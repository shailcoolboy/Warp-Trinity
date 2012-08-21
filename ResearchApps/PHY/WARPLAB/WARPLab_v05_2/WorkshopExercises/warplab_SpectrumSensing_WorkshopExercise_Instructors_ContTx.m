%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Spectrum sensing using WARPLab
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Instructors code

% 0. Initializaton and definition of parameters
% 1. Generate a sum of two sinusoids to transmit
% 2. Plot the transmitted data fft and waveform
% 3. Prepare WARP node for transmission and send trigger to 
% start transmission (trigger is the SYNC packet)
% 4. Stop continuous Tx Mode and disable the transmitter path (Commented out
%    by default, run these lines of code for stopping continous Tx and disable Tx radios)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0. Initializaton and definition of parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Load some global definitions (packet types, etc.)
warplab_defines

% Create Socket handles and intialize nodes
[socketHandles, packetNum] = warplab_initialize(1);

% Separate the socket handles for easier access
% The first socket handle is always the magic SYNC
% The rest of the handles are the handles to the WARP nodes
udp_Sync = socketHandles(1); % SYNC
udp_node1 = socketHandles(2); % Handle for node 1. There is only one node

% Define WARPLab parameters. 
TxDelay = 0; % Number of noise samples per Rx capture. In [0:2^14]
TxLength = 2^14-1-TxDelay; % Length of transmission. In [0:2^14-1-TxDelay]
Node1_CarrierChannel = 1; % Channel in the 2.4 GHz band. In [1:14]
Node1_Radio2_TxGain_BB = 3; % Tx Baseband Gain. In [0:3]
Node1_Radio2_TxGain_RF = 10; % Tx RF Gain. In [0:63]
TxMode = 1; % Transmission mode. In [0:1] 
            % 0: Single Transmission 
            % 1: Continuous Transmission. Tx node will continue 
            % transmitting the vector of samples until the user manually
            % disables the transmitter. 
            
% Download the WARPLab parameters to the WARP nodes. 
warplab_writeRegister(udp_node1,TX_DELAY,TxDelay);
warplab_writeRegister(udp_node1,TX_LENGTH,TxLength);
warplab_setRadioParameter(udp_node1,CARRIER_CHANNEL,Node1_CarrierChannel);
% Node 2 will be set as the transmitter so download Tx gains to node 2.
warplab_setRadioParameter(udp_node1,RADIO2_TXGAINS,(Node1_Radio2_TxGain_RF + Node1_Radio2_TxGain_BB*2^16));
warplab_writeRegister(udp_node1,TX_MODE,TxMode);            

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Generate a sum of two sinusoids to transmit
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
Node1_Radio2_TxData = 0.45*exp(t*j*2*pi*f1)+0.45*exp(t*j*2*pi*f2);
% Node1_Radio2_TxData = 0.45*sin(t*2*pi*f1)+0.45*exp(t*j*2*pi*f2);
% Node1_Radio2_TxData = 0.45*cos(t*2*pi*f1)+0.45*exp(t*j*2*pi*f2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Plot the transmitted data fft and waveform
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Compute and plot the fft of the transmitted signal centered at baseband
% Computation of fft is based on the example in MATLAB's fft
% documentation, see help fft for more information on MATLAB's fft function
% Comppute fft
L=length(Node1_Radio2_TxData); % Get length of transmitted vector
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
Y = fftshift(fft(Node1_Radio2_TxData,NFFT)/L); % Compute fft
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
plot([0:1:length(Node1_Radio2_TxData)-1]/40e6,real(Node1_Radio2_TxData));
title('Tx Node 1 Radio 2 I');
xlabel('time (s)'); ylabel('Amplitude');
axis([0 (length(Node1_Radio2_TxData)-1)/40e6 -1 1]); % Set axis ranges.

subplot(2,2,4);
plot([0:1:length(Node1_Radio2_TxData)-1]/40e6,imag(Node1_Radio2_TxData));
title('Tx Node 1 Radio 2 Q');
xlabel('time (s)'); ylabel('Amplitude');
axis([0 (length(Node1_Radio2_TxData)-1)/40e6 -1 1]); % Set axis ranges.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Prepare WARP node for transmission and send trigger to 
% start transmission (trigger is the SYNC packet)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Download the samples to be transmitted
warplab_writeSMWO(udp_node1, RADIO2_TXDATA, Node1_Radio2_TxData);

% Enable transmitter radio path in radio 2 in node 2 (enable radio 2 in 
% node 2 as transmitter)
warplab_sendCmd(udp_node1, RADIO2_TXEN, packetNum);

% Enable transmission of Node1's radio 2 Tx buffer (enable transmission
% of samples stored in radio 2 Tx Buffer in node 2)
warplab_sendCmd(udp_node1, RADIO2TXBUFF_TXEN, packetNum);

% Prime transmitter state machine in node 2. Node 2 will be 
% waiting for the SYNC packet. Transmission from node 2 will be triggered 
% when node 2 receives the SYNC packet.
warplab_sendCmd(udp_node1, TX_START, packetNum);

% Send the SYNC packet
warplab_sendSync(udp_Sync);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Stop continuous Tx Mode and disable the transmitter path
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Stop continuous transmission. Resets the output and read address of the
% transmitter buffer without disabling the transmitter radio. 

% Set radio 2 Tx buffer in node 2 back to Tx disabled mode

% Disable the transmitter radio

% warplab_sendCmd(udp_node1, TX_STOP, packetNum); 
% warplab_sendCmd(udp_node1, RADIO2TXBUFF_TXDIS, packetNum);
% warplab_sendCmd(udp_node1, RADIO2_TXDIS, packetNum);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Close sockets
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pnet('closeall');