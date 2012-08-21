%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Transmitting and Receiving Data using WARPLab (1x4 SIMO configuration)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To run this M-code the boards must be programmed with the
% warplab_mimo_4x4_v04.bit bitstream

% The specific steps implemented in this script are the following

% 0. Initializaton and definition of parameters
% 1. Generate a vector of samples to transmit and send the samples to the 
% WARP board (Sample Frequency is 40MHz)
% 2. Prepare WARP boards for transmission and reception and send trigger to 
% start transmission and reception (trigger is the SYNC packet)
% 3. Read the received samples from the Warp board
% 4. Reset and disable the boards
% 5. Plot the transmitted and received data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0. Initializaton and definition of parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

% Define WARPLab parameters. 
TxDelay = 1000; % Number of noise samples per Rx capture. In [0:2^14]
TxLength = 2^14-1-1000; % Length of transmission. In [0:2^14-1-TxDelay]
TxMode = 0; % Transmission mode. In [0:1] 
            % 0: Single Transmission 
            % 1: Continuous Transmission. Tx board will continue 
            % transmitting the vector of samples until the user manually
            % disables the transmitter. 
CarrierChannel = 9; % Channel in the 2.4 GHz band. In [1:14]
Node1_Radio1_TxGain_BB = 3; % Tx Baseband Gain. In [0:3]
Node1_Radio1_TxGain_RF = 40; % Tx RF Gain. In [0:63]
Node2_Radio1_RxGain_BB = 17; % Rx Baseband Gain. In [0:31]
Node2_Radio1_RxGain_RF = 1; % Rx RF Gain. In [1:3]  
Node2_Radio2_RxGain_BB = 17; % Rx Baseband Gain. In [0:31]
Node2_Radio2_RxGain_RF = 1; % Rx RF Gain. In [1:3]  
Node2_Radio3_RxGain_BB = 17; % Rx Baseband Gain. In [0:31]
Node2_Radio3_RxGain_RF = 1; % Rx RF Gain. In [1:3]  
Node2_Radio4_RxGain_BB = 17; % Rx Baseband Gain. In [0:31]
Node2_Radio4_RxGain_RF = 1; % Rx RF Gain. In [1:3]  
% Note: For this experiment node 1 will be set as the transmitter and node 
% 2 will be set as the receiver (this is done later in the code), hence, 
% there is no need to define receive gains for node1 and there is no
% need to define transmitter gains for node2.

% Download the WARPLab parameters to the WARP nodes. 
% The nodes store the TxDelay, TxLength, and TxMode parameters in 
% registers defined in the WARPLab sysgen model. The nodes set radio 
% related parameters CarrierChannel, TxGains, and RxGains, using the 
% radio controller functions.
% The TxDelay, TxLength, and TxMode parameters need to be known at the transmitter;
% the receiver doesn't require knowledge of these parameters (the receiver
% will always capture 2^14 samples). For this exercise node 1 will be set as
% the transmitter (this is done later in the code). Since TxDelay, TxLength and
% TxMode are only required at the transmitter we download the TxDelay, TxLength and
% TxMode parameters only to the transmitter node (node 1).
warplab_writeRegister(udp_node1,TX_DELAY,TxDelay);
warplab_writeRegister(udp_node1,TX_LENGTH,TxLength);
warplab_writeRegister(udp_node1,TX_MODE,TxMode);
% The CarrierChannel parameter must be downloaded to all nodes  
warplab_setRadioParameter(udp_node1,CARRIER_CHANNEL,CarrierChannel);
warplab_setRadioParameter(udp_node2,CARRIER_CHANNEL,CarrierChannel);
% Node 1 will be set as the transmitter so download Tx gains to node 1.
warplab_setRadioParameter(udp_node1,RADIO1_TXGAINS,(Node1_Radio1_TxGain_RF + Node1_Radio1_TxGain_BB*2^16));
% Node 2 will be set as the receiver so download Rx gains to node 2.
warplab_setRadioParameter(udp_node2,RADIO1_RXGAINS,(Node2_Radio1_RxGain_BB + Node2_Radio1_RxGain_RF*2^16));
warplab_setRadioParameter(udp_node2,RADIO2_RXGAINS,(Node2_Radio2_RxGain_BB + Node2_Radio2_RxGain_RF*2^16));
warplab_setRadioParameter(udp_node2,RADIO3_RXGAINS,(Node2_Radio3_RxGain_BB + Node2_Radio3_RxGain_RF*2^16));
warplab_setRadioParameter(udp_node2,RADIO4_RXGAINS,(Node2_Radio4_RxGain_BB + Node2_Radio4_RxGain_RF*2^16));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Generate a vector of samples to transmit and send the samples to the 
% WARP board (Sample Frequency is 40MHz)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Prepare some data to be transmitted
t = 0:(1/40e6):TxLength/40e6 - 1/40e6; % Create time vector

% Create a signal to transmit from radio 1, the signal can be real or complex.
% The signal must meet the following requirements:
% - Signal to transmit must be a row vector.
% - The amplitude of the real part must be in [-1:1] and the amplitude 
% of the imaginary part must be in [-1:1]. 
% - Highest frequency component is limited to 9.5 MHz (signal bandwidth
% is limited to 19 MHz)
% - Lowest frequency component is limited to 30 kHz
Node1_Radio1_TxData = exp(t*j*2*pi*1e6);

% Download the samples to be transmitted
warplab_writeSMWO(udp_node1, RADIO1_TXDATA, Node1_Radio1_TxData); % Download samples to 
% radio 1 Tx Buffer

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Prepare WARP boards for transmission and reception and send trigger to 
% start transmission and reception (trigger is the SYNC packet)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The following lines of code set node 1 as transmitter and node 2 as
% receiver; transmission and capture are triggered by sending the SYNC
% packet.

% Enable transmitter radio path in radio 1 in node 1 (enable radio 1
% in node 1 as transmitters)
warplab_sendCmd(udp_node1, RADIO1_TXEN, packetNum);

% Enable transmission of node1's radio 1 Tx buffer (enable 
% transmission of samples stored in radio 1 Tx buffer in node 1)
warplab_sendCmd(udp_node1, RADIO1TXBUFF_TXEN, packetNum);

% Enable receiver radio path in all radios in node 2 (enable all radios
% in node 2 as receivers)
warplab_sendCmd(udp_node2, [RADIO1_RXEN, RADIO2_RXEN, RADIO3_RXEN, RADIO4_RXEN], packetNum);

% Enable capture in node2's Rx Buffers (enable all Rx buffers in node 2 
% for storage of samples)
warplab_sendCmd(udp_node2, [RADIO1RXBUFF_RXEN, RADIO2RXBUFF_RXEN, RADIO3RXBUFF_RXEN, RADIO4RXBUFF_RXEN], packetNum);

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
% 3. Read the received samples from the Warp board
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read back the received samples from radio 1
[Node2_Radio1_RawRxData] = warplab_readSMRO(udp_node2, RADIO1_RXDATA, TxLength+TxDelay);
% Read back the received samples from radio 2
[Node2_Radio2_RawRxData] = warplab_readSMRO(udp_node2, RADIO2_RXDATA, TxLength+TxDelay);
% Read back the received samples from radio 3
[Node2_Radio3_RawRxData] = warplab_readSMRO(udp_node2, RADIO3_RXDATA, TxLength+TxDelay);
% Read back the received samples from radio 4
[Node2_Radio4_RawRxData] = warplab_readSMRO(udp_node2, RADIO4_RXDATA, TxLength+TxDelay);
% Process the received samples to obtain meaningful data
[Node2_Radio1_RxData,Node2_Radio1_RxOTR] = warplab_processRawRxData(Node2_Radio1_RawRxData);
[Node2_Radio2_RxData,Node2_Radio2_RxOTR] = warplab_processRawRxData(Node2_Radio2_RawRxData);
[Node2_Radio3_RxData,Node2_Radio3_RxOTR] = warplab_processRawRxData(Node2_Radio3_RawRxData);
[Node2_Radio4_RxData,Node2_Radio4_RxOTR] = warplab_processRawRxData(Node2_Radio4_RawRxData);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Reset and disable the boards
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set radio 1 Tx buffers in node 1 back to Tx disabled mode
warplab_sendCmd(udp_node1, RADIO1TXBUFF_TXDIS, packetNum);

% Disable the transmitter radio
warplab_sendCmd(udp_node1, RADIO1_TXDIS, packetNum);

% Let the receiver know that samples have been read and system is ready for
% a new capture
warplab_sendCmd(udp_node2, RX_DONEREADING, packetNum);

% Set all Rx buffers in node 2 back to Rx disabled mode
warplab_sendCmd(udp_node2, [RADIO1RXBUFF_RXDIS, RADIO2RXBUFF_RXDIS, RADIO3RXBUFF_RXDIS, RADIO4RXBUFF_RXDIS], packetNum);

% Disable the receiver radios
warplab_sendCmd(udp_node2, [RADIO1_RXDIS, RADIO2_RXDIS, RADIO3_RXDIS, RADIO4_RXDIS], packetNum);

% Close sockets
pnet('closeall');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. Plot the transmitted and received data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
subplot(2,1,1);
plot(real(Node1_Radio1_TxData));
title('Tx Node 1 Radio 1 I');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(2,1,2);
plot(imag(Node1_Radio1_TxData));
title('Tx Node 1 Radio 1 Q');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.


figure;
subplot(4,2,1);
plot(real(Node2_Radio1_RxData));
title('Rx Node 2 Radio 1 I');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(4,2,2);
plot(imag(Node2_Radio1_RxData));
title('Rx Node 2 Radio 1 Q');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(4,2,3);
plot(real(Node2_Radio2_RxData));
title('Rx Node 2 Radio 2 I');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(4,2,4);
plot(imag(Node2_Radio2_RxData));
title('Rx Node 2 Radio 2 Q');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(4,2,5);
plot(real(Node2_Radio3_RxData));
title('Rx Node 2 Radio 3 I');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(4,2,6);
plot(imag(Node2_Radio3_RxData));
title('Rx Node 2 Radio 4 Q');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(4,2,7);
plot(real(Node2_Radio4_RxData));
title('Rx Node 2 Radio 4 I');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(4,2,8);
plot(imag(Node2_Radio4_RxData));
title('Rx Node 2 Radio 4 Q');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
