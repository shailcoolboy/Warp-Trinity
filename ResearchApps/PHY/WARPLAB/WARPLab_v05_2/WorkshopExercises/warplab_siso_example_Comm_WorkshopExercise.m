%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Using WARPLab (SISO configuration) to Transmit Bits Over a Wireless 
% Channel .
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This matlab srcipt generates a bitstream, modulates the bitstream using 
% DQPSK, transmits the modulated symbols over a wireless channel using 
% WARPLab, and demodulates the received signal to obtain the 
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
% 4. Upconvert from baseband to 5MHz to avoid radio DC attenuation
% 5. Transmit the signal over a wireless channel using Warplab
% 6. Downconvert from 5MHz to baseband
% 7. Filter the received signal with a Matched Filter (matched to the pulse 
% shaping filter), detect preamble, and downsample output of Matched Filter
% 8. Demodulate and recover the transmitted bitstream
% 9. Compute the Bit Error Rate (BER) and close sockets

% Part of this code was adapted from Matlab's commdoc_mod and commdoc_rrc 
% examples.

% You will write a matlab script that implements the ten steps above. 
% Part of the code is provided, some part of the code you will write. Read 
% the code below and fill in with your code wherever you are asked to do
% so.

% NOTE : To avoid conflict with other groups using the boards, please 
% test the code you write in this script in any of the following three 
% ways:
%
% Option 1. Run this script from matlab's Command Window by entering the 
% name of the script (enter warplab_siso_example_Comm_WorkshopExercise
% in matlab's Command Window).
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
% fid = fopen('c:\boards_lock.txt');
% 
% if(fid > -1)
%     fclose('all');
% 	errordlg('Boards already in use - Please try again!');
% 	return;
% end
% 
% !echo > c:\boards_lock.txt

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
% number of symbols to be transmitted must be less than 
% (2^14-200)/nsam-2*delay. We subtract extra 200 to account for jitter in
% sync trigger.
nsym = floor((2^14-200)/nsamp-2*delay);  % Number or symbols to transmit
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
corr_window = 300; % We expect to find the preamble within the first 
                   % 300 received samples
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

%-------------------------------------------------------------------------%
% USER CODE HERE

% Create a random binary data stream as a column vector. The number of
% elements is equal to 'nbits'. You can use Matlab's 'randint' function. 
% Store the vector in a variable named 'x'

%-------------------------------------------------------------------------%

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

%-------------------------------------------------------------------------%
% USER CODE HERE

% Modulate the symbols in vector 'xsym' using DQPSK. You can use Matlab's
% 'dpskmod' function. The alphabet or constellation size 'M' was set in
% step 0 above as 'M=4'. Store the modulated symbols in a variable named 
% 'ytx_mod'.

%-------------------------------------------------------------------------%

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
% 4. Upconvert from baseband to 5MHz to avoid radio DC attenuation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
time = [0:1:length(ytx_mod_filt)-1]/40e6; % Sampling Freq. is 40MHz
ytx_mod_filt_up = ytx_mod_filt .* exp(sqrt(-1)*2*pi*5e6*time).';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. Transmit the signal over a wireless channel using Warplab
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Follow the steps for transmission and reception of data using Warplab.
% These are the steps in the matlab script warplab_example_TxRx.m

% In this example the vector to transmit is the 'ytx_mod_filt' vector.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5.0. Initializaton and definition of parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
% TxDelay: Value of the Transmitter Delay. For this exercise set TxDelay
%             equal to 100. This value of TxDelay will allow detection
%             of the preamble if there is a jitter of 100 samples or less 
%             in the sync trigger (if transmission is triggered 100 samples
%             or less before capture is triggered).
% TxLength : Length of transmission or number of samples to transmit. 
%            In [0:2^14-TxDelay]
%            For this exercise the vector to transmit is the 'ytx_mod_filt_up'
%            vector. Set TxLength equal to the length of the 'ytx_mod_filt_up'
%            vector. You can use Matlab's 'length' function.  
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

TxMode = 0; % Transmission mode. In [0:1] 
            % 0: Single Transmission 
            % 1: Continuous Transmission. Tx board will continue 
            % transmitting the vector of samples until the user manually
            % disables the transmitter. 

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5.1. Generate a vector of samples to transmit and send the samples to the 
% WARP board (Sample Frequency is 40MHz)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Prepare some data to be transmitted

% Scale signal to transmit so that it spans [-1,1] range. We do this to
% use the full range of the DAC at the tranmitter
scale = 1 / max( [ max(real(ytx_mod_filt_up)) , max(imag(ytx_mod_filt_up)) ] );
ytx_mod_filt_up = scale*ytx_mod_filt_up;

Node1_Radio2_TxData = ytx_mod_filt_up.'; % Create a signal to transmit. Signal must be a 
% row vector

% Download the samples to be transmitted
%-------------------------------------------------------------------------%
% USER CODE HERE
% Download the 'Node1_Radio2_TxData' vector to WARP node 1 using the 
% 'warplab_writeSMWO' function. The 'Node1_Radio2_TxData' vector is the
% vector of samples to be transmitted.

% Hints: 

% 1. The first argument of the 'warplab_writeSMWO' function identifies the
% node to which samples will be downloaded to. In this exercise we will set 
% node 1 as the transmitter node, the id or handle to node 1 is 'udp_node1'.

% 2. The second argument of the 'warplab_writeSMWO' function identifies the
% transmit buffer where the samples will be written. For this exercise we 
% will transmit from radio 2, hence, samples must be downloaded to radio 2
% Tx buffer, the id for this buffer is 'RADIO2_TXDATA'. 

% 3. The third argument of the 'warplab_writeSMWO' function is the
% vector of samples to download, it must be a row vector. For this
% exercise the 'Node1_Radio2_TxData' vector is the vector of samples to be 
% transmitted, hence, this is the vector that must be downloaded to radio 2
% Tx buffer.

% 4. The 'warplab_writeSMWO' function was used in the previous exercise.

%-------------------------------------------------------------------------%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5.2. Prepare WARP boards for transmission and reception and send trigger to 
% start transmission and reception (trigger is the SYNC packet)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The following lines of code set node 1 as transmitter and node 2 as
% receiver; transmission and capture are triggered by sending the SYNC
% packet.

%-------------------------------------------------------------------------%
% USER CODE HERE
% Enable transmitter radio path in radio 2 in node 1 (enable radio 2 in 
% node 1 as transmitter) by sending the RADIO2_TXEN command to node 1 using
% the 'warplab_sendCmd' function.

% Hints:

% 1. The first argument of the 'warplab_sendCmd' function identifies the
% node to which the command will be sent to. The id or handle to node 1 is
% 'udp_node1'.

% 2. The second argument of the 'warplab_sendCmd' function identifies the
% command that will be sent.

% 3. The third argument of the 'warplab_sendCmd' command is a field that is
% not used at the moment, it may be used in future versions of WARPLab to 
% keep track of packets. Use 'packetNum' as the third argument of the 
% 'warplab_sendCmd' command. 

% 4. The 'warplab_sendCmd' function was used in the previous exercise.

%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% USER CODE HERE
% Enable transmission of node1's radio 2 Tx buffer (enable transmission
% of samples stored in radio 2 Tx Buffer in node 1) by sending the 
% RADIO2TXBUFF_TXEN command to node 1 using the 'warplab_sendCmd' function.

%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% USER CODE HERE
% Enable receiver radio path in radio 2 in node 2 (enable radio 2 in
% node 2 as receiver) by sending the RADIO2_RXEN command to node 2 using
% the 'warplab_sendCmd' function. 
% Hint: The id or handle to node 2 is 'udp_node2'.

%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% USER CODE HERE

% Enable capture in node2's radio 2 Rx Buffer (enable radio 2 rx buffer in
% node 2 for storage of samples) by sending the RADIO2RXBUFF_RXEN command to 
% node 2 using the 'warplab_sendCmd' function. 

%-------------------------------------------------------------------------%

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
% 5.3. Read the received smaples from the Warp board
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-------------------------------------------------------------------------%
% USER CODE HERE

% Read the received samples from the WARP board using the 
% 'warplab_readSMRO' function.  Store the samples in a variable named
% 'Node2_Radio2_RawRxData'

% Hints:

% 1. The first argument of the 'warplab_readSMRO' function identifies the
% node from which samples will be read. In this exercise we set node 2 as
% the receiver node, the id or handle to node 2 is 'udp_node2'.

% 2. The second argument of the 'warplab_readSMRO' function identifies the
% receive buffer from which samples will be read. For this exercise samples
% were captured in node 2 radio 2, hence, samples must be read from radio 2
% Rx buffer, the id for this buffer is 'RADIO2_RXDATA'. 

% 3. The third argument of the 'warplab_readSMRO' function is the number of
% samples to read; reading of samples always starts from address zero.
% For this exercise set third argument of the 'warplab_readSMRO' 
% function equal to 'TxLength+CaptOffset+100' (Read extra 100 samples to
% account for jitter in sync trigger)

% 4. The 'warplab_readSMRO' function was used in the previous exercise.

%-------------------------------------------------------------------------%

% Process the received samples to obtain meaningful data
[Node2_Radio2_RxData,Node2_Radio2_RxOTR] = warplab_processRawRxData(Node2_Radio2_RawRxData);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5.4. Reset and disable the boards
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
% 5.5. Plot the transmitted and received data
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
% 6. Downconvert from 5MHz to baseband
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
time = [0:1:length(Node2_Radio2_RxData)-1]/40e6; % Sampling Freq. is 40MHz
yrx_bb = Node2_Radio2_RxData .* exp(-sqrt(-1)*2*pi*5e6*time);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 7. Filter the received signal with a Matched Filter (matched to the pulse 
% shaping filter), detect preamble, and downsample output of Matched Filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Store received samples as a column vector
yrx_bb = yrx_bb.';

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

% Slice symbols of interest (nsym_payload symbols were transmitted so if 
% yrx_bb_mf_ds has more than nsym_payload elements the extra elements of the 
% yrx_bb_mf_ds vector are due to the extra samples read from the Rx buffer 
% and the extra samples added by the delay of the filters)
yrx_bb_mf_ds = yrx_bb_mf_ds(1:nsym_payload); 

% Stem Plot of signal before Matched Filter, after Matched Filter, and 
% after downsampling 
% Plots first 30 symbols. 
% Plots real and imaginary parts in different windows
figure; % Create new figure window.
subplot(2,1,1)
stem(real(yrx_bb(first_sample_index-(1+delay*nsamp):first_sample_index-(1+delay*nsamp)+30*nsamp)),'b');
hold
stem(real(yrx_bb_mf(first_sample_index:first_sample_index+30*nsamp)),'r');
stem([1:nsamp:nsamp*30],real(yrx_bb_mf_ds(1:30)),'k');
title('I Symbols');
xlabel('n (sample)'); ylabel('Amplitude');
legend('Before Matched Filter','After Matched Filter','After Downsample');
subplot(2,1,2)
stem(imag(yrx_bb(first_sample_index-(1+delay*nsamp):first_sample_index-(1+delay*nsamp)+30*nsamp)),'b');
hold
stem(imag(yrx_bb_mf(first_sample_index:first_sample_index+30*nsamp)),'r');
stem([1:nsamp:nsamp*30],imag(yrx_bb_mf_ds(1:30)),'k');
title('Q Symbols');
xlabel('n (sample)'); ylabel('Amplitude');

% Scatter Plot of received and transmitted constellation points
h = scatterplot(yrx_bb_mf_ds(1:end),1,0,'g.');
hold on;
scatterplot(ytx_mod(nsym_preamble+1:end),1,0,'k*',h);
title('Constellations');
legend('Received','Transmitted');
axis([-2 2 -2 2]); % Set axis ranges.
hold off;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 8. Demodulate and recover the transmitted bitstream
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-------------------------------------------------------------------------%
% USER CODE HERE

% Demodulate the 'yrx_bb_mf_ds' vector. Remember modulation is DQPSK.
% You can use Matlab's 'dpskdemod' function. The alphabet or constellation 
% size 'M' was set in step 0 above as 'M=4'. Store the demodulated symbols 
% in a variable named 'zsym'.

%-------------------------------------------------------------------------%

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
% 9. Compute the Bit Error Rate (BER) and close sockets
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compare x and z to obtain the number of errors and the bit error rate
[number_of_errors,bit_error_rate] = biterr(x(3:length(z)),z(3:length(z)))
% We start comparing at three because the first two bits are are always
% lost in DQPSK. We compare until minlen because z may be shorter 
% than x due to the jitter of the synch pulse.

% Close sockets
pnet('closeall');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Code to avoid conflict between users, only needed for the workshop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% !del c:\boards_lock.txt
catch,
SocketHandleExists = exist('udp_node1');
if(1==SocketHandleExists)   
% If statement needed because user code errors may happen before the 
% packets are created
% Reset nodes
warplab_reset2x2Node(udp_node1);
warplab_reset2x2Node(udp_node2);
end
% Close sockets
pnet('closeall');
% !del c:\boards_lock.txt
lasterr
end
