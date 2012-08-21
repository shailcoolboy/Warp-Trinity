%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The MIMO LTE Uplink simulation based on Warplab
% Composed by: Guohui Wang, Bei Yin, Michael Wu
% Date: October 2009
% Configuration: 2x2 MIMO
%                16QAM
%                Zero forcing/MMSE equalizer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [block_out] = demo_transmit_1user_mimo(block_in)
% function descriiption: this function simulates the transmition of 
% LTE uplink, 2x2 MIMO, 16QAM modulation (configurable), ZF and MMSE
% equalizer can be selected.

num = 1;
EbNo = 10000;
sigma = 1/(10^(EbNo/10));
n_pack_err_max = floor(50/num);
n_err_max = floor(100/num);
n_pack_max = floor(100/num);

%% Simulation parameters
dft_size = 72;
idft_size = 128;
nsym_CP = 160-128;
add_delay = 1;
debugon = 1;
filteron = 0;
equalization_mode =  0;

%Common between Warplab and Simulation
M_T = 2;					% Number of TX antennas
M = 16;                    	% Size of signal constellation
k = log2(M);              	% Number of bits per symbol
nsamp = 20;                	% Oversampling rate or Number of samples per symbol, 40Mhz/20 = 2Mhz wide band
TxLength = 2^14-1;          % Length of transmission. In [0:2^14-1-TxDelay]
TX_gain = 40;
BB_gain = 3;
TxDelay = 0; 
CarrierChannel = 7; % Channel in the 2.4 GHz band. In [1:14]

agc_trigger_nsamp_delay = 100; % in the air, decrease this

%Modulation objects
h_mod = modem.qammod('M', M, 'SymbolOrder', 'Gray');
h_demod = modem.qamdemod(h_mod);

% Define parameters related to the pulse shaping filter and create the
% pulse shaping filter(SRRC) filter
filtorder = nsamp*8;               % Filter order
delay = filtorder/(nsamp*2);  % Group delay (# of input samples).
rolloff = 0.3;                % Rolloff factor of filter
rrcfilter = rcosine(1,nsamp,'fir/sqrt',rolloff,delay); % Create SRRC filter

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

% 1.2. Generate preamble
[LongTrainingSyms_up2,LongSymbol_time_up2,LongSymbol_time,LongSymbol_freq,scale_LongTrainingSyms] = warplab_generateLongTrainSyms;
preamble_upsamp = LongTrainingSyms_up2/sqrt(M_T);
% preamble_conv = LongSymbol_time_up2;
nsym_preamble = length(preamble_upsamp)/nsamp;

% 1.3. Generate pilot tones
%pilot_tone_freq = ones(1,idft_size).*exp(sqrt(-1)*rand(1,idft_size)*pi*2); %random phase
r = 5;
L = 128;
q = 5;
pilot_tone_freq = exp(-sqrt(-1)*2*pi*r/L*((0:1:L-1).^2/2+(0:1:L-1)*q));

pilot_tone = ifft(pilot_tone_freq);
pilot_CP = pilot_tone(end-nsym_CP+1:end);
pilot_tone = [pilot_CP pilot_tone];

training.tx1 = pilot_tone;
training.tx2 = pilot_tone;
nsym_per_pilot = length(training.tx1);

% 1.4. Calculate the packet parameters
sym_guard = 4;
nsym = floor(TxLength/nsamp-delay*2);                     			  % Number or symbols to transmit
nsym_header  = nsym_preamble+M_T*(nsym_per_pilot)+sym_guard;  		  % Number of symbols in header, 2 frame for channel estimation,
nsym_payload = floor(nsym-nsym_header);		 						  % Number of payload bits
nframe = floor(nsym_payload/(idft_size+nsym_CP));					  % Number of SCFDMA frames per packet

%% Start the simulation
num_errs_total.ZF = 0;
num_errs_total.SD = 0;
num_bits_total = 0;

% for packet_cntr = 1:1e7
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Transmitting and Receiving Data using WARPLab (Virtual MIMO Downlink)
% 2x2 Transmitter, 2x2 Receiver
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0. Initializaton and definition of parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
warplab_defines;
% Create Socket handles and intialize nodes
[socketHandles, packetNum] = warplab_initialize;

% Separate the socket handles for easier access
udp_Sync = socketHandles(1);    %magic SYNC
udp_node1 = socketHandles(2);   %transmitter
udp_node2 = socketHandles(3);   %receiver
% continuous transmission:
TxMode = 0; %1 for continuous transmission
warplab_writeRegister(udp_node1,TX_MODE,TxMode);

% Set transmitter and receiver gains
% Node 1 can transmit and receive on both antenna, 2x2 setup
Node1_Radio2_TxGain_BB = BB_gain;  % Tx Baseband Gain. In [0:3]
Node1_Radio2_TxGain_RF = TX_gain;  % Tx RF Gain. In [0:63]
Node1_Radio3_TxGain_BB = BB_gain;  % Tx Baseband Gain. In [0:3]
Node1_Radio3_TxGain_RF = TX_gain;  % Tx RF Gain. In [0:63]

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
DCOffset_FPGA_Enabled = 0;
warplab_setRadioAGCParameter(udp_node2,AGC_DCO_EN,DCOffset_FPGA_Enabled);

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
% Create a random binary data stream as a column vector.
% assign input block to two streams which are transmitted by two anttennas.
block_size = length(block_in);
block_in = block_in';
stream1 = block_in(1:block_size/2);
stream2 = block_in(block_size/2+1:end);

% Map bits in vector x into k-bit symbols
tx1_xsym = bi2de(reshape(stream1,k,length(stream1)/k).','left-msb');
tx2_xsym = bi2de(reshape(stream2,k,length(stream2)/k).','left-msb');

% Modulate using M-QAM
tx1_mod = modulate(h_mod, tx1_xsym);
tx1_mod = tx1_mod/(sqrt(M)-1);
tx2_mod = modulate(h_mod, tx2_xsym);
tx2_mod = tx2_mod/(sqrt(M)-1);

%Take the fft
tx1_mod_freq = [fft(tx1_mod(1:dft_size));fft(tx1_mod(dft_size+1:end))];
tx2_mod_freq = [fft(tx2_mod(1:dft_size));fft(tx2_mod(dft_size+1:end))];

%Pad with 0 to ifft size
padding_size = 0.5*(idft_size-dft_size);
padding = zeros(padding_size,1);

tx1_mod_freq = [padding; tx1_mod_freq(1:dft_size); padding; padding; tx1_mod_freq(dft_size+1:end); padding  ];
tx2_mod_freq = [padding; tx2_mod_freq(1:dft_size); padding; padding; tx2_mod_freq(dft_size+1:end); padding  ];

%Take the ifft;
tx1_mod_time = [ifft(tx1_mod_freq(1:idft_size));ifft(tx1_mod_freq(idft_size+1:end))];
tx2_mod_time = [ifft(tx2_mod_freq(1:idft_size));ifft(tx2_mod_freq(idft_size+1:end))];

%Add cyclic prefix
tx1_mod_time = [tx1_mod_time(idft_size-nsym_CP+1:idft_size); tx1_mod_time(1:idft_size);tx1_mod_time(end-nsym_CP+1:end); tx1_mod_time(idft_size+1:end)];
tx2_mod_time = [tx2_mod_time(idft_size-nsym_CP+1:idft_size); tx2_mod_time(1:idft_size);tx2_mod_time(end-nsym_CP+1:end); tx2_mod_time(idft_size+1:end)];
tic

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Upsample the modulated symbols with the appended preamble and filter
% using a pulse shaping filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ytx1_mod = [training.tx1.'; zeros(length(training.tx1),1); tx1_mod_time ];
ytx2_mod = [zeros(length(training.tx2),1); training.tx2.'; tx2_mod_time ];

ytx1_mod_filt = [ShortTrainingSyms_up2_norm.';preamble_upsamp.'; zeros(1,sym_guard*nsamp).'; rcosflt(ytx1_mod,1,nsamp,'filter',rrcfilter)];
ytx2_mod_filt = [ShortTrainingSyms_up2_norm.';preamble_upsamp.'; zeros(1,sym_guard*nsamp).'; rcosflt(ytx2_mod,1,nsamp,'filter',rrcfilter)];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Upconvert from baseband to 5MHz to avoid radio DC attenuation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
time = [0:1:length(ytx1_mod_filt)-1]/40e6; % Sampling Freq. is 40MHz
ytx1_mod_filt_up = ytx1_mod_filt .* exp(sqrt(-1)*2*pi*5e6*time).';
ytx2_mod_filt_up = ytx2_mod_filt .* exp(sqrt(-1)*2*pi*5e6*time).';

Node1_Radio2_TxData = ytx1_mod_filt_up.';
Node1_Radio3_TxData = ytx2_mod_filt_up.';

% Download the samples to be transmitted
warplab_writeSMWO(udp_node1, RADIO2_TXDATA, Node1_Radio2_TxData); % Download samples to
% radio 2 Tx Buffer
warplab_writeSMWO(udp_node1, RADIO3_TXDATA, Node1_Radio3_TxData); % Download samples to
% radio 3 Tx Buffer
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

% Enable receiver radio path in radios 2 and 3 in node 2 (enable radios 2
% and 3 in node 2 as receivers)
warplab_sendCmd(udp_node2, [RADIO2_RXEN, RADIO3_RXEN], packetNum);
% Enable capture in node2's radio 2 and radio 3 Rx Buffer (enable radio 2
% Rx buffer and radio 3 Rx buffer in node 2 for storage of samples)
warplab_sendCmd(udp_node2, [RADIO2RXBUFF_RXEN, RADIO3RXBUFF_RXEN], packetNum);

% Prime transmitter state machine in node 1. Node 1 will be
% waiting for the SYNC packet. Transmission from node 1 will be triggered
% when node 1 receives the SYNC packet.
warplab_sendCmd(udp_node1, TX_START, packetNum);

% Prime receiver state machine in node 2. Node 2 will be waiting
% for the SYNC packet. Capture at node 2 will be triggered when node 2
% receives the SYNC packet.
warplab_sendCmd(udp_node2, RX_START, packetNum);

% Send the SYNC packet
warplab_sendSync(udp_Sync);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Time Slot 1
% Step C:  Receiver reads the received samples from the Warp board (on one
%      antenna each.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read back the received samples from radio 2, node 2
[Node2_Radio2_RawRxData] = warplab_readSMRO(udp_node2, RADIO2_RXDATA, TxLength+TxDelay);
% Read back the received samples from radio 2, node 3
[Node2_Radio3_RawRxData] = warplab_readSMRO(udp_node2, RADIO3_RXDATA, TxLength+TxDelay);
%-------------------------------------------------------------------------%

% Process the received samples to obtain the meaningful data
[Node2_Radio2_RxData_wDCO,Node2_Radio2_RxOTR] = warplab_processRawRxData(Node2_Radio2_RawRxData);
[Node2_Radio3_RxData_wDCO,Node2_Radio3_RxOTR] = warplab_processRawRxData(Node2_Radio3_RawRxData);

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

% Set radios 2 and 3 Rx buffer in node 2 back to Rx disabled mode
warplab_sendCmd(udp_node2, [RADIO2RXBUFF_RXDIS, RADIO3RXBUFF_RXDIS], packetNum);

% Disable the receiver radios
warplab_sendCmd(udp_node2, [RADIO2_RXDIS,RADIO3_RXDIS], packetNum);

% Reset the AGC
warplab_sendCmd(udp_node2, AGC_RESET, packetNum);

%Close sockets
pnet('closeall');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 6. Downconvert from 5MHz to baseband
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
time = [0:1:length(Node2_Radio2_RxData)-1]/40e6; % Sampling Freq. is 40MHz
yrx1_bb = Node2_Radio2_RxData .* exp(-sqrt(-1)*2*pi*5e6*time);   %Downconvert to baseband
yrx2_bb = Node2_Radio3_RxData .* exp(-sqrt(-1)*2*pi*5e6*time);   %Downconvert to baseband

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 7. Filter the received signal with a Matched Filter (matched to the pulse
% shaping filter), detect preamble, and downsample output of Matched Filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Store received samples as a column vector
yrx1_bb = yrx1_bb.';
yrx2_bb = yrx2_bb.';

% Matched filter: Filter received signal using the SRRC filter
% [LongTrainingStart_2,ValidStart_2] =
% warplab_findLongTrainingStart(RxData_2,LongSymbol_time_up2,AGC_Set_Address);

% Correlate with the reference matrix to find preamble sequence
% AGC_Set_Address = 0;

AGC_Set_Address = AGC_Set_Address + 160;
% Find start of the preamble
[LongTrainingStart,ValidStart_1, Corr_1] = warplab_findLongTrainingStart(yrx1_bb,LongSymbol_time_up2,AGC_Set_Address);
preamble_start_1 = LongTrainingStart-1;

[LongTrainingStart,ValidStart_2, Corr_2] = warplab_findLongTrainingStart(yrx2_bb,LongSymbol_time_up2,AGC_Set_Address);
preamble_start_2 = LongTrainingStart-1;

if (~ValidStart_1&& ~ValidStart_2)
    'error'
else
    yrx1_bb_mf = rcosflt(yrx1_bb(preamble_start_1+nsym_preamble*nsamp+sym_guard*nsamp:end),1,nsamp,'Fs/filter',rrcfilter);
    yrx2_bb_mf = rcosflt(yrx2_bb(preamble_start_2+nsym_preamble*nsamp+sym_guard*nsamp:end),1,nsamp,'Fs/filter',rrcfilter);

    %Figure out where the first index is
    delay = filtorder/(nsamp*2);
    first_sample_index = 2;% 1+2*delay*nsamp;

    rx1 = downsample(yrx1_bb_mf(first_sample_index:end), nsamp);
    rx2 = downsample(yrx2_bb_mf(first_sample_index:end), nsamp);

    %estimate the channel
    chan.h11 = chan_est(rx1(1:length(training.tx1)),pilot_tone_freq, nsym_CP);
    chan.h21 = chan_est(rx1(length(training.tx1)+1:2*length(training.tx1)),pilot_tone_freq, nsym_CP);

    chan.h12 = chan_est(rx2(1:length(training.tx1)),pilot_tone_freq, nsym_CP);
    chan.h22 = chan_est(rx2(length(training.tx1)+1:2*length(training.tx1)),pilot_tone_freq, nsym_CP);

    if (filteron)
        L = 3; %please be even
        lowpass = [0.5 2 0.5]/L;
        chan.h11 = conv(lowpass, chan.h11);
        chan.h11 = chan.h11(ceil(L/2):end-floor(L/2));

        chan.h12 = conv(lowpass, chan.h12);
        chan.h12 = chan.h12(ceil(L/2):end-floor(L/2));

        chan.h21 = conv(lowpass, chan.h21);
        chan.h21 = chan.h21(ceil(L/2):end-floor(L/2));

        chan.h22 = conv(lowpass, chan.h22);
        chan.h22 = chan.h22(ceil(L/2):end-floor(L/2));
    end

    %Grab data frames  
	%not generalized to n frames, make the vector larger
    data.rx1 = zeros(1,idft_size*2);
    data.rx2 = zeros(1,idft_size*2);

    start_index = 2*length(training.tx1)+1;
    end_index = start_index+idft_size*2+nsym_CP*2-1;

    for ii = 1:1:1		%not generalized to n frames, change index
        [start_index end_index];

        temp = rx1(start_index:end_index);  									%grab data;

        data.rx1((ii-1)*idft_size+1:(ii+1)*idft_size) = [fft(temp(nsym_CP+1:nsym_CP+idft_size));fft(temp(nsym_CP*2+1+idft_size:end))];	%remove of cyclic prefix, take FFT;

        temp = rx2(start_index:end_index);										%grab data;
        data.rx2((ii-1)*idft_size+1:(ii+1)*idft_size) = [fft(temp(nsym_CP+1:nsym_CP+idft_size));fft(temp(nsym_CP*2+1+idft_size:end))];	%remove of cyclic prefix, take FFT;

        start_index = end_index+1;
        end_index = end_index+idft_size*2+nsym_CP*2;
    end

   
    % grab actual symbols in freq:
    final.rx1 = [data.rx1(padding_size+1:padding_size+dft_size),data.rx1(idft_size+padding_size+1:idft_size+padding_size+dft_size)];
    final.rx2 = [data.rx2(padding_size+1:padding_size+dft_size),data.rx2(idft_size+padding_size+1:idft_size+padding_size+dft_size)];

    final.h11 = [chan.h11(padding_size+1:padding_size+dft_size);chan.h11(padding_size+1:padding_size+dft_size)];
    final.h21 = [chan.h21(padding_size+1:padding_size+dft_size);chan.h21(padding_size+1:padding_size+dft_size)];
    final.h12 = [chan.h12(padding_size+1:padding_size+dft_size);chan.h12(padding_size+1:padding_size+dft_size)];
    final.h22 = [chan.h22(padding_size+1:padding_size+dft_size);chan.h22(padding_size+1:padding_size+dft_size)];
    
    if (equalization_mode == 0)    % Zero Forcing
        %%%% Zero forcing equalizer;
        %equalize symbol by symbol
        x = [];
        for ii = 1:length(final.rx1)
            h = [final.h11(ii) final.h21(ii);
                final.h12(ii) final.h22(ii)];
            y = [final.rx1(ii); final.rx2(ii)];
            x = [x inv(h)*y];
        end
    else
        %%%% MMSE equalizer
        SP.NDFT_sub = dft_size*2;
        RxSymbolsMimo_fd = [final.rx1;final.rx2];
        for ii = 1:length(final.rx1)
            H_fd(:,:,ii) = [final.h11(ii),final.h21(ii);final.h12(ii),final.h22(ii)];
        end
        sigma_n = sigma;
        mmse;
        x=RxSymbolsMimo_eq_fd;
    end

    xsym1 = [ifft(x(1,1:dft_size)),ifft(x(1,1+dft_size:end))]*(sqrt(M)-1);
    xsym2 = [ifft(x(2,1:dft_size)),ifft(x(2,1+dft_size:end))]*(sqrt(M)-1);

    %% Demodulate and calculate error
    z1 = demodulate(h_demod, xsym1(1,:));
    z2 = demodulate(h_demod, xsym2(1,:));

    z1_ZF = de2bi(	z1,'left-msb',4); % Convert integers to bits.
    z1_ZF = reshape(z1_ZF.',prod(size(z1_ZF)),1);

    z2_ZF = de2bi(	z2,'left-msb',4); % Convert integers to bits.
    z2_ZF = reshape(z2_ZF.',prod(size(z2_ZF)),1);

	% display the intermidea results
%     [number_of_errors.tx1.ZF,bit_error_rate.tx1.ZF] = biterr(stream1,z1_ZF);
%     [number_of_errors.tx2.ZF,bit_error_rate.tx2.ZF] = biterr(stream2,z2_ZF);
%     disp('ber tx1 | tx2');
%     disp([bit_error_rate.tx1.ZF bit_error_rate.tx2.ZF]);
%     disp('err number tx1 | tx2');
%     disp([number_of_errors.tx1.ZF,number_of_errors.tx2.ZF]);
end

% t=toc;
block_out = [z1_ZF' z2_ZF'];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% !!! Plot the transmitted and received data!!!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure;
% subplot(4,1,1); plot(real(Node1_Radio2_TxData));
% subplot(4,1,2); plot(real(Node2_Radio2_RxData));
