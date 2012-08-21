%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Using Warplab to Estimate the Amplitude and Phase of a Narrowband Flat 
% Fading 2-Input 2-Output Wireless Channel (2x2 MIMO Configuration)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To run this code the boards must be programmed with the
% warplab_mimo_v02.bit bitstream

% The specific steps implemented in this script are the following:

% 0. Transmit a narrowband signal using Warplab. For 2x2 channel estimation 
% first silence Tx radio 3 and transmit from Tx radio 2, then silence Tx 
% radio 2 and transmit from Tx radio 3. During both transimissions both 
% receive radios are capturing data. 
% 1. Remove from the received vectors the samples that do not correspond to 
% transmitted data.
% 2. Compute the amplitude and the phase of the transmitted and received 
% samples
% 3. Compute the channel amplitude and channel phase per sample for each of
% the 4 SISO channels, and compute the channel matrix

% Note: The amplitude and phase computed in this exercise correspond to the
% amplitude and phase of the channel together with the amplitude and phase 
% of the hardware. In other words, the effect of the radios is also part of
% the channel.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0. Transmit a narrowband signal using Warplab. For 2x2 channel estimation 
% first silence Tx radio 3 and transmit from Tx radio 2, then silence Tx 
% radio 2 and transmit from Tx radio 3. During both transimissions both 
% receive radios are capturing data. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0.0. Initializaton and definition of parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Load some global definitions (packet types, etc.)
warplab_defines

% Create Socket handles and intialize nodes
[socketHandles, packetNum] = warplab_initialize;

%Separate the socket handles for easier access
% The first socket handle is always the magic SYNC
% The rest can be arranged in any combination of Tx and Rx
udp_Sync = socketHandles(1);
udp_Tx = socketHandles(2);
udp_RxA = socketHandles(3);

% Define the warplab options (parameters)
CaptOffset = 1000; %Number of noise samples per Rx capture; in [0:2^14]
TxLength = 2^14-1000; %Length of transmission; in [0:2^14-CaptOffset]
TransMode = 0; %Transmission mode; in [0:1] 
               % 0: Single Transmission 
               % 1: Continuous Transmission. Tx board will continue 
               % transmitting the vector of samples until the user manually
               % disables the transmitter. 
CarrierChannel = 8; % Channel in the 2.4 GHz band. In [1:14]
Tx2GainBB = 3; %Tx Baseband Gain in [0:3]
Tx2GainRF = 40; %Tx RF Gain in [0:63]
Rx2GainBB = 15; %Rx Baseband Gain in [0:31]
Rx2GainRF = 1; %Rx RF Gain in [1:3]
Tx3GainBB = 3; %Tx Baseband Gain in [0:3]
Tx3GainRF = 40; %Tx RF Gain in [0:63]
Rx3GainBB = 15; %Rx Baseband Gain in [0:31]
Rx3GainRF = 1; %Rx RF Gain in [1:3]
TxSelect = 2; % Select transmitter radio [0:2] 0:Radio2, 1:Radio3, 2: Both
RxSelect = 2; % Select transmitter radio [0:2] 0:Radio2, 1:Radio3, 2: Both

% Define the options vector; the order of options is set by the FPGA's code
% (C code)
optionsVector = [CaptOffset TxLength-1 TransMode CarrierChannel (Rx2GainBB + Rx2GainRF*2^16) (Tx2GainRF + Tx2GainBB*2^16) (Rx3GainBB + Rx3GainRF*2^16) (Tx3GainRF + Tx3GainBB*2^16) TxSelect RxSelect]; 
% Send options vector to the nodes
warplab_setOptions(socketHandles,optionsVector);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0.1. Generate a vector of samples to transmit and send the samples to the 
% Warp board (Sample Frequency is 40MHz)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Prepare some data to be transmitted
t = 0:(1/40e6):TxLength/40e6 - 1/40e6; %Create time vector.
TxData = exp(t*j*2*pi*1e6); % Create a signal to transmit. Signal must be a
% row vector

% Download the samples to be transmitted to Tx radio 2 buffer
warplab_writeSMWO(udp_Tx, TxData, RADIO2_TXDATA);

% Download the samples to be transmitted to Tx radio 3 buffer
warplab_writeSMWO(udp_Tx, TxData, RADIO3_TXDATA);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0.2 Prepare boards for transmission from Tx radio 2 and reception on 
% both receiver antennas. Send trigger to start transmission and reception 
% (trigger is the SYNC packet)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enable transmitter radio path on radio 2 in transmitter node (enable 
% radio 2 in transmitter node as transmitter)
warplab_sendCmd(udp_Tx, RADIO2_TXEN, packetNum);

% Enable receiver radio path in receiver node (enable radio 2 and 
% radio 3 in receiver node as receivers)
warplab_sendCmd(udp_RxA, [RADIO2_RXEN RADIO3_RXEN], packetNum);

% Prime transmitter state machine in transmitter node. Transmitter will be 
% waiting for the SYNC packet. Transmission will be triggered when the 
% transmitter node receives the SYNC packet.
warplab_sendCmd(udp_Tx, TX_START, packetNum);

% Prime receiver state machine in receiver node. Receiver will be waiting 
% for the SYNC packet. Capture will be triggered when the receiver 
% node receives the SYNC packet.
warplab_sendCmd(udp_RxA, RX_START, packetNum);

% Send the SYNC packet
warplab_sendSync(udp_Sync);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0.3 Read the received smaples from the Warp board
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read back the received samples from Rx radio2
[Tx2_Rx2_RawRxData] = warplab_readSMRO(udp_RxA, RADIO2_RXDATA, TxLength+CaptOffset);
% Process the received samples to obtain meaningful data
[Tx2_Rx2_RxData,Tx2_Rx2_RxOTR] = warplab_processRawRxData(Tx2_Rx2_RawRxData);
% Read stored RSSI data
[Tx2_Rx2_RawRSSIData] = warplab_readSMRO(udp_RxA, RADIO2_RSSIDATA, (TxLength+CaptOffset)/8);
% Procecss Raw RSSI data to obtain meningful RSSI values
[Tx2_Rx2_RxRSSI] = warplab_processRawRSSIData(Tx2_Rx2_RawRSSIData);

% Read back the received samples from Rx radio3
[Tx2_Rx3_RawRxData] = warplab_readSMRO(udp_RxA, RADIO3_RXDATA, TxLength+CaptOffset);
% Process the received samples to obtain meaningful data
[Tx2_Rx3_RxData,Tx2_Rx3_RxOTR] = warplab_processRawRxData(Tx2_Rx3_RawRxData);
% Read stored RSSI data
[Tx2_Rx3_RawRSSIData] = warplab_readSMRO(udp_RxA, RADIO3_RSSIDATA, (TxLength+CaptOffset)/8);
% Procecss Raw RSSI data to obtain meningful RSSI values
[Tx2_Rx3_RxRSSI] = warplab_processRawRSSIData(Tx2_Rx3_RawRSSIData);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0.4 Reset and disable the boards
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reset the receiver
warplab_sendCmd(udp_RxA, RX_DONEREADING, packetNum);

% Disable the receiver radio 2 and radio 3
warplab_sendCmd(udp_RxA, [RADIO2_RXDIS RADIO3_RXDIS], packetNum);

% Disable the transmitter radio 2
warplab_sendCmd(udp_Tx, RADIO2_TXDIS, packetNum);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0.5 Prepare boards for transmission from Tx radio 3 and reception on 
% both receiver antennas. Send trigger to start transmission and reception 
% (trigger is the SYNC packet)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enable transmitter radio path on radio 3 in transmitter node (enable 
% radio 3 in transmitter node as transmitter)
warplab_sendCmd(udp_Tx, RADIO3_TXEN, packetNum);

% Enable receiver radio path in receiver node (enable radio 2 and 
% radio 3 in receiver node as receivers)
warplab_sendCmd(udp_RxA, [RADIO2_RXEN RADIO3_RXEN], packetNum);

% Prime transmitter state machine in transmitter node. Transmitter will be 
% waiting for the SYNC packet. Transmission will be triggered when the 
% transmitter node receives the SYNC packet.
warplab_sendCmd(udp_Tx, TX_START, packetNum);

% Prime receiver state machine in receiver node. Receiver will be waiting 
% for the SYNC packet. Capture will be triggered when the receiver 
% node receives the SYNC packet.
warplab_sendCmd(udp_RxA, RX_START, packetNum);

% Send the SYNC packet
warplab_sendSync(udp_Sync);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0.6 Read the received smaples from the Warp board
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read back the received samples from Rx radio2
[Tx3_Rx2_RawRxData] = warplab_readSMRO(udp_RxA, RADIO2_RXDATA, TxLength+CaptOffset);
% Process the received samples to obtain meaningful data
[Tx3_Rx2_RxData,Tx3_Rx2_RxOTR] = warplab_processRawRxData(Tx3_Rx2_RawRxData);
% Read stored RSSI data
[Tx3_Rx2_RawRSSIData] = warplab_readSMRO(udp_RxA, RADIO2_RSSIDATA, (TxLength+CaptOffset)/8);
% Procecss Raw RSSI data to obtain meningful RSSI values
[Tx3_Rx2_RxRSSI] = warplab_processRawRSSIData(Tx3_Rx2_RawRSSIData);

% Read back the received samples from Rx radio3
[Tx3_Rx3_RawRxData] = warplab_readSMRO(udp_RxA, RADIO3_RXDATA, TxLength+CaptOffset);
% Process the received samples to obtain meaningful data
[Tx3_Rx3_RxData,Tx3_Rx3_RxOTR] = warplab_processRawRxData(Tx3_Rx3_RawRxData);
% Read stored RSSI data
[Tx3_Rx3_RawRSSIData] = warplab_readSMRO(udp_RxA, RADIO3_RSSIDATA, (TxLength+CaptOffset)/8);
% Procecss Raw RSSI data to obtain meningful RSSI values
[Tx3_Rx3_RxRSSI] = warplab_processRawRSSIData(Tx3_Rx3_RawRSSIData);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0.7 Reset and disable the boards
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reset the receiver
warplab_sendCmd(udp_RxA, RX_DONEREADING, packetNum);

% Disable the receiver radio 2 and radio 3
warplab_sendCmd(udp_RxA, [RADIO2_RXDIS RADIO3_RXDIS], packetNum);

% Disable the transmitter radio 3
warplab_sendCmd(udp_Tx, RADIO3_TXDIS, packetNum);

% Close sockets
pnet('closeall');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0.8 Plot the transmitted and received data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
subplot(5,2,1);
plot(real(TxData));
title('Tx Radio 2 I and Tx Radio 3 I ');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(5,2,2);
plot(imag(TxData));
title('Tx Radio 2 Q Tx Radio 3 Q ');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(5,2,3);
plot(real(Tx2_Rx2_RxData));
title('Rx Radio 2 I when Tx Radio 2 was transmitting');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(5,2,4);
plot(imag(Tx2_Rx2_RxData));
title('Rx Radio 2 Q when Tx Radio 2 was transmitting');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(5,2,5);
plot(real(Tx2_Rx3_RxData));
title('Rx Radio 3 I when Tx Radio 2 was transmitting');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(5,2,6);
plot(imag(Tx2_Rx3_RxData));
title('Rx Radio 3 Q when Tx Radio 2 was transmitting');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(5,2,7);
plot(real(Tx3_Rx2_RxData));
title('Rx Radio 2 I when Tx Radio 3 was transmitting');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(5,2,8);
plot(imag(Tx3_Rx2_RxData));
title('Rx Radio 2 Q when Tx Radio 3 was transmitting');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(5,2,9);
plot(real(Tx3_Rx3_RxData));
title('Rx Radio 3 I when Tx Radio 3 was transmitting');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(5,2,10);
plot(imag(Tx3_Rx3_RxData));
title('Rx Radio 3 Q when Tx Radio 3 was transmitting');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Remove from the received vector the samples that do not correspond to 
% transmitted data. In other words, remove from the received vector samples
% 1 to CaptOffset. This step will remove samples that correspond to measured
% noise and make the RxData vector the same length as the TxData vector
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Tx2_Rx2_RxData = Tx2_Rx2_RxData(CaptOffset+1:end);
Tx2_Rx3_RxData = Tx2_Rx3_RxData(CaptOffset+1:end);
Tx3_Rx2_RxData = Tx3_Rx2_RxData(CaptOffset+1:end);
Tx3_Rx3_RxData = Tx3_Rx3_RxData(CaptOffset+1:end);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Compute the amplitude and the phase of the transmitted and received 
% sammples
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute the magnitude per sample of the transmitted and received
% data
mag_TxData = abs(TxData); % Tx data
mag_Tx2_Rx2_RxData = abs(Tx2_Rx2_RxData); 
mag_Tx2_Rx3_RxData = abs(Tx2_Rx3_RxData);
mag_Tx3_Rx2_RxData = abs(Tx3_Rx2_RxData);
mag_Tx3_Rx3_RxData = abs(Tx3_Rx3_RxData);

% Compute the phase per sample of the transmitted data
phase_TxData = angle(TxData);
phase_TxData_unw = unwrap(phase_TxData);
phase_TxData = phase_TxData *180/pi; %Convert to degrees
phase_TxData_unw = phase_TxData_unw *180/pi; %Convert to degrees

phase_Tx2_Rx2_RxData = angle(Tx2_Rx2_RxData);
phase_Tx2_Rx2_RxData_unw = unwrap(phase_Tx2_Rx2_RxData);
phase_Tx2_Rx2_RxData = phase_Tx2_Rx2_RxData *180/pi; %Convert to degrees
phase_Tx2_Rx2_RxData_unw = phase_Tx2_Rx2_RxData_unw *180/pi; %Convert to degrees

phase_Tx2_Rx3_RxData = angle(Tx2_Rx3_RxData);
phase_Tx2_Rx3_RxData_unw = unwrap(phase_Tx2_Rx3_RxData);
phase_Tx2_Rx3_RxData = phase_Tx2_Rx3_RxData *180/pi; %Convert to degrees
phase_Tx2_Rx3_RxData_unw = phase_Tx2_Rx3_RxData_unw *180/pi; %Convert to degrees

phase_Tx3_Rx2_RxData = angle(Tx3_Rx2_RxData);
phase_Tx3_Rx2_RxData_unw = unwrap(phase_Tx3_Rx2_RxData);
phase_Tx3_Rx2_RxData = phase_Tx3_Rx2_RxData *180/pi; %Convert to degrees
phase_Tx3_Rx2_RxData_unw = phase_Tx3_Rx2_RxData_unw *180/pi; %Convert to degrees

phase_Tx3_Rx3_RxData = angle(Tx3_Rx3_RxData);
phase_Tx3_Rx3_RxData_unw = unwrap(phase_Tx3_Rx3_RxData);
phase_Tx3_Rx3_RxData = phase_Tx3_Rx3_RxData *180/pi; %Convert to degrees
phase_Tx3_Rx3_RxData_unw = phase_Tx3_Rx3_RxData_unw *180/pi; %Convert to degrees

% Plot magnitude and phase of transmitted and received samples
figure;
subplot(5,2,1);
plot(mag_TxData);
title('Tx Radio 2 magnitude and Tx Radio 3 magnitude ');
xlabel('n (samples)'); ylabel('Amplitude');
subplot(5,2,2);
plot(phase_TxData_unw);
title('Tx Radio 2 phase Tx Radio 3 phase ');
xlabel('n (samples)'); ylabel('Amplitude');
subplot(5,2,3);
plot(mag_Tx2_Rx2_RxData);
title('Rx Radio 2 magnitude when Tx Radio 2 was transmitting');
xlabel('n (samples)'); ylabel('Amplitude');
subplot(5,2,4);
plot(phase_Tx2_Rx2_RxData_unw);
title('Rx Radio 2 phase when Tx Radio 2 was transmitting');
xlabel('n (samples)'); ylabel('Amplitude');
subplot(5,2,5);
plot(mag_Tx2_Rx3_RxData);
title('Rx Radio 3 magnitude when Tx Radio 2 was transmitting');
xlabel('n (samples)'); ylabel('Amplitude');
subplot(5,2,6);
plot(phase_Tx2_Rx3_RxData_unw);
title('Rx Radio 3 phase when Tx Radio 2 was transmitting');
xlabel('n (samples)'); ylabel('Amplitude');
subplot(5,2,7);
plot(mag_Tx3_Rx2_RxData);
title('Rx Radio 2 magnitude when Tx Radio 3 was transmitting');
xlabel('n (samples)'); ylabel('Amplitude');
subplot(5,2,8);
plot(phase_Tx3_Rx2_RxData_unw);
title('Rx Radio 2 phase when Tx Radio 3 was transmitting');
xlabel('n (samples)'); ylabel('Amplitude');
subplot(5,2,9);
plot(mag_Tx3_Rx3_RxData);
title('Rx Radio 3 magnitude when Tx Radio 3 was transmitting');
xlabel('n (samples)'); ylabel('Amplitude');
subplot(5,2,10);
plot(phase_Tx3_Rx3_RxData_unw);
title('Rx Radio 3 phase when Tx Radio 3 was transmitting');
xlabel('n (samples)'); ylabel('Amplitude');

% Plot magnitude and phase of transmitted and received samples

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Compute the channel amplitude and channel phase per sample
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute the channel amplitudes
channel_amplitude_Tx2_Rx2 = mag_Tx2_Rx2_RxData./mag_TxData;
channel_amplitude_Tx2_Rx3 = mag_Tx2_Rx3_RxData./mag_TxData;
channel_amplitude_Tx3_Rx2 = mag_Tx3_Rx2_RxData./mag_TxData;
channel_amplitude_Tx3_Rx3 = mag_Tx3_Rx3_RxData./mag_TxData;

% Compute the channel phases 
channel_phase_Tx2_Rx2 = phase_Tx2_Rx2_RxData_unw - phase_TxData_unw;
channel_phase_Tx2_Rx3 = phase_Tx2_Rx3_RxData_unw - phase_TxData_unw;
channel_phase_Tx3_Rx2 = phase_Tx3_Rx2_RxData_unw - phase_TxData_unw;
channel_phase_Tx3_Rx3 = phase_Tx3_Rx3_RxData_unw - phase_TxData_unw;

% Plot channel amplitude
figure
subplot(2,2,1)
plot(channel_amplitude_Tx2_Rx2)
title('Tx2-Rx2 path - Channel Amplitude per sample')
xlabel('n (samples)'); ylabel('Amplitude');
subplot(2,2,2)
plot(channel_amplitude_Tx2_Rx3)
title('Tx2-Rx3 path - Channel Amplitude per sample')
xlabel('n (samples)'); ylabel('Amplitude');
subplot(2,2,3)
plot(channel_amplitude_Tx3_Rx2)
title('Tx3-Rx2 path - Channel Amplitude per sample')
xlabel('n (samples)'); ylabel('Amplitude');
subplot(2,2,4)
plot(channel_amplitude_Tx3_Rx3)
title('Tx3-Rx3 path - Channel Amplitude per sample')
xlabel('n (samples)'); ylabel('Amplitude');

%Plot channel phase
figure
subplot(2,2,1)
plot(channel_phase_Tx2_Rx2)
xlabel('n (samples)'); ylabel('Degrees');
title('Tx2-Rx2 path - Channel Phase per sample')
subplot(2,2,2)
plot(channel_phase_Tx2_Rx3)
xlabel('n (samples)'); ylabel('Degrees');
title('Tx2-Rx3 path - Channel Phase per sample')
subplot(2,2,3)
plot(channel_phase_Tx3_Rx2)
xlabel('n (samples)'); ylabel('Degrees');
title('Tx3-Rx2 path - Channel Phase per sample')
subplot(2,2,4)
plot(channel_phase_Tx3_Rx3)
xlabel('n (samples)'); ylabel('Degrees');
title('Tx3-Rx3 path - Channel Phase per sample')

