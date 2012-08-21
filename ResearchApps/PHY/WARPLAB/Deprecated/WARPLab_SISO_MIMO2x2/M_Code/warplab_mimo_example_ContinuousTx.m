%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generating a Frequency Sweep with Continous Transmission using Warplab
% (2x2 MIMO configuration)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To run this code the boards must be programmed with the
% warplab_mimo_v02.bit bitstream

% The specific steps implemented in this script are the following

% 0. Initializaton and definition of parameters
% 1. Generate a vector of samples to transmit and send the samples to the 
% Warp board (Sample Frequency is 40MHz). Each transmitter radio transmits
% a sinusoid with different frequency.
% 2. Prepare boards for transmission and reception and send trigger to 
% start transmission and reception (trigger is the SYNC packet)
% 3. Leave continuous transmitter on for n seconds and then stop continuous
% transmission.
% 4. Read the received samples from the Warp board.
% 5. Reset and disable the boards.
% 6. Plot the transmitted and received data.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0. Initializaton and definition of parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Load some global definitions (packet types, etc.)
warplab_defines

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
TxLength = 2^14-1000; %Length of transmission; in [0:2^14-CaptOffset]
TransMode = 1; %Transmission mode; in [0:1] 
               % 0: Single Transmission 
               % 1: Continuous Transmission. Tx board will continue 
               % transmitting the vector of samples until the user manually
               % disables the transmitter. 
CarrierChannel = 8; % Channel in the 2.4 GHz band. In [1:14]
Tx2GainBB = 3; %Tx Baseband Gain in [0:3]
Tx2GainRF = 40; %Tx RF Gain in [0:63]
Rx2GainBB = 15; %Rx Baseband Gain in [0:31]
Rx2GainRF = 1; %Rx RF Gain in [1:3]
Tx3GainBB = 3; %Tx Baseband Gain in [0:3]
Tx3GainRF = 40; %Tx RF Gain in [0:63]
Rx3GainBB = 15; %Rx Baseband Gain in [0:31]
Rx3GainRF = 1; %Rx RF Gain in [1:3]
TxSelect = 2; % Select transmitter radio [0:2] 0:Radio2, 1:Radio3, 2: Both
RxSelect = 2; % Select transmitter radio [0:2] 0:Radio2, 1:Radio3, 2: Both

% Define the options vector; the order of options is set by the FPGA's code
% (C code)
optionsVector = [CaptOffset TxLength-1 TransMode CarrierChannel (Rx2GainBB + Rx2GainRF*2^16) (Tx2GainRF + Tx2GainBB*2^16) (Rx3GainBB + Rx3GainRF*2^16) (Tx3GainRF + Tx3GainBB*2^16) TxSelect RxSelect]; 
% Send options vector to the nodes
warplab_setOptions(socketHandles,optionsVector);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Generate a vector of samples to transmit and send the samples to the 
% Warp board (Sample Frequency is 40MHz).  Vector represents a sinusoid
% with complex frequency linearly increasing in time.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Prepare some data to be transmitted
t = 0:(1/40e6):TxLength/40e6 - 1/40e6; % Create time vector

% Create a signal to transmit from radio 2 
f1 = 1e6;
TxData_2 = exp(t*j*2*pi*f1); %Signal must be a row vector. The signal can
% be real or complex, the only constraint is that the amplitude of the real
% part must be in [-1:1] and the amplitude of the imaginary part must be 
% in [-1:1]

% Download the samples to be transmitted
warplab_writeSMWO(udp_Tx, TxData_2, RADIO2_TXDATA); % Download samples to 
% radio 2 Tx Buffer

% Create a signal to transmit from radio 3
f2 = 6e6;
TxData_3 = linspace(0,1,TxLength).*exp(t*j*2*pi*f2); 
% Signal must be a row vector. The signal can be real or complex, 
% the only constraint is that the amplitude of the real part must be in 
% [-1:1] and the amplitude of the imaginary part must be in [-1:1]

warplab_writeSMWO(udp_Tx, TxData_3, RADIO3_TXDATA); % Download samples to 
% radio 3 Tx Buffer

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Prepare boards for transmission and reception and send trigger to 
% start transmission and reception (trigger is the SYNC packet)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enable transmitter radio path in transmitter node (enable radio 2 and 
% radio 3 in transmitter node as transmitters)
warplab_sendCmd(udp_Tx, [RADIO2_TXEN RADIO3_TXEN], packetNum);

% Enable receiver radio path in receiver node (enable radio 2 and 
% radio 3 in receiver node as receivers)
warplab_sendCmd(udp_RxA, [RADIO2_RXEN RADIO3_RXEN], packetNum);

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
% 3. Leave continuous transmitter on for n seconds and then stop continuous
% transmission and disable transmitter radio
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Leave continuous transmitter on for nsec seconds
nsec = 5;
pause(nsec);

% Stop transmission
warplab_sendCmd(udp_Tx, TX_STOP, packetNum); % Resets the output and read 
% address of the transmitter buffer without disabling the transmitter radio. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Read the received samples from the Warp board
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% In continuous transmitter mode the receiver stores CaptOffset samples of 
% noise and the first TxLength samples transmitted. 

% Read back the received samples from radio 2
[RawRxData_2] = warplab_readSMRO(udp_RxA, RADIO2_RXDATA, TxLength+CaptOffset);
% Read back the received samples from radio 3
[RawRxData_3] = warplab_readSMRO(udp_RxA, RADIO3_RXDATA, TxLength+CaptOffset);
% Process the received samples to obtain meaningful data
[RxData_2,RxOTR_2] = warplab_processRawRxData(RawRxData_2);
[RxData_3,RxOTR_3] = warplab_processRawRxData(RawRxData_3);
% Read stored RSSI data from radio 2
[RawRSSIData_2] = warplab_readSMRO(udp_RxA, RADIO2_RSSIDATA, (TxLength+CaptOffset)/8);
% Read stored RSSI data from radio 3
[RawRSSIData_3] = warplab_readSMRO(udp_RxA, RADIO3_RSSIDATA, (TxLength+CaptOffset)/8);
% Procecss Raw RSSI data to obtain meningful RSSI values
[RxRSSI_2] = warplab_processRawRSSIData(RawRSSIData_2);
[RxRSSI_3] = warplab_processRawRSSIData(RawRSSIData_3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. Reset and disable the boards
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reset the receiver
warplab_sendCmd(udp_RxA, RX_DONEREADING, packetNum);

% Disable the receiver radio 2 radio 3
warplab_sendCmd(udp_RxA, [RADIO2_RXDIS RADIO3_RXDIS], packetNum);

% Disable the transmitter radio 2 and radio 3
warplab_sendCmd(udp_Tx, [RADIO2_TXDIS RADIO3_TXDIS], packetNum);

% Close sockets
pnet('closeall');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 6. Plot the transmitted and received data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
subplot(4,2,1);
plot(real(TxData_2));
title('Tx Radio 2 I');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(4,2,2);
plot(imag(TxData_2));
title('Tx Radio 2 Q');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(4,2,3);
plot(real(TxData_3));
title('Tx Radio 3 I');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(4,2,4);
plot(imag(TxData_3));
title('Tx Radio 3 Q');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(4,2,5);
plot(real(RxData_2));
title('Rx Radio 2 I');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(4,2,6);
plot(imag(RxData_2));
title('Rx Radio 2 Q');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(4,2,7);
plot(real(RxData_3));
title('Rx Radio 3 I');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(4,2,8);
plot(imag(RxData_3));
title('Rx Radio 3 Q');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
