
% Simple test from Tx 2 to Rx 2. Quick and dirty version, comments may be
% wrong. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0. Initializaton and definition of parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Load some global definitions (packet types, etc.)
warplab_defines_AGC

% Create Socket handles and intialize nodes
[socketHandles, packetNum] = warplab_initialize;

%Separate the socket handles for easier access
% The first socket handle is always the magic SYNC
% The rest can be arranged in any combination of Tx and Rx
udp_Sync = socketHandles(1);
udp_Tx = socketHandles(2);
udp_RxA = socketHandles(3);

% Define the warplab options (parameters)
CaptOffset = 1000; %Number of noise samples per Rx capture; in [0:2^14]
TxLength = 2^14-CaptOffset-672; %Length of transmission; in [0:2^14-CaptOffset-672] 672 is the length of the preamble (short training symbols(160*2upsample)+long training symbols(160*2upsample)+guard interval of 32samples)
%TransMode = 0; %Transmission mode; in [0:1] 
               % 0: Single Transmission 
               % 1: Continuous Transmission. Tx board will continue 
               % transmitting the vector of samples until the user manually
               % disables the transmitter. 
CarrierChannel = 4; % Channel in the 2.4 GHz band. In [1:14]
Tx1GainBB = 3; %Tx Baseband Gain in [0:3]
Tx1GainRF = 40; %Tx RF Gain in [0:63]
Tx2GainBB = 3; %Tx Baseband Gain in [0:3]
Tx2GainRF = 40; %Tx RF Gain in [0:63]
Tx3GainBB = 3; %Tx Baseband Gain in [0:3]
Tx3GainRF = 40; %Tx RF Gain in [0:63]
Tx4GainBB = 3; %Tx Baseband Gain in [0:3]
Tx4GainRF = 40; %Tx RF Gain in [0:63]
%Rx2GainBB = 15; %Rx Baseband Gain in [0:31]
%Rx2GainRF = 1; %Rx RF Gain in [1:3]
% ALL THE RADIOS WILL HAVE THE SAME GAIN
% Tx3GainBB = 3; %Tx Baseband Gain in [0:3]
% Tx3GainRF = 40; %Tx RF Gain in [0:63]
% Rx3GainBB = 15; %Rx Baseband Gain in [0:31]
% Rx3GainRF = 1; %Rx RF Gain in [1:3]
%TxSelect = 5; % Select transmitter radio [0:2] 0:Radio1, 1:Radio2, 2: Radio3, 3:Radio4, 5:All RAdios 
%RxSelect = 5; % Select transmitter radio [0:2] 0:Radio1, 1:Radio2, 2: Radio3, 3:Radio4, 5:All RAdios 

% % Define the options vector; the order of options is set by the FPGA's code
% % (C code)
% %optionsVector = [CaptOffset TxLength-1 TransMode CarrierChannel (Rx2GainBB + Rx2GainRF*2^16) (Tx2GainRF + Tx2GainBB*2^16) (Rx3GainBB + Rx3GainRF*2^16) (Tx3GainRF + Tx3GainBB*2^16) TxSelect RxSelect]; 
% %optionsVector = [CaptOffset TxLength-1 CarrierChannel (Rx2GainBB + Rx2GainRF*2^16) (Tx2GainRF + Tx2GainBB*2^16) TxSelect RxSelect]; 
% optionsVector = [CaptOffset TxLength-1 CarrierChannel (Tx1GainRF + Tx1GainBB*2^16) (Tx2GainRF + Tx2GainBB*2^16) (Tx3GainRF + Tx3GainBB*2^16) (Tx4GainRF + Tx4GainBB*2^16)]; 
% % Send options vector to the nodes
% warplab_setOptions(socketHandles,optionsVector);
% % Note: The Rx Gains will be ignored because these will be set by the AGC
% 
% % Set target dBm for AGC
% warplab_setTargetdBmAGC(udp_RxA,-6); % -6 % From ref design: -14
% 
% % Set noise estimate dBm for AGC
% warplab_setNoiseEstdBmAGC(udp_RxA,-95); % -95 % From ref design: -95

Node1_Radio1_TxGain_BB = 3; % Tx Baseband Gain. In [0:3]
Node1_Radio1_TxGain_RF = 40; % Tx RF Gain. In [0:63]
Node1_Radio2_TxGain_BB = 3; % Tx Baseband Gain. In [0:3]
Node1_Radio2_TxGain_RF = 40; % Tx RF Gain. In [0:63]
Node1_Radio3_TxGain_BB = 3; % Tx Baseband Gain. In [0:3]
Node1_Radio3_TxGain_RF = 40; % Tx RF Gain. In [0:63]
Node1_Radio4_TxGain_BB = 3; % Tx Baseband Gain. In [0:3]
Node1_Radio4_TxGain_RF = 40; % Tx RF Gain. In [0:63]
Node2_TargetdBmAGC = -6; % AGC's target dBm
Node2_NoiseEstdBmAGC = -95; % AGC's Noise Estimate in dBm
% Note: For this experiment node 1 will be set as the transmitter and node 
% 2 will be set as the receiver (this is done later in the code), hence, 
% there is no need to define receive gains for node 1, there is no
% need to define transmitter gains for node 2, and there is no need to
% define AGC parameters for node 1

% Download the WARPLab parameters to the WARP nodes. 
% The nodes store the CaptOffset, TxLength, and TxMode parameters in 
% registers defined in the WARPLab sysgen model. The nodes set radio 
% related parameters CarrierChannel, TxGains, and RxGains, using the 
% radio controller functions. The nodes store the TargetdBmAGC and
% NoiseEstdBmAGC parameters in registers in the AGC sysgen model.
% The CaptOffset is a parameter that needs to be known at the receiver
% node; knowledge of CaptOffset is not required at the transmitter. For 
% this exercise node 2 will be set as the receiver (this is done later in 
% the code). Since CaptOffset is only required at the receiver we
% download the CaptOffset value only to the receiver node (node 2).
warplab_writeRegister(udp_RxA,CAPT_OFFSET,CaptOffset);
% The TxLength and TxMode parameters need to be known at the transmitter;
% the receiver doesn't require knowledge of these parameters (the receiver
% will always capture 2^14 samples). For this exercise node 1 will be set as
% the transmitter (this is done later in the code). Since TxLength and
% TxMode are only required at the transmitter we download the TxLength and
% TxMode parameters only to the transmitter node (node 1).
warplab_writeRegister(udp_Tx,TX_LENGTH,TxLength);
%warplab_writeRegister(udp_Tx,TX_MODE,TxMode);
% The CarrierChannel parameter must be downloaded to all nodes  
warplab_setRadioAGCParameter(udp_Tx,CARRIER_CHANNEL,CarrierChannel);
warplab_setRadioAGCParameter(udp_RxA,CARRIER_CHANNEL,CarrierChannel);
% Node 1 will be set as the transmitter so download Tx gains to node 1.
warplab_setRadioAGCParameter(udp_Tx,RADIO1_TXGAINS,(Node1_Radio1_TxGain_RF + Node1_Radio1_TxGain_BB*2^16));
warplab_setRadioAGCParameter(udp_Tx,RADIO2_TXGAINS,(Node1_Radio2_TxGain_RF + Node1_Radio2_TxGain_BB*2^16));
warplab_setRadioAGCParameter(udp_Tx,RADIO3_TXGAINS,(Node1_Radio3_TxGain_RF + Node1_Radio3_TxGain_BB*2^16));
warplab_setRadioAGCParameter(udp_Tx,RADIO4_TXGAINS,(Node1_Radio4_TxGain_RF + Node1_Radio4_TxGain_BB*2^16));
% Download AGC parameters to node 2
warplab_setRadioAGCParameter(udp_RxA,SET_AGC_TARGET_dBm,Node2_TargetdBmAGC);
warplab_setRadioAGCParameter(udp_RxA,SET_AGC_NOISEEST_dBm,Node2_NoiseEstdBmAGC);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Generate a vector of samples to transmit and send the samples to the 
% Warp board (Sample Frequency is 40MHz)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Prepare some data to be transmitted
t = 0:(1/40e6):TxLength/40e6 - 1/40e6; % Create time vector

% Create a signal to transmit from radio 2 
TxData_2 = exp(t*j*2*pi*1.25e6); %Signal must be a row vector. The signal can
% be real or complex, the only constraint is that the amplitude of the real
% part must be in [-1:1] and the amplitude of the imaginary part must be 
% in [-1:1]

% % Download the samples to be transmitted
% warplab_writeSMWO(udp_Tx, TxData_2, RADIO2_TXDATA); % Download samples to 
% % radio 2 Tx Buffer

% Create a signal to transmit from radio 3
%TxData_3 = 0*exp(t*j*2*pi*1.25e6); 
% Signal must be a row vector. The signal can be real or complex, 
% the only constraint is that the amplitude of the real part must be in 
% [-1:1] and the amplitude of the imaginary part must be in [-1:1]

%warplab_writeSMWO(udp_Tx, TxData_3, RADIO3_TXDATA); % Download samples to 
% radio 3 Tx Buffer

%%%%%%%%%%%% Append long training symbols and guard interval %%%%%%%%%%%%%%
% Append guard interval
TxData_2 = [zeros(1,32) TxData_2]; % Used to prevent ISI due to multipath
%TxData_3 = [zeros(1,32) TxData_3]; % Used to prevent ISI due to multipath

% Call WARPLab function that generates long training symbols
[LongTrainingSyms_up2,LongSymbol_time_up2,LongSymbol_time,LongSymbol_freq] = warplab_generateLongTrainSyms;
%[LongTrainingSyms_up2]= warplab_generateLongTrainingSyms

% Append long training symbols and save 
TxData_2 = [LongTrainingSyms_up2 TxData_2];
%TxData_3 = [LongTrainingSyms_up2 TxData_3];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%% Preamble for a 1.25MHz tone %%%%%%%%%%%%%%%%%%%%%%%%
shortSymbol_freq = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1-i 0 0 0 0 0 0 0 1-i 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0].';
% Take IFFT of preamble and create short symbols as per 802.11 standard
shortSymbol_time = ifft(fftshift(shortSymbol_freq));
shortSymbol_time = shortSymbol_time(1:16).';
shortsyms_10 = repmat(shortSymbol_time,1,10);
preamble_I = real(shortsyms_10);
preamble_Q = imag(shortsyms_10);
% Upsample by 2 so the standard preamble occupies a bandwith of 10MHz if
% unmodified
[preamble_I_up2] = interp(preamble_I, 2);%(2.85/(10*0.0313))*interp(preamble_I, 2);
[preamble_Q_up2] = interp(preamble_Q, 2);%(2.85/(10*0.0313))*interp(preamble_Q, 2);
[preamble_I_up2] = (1/0.0314)*preamble_I_up2;%(2.85/(10*0.0313))*interp(preamble_I, 2);
[preamble_Q_up2] = (1/0.0314)*preamble_Q_up2;%(2.85/(10*0.0313))*interp(preamble_Q, 2);
% Other scaling option
% scale = 1 / max( [ max(preamble_I_up2) , max(preamble_Q_up2) ] );
% [preamble_I_up2] = scale*preamble_I_up2;%(2.85/(10*0.0313))*interp(preamble_I, 2);
% [preamble_Q_up2] = scale*preamble_Q_up2;%(2.85/(10*0.0313))*interp(preamble_Q, 2);

%%%%%%%%%%%%%%%%%%%%%%%% Preamble plotter %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reference preamble 
shortSymbol_freq_80211 = [0 0 0 0 0 0 0 0 1+i 0 0 0 -1+i 0 0 0 -1-i 0 0 0 1-i 0 0 0 -1-i 0 0 0 1-i 0 0 0 0 0 0 0 1-i 0 0 0 -1-i 0 0 0 1-i 0 0 0 -1-i 0 0 0 -1+i 0 0 0 1+i 0 0 0 0 0 0 0].';
figure
subplot(3,2,1)
stem(real(shortSymbol_freq_80211))
subplot(3,2,3)
stem(imag(shortSymbol_freq_80211))
subplot(3,2,5)
stem(abs(shortSymbol_freq_80211))
subplot(3,2,2)
stem(real(shortSymbol_freq))
subplot(3,2,4)
stem(imag(shortSymbol_freq))
subplot(3,2,6)
stem(abs(shortSymbol_freq))
figure
subplot(3,2,1)
plot(preamble_I)
subplot(3,2,3)
plot(preamble_Q)
subplot(3,2,5)
plot(abs(preamble_I + sqrt(-1)*preamble_Q))
subplot(3,2,2)
plot(preamble_I_up2)
subplot(3,2,4)
plot(preamble_Q_up2)
subplot(3,2,6)
plot(abs(preamble_I_up2 + sqrt(-1)*preamble_Q_up2))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Append the preamble to the data to be transmitted
TxData_2 = [preamble_I_up2 + sqrt(-1)*preamble_Q_up2, TxData_2];
%TxData_3 = [preamble_I_up2 + sqrt(-1)*preamble_Q_up2, TxData_3];

% % Download the samples to be transmitted
warplab_writeSMWO(udp_Tx, RADIO2_TXDATA, TxData_2); % Download samples to 
% % radio 2 Tx Buffer
%warplab_writeSMWO(udp_Tx, RADIO3_TXDATA, TxData_3); % Download samples to 
% radio 3 Tx Buffer

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Prepare boards for transmission and reception and send trigger to 
% start transmission and reception (trigger is the SYNC packet)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enable transmitter radio path in transmitter node (enable radio 2 and 
% radio 3 in transmitter node as transmitters)
warplab_sendCmd(udp_Tx, [RADIO2_TXEN], packetNum);

% Enable transmission of samples stored in radio2 Tx buffer
warplab_sendCmd(udp_Tx, [RADIO2TXBUFF_TXEN], packetNum);

% Enable receiver radio path in receiver node (enable radio 2 and 
% radio 3 in receiver node as receivers)
warplab_sendCmd(udp_RxA, [RADIO2_RXEN], packetNum);

%Enable Radio's receive buffer for storage of samples
warplab_sendCmd(udp_RxA, [RADIO2RXBUFF_RXEN], packetNum);

% Prime transmitter state machine in transmitter node. Transmitter will be 
% waiting for the SYNC packet. Transmission will be triggered when the 
% transmitter node receives the SYNC packet.
warplab_sendCmd(udp_Tx, TX_START, packetNum);

% Prime receiver state machine in receiver node. Receiver will be waiting 
% for the SYNC packet. Capture will be triggered when the receiver 
% node receives the SYNC packet.
warplab_sendCmd(udp_RxA, RX_START, packetNum);

% Send the SYNC packet
warplab_sendSync(udp_Sync);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Read the received samples from the Warp board
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read back the received samples from radio 2
[RawRxData_2_wDCO] = warplab_readSMRO(udp_RxA, RADIO2_RXDATA, TxLength+CaptOffset);
% Read back the received samples from radio 3
%[RawRxData_3_wDCO] = warplab_readSMRO(udp_RxA, RADIO3_RXDATA, TxLength+CaptOffset);
% Process the received samples to obtain meaningful data
[RxData_2_wDCO,RxOTR_2] = warplab_processRawRxData(RawRxData_2_wDCO);
%[RxData_3_wDCO,RxOTR_3] = warplab_processRawRxData(RawRxData_3_wDCO);

% Read the address where the AGC fixes the gains
[AGC_Set_Address] = warplab_readRegister(udp_RxA,AGC_DONE_ADDR);
% Read the gains that were set by the AGC
[GainsRF_Init,GainsBB_Init] = warplab_readAGCGains(udp_RxA);
% Remove DC Offset (DCO) from RxData
[RxData_2] = warplab_correctDCO(RxData_2_wDCO,AGC_Set_Address);
%[RxData_3] = warplab_correctDCO(RxData_3_wDCO,AGC_Set_Address);

% Find address where payolad starts and address where the first long symbol
% in the long training symbols starts
[FirstLongSymbol_Start_2] = warplab_findLongTrainingStart(RxData_2,LongSymbol_time_up2,AGC_Set_Address);
%[FirstLongSymbol_Start_3] = warplab_findLongTrainingStart(RxData_3,LongSymbol_time_up2,AGC_Set_Address);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Reset and disable the boards
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reset the AGC
warplab_sendCmd(udp_RxA, AGC_RESET, packetNum);

% Reset the receiver
warplab_sendCmd(udp_RxA, RX_DONEREADING, packetNum);

% Disable the receiver radio 2 radio 3
warplab_sendCmd(udp_RxA, [RADIO2_RXDIS], packetNum);

% Disable transmission of samples stored in radio2 Tx buffer
warplab_sendCmd(udp_Tx, [RADIO2TXBUFF_TXDIS], packetNum);

% Disable the transmitter radio 2 and radio 3
warplab_sendCmd(udp_Tx, [RADIO2_TXDIS], packetNum);

%Enable Radio's receive buffer for storage of samples
warplab_sendCmd(udp_RxA, [RADIO2RXBUFF_RXDIS], packetNum);

% Close sockets
pnet('closeall');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. Plot the transmitted and received data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
subplot(3,2,1);
plot(real(TxData_2));
title('Tx Radio 2 I');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(3,2,2);
plot(imag(TxData_2));
title('Tx Radio 2 Q');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(3,2,3);
plot(real(RxData_2_wDCO));
title('Rx Radio 2 I before DCO correction');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(3,2,4);
plot(imag(RxData_2_wDCO));
title('Rx Radio 2 Q before DCO correction');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(3,2,5);
plot(real(RxData_2));
title('Rx Radio 2 I after DCO correction');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(3,2,6);
plot(imag(RxData_2));
title('Rx Radio 2 Q after DCO correction');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.


% figure;
% subplot(3,2,1);
% plot(real(TxData_3));
% title('Tx Radio 3 I');
% xlabel('n (samples)'); ylabel('Amplitude');
% axis([0 2^14 -1 1]); % Set axis ranges.
% subplot(3,2,2);
% plot(imag(TxData_3));
% title('Tx Radio 3 Q');
% xlabel('n (samples)'); ylabel('Amplitude');
% axis([0 2^14 -1 1]); % Set axis ranges.
% subplot(3,2,3);
% plot(real(RxData_3_wDCO));
% title('Rx Radio 3 I before DCO correction');
% xlabel('n (samples)'); ylabel('Amplitude');
% axis([0 2^14 -1 1]); % Set axis ranges.
% subplot(3,2,4);
% plot(imag(RxData_3_wDCO));
% title('Rx Radio 3 Q before DCO correction');
% xlabel('n (samples)'); ylabel('Amplitude');
% axis([0 2^14 -1 1]); % Set axis ranges.
% subplot(3,2,5);
% plot(real(RxData_3));
% title('Rx Radio 3 I after DCO correction');
% xlabel('n (samples)'); ylabel('Amplitude');
% axis([0 2^14 -1 1]); % Set axis ranges.
% subplot(3,2,6);
% plot(imag(RxData_3));
% title('Rx Radio 3 Q after DCO correction');
% xlabel('n (samples)'); ylabel('Amplitude');
% axis([0 2^14 -1 1]); % Set axis ranges.
