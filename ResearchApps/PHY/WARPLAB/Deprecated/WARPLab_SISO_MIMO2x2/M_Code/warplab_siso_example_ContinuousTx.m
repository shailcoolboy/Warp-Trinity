%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generating a Frequency Sweep with Continous Transmission using Warplab
% (SISO configuration)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To run this code the boards must be programmed with the
% warplab_siso_v02.bit bitstream

% The specific steps implemented in this script are the following

% 0. Initializaton and definition of parameters
% 1. Generate a vector of samples to transmit and send the samples to the 
% Warp board (Sample Frequency is 40MHz).  Vector represents a sum of two 
% sinusoids with different frequency.
% 2. Prepare boards for transmission and reception and send trigger to 
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

%Separate the socket handles for easier access
% The first socket handle is always the magic SYNC
% The rest can be arranged in any combination of Tx and Rx
udp_Sync = socketHandles(1);
udp_Tx = socketHandles(2);
udp_RxA = socketHandles(3);

% Define the warplab options (parameters)
CaptOffset = 1000; %Number of noise samples per Rx capture; in [0:2^14]
TxLength = 2^14-1000; %Length of transmission; in [0:2^14-CaptOffset]
TransMode = 1; %Transmission mode; in [0:1] 
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
% 1. Generate a vector of samples to transmit and send the samples to the 
% Warp board (Sample Frequency is 40MHz).  Vector represents a sinusoid
% with complex frequency linearly increasing in time.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Prepare some data to be transmitted
t = 0:(1/40e6):TxLength/40e6 - 1/40e6; % Create time vector.
f1 = 1e6; 
f2 = 6e6;
TxData = exp(t*j*2*pi*f1)+exp(t*j*2*pi*f2); % Create a signal to transmit. 
% Signal is the sum of two sinusoids with frequencies f1 and f2.
% Signal to transmit must be a row vector. The signal can be real or 
% complex, the only constraint is that the amplitude of the real part must 
% be in [-1:1] and the amplitude of the imaginary part must be in [-1:1]
scale = 1 / max( [ max(real(TxData)) , max(imag(TxData)) ] );
TxData = scale*TxData; % Scale signal so that amplitude of the real and 
% imaginary part is in [-1:1]. We want the signal to span [-1,1] range
% so it uses the full range of the DAC at the tranmitter.

% Download the samples to be transmitted
warplab_writeSMWO(udp_Tx, TxData, RADIO2_TXDATA);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Prepare boards for transmission and reception and send trigger to 
% start transmission and reception (trigger is the SYNC packet)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enable transmitter radio path in transmitter node
warplab_sendCmd(udp_Tx, RADIO2_TXEN, packetNum);

% Enable receiver radio path in receiver node
warplab_sendCmd(udp_RxA, RADIO2_RXEN, packetNum);

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
% 3. Leave continuous transmitter on for n seconds and then stop continuous
% transmission
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Leave continuous transmitter on for nsec seconds
nsec = 5;
pause(nsec);

% Stop transmission
warplab_sendCmd(udp_Tx, TX_STOP, packetNum); % Resets the output and read 
% address of the transmitter buffer without disabling the transmitter radio. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Read the received samples from the Warp board
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% In continuous transmitter mode the receiver stores CaptOffset samples of 
% noise and the first TxLength samples transmitted. 

% Read back the received samples
[RawRxData] = warplab_readSMRO(udp_RxA, RADIO2_RXDATA, TxLength+CaptOffset);
% Process the received samples to obtain meaningful data
[RxData,RxOTR] = warplab_processRawRxData(RawRxData);
% Read stored RSSI data
[RawRSSIData] = warplab_readSMRO(udp_RxA, RADIO2_RSSIDATA, (TxLength+CaptOffset)/8);
% Procecss Raw RSSI data to obtain meningful RSSI values
[RxRSSI] = warplab_processRawRSSIData(RawRSSIData);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. Reset and disable the boards
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reset the receiver
warplab_sendCmd(udp_RxA, RX_DONEREADING, packetNum);

% Disable the receiver radio
warplab_sendCmd(udp_RxA, RADIO2_RXDIS, packetNum);

% Disable the transmitter radio
warplab_sendCmd(udp_Tx, RADIO2_TXDIS, packetNum);

% Close sockets
pnet('closeall');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 6. Plot the transmitted and received data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
subplot(2,2,1);
plot(real(TxData));
title('Tx I');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(2,2,2);
plot(imag(TxData));
title('Tx Q');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(2,2,3);
plot(real(RxData));
title('Rx I');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(2,2,4);
plot(imag(RxData));
title('Rx Q');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.

