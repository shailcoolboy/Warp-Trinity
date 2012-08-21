%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Spectrum sensing using WARPLab
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The specific steps implemented in this script are the following

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Instructors code

% 0. Initializaton and definition of parameters
% 1. Generate a sum of two sinusoids to transmit
% 2. Plot the transmitted data fft and waveform
% 3. Prepare WARP node for transmission
% 4. Disable the transmitter path

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Attendees code

% The specific steps implemented in this script are the following
% 0. Initialization and definition of parameters
% 1. Prepare the WARP node for reception (sensing the medium) and send trigger to 
% start reception (trigger is the SYNC packet)
% 2. Read the received samples from the WARP node
% 3. Reset and disable the WARP node
% 4. Compute and plot the fft of the received data
% 5. Plot the received waveform
% 6. Compute the Received Signal Strength Indicator (RSSI in dBm) of the received signal
% 7. Close sockets

% In this lab exercise you will write a matlab script that implements the
% steps above. Part of the code is provided, some part of the code you
% will write. Read the code below and fill in with your code wherever you 
% are asked to do so.

% WARPLab documentation can be found online at
% http://warp.rice.edu/trac/wiki/WARPLab

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0. Initializaton and definition of parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Instructors and attendees code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Load some global definitions (packet types, etc.)
warplab_defines

% Create Socket handles and intialize nodes
[socketHandles, packetNum] = warplab_initialize(2);

% Separate the socket handles for easier access
% The first socket handle is always the magic SYNC
% The rest of the handles are the handles to the WARP nodes
udp_Sync = socketHandles(1); % SYNC
udp_node1 = socketHandles(2); % Handle for node 1: Receiver node
udp_node2 = socketHandles(3); % Handle for node 2: Transmitter node
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Instructors code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define WARPLab parameters. 
TxDelay = 0; % Number of noise samples per Rx capture. In [0:2^14]
TxLength = 2^14-1-TxDelay; % Length of transmission. In [0:2^14-1-TxDelay]
Node2_CarrierChannel = 1; % Channel in the 2.4 GHz band. In [1:14]
Node2_Radio2_TxGain_BB = 3; % Tx Baseband Gain. In [0:3]
Node2_Radio2_TxGain_RF = 40; % Tx RF Gain. In [0:63]
TxMode = 0; % Transmission mode. In [0:1] 
            % 0: Single Transmission 
            % 1: Continuous Transmission. Tx node will continue 
            % transmitting the vector of samples until the user manually
            % disables the transmitter. 
            
% Download the WARPLab parameters to the WARP nodes. 
warplab_writeRegister(udp_node2,TX_DELAY,TxDelay);
warplab_writeRegister(udp_node2,TX_LENGTH,TxLength);
warplab_setRadioParameter(udp_node2,CARRIER_CHANNEL,Node2_CarrierChannel);
% Node 2 will be set as the transmitter so download Tx gains to node 2.
warplab_setRadioParameter(udp_node2,RADIO2_TXGAINS,(Node2_Radio2_TxGain_RF + Node2_Radio2_TxGain_BB*2^16));
warplab_writeRegister(udp_node2,TX_MODE,TxMode);            

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Attendees code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define WARPLab parameters for this workshop exercise.

%-------------------------------------------------------------------------%
% USER CODE HERE

% - Create a variable named 'Node1_SensingChannel' and assign a value to 
% this variable . 
% - Variable 'Node1_SensingChannel' can be any integer value in [1:14] range.
% - The value of Node1_SensingChannel specifies a channel in the 2.4 GHz band
% and this is the channel at which sensing wll be centered

Node1_SensingChannel = 1;
%-------------------------------------------------------------------------%                           

%-------------------------------------------------------------------------%
% USER CODE HERE

% - Set the sensing channel of node 1 by using the 'warplab_setRadioParameter'
% function and the 'Node1_SensingChannel' variable just defined

% The 'warplab_setRadioParameter' function has three arguments which are specified below:
%(The arguments in the 'warplab_setRadioParameter' function do not use the quotes '')

% 1. The first argument of the 'warplab_setRadioParameter' function identifies the
% node where the radio parameter will be set. The id or handle to node 1 is
% 'udp_node1'.

% 2. The second argument of the 'warplab_setRadioParameter' function identifies the
% radio parameter that will be set. The sensing channel is the receiver center 
% frequency or carrier channel. To set the sensing channel, the radio
% parameter that needs to be set is the parameter identified as
% 'CARRIER_CHANNEL'.

% 3. The third argument of the 'warplab_setRadioParameter' function is the channel
% number to be set. Use as third argument the variable 'Node1_SensingChannel'
% that you have previously defined

warplab_setRadioParameter(udp_node1,CARRIER_CHANNEL,Node1_SensingChannel);
%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% USER CODE HERE

% - Create a variable named 'Node1_Radio2_RxGain_BB' and assign a value to 
% this variable .
% - Node1_Radio2_RxGain_BB can be any integer value in [0:31] range.
% - Node1_Radio2_RxGain_BB is the baseband gain applied by the receiver.
% - Each unit step increase in the value of Node1_Radio2_RxGain_BB
% corresponds to a 2 dB increase of gain applied to the received signal.
                           
Node1_Radio2_RxGain_BB = 9; 
%-------------------------------------------------------------------------%


%-------------------------------------------------------------------------%
% USER CODE HERE

% - Create a variable named 'Node1_Radio2_RxGain_RF' and assign a value to 
% this variable .
% - Node1_Radio2_RxGain_RF can be any integer value in [1:3] range.
% - Node1_Radio2_RxGain_RF is the RF gain applied by the receiver.
% - Each unit step increase in the value of Node1_Radio2_RxGain_RF
% corresponds to a 15 dB increase of gain applied to the received signal.
                           
Node1_Radio2_RxGain_RF = 2; 
%-------------------------------------------------------------------------%

% Set the baseband and RF receiver gains of the radio by using the 'warplab_setRadioParameter'
% function and the 'Node1_Radio2_RxGain_BB' and 'Node1_Radio2_RxGain_RF' variables just defined
warplab_setRadioParameter(udp_node1,RADIO2_RXGAINS,(Node1_Radio2_RxGain_BB + Node1_Radio2_RxGain_RF*2^16));

Node1_MGC_AGC_Select = 0;  % Set MGC_AGC_Select=1 to enable Automatic Gain Control (AGC). 
                            % Set MGC_AGC_Select=0 to enable Manual Gain Control (MGC).
                            % By default, the nodes are set to MGC.                 
% Set MGC mode in Rx node
warplab_setAGCParameter(udp_node1,MGC_AGC_SEL,Node1_MGC_AGC_Select);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Instructors code : 
% 1. Generate a sum of two sinusoids to transmit
% 2. Plot the transmitted data fft and waveform
% 3. Prepare WARP node for transmission
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1. Generate a sum of two sinusoids to transmit

% Create a signal to transmit, the signal is a function of the time vector 
% 't' the signal can be real or complex. 
% The signal must meet the following requirements:
% - Signal to transmit must be a row vector.
% - The amplitude of the real part must be in [-1:1] and the amplitude 
% of the imaginary part must be in [-1:1]. 
% - Highest frequency component is limited to 9.5 MHz (signal bandwidth
% is limited to 19 MHz)
% - Lowest frequency component is limited to 30 kHz

t = 0:(1/40e6):TxLength/40e6 - 1/40e6; % Create time vector.
f1 = 1e6;
f2 = 4e6;
Node2_Radio2_TxData = 0.45*exp(t*j*2*pi*f1)+0.45*exp(t*j*2*pi*f2);
% Node2_Radio2_TxData = 0.45*sin(t*2*pi*f1)+0.45*exp(t*j*2*pi*f2);
% Node2_Radio2_TxData = 0.45*cos(t*2*pi*f1)+0.45*exp(t*j*2*pi*f2);

% 2. Plot the transmitted data fft and waveform

% Compute and plot the fft of the transmitted signal centered at baseband
% Computation of fft is based on the example in MATLAB's fft
% documentation, see help fft for more information on MATLAB's fft function
% Comppute fft
L=length(Node2_Radio2_TxData); % Get length of transmitted vector
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
Y = fftshift(fft(Node2_Radio2_TxData,NFFT)/L); % Compute fft
Fs=40e6; % Sampling frequency is equal to 40e6
f = Fs/2*linspace(-1,1,NFFT);

% Plot plot fft.
figure
plot(f/10^6,abs(Y)) 
title('Spectrum of transmitted signal in current carrier channel')
xlabel('Frequency (MHz)')
ylabel('Magnitude')
xlim([-10, 10])

% Plot amplitude versus sample
figure;
subplot(2,2,1);
plot(real(Node2_Radio2_TxData));
title('Tx Node 1 Radio 2 I');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.

subplot(2,2,2);
plot(imag(Node2_Radio2_TxData));
title('Tx Node 1 Radio 2 Q');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.

subplot(2,2,3);
plot([0:1:length(Node2_Radio2_TxData)-1]/40e6,real(Node2_Radio2_TxData));
title('Tx Node 1 Radio 2 I');
xlabel('time (s)'); ylabel('Amplitude');
axis([0 (length(Node2_Radio2_TxData)-1)/40e6 -1 1]); % Set axis ranges.

subplot(2,2,4);
plot([0:1:length(Node2_Radio2_TxData)-1]/40e6,imag(Node2_Radio2_TxData));
title('Tx Node 1 Radio 2 Q');
xlabel('time (s)'); ylabel('Amplitude');
axis([0 (length(Node2_Radio2_TxData)-1)/40e6 -1 1]); % Set axis ranges.

% 3. Prepare WARP node for transmission
% Download the samples to be transmitted
warplab_writeSMWO(udp_node2, RADIO2_TXDATA, Node2_Radio2_TxData);

% Enable transmitter radio path in radio 2 in node 2 (enable radio 2 in 
% node 2 as transmitter)
warplab_sendCmd(udp_node2, RADIO2_TXEN, packetNum);

% Enable transmission of Node2's radio 2 Tx buffer (enable transmission
% of samples stored in radio 2 Tx Buffer in node 2)
warplab_sendCmd(udp_node2, RADIO2TXBUFF_TXEN, packetNum);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Attendees code : 
% 1. Prepare the WARP node for reception (sensing the medium) and send trigger to 
% start reception (trigger is the SYNC packet)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-------------------------------------------------------------------------%
% USER CODE HERE

% Enable radio 2 in node 1 as receiver by sending the 'RADIO2_RXEN' command
% to node 1 using the 'warplab_sendCmd' function.

% The 'warplab_sendCmd' function has three arguments which are specified below:
%(The arguments in the 'warplab_setRadioParameter' function do not use the quotes '')

% 1. The first argument of the 'warplab_sendCmd' function identifies the
% node to which the command will be sent to. The id or handle to node 1 is
% 'udp_node1'.

% 2. The second argument of the 'warplab_sendCmd' function identifies the
% command that will be sent.

% 3. The third argument of the 'warplab_sendCmd' command is a field that is
% not used at the moment, it may be used in future versions of WARPLab to 
% keep track of packets. Use 'packetNum' as the third argument of the 
% 'warplab_sendCmd' function. 

warplab_sendCmd(udp_node1, RADIO2_RXEN, packetNum);
%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% USER CODE HERE

% Enable storage of samples in the receive buffer that is connected to 
% radio 2 in node 1 by sending the RADIO2RXBUFF_RXEN command to 
% node 1 using the 'warplab_sendCmd' function. 

% The 'warplab_sendCmd' function has been described above

warplab_sendCmd(udp_node1, RADIO2RXBUFF_RXEN, packetNum);
%-------------------------------------------------------------------------%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Instructors code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Prime transmitter state machine in node 2. Node 2 will be 
% waiting for the SYNC packet. Transmission from node 2 will be triggered 
% when node 2 receives the SYNC packet.
warplab_sendCmd(udp_node2, TX_START, packetNum);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Attendees code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Prime receiver state machine in node 1. Node 1 will be waiting 
% for the SYNC packet. Capture at node 1 will be triggered when node 1 
% receives the SYNC packet.
warplab_sendCmd(udp_node1, RX_START, packetNum);

% Send the SYNC packet
warplab_sendSync(udp_Sync);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Attendees code:
% 2. Read the received samples from the WARP node
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BufferSize = 2^14;

%-------------------------------------------------------------------------%
% USER CODE HERE

% Read the received samples from the WARP node using the 
% 'warplab_readSMRO' function. Store the samples output by the warplab_readSMRO 
% function samples in a variable named 'Node1_Radio2_RawRxData'.

% The arguments of the 'warplab_readSMRO' function are the following:

% 1. The first argument of the 'warplab_readSMRO' function identifies the
% node from which samples will be read. In this exercise there is only one 
% node and the id or handle to node 1 is 'udp_node1'.

% 2. The second argument of the 'warplab_readSMRO' function identifies the
% receive buffer from which samples will be read. For this exercise samples
% were captured in node 1 radio 2, hence, samples must be read from radio 2
% Rx buffer, the id for this buffer is 'RADIO2_RXDATA'. 

% 3. The third argument of the 'warplab_readSMRO' function is the number of
% samples to read; reading of samples always starts from address zero in 
% the receive buffer. For this exercise set the third argument of the 'warplab_readSMRO' 
% function equal to 'BufferSize' which has been defined in the code to be
% equal to 2^14 which is the maximum number of samples that can be stored
% in the receive buffer, hence you will read the entire receive buffer

[Node1_Radio2_RawRxData] = warplab_readSMRO(udp_node1, RADIO2_RXDATA, BufferSize);
%-------------------------------------------------------------------------%

% Process the received samples to obtain meaningful data
[Node1_Radio2_RxData,Node1_Radio2_RxOTR] = warplab_processRawRxData(Node1_Radio2_RawRxData);

% Read stored RSSI data
[Node1_Radio2_RawRSSIData] = warplab_readSMRO(udp_node1, RADIO2_RSSIDATA, ceil(BufferSize/8));

% Process Raw RSSI data to obtain meningful RSSI values
[Node1_Radio2_RSSIData] = warplab_processRawRSSIData(Node1_Radio2_RawRSSIData);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Instructors code
% 4. Disable te transmitter path
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Set radio 2 Tx buffer in node 2 back to Tx disabled mode
warplab_sendCmd(udp_node2, RADIO2TXBUFF_TXDIS, packetNum);

% Disable the transmitter radio
warplab_sendCmd(udp_node2, RADIO2_TXDIS, packetNum);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Attendees code:
% 3. Reset and disable the WARP node
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-------------------------------------------------------------------------%
% USER CODE HERE

% Set radio 2 in node 1 back to Rx disabled mode by sending the 
% 'RADIO2_RXDIS' command to node 1 using the 'warplab_sendCmd' function.

% The 'warplab_sendCmd' function has been described above

warplab_sendCmd(udp_node1, RADIO2_RXDIS, packetNum);
%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% USER CODE HERE

% Set storage of samples in the receive buffer that is connected to 
% radio 2 in node 1 back to disabled mode by sending the RADIO2RXBUFF_RXDIS 
% command to node 1 using the 'warplab_sendCmd' function. 

warplab_sendCmd(udp_node1, RADIO2RXBUFF_RXDIS, packetNum);
%-------------------------------------------------------------------------%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Attendees code:
% 4. Compute and plot the fft of the received data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Computation of fft is based on the example in MATLAB's fft
% documentation, see help fft for more information on MATLAB's fft function

% Compute and plot the fft of the received signal
% Compute fft
L=length(Node1_Radio2_RxData); % Get length of transmitted vector
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
Y = fftshift(fft(Node1_Radio2_RxData,NFFT)/L); % Compute fft
Fs=40e6; % Sampling frequency is equal to 40e6
f = Fs/2*linspace(0-1,1,NFFT);

% Plot fft
figure
plot(f/10^6,abs(Y)) 
title('Spectrum of received signal in current carrier channel')
xlabel('Frequency (MHz)')
ylabel('Magnitude')
xlim([-10 10])


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Attendees code:
% 5. Plot the received waveform
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
subplot(2,2,1);
plot(real(Node1_Radio2_RxData));
title('Rx Node 2 Radio 2 I');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(2,2,2);
plot(imag(Node1_Radio2_RxData));
title('Rx Node 2 Radio 2 Q');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.

% Plot amplitude versus time
subplot(2,2,3);
plot([0:1:length(Node1_Radio2_RxData)-1]/40e6,real(Node1_Radio2_RxData));
title('Rx Node 2 Radio 2 I');
xlabel('time (s)'); ylabel('Amplitude');
axis([0 (length(Node1_Radio2_RxData)-1)/40e6 -1 1]); % Set axis ranges.
subplot(2,2,4);
plot([0:1:length(Node1_Radio2_RxData)-1]/40e6,imag(Node1_Radio2_RxData));
title('Rx Node 2 Radio 2 Q');
xlabel('time (s)'); ylabel('Amplitude');
axis([0 (length(Node1_Radio2_RxData)-1)/40e6 -1 1]); % Set axis ranges.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Attendees code:
% 6. Compute the Received Signal Strength Indicator (RSSI in dBm) of the received signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RSSI measurements were stored in 'Node1_Radio2_RSSIData' variable.
% Average over all measurements of RSSI
RSSI_Avg = mean(Node1_Radio2_RSSIData);

% Convert RSSIAvg to dBm. 
% The conversion is based on the following radio and RSSI vaue specifications:
% For high receiver gain (Node1_Radio2_RxGain_RF = 3), RSSI_Avg=0 is -100dBm; RSSI_Avg=1023 is -30dBm.
% For medium receiver gain (Node1_Radio2_RxGain_RF = 2), RSSI_Avg=0 is -85dBm; RSSI_Avg=1023 is -15dBm.
% For low receiver gain (Node1_Radio2_RxGain_RF = 1), RSSI_Avg=0 is -70dBm; RSSI_Avg=1023 is 0dBm. 

RSSI_dBm = (70/1023)*RSSI_Avg - 70 - (Node1_Radio2_RxGain_RF-1)*15;
fprintf('\nRSSI dBm = %5.2f\n',RSSI_dBm)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 7. Close sockets
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pnet('closeall');