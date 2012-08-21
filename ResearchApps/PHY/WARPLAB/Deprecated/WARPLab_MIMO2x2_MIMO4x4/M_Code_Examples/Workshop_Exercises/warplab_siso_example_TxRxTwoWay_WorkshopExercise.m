%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Two-Way transmission and reception of data using WARPLab(SISO configuration)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Use WARPLab for two-way communication between two nodes. First node 1 
% will transmit to node 2 and then node 2 will transmit to node 1.

% The specific steps implemented in this script are the following

% 0. Initializaton and definition of parameters
% 1. Generate the vector of samples that node 1 will transmit to node 2 and
% the vector of samples that node 2 will transmit to node 1, then download 
% the samples to the WARP boards (Sample Frequency is 40MHz)
% 2. Prepare WARP boards for transmission and reception from node 1 to node 2 
% and send trigger to start transmission and reception (trigger is the SYNC
% packet)
% 3. Disable the radios
% 4. Prepare WARP boards for transmission and reception from node 2 to node 1 
% and send trigger to start transmission and reception (trigger is the SYNC
% packet)
% 5. Disable the radios
% 6. Read the received samples from the WARP boards 
% 7. Reset the boards 
% 8. Plot the transmitted and received data and close sockets

% In this lab exercise you will write a matlab script that implements the
% nine steps above. Part of the code is provided, some part of the code you
% will write. Read the code below and fill in with your code wherever you 
% are asked to do so.

% NOTE: To avoid conflict with other groups using the boards, please test 
% the code you write in this script in any of the following three ways:
%
% Option 1. Run this script from matlab's Command Window by entering the 
% name of the script (enter warplab_example_TxRx_WorkshopExercise in 
% matlab's Command Window).
% Option 2. In the menu bar go to Debug and select Run. If there
% are errors in the code, error messages will appear in the Command Window.
% Option 3. Press F5. If the are errors in the code, error messages will 
% appear in the Command Window.
%
% DO NOT USE the Evaluate selection option and DO NOT run the script by
% sections. To test any change, always run the whole script by following 
% any of the three options above.

try,
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Code to avoid conflict between users, only needed for the workshop, go to
% step 0 below to start the initialization and definition of parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid = fopen('c:\boards_lock.txt');

if(fid > -1)
    fclose('all');
	errordlg('Boards already in use - Please try again!');
	return;
end

!echo > c:\boards_lock.txt

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
%-------------------------------------------------------------------------%
% USER CODE HERE

% Create the following variables and assign them valid values: 
% Node1_CaptOffset:  Number of noise samples per Rx capture in node 1. In [0:2^14]
% Node2_CaptOffset: Number of noise samples per Rx capture in node 2. In [0:2^14]
% Node1_TxLength: Length of transmission from node 1. In [0:2^14-1-Node2_CaptOffset]
% Node2_TxLength: Length of transmission from node 2. In [0:2^14-1-Node1_CaptOffset]
% CarrierChannel = 8; % Channel in the 2.4 GHz band. In [1:14]
% Node1_Radio2_TxGain_BB = 3; % Tx Baseband Gain Node1 Radio2. In [0:3]
% Node1_Radio2_TxGain_RF = 40; % Tx RF Gain Node1 Radio2. In [0:63]
% Node1_Radio2_RxGain_BB = 13; % Rx Baseband Gain Node1 Radio2. In [0:31]
% Node1_Radio2_RxGain_RF = 1; % Rx RF Gain Node1 Radio2. In [1:3]
% Node2_Radio2_TxGain_BB = 3; % Tx Baseband Gain Node2 Radio2. In [0:3]
% Node2_Radio2_TxGain_RF = 40; % Tx RF Gain Node2 Radio2. In [0:63] 
% Node2_Radio2_RxGain_BB = 13; % Rx Baseband Gain Node2 Radio2. In [0:31]
% Node2_Radio2_RxGain_RF = 1; % Rx RF Gain Node2 Radio2. In [1:3]  

%-------------------------------------------------------------------------%

TxMode = 0; % Transmission mode. In [0:1] 
            % 0: Single Transmission 
            % 1: Continuous Transmission. Tx board will continue 
            % transmitting the vector of samples until the user manually
            % disables the transmitter. 

% Download the WARPLab parameters to the WARP nodes. 
% The nodes store the CaptOffset, TxLength, and TxMode parameters in 
% registers defined in the WARPLab sysgen model. The nodes set radio 
% related parameters CarrierChannel, TxGains, and RxGains, using the 
% radio controller functions.
% Download parameters to node 1
warplab_writeRegister(udp_node1,CAPT_OFFSET,Node1_CaptOffset);
warplab_writeRegister(udp_node1,TX_LENGTH,Node1_TxLength);
warplab_writeRegister(udp_node1,TX_MODE,TxMode);
warplab_setRadioParameter(udp_node1,CARRIER_CHANNEL,CarrierChannel);

%-------------------------------------------------------------------------%
% USER CODE HERE

% Download 'Node1_Radio2_TxGain_RF' and 'Node1_Radio2_TxGain_BB' parameters
% to node 1 using the 'warplab_setRadioParameter' function.

% Hints: 

% 1. The first argument of the 'warplab_setRadioParameter' function 
% identifies the node to which the parameter will be downloaded to. 
% The id or handle to node 1 is 'udp_node1'.

% 2. The second argument of the 'warplab_setRadioParameter' function 
% identifies the parameter that will be downloaded. The
% 'Node1_Radio2_TxGain_RF' and 'Node1_Radio2_TxGain_BB' parameters are
% downloaded in one call of the 'warplab_setRadioParameter' and the id to
% download these parameters is 'RADIO2_TXGAINS'

% 3. The third argument of the 'warplab_setRadioParameter' function is the
% value the parameter must be set to. The 'Node1_Radio2_TxGain_RF' and 
% 'Node1_Radio2_TxGain_BB' parameters are downloaded in one call of the
% 'warplab_setRadioParameter', these two values must be combined for 
% download in the following way: 
% (Node1_Radio2_TxGain_RF + Node1_Radio2_TxGain_BB*2^16)

% 4. The 'warplab_setRadioParameter' function has been used in previous
% exercises.

%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% USER CODE HERE

% Download 'Node1_Radio2_RxGain_BB' and 'Node1_Radio2_RxGain_RF' parameters
% to node 1 using the 'warplab_setRadioParameter' function.

% Hints: 

% 1. The first argument of the 'warplab_setRadioParameter' function 
% identifies the node to which the parameter will be downloaded to. 
% The id or handle to node 1 is 'udp_node1'.

% 2. The second argument of the 'warplab_setRadioParameter' function 
% identifies the parameter that will be downloaded. The
% 'Node1_Radio2_RxGain_BB' and 'Node1_Radio2_RxGain_RF' parameters are
% downloaded in one call of the 'warplab_setRadioParameter' and the id to
% download these parameters is 'RADIO2_RXGAINS'

% 3. The third argument of the 'warplab_setRadioParameter' function is the
% value the parameter must be set to. The 'Node1_Radio2_RxGain_BB' and 
% 'Node1_Radio2_RxGain_RF' parameters are downloaded in one call of the
% 'warplab_setRadioParameter', these two values must be combined for 
% download in the following way: 
% (Node1_Radio2_RxGain_BB + Node1_Radio2_RxGain_RF*2^16)

% 4. The 'warplab_setRadioParameter' function has been used in previous
% exercises.

%-------------------------------------------------------------------------%

% Download parameters to node 2
warplab_writeRegister(udp_node2,CAPT_OFFSET,Node2_CaptOffset);
warplab_writeRegister(udp_node2,TX_LENGTH,Node2_TxLength);
warplab_writeRegister(udp_node2,TX_MODE,TxMode);
warplab_setRadioParameter(udp_node2,CARRIER_CHANNEL,CarrierChannel);

%-------------------------------------------------------------------------%
% USER CODE HERE

% Download 'Node2_Radio2_TxGain_RF' and 'Node2_Radio2_TxGain_BB' parameters
% to node 2 using the 'warplab_setRadioParameter' function.

% Hints: 

% 1. The first argument of the 'warplab_setRadioParameter' function 
% identifies the node to which the parameter will be downloaded to. 
% The id or handle to node 2 is 'udp_node2'.

% 2. The second argument of the 'warplab_setRadioParameter' function 
% identifies the parameter that will be downloaded. The
% 'Node2_Radio2_TxGain_RF' and 'Node2_Radio2_TxGain_BB' parameters are
% downloaded in one call of the 'warplab_setRadioParameter' and the id to
% download these parameters is 'RADIO2_TXGAINS'

% 3. The third argument of the 'warplab_setRadioParameter' function is the
% value the parameter must be set to. The 'Node2_Radio2_TxGain_RF' and 
% 'Node2_Radio2_TxGain_BB' parameters are downloaded in one call of the
% 'warplab_setRadioParameter', these two values must be combined for 
% download in the following way: 
% (Node2_Radio2_TxGain_RF + Node2_Radio2_TxGain_BB*2^16)

% 4. The 'warplab_setRadioParameter' function has been used in previous
% exercises.

%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% USER CODE HERE

% Download 'Node2_Radio2_RxGain_BB' and 'Node2_Radio2_RxGain_RF' parameters
% to node 2 using the 'warplab_setRadioParameter' function.

% Hints: 

% 1. The first argument of the 'warplab_setRadioParameter' function 
% identifies the node to which the parameter will be downloaded to. 
% The id or handle to node 2 is 'udp_node2'.

% 2. The second argument of the 'warplab_setRadioParameter' function 
% identifies the parameter that will be downloaded. The
% 'Node2_Radio2_RxGain_BB' and 'Node2_Radio2_RxGain_RF' parameters are
% downloaded in one call of the 'warplab_setRadioParameter' and the id to
% download these parameters is 'RADIO2_RXGAINS'

% 3. The third argument of the 'warplab_setRadioParameter' function is the
% value the parameter must be set to. The 'Node2_Radio2_RxGain_BB' and 
% 'Node2_Radio2_RxGain_RF' parameters are downloaded in one call of the
% 'warplab_setRadioParameter', these two values must be combined for 
% download in the following way: 
% (Node2_Radio2_RxGain_BB + Node2_Radio2_RxGain_RF*2^16)

% 4. The 'warplab_setRadioParameter' function has been used in previous
% exercises.

%-------------------------------------------------------------------------%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Generate the vector of samples that node 1 will transmit to node 2 and
% the vector of samples that node 2 will transmit to node 1, then download 
% the samples to the WARP boards (Sample Frequency is 40MHz)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create time vector.
t1 = 0:(1/40e6):Node1_TxLength/40e6 - 1/40e6; 

% Create a signal to transmit from node 1, the signal can be real or complex.
% The signal must meet the following requirements:
% - Signal to transmit must be a row vector.
% - The amplitude of the real part must be in [-1:1] and the amplitude 
% of the imaginary part must be in [-1:1]. 
% - Highest frequency component is limited to 9.5 MHz (signal bandwidth
% is limited to 19 MHz)
% - Lowest frequency component is limited to 30 kHz
Node1_Radio2_TxData = exp(t1*j*2*pi*1e6);

%-------------------------------------------------------------------------%
% USER CODE HERE
% Download the 'Node1_Radio2_TxData' vector to WARP node 1 using the 
% 'warplab_writeSMWO' function. The 'Node1_Radio2_TxData' vector is the
% vector of samples to be transmitted from node 1 to node 2. The 
% 'warplab_writeSMWO' function has been used in previous exercises and a 
% description of the input arguments of this function can be found in the 
% 'warplab_example_ChannelEstim_WorkshopExercise.m' code

%-------------------------------------------------------------------------%

% Create time vector.
t2 = 0:(1/40e6):Node2_TxLength/40e6 - 1/40e6;

% Create a signal to transmit from node 2, the signal can be real or complex.
% The signal must meet the following requirements:
% - Signal to transmit must be a row vector.
% - The amplitude of the real part must be in [-1:1] and the amplitude 
% of the imaginary part must be in [-1:1]. 
% - Signal bandwidth must be less than 19 MHz (Highest frequency component 
% is limited to 9.5 MHz due to radio settings)
Node2_Radio2_TxData = linspace(0,1,Node2_TxLength).*exp(t2*j*2*pi*5e6); 

%-------------------------------------------------------------------------%
% USER CODE HERE
% Download the 'Node2_Radio2_TxData' vector to WARP node 2 using the 
% 'warplab_writeSMWO' function. The 'Node2_Radio2_TxData' vector is the
% vector of samples to be transmitted from node 2 to node 1. The 
% 'warplab_writeSMWO' function has been used in previous exercises and a 
% description of the input arguments of this function can be found in the 
% 'warplab_example_ChannelEstim_WorkshopExercise.m' code

%-------------------------------------------------------------------------%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Prepare WARP boards for transmission and reception from node 1 to node 2 
% and send trigger to start transmission and reception (trigger is the SYNC
% packet)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The following lines of code set node 1 as transmitter and node 2 as
% receiver; transmission and capture are triggered by sending the SYNC
% packet.

%-------------------------------------------------------------------------%
% USER CODE HERE
% Enable transmitter radio path in radio 2 in node 1 (enable radio 2 in 
% node 1 as transmitter) by sending the RADIO2_TXEN command to node 1 using
% the 'warplab_sendCmd' function. The 'warplab_sendCmd' function has been 
% used in previous exercises and a description of the input arguments of 
% this function can be found in the 
% 'warplab_example_Comm_WorkshopExercise.m' code

%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% USER CODE HERE
% Enable transmission of node1's radio 2 Tx buffer (enable transmission
% of samples stored in radio 2 Tx Buffer in node 1) by sending the 
% RADIO2TXBUFF_TXEN command to node 1 using the 'warplab_sendCmd' function.
% The 'warplab_sendCmd' function has been used in previous exercises and 
% a description of the input arguments of this function can be found in the 
% 'warplab_example_Comm_WorkshopExercise.m' code

%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% USER CODE HERE
% Enable receiver radio path in radio 2 in node 2 (enable radio 2 in
% node 2 as receiver) by sending the RADIO2_RXEN command to node 2 using
% the 'warplab_sendCmd' function. 
% The 'warplab_sendCmd' function has been used in previous exercises and 
% a description of the input arguments of this function can be found in the 
% 'warplab_example_Comm_WorkshopExercise.m' code

%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% USER CODE HERE

% Enable capture in node2's radio 2 Rx Buffer (enable radio 2 rx buffer in
% node 2 for storage of samples) by sending the RADIO2RXBUFF_RXEN command to 
% node 2 using the 'warplab_sendCmd' function.
% The 'warplab_sendCmd' function has been used in previous exercises and 
% a description of the input arguments of this function can be found in the 
% 'warplab_example_Comm_WorkshopExercise.m' code

%-------------------------------------------------------------------------%

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
% 3. Disable the radios
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Disable the transmitter
warplab_sendCmd(udp_node1, RADIO2_TXDIS, packetNum);

% Disable the receiver
warplab_sendCmd(udp_node2, RADIO2_RXDIS, packetNum);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Prepare boards for transmission and reception from node 2 to node 1 
% and send trigger to start transmission and reception (trigger is the SYNC
% packet)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The following lines of code set node 2 as transmitter and node 1 as
% receiver; transmission and capture are triggered by sending the SYNC
% packet.

%-------------------------------------------------------------------------%
% USER CODE HERE
% Enable transmitter radio path in radio 2 in node 2 (enable radio 2 in 
% node 2 as transmitter) by sending the RADIO2_TXEN command to node 2 using
% the 'warplab_sendCmd' function. The 'warplab_sendCmd' function has been 
% used in previous exercises and a description of the input arguments of 
% this function can be found in the 
% 'warplab_example_Comm_WorkshopExercise.m' code

%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% USER CODE HERE
% Enable transmission of node2's radio 2 Tx buffer (enable transmission
% of samples stored in radio 2 Tx Buffer in node 2) by sending the 
% RADIO2TXBUFF_TXEN command to node 2 using the 'warplab_sendCmd' function.
% The 'warplab_sendCmd' function has been used in previous exercises and 
% a description of the input arguments of this function can be found in the 
% 'warplab_example_Comm_WorkshopExercise.m' code

%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% USER CODE HERE
% Enable receiver radio path in radio 2 in node 1 (enable radio 2 in
% node 1 as receiver) by sending the RADIO2_RXEN command to node 1 using
% the 'warplab_sendCmd' function. 
% The 'warplab_sendCmd' function has been used in previous exercises and 
% a description of the input arguments of this function can be found in the 
% 'warplab_example_Comm_WorkshopExercise.m' code

%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% USER CODE HERE

% Enable capture in node1's radio 2 Rx Buffer (enable radio 2 rx buffer in
% node 1 for storage of samples) by sending the RADIO2RXBUFF_RXEN command to 
% node 1 using the 'warplab_sendCmd' function.
% The 'warplab_sendCmd' function has been used in previous exercises and 
% a description of the input arguments of this function can be found in the 
% 'warplab_example_Comm_WorkshopExercise.m' code

%-------------------------------------------------------------------------%

% Prime transmitter state machine in node 2. Node 2 will be 
% waiting for the SYNC packet. Transmission from node 2 will be triggered 
% when node 2 receives the SYNC packet.
warplab_sendCmd(udp_node2, TX_START, packetNum);

% Prime receiver state machine in node 1. Node 1 will be waiting 
% for the SYNC packet. Capture at node 1 will be triggered when node 1 
% receives the SYNC packet.
warplab_sendCmd(udp_node1, RX_START, packetNum);

% Send the SYNC packet
warplab_sendSync(udp_Sync);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. Disable the radios
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Disable the receiver
warplab_sendCmd(udp_node1, RADIO2_RXDIS, packetNum);

% Disable the transmitter
warplab_sendCmd(udp_node2, RADIO2_TXDIS, packetNum);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 6. Read the received samples from the WARP boards 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read back the received samples sent from node 1 to node 2
[Node2_Radio2_RawRxData] = warplab_readSMRO(udp_node2, RADIO2_RXDATA, Node1_TxLength+Node2_CaptOffset);
% Process the received samples to obtain meaningful data
[Node2_Radio2_RxData,Node2_Radio2_RxOTR] = warplab_processRawRxData(Node2_Radio2_RawRxData);

% Read back the received samples sent from node 2 to node 1
[Node1_Radio2_RawRxData] = warplab_readSMRO(udp_node1, RADIO2_RXDATA, Node2_TxLength+Node1_CaptOffset);
% Process the received samples to obtain meaningful data
[Node1_Radio2_RxData,Node1_Radio2_RxOTR] = warplab_processRawRxData(Node1_Radio2_RawRxData);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 7. Reset the boards
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set radio 2 Tx buffer in node 1 back to Tx disabled mode
warplab_sendCmd(udp_node1, RADIO2TXBUFF_TXDIS, packetNum);

% Set radio 2 Tx buffer in node 2 back to Tx disabled mode
warplab_sendCmd(udp_node2, RADIO2TXBUFF_TXDIS, packetNum);

% Let node 1 know that samples have been read and system is ready for
% a new capture
warplab_sendCmd(udp_node1, RX_DONEREADING, packetNum);

% Let node 2 know that samples have been read and system is ready for
% a new capture
warplab_sendCmd(udp_node2, RX_DONEREADING, packetNum);

% Set radio 2 Rx buffer in node 1 back to Rx disabled mode
warplab_sendCmd(udp_node1, RADIO2RXBUFF_RXDIS, packetNum);

% Set radio 2 Rx buffer in node 2 back to Rx disabled mode
warplab_sendCmd(udp_node2, RADIO2RXBUFF_RXDIS, packetNum);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. Plot the transmitted and received data and close sockets
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot data corresponding to node 1 to node 2 transmission
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

% Plot data from B to A transmission
figure;
subplot(2,2,1);
plot(real(Node2_Radio2_TxData));
title('Tx Node 2 Radio 2 I');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(2,2,2);
plot(imag(Node2_Radio2_TxData));
title('Tx Node 2 Radio 2 Q');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(2,2,3);
plot(real(Node1_Radio2_RxData));
title('Rx Node 1 Radio 2 I');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(2,2,4);
plot(imag(Node1_Radio2_RxData));
title('Rx Node 1 Radio 2 Q');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.

% Close sockets
pnet('closeall');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Code to avoid conflict between users, only needed for the workshop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pnet('closeall');
!del c:\boards_lock.txt
catch,
% Reset nodes
warplab_reset2x2Node(udp_node1);
warplab_reset2x2Node(udp_node2);
% Close sockets
pnet('closeall');
!del c:\boards_lock.txt
lasterr
end