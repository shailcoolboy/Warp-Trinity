%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Two-Way transmission and reception of data using Warplab (SISO configuration)
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

%-------------------------------------------------------------------------%
% USER CODE HERE

% Create a signal to transmit from node A to node B.
% The signal must be a row vector. The Signal is a function of the time 
% vector 't'. The signal can be real or complex, the only constraint is
% that the amplitude of the real part must be in [-1:1] and the amplitude 
% of the imaginary part must be in [-1:1]. 

% Store the signal to transmit in a variable called 
% TxDataAB (TxDataAB = your signal from node A to node B)

% Create a signal to transmit from node A to node B
TxDataAB = exp(t*j*2*pi*1e6); %Signal must be a row vector. The signal can
% be real or complex, the only constraint is that the amplitude of the real
% part must be in [-1:1] and the amplitude of the imaginary part must be 
% in [-1:1]
%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% USER CODE HERE

% Use the 'warplab_writeSMWO' function to download to node A the samples to
% be transmitted from node A to B ('TxDataAB' vector). The 
% 'warplab_writeSMWO' function has been used in all the previous exercises.

% Hints: 

% 1. The first argument of the 'warplab_writeSMWO' function identifies the
% node to which samples will be downloaded to. The handle for node A is 
% 'udp_nodeA' so use 'udp_nodeA' as the first argument.

% 2. The second argument of the 'warplab_writeSMWO' function is the
% vector of samples to be downloaded, which in this case is the 'TxDataAB'
% vector.

% 3. The third argument of 'warplab_writeSMWO' is RADIO2_TXDATA,
% RADIO2_TXDATA is defined in 'warplab_defines'. RADIO2_TXDATA can be 
% understood as an id that identifies the transmitter buffer. 

% 4. In sumary, the first argument of the 'warplab_writeSMWO' identifies
% the node and the third argument identifies which buffer in the node will 
% the samples be downloaded to. The second argument is the vector of
% samples to download.

% Download the samples to be transmitted
warplab_writeSMWO(udp_nodeA, TxDataAB, RADIO2_TXDATA); % Download samples to node A
%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% USER CODE HERE

% Create a signal to transmit from node B to node A.
% The signal must be a row vector. The Signal is a function of the time 
% vector 't'. The signal can be real or complex, the only constraint is
% that the amplitude of the real part must be in [-1:1] and the amplitude 
% of the imaginary part must be in [-1:1]. 

% Store the signal to transmit in a variable called 
% TxDataBA (TxDataBA = your signal from node B to node A)

% Create a signal to transmit from node B to node A
TxDataBA = linspace(0,1,TxLength).*exp(t*j*2*pi*5e6); 
% Signal must be a row vector. The signal can be real or complex, 
% the only constraint is that the amplitude of the real part must be in 
% [-1:1] and the amplitude of the imaginary part must be in [-1:1]
%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% USER CODE HERE

% Use the 'warplab_writeSMWO' function to download to node B the samples to
% be transmitted from node B to A ('TxDataBA' vector). The 
% 'warplab_writeSMWO' function has been used in all the previous exercises.

% Hints: 

% 1. The first argument of the 'warplab_writeSMWO' function identifies the
% node to which samples will be downloaded to. The handle for node B is 
% 'udp_nodeB' so use 'udp_nodeB' as the first argument.

% 2. The second argument of the 'warplab_writeSMWO' function is the
% vector of samples to be downloaded, which in this case is the 'TxDataBA'
% vector.

% 3. The third argument of 'warplab_writeSMWO' is RADIO2_TXDATA,
% RADIO2_TXDATA is defined in 'warplab_defines'. RADIO2_TXDATA can be 
% understood as an id that identifies the transmitter buffer. 

% 4. In sumary, the first argument of the 'warplab_writeSMWO' identifies
% the node and the third argument identifies which buffer in the node will 
% the samples be downloaded to. The second argument is the vector of
% samples to download.

warplab_writeSMWO(udp_nodeB, TxDataBA, RADIO2_TXDATA); % Download samples to node B
%-------------------------------------------------------------------------%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Prepare boards for transmission and reception from node A to node B 
% and send trigger to start transmission and reception (trigger is the SYNC
% packet)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-------------------------------------------------------------------------%
% USER CODE HERE

% Enable the transmitter radio path in node A by sending the RADIO2_TXEN
% command to node A using the 'warplab_sendCmd' function. This function has
% been used in all the previous exercises.

% Hints:

% 1. The first argument of the 'warplab_sendCmd' function identifies the
% node to which the command will be sent. The handle for node A is 
% 'udp_nodeA' so use 'udp_nodeA' as the first argument.

% 2. The second argument of the 'warplab_sendCmd' function identifies the
% instruction or command to be sent. In this case, the command to send is 
% the RADIO2_TXEN command defined in 'warplab_defines'.

% 3. The third argument of the 'warplab_sendCmd' command is a field that 
% is not used at the moment, it may be used in future versions of WARPLab 
% to keep track of packets. Use 'packetNum' as the third argument of the 
% 'warplab_sendCmd' command. 

% Enable transmitter radio path in node A
warplab_sendCmd(udp_nodeA, RADIO2_TXEN, packetNum);
%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% USER CODE HERE

% Enable the receiver radio path in node B by sending the RADIO2_RXEN
% command to node B using the 'warplab_sendCmd' function. This function has
% been used in all the previous exercises.

% Hints:

% 1. The first argument of the 'warplab_sendCmd' function identifies the
% node to which the command will be sent. The handle for node B is 
% 'udp_nodeB' so use 'udp_nodeB' as the first argument.

% 2. The second argument of the 'warplab_sendCmd' function identifies the
% instruction or command to be sent. In this case, the command to send is 
% the RADIO2_RXEN command defined in 'warplab_defines'.

% 3. The third argument of the 'warplab_sendCmd' command is a field that 
% is not used at the moment, it may be used in future versions of WARPLab 
% to keep track of packets. Use 'packetNum' as the third argument of the 
% 'warplab_sendCmd' command. 

% Enable receiver radio path in node B
warplab_sendCmd(udp_nodeB, RADIO2_RXEN, packetNum);
%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% USER CODE HERE

% Prime transmitter state machine in node A by sending the TX_START command
% to node A using the 'warplab_sendCmd' function. This function has
% been used in all the previous exercises and it is described in the Hints
% above.

% Node A will start waiting for the SYNC packet as soon as it receives the 
% TX_START command. Transmission from node A will be triggered when node A 
% receives the SYNC packet.

% Prime transmitter state machine in node A. Node A will be waiting for 
% the SYNC packet. Transmission will be triggered when node A receives 
% the SYNC packet.
warplab_sendCmd(udp_nodeA, TX_START, packetNum);
%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% USER CODE HERE

% Prime receiver state machine in node B by sending the RX_START command
% to node B using the 'warplab_sendCmd' function. This function has
% been used in all the previous exercises and it is described in the Hints
% above.

% Node B will start waiting for the SYNC packet as soon as it receives the 
% RX_START command. Capture on node B will be triggered when node B 
% receives the SYNC packet.

% Prime receiver state machine in node B. Node B will be waiting for 
% the SYNC packet. Capture will be triggered when node B receives 
% the SYNC packet.
warplab_sendCmd(udp_nodeB, RX_START, packetNum);
%-------------------------------------------------------------------------%

% Send the SYNC packet
warplab_sendSync(udp_Sync)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Disable the radios
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-------------------------------------------------------------------------%
% USER CODE HERE

% Disable the receiver radio path in node B by sending the RADIO2_RXDIS
% command to node B using the 'warplab_sendCmd' function. This function has
% been used in all the previous exercises and it is described in the Hints
% above.

% Disable the receiver
warplab_sendCmd(udp_nodeB, RADIO2_RXDIS, packetNum);
%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% USER CODE HERE

% Disable the transmitter radio path in node A by sending the RADIO2_TXDIS
% command to node A using the 'warplab_sendCmd' function. This function has
% been used in all the previous exercises and it is described in the Hints
% above.

% Disable the transmitter
warplab_sendCmd(udp_nodeA, RADIO2_TXDIS, packetNum);
%-------------------------------------------------------------------------%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Prepare boards for transmission and reception from node B to node A 
% and send trigger to start transmission and reception (trigger is the SYNC
% packet)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-------------------------------------------------------------------------%
% USER CODE HERE

% Enable the transmitter radio path in node B by sending the RADIO2_TXEN
% command to node B using the 'warplab_sendCmd' function. This function has
% been used in all the previous exercises.

% Enable transmitter radio path in node B
warplab_sendCmd(udp_nodeB, RADIO2_TXEN, packetNum);
%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% USER CODE HERE

% Enable the receiver radio path in node A by sending the RADIO2_RXEN
% command to node A using the 'warplab_sendCmd' function. This function has
% been used in all the previous exercises.

% Enable receiver radio path in node A
warplab_sendCmd(udp_nodeA, RADIO2_RXEN, packetNum);
%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% USER CODE HERE

% Prime transmitter state machine in node B by sending the TX_START command
% to node B using the 'warplab_sendCmd' function. This function has
% been used in all the previous exercises and it is described in the Hints
% above.

% Node B will start waiting for the SYNC packet as soon as it receives the 
% TX_START command. Transmission from node B will be triggered when node B 
% receives the SYNC packet.

% Prime transmitter state machine in node B. Node B will be waiting for 
% the SYNC packet. Transmission will be triggered when node B receives 
% the SYNC packet.
warplab_sendCmd(udp_nodeB, TX_START, packetNum);
%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% USER CODE HERE

% Prime receiver state machine in node A by sending the RX_START command
% to node A using the 'warplab_sendCmd' function. This function has
% been used in all the previous exercises and it is described in the Hints
% above.

% Node A will start waiting for the SYNC packet as soon as it receives the 
% RX_START command. Capture on node A will be triggered when node A 
% receives the SYNC packet.

% Prime receiver state machine in node A. Node A will be waiting for 
% the SYNC packet. Capture will be triggered when node A receives 
% the SYNC packet.
warplab_sendCmd(udp_nodeA, RX_START, packetNum);
%-------------------------------------------------------------------------%

% Send the SYNC packet
warplab_sendSync(udp_Sync)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. Disable the radios
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-------------------------------------------------------------------------%
% USER CODE HERE

% Disable the receiver radio path in node A by sending the RADIO2_RXDIS
% command to node A using the 'warplab_sendCmd' function. This function has
% been used in all the previous exercises and it is described in the Hints
% above.

% Disable the receiver
warplab_sendCmd(udp_nodeA, RADIO2_RXDIS, packetNum);
%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% USER CODE HERE

% Disable the transmitter radio path in node B by sending the RADIO2_TXDIS
% command to node B using the 'warplab_sendCmd' function. This function has
% been used in all the previous exercises and it is described in the Hints
% above.

% Disable the transmitter
warplab_sendCmd(udp_nodeB, RADIO2_TXDIS, packetNum);
%-------------------------------------------------------------------------%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 6. Read the received samples from the Warp boards 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-------------------------------------------------------------------------%
% USER CODE HERE

% Read the samples received at node B (samples sent from A to B) using the 
% 'warplab_readSMRO' function. This function was used in the 
% previous exercises. Store the samples in a variable named 'RawRxDataAB'

% Hints:

% 1. The first argument of the 'warplab_readSMRO' function identifies the
% node from which samples will be read. The handle for node B is 
% 'udp_nodeB' so use 'udp_nodeB' as the first argument.

% 2. The second argument of 'warplab_readSMRO' is RADIO2_RXDATA,
% RADIO2_RXDATA is defined in 'warplab_defines'. RADIO2_RXDATA can be 
% understood as an id that identifies the receiver buffer. 

% 3. The third argument of the 'warplab_readSMRO' function is the number of
% samples to read. For this exercise, the third argument of the 'warplab_readSMRO' 
% function is equal to 'TxLength+CaptOffset'

% 4. In sumary, the first argument of the 'warplab_readSMWO' identifies
% the node and the second argument identifies which buffer in the node will 
% be read. The third argument is the number of samples to read.

% Read back the received samples sent from A to B
[RawRxDataAB] = warplab_readSMRO(udp_nodeB, RADIO2_RXDATA, TxLength+CaptOffset);
%-------------------------------------------------------------------------%

% Process the received samples to obtain meaningful data
[RxDataAB,RxOTRAB] = warplab_processRawRxData(RawRxDataAB);
% Read stored RSSI data corresponding to A to B transmission
[RawRSSIDataAB] = warplab_readSMRO(udp_nodeB, RADIO2_RSSIDATA, (TxLength+CaptOffset)/8);
% Procecss Raw RSSI data to obtain meningful RSSI values
[RxRSSIAB] = warplab_processRawRSSIData(RawRSSIDataAB);

%-------------------------------------------------------------------------%
% USER CODE HERE

% Read the samples received at node A (samples sent from B to A) using the 
% 'warplab_readSMRO' function. This function was used in the two 
% previous exercises. Store the samples in a variable named 'RawRxDataBA'

% Hints:

% 1. The first argument of the 'warplab_readSMRO' function identifies the
% node from which samples will be read. The handle for node A is 
% 'udp_nodeA' so use 'udp_nodeA' as the first argument.

% 2. The second argument of 'warplab_readSMRO' is RADIO2_RXDATA,
% RADIO2_RXDATA is defined in 'warplab_defines'. RADIO2_RXDATA can be 
% understood as an id that identifies the receiver buffer. 

% 3. The third argument of the 'warplab_readSMRO' function is the number of
% samples to read. For this exercise, the third argument of the 'warplab_readSMRO' 
% function is equal to 'TxLength+CaptOffset'

% 4. In sumary, the first argument of the 'warplab_readSMWO' identifies
% the node and the second argument identifies which buffer in the node will 
% be read. The third argument is the number of samples to read.

% Read back the received samples sent from B to A
[RawRxDataBA] = warplab_readSMRO(udp_nodeA, RADIO2_RXDATA, TxLength+CaptOffset);
%-------------------------------------------------------------------------%

% Process the received samples to obtain meaningful data
[RxDataBA,RxOTRBA] = warplab_processRawRxData(RawRxDataBA);
% Read stored RSSI data corresponding to B to A transmission
[RawRSSIDataBA] = warplab_readSMRO(udp_nodeA, RADIO2_RSSIDATA, (TxLength+CaptOffset)/8);
% Procecss Raw RSSI data to obtain meningful RSSI values
[RxRSSIBA] = warplab_processRawRSSIData(RawRSSIDataBA);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 7. Reset the boards and close sockets
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-------------------------------------------------------------------------%
% USER CODE HERE

% Reset node A by sending the RX_DONEREADING command to node A using the 
% 'warplab_sendCmd' function. When the node receives the RX_DONEREADING 
% command it knows that the samples in the receiver buffer have been read 
% and sets the node ready for a new capture. 

% Reset node A 
warplab_sendCmd(udp_nodeA, RX_DONEREADING, packetNum);
%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% USER CODE HERE

% Reset node B by sending the RX_DONEREADING command to node B using the 
% 'warplab_sendCmd' function. When the node receives the RX_DONEREADING 
% command it knows that the samples in the receiver buffer have been read 
% and sets the node ready for a new capture.  

% Reset node B
warplab_sendCmd(udp_nodeB, RX_DONEREADING, packetNum);
%-------------------------------------------------------------------------%

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Code to avoid conflict between users, only needed for the workshop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pnet('closeall');
!del c:\boards_lock.txt
catch,
% Close sockets
pnet('closeall');
!del c:\boards_lock.txt
lasterr
end