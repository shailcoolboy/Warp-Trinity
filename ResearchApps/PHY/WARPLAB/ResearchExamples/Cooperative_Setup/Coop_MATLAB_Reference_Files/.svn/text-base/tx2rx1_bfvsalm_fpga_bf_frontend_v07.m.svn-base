%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Using Warplab to Transmit Beamformed Almouti symbols over a 
% Wireless Channel.
% Three beamforming schemes are tested, they are labeled as BF1,BF2,BF3
% BF1: 2x1 Beamforming with 2 bits of feedback using Grassmannian codebook
% BF2: 2x1 Beamforming with 2 bits of feedback using USTC codebook
% BF3: 2x1 Beamforming with infinite bits of feedback
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% INITIAL CODE SHARED BY THE THREE BEAMFORMING SCHEMES AND ALAMOUTI SCHEME
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Define parameters, create pulse shaping filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The samples to be transmitted are structured in the following way:
% Short Training: 320 samples @40MHz
% Long Training: 320 smaples @40MHz
% Guard Interval: 32 smaples @40MHz
% Preamble : Short Training + Long Training + Guard Interval = 672 samples
% @40MHz
% Pilots: Number of smaples varies depending on parameters specified below
% Payload: Number of payload samples is variable

% Define Wireless Channel Parameters
channel_select = 1;
% If channel_select = 0 the signal is transmitted over a channel generated
% in MATLAB
% If channel_select = 1 the signal is transmitted over a real wireless
% channel using the WARPLab framework to transmit and receive using WARP
% boards
noise_select = 0;
% The noise select signal is relevant only when channel_select = 0.
% If noise_select = 0 (and channel_select=0) then no noise is added to
% the signal
% If noise_select = 1 (and channel_select=0) then AWGN noise is added to
% the signal
perfect_channel_estimate_select = 1;
% The perfect_channel_estimate_select signal is relevant only when
% channel_select = 0 and noise_select = 1.
% If perfect_channel_estimate_select = 1 (and channel_select=0 noise_select=1) then 
% the Channel estimate is noiseless (no noise is added to pilots for channel
% estimate but pilots do go through fading channel)
% If perfect_channel_estimate_select = 0 (and channel_select=0 noise_select=1) then
% noise is added to pilots used for channel estimate
perfect_training_select = 1;
% The perfect_training_select signal is relevant only when 
% channel_select = 0 and noise_select = 1.
% If perfect_training_select = 1 (and channel_select=0) then 
% the received training signal is noiseless (no noise is added to training but 
% training does go through a fading channel).
% If perfect_training_select = 0 (and channel_select=0) then
% the received training is noisy 
channel_emulator_select = 1;
% If channel_emulator_select = 1 it means we are using the channel
% emmulator and since these adds some delay then more samples need to be
% read when the beamforming pilots are read for channel quantization
channel_emulator_remote_select = 1;
% If channel_emulator_remote_select = 1 means that we are setting the
% emulator command via remote command. If channel_emulator_remote_select =
% 1; then channel_emulator_select must be equal to 1 otherwise there 
% will be an error. 
% NOTE: Never set channel_emulator_select = 0 and channel_emulator_remote_select = 1;
% This makes no sense and code will problably crash or do wird things
AzimuthSpirent_select = 0; 
% If AzimuthSpirent_select = 1 means that we are using the Azimuth channel
% emulator. If AzimuthSpirent_select = 0 means that we are using the
% Spirent emulator. AzimuthSpirent_select variable is ony relevant if
% channel_emulator_select=1
front_end_FPGA = 0;
% The front_end_FPGA signal is relevant only when channel_select=1
% If front_end_FPGA = 1 then the front end processing (DC Offset correction, 
% Timing Sync and channel estimation) is computed in real time in the FPGA.
% If front_end_FPGA = 0 then the front end processing (DC Offset correction, 
% Timing Sync and channel estimation) is computed in offline in MATLAB.
% For experiments I'm always setting front_end_FPGA = 0; Didn't get to
% verify if worse performance when front_end_FPGA = 1; was simply due to
% fixed point processing or some bug in the code. For the experiments I
% finally decided to set front_end_FPGA = 0 (never used this option,
% doesn't make a big difference in speed since we speed up the Rx buffer read)

% Define MIMO parameters 
Num_Tx = 2; % Do not change this value, code will only run for 2 Tx antennas
Num_Rx = 1; % Do not change this value, code will only run for 1 Rx antenna

% Load Codebooks to be used
% Use below xxx lines of code to load codebooks when running MATLAB
% locally. % Codebook is only used for Beamforming (not for Alamouti)
load('Codebooks\Grassmannian\codebook_2_4vec_Grassm','codebook_2_4vec_Grassm_original');
CodebookBF1 = codebook_2_4vec_Grassm_original;
load('Codebooks\USTC\codebook_2_4vec_USTC','codebook_2_4vec_USTC_original');
CodebookBF2 = codebook_2_4vec_USTC_original;
% Use below two lines of code to load codebooks when using this script in sugar. When using sugar
% workers comment out above two lines and beow two lines
%load('Codebooks/Grassmannian/codebook_2_4vec_Grassm','codebook_2_4vec_Grassm_original');
%Codebook_Original = codebook_2_4vec_Grassm_original; % Codebook is only used for Beamforming (not for Alamouti)


% Define Pilot parameters 
n_ChanEst = 1; % Number of times the pilot sequence for channel estimation will be transmitted
nsamp_PerAntPerChanEst = 128; % Number of samples per antenna per channel estimate
nsamp_Pilots = nsamp_PerAntPerChanEst*n_ChanEst*Num_Tx;
nsamp_TGP = 672+nsamp_Pilots; % Number of samples for training, guard 
                              % interval and pilots
                              % Short training, long training and guard
                              % interval correspond to first 672 samples

% Define modulation parameters 
M = 16; % Size of signal constellation. Maxim possble, M=16. Some normalizations in the code (some of them done just to save storage space) won't work with larger constellations
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

% Use MATLABs rayleigh fading channel function. Create a channel object
% Channel =  rayleighchan(1/40e6,0,[0,0.05e-6,0.1e-6],[0,-3.6,-7.2]);
% Channel1 =  rayleighchan(1/40e6,0);
% Channel2 =  rayleighchan(1/40e6,0);
Channel1 =  rayleighchan(1/40e6,0.1,[0,0.05e-6,0.1e-6],[0,-3.6,-7.2]);
Channel2 =  rayleighchan(1/40e6,0.1,[0,0.05e-6,0.1e-6],[0,-3.6,-7.2]);
Channel1.ResetBeforeFiltering = 0;
Channel2.ResetBeforeFiltering = 0;
% warplabdelay_sec = 60e-3; % In seconds, Warplab feedback delay for beamforming, will be emulated in simulation
warplabdelay_sec = 0; % In seconds, Warplab feedback delay for beamforming, will be emulated in simulation
warplabdelay_samp = warplabdelay_sec*40e6; % In samples (f sampling = 40e6), Warplab feedback delay for beamforming, will be emulated in simulation


% Define number of payload samples, symbols, and bits to transmit
% The Warplab transmit buffer can store a maximum of 2^14 samples; a number
% of samples equal to nsamp_TGP is reserved for training, guard interval, and
% pilots. Consequently, the total number of samples avaliable for
% payload data is 2^14-nsamp_TGP-100. We substract extra 100 to 
% account for jitter in sync trigger.
max_nsamp_Payload = 2^14-nsamp_TGP-100; 
if (1 == channel_emulator_select)
    max_nsamp_Payload = 2^14-nsamp_TGP-200; % Spirent emulator adds a delay of around 200 samples
    % so send 200 samples less than the total size of the Tx buffer
    % A value of max_nsamp_Payload = 2^14-nsamp_TGP-200 is valid
    % for Azimuth and Spirent emulator (Azimuth delay between 50-100 samples.
    % Spirent delay around 200 smaples)
end
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

if(1 == channel_select)
    
    % Define some general WARPLab parameters
    % Load some global definitions (packet types, etc.)
    warplab_defines_AGC
    % Create Socket handles and intialize nodes
    [socketHandles, packetNum] = warplab_initialize;
    % Separate the socket handles for easier access
    % The first socket handle is always the magic SYNC
    % The rest can be arranged in any combination of Tx and Rx
    udp_Sync = socketHandles(1);
    udp_node1 = socketHandles(2);
    udp_node2 = socketHandles(3);
    % Define the warplab options (parameters)
    TxDelay = 0; %Number of noise samples per Rx capture; in [0:2^14]
    TxLength = 2^14-1; %Total of samples to transmit; in [0:2^14-TxDelay-1]
    CarrierChannel = 3; % Channel in the 2.4 GHz band. In [1:14]
    TxMode = 0; % Disable continuous transmission mode
%     Node1_Radio1_TxGain_BB = 3; % Tx Baseband Gain. In [0:3]
%     Node1_Radio1_TxGain_RF = 40; % Tx RF Gain. In [0:63]
%     Node1_Radio2_TxGain_BB = 3; % Tx Baseband Gain. In [0:3]
%     Node1_Radio2_TxGain_RF = 40; % Tx RF Gain. In [0:63]
%     Node1_Radio3_TxGain_BB = 3; % Tx Baseband Gain. In [0:3]
%     Node1_Radio3_TxGain_RF = 40; % Tx RF Gain. In [0:63]
%     Node1_Radio4_TxGain_BB = 3; % Tx Baseband Gain. In [0:3]
%     Node1_Radio4_TxGain_RF = 40; % Tx RF Gain. In [0:63]

    % Define some Beamforming and Front End processing parameters
    % MGC_AGC_Select = 1; % In this experiment we always use the AGC
    nsamp_LongCorr_Window = 640; % After AGC is done we search the next 640 samples in order to get LongCorr symbols for timing sync
                                 % If LongCorr is not detected in these 640 samples then timing sync was not achieved and we can not decode
    LongCorr_Threshold = 3000; % Threshold to detect LongCorr symbols
    Two_LongCorr_Required = 1; % We always require two LongCorr peaks separated by 64 samples @ 20MHz (LongDetection block runs slower)
    num_TxAntennas_Sending_Pilots = Num_Tx; % For all the experiments all the transmitter antennas will send pilots
    Order_Pilot_Transmission = [2,3,0,0]; % Vector of 4 entries: Entry 1: Index of radio that sends first pilot tone - Entry 2: Index of radio that sends second pilot tone - etc
    Order_Pilot_Transmission_Grouped = Order_Pilot_Transmission *[2^0,2^3,2^6,2^9]';
    % Define some AGC parameters
    Node2_TargetdBmAGC = -10; %Using -8 b/c too many overflows with -6 (using channel emulator) % AGC's target dBm. original: -6 (-10 option2 -wideband preamble)
    Node2_NoiseEstdBmAGC = -95; % AGC's Noise Estimate in dBm original: -95
    % Note: For this experiment node 1 will be set as the transmitter and node 
    % 2 will be set as the receiver (this is done later in the code), hence, 
    % there is no need to define receive gains for node 1, there is no
    % need to define transmitter gains for node 2, and there is no need to
    % define AGC parameters for node 1
    % Define AGC thresholds:
    if (1 == front_end_FPGA)
        MGC_AGC_Select = 1;
        DCOffset_FPGA_Enabled = 1;
    else
        MGC_AGC_Select = 1;
        DCOffset_FPGA_Enabled = 1;
    end
    Thresh1 = -90;
    Thresh2 = -63;
    Thresh3 = -43;
    % Change format of Thresholds so they can be correctly understood by
    % the FPGA:
    Thresholds = uint32(Thresh3+2^8)*2^16+uint32(Thresh2+2^8)*2^8+uint32(Thresh1+2^8);
   
    if (1 == channel_emulator_select)
        if(0==AzimuthSpirent_select)
            agc_trigger_nsamp_delay = 200; % Spirent emulator adds a delay of around 200 samples
            % so start AGC 200 samples after magic sync is received
        end
        if(1==AzimuthSpirent_select)
            agc_trigger_nsamp_delay = 100; % Azimuth emulator adds a delay of around 100 samples
            % so start AGC 100 samples after magic sync is received
        end
    else
         agc_trigger_nsamp_delay = 60; % If emulator is not used, then 
         % start AGC 50 samples after magic sync is received. This will
         % make sure AGC is not started before the signal arrives 
         %(because of jitter in the magic sync the receiver may get magic 
         % before transmitter, adding a delay will make sure that even in 
         % this case the AGC wont start before the signal starts to arrive)
         % Via experiments we have determined  agc_trigger_nsamp_delay=60
         % works well;
    end

    % Download the WARPLab parameters to the WARP nodes. 
    % The nodes store the TxDelay, TxLength, and TxMode parameters in 
    % registers defined in the WARPLab sysgen model. The nodes set radio 
    % related parameters CarrierChannel, TxGains, and RxGains, using the 
    % radio controller functions. The nodes store the TargetdBmAGC and
    % NoiseEstdBmAGC parameters in registers in the AGC sysgen model.
    % The TxDelay, TxLength and TxMode parameters need to be known at the transmitter;
    % the receiver doesn't require knowledge of these parameters (the receiver
    % will always capture 2^14 samples). For this exercise node 1 will be set as
    % the transmitter (this is done later in the code). Since TxDelay, TxLength and
    % TxMode are only required at the transmitter we download the TxDelay, TxLength and
    % TxMode parameters only to the transmitter node (node 1).
    warplab_writeRegister(udp_node1,TX_DELAY,TxDelay);
    warplab_writeRegister(udp_node1,TX_LENGTH,TxLength);
    warplab_writeRegister(udp_node1,TX_MODE,TxMode);
    % The CarrierChannel parameter must be downloaded to all nodes  
    warplab_setRadioAGCParameter(udp_node1,CARRIER_CHANNEL,CarrierChannel);
    warplab_setRadioAGCParameter(udp_node2,CARRIER_CHANNEL,CarrierChannel);
    % Download parameters to the receiver node upd_node2
    warplab_writeRegister(udp_node2,MGC_AGC_SEL,MGC_AGC_Select);
    warplab_writeRegister(udp_node2,N_SAMPS_LONG_CORR_WINDOW,nsamp_LongCorr_Window);
    warplab_writeRegister(udp_node2,LONG_CORR_THRESH,LongCorr_Threshold);
    warplab_writeRegister(udp_node2,REQ_TWO_LONG_CORR,Two_LongCorr_Required);
    warplab_writeRegister(udp_node2,NUM_TX_ANT_SENDING_PILOTS,num_TxAntennas_Sending_Pilots);
    warplab_writeRegister(udp_node2,PILOT_ORDER,Order_Pilot_Transmission_Grouped);
    % Node 1 will be set as the transmitter so download Tx gains to node 1.
%     warplab_setRadioAGCParameter(udp_node1,RADIO1_TXGAINS,(Node1_Radio1_TxGain_RF + Node1_Radio1_TxGain_BB*2^16));
%     warplab_setRadioAGCParameter(udp_node1,RADIO2_TXGAINS,(Node1_Radio2_TxGain_RF + Node1_Radio2_TxGain_BB*2^16));
%     warplab_setRadioAGCParameter(udp_node1,RADIO3_TXGAINS,(Node1_Radio3_TxGain_RF + Node1_Radio3_TxGain_BB*2^16));
%     warplab_setRadioAGCParameter(udp_node1,RADIO4_TXGAINS,(Node1_Radio4_TxGain_RF + Node1_Radio4_TxGain_BB*2^16));
    % Download AGC parameters to node 2
    warplab_setRadioAGCParameter(udp_node2,SET_AGC_TARGET_dBm,Node2_TargetdBmAGC);
    warplab_setRadioAGCParameter(udp_node2,SET_AGC_NOISEEST_dBm,Node2_NoiseEstdBmAGC);
    warplab_setRadioAGCParameter(udp_node2,AGC_DCO_EN,DCOffset_FPGA_Enabled);
    warplab_setRadioAGCParameter(udp_node2,SET_AGC_TRIG_DELAY,agc_trigger_nsamp_delay);
%     warplab_setRadioAGCParameter(udp_node2,SET_AGC_THRESHOLDS,Thresholds);
end

if (1 == channel_emulator_remote_select)
    if(0==AzimuthSpirent_select)
        % Connect to Spirent Emulator. Load channel charateristics.
        % Create emulator handle
        sr5500_test;
        pause(2);
        % Download profile to emulator
        pnet(emulatorHandle, 'printf', 'frec c:\\MD_OfficeA_Ds01_CH3.wce\r');
        pause(30)
        pnet(emulatorHandle, 'printf', 'err?\r');
        pnet(emulatorHandle,'read');
        % Set Input power channel 1
        pnet(emulatorHandle, 'printf', 'chan1:ipow -19.42\r');
        pnet(emulatorHandle, 'printf', 'err?\r');
        pnet(emulatorHandle,'read')
        % Set Input power channel 2
        pnet(emulatorHandle, 'printf', 'chan2:ipow -21.92\r');
        pnet(emulatorHandle, 'printf', 'err?\r');
        pnet(emulatorHandle,'read')
    end
    if(1==AzimuthSpirent_select)
        % Connec to Azimuth Emulator.
        % Create emulator handle
        ACE400WB_test;
    
        pause(2)
        pnet(emulatorHandle, 'printf', '00 ace_set_input_power C1-A {11 11 11 11}\r');
        data='';
        while (strcmp(data,''))
            data=pnet(emulatorHandle,'read');
            pause(1)
        end
        fprintf('\n%s', data);
    end
end
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

% We only have one receive antenna, create a matrix of pilot tones that
% will be used for channel estimation
Pilot_Tone_Matrix = repmat(pilot_tone.',1,Num_Tx);
Pilot_Tone_Matrix_ForChEst = conj(Pilot_Tone_Matrix)./(abs(Pilot_Tone_Matrix).^2); % Compute this matrix before hand to speed Channel Estimation processing
nsamp_SliceOutChEst = 10; % Will ignore the first nsamp_SliceOutChEst and last nsamp_SliceOutChEst samples in the pilots received from each antenna. This is because first and last samples mey have some distortion due to transients and beginning of transmission.
mask_SliceOutChEst = ones(nsamp_PerAntPerChanEst,1);
mask_SliceOutChEst(1:nsamp_SliceOutChEst) = zeros(1,nsamp_SliceOutChEst);
mask_SliceOutChEst(end-nsamp_SliceOutChEst+1:end) = zeros(1,nsamp_SliceOutChEst);
mask_SliceOutChEst = repmat(mask_SliceOutChEst,1,Num_Tx);
scale_ChannelEstimate = 1/(n_ChanEst*nsamp_PerAntPerChanEst-2*nsamp_SliceOutChEst); % Compute this scaling value before hand to speed Channel Estimation processing
Pilot_Tone_Matrix_ForChEst_scaled = (Pilot_Tone_Matrix_ForChEst.*mask_SliceOutChEst) * scale_ChannelEstimate;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Generate long training symbols
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Call WARPLab function that generates long training symbols
[LongTrainingSyms_up2,LongSymbol_time_up2,LongSymbol_time,LongSymbol_freq,scale_LongTrainingSyms] = warplab_generateLongTrainSyms;
% Added division by sqrt(2) for unit power Tx: (normalized by sqrt(Num_Tx))
[LongTrainingSyms_up2_norm] = [LongTrainingSyms_up2]/sqrt(Num_Tx);
[LongSymbol_time_up2_norm] = [LongSymbol_time_up2]/sqrt(Num_Tx);
[LongSymbol_time_norm] = [LongSymbol_time]/sqrt(Num_Tx);
[LongSymbol_freq_norm] = [LongSymbol_freq]/sqrt(Num_Tx);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Generate short training symbols
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% shortSymbol_freq_80211 = [0 0 0 0 0 0 0 0 1+i 0 0 0 -1+i 0 0 0 -1-i 0 0 0 1-i 0 0 0 -1-i 0 0 0 1-i 0 0 0 0 0 0 0 1-i 0 0 0 -1-i 0 0 0 1-i 0 0 0 -1-i 0 0 0 -1+i 0 0 0 1+i 0 0 0 0 0 0 0].';
% shortSymbol_freq = shortSymbol_freq_80211;
shortSymbol_freq = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1-i 0 0 0 0 0 0 0 1-i 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0].';
% Take IFFT of preamble and create short symbols as per 802.11 standard
shortSymbol_time = ifft(fftshift(shortSymbol_freq));
shortSymbol_time = shortSymbol_time(1:16).';
shortsyms_10 = repmat(shortSymbol_time,1,10);
preamble_I = real(shortsyms_10);
preamble_Q = imag(shortsyms_10);
% Upsample by 2 so the standard preamble occupies a bandwith of +-10MHz (if 
% the freq content of the preamble is as in the 802.11 standard)
[preamble_I_up2] = interp(preamble_I, 2);%(2.85/(10*0.0313))*interp(preamble_I, 2);
[preamble_Q_up2] = interp(preamble_Q, 2);%(2.85/(10*0.0313))*interp(preamble_Q, 2);
% Scale to span -1,1 range of DAC
scale_ShortSyms = max([ max(abs(preamble_I_up2)), max(abs(preamble_Q_up2)) ]);
[preamble_I_up2] = (1/scale_ShortSyms)*preamble_I_up2;
[preamble_Q_up2] = (1/scale_ShortSyms)*preamble_Q_up2;

% Added division by sqrt(2) for unit power Tx: (normalized by sqrt(Num_Tx))
ShortTrainingSyms_up2 = (preamble_I_up2 + sqrt(-1)*preamble_Q_up2);
ShortTrainingSyms_up2_norm = ShortTrainingSyms_up2/sqrt(Num_Tx);
% Added division by sqrt(2) for unit power Tx
% ShortTrainingSyms_up2 = (preamble_I_up2 + sqrt(-1)*preamble_Q_up2);

% %%% Testing if tone at 625KHz works better for preamble
% timevec = 0:1/40e6:(320-1)/40e6;
% ShortTrainingSyms_up2 = exp(sqrt(-1)*2*pi*625e3*timevec);
% %%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. Concatenate short training symbols, long training symbols, 
% guard interval, and pilots
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Training Guard Pilots with normalized training
% TrainGuardPilots_1 = [ShortTrainingSyms_up2, LongTrainingSyms_up2, zeros(1,32), Pilots_1];
TrainGuardPilots_2_norm = [ShortTrainingSyms_up2_norm, LongTrainingSyms_up2_norm, zeros(1,32), Pilots_2];
TrainGuardPilots_3_norm = [ShortTrainingSyms_up2_norm, LongTrainingSyms_up2_norm, zeros(1,32), Pilots_3];
% TrainGuardPilots_4 = [ShortTrainingSyms_up2, LongTrainingSyms_up2, zeros(1,32), Pilots_4];

% Training Guard Pilots without normalized training
TrainGuardPilots_2 = [ShortTrainingSyms_up2, LongTrainingSyms_up2, zeros(1,32), Pilots_2];
TrainGuardPilots_3 = [ShortTrainingSyms_up2, LongTrainingSyms_up2, zeros(1,32), Pilots_3];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Each transmission is limited to 2^14 samples. Do a for loop to gather
% statistics. In each loop 2^14 samples are transmitted.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Default Loops
Total_Loops = 1;
Total_Loops_Vec = 1;

% Define parameters used when channel is simulated (channel_select = 0) and
% the channel is noisy (noise_select = 1)
if(0 == channel_select)
    if (1 == noise_select)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%% BEFORE March 25 2009 I WAS USING EbNo for offline sims, now I'm
        %%% using EsNo
        % WHEN CHANNEL IS SIMULATED THE VALUES BELOW ARE USED TO SET THE
        % SNR AND TOTAL BITS TRANSMITTED
%         EbNodB = [-4,-2,0,2,4,6,8]; % EbNo values. The constellation will be scaled
%         EbNodB = [4,8,12,16,20,24,28,32,34]; % EbNo values. The
%         constellation will be scaled
%           EbNodB = [12,14,16,18,20,22]; % EbNo values. The constellation will be scaled
%         EbNodB = [0,10,15]; % EbNo values. The constellation will be scaled
% % % %         EbNodB = [4,6,8,10,12,14,16,18,20,22,24]; % EbNo values. The constellation will be scaled
% EbNodB=[-4,0,4];
        % such that the Energy per symbol is equal to 1: Es=1. Eb = Es/k.
%         Total_Bits_perEbNodB = [2.5e5,1e6,2e6];
%         Total_Bits_perEbNodB = [1e5,2.5e5,5e5];
%           Total_Bits_perEbNodB = [5e5,1e6,2e6,3.5e6,5e6,7e6];
%         Total_Bits_perEbNodB = [2e6,3e6,4e6,5e6,6e6,7e6];
%         Total_Bits_perEbNodB = [5e5,5e5,1e6,1e6,2e6,2e6,3e6];
%         Total_Bits_perEbNodB = [1e6,1e6,2e6,2e6,3e6,3e6,4e6,4e6,6e6];
%         Total_Bits_perEbNodB = [3e6,4e6,4.5e6,5.5e6,6.5e6,7.5e6];
%         Total_Bits_perEbNodB = [220,220,220,220,220,220];
%         Total_Bits_perEbNodB = [1e4, 1e4, 1e4, 1e4, 1e4, 1e4, 1e4 ,1e4];
%         Total_Bits_perEbNodB = [2e6,2.5e6,3e6,4e6,4.5e6,5e6,5.5e6];        
%         Total_Bits_perEbNodB = [1e6,1e6,2e6,2.5e6,3e6,4e6,4.5e6,5e6,5.5e6,6e6,6.5e6];
%         Total_Bits_perEbNodB = [1e0,1e0,2e0,2.5e0,3e0,4e0,4.5e0,5e0,5.5e0,6e0,6.5e0]*1e2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Since March 25 2009 I'm using EsNo for offline simulations
        EsNodB = [12,16,20,24,28,32,36]; % EsNodB values. 
%         EsNodB = [23,27,31]; % EsNodB values. 
%         EsNodB = [24,28]; % EsNodB values. 
%         Total_Bits_perEsNodB = [1e5,1e5,5e5,1e6,3e6,3e6,6e6];        
%         Total_Bits_perEsNodB = [3e6,5e6]; 
%        Total_Bits_perEsNodB = [1e5,1e5,2e5,1e6,2e6,4e6,6e6,6e6,6e6]/25; 
%         Total_Bits_perEsNodB = [2e5,2e5,4e5,2e6,4e6,8e6,12e6,12e6,12e6]/(100*32); 
%         Total_Bits_perEsNodB = [1e5,2e5,4e5,8e5,2e6,3e6,5e6]; 
        Total_Bits_perEsNodB = [1e5]; 
%         Total_Bits_perEsNodB = [3e6,4e6];       
%         Total_Bits_perEsNodB = [3000];        
%         Total_Bits_perEsNodB = [20000,20000,20000,20000,20000,20000];
        Total_Loops_Vec = ceil(Total_Bits_perEsNodB/nbits);
    end
end


% Define parameters used when channel is real wireless channel.
if(1 == channel_select)
    if(1==channel_emulator_remote_select)
        % WHEN USING THE CHANNEL EMULATOR REMOTE CONNECTION THE VALUES BELOW ARE USED
        % TO SET THE SNR (By changig the emulator's output power and setting the
        % WARP node output power to a fixed value) AND TOTAL
        % BITS TRANSMITTED
        
        if(0==AzimuthSpirent_select)
            % This is the code used if we are using the Spirent emulator
            
            % When using the Spirent emulator we add the output of the two
            % RF channels externally using an RF combiner.
            % Since we use the two RF outputs of the Spirent emulator, we
            % must set two output powers
            
            %%%% Output power used for 16QAM experiments
            Emu_Out_Power_Ch1 = ['chan1:pow -62.00\r';'chan1:pow -58.00\r';'chan1:pow -54.00\r';'chan1:pow -50.00\r';'chan1:pow -46.00\r'];
            Emu_Out_Power_Ch2 = ['chan2:pow -62.00\r';'chan2:pow -58.00\r';'chan2:pow -54.00\r';'chan2:pow -50.00\r';'chan2:pow -46.00\r'];
        
            %%%% Output power used for QPSK experiments
%           Emu_Out_Power_Ch1 = ['chan1:pow -70.00\r';'chan1:pow -66.00\r';'chan1:pow -62.00\r';'chan1:pow -58.00\r';'chan1:pow -54.00\r'];
%           Emu_Out_Power_Ch2 = ['chan2:pow -70.00\r';'chan2:pow -66.00\r';'chan2:pow -62.00\r';'chan2:pow -58.00\r';'chan2:pow -54.00\r'];

            % Set Tx output power
            Node1_Radio2_TxGain_BB = [3]; % Tx Baseband Gain. In [0:3]
            Node1_Radio2_TxGain_RF = [40]; % Tx RF Gain. In [0:63]
            Node1_Radio3_TxGain_BB = [3]; % Tx Baseband Gain. In [0:3]
            Node1_Radio3_TxGain_RF = [40]; % Tx RF Gain. In [0:63]
            warplab_setRadioAGCParameter(udp_node1,RADIO2_TXGAINS,(Node1_Radio2_TxGain_RF + Node1_Radio2_TxGain_BB*2^16));
            warplab_setRadioAGCParameter(udp_node1,RADIO3_TXGAINS,(Node1_Radio3_TxGain_RF + Node1_Radio3_TxGain_BB*2^16));
    
            %%%% Total bits used for 16QAM experiments
%             Total_Bits_perTxGain = [2e5,5e5,1e6,2e6,4e6];
        
            %%%% Total bits used for QPSK experiments
%           Total_Bits_perTxGain = [2e5,5e5,1e6,2e6,4e6]/2;

            %%%% Total bits used in short experiments
          Total_Bits_perTxGain = [1e5,2.5e5,4e5];

            Total_Loops_Vec = ceil(Total_Bits_perTxGain/nbits);
        end
        if(1==AzimuthSpirent_select)
            % This is the code used if we are using the Azimuth emulator
            
            % When we use the Azimuth emulator we ony use one RF output.
            % The emulator takes care of adding signals to create a 2x1
            % MISO channel. Since we only use one RF output we only  need
            % to set one output power
            
            %%%% Output power used for 16QAM experiments
            Emu_Out_Power_Ch1 = ['00 atten_set C1 28\r'; '00 atten_set C1 24\r'; '00 atten_set C1 20\r'; '00 atten_set C1 16\r'; '00 atten_set C1 12\r'];

            % Set Tx output power
            Node1_Radio2_TxGain_BB = [3]; % Tx Baseband Gain. In [0:3]
            Node1_Radio2_TxGain_RF = [40]; % Tx RF Gain. In [0:63]
            Node1_Radio3_TxGain_BB = [3]; % Tx Baseband Gain. In [0:3]
            Node1_Radio3_TxGain_RF = [40]; % Tx RF Gain. In [0:63]
            warplab_setRadioAGCParameter(udp_node1,RADIO2_TXGAINS,(Node1_Radio2_TxGain_RF + Node1_Radio2_TxGain_BB*2^16));
            warplab_setRadioAGCParameter(udp_node1,RADIO3_TXGAINS,(Node1_Radio3_TxGain_RF + Node1_Radio3_TxGain_BB*2^16));
    
            %%%% Total bits used for 16QAM experiments
            Total_Bits_perTxGain = [2e5,5e5,1e6,2e6,4e6];
            
            %%%% Total bits used in short experiments
%             Total_Bits_perTxGain = [70000,70000];
    
            Total_Loops_Vec = ceil(Total_Bits_perTxGain/nbits);
        end
    else
      % WHEN CHANNEL IS A REAL WIRELESS CHANNEL OR THE EMULATOR CHANNEL USING THE 
      % TESTKIT (No server or reomte connection), THE VALUES BELOW ARE USED 
      % TO SET THE SNR (By changing transmission power) AND TOTAL BITS TRANSMITTED
%       Node1_Radio2_TxGain_BB = [3, 3, 3, 3] ; % Tx Baseband Gain. In [0:3]
%       Node1_Radio2_TxGain_RF = [40, 44, 48, 52]; % Tx RF Gain. In [0:63]
%       Node1_Radio3_TxGain_BB = [3, 0, 0, 0]; % Tx Baseband Gain. In [0:3]
%       Node1_Radio3_TxGain_RF = [40, 44, 48, 52]; % Tx RF Gain. In [0:63]
%       Node1_Radio2_TxGain_BB = [3,3,3,3,3]; % Tx Baseband Gain. In [0:3]
%       Node1_Radio2_TxGain_RF = [6,8,10,12,14]; % Tx RF Gain. In [0:63]
%       Node1_Radio3_TxGain_BB = [3,3,3,3,3]; % Tx Baseband Gain. In [0:3]
%       Node1_Radio3_TxGain_RF = [6,8,10,12,14]; % Tx RF Gain. In [0:63]
%       Node1_Radio2_TxGain_BB = [1,1,1,1,1]; % Tx Baseband Gain. In [0:3]
%       Node1_Radio2_TxGain_RF = [12,14]; % Tx RF Gain. In [0:63]
%       Node1_Radio3_TxGain_BB = [1,1,1,1,1]; % Tx Baseband Gain. In [0:3]
%       Node1_Radio3_TxGain_RF = [12,14]; % Tx RF Gain. In [0:63]
%       Node1_Radio2_TxGain_BB = [3,3,3,3,3]; % Tx Baseband Gain. In [0:3]
%       Node1_Radio2_TxGain_RF = [36,38,40,42,44]; % Tx RF Gain. In [0:63]
%       Node1_Radio3_TxGain_BB = [3,3,3,3,3]; % Tx Baseband Gain. In [0:3]
%       Node1_Radio3_TxGain_RF = [36,38,40,42,44]; % Tx RF Gain. In [0:63]
        Node1_Radio2_TxGain_BB = [3,3,2,2]; % Tx Baseband Gain. In [0:3]
        Node1_Radio2_TxGain_RF = [40,40,30,35]; % Tx RF Gain. In [0:63]
        Node1_Radio3_TxGain_BB = [3,3,2,2]; % Tx Baseband Gain. In [0:3]
        Node1_Radio3_TxGain_RF = [40,40,30,35]; % Tx RF Gain. In [0:63]
%       Total_Bits_perTxGain = [1e6,1.5e6,2e6,2.5e6,3e6,3.5e6];
%       Total_Bits_perTxGain = [1e6,1e6,1e6,2e6,2e6];
%       Total_Bits_perTxGain = [50000,50000,50000,100000];
%       Total_Bits_perTxGain = [5e5,1.2e6,3e6];
%       Total_Bits_perTxGain = [1e6,2.5e6,4e6];
%       Total_Bits_perTxGain = [100000,100000,100000,100000,100000];
%       Total_Bits_perTxGain = [2e6,2.5e6,3.5e6,4e6,5e6,6e6];
%       Total_Bits_perTxGain = [5000,5000,5000];
%       Total_Bits_perTxGain = [1e4,1e4,1e4];
%       Total_Bits_perTxGain = [1e0,1e0,1e0,1e0,1e0];
%       Total_Bits_perTxGain = [5e5,5e5,5e5,5e5,5e5];
%       Total_Bits_perTxGain = [1e6,1e6,1e6,1e6,1e6];
%       Total_Bits_perTxGain = [2.5e5,5e5,1.5e6,4e6];
        Total_Bits_perTxGain = [1000];
%       Total_Bits_perTxGain = [2000,2000,2000,2000,2000,2000,2000,2000];
        Total_Loops_Vec = ceil(Total_Bits_perTxGain/nbits);
    end
end



% Compute length of Total_Loops_Vec
len_Total_Loops_Vec = length(Total_Loops_Vec);

% Choose between dpsk or qam
dpskqam_select = 1; % dpskqam_select = 0: use dpsk, dpskqam_select = 1: use qam 

swarning=warning('off','MATLAB:divideByZero');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% VARIABLES TO STORE BF1 STATISTICS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Result_Total_Bits_Vec_BF1_CoherentChannels = 0;
Result_Total_Errors_Vec_BF1_CoherentChannels = 0;
Result_Total_Bits_Vec_BF1_CoherentChannels_NonSat = 0;
Result_Total_Errors_Vec_BF1_CoherentChannels_NonSat = 0;
Result_BER_BF1_CoherentChannels = 0;
Result_BER_BF1_CoherentChannels_NonSat = 0;
Result_Channel_Gain_Init_Vec_BF1_CoherentChannels = 0;
Result_Channel_Gain_BF1_Vec_BF1_CoherentChannels = 0;
Result_Avg_Noise_Power_Vec_BF1_CoherentChannels = 0;
Result_Avg_Signal_Power_Vec_BF1_CoherentChannels = 0;
Result_Avg_SignalToNoiseRatio_Vec_BF1_CoherentChannels = 0;
Result_RF_RxGain_Mat_BF1_CoherentChannels = uint8(zeros(max(Total_Loops_Vec),len_Total_Loops_Vec));
Result_BB_RxGain_Mat_BF1_CoherentChannels = uint8(zeros(max(Total_Loops_Vec),len_Total_Loops_Vec));
Result_RF_RxGain_Mat_BF1_Init_CoherentChannels = uint8(zeros(max(Total_Loops_Vec),len_Total_Loops_Vec));
Result_BB_RxGain_Mat_BF1_Init_CoherentChannels = uint8(zeros(max(Total_Loops_Vec),len_Total_Loops_Vec));
% Result_ConstellationPointsTx_BF1_CoherentChannels=0;
Result_ConstellationSymbsTx_BF1_CoherentChannels = uint8(0);
Result_ConstellationPointsRx_BF1_CoherentChannels=0;
Result_CE_Init_BF1_CoherentChannels=0;
Result_CE_BF1_CoherentChannels=0;
Result_CE_NoBF1_CoherentChannels=0;
Result_Index_Init_BF1_CoherentChannels=uint8(0);
Result_Index_check_BF1_CoherentChannels=uint8(0);
Result_Saturation_Flag_Init_BF1_CoherentChannels=uint8(0);
Result_Saturation_Flag_BF1_CoherentChannels=uint8(0);


Result_Total_Bits_Vec_BF1_AllChannels = 0;
Result_Total_Errors_Vec_BF1_AllChannels = 0;
Result_Total_Bits_Vec_BF1_AllChannels_NonSat = 0;
Result_Total_Errors_Vec_BF1_AllChannels_NonSat = 0;
Result_BER_BF1_AllChannels = 0;
Result_BER_BF1_AllChannels_NonSat = 0;
Result_Channel_Gain_Init_Vec_BF1_AllChannels = 0;
Result_Channel_Gain_BF1_Vec_BF1_AllChannels = 0;
Result_Avg_Noise_Power_Vec_BF1_AllChannels = 0;
Result_Avg_Signal_Power_Vec_BF1_AllChannels = 0;
Result_Avg_SignalToNoiseRatio_Vec_BF1_AllChannels = 0;
Result_RF_RxGain_Mat_BF1_AllChannels = uint8(zeros(max(Total_Loops_Vec),len_Total_Loops_Vec));
Result_BB_RxGain_Mat_BF1_AllChannels = uint8(zeros(max(Total_Loops_Vec),len_Total_Loops_Vec));
Result_RF_RxGain_Mat_BF1_Init_AllChannels = uint8(zeros(max(Total_Loops_Vec),len_Total_Loops_Vec));
Result_BB_RxGain_Mat_BF1_Init_AllChannels = uint8(zeros(max(Total_Loops_Vec),len_Total_Loops_Vec));
% Result_ConstellationPointsTx_BF1_AllChannels=0;
Result_ConstellationSymbsTx_BF1_AllChannels=uint8(0);
Result_ConstellationPointsRx_BF1_AllChannels=0;
Result_CE_Init_BF1_AllChannels=0;
Result_CE_BF1_AllChannels=0;
Result_CE_NoBF1_AllChannels=0;
Result_Index_Init_BF1_AllChannels=uint8(0);
Result_Index_check_BF1_AllChannels=uint8(0);
Result_Saturation_Flag_Init_BF1_AllChannels = uint8(0);
Result_Saturation_Flag_BF1_AllChannels = uint8(0);
Result_ScalePayload_BF1 = uint16(0);


Result_Failed_Channels_Vec_BF1 = 0;
Result_Passed_Channels_Vec_BF1 = 0;
Result_Passed_NonCoherentChannels_Vec_BF1 = 0;
Result_Passed_CoherentChannels_Vec_BF1 = 0;
Result_Failed_Channels_Init_Vec_BF1 = 0;
Result_Failed_Channels_BF1_Vec_BF1 = 0;
Result_Failed_Channels_Init_Vec_BF1_Length = 0;
Result_Failed_Channels_BF1_Vec_BF1_Length = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% VARIABLES TO STORE BF2 STATISTICS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Result_Total_Bits_Vec_BF2_CoherentChannels = 0;
Result_Total_Errors_Vec_BF2_CoherentChannels = 0;
Result_Total_Bits_Vec_BF2_CoherentChannels_NonSat = 0;
Result_Total_Errors_Vec_BF2_CoherentChannels_NonSat = 0;
Result_BER_BF2_CoherentChannels = 0;
Result_BER_BF2_CoherentChannels_NonSat = 0;
Result_Channel_Gain_Init_Vec_BF2_CoherentChannels = 0;
Result_Channel_Gain_BF2_Vec_BF2_CoherentChannels = 0;
Result_Avg_Noise_Power_Vec_BF2_CoherentChannels = 0;
Result_Avg_Signal_Power_Vec_BF2_CoherentChannels = 0;
Result_Avg_SignalToNoiseRatio_Vec_BF2_CoherentChannels = 0;
Result_RF_RxGain_Mat_BF2_CoherentChannels = uint8(zeros(max(Total_Loops_Vec),len_Total_Loops_Vec));
Result_BB_RxGain_Mat_BF2_CoherentChannels = uint8(zeros(max(Total_Loops_Vec),len_Total_Loops_Vec));
Result_RF_RxGain_Mat_BF2_Init_CoherentChannels = uint8(zeros(max(Total_Loops_Vec),len_Total_Loops_Vec));
Result_BB_RxGain_Mat_BF2_Init_CoherentChannels = uint8(zeros(max(Total_Loops_Vec),len_Total_Loops_Vec));
% Result_ConstellationPointsTx_BF2_CoherentChannels=0;
Result_ConstellationSymbsTx_BF2_CoherentChannels = uint8(0);
Result_ConstellationPointsRx_BF2_CoherentChannels=0;
Result_CE_Init_BF2_CoherentChannels=0;
Result_CE_BF2_CoherentChannels=0;
Result_CE_NoBF2_CoherentChannels=0;
Result_Index_Init_BF2_CoherentChannels=uint8(0);
Result_Index_check_BF2_CoherentChannels=uint8(0);
Result_Saturation_Flag_Init_BF2_CoherentChannels=uint8(0);
Result_Saturation_Flag_BF2_CoherentChannels=uint8(0);


Result_Total_Bits_Vec_BF2_AllChannels = 0;
Result_Total_Errors_Vec_BF2_AllChannels = 0;
Result_Total_Bits_Vec_BF2_AllChannels_NonSat = 0;
Result_Total_Errors_Vec_BF2_AllChannels_NonSat = 0;
Result_BER_BF2_AllChannels = 0;
Result_BER_BF2_AllChannels_NonSat = 0;
Result_Channel_Gain_Init_Vec_BF2_AllChannels = 0;
Result_Channel_Gain_BF2_Vec_BF2_AllChannels = 0;
Result_Avg_Noise_Power_Vec_BF2_AllChannels = 0;
Result_Avg_Signal_Power_Vec_BF2_AllChannels = 0;
Result_Avg_SignalToNoiseRatio_Vec_BF2_AllChannels = 0;
Result_RF_RxGain_Mat_BF2_AllChannels = uint8(zeros(max(Total_Loops_Vec),len_Total_Loops_Vec));
Result_BB_RxGain_Mat_BF2_AllChannels = uint8(zeros(max(Total_Loops_Vec),len_Total_Loops_Vec));
Result_RF_RxGain_Mat_BF2_Init_AllChannels = uint8(zeros(max(Total_Loops_Vec),len_Total_Loops_Vec));
Result_BB_RxGain_Mat_BF2_Init_AllChannels = uint8(zeros(max(Total_Loops_Vec),len_Total_Loops_Vec));
% Result_ConstellationPointsTx_BF2_AllChannels=0;
Result_ConstellationSymbsTx_BF2_AllChannels=uint8(0);
Result_ConstellationPointsRx_BF2_AllChannels=0;
Result_CE_Init_BF2_AllChannels=0;
Result_CE_BF2_AllChannels=0;
Result_CE_NoBF2_AllChannels=0;
Result_Index_Init_BF2_AllChannels=uint8(0);
Result_Index_check_BF2_AllChannels=uint8(0);
Result_Saturation_Flag_Init_BF2_AllChannels = uint8(0);
Result_Saturation_Flag_BF2_AllChannels = uint8(0);
Result_ScalePayload_BF2 = uint16(0);


Result_Failed_Channels_Vec_BF2 = 0;
Result_Passed_Channels_Vec_BF2 = 0;
Result_Passed_NonCoherentChannels_Vec_BF2 = 0;
Result_Passed_CoherentChannels_Vec_BF2 = 0;
Result_Failed_Channels_Init_Vec_BF2 = 0;
Result_Failed_Channels_BF2_Vec_BF2 = 0;
Result_Failed_Channels_Init_Vec_BF2_Length = 0;
Result_Failed_Channels_BF2_Vec_BF2_Length = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% VARIABLES TO STORE BF3 STATISTICS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% No CoherentChannels variables
% In infinite feedback we do not check for "coherence time" since there are
% no codebok indices to compare
% % Result_Total_Bits_Vec_BF3_CoherentChannels = 0;
% % Result_Total_Errors_Vec_BF3_CoherentChannels = 0;
% % Result_Total_Bits_Vec_BF3_CoherentChannels_NonSat = 0;
% % Result_Total_Errors_Vec_BF3_CoherentChannels_NonSat = 0;
% % Result_BER_BF3_CoherentChannels = 0;
% % Result_BER_BF3_CoherentChannels_NonSat = 0;
% % Result_Channel_Gain_Init_Vec_BF3_CoherentChannels = 0;
% % Result_Channel_Gain_BF3_Vec_BF3_CoherentChannels = 0;
% % Result_Avg_Noise_Power_Vec_BF3_CoherentChannels = 0;
% % Result_Avg_Signal_Power_Vec_BF3_CoherentChannels = 0;
% % Result_Avg_SignalToNoiseRatio_Vec_BF3_CoherentChannels = 0;
% % Result_RF_RxGain_Mat_BF3_CoherentChannels = uint8(zeros(max(Total_Loops_Vec),len_Total_Loops_Vec));
% % Result_BB_RxGain_Mat_BF3_CoherentChannels = uint8(zeros(max(Total_Loops_Vec),len_Total_Loops_Vec));
% % Result_RF_RxGain_Mat_BF3_Init_CoherentChannels = uint8(zeros(max(Total_Loops_Vec),len_Total_Loops_Vec));
% % Result_BB_RxGain_Mat_BF3_Init_CoherentChannels = uint8(zeros(max(Total_Loops_Vec),len_Total_Loops_Vec));
% % % Result_ConstellationPointsTx_BF3_CoherentChannels=0;
% % Result_ConstellationSymbsTx_BF3_CoherentChannels = uint8(0);
% % Result_ConstellationPointsRx_BF3_CoherentChannels=0;
% % Result_CE_Init_BF3_CoherentChannels=0;
% % Result_CE_BF3_CoherentChannels=0;
% % Result_CE_NoBF3_CoherentChannels=0;
% % Result_Index_Init_BF3_CoherentChannels=uint8(0);
% % Result_Index_check_BF3_CoherentChannels=uint8(0);
% % Result_Saturation_Flag_Init_BF3_CoherentChannels=uint8(0);
% % Result_Saturation_Flag_BF3_CoherentChannels=uint8(0);


Result_Total_Bits_Vec_BF3_AllChannels = 0;
Result_Total_Errors_Vec_BF3_AllChannels = 0;
Result_Total_Bits_Vec_BF3_AllChannels_NonSat = 0;
Result_Total_Errors_Vec_BF3_AllChannels_NonSat = 0;
Result_BER_BF3_AllChannels = 0;
Result_BER_BF3_AllChannels_NonSat = 0;
Result_Channel_Gain_Init_Vec_BF3_AllChannels = 0;
Result_Channel_Gain_BF3_Vec_BF3_AllChannels = 0;
Result_Avg_Noise_Power_Vec_BF3_AllChannels = 0;
Result_Avg_Signal_Power_Vec_BF3_AllChannels = 0;
Result_Avg_SignalToNoiseRatio_Vec_BF3_AllChannels = 0;
Result_RF_RxGain_Mat_BF3_AllChannels = uint8(zeros(max(Total_Loops_Vec),len_Total_Loops_Vec));
Result_BB_RxGain_Mat_BF3_AllChannels = uint8(zeros(max(Total_Loops_Vec),len_Total_Loops_Vec));
Result_RF_RxGain_Mat_BF3_Init_AllChannels = uint8(zeros(max(Total_Loops_Vec),len_Total_Loops_Vec));
Result_BB_RxGain_Mat_BF3_Init_AllChannels = uint8(zeros(max(Total_Loops_Vec),len_Total_Loops_Vec));
% Result_ConstellationPointsTx_BF3_AllChannels=0;
Result_ConstellationSymbsTx_BF3_AllChannels=uint8(0);
Result_ConstellationPointsRx_BF3_AllChannels=0;
Result_CE_Init_BF3_AllChannels=0;
Result_CE_BF3_AllChannels=0;
Result_CE_NoBF3_AllChannels=0;
Result_Index_Init_BF3_AllChannels=uint8(0);
Result_Index_check_BF3_AllChannels=uint8(0);
Result_Saturation_Flag_Init_BF3_AllChannels = uint8(0);
Result_Saturation_Flag_BF3_AllChannels = uint8(0);
Result_ScalePayload_BF3 = uint16(0);


Result_Failed_Channels_Vec_BF3 = 0;
Result_Passed_Channels_Vec_BF3 = 0;
% Result_Passed_NonCoherentChannels_Vec_BF3 = 0;
% Result_Passed_CoherentChannels_Vec_BF3 = 0;
Result_Failed_Channels_Init_Vec_BF3 = 0;
Result_Failed_Channels_BF3_Vec_BF3 = 0;
Result_Failed_Channels_Init_Vec_BF3_Length = 0;
Result_Failed_Channels_BF3_Vec_BF3_Length = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% VARIABLES TO STORE ALAMOUTI STATISTICS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Result_Total_Bits_Vec_Alm = 0;
Result_Total_Errors_Vec_Alm = 0;
Result_Total_Bits_Vec_Alm_NonSat = 0;
Result_Total_Errors_Vec_Alm_NonSat = 0;
Result_BER_Alm = 0;
Result_BER_Alm_NonSat = 0;
Result_Channel_Gain_Alm_Vec = 0;
Result_Avg_Noise_Power_Vec_Alm = 0;
Result_Avg_Signal_Power_Vec_Alm = 0;
Result_Avg_SignalToNoiseRatio_Vec_Alm = 0;
Result_Failed_Channels_Vec_Alm = 0;
Result_Passed_Channels_Vec_Alm = 0;
Result_Failed_Channels_Vec_Alm_Length = 0;
Result_RF_RxGain_Mat_Alm = uint8(zeros(max(Total_Loops_Vec),len_Total_Loops_Vec));
Result_BB_RxGain_Mat_Alm = uint8(zeros(max(Total_Loops_Vec),len_Total_Loops_Vec));
% Channel_Gain_Init_Vec = 0;
% Channel_Gain_BF1_Vec = 0;
% Result_ConstellationPointsTx_Alm=0;
Result_ConstellationSymbsTx_Alm= uint8(0);
Result_ConstellationPointsRx_Alm=0;
Result_CE_Alm=0;
Result_Saturation_Flag_Alm = uint8(0);
Result_ScalePayload_Alm = uint16(0);

%% SOME MORE CODE SHARED BY THE THREE BEAMFORMING SCHEMES AND ALAMOUTI SCHEME
Counter_EMac_Fails = 0;

for index_Total_Loops_Vec = 1:1:len_Total_Loops_Vec
    
% Set Tx Gains
if(1 == channel_select)
    if(0 == channel_emulator_remote_select)
       % If we are using the channel emulator remote command gains have already been set
       % so no need to enter this if statement and set them again
%     warplab_setRadioAGCParameter(udp_node1,RADIO1_TXGAINS,(Node1_Radio1_TxGain_RF + Node1_Radio1_TxGain_BB*2^16));
%     warplab_setRadioAGCParameter(udp_node1,RADIO2_TXGAINS,(Node1_Radio2_TxGain_RF(index_Total_Loops_Vec) + Node1_Radio2_TxGain_BB(index_Total_Loops_Vec)*2^16));
%     warplab_setRadioAGCParameter(udp_node1,RADIO3_TXGAINS,(Node1_Radio3_TxGain_RF(index_Total_Loops_Vec) + Node1_Radio3_TxGain_BB(index_Total_Loops_Vec)*2^16));
%     warplab_setRadioAGCParameter(udp_node1,RADIO4_TXGAINS,(Node1_Radio4_TxGain_RF + Node1_Radio4_TxGain_BB*2^16));
        TxGainsForRadio2 = (Node1_Radio2_TxGain_RF(index_Total_Loops_Vec) + Node1_Radio2_TxGain_BB(index_Total_Loops_Vec)*2^16);
        TxGainsForRadio3 = (Node1_Radio3_TxGain_RF(index_Total_Loops_Vec) + Node1_Radio3_TxGain_BB(index_Total_Loops_Vec)*2^16);
        % Customized warplab to download all gains in one pc-node
        % communication
       warplab_setRadioAGCParameter(udp_node1,RADIO2_RADIO3_TXGAINS,[TxGainsForRadio2,TxGainsForRadio3]);
    end
    
    if(1 == channel_emulator_remote_select)
        if(0==AzimuthSpirent_select)
            % If we are using Spirent Emulator, use this code to set
            % Spirent's output power
            
            % Set emulator's channel 1 output power
            pnet(emulatorHandle, 'printf', Emu_Out_Power_Ch1(index_Total_Loops_Vec,:));
            pnet(emulatorHandle, 'printf', 'err?\r');
            pnet(emulatorHandle,'read');
            
            % Set emulator's channel 2 output power
            pnet(emulatorHandle, 'printf', Emu_Out_Power_Ch2(index_Total_Loops_Vec,:));
            pnet(emulatorHandle, 'printf', 'err?\r');
            pnet(emulatorHandle,'read');
        end
        if(1==AzimuthSpirent_select)
            % If we are using Azimuths Emulator, use this code to set
            % Azimuths's output power
            
            % Set emulator's channel 1 output power
            pnet(emulatorHandle, 'printf', Emu_Out_Power_Ch1(index_Total_Loops_Vec,:));
            pause(2);
            data='';
            while (strcmp(data,''))
                data=pnet(emulatorHandle,'read');
                pause(1)
            end
            fprintf('\n%s', data);
        end
    end
end
    
    if((0 == channel_select) && (1 == noise_select))
%         % Compute noise variance from EbNodB
%         EsNodB = EbNodB(index_Total_Loops_Vec) + 10*log10(k);
        % Compute noise variance from EbNodB
        EsNo = 10^(EsNodB(index_Total_Loops_Vec)/10);
        var_noise = 1/(EsNo);
    end
    
Total_Loops = Total_Loops_Vec(index_Total_Loops_Vec);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% VARIABLES TO STORE BF1 STATISTICS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Total_Bits_BF1_CoherentChannels = 0;
Total_Errors_BF1_CoherentChannels = 0;
Total_Bits_BF1_CoherentChannels_NonSat = 0;
Total_Errors_BF1_CoherentChannels_NonSat = 0;
Sum_Channel_Gain_Init_BF1_CoherentChannels = 0;
Sum_Channel_Gain_BF1_BF1_CoherentChannels = 0;
Sum_Avg_Noise_Power_BF1_CoherentChannels = 0;
Sum_Avg_Signal_Power_BF1_CoherentChannels = 0;
Sum_Avg_SignalToNoiseRatio_BF1_CoherentChannels = 0;
Sum_Total_CoherentChannels_BF1 = 0;

Total_Bits_BF1_NonCoherentChannels = 0;
Total_Errors_BF1_NonCoherentChannels = 0;
Total_Bits_BF1_NonCoherentChannels_NonSat = 0;
Total_Errors_BF1_NonCoherentChannels_NonSat = 0;
Sum_Channel_Gain_Init_BF1_AllChannels = 0;
Sum_Channel_Gain_BF1_BF1_AllChannels = 0;
Sum_Avg_Noise_Power_BF1_AllChannels = 0;
Sum_Avg_Signal_Power_BF1_AllChannels = 0;
Sum_Avg_SignalToNoiseRatio_BF1_AllChannels = 0;
Sum_Total_NonCoherentChannels_BF1 = 0;

Sum_Total_AllChannels_BF1 = 0;
Sum_Total_FailedInitTiming_BF1 = 0;
Sum_Total_FailedBFTiming_BF1 = 0;
Sum_Total_FailedInitTiming_BF1_Length = 0;
Sum_Total_FailedBFTiming_BF1_Length = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% VARIABLES TO STOE BF2 STATISTICS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Total_Bits_BF2_CoherentChannels = 0;
Total_Errors_BF2_CoherentChannels = 0;
Total_Bits_BF2_CoherentChannels_NonSat = 0;
Total_Errors_BF2_CoherentChannels_NonSat = 0;
Sum_Channel_Gain_Init_BF2_CoherentChannels = 0;
Sum_Channel_Gain_BF2_BF2_CoherentChannels = 0;
Sum_Avg_Noise_Power_BF2_CoherentChannels = 0;
Sum_Avg_Signal_Power_BF2_CoherentChannels = 0;
Sum_Avg_SignalToNoiseRatio_BF2_CoherentChannels = 0;
Sum_Total_CoherentChannels_BF2 = 0;

Total_Bits_BF2_NonCoherentChannels = 0;
Total_Errors_BF2_NonCoherentChannels = 0;
Total_Bits_BF2_NonCoherentChannels_NonSat = 0;
Total_Errors_BF2_NonCoherentChannels_NonSat = 0;
Sum_Channel_Gain_Init_BF2_AllChannels = 0;
Sum_Channel_Gain_BF2_BF2_AllChannels = 0;
Sum_Avg_Noise_Power_BF2_AllChannels = 0;
Sum_Avg_Signal_Power_BF2_AllChannels = 0;
Sum_Avg_SignalToNoiseRatio_BF2_AllChannels = 0;
Sum_Total_NonCoherentChannels_BF2 = 0;

Sum_Total_AllChannels_BF2 = 0;
Sum_Total_FailedInitTiming_BF2 = 0;
Sum_Total_FailedBFTiming_BF2 = 0;
Sum_Total_FailedInitTiming_BF2_Length = 0;
Sum_Total_FailedBFTiming_BF2_Length = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% VARIABLES TO STOE BF3 STATISTICS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Total_Bits_BF3_CoherentChannels = 0;
Total_Errors_BF3_CoherentChannels = 0;
Total_Bits_BF3_CoherentChannels_NonSat = 0;
Total_Errors_BF3_CoherentChannels_NonSat = 0;
Sum_Channel_Gain_Init_BF3_CoherentChannels = 0;
Sum_Channel_Gain_BF3_BF3_CoherentChannels = 0;
Sum_Avg_Noise_Power_BF3_CoherentChannels = 0;
Sum_Avg_Signal_Power_BF3_CoherentChannels = 0;
Sum_Avg_SignalToNoiseRatio_BF3_CoherentChannels = 0;
Sum_Total_CoherentChannels_BF3 = 0;

Total_Bits_BF3_NonCoherentChannels = 0;
Total_Errors_BF3_NonCoherentChannels = 0;
Total_Bits_BF3_NonCoherentChannels_NonSat = 0;
Total_Errors_BF3_NonCoherentChannels_NonSat = 0;
Sum_Channel_Gain_Init_BF3_AllChannels = 0;
Sum_Channel_Gain_BF3_BF3_AllChannels = 0;
Sum_Avg_Noise_Power_BF3_AllChannels = 0;
Sum_Avg_Signal_Power_BF3_AllChannels = 0;
Sum_Avg_SignalToNoiseRatio_BF3_AllChannels = 0;
Sum_Total_NonCoherentChannels_BF3 = 0;

Sum_Total_AllChannels_BF3 = 0;
Sum_Total_FailedInitTiming_BF3 = 0;
Sum_Total_FailedBFTiming_BF3 = 0;
Sum_Total_FailedInitTiming_BF3_Length = 0;
Sum_Total_FailedBFTiming_BF3_Length = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% VARIABLES TO STORE ALAMOUTI STATISTICS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Total_Bits_Alm = 0;
Total_Errors_Alm = 0;
Total_Bits_Alm_NonSat = 0;
Total_Errors_Alm_NonSat = 0;
Sum_Avg_Noise_Power_Alm = 0;
Sum_Avg_Signal_Power_Alm = 0;
Sum_Avg_SignalToNoiseRatio_Alm = 0;
Sum_Channel_Gain_Alm = 0;
Sum_Total_Channels_Alm = 0; 
Sum_Total_FailedAlmTiming_Length = 0;

%% SOME MORE CODE SHARED BY THE THREE BEAMFORMING SCHEMES AND ALAMOUTI SCHEME
for loopscount = 1:1:Total_Loops;

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
if(0 == dpskqam_select)
    ytx_mod = dpskmod(xsym,M,0,'gray');
    ytx_mod_norm = ytx_mod; % Avg Es is already 1, no need to scale
    Constellation = dpskmod([0:M-1],M); % Generate the constellation.
    scaleConstellation = 1;
end

% Modulate using QPSK
if(1 == dpskqam_select)
    ytx_mod = qammod(xsym,M,0,'gray');
    % Compute scalinig value to scale constellation so that the average symbol
    % power is equal to 1
    Constellation = qammod([0:M-1],M); % Generate the constellation.
    scaleConstellation = modnorm(Constellation,'avpow',1);
    ytx_mod_norm = ytx_mod*scaleConstellation;
end

%% RUN EXPERIMENT FOR BF1 SCHEME (2X1 2 BITS OF FEEDBACK GRASSMANNIAN CODEBOOK)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set some flags for gathering statistics and some flags used by the
% beamforming code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Passed_Init_Timing_Flag = 0;
Passed_BF_Timing_Flag = 0;
Failed_Init_Timing_Flag_Length = 0;
Failed_BF_Timing_Flag_Length = 0;
EMac_Fail_Flag = 0;
RecomputeReloadBFTxVecs_Flag = 1; % Used in Tx2Rx1_BFvsAlm_BFProc_FPGA.... 
InfiniteFeedbackFlag = 0; % We are using codebook ~= Infinite feedback

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Transmit and receive symbols using transmit beamforming and receive
% combining 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Write codebook to use in Codebook_Original variable
Codebook_Original = CodebookBF1; % Codebook is only used for Beamforming (not for Alamouti)
Tx2Rx1_BFvsAlm_BFProc_FPGA_BF_FRONTEND_v07

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute statistics for beamforming
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(0==Passed_Init_Timing_Flag)
    Sum_Total_FailedInitTiming_BF1 = Sum_Total_FailedInitTiming_BF1 + 1;
    Sum_Total_FailedInitTiming_BF1_Length = Sum_Total_FailedInitTiming_BF1_Length + Failed_Init_Timing_Flag_Length;
end
if((1==Passed_Init_Timing_Flag)&&(0==Passed_BF_Timing_Flag))
    Sum_Total_FailedBFTiming_BF1 = Sum_Total_FailedBFTiming_BF1 + 1;
    Sum_Total_FailedBFTiming_BF1_Length = Sum_Total_FailedBFTiming_BF1_Length + Failed_BF_Timing_Flag_Length;
end

if(1 == channel_select)
    if(1==EMac_Fail_Flag)
        % AFTER WE CHANGED THE IP TOOLBOX FOR FAST READ WE STOPPED GETTING
        % EMAC FAILURES, HENCE THE CODE IN THIS IF STATEMENT 
        % MAY NOT BE NEEDED ANYMORE
        pnet('closeall');
        warplab_initialize_afterEMacFail;
        
        warplab_sendCmd(udp_node1, RADIO2_RADIO3_TX_DISABLE, packetNum);
        warplab_sendCmd(udp_node2, RADIO2_RX_DISABLE, packetNum);
        warplab_sendCmd(udp_node2, AGC_RESET, packetNum);
        
        Counter_EMac_Fails = Counter_EMac_Fails + 1;
        if(15==Counter_EMac_Fails)
            error('Too many EMac fails!')
        end
    
        if(0 == channel_emulator_remote_select)
            % If we are using the channel emulator remote command gains have already been set
        % so no need to enter this if statement and set them again
    %     warplab_setRadioAGCParameter(udp_node1,RADIO1_TXGAINS,(Node1_Radio1_TxGain_RF + Node1_Radio1_TxGain_BB*2^16));
    %     warplab_setRadioAGCParameter(udp_node1,RADIO2_TXGAINS,(Node1_Radio2_TxGain_RF(index_Total_Loops_Vec) + Node1_Radio2_TxGain_BB(index_Total_Loops_Vec)*2^16));
    %     warplab_setRadioAGCParameter(udp_node1,RADIO3_TXGAINS,(Node1_Radio3_TxGain_RF(index_Total_Loops_Vec) + Node1_Radio3_TxGain_BB(index_Total_Loops_Vec)*2^16));
        %     warplab_setRadioAGCParameter(udp_node1,RADIO4_TXGAINS,(Node1_Radio4_TxGain_RF + Node1_Radio4_TxGain_BB*2^16));
            TxGainsForRadio2 = (Node1_Radio2_TxGain_RF(index_Total_Loops_Vec) + Node1_Radio2_TxGain_BB(index_Total_Loops_Vec)*2^16);
            TxGainsForRadio3 = (Node1_Radio3_TxGain_RF(index_Total_Loops_Vec) + Node1_Radio3_TxGain_BB(index_Total_Loops_Vec)*2^16);
            % Customized warplab to download all gains in one pc-node
            % communication
            warplab_setRadioAGCParameter(udp_node1,RADIO2_RADIO3_TXGAINS,[TxGainsForRadio2,TxGainsForRadio3]);
        end
    
        if(1 == channel_emulator_remote_select)
            % Create emulator handle
            sr5500_test;
            pause(2);
            % Download profile to emulator
            pnet(emulatorHandle, 'printf', 'frec c:\\MD_OfficeA_Ds05_CH3.wce\r');
            pause(30)
            pnet(emulatorHandle, 'printf', 'err?\r');
            pnet(emulatorHandle,'read');
            % Set Input power channel 1
            pnet(emulatorHandle, 'printf', 'chan1:ipow -16.50\r');
            pnet(emulatorHandle, 'printf', 'err?\r');
            pnet(emulatorHandle,'read')
            % Set Input power channel 2
            pnet(emulatorHandle, 'printf', 'chan2:ipow -19.57\r');
            pnet(emulatorHandle, 'printf', 'err?\r');
            pnet(emulatorHandle,'read')
        
            % Set emulator's channel 1 output power
            pnet(emulatorHandle, 'printf', Emu_Out_Power_Ch1(index_Total_Loops_Vec,:));
            pnet(emulatorHandle, 'printf', 'err?\r');
            pnet(emulatorHandle,'read');
            % Set emulator's channel 2 output power
            pnet(emulatorHandle, 'printf', Emu_Out_Power_Ch2(index_Total_Loops_Vec,:));
            pnet(emulatorHandle, 'printf', 'err?\r');
            pnet(emulatorHandle,'read');
        end
    end
end
    

if (Num_Rx == (ValidStart_1+ValidStart_2+ValidStart_3+ValidStart_4))
if (1 == Valid_Timing_Flag_BF)    
    
% Channel Gain
Sum_Channel_Gain_Init_BF1_AllChannels = Sum_Channel_Gain_Init_BF1_AllChannels + Channel_Gain_Init_BF;
Sum_Channel_Gain_BF1_BF1_AllChannels = Sum_Channel_Gain_BF1_BF1_AllChannels + Channel_Gain_BF;

% Noise and SNR 
% Symbols_Sent = Constellation(zsym+1)*scaleConstellation; % Modulated
% symbols were scaled to set Es=1
Noise_Power_BF1_AllChannels = abs(ytx_mod_norm(1:nsym_Payload).'-yrx_bb_mf_ds_mrc_norm).^2;
Signal_Power_BF1_AllChannels = abs(ytx_mod_norm(1:nsym_Payload).').^2;
SignalToNoiseRatio_BF1_AllChannels = Signal_Power_BF1_AllChannels./Noise_Power_BF1_AllChannels; % We set Es = 1;

% Save sent and received constellation point for further postprocessing
% Result_ConstellationPointsTx_BF1_AllChannels((Sum_Total_AllChannels_BF1)*nsym_Payload+1:(Sum_Total_AllChannels_BF1+1)*nsym_Payload,index_Total_Loops_Vec) ...
%     = ytx_mod_norm(1:nsym_Payload);
Result_ConstellationSymbsTx_BF1_AllChannels((Sum_Total_AllChannels_BF1)*nsym_Payload+1:(Sum_Total_AllChannels_BF1+1)*nsym_Payload,index_Total_Loops_Vec) ...
    = uint8(xsym(1:nsym_Payload));
Result_ConstellationPointsRx_BF1_AllChannels((Sum_Total_AllChannels_BF1)*nsym_Payload+1:(Sum_Total_AllChannels_BF1+1)*nsym_Payload,index_Total_Loops_Vec) ...
    = yrx_bb_mf_ds_mrc_norm;

Avg_Noise_Power_BF1_AllChannels = mean(Noise_Power_BF1_AllChannels);
Avg_Signal_Power_BF1_AllChannels = mean(Signal_Power_BF1_AllChannels);
Avg_SignalToNoiseRatio_BF1_AllChannels = mean(SignalToNoiseRatio_BF1_AllChannels);

Sum_Avg_Noise_Power_BF1_AllChannels = Sum_Avg_Noise_Power_BF1_AllChannels + Avg_Noise_Power_BF1_AllChannels;
Sum_Avg_Signal_Power_BF1_AllChannels = Sum_Avg_Signal_Power_BF1_AllChannels + Avg_Signal_Power_BF1_AllChannels;
Sum_Avg_SignalToNoiseRatio_BF1_AllChannels = Sum_Avg_SignalToNoiseRatio_BF1_AllChannels + Avg_SignalToNoiseRatio_BF1_AllChannels;
Sum_Total_AllChannels_BF1 = Sum_Total_AllChannels_BF1 + 1;   

% Save channel estimates 
Result_CE_Init_BF1_AllChannels(Sum_Total_AllChannels_BF1,1:2,index_Total_Loops_Vec) = CE_Init;
Result_CE_BF1_AllChannels(Sum_Total_AllChannels_BF1,1:2,index_Total_Loops_Vec) = CE_BF;
Result_CE_NoBF1_AllChannels(Sum_Total_AllChannels_BF1,1:2,index_Total_Loops_Vec) = CE_NoBF;
Result_Index_Init_BF1_AllChannels(Sum_Total_AllChannels_BF1,index_Total_Loops_Vec) = uint8(Index_Init);
Result_Index_check_BF1_AllChannels(Sum_Total_AllChannels_BF1,index_Total_Loops_Vec) = uint8(Index_check);

% Save saturation flag corresponding to each channel estimate
Result_Saturation_Flag_Init_BF1_AllChannels(Sum_Total_AllChannels_BF1,index_Total_Loops_Vec) = uint8(Saturation_Flag_BF_Init);
Result_Saturation_Flag_BF1_AllChannels(Sum_Total_AllChannels_BF1,index_Total_Loops_Vec) = uint8(Saturation_Flag_BF);

% Save scale payload value
Result_ScalePayload_BF1(Sum_Total_AllChannels_BF1,index_Total_Loops_Vec) = uint16(scale_Payload*2^16);

if(1 == channel_select)
%     [GainsRF_Init,GainsBB_Init] = warplab_readAGCGains(udp_node2);
    Result_RF_RxGain_Mat_BF1_AllChannels(Sum_Total_AllChannels_BF1,index_Total_Loops_Vec) = uint8(BF_GainsRF_BF);
    Result_BB_RxGain_Mat_BF1_AllChannels(Sum_Total_AllChannels_BF1,index_Total_Loops_Vec) = uint8(BF_GainsBB_BF);
    Result_RF_RxGain_Mat_BF1_Init_AllChannels(Sum_Total_AllChannels_BF1,index_Total_Loops_Vec) = uint8(BF_GainsRF_Init);
    Result_BB_RxGain_Mat_BF1_Init_AllChannels(Sum_Total_AllChannels_BF1,index_Total_Loops_Vec) = uint8(BF_GainsBB_Init);
end


% Check Beamforming coherence time
if(Index_Init ~= Index_check)
    Result_Coherent_Flag_BF1_AllChannels(Sum_Total_AllChannels_BF1,index_Total_Loops_Vec) = 0;
    % Errors and total bits for noncoherent channels
    Sum_Total_NonCoherentChannels_BF1 = Sum_Total_NonCoherentChannels_BF1 + 1;
    Total_Bits_BF1_NonCoherentChannels = Total_Bits_BF1_NonCoherentChannels + number_of_bits;
    Total_Errors_BF1_NonCoherentChannels = Total_Errors_BF1_NonCoherentChannels + number_of_errors;
    % Errors and toatl bits for noncoherent channels that were not saturated
    if(0==(Saturation_Flag_BF+Saturation_Flag_BF_Init))
       Total_Bits_BF1_NonCoherentChannels_NonSat = Total_Bits_BF1_NonCoherentChannels_NonSat + number_of_bits;
       Total_Errors_BF1_NonCoherentChannels_NonSat = Total_Errors_BF1_NonCoherentChannels_NonSat + number_of_errors;
    end
else
% Statistics for coherent channels

Result_Coherent_Flag_BF1_AllChannels(Sum_Total_AllChannels_BF1,index_Total_Loops_Vec) = 1;


% Errors and total bits for coherent channels
Total_Bits_BF1_CoherentChannels = Total_Bits_BF1_CoherentChannels + number_of_bits;
Total_Errors_BF1_CoherentChannels = Total_Errors_BF1_CoherentChannels + number_of_errors;

% Errors and toatl bits for coherent channels that were not saturated
if(0==(Saturation_Flag_BF+Saturation_Flag_BF_Init))
    Total_Bits_BF1_CoherentChannels_NonSat = Total_Bits_BF1_CoherentChannels_NonSat + number_of_bits;
    Total_Errors_BF1_CoherentChannels_NonSat = Total_Errors_BF1_CoherentChannels_NonSat + number_of_errors;
end

% Channel Gain
Sum_Channel_Gain_Init_BF1_CoherentChannels = Sum_Channel_Gain_Init_BF1_CoherentChannels + Channel_Gain_Init_BF;
Sum_Channel_Gain_BF1_BF1_CoherentChannels = Sum_Channel_Gain_BF1_BF1_CoherentChannels + Channel_Gain_BF;

% Noise and SNR 
% Symbols_Sent = Constellation(zsym+1)*scaleConstellation; % Modulated
% symbols were scaled to set Es=1
Noise_Power_BF1_CoherentChannels = abs(ytx_mod_norm(1:nsym_Payload).'-yrx_bb_mf_ds_mrc_norm).^2;
% Noise_Power_BF1_CoherentChannels = Noise_Power_BF1_CoherentChannels.* Channel_Gain_BF;
Signal_Power_BF1_CoherentChannels = abs(ytx_mod_norm(1:nsym_Payload).').^2;
SignalToNoiseRatio_BF1_CoherentChannels = Signal_Power_BF1_CoherentChannels./Noise_Power_BF1_CoherentChannels; % We set Es = 1;
% Result_ConstellationPointsTx_BF1_CoherentChannels((Sum_Total_CoherentChannels_BF1)*nsym_Payload+1:(Sum_Total_CoherentChannels_BF1+1)*nsym_Payload,index_Total_Loops_Vec) ...
%     = ytx_mod_norm(1:nsym_Payload);
Result_ConstellationSymbsTx_BF1_CoherentChannels((Sum_Total_CoherentChannels_BF1)*nsym_Payload+1:(Sum_Total_CoherentChannels_BF1+1)*nsym_Payload,index_Total_Loops_Vec) ...
    = uint8(xsym(1:nsym_Payload));
Result_ConstellationPointsRx_BF1_CoherentChannels((Sum_Total_CoherentChannels_BF1)*nsym_Payload+1:(Sum_Total_CoherentChannels_BF1+1)*nsym_Payload,index_Total_Loops_Vec) ...
    = yrx_bb_mf_ds_mrc_norm;

Avg_Noise_Power_BF1_CoherentChannels = mean(Noise_Power_BF1_CoherentChannels);
Avg_Signal_Power_BF1_CoherentChannels = mean(Signal_Power_BF1_CoherentChannels);
Avg_SignalToNoiseRatio_BF1_CoherentChannels = mean(SignalToNoiseRatio_BF1_CoherentChannels);

Sum_Avg_Noise_Power_BF1_CoherentChannels = Sum_Avg_Noise_Power_BF1_CoherentChannels + Avg_Noise_Power_BF1_CoherentChannels;
Sum_Avg_Signal_Power_BF1_CoherentChannels = Sum_Avg_Signal_Power_BF1_CoherentChannels + Avg_Signal_Power_BF1_CoherentChannels;
Sum_Avg_SignalToNoiseRatio_BF1_CoherentChannels = Sum_Avg_SignalToNoiseRatio_BF1_CoherentChannels + Avg_SignalToNoiseRatio_BF1_CoherentChannels;
Sum_Total_CoherentChannels_BF1 = Sum_Total_CoherentChannels_BF1 + 1;

% Save channel estimates

Result_CE_Init_BF1_CoherentChannels(Sum_Total_CoherentChannels_BF1,1:2,index_Total_Loops_Vec) = CE_Init;
Result_CE_BF1_CoherentChannels(Sum_Total_CoherentChannels_BF1,1:2,index_Total_Loops_Vec) = CE_BF;
Result_CE_NoBF1_CoherentChannels(Sum_Total_CoherentChannels_BF1,1:2,index_Total_Loops_Vec) = CE_NoBF;
Result_Index_Init_BF1_CoherentChannels(Sum_Total_CoherentChannels_BF1,index_Total_Loops_Vec) = uint8(Index_Init);
Result_Index_check_BF1_CoherentChannels(Sum_Total_CoherentChannels_BF1,index_Total_Loops_Vec) = uint8(Index_check);

% Save saturation flag corresponding to each channel estimate
Result_Saturation_Flag_Init_BF1_CoherentChannels(Sum_Total_CoherentChannels_BF1,index_Total_Loops_Vec) = uint8(Saturation_Flag_BF_Init);
Result_Saturation_Flag_BF1_CoherentChannels(Sum_Total_CoherentChannels_BF1,index_Total_Loops_Vec) = uint8(Saturation_Flag_BF);

if(1 == channel_select)
%     [GainsRF_Init,GainsBB_Init] = warplab_readAGCGains(udp_node2);
    Result_RF_RxGain_Mat_BF1_CoherentChannels(Sum_Total_CoherentChannels_BF1,index_Total_Loops_Vec) = uint8(BF_GainsRF_BF);
    Result_BB_RxGain_Mat_BF1_CoherentChannels(Sum_Total_CoherentChannels_BF1,index_Total_Loops_Vec) = uint8(BF_GainsBB_BF);
    Result_RF_RxGain_Mat_BF1_Init_CoherentChannels(Sum_Total_CoherentChannels_BF1,index_Total_Loops_Vec) = uint8(BF_GainsRF_Init);
    Result_BB_RxGain_Mat_BF1_Init_CoherentChannels(Sum_Total_CoherentChannels_BF1,index_Total_Loops_Vec) = uint8(BF_GainsBB_Init);
end
end
end
end

%% RUN EXPERIMENT FOR BF2 SCHEME (2X1 2 BITS OF FEEDBACK USTC CODEBOOK)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set some flags for gathering statistics and some flags used by the
% beamforming code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Passed_Init_Timing_Flag = 0;
Passed_BF_Timing_Flag = 0;
Failed_Init_Timing_Flag_Length = 0;
Failed_BF_Timing_Flag_Length = 0;
EMac_Fail_Flag = 0;

% Already computer Tx vectors and downloaded them to the Tx nodes. Thsi was
% done to run experiment for BF1 scheme
RecomputeReloadBFTxVecs_Flag = 0; % Used in Tx2Rx1_BFvsAlm_BFProc_FPGA.... 
InfiniteFeedbackFlag = 0; % We are using codebook ~= Infinite feedback

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Transmit and receive symbols using transmit beamforming and receive
% combining 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Write codebook to use in Codebook_Original variable
Codebook_Original = CodebookBF2; % Codebook is only used for Beamforming (not for Alamouti)
Tx2Rx1_BFvsAlm_BFProc_FPGA_BF_FRONTEND_v07

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute statistics for beamforming
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(0==Passed_Init_Timing_Flag)
    Sum_Total_FailedInitTiming_BF2 = Sum_Total_FailedInitTiming_BF2 + 1;
    Sum_Total_FailedInitTiming_BF2_Length = Sum_Total_FailedInitTiming_BF2_Length + Failed_Init_Timing_Flag_Length;
end
if((1==Passed_Init_Timing_Flag)&&(0==Passed_BF_Timing_Flag))
    Sum_Total_FailedBFTiming_BF2 = Sum_Total_FailedBFTiming_BF2 + 1;
    Sum_Total_FailedBFTiming_BF2_Length = Sum_Total_FailedBFTiming_BF2_Length + Failed_BF_Timing_Flag_Length;
end

if(1 == channel_select)
    if(1==EMac_Fail_Flag)
        % AFTER WE CHANGED THE IP TOOLBOX FOR FAST READ WE STOPPED GETTING
        % EMAC FAILURES, HENCE THE CODE IN THIS IF STATEMENT 
        % MAY NOT BE NEEDED ANYMORE
        pnet('closeall');
        warplab_initialize_afterEMacFail;
        
        warplab_sendCmd(udp_node1, RADIO2_RADIO3_TX_DISABLE, packetNum);
        warplab_sendCmd(udp_node2, RADIO2_RX_DISABLE, packetNum);
        warplab_sendCmd(udp_node2, AGC_RESET, packetNum);
        
        Counter_EMac_Fails = Counter_EMac_Fails + 1;
        if(15==Counter_EMac_Fails)
            error('Too many EMac fails!')
        end
    
        if(0 == channel_emulator_remote_select)
            % If we are using the channel emulator remote command gains have already been set
        % so no need to enter this if statement and set them again
    %     warplab_setRadioAGCParameter(udp_node1,RADIO1_TXGAINS,(Node1_Radio1_TxGain_RF + Node1_Radio1_TxGain_BB*2^16));
    %     warplab_setRadioAGCParameter(udp_node1,RADIO2_TXGAINS,(Node1_Radio2_TxGain_RF(index_Total_Loops_Vec) + Node1_Radio2_TxGain_BB(index_Total_Loops_Vec)*2^16));
    %     warplab_setRadioAGCParameter(udp_node1,RADIO3_TXGAINS,(Node1_Radio3_TxGain_RF(index_Total_Loops_Vec) + Node1_Radio3_TxGain_BB(index_Total_Loops_Vec)*2^16));
        %     warplab_setRadioAGCParameter(udp_node1,RADIO4_TXGAINS,(Node1_Radio4_TxGain_RF + Node1_Radio4_TxGain_BB*2^16));
            TxGainsForRadio2 = (Node1_Radio2_TxGain_RF(index_Total_Loops_Vec) + Node1_Radio2_TxGain_BB(index_Total_Loops_Vec)*2^16);
            TxGainsForRadio3 = (Node1_Radio3_TxGain_RF(index_Total_Loops_Vec) + Node1_Radio3_TxGain_BB(index_Total_Loops_Vec)*2^16);
            % Customized warplab to download all gains in one pc-node
            % communication
            warplab_setRadioAGCParameter(udp_node1,RADIO2_RADIO3_TXGAINS,[TxGainsForRadio2,TxGainsForRadio3]);
        end
    
        if(1 == channel_emulator_remote_select)
            % Create emulator handle
            sr5500_test;
            pause(2);
            % Download profile to emulator
            pnet(emulatorHandle, 'printf', 'frec c:\\MD_OfficeA_Ds05_CH3.wce\r');
            pause(30)
            pnet(emulatorHandle, 'printf', 'err?\r');
            pnet(emulatorHandle,'read');
            % Set Input power channel 1
            pnet(emulatorHandle, 'printf', 'chan1:ipow -16.50\r');
            pnet(emulatorHandle, 'printf', 'err?\r');
            pnet(emulatorHandle,'read')
            % Set Input power channel 2
            pnet(emulatorHandle, 'printf', 'chan2:ipow -19.57\r');
            pnet(emulatorHandle, 'printf', 'err?\r');
            pnet(emulatorHandle,'read')
        
            % Set emulator's channel 1 output power
            pnet(emulatorHandle, 'printf', Emu_Out_Power_Ch1(index_Total_Loops_Vec,:));
            pnet(emulatorHandle, 'printf', 'err?\r');
            pnet(emulatorHandle,'read');
            % Set emulator's channel 2 output power
            pnet(emulatorHandle, 'printf', Emu_Out_Power_Ch2(index_Total_Loops_Vec,:));
            pnet(emulatorHandle, 'printf', 'err?\r');
            pnet(emulatorHandle,'read');
        end
    end
end
    

if (Num_Rx == (ValidStart_1+ValidStart_2+ValidStart_3+ValidStart_4))
if (1 == Valid_Timing_Flag_BF)    
    
% Channel Gain
Sum_Channel_Gain_Init_BF2_AllChannels = Sum_Channel_Gain_Init_BF2_AllChannels + Channel_Gain_Init_BF;
Sum_Channel_Gain_BF2_BF2_AllChannels = Sum_Channel_Gain_BF2_BF2_AllChannels + Channel_Gain_BF;

% Noise and SNR 
% Symbols_Sent = Constellation(zsym+1)*scaleConstellation; % Modulated
% symbols were scaled to set Es=1
Noise_Power_BF2_AllChannels = abs(ytx_mod_norm(1:nsym_Payload).'-yrx_bb_mf_ds_mrc_norm).^2;
Signal_Power_BF2_AllChannels = abs(ytx_mod_norm(1:nsym_Payload).').^2;
SignalToNoiseRatio_BF2_AllChannels = Signal_Power_BF2_AllChannels./Noise_Power_BF2_AllChannels; % We set Es = 1;

% Save sent and received constellation point for further postprocessing
% Result_ConstellationPointsTx_BF2_AllChannels((Sum_Total_AllChannels_BF2)*nsym_Payload+1:(Sum_Total_AllChannels_BF2+1)*nsym_Payload,index_Total_Loops_Vec) ...
%     = ytx_mod_norm(1:nsym_Payload);
Result_ConstellationSymbsTx_BF2_AllChannels((Sum_Total_AllChannels_BF2)*nsym_Payload+1:(Sum_Total_AllChannels_BF2+1)*nsym_Payload,index_Total_Loops_Vec) ...
    = uint8(xsym(1:nsym_Payload));
Result_ConstellationPointsRx_BF2_AllChannels((Sum_Total_AllChannels_BF2)*nsym_Payload+1:(Sum_Total_AllChannels_BF2+1)*nsym_Payload,index_Total_Loops_Vec) ...
    = yrx_bb_mf_ds_mrc_norm;

Avg_Noise_Power_BF2_AllChannels = mean(Noise_Power_BF2_AllChannels);
Avg_Signal_Power_BF2_AllChannels = mean(Signal_Power_BF2_AllChannels);
Avg_SignalToNoiseRatio_BF2_AllChannels = mean(SignalToNoiseRatio_BF2_AllChannels);

Sum_Avg_Noise_Power_BF2_AllChannels = Sum_Avg_Noise_Power_BF2_AllChannels + Avg_Noise_Power_BF2_AllChannels;
Sum_Avg_Signal_Power_BF2_AllChannels = Sum_Avg_Signal_Power_BF2_AllChannels + Avg_Signal_Power_BF2_AllChannels;
Sum_Avg_SignalToNoiseRatio_BF2_AllChannels = Sum_Avg_SignalToNoiseRatio_BF2_AllChannels + Avg_SignalToNoiseRatio_BF2_AllChannels;
Sum_Total_AllChannels_BF2 = Sum_Total_AllChannels_BF2 + 1;   

% Save channel estimates 
Result_CE_Init_BF2_AllChannels(Sum_Total_AllChannels_BF2,1:2,index_Total_Loops_Vec) = CE_Init;
Result_CE_BF2_AllChannels(Sum_Total_AllChannels_BF2,1:2,index_Total_Loops_Vec) = CE_BF;
Result_CE_NoBF2_AllChannels(Sum_Total_AllChannels_BF2,1:2,index_Total_Loops_Vec) = CE_NoBF;
Result_Index_Init_BF2_AllChannels(Sum_Total_AllChannels_BF2,index_Total_Loops_Vec) = uint8(Index_Init);
Result_Index_check_BF2_AllChannels(Sum_Total_AllChannels_BF2,index_Total_Loops_Vec) = uint8(Index_check);

% Save saturation flag corresponding to each channel estimate
Result_Saturation_Flag_Init_BF2_AllChannels(Sum_Total_AllChannels_BF2,index_Total_Loops_Vec) = uint8(Saturation_Flag_BF_Init);
Result_Saturation_Flag_BF2_AllChannels(Sum_Total_AllChannels_BF2,index_Total_Loops_Vec) = uint8(Saturation_Flag_BF);

% Save scale payload value
Result_ScalePayload_BF2(Sum_Total_AllChannels_BF2,index_Total_Loops_Vec) = uint16(scale_Payload*2^16);

if(1 == channel_select)
%     [GainsRF_Init,GainsBB_Init] = warplab_readAGCGains(udp_node2);
    Result_RF_RxGain_Mat_BF2_AllChannels(Sum_Total_AllChannels_BF2,index_Total_Loops_Vec) = uint8(BF_GainsRF_BF);
    Result_BB_RxGain_Mat_BF2_AllChannels(Sum_Total_AllChannels_BF2,index_Total_Loops_Vec) = uint8(BF_GainsBB_BF);
    Result_RF_RxGain_Mat_BF2_Init_AllChannels(Sum_Total_AllChannels_BF2,index_Total_Loops_Vec) = uint8(BF_GainsRF_Init);
    Result_BB_RxGain_Mat_BF2_Init_AllChannels(Sum_Total_AllChannels_BF2,index_Total_Loops_Vec) = uint8(BF_GainsBB_Init);
end


% Check Beamforming coherence time
if(Index_Init ~= Index_check)
    Result_Coherent_Flag_BF2_AllChannels(Sum_Total_AllChannels_BF2,index_Total_Loops_Vec) = 0;
    % Errors and total bits for noncoherent channels
    Sum_Total_NonCoherentChannels_BF2 = Sum_Total_NonCoherentChannels_BF2 + 1;
    Total_Bits_BF2_NonCoherentChannels = Total_Bits_BF2_NonCoherentChannels + number_of_bits;
    Total_Errors_BF2_NonCoherentChannels = Total_Errors_BF2_NonCoherentChannels + number_of_errors;
    % Errors and toatl bits for noncoherent channels that were not saturated
    if(0==(Saturation_Flag_BF+Saturation_Flag_BF_Init))
       Total_Bits_BF2_NonCoherentChannels_NonSat = Total_Bits_BF2_NonCoherentChannels_NonSat + number_of_bits;
       Total_Errors_BF2_NonCoherentChannels_NonSat = Total_Errors_BF2_NonCoherentChannels_NonSat + number_of_errors;
    end
else
% Statistics for coherent channels

Result_Coherent_Flag_BF2_AllChannels(Sum_Total_AllChannels_BF2,index_Total_Loops_Vec) = 1;


% Errors and total bits for coherent channels
Total_Bits_BF2_CoherentChannels = Total_Bits_BF2_CoherentChannels + number_of_bits;
Total_Errors_BF2_CoherentChannels = Total_Errors_BF2_CoherentChannels + number_of_errors;

% Errors and toatl bits for coherent channels that were not saturated
if(0==(Saturation_Flag_BF+Saturation_Flag_BF_Init))
    Total_Bits_BF2_CoherentChannels_NonSat = Total_Bits_BF2_CoherentChannels_NonSat + number_of_bits;
    Total_Errors_BF2_CoherentChannels_NonSat = Total_Errors_BF2_CoherentChannels_NonSat + number_of_errors;
end

% Channel Gain
Sum_Channel_Gain_Init_BF2_CoherentChannels = Sum_Channel_Gain_Init_BF2_CoherentChannels + Channel_Gain_Init_BF;
Sum_Channel_Gain_BF2_BF2_CoherentChannels = Sum_Channel_Gain_BF2_BF2_CoherentChannels + Channel_Gain_BF;

% Noise and SNR 
% Symbols_Sent = Constellation(zsym+1)*scaleConstellation; % Modulated
% symbols were scaled to set Es=1
Noise_Power_BF2_CoherentChannels = abs(ytx_mod_norm(1:nsym_Payload).'-yrx_bb_mf_ds_mrc_norm).^2;
% Noise_Power_BF2_CoherentChannels = Noise_Power_BF2_CoherentChannels.* Channel_Gain_BF;
Signal_Power_BF2_CoherentChannels = abs(ytx_mod_norm(1:nsym_Payload).').^2;
SignalToNoiseRatio_BF2_CoherentChannels = Signal_Power_BF2_CoherentChannels./Noise_Power_BF2_CoherentChannels; % We set Es = 1;
% Result_ConstellationPointsTx_BF2_CoherentChannels((Sum_Total_CoherentChannels_BF2)*nsym_Payload+1:(Sum_Total_CoherentChannels_BF2+1)*nsym_Payload,index_Total_Loops_Vec) ...
%     = ytx_mod_norm(1:nsym_Payload);
Result_ConstellationSymbsTx_BF2_CoherentChannels((Sum_Total_CoherentChannels_BF2)*nsym_Payload+1:(Sum_Total_CoherentChannels_BF2+1)*nsym_Payload,index_Total_Loops_Vec) ...
    = uint8(xsym(1:nsym_Payload));
Result_ConstellationPointsRx_BF2_CoherentChannels((Sum_Total_CoherentChannels_BF2)*nsym_Payload+1:(Sum_Total_CoherentChannels_BF2+1)*nsym_Payload,index_Total_Loops_Vec) ...
    = yrx_bb_mf_ds_mrc_norm;

Avg_Noise_Power_BF2_CoherentChannels = mean(Noise_Power_BF2_CoherentChannels);
Avg_Signal_Power_BF2_CoherentChannels = mean(Signal_Power_BF2_CoherentChannels);
Avg_SignalToNoiseRatio_BF2_CoherentChannels = mean(SignalToNoiseRatio_BF2_CoherentChannels);

Sum_Avg_Noise_Power_BF2_CoherentChannels = Sum_Avg_Noise_Power_BF2_CoherentChannels + Avg_Noise_Power_BF2_CoherentChannels;
Sum_Avg_Signal_Power_BF2_CoherentChannels = Sum_Avg_Signal_Power_BF2_CoherentChannels + Avg_Signal_Power_BF2_CoherentChannels;
Sum_Avg_SignalToNoiseRatio_BF2_CoherentChannels = Sum_Avg_SignalToNoiseRatio_BF2_CoherentChannels + Avg_SignalToNoiseRatio_BF2_CoherentChannels;
Sum_Total_CoherentChannels_BF2 = Sum_Total_CoherentChannels_BF2 + 1;

% Save channel estimates

Result_CE_Init_BF2_CoherentChannels(Sum_Total_CoherentChannels_BF2,1:2,index_Total_Loops_Vec) = CE_Init;
Result_CE_BF2_CoherentChannels(Sum_Total_CoherentChannels_BF2,1:2,index_Total_Loops_Vec) = CE_BF;
Result_CE_NoBF2_CoherentChannels(Sum_Total_CoherentChannels_BF2,1:2,index_Total_Loops_Vec) = CE_NoBF;
Result_Index_Init_BF2_CoherentChannels(Sum_Total_CoherentChannels_BF2,index_Total_Loops_Vec) = uint8(Index_Init);
Result_Index_check_BF2_CoherentChannels(Sum_Total_CoherentChannels_BF2,index_Total_Loops_Vec) = uint8(Index_check);

% Save saturation flag corresponding to each channel estimate
Result_Saturation_Flag_Init_BF2_CoherentChannels(Sum_Total_CoherentChannels_BF2,index_Total_Loops_Vec) = uint8(Saturation_Flag_BF_Init);
Result_Saturation_Flag_BF2_CoherentChannels(Sum_Total_CoherentChannels_BF2,index_Total_Loops_Vec) = uint8(Saturation_Flag_BF);

if(1 == channel_select)
%     [GainsRF_Init,GainsBB_Init] = warplab_readAGCGains(udp_node2);
    Result_RF_RxGain_Mat_BF2_CoherentChannels(Sum_Total_CoherentChannels_BF2,index_Total_Loops_Vec) = uint8(BF_GainsRF_BF);
    Result_BB_RxGain_Mat_BF2_CoherentChannels(Sum_Total_CoherentChannels_BF2,index_Total_Loops_Vec) = uint8(BF_GainsBB_BF);
    Result_RF_RxGain_Mat_BF2_Init_CoherentChannels(Sum_Total_CoherentChannels_BF2,index_Total_Loops_Vec) = uint8(BF_GainsRF_Init);
    Result_BB_RxGain_Mat_BF2_Init_CoherentChannels(Sum_Total_CoherentChannels_BF2,index_Total_Loops_Vec) = uint8(BF_GainsBB_Init);
end
end
end
end

%% RUN EXPERIMENT FOR BF3 SCHEME (2X1 INFINITE BITS OF FEEDBACK)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set some flags for gathering statistics and some flags used by the
% beamforming code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Passed_Init_Timing_Flag = 0;
Passed_BF_Timing_Flag = 0;
Failed_Init_Timing_Flag_Length = 0;
Failed_BF_Timing_Flag_Length = 0;
EMac_Fail_Flag = 0;

% Already computer Tx vectors and downloaded them to the Tx nodes. This was
% done to run experiment for BF1 scheme
RecomputeReloadBFTxVecs_Flag = 0; % Used in Tx2Rx1_BFvsAlm_BFProc_FPGA.... 
InfiniteFeedbackFlag = 1; % We are using Infinite feedback (Rx and TX have same Channel State Information)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Transmit and receive symbols using transmit beamforming and receive
% combining 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Write codebook to use in Codebook_Original variable
Codebook_Original = 0; % Codebook not needed for infinite feedback scheme (not for Alamouti)
Tx2Rx1_BFvsAlm_BFProc_FPGA_BF_FRONTEND_v07

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute statistics for beamforming
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(0==Passed_Init_Timing_Flag)
    Sum_Total_FailedInitTiming_BF3 = Sum_Total_FailedInitTiming_BF3 + 1;
    Sum_Total_FailedInitTiming_BF3_Length = Sum_Total_FailedInitTiming_BF3_Length + Failed_Init_Timing_Flag_Length;
end
if((1==Passed_Init_Timing_Flag)&&(0==Passed_BF_Timing_Flag))
    Sum_Total_FailedBFTiming_BF3 = Sum_Total_FailedBFTiming_BF3 + 1;
    Sum_Total_FailedBFTiming_BF3_Length = Sum_Total_FailedBFTiming_BF3_Length + Failed_BF_Timing_Flag_Length;
end

if(1 == channel_select)
    if(1==EMac_Fail_Flag)
        % AFTER WE CHANGED THE IP TOOLBOX FOR FAST READ WE STOPPED GETTING
        % EMAC FAILURES, HENCE THE CODE IN THIS IF STATEMENT 
        % MAY NOT BE NEEDED ANYMORE
        pnet('closeall');
        warplab_initialize_afterEMacFail;
        
        warplab_sendCmd(udp_node1, RADIO2_RADIO3_TX_DISABLE, packetNum);
        warplab_sendCmd(udp_node2, RADIO2_RX_DISABLE, packetNum);
        warplab_sendCmd(udp_node2, AGC_RESET, packetNum);
        
        Counter_EMac_Fails = Counter_EMac_Fails + 1;
        if(15==Counter_EMac_Fails)
            error('Too many EMac fails!')
        end
    
        if(0 == channel_emulator_remote_select)
            % If we are using the channel emulator remote command gains have already been set
        % so no need to enter this if statement and set them again
    %     warplab_setRadioAGCParameter(udp_node1,RADIO1_TXGAINS,(Node1_Radio1_TxGain_RF + Node1_Radio1_TxGain_BB*2^16));
    %     warplab_setRadioAGCParameter(udp_node1,RADIO2_TXGAINS,(Node1_Radio2_TxGain_RF(index_Total_Loops_Vec) + Node1_Radio2_TxGain_BB(index_Total_Loops_Vec)*2^16));
    %     warplab_setRadioAGCParameter(udp_node1,RADIO3_TXGAINS,(Node1_Radio3_TxGain_RF(index_Total_Loops_Vec) + Node1_Radio3_TxGain_BB(index_Total_Loops_Vec)*2^16));
        %     warplab_setRadioAGCParameter(udp_node1,RADIO4_TXGAINS,(Node1_Radio4_TxGain_RF + Node1_Radio4_TxGain_BB*2^16));
            TxGainsForRadio2 = (Node1_Radio2_TxGain_RF(index_Total_Loops_Vec) + Node1_Radio2_TxGain_BB(index_Total_Loops_Vec)*2^16);
            TxGainsForRadio3 = (Node1_Radio3_TxGain_RF(index_Total_Loops_Vec) + Node1_Radio3_TxGain_BB(index_Total_Loops_Vec)*2^16);
            % Customized warplab to download all gains in one pc-node
            % communication
            warplab_setRadioAGCParameter(udp_node1,RADIO2_RADIO3_TXGAINS,[TxGainsForRadio2,TxGainsForRadio3]);
        end
    
        if(1 == channel_emulator_remote_select)
            % Create emulator handle
            sr5500_test;
            pause(2);
            % Download profile to emulator
            pnet(emulatorHandle, 'printf', 'frec c:\\MD_OfficeA_Ds05_CH3.wce\r');
            pause(30)
            pnet(emulatorHandle, 'printf', 'err?\r');
            pnet(emulatorHandle,'read');
            % Set Input power channel 1
            pnet(emulatorHandle, 'printf', 'chan1:ipow -16.50\r');
            pnet(emulatorHandle, 'printf', 'err?\r');
            pnet(emulatorHandle,'read')
            % Set Input power channel 2
            pnet(emulatorHandle, 'printf', 'chan2:ipow -19.57\r');
            pnet(emulatorHandle, 'printf', 'err?\r');
            pnet(emulatorHandle,'read')
        
            % Set emulator's channel 1 output power
            pnet(emulatorHandle, 'printf', Emu_Out_Power_Ch1(index_Total_Loops_Vec,:));
            pnet(emulatorHandle, 'printf', 'err?\r');
            pnet(emulatorHandle,'read');
            % Set emulator's channel 2 output power
            pnet(emulatorHandle, 'printf', Emu_Out_Power_Ch2(index_Total_Loops_Vec,:));
            pnet(emulatorHandle, 'printf', 'err?\r');
            pnet(emulatorHandle,'read');
        end
    end
end
    

if (Num_Rx == (ValidStart_1+ValidStart_2+ValidStart_3+ValidStart_4))
if (1 == Valid_Timing_Flag_BF)    
    
% Channel Gain
Sum_Channel_Gain_Init_BF3_AllChannels = Sum_Channel_Gain_Init_BF3_AllChannels + Channel_Gain_Init_BF;
Sum_Channel_Gain_BF3_BF3_AllChannels = Sum_Channel_Gain_BF3_BF3_AllChannels + Channel_Gain_BF;

% Noise and SNR 
% Symbols_Sent = Constellation(zsym+1)*scaleConstellation; % Modulated
% symbols were scaled to set Es=1
Noise_Power_BF3_AllChannels = abs(ytx_mod_norm(1:nsym_Payload).'-yrx_bb_mf_ds_mrc_norm).^2;
Signal_Power_BF3_AllChannels = abs(ytx_mod_norm(1:nsym_Payload).').^2;
SignalToNoiseRatio_BF3_AllChannels = Signal_Power_BF3_AllChannels./Noise_Power_BF3_AllChannels; % We set Es = 1;

% Save sent and received constellation point for further postprocessing
% Result_ConstellationPointsTx_BF3_AllChannels((Sum_Total_AllChannels_BF3)*nsym_Payload+1:(Sum_Total_AllChannels_BF3+1)*nsym_Payload,index_Total_Loops_Vec) ...
%     = ytx_mod_norm(1:nsym_Payload);
Result_ConstellationSymbsTx_BF3_AllChannels((Sum_Total_AllChannels_BF3)*nsym_Payload+1:(Sum_Total_AllChannels_BF3+1)*nsym_Payload,index_Total_Loops_Vec) ...
    = uint8(xsym(1:nsym_Payload));
Result_ConstellationPointsRx_BF3_AllChannels((Sum_Total_AllChannels_BF3)*nsym_Payload+1:(Sum_Total_AllChannels_BF3+1)*nsym_Payload,index_Total_Loops_Vec) ...
    = yrx_bb_mf_ds_mrc_norm;

Avg_Noise_Power_BF3_AllChannels = mean(Noise_Power_BF3_AllChannels);
Avg_Signal_Power_BF3_AllChannels = mean(Signal_Power_BF3_AllChannels);
Avg_SignalToNoiseRatio_BF3_AllChannels = mean(SignalToNoiseRatio_BF3_AllChannels);

Sum_Avg_Noise_Power_BF3_AllChannels = Sum_Avg_Noise_Power_BF3_AllChannels + Avg_Noise_Power_BF3_AllChannels;
Sum_Avg_Signal_Power_BF3_AllChannels = Sum_Avg_Signal_Power_BF3_AllChannels + Avg_Signal_Power_BF3_AllChannels;
Sum_Avg_SignalToNoiseRatio_BF3_AllChannels = Sum_Avg_SignalToNoiseRatio_BF3_AllChannels + Avg_SignalToNoiseRatio_BF3_AllChannels;
Sum_Total_AllChannels_BF3 = Sum_Total_AllChannels_BF3 + 1;   

% Save channel estimates 
Result_CE_Init_BF3_AllChannels(Sum_Total_AllChannels_BF3,1:2,index_Total_Loops_Vec) = CE_Init;
Result_CE_BF3_AllChannels(Sum_Total_AllChannels_BF3,1:2,index_Total_Loops_Vec) = CE_BF;
Result_CE_NoBF3_AllChannels(Sum_Total_AllChannels_BF3,1:2,index_Total_Loops_Vec) = CE_NoBF;
% Result_Index_Init_BF3_AllChannels(Sum_Total_AllChannels_BF3,index_Total_Loops_Vec) = uint8(Index_Init); Codebook index not relevant in infinite feedback there is no codebook
% Result_Index_check_BF3_AllChannels(Sum_Total_AllChannels_BF3,index_Total_Loops_Vec) = uint8(Index_check);  Codebook index not relevant in infinite feedback there is no codebook

% Save saturation flag corresponding to each channel estimate
Result_Saturation_Flag_Init_BF3_AllChannels(Sum_Total_AllChannels_BF3,index_Total_Loops_Vec) = uint8(Saturation_Flag_BF_Init);
Result_Saturation_Flag_BF3_AllChannels(Sum_Total_AllChannels_BF3,index_Total_Loops_Vec) = uint8(Saturation_Flag_BF);

% Save scale payload value
Result_ScalePayload_BF3(Sum_Total_AllChannels_BF3,index_Total_Loops_Vec) = uint16(scale_Payload*2^16);

if(1 == channel_select)
%     [GainsRF_Init,GainsBB_Init] = warplab_readAGCGains(udp_node2);
    Result_RF_RxGain_Mat_BF3_AllChannels(Sum_Total_AllChannels_BF3,index_Total_Loops_Vec) = uint8(BF_GainsRF_BF);
    Result_BB_RxGain_Mat_BF3_AllChannels(Sum_Total_AllChannels_BF3,index_Total_Loops_Vec) = uint8(BF_GainsBB_BF);
    Result_RF_RxGain_Mat_BF3_Init_AllChannels(Sum_Total_AllChannels_BF3,index_Total_Loops_Vec) = uint8(BF_GainsRF_Init);
    Result_BB_RxGain_Mat_BF3_Init_AllChannels(Sum_Total_AllChannels_BF3,index_Total_Loops_Vec) = uint8(BF_GainsBB_Init);
end

% IMPORTANT NOTE:
% In infinite feedback we do not check for "coherence time" since there are
% no codebok indices to compare

% % % Check Beamforming coherence time
% % if(Index_Init ~= Index_check)
% %     Result_Coherent_Flag_BF3_AllChannels(Sum_Total_AllChannels_BF3,index_Total_Loops_Vec) = 0;
% %     % Errors and total bits for noncoherent channels

% IMPORTANT NOTE:
% We store statistics for everychannel in NonCoherentChannels variable
Sum_Total_NonCoherentChannels_BF3 = Sum_Total_NonCoherentChannels_BF3 + 1;
Total_Bits_BF3_NonCoherentChannels = Total_Bits_BF3_NonCoherentChannels + number_of_bits;
Total_Errors_BF3_NonCoherentChannels = Total_Errors_BF3_NonCoherentChannels + number_of_errors;
% Errors and toatl bits for noncoherent channels that were not saturated
if(0==(Saturation_Flag_BF+Saturation_Flag_BF_Init))
   Total_Bits_BF3_NonCoherentChannels_NonSat = Total_Bits_BF3_NonCoherentChannels_NonSat + number_of_bits;
   Total_Errors_BF3_NonCoherentChannels_NonSat = Total_Errors_BF3_NonCoherentChannels_NonSat + number_of_errors;
end

% % else
% % % Statistics for coherent channels
% % 
% % Result_Coherent_Flag_BF3_AllChannels(Sum_Total_AllChannels_BF3,index_Total_Loops_Vec) = 1;
% % 
% % 
% % % Errors and total bits for coherent channels
% % Total_Bits_BF3_CoherentChannels = Total_Bits_BF3_CoherentChannels + number_of_bits;
% % Total_Errors_BF3_CoherentChannels = Total_Errors_BF3_CoherentChannels + number_of_errors;
% % 
% % % Errors and toatl bits for coherent channels that were not saturated
% % if(0==(Saturation_Flag_BF+Saturation_Flag_BF_Init))
% %     Total_Bits_BF3_CoherentChannels_NonSat = Total_Bits_BF3_CoherentChannels_NonSat + number_of_bits;
% %     Total_Errors_BF3_CoherentChannels_NonSat = Total_Errors_BF3_CoherentChannels_NonSat + number_of_errors;
% % end
% % 
% % % Channel Gain
% % Sum_Channel_Gain_Init_BF3_CoherentChannels = Sum_Channel_Gain_Init_BF3_CoherentChannels + Channel_Gain_Init_BF;
% % Sum_Channel_Gain_BF3_BF3_CoherentChannels = Sum_Channel_Gain_BF3_BF3_CoherentChannels + Channel_Gain_BF;
% % 
% % % Noise and SNR 
% % % Symbols_Sent = Constellation(zsym+1)*scaleConstellation; % Modulated
% % % symbols were scaled to set Es=1
% % Noise_Power_BF3_CoherentChannels = abs(ytx_mod_norm(1:nsym_Payload).'-yrx_bb_mf_ds_mrc_norm).^2;
% % % Noise_Power_BF3_CoherentChannels = Noise_Power_BF3_CoherentChannels.* Channel_Gain_BF;
% % Signal_Power_BF3_CoherentChannels = abs(ytx_mod_norm(1:nsym_Payload).').^2;
% % SignalToNoiseRatio_BF3_CoherentChannels = Signal_Power_BF3_CoherentChannels./Noise_Power_BF3_CoherentChannels; % We set Es = 1;
% % % Result_ConstellationPointsTx_BF3_CoherentChannels((Sum_Total_CoherentChannels_BF3)*nsym_Payload+1:(Sum_Total_CoherentChannels_BF3+1)*nsym_Payload,index_Total_Loops_Vec) ...
% % %     = ytx_mod_norm(1:nsym_Payload);
% % Result_ConstellationSymbsTx_BF3_CoherentChannels((Sum_Total_CoherentChannels_BF3)*nsym_Payload+1:(Sum_Total_CoherentChannels_BF3+1)*nsym_Payload,index_Total_Loops_Vec) ...
% %     = uint8(xsym(1:nsym_Payload));
% % Result_ConstellationPointsRx_BF3_CoherentChannels((Sum_Total_CoherentChannels_BF3)*nsym_Payload+1:(Sum_Total_CoherentChannels_BF3+1)*nsym_Payload,index_Total_Loops_Vec) ...
% %     = yrx_bb_mf_ds_mrc_norm;
% % 
% % Avg_Noise_Power_BF3_CoherentChannels = mean(Noise_Power_BF3_CoherentChannels);
% % Avg_Signal_Power_BF3_CoherentChannels = mean(Signal_Power_BF3_CoherentChannels);
% % Avg_SignalToNoiseRatio_BF3_CoherentChannels = mean(SignalToNoiseRatio_BF3_CoherentChannels);
% % 
% % Sum_Avg_Noise_Power_BF3_CoherentChannels = Sum_Avg_Noise_Power_BF3_CoherentChannels + Avg_Noise_Power_BF3_CoherentChannels;
% % Sum_Avg_Signal_Power_BF3_CoherentChannels = Sum_Avg_Signal_Power_BF3_CoherentChannels + Avg_Signal_Power_BF3_CoherentChannels;
% % Sum_Avg_SignalToNoiseRatio_BF3_CoherentChannels = Sum_Avg_SignalToNoiseRatio_BF3_CoherentChannels + Avg_SignalToNoiseRatio_BF3_CoherentChannels;
% % Sum_Total_CoherentChannels_BF3 = Sum_Total_CoherentChannels_BF3 + 1;
% % 
% % % Save channel estimates
% % 
% % Result_CE_Init_BF3_CoherentChannels(Sum_Total_CoherentChannels_BF3,1:2,index_Total_Loops_Vec) = CE_Init;
% % Result_CE_BF3_CoherentChannels(Sum_Total_CoherentChannels_BF3,1:2,index_Total_Loops_Vec) = CE_BF;
% % Result_CE_NoBF3_CoherentChannels(Sum_Total_CoherentChannels_BF3,1:2,index_Total_Loops_Vec) = CE_NoBF;
% % Result_Index_Init_BF3_CoherentChannels(Sum_Total_CoherentChannels_BF3,index_Total_Loops_Vec) = uint8(Index_Init);
% % Result_Index_check_BF3_CoherentChannels(Sum_Total_CoherentChannels_BF3,index_Total_Loops_Vec) = uint8(Index_check);
% % 
% % % Save saturation flag corresponding to each channel estimate
% % Result_Saturation_Flag_Init_BF3_CoherentChannels(Sum_Total_CoherentChannels_BF3,index_Total_Loops_Vec) = uint8(Saturation_Flag_BF_Init);
% % Result_Saturation_Flag_BF3_CoherentChannels(Sum_Total_CoherentChannels_BF3,index_Total_Loops_Vec) = uint8(Saturation_Flag_BF);
% % 
% % if(1 == channel_select)
% % %     [GainsRF_Init,GainsBB_Init] = warplab_readAGCGains(udp_node2);
% %     Result_RF_RxGain_Mat_BF3_CoherentChannels(Sum_Total_CoherentChannels_BF3,index_Total_Loops_Vec) = uint8(BF_GainsRF_BF);
% %     Result_BB_RxGain_Mat_BF3_CoherentChannels(Sum_Total_CoherentChannels_BF3,index_Total_Loops_Vec) = uint8(BF_GainsBB_BF);
% %     Result_RF_RxGain_Mat_BF3_Init_CoherentChannels(Sum_Total_CoherentChannels_BF3,index_Total_Loops_Vec) = uint8(BF_GainsRF_Init);
% %     Result_BB_RxGain_Mat_BF3_Init_CoherentChannels(Sum_Total_CoherentChannels_BF3,index_Total_Loops_Vec) = uint8(BF_GainsBB_Init);
% % end
% % end
end
end

%% RUN EXPERIMENT FOR ALAMOUTI SCHEME
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set some flags for gathering statistics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Passed_Alm_Timing_Flag = 0;
Failed_Alm_Timing_Flag_Length = 0;
EMac_Fail_Flag = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Transmit and receive Alamouit encoded symbols
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Tx2Rx1_BFvsAlm_AlmProc_FPGA_BF_FRONTEND_v07

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute statistics for Alamouti
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (0 == Passed_Alm_Timing_Flag)
    Sum_Total_FailedAlmTiming_Length = Sum_Total_FailedAlmTiming_Length + Failed_Alm_Timing_Flag_Length;
end

if(1 == channel_select)
    if(1==EMac_Fail_Flag)
        % AFTER WE CHANGED THE IP TOOLBOX FOR FAST READ WE STOPPED GETTING
        % EMAC FAILURES, HENCE THE CODE IN THIS IF STATEMENT 
        % MAY NOT BE NEEDED ANYMORE
        pnet('closeall');
        warplab_initialize_afterEMacFail;
        
        warplab_sendCmd(udp_node1, RADIO2_RADIO3_TX_DISABLE, packetNum);
        warplab_sendCmd(udp_node2, RADIO2_RX_DISABLE, packetNum);
        warplab_sendCmd(udp_node2, AGC_RESET, packetNum);
        
        Counter_EMac_Fails = Counter_EMac_Fails + 1;
        if(15==Counter_EMac_Fails)
            error('Too many EMac fails!')
        end
    
        if(0 == channel_emulator_remote_select)
            % If we are using the channel emulator remote command gains have already been set
        % so no need to enter this if statement and set them again
    %     warplab_setRadioAGCParameter(udp_node1,RADIO1_TXGAINS,(Node1_Radio1_TxGain_RF + Node1_Radio1_TxGain_BB*2^16));
    %     warplab_setRadioAGCParameter(udp_node1,RADIO2_TXGAINS,(Node1_Radio2_TxGain_RF(index_Total_Loops_Vec) + Node1_Radio2_TxGain_BB(index_Total_Loops_Vec)*2^16));
    %     warplab_setRadioAGCParameter(udp_node1,RADIO3_TXGAINS,(Node1_Radio3_TxGain_RF(index_Total_Loops_Vec) + Node1_Radio3_TxGain_BB(index_Total_Loops_Vec)*2^16));
        %     warplab_setRadioAGCParameter(udp_node1,RADIO4_TXGAINS,(Node1_Radio4_TxGain_RF + Node1_Radio4_TxGain_BB*2^16));
            TxGainsForRadio2 = (Node1_Radio2_TxGain_RF(index_Total_Loops_Vec) + Node1_Radio2_TxGain_BB(index_Total_Loops_Vec)*2^16);
            TxGainsForRadio3 = (Node1_Radio3_TxGain_RF(index_Total_Loops_Vec) + Node1_Radio3_TxGain_BB(index_Total_Loops_Vec)*2^16);
            % Customized warplab to download all gains in one pc-node
            % communication
            warplab_setRadioAGCParameter(udp_node1,RADIO2_RADIO3_TXGAINS,[TxGainsForRadio2,TxGainsForRadio3]);
        end
    
        if(1 == channel_emulator_remote_select)
            % Create emulator handle
            sr5500_test;
            pause(2);
            % Download profile to emulator
            pnet(emulatorHandle, 'printf', 'frec c:\\MD_OfficeA_Ds05_CH3.wce\r');
            pause(30)
            pnet(emulatorHandle, 'printf', 'err?\r');
            pnet(emulatorHandle,'read');
            % Set Input power channel 1
            pnet(emulatorHandle, 'printf', 'chan1:ipow -16.50\r');
            pnet(emulatorHandle, 'printf', 'err?\r');
            pnet(emulatorHandle,'read')
            % Set Input power channel 2
            pnet(emulatorHandle, 'printf', 'chan2:ipow -19.57\r');
            pnet(emulatorHandle, 'printf', 'err?\r');
            pnet(emulatorHandle,'read')
        
            % Set emulator's channel 1 output power
            pnet(emulatorHandle, 'printf', Emu_Out_Power_Ch1(index_Total_Loops_Vec,:));
            pnet(emulatorHandle, 'printf', 'err?\r');
            pnet(emulatorHandle,'read');
            % Set emulator's channel 2 output power
            pnet(emulatorHandle, 'printf', Emu_Out_Power_Ch2(index_Total_Loops_Vec,:));
            pnet(emulatorHandle, 'printf', 'err?\r');
            pnet(emulatorHandle,'read');
        end
    end
end
    
if (Num_Rx == (ValidStart_1+ValidStart_2+ValidStart_3+ValidStart_4))
if (1 == Valid_Timing_Flag_Alm)
Total_Bits_Alm = Total_Bits_Alm + number_of_bits;
Total_Errors_Alm = Total_Errors_Alm + number_of_errors;
% Errors and toatl bits for channels that were not saturated
if(0==Saturation_Flag_Alm)
    Total_Bits_Alm_NonSat = Total_Bits_Alm_NonSat + number_of_bits;
    Total_Errors_Alm_NonSat = Total_Errors_Alm_NonSat + number_of_errors;
end
% Channel Gain
Sum_Channel_Gain_Alm = Sum_Channel_Gain_Alm + Channel_Gain_Alm;
% Noise and SNR 
% Symbols_Sent = Constellation(zsym+1)*scaleConstellation; % Modulated symbols were scaled to set Es=1
Noise_Power_Alm = abs(ytx_mod_norm(1:nsym_Payload).'-yrx_bb_mf_ds_alm_norm).^2;
Signal_Power_Alm = abs(ytx_mod_norm(1:nsym_Payload).').^2;
SignalToNoiseRatio_Alm = Signal_Power_Alm./Noise_Power_Alm; % We set Es = 1;

% Result_ConstellationPointsTx_Alm((Sum_Total_Channels_Alm)*nsym_Payload+1:(Sum_Total_Channels_Alm+1)*nsym_Payload,index_Total_Loops_Vec) ...
%     = ytx_mod_norm(1:nsym_Payload);
Result_ConstellationSymbsTx_Alm((Sum_Total_Channels_Alm)*nsym_Payload+1:(Sum_Total_Channels_Alm+1)*nsym_Payload,index_Total_Loops_Vec) ...
    = uint8(xsym(1:nsym_Payload));
Result_ConstellationPointsRx_Alm((Sum_Total_Channels_Alm)*nsym_Payload+1:(Sum_Total_Channels_Alm+1)*nsym_Payload,index_Total_Loops_Vec) ...
    = yrx_bb_mf_ds_alm_norm;

Avg_Noise_Power_Alm = mean(Noise_Power_Alm);
Avg_Signal_Power_Alm = mean(Signal_Power_Alm);
Avg_SignalToNoiseRatio_Alm = mean(SignalToNoiseRatio_Alm);
Sum_Avg_Noise_Power_Alm = Sum_Avg_Noise_Power_Alm + Avg_Noise_Power_Alm;
Sum_Avg_Signal_Power_Alm = Sum_Avg_Signal_Power_Alm + Avg_Signal_Power_Alm;
Sum_Avg_SignalToNoiseRatio_Alm = Sum_Avg_SignalToNoiseRatio_Alm + Avg_SignalToNoiseRatio_Alm;
Sum_Total_Channels_Alm = Sum_Total_Channels_Alm + 1;

% Save channel estimates

Result_CE_Alm(Sum_Total_Channels_Alm,1:2,index_Total_Loops_Vec) = CE;

% Save saturation flag corresponding to each channel estimate
Result_Saturation_Flag_Alm(Sum_Total_Channels_Alm,index_Total_Loops_Vec) = uint8(Saturation_Flag_Alm);
% Save scale payload value
Result_ScalePayload_Alm(Sum_Total_Channels_Alm,index_Total_Loops_Vec) = uint16(scale_Payload*2^16);

if(1 == channel_select)
%     [GainsRF_Init,GainsBB_Init] = warplab_readAGCGains(udp_node2);
    Result_RF_RxGain_Mat_Alm(Sum_Total_Channels_Alm,index_Total_Loops_Vec) = uint8(Alm_GainsRF);
    Result_BB_RxGain_Mat_Alm(Sum_Total_Channels_Alm,index_Total_Loops_Vec) = uint8(Alm_GainsBB);
end
end
end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% COMPUTE STATISTICS FOR BEAMFORMING BF1 SCHEME
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% For coherent channels
Result_Total_Bits_Vec_BF1_CoherentChannels(index_Total_Loops_Vec) = Total_Bits_BF1_CoherentChannels
Result_Total_Errors_Vec_BF1_CoherentChannels(index_Total_Loops_Vec) = Total_Errors_BF1_CoherentChannels 
Result_BER_BF1_CoherentChannels(index_Total_Loops_Vec) = Total_Errors_BF1_CoherentChannels / Total_Bits_BF1_CoherentChannels
Result_Total_Bits_Vec_BF1_CoherentChannels_NonSat(index_Total_Loops_Vec) = Total_Bits_BF1_CoherentChannels_NonSat
Result_Total_Errors_Vec_BF1_CoherentChannels_NonSat(index_Total_Loops_Vec) = Total_Errors_BF1_CoherentChannels_NonSat 
Result_BER_BF1_CoherentChannels_NonSat(index_Total_Loops_Vec) = Total_Errors_BF1_CoherentChannels_NonSat / Total_Bits_BF1_CoherentChannels_NonSat
Result_Channel_Gain_Init_Vec_BF1_CoherentChannels(index_Total_Loops_Vec) = Sum_Channel_Gain_Init_BF1_CoherentChannels/Sum_Total_CoherentChannels_BF1;
Result_Channel_Gain_BF1_Vec_BF1_CoherentChannels(index_Total_Loops_Vec) = Sum_Channel_Gain_BF1_BF1_CoherentChannels/Sum_Total_CoherentChannels_BF1;
Result_Avg_Noise_Power_Vec_BF1_CoherentChannels(index_Total_Loops_Vec) = Sum_Avg_Noise_Power_BF1_CoherentChannels/Sum_Total_CoherentChannels_BF1;
Result_Avg_Signal_Power_Vec_BF1_CoherentChannels(index_Total_Loops_Vec) = Sum_Avg_Signal_Power_BF1_CoherentChannels/Sum_Total_CoherentChannels_BF1;
Result_Avg_SignalToNoiseRatio_Vec_BF1_CoherentChannels(index_Total_Loops_Vec) = Sum_Avg_SignalToNoiseRatio_BF1_CoherentChannels/Sum_Total_CoherentChannels_BF1;

Result_Total_Bits_Vec_BF1_AllChannels(index_Total_Loops_Vec) = Total_Bits_BF1_CoherentChannels + Total_Bits_BF1_NonCoherentChannels
Result_Total_Errors_Vec_BF1_AllChannels(index_Total_Loops_Vec) = Total_Errors_BF1_CoherentChannels + Total_Errors_BF1_NonCoherentChannels
Result_BER_BF1_AllChannels(index_Total_Loops_Vec) = (Total_Errors_BF1_CoherentChannels + Total_Errors_BF1_NonCoherentChannels) / (Total_Bits_BF1_CoherentChannels + Total_Bits_BF1_NonCoherentChannels)
Result_Total_Bits_Vec_BF1_AllChannels_NonSat(index_Total_Loops_Vec) = Total_Bits_BF1_CoherentChannels_NonSat + Total_Bits_BF1_NonCoherentChannels_NonSat
Result_Total_Errors_Vec_BF1_AllChannels_NonSat(index_Total_Loops_Vec) = Total_Errors_BF1_CoherentChannels_NonSat + Total_Errors_BF1_NonCoherentChannels_NonSat
Result_BER_BF1_AllChannels_NonSat(index_Total_Loops_Vec) = (Total_Errors_BF1_CoherentChannels_NonSat + Total_Errors_BF1_NonCoherentChannels_NonSat) / (Total_Bits_BF1_CoherentChannels_NonSat + Total_Bits_BF1_NonCoherentChannels_NonSat)
Result_Channel_Gain_Init_Vec_BF1_AllChannels(index_Total_Loops_Vec) = Sum_Channel_Gain_Init_BF1_AllChannels/Sum_Total_AllChannels_BF1;
Result_Channel_Gain_BF1_Vec_BF1_AllChannels(index_Total_Loops_Vec) = Sum_Channel_Gain_BF1_BF1_AllChannels/Sum_Total_AllChannels_BF1;
Result_Avg_Noise_Power_Vec_BF1_AllChannels(index_Total_Loops_Vec) = Sum_Avg_Noise_Power_BF1_AllChannels/Sum_Total_AllChannels_BF1;
Result_Avg_Signal_Power_Vec_BF1_AllChannels(index_Total_Loops_Vec) = Sum_Avg_Signal_Power_BF1_AllChannels/Sum_Total_AllChannels_BF1;
Result_Avg_SignalToNoiseRatio_Vec_BF1_AllChannels(index_Total_Loops_Vec) = Sum_Avg_SignalToNoiseRatio_BF1_AllChannels/Sum_Total_AllChannels_BF1;

Result_Failed_Channels_Vec_BF1(index_Total_Loops_Vec) = Total_Loops - Sum_Total_AllChannels_BF1;
Result_Passed_Channels_Vec_BF1(index_Total_Loops_Vec) = Sum_Total_AllChannels_BF1;
Result_Passed_NonCoherentChannels_Vec_BF1(index_Total_Loops_Vec) = Sum_Total_NonCoherentChannels_BF1;
Result_Passed_CoherentChannels_Vec_BF1(index_Total_Loops_Vec) = Sum_Total_CoherentChannels_BF1;
Result_Failed_Channels_Init_Vec_BF1(index_Total_Loops_Vec) =  Sum_Total_FailedInitTiming_BF1;
Result_Failed_Channels_BF1_Vec_BF1(index_Total_Loops_Vec) = Sum_Total_FailedBFTiming_BF1;
Result_Failed_Channels_Init_Vec_BF1_Length(index_Total_Loops_Vec) = Sum_Total_FailedInitTiming_BF1_Length;
Result_Failed_Channels_BF1_Vec_BF1_Length(index_Total_Loops_Vec) = Sum_Total_FailedBFTiming_BF1_Length;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% COMPUTE STATISTICS FOR BEAMFORMING BF2 SCHEME
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% For coherent channels
Result_Total_Bits_Vec_BF2_CoherentChannels(index_Total_Loops_Vec) = Total_Bits_BF2_CoherentChannels
Result_Total_Errors_Vec_BF2_CoherentChannels(index_Total_Loops_Vec) = Total_Errors_BF2_CoherentChannels 
Result_BER_BF2_CoherentChannels(index_Total_Loops_Vec) = Total_Errors_BF2_CoherentChannels / Total_Bits_BF2_CoherentChannels
Result_Total_Bits_Vec_BF2_CoherentChannels_NonSat(index_Total_Loops_Vec) = Total_Bits_BF2_CoherentChannels_NonSat
Result_Total_Errors_Vec_BF2_CoherentChannels_NonSat(index_Total_Loops_Vec) = Total_Errors_BF2_CoherentChannels_NonSat 
Result_BER_BF2_CoherentChannels_NonSat(index_Total_Loops_Vec) = Total_Errors_BF2_CoherentChannels_NonSat / Total_Bits_BF2_CoherentChannels_NonSat
Result_Channel_Gain_Init_Vec_BF2_CoherentChannels(index_Total_Loops_Vec) = Sum_Channel_Gain_Init_BF2_CoherentChannels/Sum_Total_CoherentChannels_BF2;
Result_Channel_Gain_BF2_Vec_BF2_CoherentChannels(index_Total_Loops_Vec) = Sum_Channel_Gain_BF2_BF2_CoherentChannels/Sum_Total_CoherentChannels_BF2;
Result_Avg_Noise_Power_Vec_BF2_CoherentChannels(index_Total_Loops_Vec) = Sum_Avg_Noise_Power_BF2_CoherentChannels/Sum_Total_CoherentChannels_BF2;
Result_Avg_Signal_Power_Vec_BF2_CoherentChannels(index_Total_Loops_Vec) = Sum_Avg_Signal_Power_BF2_CoherentChannels/Sum_Total_CoherentChannels_BF2;
Result_Avg_SignalToNoiseRatio_Vec_BF2_CoherentChannels(index_Total_Loops_Vec) = Sum_Avg_SignalToNoiseRatio_BF2_CoherentChannels/Sum_Total_CoherentChannels_BF2;

Result_Total_Bits_Vec_BF2_AllChannels(index_Total_Loops_Vec) = Total_Bits_BF2_CoherentChannels + Total_Bits_BF2_NonCoherentChannels
Result_Total_Errors_Vec_BF2_AllChannels(index_Total_Loops_Vec) = Total_Errors_BF2_CoherentChannels + Total_Errors_BF2_NonCoherentChannels
Result_BER_BF2_AllChannels(index_Total_Loops_Vec) = (Total_Errors_BF2_CoherentChannels + Total_Errors_BF2_NonCoherentChannels) / (Total_Bits_BF2_CoherentChannels + Total_Bits_BF2_NonCoherentChannels)
Result_Total_Bits_Vec_BF2_AllChannels_NonSat(index_Total_Loops_Vec) = Total_Bits_BF2_CoherentChannels_NonSat + Total_Bits_BF2_NonCoherentChannels_NonSat
Result_Total_Errors_Vec_BF2_AllChannels_NonSat(index_Total_Loops_Vec) = Total_Errors_BF2_CoherentChannels_NonSat + Total_Errors_BF2_NonCoherentChannels_NonSat
Result_BER_BF2_AllChannels_NonSat(index_Total_Loops_Vec) = (Total_Errors_BF2_CoherentChannels_NonSat + Total_Errors_BF2_NonCoherentChannels_NonSat) / (Total_Bits_BF2_CoherentChannels_NonSat + Total_Bits_BF2_NonCoherentChannels_NonSat)
Result_Channel_Gain_Init_Vec_BF2_AllChannels(index_Total_Loops_Vec) = Sum_Channel_Gain_Init_BF2_AllChannels/Sum_Total_AllChannels_BF2;
Result_Channel_Gain_BF2_Vec_BF2_AllChannels(index_Total_Loops_Vec) = Sum_Channel_Gain_BF2_BF2_AllChannels/Sum_Total_AllChannels_BF2;
Result_Avg_Noise_Power_Vec_BF2_AllChannels(index_Total_Loops_Vec) = Sum_Avg_Noise_Power_BF2_AllChannels/Sum_Total_AllChannels_BF2;
Result_Avg_Signal_Power_Vec_BF2_AllChannels(index_Total_Loops_Vec) = Sum_Avg_Signal_Power_BF2_AllChannels/Sum_Total_AllChannels_BF2;
Result_Avg_SignalToNoiseRatio_Vec_BF2_AllChannels(index_Total_Loops_Vec) = Sum_Avg_SignalToNoiseRatio_BF2_AllChannels/Sum_Total_AllChannels_BF2;

Result_Failed_Channels_Vec_BF2(index_Total_Loops_Vec) = Total_Loops - Sum_Total_AllChannels_BF2;
Result_Passed_Channels_Vec_BF2(index_Total_Loops_Vec) = Sum_Total_AllChannels_BF2;
Result_Passed_NonCoherentChannels_Vec_BF2(index_Total_Loops_Vec) = Sum_Total_NonCoherentChannels_BF2;
Result_Passed_CoherentChannels_Vec_BF2(index_Total_Loops_Vec) = Sum_Total_CoherentChannels_BF2;
Result_Failed_Channels_Init_Vec_BF2(index_Total_Loops_Vec) =  Sum_Total_FailedInitTiming_BF2;
Result_Failed_Channels_BF2_Vec_BF2(index_Total_Loops_Vec) = Sum_Total_FailedBFTiming_BF2;
Result_Failed_Channels_Init_Vec_BF2_Length(index_Total_Loops_Vec) = Sum_Total_FailedInitTiming_BF2_Length;
Result_Failed_Channels_BF2_Vec_BF2_Length(index_Total_Loops_Vec) = Sum_Total_FailedBFTiming_BF2_Length;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% COMPUTE STATISTICS FOR BEAMFORMING BF3 SCHEME
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % For coherent channels
% % Result_Total_Bits_Vec_BF3_CoherentChannels(index_Total_Loops_Vec) = Total_Bits_BF3_CoherentChannels
% % Result_Total_Errors_Vec_BF3_CoherentChannels(index_Total_Loops_Vec) = Total_Errors_BF3_CoherentChannels 
% % Result_BER_BF3_CoherentChannels(index_Total_Loops_Vec) = Total_Errors_BF3_CoherentChannels / Total_Bits_BF3_CoherentChannels
% % Result_Total_Bits_Vec_BF3_CoherentChannels_NonSat(index_Total_Loops_Vec) = Total_Bits_BF3_CoherentChannels_NonSat
% % Result_Total_Errors_Vec_BF3_CoherentChannels_NonSat(index_Total_Loops_Vec) = Total_Errors_BF3_CoherentChannels_NonSat 
% % Result_BER_BF3_CoherentChannels_NonSat(index_Total_Loops_Vec) = Total_Errors_BF3_CoherentChannels_NonSat / Total_Bits_BF3_CoherentChannels_NonSat
% % Result_Channel_Gain_Init_Vec_BF3_CoherentChannels(index_Total_Loops_Vec) = Sum_Channel_Gain_Init_BF3_CoherentChannels/Sum_Total_CoherentChannels_BF3;
% % Result_Channel_Gain_BF3_Vec_BF3_CoherentChannels(index_Total_Loops_Vec) = Sum_Channel_Gain_BF3_BF3_CoherentChannels/Sum_Total_CoherentChannels_BF3;
% % Result_Avg_Noise_Power_Vec_BF3_CoherentChannels(index_Total_Loops_Vec) = Sum_Avg_Noise_Power_BF3_CoherentChannels/Sum_Total_CoherentChannels_BF3;
% % Result_Avg_Signal_Power_Vec_BF3_CoherentChannels(index_Total_Loops_Vec) = Sum_Avg_Signal_Power_BF3_CoherentChannels/Sum_Total_CoherentChannels_BF3;
% % Result_Avg_SignalToNoiseRatio_Vec_BF3_CoherentChannels(index_Total_Loops_Vec) = Sum_Avg_SignalToNoiseRatio_BF3_CoherentChannels/Sum_Total_CoherentChannels_BF3;

Result_Total_Bits_Vec_BF3_AllChannels(index_Total_Loops_Vec) = Total_Bits_BF3_CoherentChannels + Total_Bits_BF3_NonCoherentChannels
Result_Total_Errors_Vec_BF3_AllChannels(index_Total_Loops_Vec) = Total_Errors_BF3_CoherentChannels + Total_Errors_BF3_NonCoherentChannels
Result_BER_BF3_AllChannels(index_Total_Loops_Vec) = (Total_Errors_BF3_CoherentChannels + Total_Errors_BF3_NonCoherentChannels) / (Total_Bits_BF3_CoherentChannels + Total_Bits_BF3_NonCoherentChannels)
Result_Total_Bits_Vec_BF3_AllChannels_NonSat(index_Total_Loops_Vec) = Total_Bits_BF3_CoherentChannels_NonSat + Total_Bits_BF3_NonCoherentChannels_NonSat
Result_Total_Errors_Vec_BF3_AllChannels_NonSat(index_Total_Loops_Vec) = Total_Errors_BF3_CoherentChannels_NonSat + Total_Errors_BF3_NonCoherentChannels_NonSat
Result_BER_BF3_AllChannels_NonSat(index_Total_Loops_Vec) = (Total_Errors_BF3_CoherentChannels_NonSat + Total_Errors_BF3_NonCoherentChannels_NonSat) / (Total_Bits_BF3_CoherentChannels_NonSat + Total_Bits_BF3_NonCoherentChannels_NonSat)
Result_Channel_Gain_Init_Vec_BF3_AllChannels(index_Total_Loops_Vec) = Sum_Channel_Gain_Init_BF3_AllChannels/Sum_Total_AllChannels_BF3;
Result_Channel_Gain_BF3_Vec_BF3_AllChannels(index_Total_Loops_Vec) = Sum_Channel_Gain_BF3_BF3_AllChannels/Sum_Total_AllChannels_BF3;
Result_Avg_Noise_Power_Vec_BF3_AllChannels(index_Total_Loops_Vec) = Sum_Avg_Noise_Power_BF3_AllChannels/Sum_Total_AllChannels_BF3;
Result_Avg_Signal_Power_Vec_BF3_AllChannels(index_Total_Loops_Vec) = Sum_Avg_Signal_Power_BF3_AllChannels/Sum_Total_AllChannels_BF3;
Result_Avg_SignalToNoiseRatio_Vec_BF3_AllChannels(index_Total_Loops_Vec) = Sum_Avg_SignalToNoiseRatio_BF3_AllChannels/Sum_Total_AllChannels_BF3;

Result_Failed_Channels_Vec_BF3(index_Total_Loops_Vec) = Total_Loops - Sum_Total_AllChannels_BF3;
Result_Passed_Channels_Vec_BF3(index_Total_Loops_Vec) = Sum_Total_AllChannels_BF3;
% % Result_Passed_NonCoherentChannels_Vec_BF3(index_Total_Loops_Vec) = Sum_Total_NonCoherentChannels_BF3;
% % Result_Passed_CoherentChannels_Vec_BF3(index_Total_Loops_Vec) = Sum_Total_CoherentChannels_BF3;
Result_Failed_Channels_Init_Vec_BF3(index_Total_Loops_Vec) =  Sum_Total_FailedInitTiming_BF3;
Result_Failed_Channels_BF3_Vec_BF3(index_Total_Loops_Vec) = Sum_Total_FailedBFTiming_BF3;
Result_Failed_Channels_Init_Vec_BF3_Length(index_Total_Loops_Vec) = Sum_Total_FailedInitTiming_BF3_Length;
Result_Failed_Channels_BF3_Vec_BF3_Length(index_Total_Loops_Vec) = Sum_Total_FailedBFTiming_BF3_Length;

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute statistics for Alamouti
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Result_Total_Bits_Vec_Alm(index_Total_Loops_Vec) = Total_Bits_Alm
Result_Total_Errors_Vec_Alm(index_Total_Loops_Vec) = Total_Errors_Alm
Result_BER_Alm(index_Total_Loops_Vec) = Total_Errors_Alm / Total_Bits_Alm
Result_Total_Bits_Vec_Alm_NonSat(index_Total_Loops_Vec) = Total_Bits_Alm_NonSat
Result_Total_Errors_Vec_Alm_NonSat(index_Total_Loops_Vec) = Total_Errors_Alm_NonSat
Result_BER_Alm_NonSat(index_Total_Loops_Vec) = Total_Errors_Alm_NonSat / Total_Bits_Alm_NonSat
Result_Channel_Gain_Alm_Vec(index_Total_Loops_Vec) = Sum_Channel_Gain_Alm/Sum_Total_Channels_Alm;
Result_Avg_Noise_Power_Vec_Alm(index_Total_Loops_Vec) = Sum_Avg_Noise_Power_Alm/Sum_Total_Channels_Alm;
Result_Avg_Signal_Power_Vec_Alm(index_Total_Loops_Vec) = Sum_Avg_Signal_Power_Alm/Sum_Total_Channels_Alm;
Result_Avg_SignalToNoiseRatio_Vec_Alm(index_Total_Loops_Vec) = Sum_Avg_SignalToNoiseRatio_Alm/Sum_Total_Channels_Alm;
Result_Failed_Channels_Vec_Alm(index_Total_Loops_Vec) = Total_Loops - Sum_Total_Channels_Alm;
Result_Passed_Channels_Vec_Alm(index_Total_Loops_Vec) = Sum_Total_Channels_Alm;
Result_Failed_Channels_Vec_Alm_Length(index_Total_Loops_Vec) = Sum_Total_FailedAlmTiming_Length;

end
warning(swarning);

Result_Total_Channels = Total_Loops_Vec

%% WRITE RESULTS FOR BF1 IN COMMAND WINDOW
Result_Total_Bits_Vec_BF1_CoherentChannels
Result_Total_Errors_Vec_BF1_CoherentChannels
Result_BER_BF1_CoherentChannels
Result_Total_Bits_Vec_BF1_CoherentChannels_NonSat
Result_Total_Errors_Vec_BF1_CoherentChannels_NonSat
Result_BER_BF1_CoherentChannels_NonSat
% Result_Channel_Gain_Init_Vec_BF1_CoherentChannels
% Result_Channel_Gain_BF1_Vec_BF1_CoherentChannels
Result_Avg_Noise_Power_Vec_BF1_CoherentChannels
% Result_Avg_Signal_Power_Vec_BF1_CoherentChannels
% Result_Avg_SignalToNoiseRatio_Vec_BF1_CoherentChannels

Result_Total_Bits_Vec_BF1_AllChannels
Result_Total_Errors_Vec_BF1_AllChannels
Result_BER_BF1_AllChannels
Result_Total_Bits_Vec_BF1_AllChannels_NonSat
Result_Total_Errors_Vec_BF1_AllChannels_NonSat
Result_BER_BF1_AllChannels_NonSat
% Result_Channel_Gain_Init_Vec_BF1_AllChannels
% Result_Channel_Gain_BF1_Vec_BF1_AllChannels
Result_Avg_Noise_Power_Vec_BF1_AllChannels
% Result_Avg_Signal_Power_Vec_BF1_AllChannels
% Result_Avg_SignalToNoiseRatio_Vec_BF1_AllChannels

Result_Failed_Channels_Vec_BF1
Result_Passed_Channels_Vec_BF1
Result_Passed_NonCoherentChannels_Vec_BF1
Result_Passed_CoherentChannels_Vec_BF1
Result_Failed_Channels_Init_Vec_BF1
Result_Failed_Channels_BF1_Vec_BF1
Result_Failed_Channels_Init_Vec_BF1_Length
Result_Failed_Channels_BF1_Vec_BF1_Length


%% WRITE RESULTS FOR BF2 IN COMMAND WINDOW
Result_Total_Bits_Vec_BF2_CoherentChannels
Result_Total_Errors_Vec_BF2_CoherentChannels
Result_BER_BF2_CoherentChannels
Result_Total_Bits_Vec_BF2_CoherentChannels_NonSat
Result_Total_Errors_Vec_BF2_CoherentChannels_NonSat
Result_BER_BF2_CoherentChannels_NonSat
% Result_Channel_Gain_Init_Vec_BF2_CoherentChannels
% Result_Channel_Gain_BF2_Vec_BF2_CoherentChannels
Result_Avg_Noise_Power_Vec_BF2_CoherentChannels
% Result_Avg_Signal_Power_Vec_BF2_CoherentChannels
% Result_Avg_SignalToNoiseRatio_Vec_BF2_CoherentChannels

Result_Total_Bits_Vec_BF2_AllChannels
Result_Total_Errors_Vec_BF2_AllChannels
Result_BER_BF2_AllChannels
Result_Total_Bits_Vec_BF2_AllChannels_NonSat
Result_Total_Errors_Vec_BF2_AllChannels_NonSat
Result_BER_BF2_AllChannels_NonSat
% Result_Channel_Gain_Init_Vec_BF2_AllChannels
% Result_Channel_Gain_BF2_Vec_BF2_AllChannels
Result_Avg_Noise_Power_Vec_BF2_AllChannels
% Result_Avg_Signal_Power_Vec_BF2_AllChannels
% Result_Avg_SignalToNoiseRatio_Vec_BF2_AllChannels

Result_Failed_Channels_Vec_BF2
Result_Passed_Channels_Vec_BF2
Result_Passed_NonCoherentChannels_Vec_BF2
Result_Passed_CoherentChannels_Vec_BF2
Result_Failed_Channels_Init_Vec_BF2
Result_Failed_Channels_BF2_Vec_BF2
Result_Failed_Channels_Init_Vec_BF2_Length
Result_Failed_Channels_BF2_Vec_BF2_Length

%% WRITE RESULTS FOR BF3 IN COMMAND WINDOW
% % Result_Total_Bits_Vec_BF3_CoherentChannels
% % Result_Total_Errors_Vec_BF3_CoherentChannels
% % Result_BER_BF3_CoherentChannels
% % Result_Total_Bits_Vec_BF3_CoherentChannels_NonSat
% % Result_Total_Errors_Vec_BF3_CoherentChannels_NonSat
% % Result_BER_BF3_CoherentChannels_NonSat
% % % Result_Channel_Gain_Init_Vec_BF3_CoherentChannels
% % % Result_Channel_Gain_BF3_Vec_BF3_CoherentChannels
% % Result_Avg_Noise_Power_Vec_BF3_CoherentChannels
% % % Result_Avg_Signal_Power_Vec_BF3_CoherentChannels
% % % Result_Avg_SignalToNoiseRatio_Vec_BF3_CoherentChannels

Result_Total_Bits_Vec_BF3_AllChannels
Result_Total_Errors_Vec_BF3_AllChannels
Result_BER_BF3_AllChannels
Result_Total_Bits_Vec_BF3_AllChannels_NonSat
Result_Total_Errors_Vec_BF3_AllChannels_NonSat
Result_BER_BF3_AllChannels_NonSat
% Result_Channel_Gain_Init_Vec_BF3_AllChannels
% Result_Channel_Gain_BF3_Vec_BF3_AllChannels
Result_Avg_Noise_Power_Vec_BF3_AllChannels
% Result_Avg_Signal_Power_Vec_BF3_AllChannels
% Result_Avg_SignalToNoiseRatio_Vec_BF3_AllChannels

Result_Failed_Channels_Vec_BF3
Result_Passed_Channels_Vec_BF3
% Result_Passed_NonCoherentChannels_Vec_BF3
% Result_Passed_CoherentChannels_Vec_BF3
Result_Failed_Channels_Init_Vec_BF3
Result_Failed_Channels_BF3_Vec_BF3
Result_Failed_Channels_Init_Vec_BF3_Length
Result_Failed_Channels_BF3_Vec_BF3_Length


%%
Result_Total_Bits_Vec_Alm
Result_Total_Errors_Vec_Alm
Result_BER_Alm
Result_Total_Bits_Vec_Alm_NonSat
Result_Total_Errors_Vec_Alm_NonSat
Result_BER_Alm_NonSat
% Result_Channel_Gain_Alm_Vec
Result_Avg_Noise_Power_Vec_Alm
% Result_Avg_Signal_Power_Vec_Alm
% Result_Avg_SignalToNoiseRatio_Vec_Alm
Result_Failed_Channels_Vec_Alm
Result_Passed_Channels_Vec_Alm
Result_Failed_Channels_Vec_Alm_Length

if(0 == channel_select)
    if (1 == noise_select)
%     Result_EbNodB = EbNodB
    Result_EsNodB = EsNodB
    end
end


if(1 == channel_select)
    Result_Node1_Radio2_TxGain_BB = Node1_Radio2_TxGain_BB 
    Result_Node1_Radio2_TxGain_RF = Node1_Radio2_TxGain_RF 
    Result_Node1_Radio3_TxGain_BB = Node1_Radio3_TxGain_BB 
    Result_Node1_Radio3_TxGain_RF = Node1_Radio3_TxGain_RF 
%     AGC_Th_read = warplab_readAGCThresholds(udp_node2, READ_AGC_THRESHOLDS);
    % Close sockets
    if (0 == channel_emulator_remote_select)
        pnet('closeall') % Use this one when channel emulator is not being used
    else
        % Close as below when channel emulator is being used
        pnet(udp_Sync,'close');
        pnet(udp_node1,'close');
        pnet(udp_node2,'close');
      
        if(1==AzimuthSpirent_select)
            pnet(emulatorHandle, 'printf', '00 Exit\r');
            data='';
            while (strcmp(data,''))
        
                data=pnet(emulatorHandle,'read');
                pause(1)
            end
        end
        pnet(emulatorHandle,'close');
    end
end
