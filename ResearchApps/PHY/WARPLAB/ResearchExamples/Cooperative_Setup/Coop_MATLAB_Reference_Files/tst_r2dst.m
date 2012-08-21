function [output, sat_flag, config] = tst_r2dst(input,config)

MGC_AGC_Select = 1;

sat_flag = [];

M_T = config.M_T;
M = config.M;                    % Size of signal constellation
k = log2(M);              % Number of bits per symbol
nsamp = config.nsamp;                % Oversampling rate or Number of samples per symbol
h_mod = config.h_mod;
h_demod = config.h_mod;

emulator_select = config.emulator_select; %0 if no emulator is used

%Load some global definitions (packet types, etc.)
warplab_defines
TX_gain = config.TX_gain;
BB_gain = 3;
TxDelay = 0;                  % Number of noise samples per Rx capture. In [0:2^14]
% TxLength = 2^14-300;            % Length of transmission. In [0:2^14-1-TxDelay]
TxLength = 2^14-1;            % Length of transmission. In [0:2^14-1-TxDelay]

CarrierChannel = config.CarrierChannel; % Channel in the 2.4 GHz band. In [1:14]



% Define basic parameters

% Define parameters related to the pulse shaping filter and create the
% pulse shaping filter(SRRC) filter
filtorder = config.filtorder;               % Filter order
delay = config.delay;  % Group delay (# of input samples).
rolloff = config.rolloff;                % Rolloff factor of filter
rrcfilter = config.rrcfilter;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Prepare header
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% 1.1. Generate short training symbols
shortSymbol_freq = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1-i 0 0 0 0 0 0 0 1-i 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0].';
% Take IFFT of preamble and create short symbols as per 802.11 standard
shortSymbol_time = ifft(fftshift(shortSymbol_freq));
shortSymbol_time = shortSymbol_time(1:16).';
shortsyms_10 = repmat(shortSymbol_time,1,10);
preamble_I = real(shortsyms_10);
preamble_Q = imag(shortsyms_10);

% Upsample by 2 so the standard preamble occupies a bandwith of +-10MHz (if
% the freq content of the preamble is as in the 802.11 standard)
[preamble_I_up2] = interp(preamble_I, 2);%(2.85/(10*0.0313))*interp(preamble_I, 2);
[preamble_Q_up2] = interp(preamble_Q, 2);%(2.85/(10*0.0313))*interp(preamble_Q, 2);

% Scale to span -1,1 range of DAC
scale_ShortSyms = max([ max(abs(preamble_I_up2)), max(abs(preamble_Q_up2)) ]);
[preamble_I_up2] = (1/scale_ShortSyms)*preamble_I_up2;
[preamble_Q_up2] = (1/scale_ShortSyms)*preamble_Q_up2;

% Added division by sqrt(2) for unit power Tx: (normalized by sqrt(Num_Tx))
ShortTrainingSyms_up2 = (preamble_I_up2 + sqrt(-1)*preamble_Q_up2);
ShortTrainingSyms_up2_norm = ShortTrainingSyms_up2/sqrt(M_T);

% % 1.2. Generate preamble
% %preamble = [0;0;0;0;0;0;0;0;1;1;1;1;1;-1;-1;1;1;-1;1;-1;1;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0]*1.25;
% preamble = [mseq(2, 7);0;zeros(4,1)];
% % Create a reference matrix used for detection of the preamble in the
% % received signal. We will correlate the received signal with the reference
% % matrix
% preamble_upsamp     = upsample(preamble,nsamp);           % Upsample preamble
% corr_window = length(preamble)*nsamp+100;  % We expect to find the preamble within the first
% reference_samples = zeros(corr_window,1);                 % Create reference vector.
% reference_samples(1:length(preamble_upsamp)) = conj(preamble_upsamp);
%
% reference_samples_tmp = reference_samples;
% reference_matrix (:,1) = reference_samples_tmp;
% for col_counter = 2:corr_window
%     reference_samples_tmp = [0; reference_samples_tmp(1:end-1)];
%     reference_matrix (:,col_counter) = reference_samples_tmp;
% end
[LongTrainingSyms_up2,LongSymbol_time_up2,LongSymbol_time,LongSymbol_freq,scale_LongTrainingSyms] = warplab_generateLongTrainSyms;
% Added division by sqrt(2) for unit power Tx: (normalized by sqrt(Num_Tx))
[LongTrainingSyms_up2_norm] = [LongTrainingSyms_up2];
[LongTrainingSyms_up2_norm] = [LongTrainingSyms_up2]/sqrt(M_T);
[LongSymbol_time_up2_norm] = [LongSymbol_time_up2]/sqrt(M_T);
[LongSymbol_time_norm] = [LongSymbol_time]/sqrt(M_T);
[LongSymbol_freq_norm] = [LongSymbol_freq]/sqrt(M_T);


% 1.3. Generate pilot tones, space time coded
pilot_tone = [1;-1;1;-1;1;-1;1;-1]*exp(j*pi/2);            % Created to be semi-orthogonal to preamble;
% pilot_tone = [pilot_tone; pilot_tone; pilot_tone; pilot_tone; pilot_tone; pilot_tone; pilot_tone; pilot_tone];
pilot_tone = [pilot_tone; pilot_tone];
training.tx1 = [pilot_tone; -conj(pilot_tone)];             % Spacetime training pilots to estimate
training.tx2 = [pilot_tone; conj(pilot_tone)];              % the channel


nsym = floor(TxLength/nsamp-2*delay);                     % Number or symbols to transmit
%nsym = floor(TxLength/nsamp);                     % Number or symbols to transmit
% nsym_preamble = length(preamble);                           % Number of preamble symbols
nsym_preamble = length(LongTrainingSyms_up2_norm)/nsamp;                           % Number of preamble symbols


nsym_pilot = length(pilot_tone);                            % Number of training symbols
nsym_header = 2*nsym_pilot+nsym_preamble+length(ShortTrainingSyms_up2_norm)/nsamp; % Number of symbols in header
nsym_payload = nsym-nsym_header - 32;                            % Number of payload bits
nbits = floor(nsym_payload*k);                              % Number of bits to process


n_pack_err_max = 10000;
n_err_max = 1000;


if emulator_select == 0
    agc_trigger_nsamp_delay = 60;
    %     agc_trigger_nsamp_delay = 1;
else
    agc_trigger_nsamp_delay = 100;
    %     agc_trigger_nsamp_delay = 41;
end

DCOffset_FPGA_Enabled = 0;

sat_counter = 0;

power_interval = 1;
% for power_counter = 1:length(power_interval)

num_errs_total.ZF = 0;
num_errs_total.SD = 0;
num_bits_total = 0;

%     for packet_cntr = 1:1e7

% Create Socket handles and intialize nodes
socketHandles = config.socketHandles;
packetNum = config.packetNum;

% Separate the socket handles for easier access
udp_Sync = socketHandles(1);    %magic SYNC
udp_node1 = socketHandles(3);   %transmitter
udp_node2 = socketHandles(2);   %receiver

udp_node3 = socketHandles(4);   %dummy rx

% continuous transmission:
TxMode = 0; %1 for continuous transmission
warplab_writeRegister(udp_node1,TX_MODE,TxMode);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0. Initializaton and definition of parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% Set transmitter and receiver gains

% Node 1 can transmit and receive on both antenna, 2x2 setup
Node1_Radio2_TxGain_BB = BB_gain;  % Tx Baseband Gain. In [0:3]
Node1_Radio2_TxGain_RF = TX_gain;  % Tx RF Gain. In [0:63]
Node1_Radio3_TxGain_BB = BB_gain;  % Tx Baseband Gain. In [0:3]
Node1_Radio3_TxGain_RF = TX_gain;  % Tx RF Gain. In [0:63]

Node1_Radio2_RxGain_BB = 15; % Rx Baseband Gain. In [0:31]
Node1_Radio2_RxGain_RF = 1;  % Rx RF Gain. In [1:3]
Node1_Radio3_RxGain_BB = 15; % Rx Baseband Gain. In [0:31]
Node1_Radio3_RxGain_RF = 1;  % Rx RF Gain. In [1:3]


% Node 2 can receive on both antennas
Node2_Radio2_RxGain_BB = 15; % Rx Baseband Gain. In [0:31]
Node2_Radio2_RxGain_RF = 1; % Rx RF Gain. In [1:3]
Node2_Radio3_RxGain_BB = 15; % Rx Baseband Gain. In [0:31]
Node2_Radio3_RxGain_RF = 1; % Rx RF Gain. In [1:3]

Node2_TargetdBmAGC = -6;     % AGC's target dBm
Node2_NoiseEstdBmAGC = -95;  % AGC's Noise Estimate in dBm

% Download AGC parameters to node 2
warplab_setRadioAGCParameter(udp_node2,SET_AGC_TARGET_dBm,Node2_TargetdBmAGC);
warplab_setRadioAGCParameter(udp_node2,SET_AGC_NOISEEST_dBm,Node2_NoiseEstdBmAGC);
warplab_setRadioAGCParameter(udp_node2,SET_AGC_TRIG_DELAY,agc_trigger_nsamp_delay);
warplab_setRadioAGCParameter(udp_node2,AGC_DCO_EN,DCOffset_FPGA_Enabled);

warplab_writeRegister(udp_node2,MGC_AGC_SEL,MGC_AGC_Select);

warplab_writeRegister(udp_node1,TX_DELAY,TxDelay);          %Node1 can transmit
warplab_writeRegister(udp_node1,TX_LENGTH,TxLength);
warplab_writeRegister(udp_node1,TX_MODE,TxMode);

% The CarrierChannel parameter must be downloaded to all nodes
warplab_setRadioParameter(udp_node1,CARRIER_CHANNEL,CarrierChannel);
warplab_setRadioParameter(udp_node2,CARRIER_CHANNEL,CarrierChannel);

% Node 1 will be set as the transmitter so download Tx gains to node 1;
warplab_setRadioParameter(udp_node1,RADIO2_TXGAINS,(Node1_Radio2_TxGain_RF + Node1_Radio2_TxGain_BB*2^16));
warplab_setRadioParameter(udp_node1,RADIO3_TXGAINS,(Node1_Radio3_TxGain_RF + Node1_Radio3_TxGain_BB*2^16));

% Node 2 will be set as the receiver so download Rx gains to node 2.
warplab_setRadioParameter(udp_node2,RADIO2_RXGAINS,(Node2_Radio2_RxGain_BB + Node2_Radio2_RxGain_RF*2^16));
warplab_setRadioParameter(udp_node2,RADIO3_RXGAINS,(Node2_Radio3_RxGain_BB + Node2_Radio3_RxGain_RF*2^16));

%-------------------------------------------------------------------------%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Time Slot 1
% Step A: Generate two vectors of samples to transmit and send the samples to
%         the WARP board (Sample Frequency is 40MHz)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Generate a random bit stream and map it to symbols
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






	stream1 = randint(nbits,1);
	stream2 = randint(nbits,1);

	% Map bits in vector x into k-bit symbols
	tx1_xsym = bi2de(reshape(stream1,k,length(stream1)/k).','left-msb');
	tx2_xsym = bi2de(reshape(stream2,k,length(stream2)/k).','left-msb');

	% Modulate using DQPSK
	% tx1_mod = qammod(tx1_xsym,M, 0, 'gray');
	tx1_mod = modulate(h_mod, tx1_xsym);
	tx1_mod = tx1_mod/(sqrt(M)-1);

	% tx2_mod = qammod(tx2_xsym,M, 0, 'gray');
	tx2_mod = modulate(h_mod, tx2_xsym);
	tx2_mod = tx2_mod/(sqrt(M)-1);

    
    




% Modulate using DQPSK
% tx1_mod = qammod(tx1_xsym,M, 0, 'gray');
%            tx1_mod = modulate(h_mod, tx1_xsym);
%            tx1_mod = tx1_mod/(sqrt(M)-1);
% tx1_mod = input{1};
% tx2_mod = input{2};

% tx2_mod = qammod(tx2_xsym,M, 0, 'gray');
%             tx2_mod = modulate(h_mod, tx2_xsym);
%             tx2_mod = tx2_mod/(sqrt(M)-1);
%-------------------------------------------------------------------------%
% Interleaving pilots with the symbols
sizeSegment = floor(length(tx1_mod)/length(pilot_tone));

[ytx1_mod size_segment] = scatter_pilots(tx1_mod, training.tx1);
[ytx2_mod size_segment] = scatter_pilots(tx2_mod, training.tx2);

%         ytx1_mod = [preamble;ytx1_mod];
%         ytx2_mod = [preamble;ytx2_mod];
%        ytx2_mod = [zeros(size(preamble));ytx2_mod];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Upsample the modulated symbols with the appended preamble and filter
% using a pulse shaping filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Upsample and apply square root raised cosine filter.
ytx1_mod_filt = [ShortTrainingSyms_up2_norm.'; LongTrainingSyms_up2_norm.'; zeros(32,1); rcosflt(ytx1_mod,1,nsamp,'filter',rrcfilter)];
ytx2_mod_filt = [ShortTrainingSyms_up2_norm.'; LongTrainingSyms_up2_norm.'; zeros(32,1); rcosflt(ytx2_mod,1,nsamp,'filter',rrcfilter)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Upconvert from baseband to 5MHz to avoid radio DC attenuation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
time = [0:1:length(ytx1_mod_filt)-1]/40e6; % Sampling Freq. is 40MHz
ytx1_mod_filt_up = ytx1_mod_filt .* exp(sqrt(-1)*2*pi*5e6*time).';
ytx2_mod_filt_up = ytx2_mod_filt .* exp(sqrt(-1)*2*pi*5e6*time).';

Node1_Radio2_TxData = ytx1_mod_filt_up.';
Node1_Radio3_TxData = ytx2_mod_filt_up.';


% Download the samples to be transmitted
warplab_writeSMWO(udp_node1, RADIO2_TXDATA, Node1_Radio2_TxData); 
warplab_writeSMWO(udp_node1, RADIO3_TXDATA, Node1_Radio3_TxData); 

%-------------------------------------------------------------------------%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Time Slot 1
% Step B: Prepare WARP boards for transmission and reception and send trigger to
% start transmission and reception (trigger is the SYNC packet)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	% Enable transmitter radio path in radios 2 and 3 in node 1 (enable radio 2
	% and radio 3 in node 1 as transmitters)
	warplab_sendCmd(udp_node1, [RADIO2_TXEN, RADIO3_TXEN], packetNum);

	% Enable transmission of node1's radio 2 and radio 3 Tx buffer (enable
	% transmission of samples stored in radio 2 Tx Buffer and in radio 3 Tx
	% Buffer in node 1)
	warplab_sendCmd(udp_node1, [RADIO2TXBUFF_TXEN, RADIO3TXBUFF_TXEN], packetNum);

	% Enable receiver radio path in radios 2 and 3 in node 2 and node 3
	warplab_sendCmd(udp_node2, [RADIO2_RXEN, RADIO3_RXEN], packetNum);
	warplab_sendCmd(udp_node3, [RADIO2_RXEN, RADIO3_RXEN], packetNum);
	
	% Enable capture in node2's radio 2 and radio 3 Rx Buffer (enable radio 2
	% Rx buffer and radio 3 Rx buffer in node 2 for storage of samples)
	warplab_sendCmd(udp_node2, [RADIO2RXBUFF_RXEN, RADIO3RXBUFF_RXEN], packetNum);
	warplab_sendCmd(udp_node3, [RADIO2RXBUFF_RXEN, RADIO3RXBUFF_RXEN], packetNum);

	% Prime transmitter state machine in node 1. Node 1 will be
	% waiting for the SYNC packet. Transmission from node 1 will be triggered
	% when node 1 receives the SYNC packet.
	warplab_sendCmd(udp_node1, TX_START, packetNum);
	warplab_sendCmd(udp_node2, RX_START, packetNum);
	warplab_sendCmd(udp_node3, RX_START, packetNum);

	% Send the SYNC packet
	warplab_sendSync(udp_Sync);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Time Slot 1
% Step C:  Relay and receiver read the received samples from the Warp board (on one
%      antenna each.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Read back the received samples from radio 2, node 2 (destination)
[Node2_Radio2_RawRxData] = warplab_readSMRO(udp_node2, RADIO2_RXDATA, TxLength+TxDelay);
% Read back the received samples from radio 2, node 3 (relay)
[Node2_Radio3_RawRxData] = warplab_readSMRO(udp_node2, RADIO3_RXDATA, TxLength+TxDelay);
%-------------------------------------------------------------------------%

% Process the received samples to obtain meaningful data
[Node2_Radio2_RxData_wDCO,Node2_Radio2_RxOTR] = warplab_processRawRxData(Node2_Radio2_RawRxData);
[Node2_Radio3_RxData_wDCO,Node2_Radio3_RxOTR] = warplab_processRawRxData(Node2_Radio3_RawRxData);
% Read stored RSSI data from radio 2
% [Node2_Radio2_RawRSSIData] = warplab_readSMRO(udp_node2, RADIO2_RSSIDATA, ceil((TxLength+TxDelay)/8));
% Read stored RSSI data from radio 3
% [Node2_Radio3_RawRSSIData] = warplab_readSMRO(udp_node2, RADIO3_RSSIDATA, ceil((TxLength+TxDelay)/8));
% Procecss Raw RSSI data to obtain meningful RSSI values
% [Node2_Radio2_RSSIData] = warplab_processRawRSSIData(Node2_Radio2_RawRSSIData);
% [Node2_Radio3_RSSIData] = warplab_processRawRSSIData(Node2_Radio3_RawRSSIData);
% Note: If the four lines of code above (warplab_processRawRSSIData lines and
% warplab_readSMRO(udp_node2, RADIO2_RSSIDATA, (TxLength+TxDelay)/8) line
% and warplab_readSMRO(udp_node2, RADIO3_RSSIDATA, (TxLength+TxDelay)/8) line)
% are deleted, then the code will work when the boards are programmed
% with the warplab_mimo_4x4_v04.bit bitstream)


%         if (abs(Node2_Radio2_RxData_wDCO)
sat_flag = sum(abs(Node2_Radio2_RxData_wDCO(nsym_header*nsamp:end))>1) + sum(abs(Node2_Radio3_RxData_wDCO(nsym_header*nsamp:end))>1);
sat_counter = sat_counter + sum(abs(Node2_Radio2_RxData_wDCO(nsym_header*nsamp:end))>1) + sum(abs(Node2_Radio3_RxData_wDCO(nsym_header*nsamp:end))>1);
%         end
%         plot(abs(Node2_Radio2_RxData_wDCO))
%         hold on;plot(abs(Node2_Radio3_RxData_wDCO));hold off

% Read the address where the AGC fixes the gains
[AGC_Set_Address] = warplab_readRegister(udp_node2,AGC_DONE_ADDR);
% Read the gains that were set by the AGC
[GainsRF_Init,GainsBB_Init] = warplab_readAGCGains(udp_node2);
% Remove DC Offset (DCO) from RxData
[Node2_Radio2_RxData] = warplab_correctDCO(Node2_Radio2_RxData_wDCO,AGC_Set_Address);
[Node2_Radio3_RxData] = warplab_correctDCO(Node2_Radio3_RxData_wDCO,AGC_Set_Address);
%          [Node2_Radio2_RxData] = Node2_Radio2_RxData_wDCO;
%          [Node2_Radio3_RxData] = Node2_Radio3_RxData_wDCO;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Time Slot 1
% Step D:  Reset and disable the boards
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Set radios 2 and 3 Tx buffer in node 1 back to Tx disabled mode
warplab_sendCmd(udp_node1, [RADIO2TXBUFF_TXDIS RADIO3TXBUFF_TXDIS], packetNum);

% Disable the transmitter radios
warplab_sendCmd(udp_node1, [RADIO2_TXDIS, RADIO3_TXDIS], packetNum);

% Let the receiver know that samples have been read and system is ready for
% a new capture
warplab_sendCmd(udp_node2, RX_DONEREADING, packetNum);
warplab_sendCmd(udp_node3, RX_DONEREADING, packetNum);

% Set radios 2 and 3 Rx buffer in node 2 back to Rx disabled mode
warplab_sendCmd(udp_node2, [RADIO2RXBUFF_RXDIS, RADIO3RXBUFF_RXDIS], packetNum);
warplab_sendCmd(udp_node3, [RADIO2RXBUFF_RXDIS, RADIO3RXBUFF_RXDIS], packetNum);

% Disable the receiver radios
warplab_sendCmd(udp_node2, [RADIO2_RXDIS,RADIO3_RXDIS], packetNum);
warplab_sendCmd(udp_node3, [RADIO2_RXDIS,RADIO3_RXDIS], packetNum);

% Reset the AGC
warplab_sendCmd(udp_node2, AGC_RESET, packetNum);
warplab_sendCmd(udp_node3, AGC_RESET, packetNum);
%Close sockets
%pnet('closeall');

output{1} = Node2_Radio2_RxData;
output{2} = Node2_Radio3_RxData;
output{3} = AGC_Set_Address;




	config.size_segment = size_segment;
	config.nsym_pilot = nsym_pilot;
	config.pilot_tone = pilot_tone;   
   
	%optional should be deleted
	config.stream1 = stream1;
	config.stream2 = stream2;
	