% Test 802.11 spectrum with WARPLAB continuous transmission
% xyzhang
clear all;

USESIM = 1; % whether to use simulation

M_t = 4; % number of tx antennas
M_r = 4; % number of rx antennas
osamp = 8; % Oversampling rate or Number of samples per symbol, 40Mhz/osamp wide band
if USESIM osamp = 1; end
TX_gain = 40;  % Tx RF Gain. In [0:63] 
BB_gain = 3; % Tx Baseband Gain. In [0:3]
Rx_BB_Gain = 5;% Rx Baseband Gain. In [0:31]
Rx_RF_Gain = 1; % Rx RF Gain. In [1:3] 

TxDelay = 1000;
TxLength = 2^14-TxDelay; % Length of transmission. In [0:2^14-1-TxDelay]
CarrierChannel = 14; % Channel in the 2.4 GHz band. In [1:14]; 5GHz in [15:37]
pktsize_bytes = 10; 
numRxCapture = 15;

% -------- Generate 802.11 STF ---------
STF = [0 0 0 0 0 0 0 0 1+i 0 0 0 -1+i 0 0 0 -1-i 0 0 0 1-i 0 0 0 -1-i 0 0 0 1-i 0 0 0 0 0 0 0 1-i 0 0 0 -1-i 0 0 0 1-i 0 0 0 -1-i 0 0 0 -1+i 0 0 0 1+i 0 0 0 0 0 0 0].';
STF_t = ifft(fftshift(STF));
STF_t = STF_t(1:16).';
STF_10 = repmat(STF_t,1,10);
STF_I = real(STF_10);
STF_Q = imag(STF_10);
% Upsample by osamp so the standard preamble occupies a bandwidth of 
% +-40/osamp MHz (computed for a sampling frequency of 40 MHz)
[STF_I_up2] = interp(STF_I, osamp);
[STF_Q_up2] = interp(STF_Q, osamp);
% Scale to span -1,1 range of DAC
scale_ShortSyms = max([ max(abs(STF_I_up2)), max(abs(STF_Q_up2)) ]);
[STF_I_up2] = (1/scale_ShortSyms)*STF_I_up2;
[STF_Q_up2] = (1/scale_ShortSyms)*STF_Q_up2;
STF_up2 = (STF_I_up2 + sqrt(-1)*STF_Q_up2);


% -------- Generate 802.11 LTF -----------
LTF_freq_bot = [0 0 0 0 0 0 1 1 -1 -1 1 1 -1 1 -1 1 1 1 1 1 1 -1 -1 1 1 -1 1 -1 1 1 1 1]';
LTF_freq_top = [1 -1 -1 1 1 -1 1 -1 1 -1 -1 -1 -1 -1 1 1 -1 -1 1 -1 1 -1 1 1 1 1 0 0 0 0 0]';
LTF_freq = [LTF_freq_bot ; 0 ; LTF_freq_top];
LTF_time = ifft(fftshift(LTF_freq)).';
LTF_time_up2 = interp(LTF_time, osamp); % Upsample 
scale = 1/max([ max(abs(real(LTF_time_up2))), max(abs(imag(LTF_time_up2))) ]);
LTF_time_up2 = scale * LTF_time_up2; % Scale to span -1,1 range of DAC 
% Concatenate two long training symbols and add cyclic prefix
%longsyms_2_cp = [LTF_time(33:64) repmat(LTF_time,1,2)];
%longsyms_2_cp_up2 = interp(longsyms_2_cp,2); % Upsample by 2
LTF_up2 = [LTF_time_up2(32*osamp+1:64*osamp) repmat(LTF_time_up2,1,2)];


% -------- Generate OFDM data symbol -----------
% ******* Add pilot tone ********
% Generate data bits to be transmitted
numbits = pktsize_bytes*8;
fg = fopen('inbits.dat', 'wb');
bt = [0 1 0 1 0 0 1 1];
bto = [];
for s = 1:pktsize_bytes
    bto = [bto bt];
end
fwrite(fg, bto, 'int8');
fclose(fg);

fin = fopen('inbits.dat', 'rb');
inb = fread(fin, pktsize_bytes*8, 'int8');
len = length(inb); 
s = 1;
posInSymb = 0;
posOut = 0;
while s <= len
    posOut = posOut + 1;
    
    posInSymb = posInSymb + 1;
    if (posInSymb == 65)
        posInSymb = 1;
    end
     
    % Insert pilot at 7, 21, 43 and 57th subcarriers
    if (posInSymb == (7+1) || posInSymb == (21+1) ...
        || posInSymb == (64-21+1) || posInSymb == (64-7+1))
        pilotOut(posOut) = 1 + 0*i;
        continue;
    end 
    if (posInSymb==1 || (posInSymb > 27 && posInSymb < 64-26+1))
        pilotOut(posOut) = 0 + 0*i;
        continue;
    end 
    
    pilotOut(posOut) = inb(s) + 0*i;
    s = s + 1; 
    %{
    % Test: make the first symbol all 1
    if posOut < 65
        pilotOut(posOut) = 1 + 0*i;
    end
    %}
end

% *** IFFT: generate time domain data signal 
DATAamplitudeScaler = 1;%sqrt(1/52); %sqrt(1/52);% FIXME
l1 = length(pilotOut)-64;
outCount = 0;
for ds = 1:64:l1
    ifftOut = ifft(pilotOut(ds:ds+63), 64);

    % *** Add guard interval 
    for s = 0:(80-1)
        ind = mod(s+64-16, 64) + 1;
        outCount = outCount + 1;
        output_t(outCount) = DATAamplitudeScaler * ifftOut(ind);   
    end 

    % ******* Pulse shaping 
    % Smooth transition between LTF and LSIG
    % FIXME
    %kkk=1;
end  % end for ds = 1:64:l1

DATA_up2 = zeros(1,800);
%DATA_up2 = interp(output_t, osamp); % Upsample 

% ------- Concatenate all tx samples ---------
zero_vector = zeros(1, length(LTF_up2));
zero_data = zeros(1, length(DATA_up2));

Node1_Radio1_TxData = [STF_up2, LTF_up2, zero_vector, zero_vector, zero_vector, DATA_up2];
%Node1_Radio1_TxData = [STF_up2, LTF_up2, zero_vector, zero_vector, zero_vector, zero_data];%DATA_up2];
Node1_Radio1_TxData = repmat(Node1_Radio1_TxData,1,1);%,3); % make 5 packets
Node1_Radio1_TxData = [Node1_Radio1_TxData zeros(1,max(1,TxLength-length(Node1_Radio1_TxData)))];  

Node1_Radio2_TxData = [STF_up2, zero_vector, LTF_up2, zero_vector, zero_vector, zero_data];
Node1_Radio2_TxData = repmat(Node1_Radio2_TxData,1,1); % make 5 packets
Node1_Radio2_TxData = [Node1_Radio2_TxData zeros(1,max(1,TxLength-length(Node1_Radio2_TxData)))];

Node1_Radio3_TxData = [STF_up2, zero_vector, zero_vector, LTF_up2, zero_vector, zero_data]; 
Node1_Radio3_TxData = repmat(Node1_Radio3_TxData,1,1); % make 5 packets
Node1_Radio3_TxData = [Node1_Radio3_TxData zeros(1,max(1,TxLength-length(Node1_Radio3_TxData)))];

Node1_Radio4_TxData = [STF_up2, zero_vector, zero_vector, zero_vector, LTF_up2, zero_data]; 
Node1_Radio4_TxData = repmat(Node1_Radio4_TxData,1,1); % make 5 packets
Node1_Radio4_TxData = [Node1_Radio4_TxData zeros(1,max(1,TxLength-length(Node1_Radio4_TxData)))];

%test SISO transmission
Node1_Radio1_TxData = [LTF_up2];
Node1_Radio1_TxData = repmat(Node1_Radio1_TxData,1,12);%,3); % make 5 packets
Node1_Radio1_TxData = [Node1_Radio1_TxData zeros(1,max(1,TxLength-length(Node1_Radio1_TxData)))];  
Node1_Radio2_TxData = Node1_Radio1_TxData; %zeros(1, length(Node1_Radio1_TxData));
Node1_Radio1_TxData = zeros(1, length(Node1_Radio1_TxData));
Node1_Radio3_TxData = zeros(1, length(Node1_Radio1_TxData));
Node1_Radio4_TxData = zeros(1, length(Node1_Radio1_TxData));


if USESIM == 1
    fname = 'sim_modulated.dat';
    fo = fopen(fname, 'wb');
    %fwrite(fo, [real(output_t); imag(output_t)], 'float32');
    fwrite(fo, [real(Node1_Radio2_TxData); ...
            imag(Node1_Radio2_TxData)], 'float32'); 
    fclose(fo);

    %decode_MUMIMO(Node1_Radio2_TxData.');
else
% ========== Initializaton of WARP radio parameters ======== 
%Load some global definitions (packet types, etc.)
warplab_defines

% Create Socket handles and intialize nodes
[socketHandles, packetNum] = warplab_initialize;

% Separate the socket handles for easier access
% The first socket handle is always the magic SYNC
% The rest of the handles are the handles to the WARP nodes
udp_Sync = socketHandles(1);
udp_node1 = socketHandles(2);
udp_node2 = socketHandles(3);

% continuous transmission:
TxMode = 1; %1 for continuous transmission
warplab_writeRegister(udp_node1,TX_MODE,TxMode);

% Set transmitter and receiver gains
% Node 1 can transmit and receive on both antenna, 2x2 setup
Node1_Radio1_TxGain_BB = BB_gain;  
Node1_Radio1_TxGain_RF = TX_gain;  
Node1_Radio2_TxGain_BB = BB_gain;  % Tx Baseband Gain. In [0:3]
Node1_Radio2_TxGain_RF = TX_gain;  % Tx RF Gain. In [0:63]
Node1_Radio3_TxGain_BB = BB_gain;  % Tx Baseband Gain. In [0:3]
Node1_Radio3_TxGain_RF = TX_gain;  % Tx RF Gain. In [0:63]
Node1_Radio4_TxGain_BB = BB_gain;  % Tx Baseband Gain. In [0:3]
Node1_Radio4_TxGain_RF = TX_gain;  % Tx RF Gain. In [0:63]

% Node 2 can receive on both antennas
Node2_Radio1_RxGain_BB = Rx_BB_Gain; 
Node2_Radio1_RxGain_RF = Rx_RF_Gain;
Node2_Radio2_RxGain_BB = Rx_BB_Gain; 
Node2_Radio2_RxGain_RF = Rx_RF_Gain; 
Node2_Radio3_RxGain_BB = Rx_BB_Gain; 
Node2_Radio3_RxGain_RF = Rx_RF_Gain; 
Node2_Radio4_RxGain_BB = Rx_BB_Gain;  
Node2_Radio4_RxGain_RF = Rx_RF_Gain; 


Node2_MGC_AGC_Select = 0;   % Set MGC_AGC_Select=1 to enable Automatic Gain Control (AGC). 
                            % Set MGC_AGC_Select=0 to enable Manual Gain Control (MGC).
                            % By default, the nodes are set to MGC.  

%Node2_TargetdBmAGC = -6;     % AGC's target dBm
%Node2_NoiseEstdBmAGC = -95;  % AGC's Noise Estimate in dBm
%% Download AGC parameters to node 2
%warplab_setRadioAGCParameter(udp_node2,SET_AGC_TARGET_dBm,Node2_TargetdBmAGC);
%warplab_setRadioAGCParameter(udp_node2,SET_AGC_NOISEEST_dBm,Node2_NoiseEstdBmAGC);
%warplab_setRadioAGCParameter(udp_node2,SET_AGC_TRIG_DELAY,agc_trigger_nsamp_delay);
%DCOffset_FPGA_Enabled = 0;
%warplab_setRadioAGCParameter(udp_node2,AGC_DCO_EN,DCOffset_FPGA_Enabled);

warplab_writeRegister(udp_node1,TX_DELAY,TxDelay); %Node1 can transmit
warplab_writeRegister(udp_node1,TX_LENGTH,TxLength);
warplab_writeRegister(udp_node1,TX_MODE,TxMode);

% The CarrierChannel parameter must be downloaded to all nodes
warplab_setRadioParameter(udp_node1,CARRIER_CHANNEL,CarrierChannel);
warplab_setRadioParameter(udp_node2,CARRIER_CHANNEL,CarrierChannel);

% Node 1 will be set as the transmitter so download Tx gains to node 1;
warplab_setRadioParameter(udp_node1,RADIO1_TXGAINS,(Node1_Radio1_TxGain_RF + Node1_Radio1_TxGain_BB*2^16));
warplab_setRadioParameter(udp_node1,RADIO2_TXGAINS,(Node1_Radio2_TxGain_RF + Node1_Radio2_TxGain_BB*2^16));
warplab_setRadioParameter(udp_node1,RADIO3_TXGAINS,(Node1_Radio3_TxGain_RF + Node1_Radio3_TxGain_BB*2^16));
warplab_setRadioParameter(udp_node1,RADIO4_TXGAINS,(Node1_Radio4_TxGain_RF + Node1_Radio4_TxGain_BB*2^16));

% Node 2 will be set as the receiver so download Rx gains to node 2.
warplab_setRadioParameter(udp_node2,RADIO1_RXGAINS,(Node2_Radio1_RxGain_BB + Node2_Radio1_RxGain_RF*2^16));
warplab_setRadioParameter(udp_node2,RADIO2_RXGAINS,(Node2_Radio2_RxGain_BB + Node2_Radio2_RxGain_RF*2^16));
warplab_setRadioParameter(udp_node2,RADIO3_RXGAINS,(Node2_Radio3_RxGain_BB + Node2_Radio3_RxGain_RF*2^16));
warplab_setRadioParameter(udp_node2,RADIO4_RXGAINS,(Node2_Radio4_RxGain_BB + Node2_Radio4_RxGain_RF*2^16));

warplab_setAGCParameter(udp_node2,MGC_AGC_SEL, Node2_MGC_AGC_Select);


% ------- Download the samples to be transmitted -------
warplab_writeSMWO(udp_node1, RADIO1_TXDATA, Node1_Radio1_TxData);
warplab_writeSMWO(udp_node1, RADIO2_TXDATA, Node1_Radio2_TxData);
warplab_writeSMWO(udp_node1, RADIO3_TXDATA, Node1_Radio3_TxData);
warplab_writeSMWO(udp_node1, RADIO4_TXDATA, Node1_Radio4_TxData);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Prepare WARP boards for transmission and reception and send trigger to
% start transmission and reception (trigger is the SYNC packet)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Enable transmitter radio path in radios 2 and 3 in node 1 (enable radio 2
% and radio 3 in node 1 as transmitters)
warplab_sendCmd(udp_node1, [RADIO2_TXEN], packetNum);
%warplab_sendCmd(udp_node1, [RADIO1_TXEN,RADIO2_TXEN,RADIO3_TXEN,RADIO4_TXEN], packetNum);

% Enable transmission of node1's radio 2 and radio 3 Tx buffer (enable
% transmission of samples stored in radio 2 Tx Buffer and in radio 3 Tx
% Buffer in node 1)
warplab_sendCmd(udp_node1, [RADIO2TXBUFF_TXEN], packetNum);
%warplab_sendCmd(udp_node1, [RADIO1TXBUFF_TXEN,RADIO2TXBUFF_TXEN,RADIO3TXBUFF_TXEN,RADIO4TXBUFF_TXEN], packetNum);



%% ===============================================
oRadio1_RxData = [];
oRadio2_RxData = [];
oRadio3_RxData = [];
oRadio4_RxData = [];

%for c = 1:numRxCapture % receive for numRxCapture times

% Prime transmitter state machine in node 1. Node 1 will be
% waiting for the SYNC packet. Transmission from node 1 will be triggered
% when node 1 receives the SYNC packet.
warplab_sendCmd(udp_node1, TX_START, packetNum);

fprintf(1, 'Start tx ...\n');
% Enable receiver radio path in radios 2 and 3 in node 2 (enable radios 2
% and 3 in node 2 as receivers)
warplab_sendCmd(udp_node2, [RADIO1_RXEN,RADIO2_RXEN,RADIO3_RXEN,RADIO4_RXEN], packetNum);
% Enable capture in node2's radio 2 and radio 3 Rx Buffer (enable radio 2
% Rx buffer and radio 3 Rx buffer in node 2 for storage of samples)
warplab_sendCmd(udp_node2, [RADIO1RXBUFF_RXEN,RADIO2RXBUFF_RXEN,RADIO3RXBUFF_RXEN,RADIO4RXBUFF_RXEN], packetNum);

% Prime receiver state machine in node 2. Node 2 will be waiting
% for the SYNC packet. Capture at node 2 will be triggered when node 2
% receives the SYNC packet.
warplab_sendCmd(udp_node2, RX_START, packetNum);

% Send the SYNC packet
warplab_sendSync(udp_Sync);

% Leave continuous transmitter on for nsec seconds
%nsec = 1;
%pause(nsec);

% Stop transmission
%warplab_sendCmd(udp_node1, TX_STOP, packetNum); % Resets the output and read 
% address of the transmitter buffer without disabling the transmitter radio. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Receiver reads the received samples from the Warp board (on one
% antenna each.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read back the received samples from node 2
%[Node2_Radio1_RawRxData] = warplab_readSMRO(udp_node2, RADIO1_RXDATA, TxLength+TxDelay);
%[Node2_Radio2_RawRxData] = warplab_readSMRO(udp_node2, RADIO2_RXDATA, TxLength+TxDelay);
%[Node2_Radio3_RawRxData] = warplab_readSMRO(udp_node2, RADIO3_RXDATA, TxLength+TxDelay);
%[Node2_Radio4_RawRxData] = warplab_readSMRO(udp_node2, RADIO4_RXDATA, TxLength+TxDelay);

%----------------------------------------------------------------------%
% ===== AGC based processing =====
% Process the received samples to obtain the meaningful data
%[Node2_Radio2_RxData_wDCO,Node2_Radio2_RxOTR] = warplab_processRawRxData(Node2_Radio2_RawRxData);
%[Node2_Radio3_RxData_wDCO,Node2_Radio3_RxOTR] = warplab_processRawRxData(Node2_Radio3_RawRxData);

% Read the address where the AGC fixes the gains
%[AGC_Set_Address] = warplab_readRegister(udp_node2,AGC_DONE_ADDR);
% Read the gains that were set by the AGC
% xyz TODO: disable AGC
%[GainsRF_Init,GainsBB_Init] = warplab_readAGCGains(udp_node2);
% Remove DC Offset (DCO) from RxData
%[Node2_Radio2_RxData] = warplab_correctDCO(Node2_Radio2_RxData_wDCO,AGC_Set_Address);
%[Node2_Radio3_RxData] = warplab_correctDCO(Node2_Radio3_RxData_wDCO,AGC_Set_Address);
%          [Node2_Radio2_RxData] = Node2_Radio2_RxData_wDCO;
%          [Node2_Radio3_RxData] = Node2_Radio3_RxData_wDCO;
% ==== MGC based processing ====
% Process the received samples to obtain meaningful data
%[Node2_Radio1_RxData,Node2_Radio1_RxOTR] = warplab_processRawRxData(Node2_Radio1_RawRxData);
%[Node2_Radio2_RxData,Node2_Radio2_RxOTR] = warplab_processRawRxData(Node2_Radio2_RawRxData);
%[Node2_Radio3_RxData,Node2_Radio3_RxOTR] = warplab_processRawRxData(Node2_Radio3_RawRxData);
%[Node2_Radio4_RxData,Node2_Radio4_RxOTR] = warplab_processRawRxData(Node2_Radio4_RawRxData);
%[Node1_Radio2_to_Node2_Radio2_RxData,Node1_Radio2_to_Node2_Radio2_RxOTR] = warplab_processRawRxData(Node2_Radio2_RawRxData);

% ============ Reset and disable the rx boards ==========

% Set radios in node 1 back to Tx disabled mode 
%warplab_sendCmd(udp_node1, [RADIO1TXBUFF_TXDIS,RADIO2TXBUFF_TXDIS,RADIO3TXBUFF_TXDIS,RADIO4TXBUFF_TXDIS], packetNum);

% Disable the transmitter radios
%warplab_sendCmd(udp_node1, [RADIO1_TXDIS,RADIO2_TXDIS,RADIO3_TXDIS,RADIO4_TXDIS], packetNum);

% Let the receiver know that samples have been read and system is ready for
% a new capture
%warplab_sendCmd(udp_node2, RX_DONEREADING, packetNum);

% Set Rx buffer in node 2 back to Rx disabled mode
%warplab_sendCmd(udp_node2, [RADIO1RXBUFF_RXDIS, RADIO2RXBUFF_RXDIS, RADIO3RXBUFF_RXDIS, RADIO4RXBUFF_RXDIS], packetNum);

% Disable the receiver radios
%warplab_sendCmd(udp_node2, [RADIO1_RXDIS,RADIO2_RXDIS,RADIO3_RXDIS,RADIO4_RXDIS], packetNum); 

% Reset the AGC
%warplab_sendCmd(udp_node2, AGC_RESET, packetNum);


%Close sockets
%pnet('closeall'); -- put to the end


% ============ OFDM detection, channel estimaiton and decoding ============
%Rx1_RxData = Node2_Radio1_RxData(TxDelay+1:end);
%Rx2_RxData = Node2_Radio2_RxData(TxDelay+1:end);
%Rx3_RxData = Node2_Radio3_RxData(TxDelay+1:end);
%Rx4_RxData = Node2_Radio4_RxData(TxDelay+1:end);

% ------ downsample incoming signals ------
%Node2_Radio1_RxData = downsample(Rx1_RxData, osamp);
%Node2_Radio2_RxData = downsample(Rx2_RxData, osamp);
%Node2_Radio3_RxData = downsample(Rx3_RxData, osamp);
%Node2_Radio4_RxData = downsample(Rx4_RxData, osamp);

%decode_MUMIMO([Node2_Radio2_RxData Node2_Radio3_RxData]);
%decode_MUMIMO(Node2_Radio2_RxData]);
%fout = fopen('insamples.dat', 'wb');
%fwrite(fout, [real(Node2_Radio2_RxData); ...
%            imag(Node2_Radio2_RxData)], 'float32'); 

%{
fwrite(fout, [real(Node2_Radio2_RxData); ...
            imag(Node2_Radio2_RxData); ...
            real(Node2_Radio3_RxData); ...
            imag(Node2_Radio3_RxData)], ...
            'float32'); 
%}

%{
fwrite(fout, [real(Node2_Radio1_RxData); imag(Node2_Radio1_RxData); ...
            real(Node2_Radio2_RxData); imag(Node2_Radio2_RxData); ...
            real(Node2_Radio3_RxData); imag(Node2_Radio3_RxData); ...
            real(Node2_Radio4_RxData); imag(Node2_Radio4_RxData)], ...
            'float32'); 
%}
%oRadio1_RxData = [oRadio1_RxData Node2_Radio1_RxData];
%oRadio2_RxData = [oRadio2_RxData Node2_Radio2_RxData];
%oRadio3_RxData = [oRadio3_RxData Node2_Radio3_RxData];
%oRadio4_RxData = [oRadio4_RxData Node2_Radio4_RxData];

%{
fwrite(fout, [real(Node2_Radio2_RxData); ...
            imag(Node2_Radio2_RxData)], ...
            'float32'); 
%} 
%fclose(fout);

%LTFchEst();
%chEstMultiRx();
%rxMulti();
%end % end for c = 1:numRxCapture
pause(60);

% ---- Disable transmitter ------------
% Set radio 2 Tx buffer in node 1 back to Tx disabled mode
warplab_sendCmd(udp_node1, [RADIO1TXBUFF_TXDIS,RADIO2TXBUFF_TXDIS,RADIO3TXBUFF_TXDIS,RADIO4TXBUFF_TXDIS], packetNum);

% Disable the transmitter radio
warplab_sendCmd(udp_node1, [RADIO1_TXDIS,RADIO2_TXDIS,RADIO3_TXDIS,RADIO4_TXDIS], packetNum);

% Disable continous tranmsission mode
TxMode = 0;
warplab_writeRegister(udp_node1,TX_MODE,TxMode);


%Close sockets
pnet('closeall');

end % end if USESIM==0


