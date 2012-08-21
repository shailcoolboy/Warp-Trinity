%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Using WARPLab (SISO configuration) to Estimate the Amplitude and Phase of
% a Narrowband Flat Fading Wireless Channel 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The specific steps implemented in this script are the following:

% 0. Transmit a narrowband signal using WARPLab 
% 1. Remove from the received vector the samples that do not correspond to 
% transmitted data.
% 2. Compute the amplitude and the phase of the transmitted and received 
% samples
% 3. Compute the channel amplitude and channel phase per sample and close
% sockets

% Note: The amplitude and phase computed in this exercise correspond to the
% amplitude and phase of the channel together with the amplitude and phase 
% of the hardware. In other words, the effect of the radios (like gains and
% carrier frequency offset)is also part of the channel.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0. Transmit a narrowband signal using WARPLab
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Follow the steps for transmission and reception of data using WARPLab.
% These are the steps implemented in the previous lab exercise, the
% following sections (0.0 to 0.5) guide you through the steps.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0.0. Initializaton and definition of parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Load some global definitions (packet types, etc.)
clear all;
warplab_defines

% Create Socket handles and intialize nodes
%[socketHandles, packetNum] = warplab_initialize;
[socketHandles, packetNum] = warplab_initialize(2);%two warp boards

% Separate the socket handles for easier access
% The first socket handle is always the magic SYNC
% The rest of the handles are the handles to the WARP nodes
udp_Sync = socketHandles(1);
udp_node1 = socketHandles(2);
udp_node2 = socketHandles(3);
%udp_node3 = socketHandles(2);

% Define WARPLab parameters. 
% Note: For this experiment node 1 will be set as the transmitter and node 
% 2 will be set as the receiver (this is done later in the code), hence, 
% there is no need to define receive gains for node 1 and there is no
% need to define transmitter gains for node 2.
TxDelay = 2000; % Number of noise samples per Rx capture. In [0:2^14]
TxLength = 2^14-1-2000; % Length of transmission. In [0:2^14-TxDelay]
CarrierChannel = 14; % Channel in the 2.4 GHz band. In [1:14]
Node1_Radio2_TxGain_BB = 1; % Tx Baseband Gain. In [0:3]
Node1_Radio2_TxGain_RF = 25; % Tx RF Gain. In [0:63]
Node2_Radio2_RxGain_BB = 15; % Rx Baseband Gain. In [0:31]
Node2_Radio2_RxGain_RF = 1; % Rx RF Gain. In [1:3]
TxMode = 0; %Transmission mode. In [0:1] 
               % 0: Single Transmission 
               % 1: Continuous Transmission. Tx board will continue 
               % transmitting the vector of samples until the user manually
               % disables the transmitter. 
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
% Node 1 will be set as the transmitter so download Tx gains to node 1.
warplab_setRadioParameter(udp_node1,RADIO2_TXGAINS,(Node1_Radio2_TxGain_RF + Node1_Radio2_TxGain_BB*2^16));
% Node 2 will be set as the receiver so download Rx gains to node 2.
warplab_setRadioParameter(udp_node2,RADIO2_RXGAINS,(Node2_Radio2_RxGain_BB + Node2_Radio2_RxGain_RF*2^16));
% Set MGC mode in node 2 (receiver)
warplab_setAGCParameter(udp_node2,MGC_AGC_SEL, Node2_MGC_AGC_Select);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0.1. Generate a vector of samples to transmit and send the samples to the 
% WARP board (Sample Frequency is 40MHz)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Prepare some data to be transmitted
t = 0:(1/40e6):TxLength/40e6 - 1/40e6; % Create time vector.

% The signal must meet the following requirements:
% - Signal to transmit must be a row vector.
% - The amplitude of the real part must be in [-1:1] and the amplitude 
% of the imaginary part must be in [-1:1]. 
% - Highest frequency component is limited to 9.5 MHz (signal bandwidth
% is limited to 19 MHz)
% - Lowest frequency component is limited to 30 kHz
Node1_Radio2_TxData = exp(t*j*2*pi*8e6);

% Download the samples to be transmitted
% Hints: 
% 1. The first argument of the 'warplab_writeSMWO' function identifies the
% node to which samples will be downloaded to. In this exercise we will set 
% node 1 as the transmitter node, the id or handle to node 1 is 'udp_node1'.
% 2. The second argument of the 'warplab_writeSMWO' function identifies the
% transmit buffer where the samples will be written. A node programmed with
% the warplab_mimo_2x2_v04.bit bitstream has 2 transmit buffers and a node 
% programmed with the warplab_mimo_4x4_v04.bit bitstream has 4 transmit 
% buffers. For this exercise we will transmit from radio 2, hence, samples
% must be downloaded to radio 2 Tx buffer, the id for this buffer is 
% 'RADIO2_TXDATA'. 
% 3. The third argument of the 'warplab_writeSMWO' function is the
% vector of samples to download, it must be a row vector. For this
% exercise the 'Node1_Radio2_TxData' vector is the vector of samples to be 
% transmitted, hence, this is the vector that must be downloaded to radio 2
% Tx buffer.

warplab_writeSMWO(udp_node1, RADIO2_TXDATA, Node1_Radio2_TxData);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0.2. Prepare WARP boards for transmission and reception and send trigger to 
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
%warplab_sendCmd(udp_node3, TX_START, packetNum);
warplab_sendCmd(udp_node1, TX_START, packetNum);

% Prime receiver state machine in node 2. Node 2 will be waiting 
% for the SYNC packet. Capture at node 2 will be triggered when node 2 
% receives the SYNC packet.
warplab_sendCmd(udp_node2, RX_START, packetNum);

% Send the SYNC packet
warplab_sendSync(udp_Sync);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0.3. Read the received smaples from the WARP board
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hints:
% 1. The first argument of the 'warplab_readSMRO' function identifies the
% node from which samples will be read. In this exercise we set node 2 as
% the receiver node, the id or handle to node 2 is 'udp_node2'.
% 2. The second argument of the 'warplab_readSMRO' function identifies the
% receive buffer from which samples will be read. A node programmed with
% the warplab_mimo_2x2_v04.bit bitstream has 2 receive buffers and a node 
% programmed with the warplab_mimo_4x4_v04.bit bitstream has 4 receive 
% buffers. For this exercise samples were captured in node 2 radio 2, 
% hence, samples must be read from radio 2 Rx buffer, the id for this
% buffer is 'RADIO2_RXDATA'. 
% 3. The third argument of the 'warplab_readSMRO' function is the number of
% samples to read; reading of samples always starts from address zero.
% For this exercise the third argument of the 'warplab_readSMRO' 
% function must be equal to 'TxLength+TxDelay', since TxLength is the
% number of samples that were transmitted and the first TxDelay samples
% that were captured correspond to noise samples captured before the data 
% was transmitted.
% Read back the received samples
[Node2_Radio2_RawRxData] = warplab_readSMRO(udp_node2, RADIO2_RXDATA, TxLength+TxDelay);

% Process the received samples to obtain meaningful data
[Node2_Radio2_RxData,Node2_Radio2_RxOTR] = warplab_processRawRxData(Node2_Radio2_RawRxData);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0.4. Reset and disable the boards
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set radio 2 Tx buffer in node 1 back to Tx disabled mode
warplab_sendCmd(udp_node1, RADIO2TXBUFF_TXDIS, packetNum);

% Disable the transmitter radio
warplab_sendCmd(udp_node1, RADIO2_TXDIS, packetNum);

% Set radio 2 Rx buffer in node 2 back to Rx disabled mode
warplab_sendCmd(udp_node2, RADIO2RXBUFF_RXDIS, packetNum);

% Disable the receiver radio
warplab_sendCmd(udp_node2, RADIO2_RXDIS, packetNum);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0.5. Plot the transmitted and received data
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Remove from the received vector the samples that do not correspond to 
% transmitted data. In other words, remove from the received vector samples
% 1 to TxDelay. This step will remove samples that correspond to measured
% noise and make the RxData vector the same length as the TxData vector
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Node2_Radio2_RxData = Node2_Radio2_RxData(TxDelay+1:end);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Compute the amplitude and the phase of the transmitted and received 
% sammples
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute the magnitude per sample of the transmitted and received
% data
mag_TxData = abs(Node1_Radio2_TxData);
mag_RxData = abs(Node2_Radio2_RxData);

% Compute the phase per sample of the transmitted and received data
phase_TxData = angle(Node1_Radio2_TxData);
phase_RxData = angle(Node2_Radio2_RxData);

phase_TxData_unw = unwrap(phase_TxData);
phase_TxData = phase_TxData *180/pi; %Convert to degrees
phase_TxData_unw = phase_TxData_unw *180/pi; %Convert to degrees

phase_RxData_unw = unwrap(phase_RxData);
phase_RxData = phase_RxData *180/pi; %Convert to degrees
phase_RxData_unw = phase_RxData_unw *180/pi; %Convert to degrees

% Plot magnitude and phase of transmitted and received samples
figure;
subplot(2,3,1);
plot(mag_TxData);
title('Tx Node 1 Radio 2 magnitude');
xlabel('n (samples)'); ylabel('Amplitude');
subplot(2,3,2);
plot(phase_TxData);
title('Tx Node 1 Radio 2 Phase');
xlabel('n (samples)'); ylabel('Degrees');
subplot(2,3,3);
plot(phase_TxData_unw);
title('Tx Node 1 Radio 2 Phase unwrapped');
xlabel('n (samples)'); ylabel('Degrees');
subplot(2,3,4);
plot(mag_RxData);
title('Rx Node 2 Radio 2 Magnitude');
xlabel('n (samples)'); ylabel('Amplitude');
subplot(2,3,5);
plot(phase_RxData);
title('Rx Node 2 Radio 2 Phase');
xlabel('n (samples)'); ylabel('Degrees');
subplot(2,3,6);
plot(phase_RxData_unw);
title('Rx Node 2 Radio 2 Phase unwrapped');
xlabel('n (samples)'); ylabel('Degrees');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Compute the channel amplitude and channel phase per sample and close
% sockets
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute the channel amplitude
channel_amplitude = mag_RxData./mag_TxData;

% Compute the channel phase 
channel_phase = phase_RxData_unw - phase_TxData_unw;

% Plot channel amplitude and phase
figure
subplot(2,1,1)
plot(channel_amplitude)
title('Channel Amplitude per sample');
xlabel('n (samples)'); ylabel('Amplitude');
subplot(2,1,2)
plot(channel_phase(1:end-1000))
title('Channel Phase per sample');
xlabel('n (samples)'); ylabel('Degrees');

% Close sockets
pnet('closeall');

