%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generating a Frequency Sweep with Continous Transmission using WARPLab
% (SISO COnfiguration)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To run this code the boards must be programmed with the
% warplab_mimo_2x2_v03.bit bitstream (warplab_mimo_4x4_v03.bit does not 
% allow continuous transmission mode).

% The specific steps implemented in this script are the following

% 0. Initializaton and definition of parameters
% 1. Generate a vector of samples to transmit and send the samples to the 
% WARP board (Sample Frequency is 40MHz).  Vector represents a sinusoid
% with frequency linearly increasing in time.
% 2. Prepare WARP boards for transmission and reception and send trigger to 
% start transmission and reception (trigger is the SYNC packet)
% 3. Leave continuous transmitter on for n seconds and then stop continuous
% transmission.
% 4. Read the received samples from the Warp board.
% 5. Reset and disable the boards.
% 6. Plot the first 2^14 received samples.

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
CaptOffset = 1000; % Number of noise samples per Rx capture. In [0:2^14]
TxLength = 2^14-1-1000; % Length of transmission vector. In [0:2^14-1-CaptOffset]
TxMode = 1; % Transmission mode. In [0:1] 
            % 0: Single Transmission 
            % 1: Continuous Transmission. Tx board will continue 
            % transmitting the vector of samples until the user manually
            % disables the transmitter. 
CarrierChannel = 8; % Channel in the 2.4 GHz band. In [1:14]
Node1_Radio2_TxGain_BB = 3; % Tx Baseband Gain. In [0:3]
Node1_Radio2_TxGain_RF = 40; % Tx RF Gain. In [0:63]
Node2_Radio2_RxGain_BB = 13; % Rx Baseband Gain. In [0:31]
Node2_Radio2_RxGain_RF = 1; % Rx RF Gain. In [1:3]  
% Note: For this experiment node 1 will be set as the transmitter and node 
% 2 will be set as the receiver (this is done later in the code), hence, 
% there is no need to define receive gains for node1-radio2 and there is no
% need to define transmitter gains for node2-radio2. Node 2 will only store
% the first 2^14 samples received

% Download the WARPLab parameters to the WARP nodes. 
% The nodes store the CaptOffset, TxLength, and TxMode parameters in 
% registers defined in the WARPLab sysgen model. The nodes set radio 
% related parameters CarrierChannel, TxGains, and RxGains, using the 
% radio controller functions.
% The CaptOffset is a parameter that needs to be known at the receiver
% node; knowledge of CaptOffset is not required at the transmitter. For 
% this exercise node 2 will be set as the receiver (this is done later in 
% the code). Since CaptOffset is only required at the receiver we
% download the CaptOffset value only to the receiver node (node 2).
warplab_writeRegister(udp_node2,CAPT_OFFSET,CaptOffset);
% The TxLength and TxMode parameters need to be known at the transmitter;
% the receiver doesn't require knowledge of these parameters (the receiver
% will always capture 2^14 samples). For this exercise node 1 will be set as
% the transmitter (this is done later in the code). Since TxLength and
% TxMode are only required at the transmitter we download the TxLength and
% TxMode parameters only to the transmitter node (node 1).
warplab_writeRegister(udp_node1,TX_LENGTH,TxLength);
warplab_writeRegister(udp_node1,TX_MODE,TxMode);
% The CarrierChannel parameter must be downloaded to all nodes  
warplab_setRadioParameter(udp_node1,CARRIER_CHANNEL,CarrierChannel);
warplab_setRadioParameter(udp_node2,CARRIER_CHANNEL,CarrierChannel);
% Node 1 will be set as the transmitter so download Tx gains to node 1.
warplab_setRadioParameter(udp_node1,RADIO2_TXGAINS,(Node1_Radio2_TxGain_RF + Node1_Radio2_TxGain_BB*2^16));
% Node 2 will be set as the receiver so download Rx gains to node 2.
warplab_setRadioParameter(udp_node2,RADIO2_RXGAINS,(Node2_Radio2_RxGain_BB + Node2_Radio2_RxGain_RF*2^16));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Generate a vector of samples to transmit and send the samples to the 
% WARP board (Sample Frequency is 40MHz).  Vector represents a sinusoid
% with complex frequency linearly increasing in time.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Prepare some data to be transmitted
t = 0:(1/40e6):TxLength/40e6 - 1/40e6; % Create time vector.
f = -2e6:(4e6/TxLength):2e6 - 1; % Create frequency vector (Sweeps from 
% 1MHz to 5MHz)  Time and frequency vectors must have the same length.

% Create a signal to transmit, the signal can be real or complex.
% The signal must meet the following requirements:
% - Signal to transmit must be a row vector.
% - The amplitude of the real part must be in [-1:1] and the amplitude 
% of the imaginary part must be in [-1:1]. 
% - Highest frequency component is limited to 9.5 MHz (signal bandwidth
% is limited to 19 MHz)
% - Lowest frequency component is limited to 30 kHz
Node1_Radio2_TxData = exp(j*2*pi*f.*t); 

% Download the samples to be transmitted
warplab_writeSMWO(udp_node1, RADIO2_TXDATA, Node1_Radio2_TxData);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Prepare WARP boards for transmission and reception and send trigger to 
% start transmission and reception (trigger is the SYNC packet)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The following lines of code set node 1 as transmitter and node 2 as
% receiver; transmission and capture are triggered by sending the SYNC
% packet.

% Enable transmitter radio path in radio 2 in node 1 (enable radio 2 in 
% node 1 as transmitter)
warplab_sendCmd(udp_node1, RADIO2_TXEN, packetNum);

% Enable transmission of node1's radio 2 Tx buffer (enable transmission
% of samples stored in radio 2 Tx Buffer in node 1)
warplab_sendCmd(udp_node1, [RADIO2TXBUFF_TXEN], packetNum);

% Enable receiver radio path in radio 2 in node 2 (enable radio 2 in
% node 2 as receiver)
warplab_sendCmd(udp_node2, RADIO2_RXEN, packetNum);

% Enable capture in node2's radio 2 Rx Buffer (enable radio 2 rx buffer in
% node 2 for storage of samples)
warplab_sendCmd(udp_node2, [RADIO2RXBUFF_RXEN], packetNum);

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
% 3. Leave continuous transmitter on for n seconds and then stop continuous
% transmission and disable transmitter radio
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Leave continuous transmitter on for nsec seconds
nsec = 5;
pause(nsec);

% Stop transmission
warplab_sendCmd(udp_node1, TX_STOP, packetNum); % Resets the output and read 
% address of the transmitter buffer without disabling the transmitter radio. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Read the received samples from the WARP board
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% In continuous transmitter mode the receiver stores CaptOffset samples of 
% noise and the first TxLength samples transmitted. 

% Read back the received samples
[Node2_Radio2_RawRxData] = warplab_readSMRO(udp_node2, RADIO2_RXDATA, TxLength+CaptOffset);
% Process the received samples to obtain meaningful data
[Node2_Radio2_RxData,Node2_Radio2_RxOTR] = warplab_processRawRxData(Node2_Radio2_RawRxData);
% Read stored RSSI data
[Node2_Radio2_RawRSSIData] = warplab_readSMRO(udp_node2, RADIO2_RSSIDATA, (TxLength+CaptOffset)/8);
% Procecss Raw RSSI data to obtain meningful RSSI values
[Node2_Radio2_RSSIData] = warplab_processRawRSSIData(Node2_Radio2_RawRSSIData);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. Reset and disable the boards
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set radio 2 Tx buffer in node 1 back to Tx disabled mode
warplab_sendCmd(udp_node1, RADIO2TXBUFF_TXDIS, packetNum);

% Disable the transmitter radio
warplab_sendCmd(udp_node1, RADIO2_TXDIS, packetNum);

% Let the receiver know that samples have been read and system is ready for
% a new capture
warplab_sendCmd(udp_node2, RX_DONEREADING, packetNum);

% Set radio 2 Rx buffer in node 2 back to Rx disabled mode
warplab_sendCmd(udp_node2, RADIO2RXBUFF_RXDIS, packetNum);

% Disable the receiver radio
warplab_sendCmd(udp_node2, RADIO2_RXDIS, packetNum);

% Disable continous tranmsission mode
TxMode = 0;
warplab_writeRegister(udp_node1,TX_MODE,TxMode);

% Close sockets
pnet('closeall');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 6. Plot the transmitted and received data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
subplot(2,2,1);
plot(real(Node1_Radio2_TxData));
title('Tx Node 1 Radio 2 I');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(2,2,2);
plot(imag(Node1_Radio2_TxData));
title('Tx Node 1 Radio 2 Q');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(2,2,3);
plot(real(Node2_Radio2_RxData));
title('Rx Node 2 Radio 2 I');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(2,2,4);
plot(imag(Node2_Radio2_RxData));
title('Rx Node 2 Radio 2 Q');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
