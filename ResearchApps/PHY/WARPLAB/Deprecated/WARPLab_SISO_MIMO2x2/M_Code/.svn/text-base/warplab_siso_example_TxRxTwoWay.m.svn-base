%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Two-Way transmission and reception of data using Warplab(SISO configuration)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To run this code the boards must be programmed with the
% warplab_siso_v02.bit bitstream

% Use Warplab for two-way communication between two nodes. First node A 
% will transmit to node B and then node B will transmit to node A.

% The specific steps implemented in this script are the following

% 0. Initializaton and definition of parameters
% 1. Generate the vector of samples that node A will transmit to node B and
% the vector of samples that node B will transmit to node A, then download 
% the samples to the Warp boards (Sample Frequency is 40MHz)
% 2. Prepare boards for transmission and reception from node A to node B 
% and send trigger to start transmission and reception (trigger is the SYNC
% packet)
% 3. Disable the radios
% 4. Prepare boards for transmission and reception from node B to node A 
% and send trigger to start transmission and reception (trigger is the SYNC
% packet)
% 5. Disable the radios
% 6. Read the received samples from the Warp boards 
% 7. Reset the boards and close sockets
% 8. Plot the transmitted and received data


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
udp_nodeA = socketHandles(2);
udp_nodeB = socketHandles(3); 

% Define the warplab options (parameters)
CaptOffset = 1000; %Number of noise samples per Rx capture; in [0:2^14]
TxLength = 2^14-1000; %Length of transmission; in [0:2^14-CaptOffset]
TransMode = 0; %Transmission mode; in [0:1] 
               % 0: Single Transmission 
               % 1: Continuous Transmission. Tx board will continue 
               % transmitting the vector of samples until the user manually
               % disables the transmitter. 
CarrierChannel = 8; % Channel in the 2.4 GHz band. In [1:14]
TxGainBB = 3; %Tx Baseband Gain in [0:3]
TxGainRF = 40; %Tx RF Gain in [0:63]
RxGainBB = 15; %Rx Baseband Gain in [0:31]
RxGainRF = 1; %Rx RF Gain in [1:3]

% Define the options vector; the order of options is set by the FPGA's code
% (C code)
optionsVector = [CaptOffset TxLength-1 TransMode CarrierChannel (RxGainBB + RxGainRF*2^16) (TxGainRF + TxGainBB*2^16)]; 
% Send options vector to the nodes
warplab_setOptions(socketHandles,optionsVector);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Generate the vector of samples that node A will transmit to node B and
% the vector of samples that node B will transmit to node A, then download 
% the samples to the Warp boards (Sample Frequency is 40MHz)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create time vector.
t = 0:(1/40e6):TxLength/40e6 - 1/40e6; 

% Create a signal to transmit from node A to node B
TxDataAB = exp(t*j*2*pi*1e6); %Signal must be a row vector. The signal can
% be real or complex, the only constraint is that the amplitude of the real
% part must be in [-1:1] and the amplitude of the imaginary part must be 
% in [-1:1]

% Download the samples to be transmitted
warplab_writeSMWO(udp_nodeA, TxDataAB, RADIO2_TXDATA); % Download samples to node A

% Create a signal to transmit from node B to node A
TxDataBA = linspace(0,1,TxLength).*exp(t*j*2*pi*5e6); 
% Signal must be a row vector. The signal can be real or complex, 
% the only constraint is that the amplitude of the real part must be in 
% [-1:1] and the amplitude of the imaginary part must be in [-1:1]

warplab_writeSMWO(udp_nodeB, TxDataBA, RADIO2_TXDATA); % Download samples to node B

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Prepare boards for transmission and reception from node A to node B 
% and send trigger to start transmission and reception (trigger is the SYNC
% packet)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enable transmitter radio path in node A
warplab_sendCmd(udp_nodeA, RADIO2_TXEN, packetNum);

% Enable receiver radio path in node B
warplab_sendCmd(udp_nodeB, RADIO2_RXEN, packetNum);

% Prime transmitter state machine in node A. Node A will be waiting for 
% the SYNC packet. Transmission will be triggered when node A receives 
% the SYNC packet.
warplab_sendCmd(udp_nodeA, TX_START, packetNum);

% Prime receiver state machine in node B. Node B will be waiting for 
% the SYNC packet. Capture will be triggered when node B receives 
% the SYNC packet.
warplab_sendCmd(udp_nodeB, RX_START, packetNum);

% Send the SYNC packet
warplab_sendSync(udp_Sync)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Disable the radios
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Disable the receiver
warplab_sendCmd(udp_nodeB, RADIO2_RXDIS, packetNum);

% Disable the transmitter
warplab_sendCmd(udp_nodeA, RADIO2_TXDIS, packetNum);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Prepare boards for transmission and reception from node B to node A 
% and send trigger to start transmission and reception (trigger is the SYNC
% packet)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enable transmitter radio path in node B
warplab_sendCmd(udp_nodeB, RADIO2_TXEN, packetNum);

% Enable receiver radio path in node A
warplab_sendCmd(udp_nodeA, RADIO2_RXEN, packetNum);

% Prime transmitter state machine in node B. Node B will be waiting for 
% the SYNC packet. Transmission will be triggered when node B receives 
% the SYNC packet.
warplab_sendCmd(udp_nodeB, TX_START, packetNum);

% Prime receiver state machine in node A. Node A will be waiting for 
% the SYNC packet. Capture will be triggered when node A receives 
% the SYNC packet.
warplab_sendCmd(udp_nodeA, RX_START, packetNum);

% Send the SYNC packet
warplab_sendSync(udp_Sync)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. Disable the radios
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Disable the receiver
warplab_sendCmd(udp_nodeA, RADIO2_RXDIS, packetNum);

% Disable the transmitter
warplab_sendCmd(udp_nodeB, RADIO2_TXDIS, packetNum);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 6. Read the received samples from the Warp boards 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read back the received samples sent from A to B
[RawRxDataAB] = warplab_readSMRO(udp_nodeB, RADIO2_RXDATA, TxLength+CaptOffset);
% Process the received samples to obtain meaningful data
[RxDataAB,RxOTRAB] = warplab_processRawRxData(RawRxDataAB);
% Read stored RSSI data corresponding to A to B transmission
[RawRSSIDataAB] = warplab_readSMRO(udp_nodeB, RADIO2_RSSIDATA, (TxLength+CaptOffset)/8);
% Procecss Raw RSSI data to obtain meningful RSSI values
[RxRSSIAB] = warplab_processRawRSSIData(RawRSSIDataAB);

% Read back the received samples sent from B to A
[RawRxDataBA] = warplab_readSMRO(udp_nodeA, RADIO2_RXDATA, TxLength+CaptOffset);
% Process the received samples to obtain meaningful data
[RxDataBA,RxOTRBA] = warplab_processRawRxData(RawRxDataBA);
% Read stored RSSI data corresponding to B to A transmission
[RawRSSIDataBA] = warplab_readSMRO(udp_nodeA, RADIO2_RSSIDATA, (TxLength+CaptOffset)/8);
% Procecss Raw RSSI data to obtain meningful RSSI values
[RxRSSIBA] = warplab_processRawRSSIData(RawRSSIDataBA);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 7. Reset the boards and close sockets
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reset node A 
warplab_sendCmd(udp_nodeA, RX_DONEREADING, packetNum);

% Reset node B
warplab_sendCmd(udp_nodeB, RX_DONEREADING, packetNum);

% Close sockets
pnet('closeall');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. Plot the transmitted and received data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot data from A to B transmissio
figure;
subplot(2,2,1);
plot(real(TxDataAB));
title('Tx I A to B');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(2,2,2);
plot(imag(TxDataAB));
title('Tx Q A to B');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(2,2,3);
plot(real(RxDataAB));
title('Rx I A to B');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(2,2,4);
plot(imag(RxDataAB));
title('Rx Q A to B');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.

% Plot data from B to A transmission
figure;
subplot(2,2,1);
plot(real(TxDataBA));
title('Tx I B to A');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(2,2,2);
plot(imag(TxDataBA));
title('Tx Q B to A');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(2,2,3);
plot(real(RxDataBA));
title('Rx I B to A');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(2,2,4);
plot(imag(RxDataBA));
title('Rx Q B to A');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.