%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Using WARPLab to Estimate the Amplitude and Phase of a Narrowband Flat 
% Fading 1-Input 1-Output Wireless Channel (1x1 MIMO Configuration)
% Both boards use radio 2
% ---- by xyzhang
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
% The specific steps implemented in this script are the following:
pfile = 'channelTrace0721_indoor_phase.txt';
afile = 'channelTrace0721_indoor_amplitude.txt';

% 0. Transmit a narrowband signal using Warplab.  
% First transmit from Tx radio 1 while silencing other radios, then transmit
% from Tx radio 2, etc. During each transmission all receive radios are
% capturing data. 
% 1. Remove from the received vectors the samples that do not correspond to 
% transmitted data.
% 2. Compute the amplitude and the phase of the transmitted and received 
% samples
% 3. Compute the channel amplitude and channel phase per sample for each of
% the 16 SISO channels, and compute the channel matrix

% Note: The amplitude and phase computed in this exercise correspond to the
% amplitude and phase of the channel together with the amplitude and phase 
% of the hardware. In other words, the effect of the radios is also part of
% the channel.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0. Transmit a narrowband signal using Warplab. %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0.0. Initialization and definition of parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Load some global definitions (packet types, etc.)
warplab_defines

% Create Socket handles and initialize nodes
%[socketHandles, packetNum] = warplab_initialize;
[socketHandles, packetNum] = warplab_initialize(2);

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
CarrierChannel = 14; % Channel in the 2.4 GHz band. In [1:14]
%Node1_Radio1_TxGain_BB = 3; % Tx Baseband Gain. In [0:3]
%Node1_Radio1_TxGain_RF = 40;% Tx RF Gain. In [0:63]
Node1_Radio2_TxGain_BB = 1; % Tx Baseband Gain. In [0:3]
Node1_Radio2_TxGain_RF = 25;% Tx RF Gain. In [0:63]
%Node1_Radio3_TxGain_BB = 3; % Tx Baseband Gain. In [0:3]
%Node1_Radio3_TxGain_RF = 40; % Tx RF Gain. In [0:63]
%Node1_Radio4_TxGain_BB = 3; % Tx Baseband Gain. In [0:3]
%Node1_Radio4_TxGain_RF = 40; % Tx RF Gain. In [0:63]

%Node2_Radio1_RxGain_BB = 13; % Rx Baseband Gain. In [0:31]
%Node2_Radio1_RxGain_RF = 1; % Rx RF Gain. In [1:3]  
Node2_Radio2_RxGain_BB = 15; % Rx Baseband Gain. In [0:31]
Node2_Radio2_RxGain_RF = 1; % Rx RF Gain. In [1:3]  

%Node2_Radio3_RxGain_BB = 13; % Rx Baseband Gain. In [0:31]
%Node2_Radio3_RxGain_RF = 1; % Rx RF Gain. In [1:3]  
%Node2_Radio4_RxGain_BB = 13; % Rx Baseband Gain. In [0:31]
%Node2_Radio4_RxGain_RF = 1; % Rx RF Gain. In [1:3]  

% Note: For this experiment node 1 will be set as the transmitter and node 
% 2 will be set as the receiver (this is done later in the code), hence, 
% there is no need to define receive gains for node1 and there is no
% need to define transmitter gains for node2.
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
%warplab_setRadioParameter(udp_node1,RADIO1_TXGAINS,(Node1_Radio1_TxGain_RF + Node1_Radio1_TxGain_BB*2^16));
warplab_setRadioParameter(udp_node1,RADIO2_TXGAINS,(Node1_Radio2_TxGain_RF + Node1_Radio2_TxGain_BB*2^16));
%warplab_setRadioParameter(udp_node1,RADIO3_TXGAINS,(Node1_Radio3_TxGain_RF + Node1_Radio3_TxGain_BB*2^16));
%warplab_setRadioParameter(udp_node1,RADIO4_TXGAINS,(Node1_Radio4_TxGain_RF + Node1_Radio4_TxGain_BB*2^16));
% Node 2 will be set as the receiver so download Rx gains to node 2.
%warplab_setRadioParameter(udp_node2,RADIO1_RXGAINS,(Node2_Radio1_RxGain_BB + Node2_Radio1_RxGain_RF*2^16));
warplab_setRadioParameter(udp_node2,RADIO2_RXGAINS,(Node2_Radio2_RxGain_BB + Node2_Radio2_RxGain_RF*2^16));
%warplab_setRadioParameter(udp_node2,RADIO3_RXGAINS,(Node2_Radio3_RxGain_BB + Node2_Radio3_RxGain_RF*2^16));
%warplab_setRadioParameter(udp_node2,RADIO4_RXGAINS,(Node2_Radio4_RxGain_BB + Node2_Radio4_RxGain_RF*2^16));
% Set MGC mode in node 2 (receiver)
warplab_setAGCParameter(udp_node2,MGC_AGC_SEL, Node2_MGC_AGC_Select);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0.1. Generate a vector of samples to transmit and send the samples to the 
% Warp board (Sample Frequency is 40MHz)
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
Node1_TxData = exp(t*j*2*pi*1e6);

% Download the samples to be transmitted to Tx radio buffer
%warplab_writeSMWO(udp_node1, RADIO1_TXDATA, Node1_TxData);
warplab_writeSMWO(udp_node1, RADIO2_TXDATA, Node1_TxData);
%warplab_writeSMWO(udp_node1, RADIO3_TXDATA, Node1_TxData);
%warplab_writeSMWO(udp_node1, RADIO4_TXDATA, Node1_TxData);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0.2 Prepare boards for transmission from one Tx radio and reception on 
% both receiver antennas. Send trigger to start transmission and reception 
% (trigger is the SYNC packet)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The following lines of code set node 1 as transmitter and node 2 as
% receiver; transmission and capture are triggered by sending the SYNC
% packet.

% -------------
% Enable transmitter radio path in radio 2 in node 1 
warplab_sendCmd(udp_node1, RADIO2_TXEN, packetNum);

% Enable transmission of node1's radio 2 Tx buffer (enable 
% transmission of samples stored in radio 1 Tx Buffer in node 1)
warplab_sendCmd(udp_node1, RADIO2TXBUFF_TXEN, packetNum);

% Enable receiver radio path in radios 2 in node 2 (enable radios 2 
% and 3 in node 2 as receivers)
warplab_sendCmd(udp_node2, [RADIO2_RXEN], packetNum);

% Enable capture in node2's radio 2 Rx Buffer (enable radio 2 
% Rx buffer Rx buffer in node 2 for storage of samples)
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

% ***** Read the received smaples from the WARP board
% Read back the received samples from radio 2
[Node1_Radio2_to_Node2_Radio2_RawRxData] = warplab_readSMRO(udp_node2, RADIO2_RXDATA, TxLength+TxDelay);


% Process the received samples to obtain meaningful data
%[Node1_Radio1_to_Node2_Radio1_RxData,Node1_Radio1_to_Node2_Radio1_RxOTR] = warplab_processRawRxData(Node1_Radio1_to_Node2_Radio1_RawRxData);
[Node1_Radio2_to_Node2_Radio2_RxData,Node1_Radio2_to_Node2_Radio2_RxOTR] = warplab_processRawRxData(Node1_Radio2_to_Node2_Radio2_RawRxData);
%[Node1_Radio1_to_Node2_Radio3_RxData,Node1_Radio1_to_Node2_Radio3_RxOTR] = warplab_processRawRxData(Node1_Radio1_to_Node2_Radio3_RawRxData);
%[Node1_Radio1_to_Node2_Radio4_RxData,Node1_Radio1_to_Node2_Radio4_RxOTR] = warplab_processRawRxData(Node1_Radio1_to_Node2_Radio4_RawRxData);

% ***** Reset and disable the boards
% Set radio 2 Tx buffer in node 1 back to Tx disabled mode
warplab_sendCmd(udp_node1, RADIO2TXBUFF_TXDIS, packetNum);

% Disable the transmitter radio 1
warplab_sendCmd(udp_node1, RADIO2_TXDIS, packetNum);

% Let the receiver know that samples have been read and system is ready for
% a new capture
warplab_sendCmd(udp_node2, RX_DONEREADING, packetNum);

% Set radios Rx buffer in node 2 back to Rx disabled mode
warplab_sendCmd(udp_node2, [RADIO2RXBUFF_RXDIS], packetNum);

% Disable the receiver radios
warplab_sendCmd(udp_node2, [RADIO2_RXDIS], packetNum);

% Close sockets
pnet('closeall');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Remove from the received vector the samples that do not correspond to 
% transmitted data. In other words, remove from the received vector samples
% 1 to TxDelay. This step will remove samples that correspond to measured
% noise and make the RxData vector the same length as the TxData vector
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Tx2_Rx2_RxData = Node1_Radio2_to_Node2_Radio2_RxData(TxDelay+1:end);

%Tx2_Rx2_RxData = Node1_Radio2_to_Node2_Radio2_RxData(TxDelay+1:end);
%Tx2_Rx3_RxData = Node1_Radio2_to_Node2_Radio3_RxData(TxDelay+1:end);
%Tx3_Rx2_RxData = Node1_Radio3_to_Node2_Radio2_RxData(TxDelay+1:end);
%Tx3_Rx3_RxData = Node1_Radio3_to_Node2_Radio3_RxData(TxDelay+1:end);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Compute the amplitude and the phase of the transmitted and received 
% sammples
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute the magnitude per sample of the transmitted and received
% data
mag_TxData = abs(Node1_TxData); % Tx data

mag_Tx2_Rx2_RxData = abs(Tx2_Rx2_RxData);

% Compute the phase per sample of the transmitted data
phase_TxData = angle(Node1_TxData);
phase_TxData_unw = unwrap(phase_TxData);
phase_TxData = phase_TxData *180/pi; %Convert to degrees
phase_TxData_unw = phase_TxData_unw *180/pi; %Convert to degrees

phase_Tx2_Rx2_RxData = angle(Tx2_Rx2_RxData);
phase_Tx2_Rx2_RxData_unw = unwrap(phase_Tx2_Rx2_RxData);
phase_Tx2_Rx2_RxData = phase_Tx2_Rx2_RxData *180/pi; %Convert to degrees
phase_Tx2_Rx2_RxData_unw = phase_Tx2_Rx2_RxData_unw *180/pi; %Convert to degrees



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Compute the channel amplitude and channel phase per sample
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fo = fopen(afile, 'w');

% Compute the channel amplitudes
channel_amplitude_Tx2_Rx2 = mag_Tx2_Rx2_RxData./mag_TxData;

cho = [channel_amplitude_Tx2_Rx2];
fprintf(fo, '%g \n', cho);
fclose(fo);

%fo = fopen('temp.txt', 'w');
% Compute the channel phases 
channel_phase_Tx2_Rx2 = phase_Tx2_Rx2_RxData_unw - phase_TxData_unw;
%channel_phase_Tx2_Rx2 = channel_phase_Tx2_Rx2 - 360*floor(channel_phase_Tx2_Rx2./360);

%fprintf(fo, '%g \n', [channel_phase_Tx2_Rx2]);
%fclose(fo);

%pha = load('temp.txt');
%amp = load('~/Desktop/channelTrace_amplitude.txt');
pha = channel_phase_Tx2_Rx2.';
len = length(pha(:,1));
x = 1000:length(pha(:,1));
p1 = pha(x, 1);
%{
cv = cov(x, p1, 1);
a = cv(1,end) / var(x);
b = mean(p1);% - a * mean(x);
%}
ft = polyfit(x.', p1, 1);
a = ft(1);
%fprintf(1, 'a11=%g b11=%g\n', a11, b11);
%plot(x,a11*x+b11,'-y', 'LineWidth', 4);
x1 = 1:len;
po(:,1) = pha(:,1) - (a*x1');
po = po - 360*floor(po./360);

fo = fopen(pfile, 'w');
fprintf(fo, '%g\n', po');
fclose(fo);


% Plot channel amplitude
figure(4);
plot(channel_amplitude_Tx2_Rx2)
title('CHamp Tx2Rx2')
xlabel('n (samples)'); ylabel('Amplitude');


%Plot channel phase
figure(6);
%plot(channel_phase_Tx2_Rx2);
%plot(po);
plot(pha(500:end));
xlabel('n (samples)'); ylabel('Degrees');
title('CHphaseTx2Rx2');


fprintf(1, 'amplitude std: %f \n', std(channel_amplitude_Tx2_Rx2(500:end)));
fprintf(1, 'amplitude mean: %f \n', mean(channel_amplitude_Tx2_Rx2(500:end)));
fprintf(1, 'phase std: %f \n', std(channel_phase_Tx2_Rx2(500:end)));
fprintf(1, 'phase mean: %f \n', mean(channel_phase_Tx2_Rx2(500:end)));
