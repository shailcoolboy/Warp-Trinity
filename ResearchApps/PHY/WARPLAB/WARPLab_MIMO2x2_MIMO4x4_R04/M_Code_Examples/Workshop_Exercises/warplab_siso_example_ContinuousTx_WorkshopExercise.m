%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Transmit sum of two sinusoids in Continous Transmission mode using WARPLab
% (SISO configuration)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To run this code the boards must be programmed with the
% warplab_mimo_2x2_v04.bit bitstream (warplab_mimo_4x4_v04.bit does not 
% allow continuous transmission mode).

% The specific steps implemented in this script are the following

% 0. Initializaton and definition of parameters
% 1. Generate a vector of samples to transmit and send the samples to the 
% WARP board (Sample Frequency is 40MHz).  Vector represents a sum of two 
% sinusoids with different frequency.
% 2. Prepare WARP boards for transmission and reception and send trigger to 
% start transmission and reception (trigger is the SYNC packet)
% 3. Leave continuous transmitter on for n seconds and then stop continuous
% transmission.
% 4. Read the received samples from the WARP board.
% 5. Reset and disable the boards.
% 6. Plot the first 2^14 received samples and close sockets

% In this lab exercise you will write a matlab script that implements the
% seven steps above. Part of the code is provided, some part of the code you
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
% TxDelay: Value of the Transmitter Delay. In continuous transmission mode
%             the receiver captures TxDelay samples of noise and the
%             first 2^14-TxDelay samples of data.
% TxLength : Length of transmission or number of samples to transmit. 
%            In [0:2^14-TxDelay]
%            In continuous transmission mode the Tx will continue
%            transmitting the first TxLength samples in the Tx buffer until
%            the user manually disables the transmitter.
% TxMode: % Transmission mode. In [0:1] 
           % 0: Single Transmission 
           % 1: Continuous Transmission. Tx board will continue 
           % transmitting the vector of samples until the user manually
           % disables the transmitter. 
           % For this exercise set TxMode = 1;
% CarrierChannel: Channel in the 2.4 GHz band. In [1:14]
% Node1_Radio2_TxGain_BB: Tx Baseband Gain. In [0:3]
% Node1_Radio2_TxGain_RF: Tx RF Gain. In [0:63]
% Node2_Radio2_RxGain_BB: Rx Baseband Gain. In [0:31]
% Node2_Radio2_RxGain_RF: Rx RF Gain. In [1:3]  

% Note: For this experiment node 1 will be set as the transmitter and node 
% 2 will be set as the receiver (this is done later in the code), hence, 
% there is no need to define receive gains for node 1 and there is no
% need to define transmitter gains for node 2.


%-------------------------------------------------------------------------%

% Download the WARPLab parameters to the WARP nodes. 
% The nodes store the TxDelay, TxLength, and TxMode parameters in 
% registers defined in the WARPLab sysgen model. The nodes set radio 
% related parameters CarrierChannel, TxGains, and RxGains, using the 
% radio controller functions.

%-------------------------------------------------------------------------%
% USER CODE HERE

% Download the TxDelay, TxLength, and TxMode parameters to node 1 using the 
% 'warplab_writeRegister' function.

% The TxDelay, TxLength, and TxMode parameters need to be known at the transmitter;
% the receiver doesn't require knowledge of these parameters (the receiver
% will always capture 2^14 samples). For this exercise node 1 will be set as
% the transmitter (this is done later in the code). Since TxDelay, TxLength and
% TxMode are only required at the transmitter download the TxDelay, TxLength and
% TxMode parameters only to the transmitter node (node 1).

% Hints: 

% 1. The first argument of the 'warplab_writeRegister' function identifies 
% the node to which the parameter will be downloaded to. The id or handle 
% to node 1 is 'udp_node1'.

% 2. The second argument of the 'warplab_writeRegister' function identifies 
% the parameter that will be downloaded. The id for the TxDelay
% parameter is 'TX_DELAY, the id for the TxLength parameter is 'TX_LENGTH' 
% and the id for the TxMode parameter is 'TX_MODE'.

% 3. The third argument of the 'warplab_writeRegister' function is the
% value the parameter must be set to. The values to download have been
% stored in the 'TxDelay', 'TxLength', and 'TxMode' variables.

% 4. The 'warplab_writeRegister' function has been used in previous
% exercises.

% 5. Call the 'warplab_writeRegister' three times. One time to download the
% TxDelay, one time to download the TxLength, and one time to download the 
% TxMode. The 'warplab_writeRegister' function can only set one register (parameter) per node at a time


%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% USER CODE HERE

% Download the CarrierChannel parameter to both nodes using the 
% 'warplab_setRadioParameter' function.

% The CarrierChannel parameter must be downloaded to all nodes  

% Hints: 

% 1. The first argument of the 'warplab_setRadioParameter' function 
% identifies the node to which the parameter will be downloaded to. 
% The id or handle to node 1 is 'udp_node1' and the id or handle to node 2
% is 'udp_node2'

% 2. The second argument of the 'warplab_setRadioParameter' function 
% identifies the parameter that will be downloaded. The id for the
% CarrierChannel parameter is 'CARRIER_CHANNEL'

% 3. The third argument of the 'warplab_setRadioParameter' function is the
% value the parameter must be set to. This value has been stored in the
% CarrierChannel variable. 

% 4. The 'warplab_setRadioParameter' function has been used in previous
% exercises.

% 5. Call the 'warplab_setRadioParameter' twice. One time to download the
% CarrierChannel to node 1 and one time to download the CarrierChannel to 
% node 2. The 'warplab_setRadioParameter' function can only set one 
% radio parameter per node at a time


%-------------------------------------------------------------------------%

% Node 1 will be set as the transmitter so download Tx gains to node 1.
warplab_setRadioParameter(udp_node1,RADIO2_TXGAINS,(Node1_Radio2_TxGain_RF + Node1_Radio2_TxGain_BB*2^16));
% Node 2 will be set as the receiver so download Rx gains to node 2.
warplab_setRadioParameter(udp_node2,RADIO2_RXGAINS,(Node2_Radio2_RxGain_BB + Node2_Radio2_RxGain_RF*2^16));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Generate a vector of samples to transmit and send the samples to the 
% WARP board (Sample Frequency is 40MHz).  Vector represents a sum of two 
% sinusoids with different frequency.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Prepare some data to be transmitted
t = 0:(1/40e6):TxLength/40e6 - 1/40e6; % Create time vector.

% Create a signal to transmit, the signal can be real or complex.
% The signal must meet the following requirements:
% - Signal to transmit must be a row vector.
% - The amplitude of the real part must be in [-1:1] and the amplitude 
% of the imaginary part must be in [-1:1]. 
% - Highest frequency component is limited to 9.5 MHz (signal bandwidth
% is limited to 19 MHz)
% - Lowest frequency component is limited to 30 kHz
f1 = 1e6; 
f2 = 6e6;
Node1_Radio2_TxData = exp(t*j*2*pi*f1)+exp(t*j*2*pi*f2); % Create a signal to transmit. 
% Signal is the sum of two sinusoids with frequencies f1 and f2.

% Scale signal so that amplitude of the real and 
% imaginary part is in [-1:1]. We want the signal to span [-1,1] range
% so it uses the full range of the DAC at the tranmitter.
scale = 1 / max( [ max(real(Node1_Radio2_TxData)) , max(imag(Node1_Radio2_TxData)) ] );
Node1_Radio2_TxData = scale*Node1_Radio2_TxData; 

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
warplab_sendCmd(udp_node1, RADIO2TXBUFF_TXEN, packetNum);

% Enable receiver radio path in radio 2 in node 2 (enable radio 2 in
% node 2 as receiver)
warplab_sendCmd(udp_node2, RADIO2_RXEN, packetNum);

% Enable capture in node2's radio 2 Rx Buffer (enable radio 2 rx buffer in
% node 2 for storage of samples)
warplab_sendCmd(udp_node2, RADIO2RXBUFF_RXEN, packetNum);

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
% transmission
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-------------------------------------------------------------------------%
% USER CODE HERE

% Use matlab's pause command to pause execution for n seconds. Because you
% are sharing the board with other users, please pause for only less than 5
% seconds: n < 5

% To learn more about the pause function enter 'help pause' in the Matlab
% command window.

% IMPORTANT: Use pause(n) (with an argument). If you just use pause it will
% pause until you press a key, since you are sharing the boards with other 
% users it is better to use pause(n) to avoid one user retaining the boards
% for too long. 


%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% USER CODE HERE

% Stop transmission by sending the TX_STOP command using the 
% 'warplab_sendCmd' function. This function has been used in all the
% previous exercises.

% Hints:

% 1. The first argument of the 'warplab_sendCmd' function identifies the
% node to which the command will be sent. The TX_STOP command must be sent
% to the transmitter node so use 'udp_node1' as the first argument. 

% 2. The second argument of the 'warplab_sendCmd' function identifies the
% instruction or command to be sent. In this case, the command to send is 
% the TX_STOP command.

% 3. The third argument of the 'warplab_sendCmd' command is a field that is
% not used at the moment, it may be used in future versions of WARPLab to 
% keep track of packets. Use 'packetNum' as the third argument of the 
% 'warplab_sendCmd' command. 

 
%-------------------------------------------------------------------------%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Read the received samples from the WARP board
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% In continuous transmitter mode the receiver stores CaptOffset samples of 
% noise and the first 2^14-CaptOffset samples transmitted. 

% Read back the received samples
[Node2_Radio2_RawRxData] = warplab_readSMRO(udp_node2, RADIO2_RXDATA, 2^14);
% Process the received samples to obtain meaningful data
[Node2_Radio2_RxData,Node2_Radio2_RxOTR] = warplab_processRawRxData(Node2_Radio2_RawRxData);
% Read stored RSSI data
[Node2_Radio2_RawRSSIData] = warplab_readSMRO(udp_node2, RADIO2_RSSIDATA, 2^14/8);
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 6. Plot the transmitted and received data and close sockets
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

