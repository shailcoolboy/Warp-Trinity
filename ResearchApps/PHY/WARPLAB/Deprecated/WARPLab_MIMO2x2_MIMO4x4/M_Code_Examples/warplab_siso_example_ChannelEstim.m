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
% 3. Compute the channel amplitude and channel phase per sample

% Note: The amplitude and phase computed in this exercise correspond to the
% amplitude and phase of the channel together with the amplitude and phase 
% of the hardware. In other words, the effect of the radios (like gains and
% carrier frequency offset)is also part of the channel.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0. Transmit a narrowband signal using WARPLab
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Follow the steps for transmission and reception of data using Warplab.
% These are the steps in the matlab script warplab_siso_example_TxRx.m

% This example transmits the following narrowband signal
% t = 0:(1/40e6):TxLength/40e6 - 1/40e6; 
% TxData = exp(t*j*2*pi*1e6); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0.0. Initializaton and definition of parameters
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
CaptOffset = 2000; % Number of noise samples per Rx capture. In [0:2^14]
TxLength = 2^14-1-2000; % Length of transmission. In [0:2^14-CaptOffset]
TxMode = 0; %Transmission mode. In [0:1] 
               % 0: Single Transmission 
               % 1: Continuous Transmission. Tx board will continue 
               % transmitting the vector of samples until the user manually
               % disables the transmitter. 
CarrierChannel = 3; % Channel in the 2.4 GHz band. In [1:14]
Node1_Radio2_TxGain_BB = 3; % Tx Baseband Gain. In [0:3]
Node1_Radio2_TxGain_RF = 40; % Tx RF Gain. In [0:63]
Node2_Radio2_RxGain_BB = 15; % Rx Baseband Gain. In [0:31]
Node2_Radio2_RxGain_RF = 1; % Rx RF Gain. In [1:3]
% Note: For this experiment node 1 will be set as the transmitter and node 
% 2 will be set as the receiver (this is done later in the code), hence, 
% there is no need to define receive gains for node1 and there is no
% need to define transmitter gains for node2.

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
% 0.1. Generate a vector of samples to transmit and send the samples to the 
% WARP board (Sample Frequency is 40MHz)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Prepare some data to be transmitted
t = 0:(1/40e6):TxLength/40e6 - 1/40e6; %Create time vector.

% Create a signal to transmit, the signal can be real or complex.
% The signal must meet the following requirements:
% - Signal to transmit must be a row vector.
% - The amplitude of the real part must be in [-1:1] and the amplitude 
% of the imaginary part must be in [-1:1]. 
% - Highest frequency component is limited to 9.5 MHz (signal bandwidth
% is limited to 19 MHz)
% - Lowest frequency component is limited to 30 kHz
Node1_Radio2_TxData = exp(t*j*2*pi*1e6); 

% Download the samples to be transmitted
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
warplab_sendCmd(udp_node1, TX_START, packetNum);

% Prime receiver state machine in node 2. Node 2 will be waiting 
% for the SYNC packet. Capture at node 2 will be triggered when node 2 
% receives the SYNC packet.
warplab_sendCmd(udp_node2, RX_START, packetNum);

% Send the SYNC packet
warplab_sendSync(udp_Sync);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0.3. Read the received smaples from the Warp board
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read back the received samples
[Node2_Radio2_RawRxData] = warplab_readSMRO(udp_node2, RADIO2_RXDATA, TxLength+CaptOffset);
% Process the received samples to obtain meaningful data
[Node2_Radio2_RxData,Node2_Radio2_RxOTR] = warplab_processRawRxData(Node2_Radio2_RawRxData);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0.4. Reset and disable the boards
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

% Close sockets
pnet('closeall');

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
% 1 to CaptOffset. This step will remove samples that correspond to measured
% noise and make the RxData vector the same length as the TxData vector
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Node2_Radio2_RxData = Node2_Radio2_RxData(CaptOffset+1:end);

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
phase_TxData_unw = unwrap(phase_TxData);
phase_TxData = phase_TxData *180/pi; %Convert to degrees
phase_TxData_unw = phase_TxData_unw *180/pi; %Convert to degrees
phase_RxData = angle(Node2_Radio2_RxData);
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
% 3. Compute the channel amplitude and channel phase per sample
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
plot(channel_phase)
title('Channel Phase per sample');
xlabel('n (samples)'); ylabel('Degrees');
