%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Using Warplab to Transmit Beamformed Almouti Encoded symbols over a 
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

% Define Wireless Channel Parameters
channel_select = 1;
% If channel_select = 0 the signal is transmitted over a channel generated
% in MATLAB
% If channel_select = 1 the signal is transmitted over a real wireless
% channel using the WARPLab framework to transmit and receive using WARP
% boards
noise_select = 1;
% The noise select signal is relevant only when channel_select = 0.
% If noise_select = 0 (and channel_select=0) then no noise is added to
% the signal
% If noise_select = 1 (and channel_select=1) then AWGN noise is added to
% the signal just before the receiver combinning stage (MRC stage for 
% Beamforming and Alamouti combining for Alamouti)

% Define MIMO parameters 
Num_Tx = 2;
Num_Rx = 1;
load('Codebooks\Grassmannian\codebook_2_4vec_Grassm','codebook_2_4vec_Grassm_original');
Codebook_Original = codebook_2_4vec_Grassm_original; % Codebook is only used for Beamforming (not for Alamouti)

% Define Pilot parameters 
n_ChanEst = 1; % Number of times the pilot sequence for channel estimation will be transmitted
nsamp_PerAntPerChanEst = 128; % Number of samples per antenna per channel estimate
nsamp_Pilots = nsamp_PerAntPerChanEst*n_ChanEst*Num_Tx;
nsamp_TGP = 672+nsamp_Pilots; % Number of samples for training, guard 
                              % interval and pilots
                              % Short training, long training and guard
                              % interval correspond to first 672 samples

% Define modulation parameters 
M = 16; % Size of signal constellation
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

if(1 == channel_select)
    % Define WARPLab parameters
    % Load some global definitions (packet types, etc.)
    warplab_defines_AGC
    % Create Socket handles and intialize nodes
    [socketHandles, packetNum] = warplab_initialize;
    %Separate the socket handles for easier access
    % The first socket handle is always the magic SYNC
    % The rest can be arranged in any combination of Tx and Rx
    udp_Sync = socketHandles(1);
    udp_node1 = socketHandles(2);
    udp_node2 = socketHandles(3);
    % Define the warplab options (parameters)
    CaptOffset = 0; %Number of noise samples per Rx capture; in [0:2^14]
    TxLength = 2^14-1; %Total of samples to transmit; in [0:2^14-CaptOffset-1]
    CarrierChannel = 4; % Channel in the 2.4 GHz band. In [1:14]
%     Node1_Radio1_TxGain_BB = 3; % Tx Baseband Gain. In [0:3]
%     Node1_Radio1_TxGain_RF = 40; % Tx RF Gain. In [0:63]
%     Node1_Radio2_TxGain_BB = 3; % Tx Baseband Gain. In [0:3]
%     Node1_Radio2_TxGain_RF = 40; % Tx RF Gain. In [0:63]
%     Node1_Radio3_TxGain_BB = 3; % Tx Baseband Gain. In [0:3]
%     Node1_Radio3_TxGain_RF = 40; % Tx RF Gain. In [0:63]
%     Node1_Radio4_TxGain_BB = 3; % Tx Baseband Gain. In [0:3]
%     Node1_Radio4_TxGain_RF = 40; % Tx RF Gain. In [0:63]
    Node2_TargetdBmAGC = -6; % AGC's target dBm
    Node2_NoiseEstdBmAGC = -95; % AGC's Noise Estimate in dBm
    % Note: For this experiment node 1 will be set as the transmitter and node 
    % 2 will be set as the receiver (this is done later in the code), hence, 
    % there is no need to define receive gains for node 1, there is no
    % need to define transmitter gains for node 2, and there is no need to
    % define AGC parameters for node 1

    % Download the WARPLab parameters to the WARP nodes. 
    % The nodes store the CaptOffset, TxLength, and TxMode parameters in 
    % registers defined in the WARPLab sysgen model. The nodes set radio 
    % related parameters CarrierChannel, TxGains, and RxGains, using the 
    % radio controller functions. The nodes store the TargetdBmAGC and
    % NoiseEstdBmAGC parameters in registers in the AGC sysgen model.
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
    %warplab_writeRegister(udp_node1,TX_MODE,TxMode);
    % The CarrierChannel parameter must be downloaded to all nodes  
    warplab_setRadioAGCParameter(udp_node1,CARRIER_CHANNEL,CarrierChannel);
    warplab_setRadioAGCParameter(udp_node2,CARRIER_CHANNEL,CarrierChannel);
    % Node 1 will be set as the transmitter so download Tx gains to node 1.
%     warplab_setRadioAGCParameter(udp_node1,RADIO1_TXGAINS,(Node1_Radio1_TxGain_RF + Node1_Radio1_TxGain_BB*2^16));
%     warplab_setRadioAGCParameter(udp_node1,RADIO2_TXGAINS,(Node1_Radio2_TxGain_RF + Node1_Radio2_TxGain_BB*2^16));
%     warplab_setRadioAGCParameter(udp_node1,RADIO3_TXGAINS,(Node1_Radio3_TxGain_RF + Node1_Radio3_TxGain_BB*2^16));
%     warplab_setRadioAGCParameter(udp_node1,RADIO4_TXGAINS,(Node1_Radio4_TxGain_RF + Node1_Radio4_TxGain_BB*2^16));
    % Download AGC parameters to node 2
    warplab_setRadioAGCParameter(udp_node2,SET_AGC_TARGET_dBm,Node2_TargetdBmAGC);
    warplab_setRadioAGCParameter(udp_node2,SET_AGC_NOISEEST_dBm,Node2_NoiseEstdBmAGC);
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Generate long training symbols
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Call WARPLab function that generates long training symbols
[LongTrainingSyms_up2,LongSymbol_time_up2,LongSymbol_time,LongSymbol_freq] = warplab_generateLongTrainSyms;

% Added division by sqrt(2) for unit power Tx:
[LongTrainingSyms_up2] = [LongTrainingSyms_up2]/sqrt(Num_Tx);
[LongSymbol_time_up2] = [LongSymbol_time_up2]/sqrt(Num_Tx);
[LongSymbol_time] = [LongSymbol_time]/sqrt(Num_Tx);
[LongSymbol_freq] = [LongSymbol_freq]/sqrt(Num_Tx);

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

ShortTrainingSyms_up2 = (preamble_I_up2 + sqrt(-1)*preamble_Q_up2)/sqrt(Num_Tx);
% Added division by sqrt(2) for unit power Tx
% ShortTrainingSyms_up2 = (preamble_I_up2 + sqrt(-1)*preamble_Q_up2);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. Concatenate short training symbols, long training symbols, 
% guard interval, and pilots
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TrainGuardPilots_1 = [ShortTrainingSyms_up2, LongTrainingSyms_up2, zeros(1,32), Pilots_1];
TrainGuardPilots_2 = [ShortTrainingSyms_up2, LongTrainingSyms_up2, zeros(1,32), Pilots_2];
TrainGuardPilots_3 = [ShortTrainingSyms_up2, LongTrainingSyms_up2, zeros(1,32), Pilots_3];
% TrainGuardPilots_4 = [ShortTrainingSyms_up2, LongTrainingSyms_up2, zeros(1,32), Pilots_4];


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
%         EbNodB = [-4,-2,0,2,4,6,8]; % EbNo values. The constellation will be scaled
%         EbNodB = [4,8,12,16,20,24,28,32,34]; % EbNo values. The
%         constellation will be scaled
%           EbNodB = [4,8,12,16]; % EbNo values. The constellation will be scaled
%         EbNodB = [4,6,8]; % EbNo values. The constellation will be scaled
         EbNodB=[8];
        % such that the Energy per symbol is equal to 1: Es=1. Eb = Es/k.
%         Total_Bits_perEbNodB = [1e6,1e6,1e6,2e6,2e6,2e6,3e6];
%         Total_Bits_perEbNodB = [5e5,5e5,1e6,1e6,2e6,2e6,3e6];
%         Total_Bits_perEbNodB = [1e6,1e6,2e6,2e6,3e6,3e6,4e6,4e6,6e6];
%         Total_Bits_perEbNodB = [1e6,1e6,1e6,1e6];
%         Total_Bits_perEbNodB = [220,220,220,220,220,220,220];
%         Total_Bits_perEbNodB = [220,220,220,220];
        Total_Bits_perEbNodB = 1000;
        Total_Loops_Vec = ceil(Total_Bits_perEbNodB/nbits);
    end
end


% Define parameters used when channel is real wireless channel.
if(1 == channel_select)
%     Node1_Radio2_TxGain_BB = [3, 3, 3, 3] ; % Tx Baseband Gain. In [0:3]
%     Node1_Radio2_TxGain_RF = [40, 44, 48, 52]; % Tx RF Gain. In [0:63]
%     Node1_Radio3_TxGain_BB = [3, 0, 0, 0]; % Tx Baseband Gain. In [0:3]
%     Node1_Radio3_TxGain_RF = [40, 44, 48, 52]; % Tx RF Gain. In [0:63]
%     Node1_Radio2_TxGain_BB = [1,1,1]; % Tx Baseband Gain. In [0:3]
%     Node1_Radio2_TxGain_RF = [10,12,14]; % Tx RF Gain. In [0:63]
%     Node1_Radio3_TxGain_BB = [1,1,1]; % Tx Baseband Gain. In [0:3]
%     Node1_Radio3_TxGain_RF = [10,12,14]; % Tx RF Gain. In [0:63]
    Node1_Radio2_TxGain_BB = [3,1,1,1]; % Tx Baseband Gain. In [0:3]
    Node1_Radio2_TxGain_RF = [8,10,12,14]; % Tx RF Gain. In [0:63]
    Node1_Radio3_TxGain_BB = [3,1,1,1]; % Tx Baseband Gain. In [0:3]
    Node1_Radio3_TxGain_RF = [8,10,12,14]; % Tx RF Gain. In [0:63]
%     Node1_Radio2_TxGain_BB = [1,1,1,1]; % Tx Baseband Gain. In [0:3]
%     Node1_Radio2_TxGain_RF = [8,10,12,14]; % Tx RF Gain. In [0:63]
%     Node1_Radio3_TxGain_BB = [1,1,1,1]; % Tx Baseband Gain. In [0:3]
%     Node1_Radio3_TxGain_RF = [8,10,12,14]; % Tx RF Gain. In [0:63]
%     Total_Bits_perTxGain = [1e6,1e6,1e6,2e6,2e6];
%     Total_Bits_perTxGain = [50000,50000,50000,100000];
%     Total_Bits_perTxGain = [2,2,2,2];
%     Total_Bits_perTxGain = [100000,100000,100000,100000,100000];
%     Total_Bits_perTxGain = [2e6,2.5e6,3.5e6,4e6,5e6,6e6];
%     Total_Bits_perTxGain = [5e5,5e5,1e6];
%     Total_Bits_perTxGain = [10000,10000];
%     Total_Bits_perTxGain = [2e5,2e5,2e5,2e5];
%     Total_Bits_perTxGain = [2000,2000,2000,2000,2000,2000,2000,2000];
%     Total_Bits_perTxGain = [1,1,1];
    Total_Bits_perTxGain = [1000];
    Total_Loops_Vec = ceil(Total_Bits_perTxGain/nbits);
end

% Compute length of Total_Loops_Vec
len_Total_Loops_Vec = length(Total_Loops_Vec);

% Choose between dpsk or qam
dpskqam_select = 1; % dpskqam_select = 0: use dpsk, dpskqam_select = 1: use qam 

swarning=warning('off','MATLAB:divideByZero');

% Variables to store BF statistics
Result_Total_Bits_Vec_BF_CoherentChannels = 0;
Result_Total_Errors_Vec_BF_CoherentChannels = 0;
Result_BER_BF_CoherentChannels = 0;
Result_Channel_Gain_Init_Vec_BF_CoherentChannels = 0;
Result_Channel_Gain_BF_Vec_BF_CoherentChannels = 0;
Result_Avg_Noise_Power_Vec_BF_CoherentChannels = 0;
Result_Avg_Signal_Power_Vec_BF_CoherentChannels = 0;
Result_Avg_SignalToNoiseRatio_Vec_BF_CoherentChannels = 0;
Result_RF_RxGain_Mat_BF_AllChannels = uint16(zeros(max(Total_Loops_Vec),len_Total_Loops_Vec));
Result_BB_RxGain_Mat_BF_AllChannels = uint16(zeros(max(Total_Loops_Vec),len_Total_Loops_Vec));

Result_Total_Bits_Vec_BF_AllChannels = 0;
Result_Total_Errors_Vec_BF_AllChannels = 0;
Result_BER_BF_AllChannels = 0;
Result_Channel_Gain_Init_Vec_BF_AllChannels = 0;
Result_Channel_Gain_BF_Vec_BF_AllChannels = 0;
Result_Avg_Noise_Power_Vec_BF_AllChannels = 0;
Result_Avg_Signal_Power_Vec_BF_AllChannels = 0;
Result_Avg_SignalToNoiseRatio_Vec_BF_AllChannels = 0;
Result_RF_RxGain_Mat_BF_CoherentChannels = uint16(zeros(max(Total_Loops_Vec),len_Total_Loops_Vec));
Result_BB_RxGain_Mat_BF_CoherentChannels = uint16(zeros(max(Total_Loops_Vec),len_Total_Loops_Vec));

Result_Failed_Channels_Vec_BF = 0;
Result_Passed_Channels_Vec_BF = 0;
Result_Passed_NonCoherentChannels_Vec_BF = 0;
Result_Passed_CoherentChannels_Vec_BF = 0;

Result_Total_Bits_Vec_Alm = 0;
Result_Total_Errors_Vec_Alm = 0;
Result_BER_Alm = 0;
Result_Channel_Gain_Alm_Vec = 0;
Result_Avg_Noise_Power_Vec_Alm = 0;
Result_Avg_Signal_Power_Vec_Alm = 0;
Result_Avg_SignalToNoiseRatio_Vec_Alm = 0;
Result_Failed_Channels_Vec_Alm = 0;
Result_Passed_Channels_Vec_Alm = 0;

% Variables to store Alamouti statistics
Result_Total_Bits_Vec_Alm = 0;
Result_Total_Errors_Vec_Alm = 0;
Result_BER_Alm = 0;
Result_Channel_Gain_Alm_Vec = 0;
Result_Avg_Noise_Power_Vec_Alm = 0;
Result_Avg_Signal_Power_Vec_Alm = 0;
Result_Avg_SignalToNoiseRatio_Vec_Alm = 0;
Result_Failed_Channels_Vec_Alm = 0;
Result_Passed_Channels_Vec_Alm = 0;
RF_RxGain_Mat_Alm = uint16(zeros(max(Total_Loops_Vec),len_Total_Loops_Vec));
BB_RxGain_Mat_Alm = uint16(zeros(max(Total_Loops_Vec),len_Total_Loops_Vec));
% Channel_Gain_Init_Vec = 0;
% Channel_Gain_BF_Vec = 0;

for index_Total_Loops_Vec = 1:1:len_Total_Loops_Vec
    
Total_Loops = Total_Loops_Vec(index_Total_Loops_Vec);

% Variables to store Beamforming statistics
Total_Bits_BF_CoherentChannels = 0;
Total_Errors_BF_CoherentChannels = 0;
Sum_Channel_Gain_Init_BF_CoherentChannels = 0;
Sum_Channel_Gain_BF_BF_CoherentChannels = 0;
Sum_Avg_Noise_Power_BF_CoherentChannels = 0;
Sum_Avg_Signal_Power_BF_CoherentChannels = 0;
Sum_Avg_SignalToNoiseRatio_BF_CoherentChannels = 0;
Sum_Total_CoherentChannels_BF = 0;

Total_Bits_BF_NonCoherentChannels = 0;
Total_Errors_BF_NonCoherentChannels = 0;
Sum_Channel_Gain_Init_BF_AllChannels = 0;
Sum_Channel_Gain_BF_BF_AllChannels = 0;
Sum_Avg_Noise_Power_BF_AllChannels = 0;
Sum_Avg_Signal_Power_BF_AllChannels = 0;
Sum_Avg_SignalToNoiseRatio_BF_AllChannels = 0;
Sum_Total_NonCoherentChannels_BF = 0;

Sum_Total_AllChannels_BF = 0;


% Variables to store Alamouti statistics
Total_Bits_Alm = 0;
Total_Errors_Alm = 0;
Sum_Avg_Noise_Power_Alm = 0;
Sum_Avg_Signal_Power_Alm = 0;
Sum_Avg_SignalToNoiseRatio_Alm = 0;
Sum_Channel_Gain_Alm = 0;
Sum_Total_Channels_Alm = 0; 


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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Transmit and receive symbols using transmit beamforming and receive
% combining 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Tx2Rx1_BFvsAlm_BFProc_v02

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute statistics for beamforming
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (Num_Rx == (ValidStart_1+ValidStart_2+ValidStart_3+ValidStart_4))
    
% Channel Gain
Sum_Channel_Gain_Init_BF_AllChannels = Sum_Channel_Gain_Init_BF_AllChannels + Channel_Gain_Init_BF;
Sum_Channel_Gain_BF_BF_AllChannels = Sum_Channel_Gain_BF_BF_AllChannels + Channel_Gain_BF;

% Noise and SNR 
% Symbols_Sent = Constellation(zsym+1)*scaleConstellation; % Modulated
% symbols were scaled to set Es=1
Noise_Power_BF_AllChannels = abs(ytx_mod_norm(1:nsym_Payload).'-yrx_bb_mf_ds_mrc_norm).^2;
Signal_Power_BF_AllChannels = abs(ytx_mod_norm(1:nsym_Payload).').^2;
SignalToNoiseRatio_BF_AllChannels = Signal_Power_BF_AllChannels./Noise_Power_BF_AllChannels; % We set Es = 1;

Avg_Noise_Power_BF_AllChannels = mean(Noise_Power_BF_AllChannels);
Avg_Signal_Power_BF_AllChannels = mean(Signal_Power_BF_AllChannels);
Avg_SignalToNoiseRatio_BF_AllChannels = mean(SignalToNoiseRatio_BF_AllChannels);

Sum_Avg_Noise_Power_BF_AllChannels = Sum_Avg_Noise_Power_BF_AllChannels + Avg_Noise_Power_BF_AllChannels;
Sum_Avg_Signal_Power_BF_AllChannels = Sum_Avg_Signal_Power_BF_AllChannels + Avg_Signal_Power_BF_AllChannels;
Sum_Avg_SignalToNoiseRatio_BF_AllChannels = Sum_Avg_SignalToNoiseRatio_BF_AllChannels + Avg_SignalToNoiseRatio_BF_AllChannels;
Sum_Total_AllChannels_BF = Sum_Total_AllChannels_BF + 1;    

if(1 == channel_select)
    [GainsRF_Init,GainsBB_Init] = warplab_readAGCGains(udp_node2);
    Result_RF_RxGain_Mat_BF_AllChannels(loopscount,index_Total_Loops_Vec) = uint16(GainsRF_Init(2));
    Result_BB_RxGain_Mat_BF_AllChannels(loopscount,index_Total_Loops_Vec) = uint16(GainsBB_Init(2));
end


% Check Beamforming coherence time
if(Index_Init ~= Index_check)
    % Errors and total bits for noncoherent channels
    Sum_Total_NonCoherentChannels_BF = Sum_Total_NonCoherentChannels_BF + 1;
    Total_Bits_BF_NonCoherentChannels = Total_Bits_BF_NonCoherentChannels + number_of_bits;
    Total_Errors_BF_NonCoherentChannels = Total_Errors_BF_NonCoherentChannels + number_of_errors;
else
% Statistics for coherent channels

% Errors and total bits for coherent channels
Total_Bits_BF_CoherentChannels = Total_Bits_BF_CoherentChannels + number_of_bits;
Total_Errors_BF_CoherentChannels = Total_Errors_BF_CoherentChannels + number_of_errors;

% Channel Gain
Sum_Channel_Gain_Init_BF_CoherentChannels = Sum_Channel_Gain_Init_BF_CoherentChannels + Channel_Gain_Init_BF;
Sum_Channel_Gain_BF_BF_CoherentChannels = Sum_Channel_Gain_BF_BF_CoherentChannels + Channel_Gain_BF;

% Noise and SNR 
% Symbols_Sent = Constellation(zsym+1)*scaleConstellation; % Modulated
% symbols were scaled to set Es=1
Noise_Power_BF_CoherentChannels = abs(ytx_mod_norm(1:nsym_Payload).'-yrx_bb_mf_ds_mrc_norm).^2;
Signal_Power_BF_CoherentChannels = abs(ytx_mod_norm(1:nsym_Payload).').^2;
SignalToNoiseRatio_BF_CoherentChannels = Signal_Power_BF_CoherentChannels./Noise_Power_BF_CoherentChannels; % We set Es = 1;

Avg_Noise_Power_BF_CoherentChannels = mean(Noise_Power_BF_CoherentChannels);
Avg_Signal_Power_BF_CoherentChannels = mean(Signal_Power_BF_CoherentChannels);
Avg_SignalToNoiseRatio_BF_CoherentChannels = mean(SignalToNoiseRatio_BF_CoherentChannels);

Sum_Avg_Noise_Power_BF_CoherentChannels = Sum_Avg_Noise_Power_BF_CoherentChannels + Avg_Noise_Power_BF_CoherentChannels;
Sum_Avg_Signal_Power_BF_CoherentChannels = Sum_Avg_Signal_Power_BF_CoherentChannels + Avg_Signal_Power_BF_CoherentChannels;
Sum_Avg_SignalToNoiseRatio_BF_CoherentChannels = Sum_Avg_SignalToNoiseRatio_BF_CoherentChannels + Avg_SignalToNoiseRatio_BF_CoherentChannels;
Sum_Total_CoherentChannels_BF = Sum_Total_CoherentChannels_BF + 1;

if(1 == channel_select)
    [GainsRF_Init,GainsBB_Init] = warplab_readAGCGains(udp_node2);
    Result_RF_RxGain_Mat_BF_CoherentChannels(loopscount,index_Total_Loops_Vec) = uint16(GainsRF_Init(2));
    Result_BB_RxGain_Mat_BF_CoherentChannels(loopscount,index_Total_Loops_Vec) = uint16(GainsBB_Init(2));
end
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Transmit and receive Alamouit encoded symbols
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Tx2Rx1_BFvsAlm_AlmProc_v02

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute statistics for Alamouti
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (Num_Rx == (ValidStart_1+ValidStart_2+ValidStart_3+ValidStart_4))
Total_Bits_Alm = Total_Bits_Alm + number_of_bits;
Total_Errors_Alm = Total_Errors_Alm + number_of_errors;
% Channel Gain
Sum_Channel_Gain_Alm = Sum_Channel_Gain_Alm + Channel_Gain_Alm;
% Noise and SNR 
% Symbols_Sent = Constellation(zsym+1)*scaleConstellation; % Modulated symbols were scaled to set Es=1
Noise_Power_Alm = abs(ytx_mod_norm(1:nsym_Payload).'-yrx_bb_mf_ds_alm_norm).^2;
Signal_Power_Alm = abs(ytx_mod_norm(1:nsym_Payload).').^2;
SignalToNoiseRatio_Alm = Signal_Power_Alm./Noise_Power_Alm; % We set Es = 1;
Avg_Noise_Power_Alm = mean(Noise_Power_Alm);
Avg_Signal_Power_Alm = mean(Signal_Power_Alm);
Avg_SignalToNoiseRatio_Alm = mean(SignalToNoiseRatio_Alm);
Sum_Avg_Noise_Power_Alm = Sum_Avg_Noise_Power_Alm + Avg_Noise_Power_Alm;
Sum_Avg_Signal_Power_Alm = Sum_Avg_Signal_Power_Alm + Avg_Signal_Power_Alm;
Sum_Avg_SignalToNoiseRatio_Alm = Sum_Avg_SignalToNoiseRatio_Alm + Avg_SignalToNoiseRatio_Alm;
Sum_Total_Channels_Alm = Sum_Total_Channels_Alm + 1;
if(1 == channel_select)
    [GainsRF_Init,GainsBB_Init] = warplab_readAGCGains(udp_node2);
    Result_RF_RxGain_Mat_Alm(loopscount,index_Total_Loops_Vec) = uint16(GainsRF_Init(2));
    Result_BB_RxGain_Mat_Alm(loopscount,index_Total_Loops_Vec) = uint16(GainsBB_Init(2));
end
end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute statistics for beamforming
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% For coherent channels
Result_Total_Bits_Vec_BF_CoherentChannels(index_Total_Loops_Vec) = Total_Bits_BF_CoherentChannels
Result_Total_Errors_Vec_BF_CoherentChannels(index_Total_Loops_Vec) = Total_Errors_BF_CoherentChannels 
Result_BER_BF_CoherentChannels(index_Total_Loops_Vec) = Total_Errors_BF_CoherentChannels / Total_Bits_BF_CoherentChannels
Result_Channel_Gain_Init_Vec_BF_CoherentChannels(index_Total_Loops_Vec) = Sum_Channel_Gain_Init_BF_CoherentChannels/Sum_Total_CoherentChannels_BF;
Result_Channel_Gain_BF_Vec_BF_CoherentChannels(index_Total_Loops_Vec) = Sum_Channel_Gain_BF_BF_CoherentChannels/Sum_Total_CoherentChannels_BF;
Result_Avg_Noise_Power_Vec_BF_CoherentChannels(index_Total_Loops_Vec) = Sum_Avg_Noise_Power_BF_CoherentChannels/Sum_Total_CoherentChannels_BF;
Result_Avg_Signal_Power_Vec_BF_CoherentChannels(index_Total_Loops_Vec) = Sum_Avg_Signal_Power_BF_CoherentChannels/Sum_Total_CoherentChannels_BF;
Result_Avg_SignalToNoiseRatio_Vec_BF_CoherentChannels(index_Total_Loops_Vec) = Sum_Avg_SignalToNoiseRatio_BF_CoherentChannels/Sum_Total_CoherentChannels_BF;

Result_Total_Bits_Vec_BF_AllChannels(index_Total_Loops_Vec) = Total_Bits_BF_CoherentChannels + Total_Bits_BF_NonCoherentChannels
Result_Total_Errors_Vec_BF_AllChannels(index_Total_Loops_Vec) = Total_Errors_BF_CoherentChannels + Total_Errors_BF_NonCoherentChannels
Result_BER_BF_AllChannels(index_Total_Loops_Vec) = (Total_Errors_BF_CoherentChannels + Total_Errors_BF_NonCoherentChannels) / (Total_Bits_BF_CoherentChannels + Total_Bits_BF_NonCoherentChannels)
Result_Channel_Gain_Init_Vec_BF_AllChannels(index_Total_Loops_Vec) = Sum_Channel_Gain_Init_BF_AllChannels/Sum_Total_AllChannels_BF;
Result_Channel_Gain_BF_Vec_BF_AllChannels(index_Total_Loops_Vec) = Sum_Channel_Gain_BF_BF_AllChannels/Sum_Total_AllChannels_BF;
Result_Avg_Noise_Power_Vec_BF_AllChannels(index_Total_Loops_Vec) = Sum_Avg_Noise_Power_BF_AllChannels/Sum_Total_AllChannels_BF;
Result_Avg_Signal_Power_Vec_BF_AllChannels(index_Total_Loops_Vec) = Sum_Avg_Signal_Power_BF_AllChannels/Sum_Total_AllChannels_BF;
Result_Avg_SignalToNoiseRatio_Vec_BF_AllChannels(index_Total_Loops_Vec) = Sum_Avg_SignalToNoiseRatio_BF_AllChannels/Sum_Total_AllChannels_BF;

Result_Failed_Channels_Vec_BF(index_Total_Loops_Vec) = Total_Loops - Sum_Total_AllChannels_BF;
Result_Passed_Channels_Vec_BF(index_Total_Loops_Vec) = Sum_Total_AllChannels_BF;
Result_Passed_NonCoherentChannels_Vec_BF(index_Total_Loops_Vec) = Sum_Total_NonCoherentChannels_BF;
Result_Passed_CoherentChannels_Vec_BF(index_Total_Loops_Vec) = Sum_Total_CoherentChannels_BF;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute statistics for Alamouti
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Result_Total_Bits_Vec_Alm(index_Total_Loops_Vec) = Total_Bits_Alm
Result_Total_Errors_Vec_Alm(index_Total_Loops_Vec) = Total_Errors_Alm
Result_BER_Alm(index_Total_Loops_Vec) = Total_Errors_Alm / Total_Bits_Alm
Result_Channel_Gain_Alm_Vec(index_Total_Loops_Vec) = Sum_Channel_Gain_Alm/Sum_Total_Channels_Alm;
Result_Avg_Noise_Power_Vec_Alm(index_Total_Loops_Vec) = Sum_Avg_Noise_Power_Alm/Sum_Total_Channels_Alm;
Result_Avg_Signal_Power_Vec_Alm(index_Total_Loops_Vec) = Sum_Avg_Signal_Power_Alm/Sum_Total_Channels_Alm;
Result_Avg_SignalToNoiseRatio_Vec_Alm(index_Total_Loops_Vec) = Sum_Avg_SignalToNoiseRatio_Alm/Sum_Total_Channels_Alm;
Result_Failed_Channels_Vec_Alm(index_Total_Loops_Vec) = Total_Loops - Sum_Total_Channels_Alm;
Result_Passed_Channels_Vec_Alm(index_Total_Loops_Vec) = Sum_Total_Channels_Alm;

end
warning(swarning);

Result_Total_Channels = Total_Loops_Vec

Result_Total_Bits_Vec_BF_CoherentChannels
Result_Total_Errors_Vec_BF_CoherentChannels
Result_BER_BF_CoherentChannels
Result_Channel_Gain_Init_Vec_BF_CoherentChannels
Result_Channel_Gain_BF_Vec_BF_CoherentChannels
Result_Avg_Noise_Power_Vec_BF_CoherentChannels
Result_Avg_Signal_Power_Vec_BF_CoherentChannels
Result_Avg_SignalToNoiseRatio_Vec_BF_CoherentChannels

Result_Total_Bits_Vec_BF_AllChannels
Result_Total_Errors_Vec_BF_AllChannels
Result_BER_BF_AllChannels
Result_Channel_Gain_Init_Vec_BF_AllChannels
Result_Channel_Gain_BF_Vec_BF_AllChannels
Result_Avg_Noise_Power_Vec_BF_AllChannels
Result_Avg_Signal_Power_Vec_BF_AllChannels
Result_Avg_SignalToNoiseRatio_Vec_BF_AllChannels

Result_Failed_Channels_Vec_BF
Result_Passed_Channels_Vec_BF
Result_Passed_NonCoherentChannels_Vec_BF
Result_Passed_CoherentChannels_Vec_BF

Result_Total_Bits_Vec_Alm
Result_Total_Errors_Vec_Alm
Result_BER_Alm
Result_Channel_Gain_Alm_Vec
Result_Avg_Noise_Power_Vec_Alm
Result_Avg_Signal_Power_Vec_Alm
Result_Avg_SignalToNoiseRatio_Vec_Alm
Result_Failed_Channels_Vec_Alm
Result_Passed_Channels_Vec_Alm

if(0 == channel_select)
    if (1 == noise_select)
    Result_EbNodB = EbNodB
    end
end


if(1 == channel_select)
    Result_Node1_Radio2_TxGain_BB = Node1_Radio2_TxGain_BB 
    Result_Node1_Radio2_TxGain_RF = Node1_Radio2_TxGain_RF 
    Result_Node1_Radio3_TxGain_BB = Node1_Radio3_TxGain_BB 
    Result_Node1_Radio3_TxGain_RF = Node1_Radio3_TxGain_RF 
    % Close sockets
    pnet('closeall');
end
