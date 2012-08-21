%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Using Warplab (SISO configuration) to Transmit Bits Over a Wireless 
% Channel .
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To run this code the boards must be programmed with the
% warplab_siso_v02.bit bitstream

% This matlab srcipt generates a bitstream, modulates the bitstream using 
% DQPSK, transmits the modulated symbols over a wireless channel using 
% Warplab, and demodulates the received signal to obtain the 
% transmitted bits. Bit error rate (BER) is computed by comparing the 
% transmitted bitstream with the bitstream recovered at the receiver

% The specific steps implemented in this script are the following:

% 0. Initialization, define paramters, create pulse shaping filter, and 
% create reference matrix for detection of preamble
% 1. Generate a random bit stream and map it to symbols
% 2. Modulate the symbols (map symbols to constellation points) and append
% preamble symbols
% 3. Upsample the modulated symbols with the appended preamble and filter 
% using a pulse shaping filter
% 4. Transmit the signal over a wireless channel using Warplab
% 5. Filter the received signal with a Matched Filter (matched to the pulse 
% shaping filter), detect preamble, and downsample output of Matched Filter
% 6. Demodulate and recover the transmitted bitstream
% 7. Compute the Bit Error Rate (BER)

% Part of this code was adapted from Matlab's commdoc_mod and commdoc_rrc 
% examples.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0. Initialization, define paramters, create pulse shaping filter, and 
% create reference matrix for detection of preamble
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define basic parameters
M = 4; % Size of signal constellation
k = log2(M); % Number of bits per symbol
nsamp = 8; % Oversampling rate or Number of samples per symbol

% Define parameters related to the pulse shaping filter and create the 
% pulse shaping filter
% This pulse shaping filter is a Squared Root Raised Cosine (SRRC) filter
filtorder = 64; % Filter order
delay = filtorder/(nsamp*2); % Group delay (# of input samples). Group 
% delay is the time between the input to the filter and the filter's peak 
% response counted in number of input samples. In number of output samples
% the delay would be equal to 'delay*nsam'.
rolloff = 0.3; % Rolloff factor of filter
rrcfilter = rcosine(1,nsamp,'fir/sqrt',rolloff,delay); % Create SRRC filter

% Plot the filter's impulse response in a stem plot
figure; % Create new figure window.
stem(rrcfilter);
title('Raised Cosine Impulse Response');
xlabel('n (samples)'); ylabel('Amplitude');

% Define number of symbols to process, number of bits to process, and the 
% preamble. 
% The Warplab transmit buffer can store a maximum of 2^14 samples, the 
% number of samples per symbol is equal 'nsam', and the SRRC filter delay 
% in number of samples is equal to 'delay*nsam'. Consequently, the total 
% number of symbols to be transmitted must be less than 2^14/nsam-2*delay. 
nsym = floor(2^14/nsamp-2*delay);  % Number or symbols to transmit
preamble = [-1;-1;-1;1;-1;0;0;0;0;0;0;0;0]; % Preamble is a Barker sequence
                                            % modulated with BPSK
nsym_preamble = length(preamble); % number of symbols in preamble
nsym_payload = nsym-nsym_preamble;
nbits = floor(nsym_payload*k); % Number of bits to process

% Create a reference matrix used for detection of the preamble in the 
% received signal. We will correlate the received signal with the reference
% matrix
preamble_upsamp = upsample(preamble,nsamp); % Upsample preamble
length_preamble_upsamp = length(preamble_upsamp);
corr_window = 150; % We expect to find the preamble within the first 
                   % 150 received samples
reference_samples = zeros(corr_window,1); % Create reference vector.
reference_samples(1:length_preamble_upsamp) = preamble_upsamp; 
                     % First samples of reference vector correspond to the 
                     % preamble upsampled
reference_matrix = toeplitz(reference_samples,...
circshift(reference_samples(corr_window:-1:1),1)); 
         % Create reference matrix. The first column of the reference 
         % matrix is equal to the reference_samples vector. The i-th column
         % of the reference matrix is equal to circular shift of the 
         % reference samples vector, it is a shift down by i samples. 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Generate a random bit stream and map it to symbols
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create a random binary data stream as a column vector.
x = randint(nbits,1); 

% Map bits in vector x into k-bit symbols
xsym = bi2de(reshape(x,k,length(x)/k).','left-msb');

% Stem plot of bits and symbols
% Plot first 40 bits in a stem plot.
figure;
subplot(2,1,1)
stem(x(1:40),'filled');
title('Random Bits');
xlabel('Bit Index'); ylabel('Binary Value');
% Plot first 40/k symbols in a stem plot.
subplot(2,1,2)
stem(xsym(1:40/k),'filled');
title('Random Bits Mapped to Symbols');
xlabel('Symbol Index'); ylabel('Integer Value');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Modulate the symbols (map symbols to constellation points) and append
% preamble symbols
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Modulate using DQPSK
ytx_mod = dpskmod(xsym,M);

% Append preamble
ytx_mod = [preamble;ytx_mod];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Upsample the modulated symbols with the appended preamble and filter 
% using a pulse shaping filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Upsample and apply square root raised cosine filter.
ytx_mod_filt = rcosflt(ytx_mod,1,nsamp,'filter',rrcfilter);

% Stem Plot of modulated symbols before and after Squared Root Raised 
% Cosine (SRRC) filter
% Plots first 30 symbols. 
% Plots I and Q in different windows
figure; % Create new figure window.
subplot(2,1,1)
stem([1:nsamp:nsamp*30],real(ytx_mod(1:30)));
hold
stem(real(ytx_mod_filt(1+delay*nsamp:1+30*nsamp+delay*nsamp)),'r');
title('I Signal');
xlabel('n (sample)'); ylabel('Amplitude');
legend('Before SRRC Filter','After SRRC Filter');
subplot(2,1,2)
stem([1:nsamp:nsamp*30],imag(ytx_mod(1:30)));
hold
stem(imag(ytx_mod_filt(1+delay*nsamp:1+30*nsamp+delay*nsamp)),'r');
title('Q Signal');
xlabel('n (sample)'); ylabel('Amplitude');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Transmit the signal over a wireless channel using Warplab
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Follow the steps for transmission and reception of data using Warplab.
% These are the steps in the matlab script warplab_example_TxRx.m

% In this example the vector to transmit is the 'ytx_mod_filt' vector. The
% capture offset is zero. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4.0. Initializaton and definition of parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
CaptOffset = 0; %Number of noise samples per Rx capture. In [0:2^14]
TxLength = length(ytx_mod_filt); %Length of transmission. In [0:2^14-CaptOffset]
TransMode = 0; %Transmission mode. In [0:1] 
               % 0: Single Transmission 
               % 1: Continuous Transmission. Tx board will continue 
               % transmitting the vector of samples until the user manually
               % disables the transmitter. 
CarrierChannel = 8; % Channel in the 2.4 GHz band. In [1:14]
TxGainBB = 3; %Tx Baseband Gain. In [0:3]
TxGainRF = 40; %Tx RF Gain. In [0:63]
RxGainBB = 15; %Rx Baseband Gain. In [0:31]
RxGainRF = 1; %Rx RF Gain. In [1:3]

% Define the options vector; the order of options is set by the FPGA's code
% (C code)
optionsVector = [CaptOffset TxLength-1 TransMode CarrierChannel (RxGainBB + RxGainRF*2^16) (TxGainRF + TxGainBB*2^16)]; 
% Send options vector to the nodes
warplab_setOptions(socketHandles,optionsVector);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4.1. Generate a vector of samples to transmit and send the samples to the 
% Warp board (Sample Frequency is 40MHz)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Prepare some data to be transmitted

% Scale signal to transmit so that it spans [-1,1] range. We do this to
% use the full range of the DAC at the tranmitter
scale = 1 / max( [ max(real(ytx_mod_filt)) , max(imag(ytx_mod_filt)) ] );
ytx_mod_filt = scale*ytx_mod_filt;

TxData = ytx_mod_filt.'; % Create a signal to transmit. Signal must be a 
% row vector

% Download the samples to be transmitted
warplab_writeSMWO(udp_Tx, TxData, RADIO2_TXDATA);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4.2. Prepare boards for transmission and reception and send trigger to 
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
% 4.3. Read the received smaples from the Warp board
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read back the received samples
[RawRxData] = warplab_readSMRO(udp_RxA, RADIO2_RXDATA, TxLength+CaptOffset);
% Process the received samples to obtain meaningful data
[RxData,RxOTR] = warplab_processRawRxData(RawRxData);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4.4. Reset and disable the boards
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reset the receiver
warplab_sendCmd(udp_RxA, RX_DONEREADING, packetNum);

% Disable the receiver
warplab_sendCmd(udp_RxA, RADIO2_RXDIS, packetNum);

% Disable the transmitter
warplab_sendCmd(udp_Tx, RADIO2_TXDIS, packetNum);

% Close sockets
pnet('closeall');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4.5. Plot the transmitted and received data
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. Filter the received signal with a Matched Filter (matched to the pulse 
% shaping filter), detect preamble, and downsample output of Matched Filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Store received samples as a column vector
yrx_bb = RxData.';

% Matched filter: Filter received signal using the SRRC filter
yrx_bb_mf = rcosflt(yrx_bb,1,nsamp,'Fs/filter',rrcfilter);

% Correlate with the reference matrix to find preamble sequence 
correlation = abs( (yrx_bb_mf(1:corr_window).') * reference_matrix );
preamble_start = find(correlation == max(correlation)); % Start of preamble
first_sample_index = preamble_start+length_preamble_upsamp; % Start of 
                                         % first symbol after preamble 

% Downsample output of Matched Filter
yrx_bb_mf_ds = yrx_bb_mf(first_sample_index:end);
yrx_bb_mf_ds = downsample(yrx_bb_mf_ds,nsamp);
% Account for delay of filter
yrx_bb_mf_ds = yrx_bb_mf_ds(1:end-2*delay); % Twice delay because signal 
                                       % goes through 2 filtering stages 

% Stem Plot of signal before Matched Filter, after Matched Filter, and 
% after downsampling 
% Plots first 30 symbols. 
% Plots real and imaginary parts in different windows
figure; % Create new figure window.
subplot(2,1,1)
stem(real(yrx_bb(1+2*delay*nsamp+first_sample_index:1+2*delay*nsamp+...
                                       first_sample_index+30*nsamp)),'b');
hold
stem(real(yrx_bb_mf(first_sample_index:first_sample_index+30*nsamp)),'r');
stem([1:nsamp:nsamp*30],real(yrx_bb_mf_ds(1:30)),'k');
title('I Symbols');
xlabel('n (sample)'); ylabel('Amplitude');
legend('Before Matched Filter','After Matched Filter','After Downsample');
subplot(2,1,2)
stem(imag(yrx_bb(first_sample_index:first_sample_index+30*nsamp)),'b');
hold
stem(imag(yrx_bb_mf(first_sample_index:first_sample_index+30*nsamp)),'r');
stem([1:nsamp:nsamp*30],imag(yrx_bb_mf_ds(1:30)),'k');
title('Q Symbols');
xlabel('n (sample)'); ylabel('Amplitude');

% Scatter Plot of received and transmitted constellation points
h = scatterplot(yrx_bb_mf_ds(nsym_preamble+1:end),1,0,'g.');
hold on;
scatterplot(ytx_mod(nsym_preamble+1:end),1,0,'k*',h);
title('Constellations');
legend('Received','Transmitted');
axis([-2 2 -2 2]); % Set axis ranges.
hold off;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 6. Demodulate and recover the transmitted bitstream
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Demodulate signal using DQPSK
zsym = dpskdemod(yrx_bb_mf_ds,M);

% Map Symbols to Bits
z = de2bi(zsym,'left-msb'); % Convert integers to bits.
% Convert z from a matrix to a vector.
z = reshape(z.',prod(size(z)),1);

% Plot first 80 transmitted bits and first 80 received bits in a stem plot
figure;
subplot(2,1,1)
stem(x(1:80),'filled');
title('Transmitted Bits');
xlabel('Bit Index'); ylabel('Binary Value');
subplot(2,1,2)
stem(z(1:80),'filled');
title('Received Bits');
xlabel('Bit Index'); ylabel('Binary Value');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 7. Compute the Bit Error Rate (BER)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compare x and z to obtain the number of errors and the bit error rate
[number_of_errors,bit_error_rate] = biterr(x(3:length(z)),z(3:length(z)))
% We start comparing at three because the first two bits are the are always
% lost in DQPSK. We compare until length(z) because z may be shorter than
% x due to the fact that some bits (approx 1 to 5) may be lost fue to the 
% jitter of the synch pulse.
