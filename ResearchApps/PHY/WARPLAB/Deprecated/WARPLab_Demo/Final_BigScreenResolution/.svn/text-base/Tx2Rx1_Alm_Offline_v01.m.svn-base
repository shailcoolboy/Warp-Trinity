%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Using Warplab to Transmit Beamformed Bits Over a 
% Wireless Channel.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Define parameters, create pulse shaping filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The samples to be transmitted are structured in the following way:
% Short Training: 320 samples
% Long Training: 320 smaples
% Guard Interval: 32 smaples
% Preamble : Short Training + Long Training + Guard Interval = 672 samples
% Pilots: Number of smaples varies depending on parameters specified below
% Payload: Number of payload samples is variable

% Define Beamforming parameters 
Num_Tx = 2;
Num_Rx = 1;
% load('Codebooks\Grassmannian\codebook_2_4vec_Grassm','codebook_2_4vec_Grassm_original');
% Codebook_Original = codebook_2_4vec_Grassm_original;
% load('Codebooks\Grassmannian\codebook_4_16vec_Grassm','codebook_4_16vec_Grassm_original');
% Codebook_Original = codebook_4_16vec_Grassm_original;

% Define Pilot parameters 
n_ChanEst = 1; % Number of times the pilot sequence for channel estimation will be transmitted
nsamp_PerAntPerChanEst = 128; % Number of samples per antenna per channel estimate
nsamp_Pilots = nsamp_PerAntPerChanEst*n_ChanEst*Num_Tx;
nsamp_TGP = 672+nsamp_Pilots; % Number of samples for training, guard 
                              % interval and pilots
                              % Short training, long training and guard
                              % interval correspond to first 672 samples

% Define modulation parameters 
M = 4; % Size of signal constellation
k = log2(M); % Number of bits per symbol
nsamp_PerSymb = 128; % Oversampling rate or Number of samples per symbol

% Define parameters related to the pulse shaping filter and create the 
% pulse shaping filter 
% This pulse shaping filter is a Squared Root Raised Cosine (SRRC) filter
filtorder = 1024; % Filter order
delay = filtorder/(nsamp_PerSymb*2); % Group delay (# of input samples). Group 
% delay is the time between the input to the filter and the filter's peak 
% response counted in number of input samples. In number of output samples
% the delay would be equal to 'delay*nsam'.
rolloff = 1; % Rolloff factor of filter
rrcfilter = rcosine(1,nsamp_PerSymb,'fir/sqrt',rolloff,delay); % Create SRRC filter
% Plot the filter's impulse response in a stem plot
% figure; % Create new figure window.
% stem(rrcfilter);
% title('Raised Cosine Impulse Response');
% xlabel('n (samples)'); ylabel('Amplitude');


% Define number of payload samples, symbols, and bits to transmit
% The Warplab transmit buffer can store a maximum of 2^14 samples; a number
% of samples equal to nsamp_TGP is reserved for training, guard interval, and
% pilots. Consequently, the total number of samples avaliable for
% payload data is 2^14-nsamp_TGP-100. We substract extra 100 to 
% account for jitter in sync trigger.
max_nsamp_Payload = 2^14-nsamp_TGP-100;  
% The number of samples per symbol is equal to nsamp_PerSymb and the SRRC
% filter delay in number of samples is equal to 'delay*nsamp_PerSymb'.
% Consequently, the max number of payload symbols is
% (max_nsamp_Payload-2*delay*nsamp_PerSymb)/nsamp_PerSymb. We count delay 
% twice because of tails at beginning and end of filtering stages.
max_nsym_Payload = floor((max_nsamp_Payload-2*delay*nsamp_PerSymb)/nsamp_PerSymb); 
nsym_Payload = max_nsym_Payload; % We transmit maximum number of payload symbols
nsamp_Payload = nsym_Payload*nsamp_PerSymb+2*delay*nsamp_PerSymb; % Number of
                           % payload samples, we take in count the samples
                           % due to filter delay
nbits = floor(nsym_Payload*k); % Number of bits to process

% Define WARPLab parameters
% Load some global definitions (packet types, etc.)
% warplab_defines_AGC
% % Create Socket handles and intialize nodes
% [socketHandles, packetNum] = warplab_initialize;
% %Separate the socket handles for easier access
% % The first socket handle is always the magic SYNC
% % The rest can be arranged in any combination of Tx and Rx
% udp_Sync = socketHandles(1);
% udp_node1 = socketHandles(2);
% udp_node2 = socketHandles(3);
% Define the warplab options (parameters)
% CaptOffset = 0; %Number of noise samples per Rx capture; in [0:2^14]
% TxLength = 2^14-1; %Total of samples to transmit; in [0:2^14-CaptOffset-1]
% CarrierChannel = 4; % Channel in the 2.4 GHz band. In [1:14]
% Node1_Radio1_TxGain_BB = 3; % Tx Baseband Gain. In [0:3]
% Node1_Radio1_TxGain_RF = 40; % Tx RF Gain. In [0:63]
% Node1_Radio2_TxGain_BB = 3; % Tx Baseband Gain. In [0:3]
% Node1_Radio2_TxGain_RF = 40; % Tx RF Gain. In [0:63]
% Node1_Radio3_TxGain_BB = 3; % Tx Baseband Gain. In [0:3]
% Node1_Radio3_TxGain_RF = 40; % Tx RF Gain. In [0:63]
% Node1_Radio4_TxGain_BB = 3; % Tx Baseband Gain. In [0:3]
% Node1_Radio4_TxGain_RF = 40; % Tx RF Gain. In [0:63]
% Node2_TargetdBmAGC = -6; % AGC's target dBm
% Node2_NoiseEstdBmAGC = -95; % AGC's Noise Estimate in dBm
% % Note: For this experiment node 1 will be set as the transmitter and node 
% % 2 will be set as the receiver (this is done later in the code), hence, 
% % there is no need to define receive gains for node 1, there is no
% % need to define transmitter gains for node 2, and there is no need to
% % define AGC parameters for node 1
% 
% % Download the WARPLab parameters to the WARP nodes. 
% % The nodes store the CaptOffset, TxLength, and TxMode parameters in 
% % registers defined in the WARPLab sysgen model. The nodes set radio 
% % related parameters CarrierChannel, TxGains, and RxGains, using the 
% % radio controller functions. The nodes store the TargetdBmAGC and
% % NoiseEstdBmAGC parameters in registers in the AGC sysgen model.
% % The CaptOffset is a parameter that needs to be known at the receiver
% % node; knowledge of CaptOffset is not required at the transmitter. For 
% % this exercise node 2 will be set as the receiver (this is done later in 
% % the code). Since CaptOffset is only required at the receiver we
% % download the CaptOffset value only to the receiver node (node 2).
% warplab_writeRegister(udp_node2,CAPT_OFFSET,CaptOffset);
% % The TxLength and TxMode parameters need to be known at the transmitter;
% % the receiver doesn't require knowledge of these parameters (the receiver
% % will always capture 2^14 samples). For this exercise node 1 will be set as
% % the transmitter (this is done later in the code). Since TxLength and
% % TxMode are only required at the transmitter we download the TxLength and
% % TxMode parameters only to the transmitter node (node 1).
% warplab_writeRegister(udp_node1,TX_LENGTH,TxLength);
% %warplab_writeRegister(udp_node1,TX_MODE,TxMode);
% % The CarrierChannel parameter must be downloaded to all nodes  
% warplab_setRadioAGCParameter(udp_node1,CARRIER_CHANNEL,CarrierChannel);
% warplab_setRadioAGCParameter(udp_node2,CARRIER_CHANNEL,CarrierChannel);
% % Node 1 will be set as the transmitter so download Tx gains to node 1.
% warplab_setRadioAGCParameter(udp_node1,RADIO1_TXGAINS,(Node1_Radio1_TxGain_RF + Node1_Radio1_TxGain_BB*2^16));
% warplab_setRadioAGCParameter(udp_node1,RADIO2_TXGAINS,(Node1_Radio2_TxGain_RF + Node1_Radio2_TxGain_BB*2^16));
% warplab_setRadioAGCParameter(udp_node1,RADIO3_TXGAINS,(Node1_Radio3_TxGain_RF + Node1_Radio3_TxGain_BB*2^16));
% warplab_setRadioAGCParameter(udp_node1,RADIO4_TXGAINS,(Node1_Radio4_TxGain_RF + Node1_Radio4_TxGain_BB*2^16));
% % Download AGC parameters to node 2
% warplab_setRadioAGCParameter(udp_node2,SET_AGC_TARGET_dBm,Node2_TargetdBmAGC);
% warplab_setRadioAGCParameter(udp_node2,SET_AGC_NOISEEST_dBm,Node2_NoiseEstdBmAGC);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Generate pilots for channel estimation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create vectors useful for easy generation of pilots for Tx antennas 1,2
time = 0:(1/40e6):nsamp_PerAntPerChanEst/40e6 - 1/40e6; % Create time vector
pilot_tone = exp(sqrt(-1)*2*pi*1.25e6*time);
zs = zeros(1,nsamp_PerAntPerChanEst);

% Create pilots to transmit from radio 1
% Pilots_1 = [pilot_tone, zs];
% Pilots_1 = repmat(Pilots_1,1,n_ChanEst);

% Create pilots to transmit from radio 2 
% Pilots_2 = [zs, pilot_tone]; 
Pilots_2 = [pilot_tone, zs];
Pilots_2 = repmat(Pilots_2,1,n_ChanEst);
% 
% Create pilots to transmit from radio 3
% Pilots_3 = [zs, zs, pilot_tone, zs]; 
Pilots_3 = [zs, pilot_tone]; 
Pilots_3 = repmat(Pilots_3,1,n_ChanEst);
% 
% % Create pilots to transmit from radio 4
% Pilots_4 = [zs, zs, zs, pilot_tone]; 
% Pilots_4 = repmat(Pilots_4,1,n_ChanEst);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Generate long training symbols
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Call WARPLab function that generates long training symbols
[LongTrainingSyms_up2,LongSymbol_time_up2,LongSymbol_time,LongSymbol_freq] = warplab_generateLongTrainSyms;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Generate short training symbols
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
shortSymbol_freq = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1-i 0 0 0 0 0 0 0 1-i 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0].';
% Take IFFT of preamble and create short symbols as per 802.11 standard
shortSymbol_time = ifft(fftshift(shortSymbol_freq));
shortSymbol_time = shortSymbol_time(1:16).';
shortsyms_10 = repmat(shortSymbol_time,1,10);
preamble_I = real(shortsyms_10);
preamble_Q = imag(shortsyms_10);
% Upsample by 2 so the standard preamble occupies a bandwith of 10MHz (if 
% the freq content of the preamble is as in the 802.11 standard)
[preamble_I_up2] = interp(preamble_I, 2);%(2.85/(10*0.0313))*interp(preamble_I, 2);
[preamble_Q_up2] = interp(preamble_Q, 2);%(2.85/(10*0.0313))*interp(preamble_Q, 2);
% Scale to span -1,1 range of DAC
scale_ShortSyms = max([ max(abs(preamble_I_up2)), max(abs(preamble_Q_up2)) ]);
[preamble_I_up2] = (1/scale_ShortSyms)*preamble_I_up2;
[preamble_Q_up2] = (1/scale_ShortSyms)*preamble_Q_up2;

ShortTrainingSyms_up2 = preamble_I_up2 + sqrt(-1)*preamble_Q_up2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. Concatenate short training symbols, long training symbols, 
% guard interval, and pilots
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TrainGuardPilots_1 = [ShortTrainingSyms_up2, LongTrainingSyms_up2, zeros(1,32), Pilots_1];
TrainGuardPilots_2 = [ShortTrainingSyms_up2, LongTrainingSyms_up2, zeros(1,32), Pilots_2];
TrainGuardPilots_3 = [ShortTrainingSyms_up2, LongTrainingSyms_up2, zeros(1,32), Pilots_3];
% TrainGuardPilots_4 = [ShortTrainingSyms_up2, LongTrainingSyms_up2, zeros(1,32), Pilots_4];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 6. Generate a random bit stream and map it to symbols
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create a random binary data stream as a column vector.
x = randint(nbits,1); 

% Map bits in vector x into k-bit symbols
xsym = bi2de(reshape(x,k,length(x)/k).','left-msb');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 7. Modulate the symbols (map symbols to constellation points)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Modulate using DQPSK
ytx_mod = dpskmod(xsym,M);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 8. Use the Alamouti scheme for encoding of symbols
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% We will encode an even number of symbols. Slice one symbol off if ytx_mod
% doesn't have an even number of elements
len_ytx_mod = length(ytx_mod);
syms2encode = floor(len_ytx_mod/2)*2;
ytx_mod_evenlen = ytx_mod(1:syms2encode);

% Since we may slice off one symbol recompute the number of nsym_Payload, 
% nsamp_Payload and nbits as was done during intialization
nsym_Payload = syms2encode; % We transmit maximum number of payload symbols
nsamp_Payload = nsym_Payload*nsamp_PerSymb+2*delay*nsamp_PerSymb; % Number of
                           % payload samples, we take in count the samples
                           % due to filter delay
nbits = floor(nsym_Payload*k); % Number of bits to process

% Reshape matrix of symbols to facilitate Alamouti encoding
ytx_mod_evenlen_R = reshape(ytx_mod_evenlen,2,syms2encode/2);

% Generate Alamouti encoded symbols for each antenna
% Row 1: slot 1 of encoding, Row 2: slot 2 of encoding
ytx_mod_2 = ytx_mod_evenlen_R;
ytx_mod_2(2,:) = -conj(ytx_mod_2(2,:));
ytx_mod_3 = ytx_mod_evenlen_R(2:-1:1,:);
ytx_mod_3(2,:) = conj(ytx_mod_3(2,:));

% Reshape to obtain stream of symbols to transmit from each antenna
ytx_mod_2 = reshape(ytx_mod_2,syms2encode,1);
ytx_mod_3 = reshape(ytx_mod_3,syms2encode,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 9. Upsample the symbols to transmit and filter 
% using a pulse shaping filter. Scale payload to span -1,1 range
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Upsample and apply square root raised cosine filter.
ytx_mod_filt_2 = rcosflt(ytx_mod_2,1,nsamp_PerSymb,'filter',rrcfilter);
ytx_mod_filt_2 = ytx_mod_filt_2.';

ytx_mod_filt_3 = rcosflt(ytx_mod_3,1,nsamp_PerSymb,'filter',rrcfilter);
ytx_mod_filt_3 = ytx_mod_filt_3.';

% Find scale payload factor to span -1,1 range
scale_Payload_2 = max([ max(abs(real(ytx_mod_filt_2))), max(abs(imag(ytx_mod_filt_2))) ]);
scale_Payload_3 = max([ max(abs(real(ytx_mod_filt_3))), max(abs(imag(ytx_mod_filt_3))) ]);
scale_Payload = max([scale_Payload_2,scale_Payload_3]);

% Scale payload and also scale by sqrt(Num_Tx) to make sure total Tx power
% is kept equal to total Tx power for beamforming
ytx_mod_filt_2 = ytx_mod_filt_2/scale_Payload*1/sqrt(Num_Tx);
ytx_mod_filt_3 = ytx_mod_filt_3/scale_Payload*1/sqrt(Num_Tx);

% Stem Plot of symbols before and after Squared Root Raised 
% Cosine (SRRC) filter
% Plots first 30 symbols. 
% Plots I and Q in different windows
% figure; % Create new figure window.
% subplot(2,1,1)
% stem([1:nsamp_PerSymb:nsamp_PerSymb*30],real(ytx_mod(1:30)));
% hold
% stem(real(ytx_mod_filt(1+delay*nsamp_PerSymb:1+30*nsamp_PerSymb+delay*nsamp_PerSymb)),'r');
% title('I Signal');
% xlabel('n (sample)'); ylabel('Amplitude');
% legend('Before SRRC Filter','After SRRC Filter');
% subplot(2,1,2)
% stem([1:nsamp_PerSymb:nsamp_PerSymb*30],imag(ytx_mod(1:30)));
% hold
% stem(imag(ytx_mod_filt(1+delay*nsamp_PerSymb:1+30*nsamp_PerSymb+delay*nsamp_PerSymb)),'r');
% title('Q Signal');
% xlabel('n (sample)'); ylabel('Amplitude');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 9. Upconvert payload to 1.25MHz
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
time = [0:1:length(ytx_mod_filt_2)-1]/40e6; % Sampling Freq. is 40MHz
ytx_mod_filt_up_2 = ytx_mod_filt_2 .* exp(sqrt(-1)*2*pi*1.25e6*time);
ytx_mod_filt_up_3 = ytx_mod_filt_3 .* exp(sqrt(-1)*2*pi*1.25e6*time);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 10. Append training, guard interval and pilots
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ytx_mod_filt_up_1 = [TrainGuardPilots_1, ytx_mod_filt_up];
ytx_mod_filt_up_2 = [TrainGuardPilots_2, ytx_mod_filt_up_2];
ytx_mod_filt_up_3 = [TrainGuardPilots_3, ytx_mod_filt_up_3];
% ytx_mod_filt_up_4 = [TrainGuardPilots_4, ytx_mod_filt_up];

% TxData_1 = ytx_mod_filt_up_1;
TxData_2 = ytx_mod_filt_up_2;
TxData_3 = ytx_mod_filt_up_3;
% TxData_4 = ytx_mod_filt_up_4;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 11. Transmit training and pilots over a wireless channel using Warplab. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 11.2 Download the samples to be transmitted.
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% warplab_writeSMWO(udp_node1, RADIO1_TXDATA, TxData_1); % Download samples to 
% % radio 1 Tx Buffer
% warplab_writeSMWO(udp_node1, RADIO2_TXDATA, TxData_2); % Download samples to 
% % radio 2 Tx Buffer
% warplab_writeSMWO(udp_node1, RADIO3_TXDATA, TxData_3); % Download samples to 
% % radio 3 Tx Buffer
% warplab_writeSMWO(udp_node1, RADIO4_TXDATA, TxData_4); % Download samples to 
% % radio 4 Tx Buffer
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 11.3 Prepare boards for transmission and reception and send trigger to 
% % start transmission and reception (trigger is the SYNC packet)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % The following lines of code set node 1 as transmitter and node 2 as
% % receiver; transmission and capture are triggered by sending the SYNC
% % packet.
% 
% % Enable transmitter radio path in all radios in node 1 (enable all radios 
% % in node 1 as transmitters)
% warplab_sendCmd(udp_node1, [RADIO2_TXEN ,RADIO3_TXEN, packetNum);
% 
% % Enable transmission of node1's  Tx buffers (enable 
% % transmission of samples stored in all radio Tx buffers in node 1)
% warplab_sendCmd(udp_node1, [RADIO2TXBUFF_TXEN, RADIO3TXBUFF_TXEN], packetNum);
% 
% % Enable receiver radio path in all radios in node 2 (enable all radios
% % in node 2 as receivers)
% warplab_sendCmd(udp_node2, [RADIO2_RXEN, RADIO3_RXEN], packetNum);
% 
% % Enable capture in node2's Rx Buffers (enable all Rx buffers in node 2 
% % for storage of samples)
% warplab_sendCmd(udp_node2, [RADIO2RXBUFF_RXEN, RADIO3RXBUFF_RXEN], packetNum);
% 
% % Prime transmitter state machine in node 1. Node 1 will be 
% % waiting for the SYNC packet. Transmission from node 1 will be triggered 
% % when node 1 receives the SYNC packet.
% warplab_sendCmd(udp_node1, TX_START, packetNum);
% 
% % Prime receiver state machine in node 2. Node 2 will be waiting 
% % for the SYNC packet. Capture at node 2 will be triggered when node 2 
% % receives the SYNC packet.
% warplab_sendCmd(udp_node2, RX_START, packetNum);
% 
% % Send the SYNC packet
% warplab_sendSync(udp_Sync);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 11.4. Read the received samples from the Warp board, read AGC values, 
% % filter DC offset, and solve timing synchronization
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Reading is done in chunks of 256 samples. There is some small jitter in the 
% % time the SYNC packet triggers TX and the time the SYNC packet triggers 
% % capture. We will read an integer number of 256 chunks, this will leave 
% % some fudge factor (read more samples) for the situation in which the
% % capture starts before the transmission
% nsamps_Read = 2^14;
% 
% % Read back the received samples from radio 1
% [RawRxData_1_wDCO] = warplab_readSMRO(udp_node2, RADIO1_RXDATA, nsamps_Read);
% % Read back the received samples from radio 2
% [RawRxData_2_wDCO] = warplab_readSMRO(udp_node2, RADIO2_RXDATA, nsamps_Read);
% % Read back the received samples from radio 3
% [RawRxData_3_wDCO] = warplab_readSMRO(udp_node2, RADIO3_RXDATA, nsamps_Read);
% % Read back the received samples from radio 4
% [RawRxData_4_wDCO] = warplab_readSMRO(udp_node2, RADIO4_RXDATA, nsamps_Read);
% % Process the received samples to obtain meaningful data
% [RxData_1_wDCO,RxOTR_1] = warplab_processRawRxData(RawRxData_1_wDCO);
% [RxData_2_wDCO,RxOTR_2] = warplab_processRawRxData(RawRxData_2_wDCO);
% [RxData_3_wDCO,RxOTR_3] = warplab_processRawRxData(RawRxData_3_wDCO);
% [RxData_4_wDCO,RxOTR_4] = warplab_processRawRxData(RawRxData_4_wDCO);
% 
% % Read the address where the AGC fixes the gains
% [AGC_Set_Address] = warplab_readRegister(udp_node2,AGC_DONE_ADDR);
% % Read the gains that were set by the AGC
% [GainsRF,GainsBB] = warplab_readAGCGains(udp_node2);
% 
% % Remove DC Offset (DCO) from RxData
% [RxData_1] = warplab_correctDCO(RxData_1_wDCO,AGC_Set_Address);
% [RxData_2] = warplab_correctDCO(RxData_2_wDCO,AGC_Set_Address);
% [RxData_3] = warplab_correctDCO(RxData_3_wDCO,AGC_Set_Address);
% [RxData_4] = warplab_correctDCO(RxData_4_wDCO,AGC_Set_Address);
% 
% % Solve timing synchronization: Find address where long training symbols start 
% [LongTrainingStart_1] = warplab_findLongTrainingStart(RxData_1,LongSymbol_time_up2,AGC_Set_Address);
% [LongTrainingStart_2] = warplab_findLongTrainingStart(RxData_2,LongSymbol_time_up2,AGC_Set_Address);
% [LongTrainingStart_3] = warplab_findLongTrainingStart(RxData_3,LongSymbol_time_up2,AGC_Set_Address);
% [LongTrainingStart_4] = warplab_findLongTrainingStart(RxData_4,LongSymbol_time_up2,AGC_Set_Address);
% 
% % Compute address where pilots start
% Pilots_Start_1 = LongTrainingStart_1 + 320 + 32; % Long training is 320 samples and there are 32 samples of guard interval before pilots
% Pilots_Start_2 = LongTrainingStart_2 + 320 + 32; % Long training is 320 samples and there are 32 samples of guard interval before pilots
% Pilots_Start_3 = LongTrainingStart_3 + 320 + 32; % Long training is 320 samples and there are 32 samples of guard interval before pilots
% Pilots_Start_4 = LongTrainingStart_4 + 320 + 32; % Long training is 320 samples and there are 32 samples of guard interval before pilots
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 11.5 Reset AGC and Rx bufer  
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Reset the AGC.
% warplab_sendCmd(udp_node2, AGC_RESET, packetNum);
% 
% % Let the receiver know that samples have been read and system is ready for
% % a new capture
% warplab_sendCmd(udp_node2, RX_DONEREADING, packetNum);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% START OF CODE FOR DEBUGGING WITHOUT TX OVER WARP BOARDS. This code
% replaces section 11 in code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create a channel matrix and pass data through this channel

var_real_imag = 1/2;
Channel = sqrt(var_real_imag)*randn(Num_Rx,Num_Tx) + ...
        sqrt(-1)*sqrt(var_real_imag)*randn(Num_Rx,Num_Tx);
% Channel_In = [TxData_1;TxData_2;TxData_3;TxData_4];
Channel_In = [TxData_2;TxData_3];
Channel_Out = Channel * Channel_In;

nsamps_Read = nsamp_TGP+nsamp_Payload;

% RxData_1_wDCO = Channel_Out(1,1:nsamps_Read);
% RxData_2_wDCO = Channel_Out(2,1:nsamps_Read);
RxData_2_wDCO = Channel_Out(1,1:nsamps_Read);
% RxData_3_wDCO = Channel_Out(3,1:nsamps_Read);
% RxData_4_wDCO = Channel_Out(4,1:nsamps_Read);

% RxData_1 = RxData_1_wDCO;
RxData_2 = RxData_2_wDCO;
% RxData_3 = RxData_3_wDCO;
% RxData_4 = RxData_4_wDCO;

% GainsRF_Init = [2,3,2,3];
% GainsBB_Init = [1,5,10,15];
% Gains are not need for one Rx antenna

% Find address where payolad starts and address where the first long symbol
% in the long training symbols starts
AGC_Set_Address = 0;
% [LongTrainingStart_1] = warplab_findLongTrainingStart(RxData_1,LongSymbol_time_up2,AGC_Set_Address);
[LongTrainingStart_2] = warplab_findLongTrainingStart(RxData_2,LongSymbol_time_up2,AGC_Set_Address);
% [LongTrainingStart_3] = warplab_findLongTrainingStart(RxData_3,LongSymbol_time_up2,AGC_Set_Address);
% [LongTrainingStart_4] = warplab_findLongTrainingStart(RxData_4,LongSymbol_time_up2,AGC_Set_Address);
% Pilots_Start_1 = LongTrainingStart_1 + 320 + 32; % Long training is 320 samples and there are 32 samples of guard interval before pilots
Pilots_Start_2 = LongTrainingStart_2 + 320 + 32; % Long training is 320 samples and there are 32 samples of guard interval before pilots
% Pilots_Start_3 = LongTrainingStart_3 + 320 + 32; % Long training is 320 samples and there are 32 samples of guard interval before pilots
% Pilots_Start_4 = LongTrainingStart_4 + 320 + 32; % Long training is 320 samples and there are 32 samples of guard interval before pilots
% Payload_Start_1 = Pilots_Start_1 + nsamp_Pilots;
Payload_Start_2 = Pilots_Start_2 + nsamp_Pilots;
% Payload_Start_3 = Pilots_Start_3 + nsamp_Pilots;
% Payload_Start_4 = Pilots_Start_4 + nsamp_Pilots;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% END OF CODE FOR DEBUGGING WITHOUT TX OVER WARP BOARDS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 12. Compute Initial Channel estimate and Quantize it
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Slice pilot data
% TxData_1_Pilots = TxData_1(673:673+nsamp_Pilots-1);
TxData_2_Pilots = TxData_2(673:673+nsamp_Pilots-1);
TxData_3_Pilots = TxData_3(673:673+nsamp_Pilots-1);
% TxData_4_Pilots = TxData_4(673:673+nsamp_Pilots-1);

% RxData_1_Pilots = RxData_1(Pilots_Start_1:Pilots_Start_1+nsamp_Pilots-1);
RxData_2_Pilots = RxData_2(Pilots_Start_2:Pilots_Start_2+nsamp_Pilots-1);
% RxData_3_Pilots = RxData_3(Pilots_Start_3:Pilots_Start_3+nsamp_Pilots-1);
% RxData_4_Pilots = RxData_4(Pilots_Start_4:Pilots_Start_4+nsamp_Pilots-1);

% Create vectors of Tx and Rx Pilots
% TxData = [TxData_1_Pilots,TxData_2_Pilots,TxData_3_Pilots,TxData_4_Pilots];
% RxData_Init = [RxData_1_Pilots,RxData_2_Pilots,RxData_3_Pilots,RxData_4_Pilots];
TxData = [TxData_2_Pilots,TxData_3_Pilots];
RxData = [RxData_2_Pilots];

% Reshape data in way that facilitates computation of channel estimate
TxData_R = reshape(TxData,[],1,Num_Tx);
TxData_RR = repmat(TxData_R,1,Num_Rx); % Dim1:Samples, Dim2:Rx, Dim3:Tx
RxData_R = reshape(RxData,[],Num_Rx,1);
RxData_RR = repmat(RxData_R,[1,1,Num_Tx]); % Dim1:Samples, Dim2:Rx, Dim3:Tx

% Compute estimate of channel real and imaginary part
realCE = real(RxData_RR.*conj(TxData_RR)./(abs(TxData_RR).^2));
imagCE = imag(RxData_RR.*conj(TxData_RR)./(abs(TxData_RR).^2));
% Find mask for invalid values and mask invalid values in channel estimate
mask = isfinite(realCE);
mask = find(0 == mask);
realCE(mask) = 0;
imagCE(mask) = 0;

% Compute Average
avgrealCE = sum(realCE,1)/(n_ChanEst*nsamp_PerAntPerChanEst);
avgimagCE = sum(imagCE,1)/(n_ChanEst*nsamp_PerAntPerChanEst);

% Reshape to obtain channel matrix
avgrealCE = reshape(avgrealCE,Num_Rx,Num_Tx);
avgimagCE = reshape(avgimagCE,Num_Rx,Num_Tx);
CE_RxGains = avgrealCE + sqrt(-1)*avgimagCE;

% NO NEED TO SCALE FOR 1 RX ANTENNA
% % Scale RxData according to inverse of AGC gains to obtain data signal 
% % before AGC scaling. 
% dBGainsRF_Init = (GainsRF_Init - 1)*15;
% dBGainsBB_Init = GainsBB_Init*2;
% ScaleRF_Init = 10.^(dBGainsRF_Init/10);
% ScaleBB_Init = 10.^(dBGainsBB_Init/10);
% Scale_RxGains_Init = ScaleRF_Init.*ScaleBB_Init;
% Scale_RxGains_Init = 1./ Scale_RxGains_Init;
% Scale_RxGains_Init = diag(Scale_RxGains_Init);
% CE_Init = Scale_RxGains_Init * CE_Init_RxGains;
CE = CE_RxGains;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Slice payload samples, and downconvert payload to 1.25MHz
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Slice
% RxData_1_Payload = RxData_1_BF(Payload_Start_1:Payload_Start_1+nsamp_Payload-1);
RxData_2_Payload = RxData_2(Payload_Start_2:Payload_Start_2+nsamp_Payload-1);
% RxData_3_Payload = RxData_3_BF(Payload_Start_3:Payload_Start_3+nsamp_Payload-1);
% RxData_4_Payload = RxData_4_BF(Payload_Start_4:Payload_Start_4+nsamp_Payload-1);

% Downconvert payload
% time = [0:1:length(RxData_1_Payload)-1]/40e6; % Sampling Freq. is 40MHz
time = [0:1:length(RxData_2_Payload)-1]/40e6; % Sampling Freq. is 40MHz
% yrx_bb_1 = RxData_1_Payload .* exp(-sqrt(-1)*2*pi*1.25e6*time);
yrx_bb_2 = RxData_2_Payload .* exp(-sqrt(-1)*2*pi*1.25e6*time);
% yrx_bb_3 = RxData_3_Payload .* exp(-sqrt(-1)*2*pi*1.25e6*time);
% yrx_bb_4 = RxData_4_Payload .* exp(-sqrt(-1)*2*pi*1.25e6*time);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filter payload samples with a Matched Filter (matched to the pulse 
% shaping filter), and downsample output of Matched Filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Matched filter: Filter received signal using the SRRC filter
% yrx_bb_mf_1 = rcosflt(yrx_bb_1,1,nsamp_PerSymb,'Fs/filter',rrcfilter);
yrx_bb_mf_2 = rcosflt(yrx_bb_2,1,nsamp_PerSymb,'Fs/filter',rrcfilter);
% yrx_bb_mf_3 = rcosflt(yrx_bb_3,1,nsamp_PerSymb,'Fs/filter',rrcfilter);
% yrx_bb_mf_4 = rcosflt(yrx_bb_4,1,nsamp_PerSymb,'Fs/filter',rrcfilter);

% Downsample output of Matched Filter
first_sample_index = 1+2*delay*nsamp_PerSymb; % Twice delay because signal goes through 2 filtering stages

% yrx_bb_mf_ds_1 = yrx_bb_mf_1(first_sample_index:end);
yrx_bb_mf_ds_2 = yrx_bb_mf_2(first_sample_index:end);
% yrx_bb_mf_ds_3 = yrx_bb_mf_3(first_sample_index:end);
% yrx_bb_mf_ds_4 = yrx_bb_mf_4(first_sample_index:end);

% yrx_bb_mf_ds_1 = downsample(yrx_bb_mf_ds_1,nsamp_PerSymb);
yrx_bb_mf_ds_2 = downsample(yrx_bb_mf_ds_2,nsamp_PerSymb);
% yrx_bb_mf_ds_3 = downsample(yrx_bb_mf_ds_3,nsamp_PerSymb);
% yrx_bb_mf_ds_4 = downsample(yrx_bb_mf_ds_4,nsamp_PerSymb);

% Account for delay of filter (Twice delay because signal goes through 2 filtering stages)
% yrx_bb_mf_ds_1 = yrx_bb_mf_ds_1(1:end-2*delay); 
yrx_bb_mf_ds_2 = yrx_bb_mf_ds_2(1:end-2*delay); 
% yrx_bb_mf_ds_3 = yrx_bb_mf_ds_3(1:end-2*delay); 
% yrx_bb_mf_ds_4 = yrx_bb_mf_ds_4(1:end-2*delay); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Alamouti Combining
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% An even number of symbols was encoded, the number of symbols encoded is 
% equal to syms2encode. Slice yrx_bb_mf_ds vectors to match syms2encode
% symbols per vector.
% yrx_bb_mf_ds_1 = yrx_bb_mf_ds_1(1:syms2encode); 
yrx_bb_mf_ds_2 = yrx_bb_mf_ds_2(1:syms2encode); 
% yrx_bb_mf_ds_3 = yrx_bb_mf_ds_3(1:syms2encode); 
% yrx_bb_mf_ds_4 = yrx_bb_mf_ds_4(1:syms2encode); 

% Reshape matrix of symbols to facilitate Alamouti combining. 
% Row 1 contains signal received in slot 1 of Alamouti scheme and row 2
% contains signal received in slot 2 of Alamouti scheme.
yrx_bb_mf_ds_2_R = reshape(yrx_bb_mf_ds_2,2,syms2encode/2);

% Conjugate of second row (second slot) as per Alamouti combining scheme
yrx_bb_mf_ds_2_R(2,:) = conj(yrx_bb_mf_ds_2_R(2,:));

% Generate Almouti combining matrix (ACM) and normalizing vector
alm_comb = [conj(CE(1)), CE(2); conj(CE(2)), -CE(1)];
alm_norm = [CE(1),CE(2)]*[CE(1),CE(2)]';

% Alamouti combining
yrx_bb_mf_ds_alm = alm_comb * yrx_bb_mf_ds_2_R;

% Reshape to obtain stream of received symbols
yrx_bb_mf_ds_alm_R = reshape(yrx_bb_mf_ds_alm,1,syms2encode);

% Normalize
yrx_bb_mf_ds_alm_norm = yrx_bb_mf_ds_alm_R / alm_norm * scale_Payload * sqrt(Num_Tx);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Demodulate and recover the transmitted bitstream
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Demodulate signal using DQPSK
zsym = dpskdemod(yrx_bb_mf_ds_alm_norm.',M);

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

% Plot transmitted and received constellations

% Scatter Plot of received and transmitted constellation points
% h = scatterplot(yrx_bb_mf_ds(nsym_preamble+1:end),1,0,'g.');
h = scatterplot(yrx_bb_mf_ds_alm_norm,1,0,'g.');
hold on;
%scatterplot(ytx_mod(nsym_preamble+1:end),1,0,'k*',h);
scatterplot(ytx_mod,1,0,'k*',h);
title('Constellations');
legend('Received','Transmitted');
axis([-2 2 -2 2]); % Set axis ranges.
hold off;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 7. Compute the Bit Error Rate (BER)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compare x and z to obtain the number of errors and the bit error rate
[number_of_errors,bit_error_rate] = biterr(x(3:length(z)),z(3:length(z)))
% We start comparing at three because the first two bits are always
% lost in DQPSK. We compare until length(z) because z may be shorter than
% x due to the fact that some bits (approx 1 to 5) may be lost fue to the 
% jitter of the synch pulse.