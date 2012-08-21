%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Transmitting and Receiving Data using WARPLab (2x2 MIMO configuration)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To run this M-code the boards must be programmed with the
% 2x2 MIMO 5.x version of WARPLab bitstream (because this bitstream provides 
% storage of RSSI values and this M-code reads RSSI values). This M-code 
% will work with warplab_mimo_4x4_v05.bit bitstream when read of RSSI 
% values is deleted from the M-code.

% The specific steps implemented in this script are the following

% 0. Initializaton and definition of parameters
% 1. Generate a vector of samples to transmit and send the samples to the 
% WARP board (Sample Frequency is 40MHz)
% 2. Prepare WARP boards for transmission and reception and send trigger to 
% start transmission and reception (trigger is the SYNC packet)
% 3. Read the received samples from the Warp board
% 4. Reset and disable the boards
% 5. Plot the transmitted and received data and close sockets

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
TxDelay = 2000; % Number of noise samples per Rx capture. In [0:2^14]
TxLength = 2^14-1-2000; % Length of transmission. In [0:2^14-1-TxDelay]
TxMode = 0; % Transmission mode. In [0:1] 
            % 0: Single Transmission 
            % 1: Continuous Transmission. Tx board will continue 
            % transmitting the vector of samples until the user manually
            % disables the transmitter. 
CarrierChannel = 12; % Channel in the 2.4 GHz band. In [1:14]
Node1_Radio2_TxGain_BB = 3; % Tx Baseband Gain. In [0:3]
Node1_Radio2_TxGain_RF = 40; % Tx RF Gain. In [0:63]
Node1_Radio3_TxGain_BB = 3; % Tx Baseband Gain. In [0:3]
Node1_Radio3_TxGain_RF = 40; % Tx RF Gain. In [0:63]
Node2_Radio2_RxGain_BB = 15; % Rx Baseband Gain. In [0:31]
Node2_Radio2_RxGain_RF = 1; % Rx RF Gain. In [1:3]  
Node2_Radio3_RxGain_BB = 15; % Rx Baseband Gain. In [0:31]
Node2_Radio3_RxGain_RF = 1; % Rx RF Gain. In [1:3]  
Node2_MGC_AGC_Select = 0;   % Set MGC_AGC_Select=1 to enable Automatic Gain Control (AGC). 
                            % Set MGC_AGC_Select=0 to enable Manual Gain Control (MGC).
                            % By default, the nodes are set to MGC.    

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

% Download 'Node1_Radio2_TxGain_RF', 'Node1_Radio2_TxGain_BB',
% 'Node1_Radio3_TxGain_RF', and 'Node1_Radio3_TxGain_BB' parameters
% to node 1 using the 'warplab_setRadioParameter' function.
% Hints: 
% 1. The first argument of the 'warplab_setRadioParameter' function 
% identifies the node to which the parameter will be downloaded to. 
% The id or handle to node 1 is 'udp_node1'.
% 2. The second argument of the 'warplab_setRadioParameter' function 
% identifies the parameter that will be downloaded. The
% 'Node1_Radio2_TxGain_RF' and 'Node1_Radio2_TxGain_BB' parameters are
% downloaded in one call of the 'warplab_setRadioParameter' and the id to
% download these parameters is 'RADIO2_TXGAINS'. The
% 'Node1_Radio3_TxGain_RF' and 'Node1_Radio3_TxGain_BB' parameters are
% downloaded in one call of the 'warplab_setRadioParameter' and the id to
% download these parameters is 'RADIO3_TXGAINS'. 
% 3. The third argument of the 'warplab_setRadioParameter' function is the
% value the parameter must be set to. The 'Node1_Radio2_TxGain_RF' and 
% 'Node1_Radio2_TxGain_BB' parameters are downloaded in one call of the
% 'warplab_setRadioParameter', these two values must be combined for 
% download in the following way: 
% (Node1_Radio2_TxGain_RF + Node1_Radio2_TxGain_BB*2^16)
% The 'Node1_Radio3_TxGain_RF' and 
% 'Node1_Radio3_TxGain_BB' parameters are downloaded in one call of the
% 'warplab_setRadioParameter', these two values must be combined for 
% download in the following way: 
% (Node1_Radio3_TxGain_RF + Node1_Radio3_TxGain_BB*2^16)
% 4. Call the 'warplab_setRadioParameter' function twice. One time to 
% download the 'Node1_Radio2_TxGain_RF' and 'Node1_Radio2_TxGain_BB' 
% parameters and one time to download the 'Node1_Radio3_TxGain_RF' and 
% 'Node1_Radio3_TxGain_BB' parameters. 
% Node 1 will be set as the transmitter so download Tx gains to node 1.
warplab_setRadioParameter(udp_node1,RADIO2_TXGAINS,(Node1_Radio2_TxGain_RF + Node1_Radio2_TxGain_BB*2^16));
warplab_setRadioParameter(udp_node1,RADIO3_TXGAINS,(Node1_Radio3_TxGain_RF + Node1_Radio3_TxGain_BB*2^16));

% Download 'Node2_Radio2_RxGain_BB', 'Node2_Radio2_RxGain_RF',
% 'Node2_Radio3_RxGain_BB', and 'Node2_Radio3_RxGain_RF' parameters
% to node 2 using the 'warplab_setRadioParameter' function.
% Hints: 
% 1. The first argument of the 'warplab_setRadioParameter' function 
% identifies the node to which the parameter will be downloaded to. 
% The id or handle to node 2 is 'udp_node2'.
% 2. The second argument of the 'warplab_setRadioParameter' function 
% identifies the parameter that will be downloaded. The
% 'Node2_Radio2_RxGain_BB' and 'Node2_Radio2_RxGain_RF' parameters are
% downloaded in one call of the 'warplab_setRadioParameter' and the id to
% download these parameters is 'RADIO2_RXGAINS'. The
% 'Node2_Radio3_RxGain_BB' and 'Node2_Radio3_RxGain_RF' parameters are
% downloaded in one call of the 'warplab_setRadioParameter' and the id to
% download these parameters is 'RADIO3_RXGAINS'
% 3. The third argument of the 'warplab_setRadioParameter' function is the
% value the parameter must be set to. The 'Node2_Radio2_RxGain_BB' and 
% 'Node2_Radio2_RxGain_RF' parameters are downloaded in one call of the
% 'warplab_setRadioParameter', these two values must be combined for 
% download in the following way: 
% (Node2_Radio2_RxGain_BB + Node2_Radio2_RxGain_RF*2^16)
% The 'Node2_Radio3_RxGain_BB' and 
% 'Node2_Radio3_RxGain_RF' parameters are downloaded in one call of the
% 'warplab_setRadioParameter', these two values must be combined for 
% download in the following way: 
% (Node2_Radio3_RxGain_BB + Node2_Radio3_RxGain_RF*2^16)
% 4. Call the 'warplab_setRadioParameter' function twice. One time to 
% download the 'Node2_Radio2_RxGain_BB' and 'Node2_Radio2_RxGain_RF' 
% parameters and one time to download the 'Node2_Radio3_RxGain_BB' and 
% 'Node2_Radio3_RxGain_RF' parameters. 
% Node 2 will be set as the receiver so download Rx gains to node 2.
warplab_setRadioParameter(udp_node2,RADIO2_RXGAINS,(Node2_Radio2_RxGain_BB + Node2_Radio2_RxGain_RF*2^16));
warplab_setRadioParameter(udp_node2,RADIO3_RXGAINS,(Node2_Radio3_RxGain_BB + Node2_Radio3_RxGain_RF*2^16));

% Set MGC mode in node 2 (receiver)
warplab_setAGCParameter(udp_node2,MGC_AGC_SEL, Node2_MGC_AGC_Select);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Generate a vector of samples to transmit and send the samples to the 
% WARP board (Sample Frequency is 40MHz)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Prepare some data to be transmitted
t = 0:(1/40e6):TxLength/40e6 - 1/40e6; % Create time vector

% Create a signal to transmit from radio 2, the signal can be real or complex.
% The signal must meet the following requirements:
% - Signal to transmit must be a row vector.
% - The amplitude of the real part must be in [-1:1] and the amplitude 
% of the imaginary part must be in [-1:1]. 
% - Highest frequency component is limited to 9.5 MHz (signal bandwidth
% is limited to 19 MHz)
% - Lowest frequency component is limited to 30 kHz
Node1_Radio2_TxData = exp(t*j*2*pi*1e6);

% Download the 'Node1_Radio2_TxData' vector to WARP node 1 radio 2 Tx 
% buffer using the 'warplab_writeSMWO' function. The 'Node1_Radio2_TxData' 
% vector is the vector of samples to be transmitted from node 1 radio 2. 
% The id for radio 2 Tx buffer is 'RADIO2_TXDATA'.
warplab_writeSMWO(udp_node1, RADIO2_TXDATA, Node1_Radio2_TxData); % Download samples to 
% radio 2 Tx Buffer

% Create a signal to transmit from radio 3, the signal can be real or complex.
% The signal must meet the following requirements:
% - Signal to transmit must be a row vector.
% - The amplitude of the real part must be in [-1:1] and the amplitude 
% of the imaginary part must be in [-1:1]. 
% - Highest frequency component is limited to 9.5 MHz (signal bandwidth
% is limited to 19 MHz)
% - Lowest frequency component is limited to 30 kHz
Node1_Radio3_TxData = exp(t*j*2*pi*5e6); 

% Download the 'Node1_Radio3_TxData' vector to WARP node 1 radio 3 Tx 
% buffer using the 'warplab_writeSMWO' function. The 'Node1_Radio3_TxData' 
% vector is the vector of samples to be transmitted from node 1 radio 3. 
% The id for radio 3 Tx buffer is 'RADIO3_TXDATA'.
warplab_writeSMWO(udp_node1, RADIO3_TXDATA, Node1_Radio3_TxData); % Download samples to 
% radio 3 Tx Buffer

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Prepare WARP boards for transmission and reception and send trigger to 
% start transmission and reception (trigger is the SYNC packet)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The following lines of code set node 1 as transmitter and node 2 as
% receiver; transmission and capture are triggered by sending the SYNC
% packet.

% Enable transmitter radio path in radios 2 and 3 in node 1 (enable radio 2 
% and radio 3 in node 1 as transmitters) by sending the RADIO2_TXEN and 
% RADIO3_TXEN commands to node 1 using
% the 'warplab_sendCmd' function. To send the RADIO2_TXEN
% and RADIO3_TXEN commands in one call of the 'warplab_sendCmd' function
% the second argument of the 'warplab_sendCmd' function can be a vector of
% the commands: [RADIO2_TXEN, RADIO3_TXEN]
warplab_sendCmd(udp_node1, [RADIO2_TXEN, RADIO3_TXEN], packetNum);

% Enable transmission of node1's radio 2 and radio 3 Tx buffer (enable 
% transmission of samples stored in radio 2 Tx Buffer and in radio 3 Tx 
% Buffer in node 1) by sending the RADIO2TXBUFF_TXEN and 
% RADIO3TXBUFF_TXEN commands to node 1 using
% the 'warplab_sendCmd' function. To send the
% RADIO2TXBUFF_TXEN and RADIO3TXBUFF_TXEN commands in one call of the 
% 'warplab_sendCmd' function the second argument of the 'warplab_sendCmd'
% function can be a vector of
% the commands: [RADIO2TXBUFF_TXEN, RADIO3TXBUFF_TXEN]
warplab_sendCmd(udp_node1, [RADIO2TXBUFF_TXEN, RADIO3TXBUFF_TXEN], packetNum);

% Enable receiver radio path in radios 2 and 3 in node 2 (enable radios 2 
% and 3 in node 2 as receivers) by sending the 'RADIO2_RXEN' and
% 'RADIO3_RXEN' ommands to node 2 using 'warplab_sendCmd' function.
% To send the  RADIO2_RXEN and RADIO3_RXEN commands in one call of the 
% 'warplab_sendCmd' function the second argument of the 'warplab_sendCmd' 
% function can be a vector of
% the commands: [RADIO2_RXEN, RADIO3_RXEN]
warplab_sendCmd(udp_node2, [RADIO2_RXEN, RADIO3_RXEN], packetNum);

% Enable capture in node2's radio 2 and radio 3 Rx Buffer (enable radio 2 
% Rx buffer and radio 3 Rx buffer in node 2 for storage of samples) by 
% sending the 'RADIO2RXBUFF_RXEN' and 'RADIO3RXBUFF_RXEN' commands to node 2 
% using 'warplab_sendCmd' function. To send the
% RADIO2RXBUFF_RXEN and RADIO3RXBUFF_RXEN commands in one call of the 
% 'warplab_sendCmd' function the second argument of the 'warplab_sendCmd' 
% function can be a vector of
% the commands: [RADIO2RXBUFF_RXEN, RADIO3RXBUFF_RXEN]
warplab_sendCmd(udp_node2, [RADIO2RXBUFF_RXEN, RADIO3RXBUFF_RXEN], packetNum);


% Prime transmitter state machine in node 1 by sending the TX_START command
% to node 1 using the 'warplab_sendCmd' function. 
% Node 1 will start waiting for the SYNC packet as soon as it receives the 
% TX_START command. Transmission from node 1 will be triggered when node 1 
% receives the SYNC packet.
warplab_sendCmd(udp_node1, TX_START, packetNum);

% Prime receiver state machine in node 2 by sending the RX_START command
% to node 2 using the 'warplab_sendCmd' function. 
% Node 2 will start waiting for the SYNC packet as soon as it receives the 
% RX_START command. Capture on node 2 will be triggered when node 2 
% receives the SYNC packet.
warplab_sendCmd(udp_node2, RX_START, packetNum);

% Send the SYNC packet
warplab_sendSync(udp_Sync);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Read the received samples from the Warp board
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read the received samples from the WARP node 2 radio 2 Rx buffer using the 
% 'warplab_readSMRO' function.  Store the samples in a variable named
% 'Node2_Radio2_RawRxData'. The id for radio 2 Rx buffer is 'RADIO2_RXDATA'.
% For this exercise the third argument of the 'warplab_readSMRO' 
% function must be equal to 'TxLength+TxDelay', since TxLength is the
% number of samples that were transmitted and the first TxDelay samples
% that were captured correspond to noise samples captured before the data 
% was transmitted.
[Node2_Radio2_RawRxData] = warplab_readSMRO(udp_node2, RADIO2_RXDATA, TxLength+TxDelay);


% Read the received samples from the WARP node 2 radio 3 Rx buffer using the 
% 'warplab_readSMRO' function.  Store the samples in a variable named
% 'Node2_Radio3_RawRxData'. The id for radio 3 Rx buffer is 'RADIO3_RXDATA'.
% For this exercise the third argument of the 'warplab_readSMRO' 
% function must be equal to 'TxLength+TxDelay', since TxLength is the
% number of samples that were transmitted and the first TxDelay samples
% that were captured correspond to noise samples captured before the data 
% was transmitted.
[Node2_Radio3_RawRxData] = warplab_readSMRO(udp_node2, RADIO3_RXDATA, TxLength+TxDelay);

% Process the received samples to obtain meaningful data
[Node2_Radio2_RxData,Node2_Radio2_RxOTR] = warplab_processRawRxData(Node2_Radio2_RawRxData);
[Node2_Radio3_RxData,Node2_Radio3_RxOTR] = warplab_processRawRxData(Node2_Radio3_RawRxData);
% Read stored RSSI data from radio 2
[Node2_Radio2_RawRSSIData] = warplab_readSMRO(udp_node2, RADIO2_RSSIDATA, ceil((TxLength+TxDelay)/8));
% Read stored RSSI data from radio 3
[Node2_Radio3_RawRSSIData] = warplab_readSMRO(udp_node2, RADIO3_RSSIDATA, ceil((TxLength+TxDelay)/8));
% Procecss Raw RSSI data to obtain meningful RSSI values
[Node2_Radio2_RSSIData] = warplab_processRawRSSIData(Node2_Radio2_RawRSSIData);
[Node2_Radio3_RSSIData] = warplab_processRawRSSIData(Node2_Radio3_RawRSSIData);
% Note: If the four lines of code above (warplab_processRawRSSIData lines and
% warplab_readSMRO(udp_node2, RADIO2_RSSIDATA, (TxLength+TxDelay)/8) line
% and warplab_readSMRO(udp_node2, RADIO3_RSSIDATA, (TxLength+TxDelay)/8) line)
% are deleted, then the code will work when the boards are programmed
% with the warplab_mimo_4x4_v04.bit bitstream)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Reset and disable the boards
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set radios 2 and 3 Tx buffer in node 1 back to Tx disabled mode
warplab_sendCmd(udp_node1, [RADIO2TXBUFF_TXDIS RADIO3TXBUFF_TXDIS], packetNum);

% Disable the transmitter radios
warplab_sendCmd(udp_node1, [RADIO2_TXDIS, RADIO3_TXDIS], packetNum);

% Set radios 2 and 3 Rx buffer in node 2 back to Rx disabled mode
warplab_sendCmd(udp_node2, [RADIO2RXBUFF_RXDIS, RADIO3RXBUFF_RXDIS], packetNum);

% Disable the receiver radios
warplab_sendCmd(udp_node2, [RADIO2_RXDIS,RADIO3_RXDIS], packetNum);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. Plot the transmitted and received data and close sockets
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
subplot(4,2,1);
plot(real(Node1_Radio2_TxData));
title('Tx Node 1 Radio 2 I');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(4,2,2);
plot(imag(Node1_Radio2_TxData));
title('Tx Node 1 Radio 2 Q');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(4,2,3);
plot(real(Node1_Radio3_TxData));
title('Tx Node 1 Radio 3 I');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(4,2,4);
plot(imag(Node1_Radio3_TxData));
title('Tx Node 1 Radio 3 Q');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(4,2,5);
plot(real(Node2_Radio2_RxData));
title('Rx Node 2 Radio 2 I');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(4,2,6);
plot(imag(Node2_Radio2_RxData));
title('Rx Node 2 Radio 2 Q');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(4,2,7);
plot(real(Node2_Radio3_RxData));
title('Rx Node 2 Radio 3 I');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(4,2,8);
plot(imag(Node2_Radio3_RxData));
title('Rx Node 2 Radio 3 Q');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.

% Close sockets
pnet('closeall');
