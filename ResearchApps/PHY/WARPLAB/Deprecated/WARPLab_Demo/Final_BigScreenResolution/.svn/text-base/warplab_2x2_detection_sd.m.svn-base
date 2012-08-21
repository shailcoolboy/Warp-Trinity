% Aron Yu
% WARP 2x2 MIMO Detection (Sphere Decoding)
%
% Implementation of the Sphere Decoding Detection Method

clear all;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Transmitting and Receiving Data using Warplab (2x2 MIMO configuration)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Using version 10 bitstream, clock shared
% Transmitter -> Bitstream 0
% Receiver -> Bitstream 1

% 0. Initializaton and definition of parameters
% 1. Generate a vector of samples to transmit and send the samples to the 
% Warp board (Sample Frequency is 40MHz)
% 2. Prepare boards for transmission and reception and send trigger to 
% start transmission and reception (trigger is the SYNC packet)
% 3. Read the received samples from the Warp board
% 4. Reset and disable the boards
% 5. Computation and results

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0. Initializaton and definition of parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load some global definitions (packet types, etc.)
warplab_defines_AGC

% Create Socket handles and intialize nodes
[socketHandles, packetNum] = warplab_initialize;

% Separate the socket handles for easier access
% The first socket handle is always the magic SYNC
% The rest can be arranged in any combination of Tx and Rx
udp_Sync = socketHandles(1);
udp_Tx = socketHandles(2);
udp_RxA = socketHandles(3);

% Define the warplab options (parameters)
CaptOffset = 1000; % Number of noise samples per Rx capture; in [0:2^14]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Inputs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Basic Setup
Num_Tx = 2;
Num_Rx = 2;
% Channel estimation
Num_ChanEst = 30;
Num_Samps_PerAntPerChanEst = 97;
% Detection
Mod_Order = 64; % Modulation order
Num_Pha = 3;
Num_Data = 10; % Number of data to be sent for detection
% Channel
CarrierChannel = 8; % Channel in the 2.4 GHz band. In [1:14]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Decide the maximum power according to the modulation order
if Mod_Order == 4
    Max_Power = sqrt(2);
elseif Mod_Order == 16
    Max_Power = sqrt(18);
elseif Mod_Order == 64
    Max_Power = sqrt(98);
end

% Create the sample data
Detect_Sample  = (1/Max_Power)*qammod(floor(rand(Num_Tx,Num_Data)*Mod_Order),Mod_Order,0,'gray');

% Length of transmission; in [0:2^14-CaptOffset-672]
% % Need to add the detection part to it
TxLength = CaptOffset+672+(Num_ChanEst*Num_Samps_PerAntPerChanEst*Num_Tx)+(Num_Data*(Num_Pha*32+1))+100;

Node1_Radio1_TxGain_BB = 3;  % Tx Baseband Gain. In [0:3]
Node1_Radio1_TxGain_RF = 40; % Tx RF Gain. In [0:63]
Node1_Radio2_TxGain_BB = 3;  % Tx Baseband Gain. In [0:3]
Node1_Radio2_TxGain_RF = 40; % Tx RF Gain. In [0:63]
Node1_Radio3_TxGain_BB = 3;  % Tx Baseband Gain. In [0:3]
Node1_Radio3_TxGain_RF = 40; % Tx RF Gain. In [0:63]
Node1_Radio4_TxGain_BB = 3;  % Tx Baseband Gain. In [0:3]
Node1_Radio4_TxGain_RF = 40; % Tx RF Gain. In [0:63]
Node2_TargetdBmAGC = -6;     % AGC's target dBm
Node2_NoiseEstdBmAGC = -95;  % AGC's Noise Estimate in dBm

% The new format of the option vector
warplab_writeRegister(udp_RxA,CAPT_OFFSET,CaptOffset);
warplab_writeRegister(udp_Tx,TX_LENGTH,TxLength);

% The CarrierChannel parameter must be downloaded to all nodes
warplab_setRadioAGCParameter(udp_Tx,CARRIER_CHANNEL,CarrierChannel);
warplab_setRadioAGCParameter(udp_RxA,CARRIER_CHANNEL,CarrierChannel);

% Node 1 will be set as the transmitter so download Tx gains to node 1
warplab_setRadioAGCParameter(udp_Tx,RADIO1_TXGAINS,(Node1_Radio1_TxGain_RF + Node1_Radio1_TxGain_BB*2^16));
warplab_setRadioAGCParameter(udp_Tx,RADIO2_TXGAINS,(Node1_Radio2_TxGain_RF + Node1_Radio2_TxGain_BB*2^16));
warplab_setRadioAGCParameter(udp_Tx,RADIO3_TXGAINS,(Node1_Radio3_TxGain_RF + Node1_Radio3_TxGain_BB*2^16));
warplab_setRadioAGCParameter(udp_Tx,RADIO4_TXGAINS,(Node1_Radio4_TxGain_RF + Node1_Radio4_TxGain_BB*2^16));

% Download AGC parameters to node 2
warplab_setRadioAGCParameter(udp_RxA,SET_AGC_TARGET_dBm,Node2_TargetdBmAGC);
warplab_setRadioAGCParameter(udp_RxA,SET_AGC_NOISEEST_dBm,Node2_NoiseEstdBmAGC);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Generate a vector of samples to transmit and send the samples to the 
% Warp board (Sample Frequency is 40MHz)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Prepare some data to be transmitted

% Time vector
t = 0:(1/40e6):(TxLength-CaptOffset-672)/40e6 - 1/40e6;

% Create vector useful for easy generation of cdata for antennas 2,3
pilot_tone = exp(t(1:Num_Samps_PerAntPerChanEst)*i*2*pi*1.25e6);
zs = zeros(1,Num_Samps_PerAntPerChanEst);

% Create a signal to transmit from radio 2
TxData_2 = [pilot_tone, zs];
TxData_2 = repmat(TxData_2,1,Num_ChanEst);

% Create a signal to transmit from radio 3
TxData_3 = [zs, pilot_tone]; 
TxData_3 = repmat(TxData_3,1,Num_ChanEst);

% Signal must be a row vector. The signal can be real or complex, the only
% constraint is that the amplitude of the real part must be in [-1,1] and
% the amplitude of the imaginary part must be in [-1:1]

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Detection Data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Multiplying the detection sample with the same frequency as the pilot
for d=1:Num_Data
    set = (d-1)*(Num_Pha*32+1);
    Detect_Mod(1,set+1:set+Num_Pha*32+1) = Detect_Sample(1,d)*exp(t(1:Num_Pha*32+1)*i*2*pi*1.25e6);
    Detect_Mod(2,set+1:set+Num_Pha*32+1) = Detect_Sample(2,d)*exp(t(1:Num_Pha*32+1)*i*2*pi*1.25e6);
end

% Attaching the detection symbols to the data
TxData_2 = [TxData_2 Detect_Mod(1,:)];
TxData_3 = [TxData_3 Detect_Mod(2,:)];

%%%%%%%%%%%% Append long training symbols and guard interval %%%%%%%%%%%%%%
% Append guard interval
TxData_2 = [zeros(1,32) TxData_2]; % Used to prevent ISI due to multipath
TxData_3 = [zeros(1,32) TxData_3]; % Used to prevent ISI due to multipath

% Call WARPLab function that generates long training symbols
[LongTrainingSyms_up2,LongSymbol_time_up2,LongSymbol_time,LongSymbol_freq] = warplab_generateLongTrainSyms;
% Append long training symbols and save 
TxData_2 = [LongTrainingSyms_up2 TxData_2];
TxData_3 = [LongTrainingSyms_up2 TxData_3];

%%%%%%%%%%%%%%%%%%%%%%%% Preamble for a 1.25MHz tone %%%%%%%%%%%%%%%%%%%%%%
shortSymbol_freq = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1-i 0 0 0 0 0 0 0 1-i 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0].';

% Take IFFT of preamble and create short symbols as per 802.11 standard
% % Something that I don't understand
shortSymbol_time = ifft(fftshift(shortSymbol_freq));
shortSymbol_time = shortSymbol_time(1:16).';
shortsyms_10 = repmat(shortSymbol_time,1,10);
preamble_I = real(shortsyms_10);
preamble_Q = imag(shortsyms_10);

% Upsample by 2 so the standard preamble occupies a bandwith of 10MHz if unmodified
[preamble_I_up2] = interp(preamble_I, 2);  % (2.85/(10*0.0313))*interp(preamble_I, 2);
[preamble_Q_up2] = interp(preamble_Q, 2);  % (2.85/(10*0.0313))*interp(preamble_Q, 2);
[preamble_I_up2] = (1/0.0314)*preamble_I_up2;  % (2.85/(10*0.0313))*interp(preamble_I, 2);
[preamble_Q_up2] = (1/0.0314)*preamble_Q_up2;  % (2.85/(10*0.0313))*interp(preamble_Q, 2);

% Other scaling option
%scale = 1 / max( [ max(preamble_I_up2) , max(preamble_Q_up2) ] );
%[preamble_I_up2] = scale*preamble_I_up2;%(2.85/(10*0.0313))*interp(preamble_I, 2);
%[preamble_Q_up2] = scale*preamble_Q_up2;%(2.85/(10*0.0313))*interp(preamble_Q, 2);

% Append the preamble to the data to be transmitted
TxData_2 = [preamble_I_up2 + sqrt(-1)*preamble_Q_up2, TxData_2];
TxData_3 = [preamble_I_up2 + sqrt(-1)*preamble_Q_up2, TxData_3];

% Download the samples to be transmitted
warplab_writeSMWO(udp_Tx, RADIO2_TXDATA, TxData_2); % Download samples to Radio 2 Tx buffer
warplab_writeSMWO(udp_Tx, RADIO3_TXDATA, TxData_3); % Download samples to Radio 3 Tx buffer


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Prepare boards for transmission and reception and send trigger to 
% start transmission and reception (trigger is the SYNC packet)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enable transmitter radio path in transmitter node (enable radio 2 and radio 3 in transmitter node as transmitters)
warplab_sendCmd(udp_Tx, [RADIO2_TXEN, RADIO3_TXEN], packetNum);

% Enable transmission of samples stored in radio 2 & 3 Tx buffers
warplab_sendCmd(udp_Tx, [RADIO2TXBUFF_TXEN, RADIO3TXBUFF_TXEN], packetNum);

% Enable receiver radio path in receiver node (enable radio 2 and radio 3 in receiver node as receivers)
warplab_sendCmd(udp_RxA, [RADIO2_RXEN, RADIO3_RXEN], packetNum);

% Enable Radio's receive buffer for storage of samples
warplab_sendCmd(udp_RxA, [RADIO2RXBUFF_RXEN, RADIO3RXBUFF_RXEN], packetNum);

% Prime transmitter state machine in transmitter node. Transmitter will be waiting for the SYNC packet. 
% Transmission will be triggered when the transmitter node receives the SYNC packet.
warplab_sendCmd(udp_Tx, TX_START, packetNum);

% Prime receiver state machine in receiver node. Receiver will be waiting for the SYNC packet. 
% Reception will be triggered when the receiver node receives the SYNC packet.
warplab_sendCmd(udp_RxA, RX_START, packetNum);

% Send the SYNC packet
warplab_sendSync(udp_Sync);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Read the received samples from the Warp board
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read back the received samples from radio 2 and 3
[RawRxData_2_wDCO] = warplab_readSMRO(udp_RxA, RADIO2_RXDATA, TxLength);
[RawRxData_3_wDCO] = warplab_readSMRO(udp_RxA, RADIO3_RXDATA, TxLength);

% Process the received samples to obtain meaningful data
[RxData_2_wDCO,RxOTR_2] = warplab_processRawRxData(RawRxData_2_wDCO);
[RxData_3_wDCO,RxOTR_3] = warplab_processRawRxData(RawRxData_3_wDCO);

% Read the address where the AGC fixes the gains
[AGC_Set_Address] = warplab_readRegister(udp_RxA,AGC_DONE_ADDR);
% Read the gains that were set by the AGC
[GainsRF_Init,GainsBB_Init] = warplab_readAGCGains(udp_RxA);

% Remove DC Offset (DCO) from RxData
[RxData_2] = warplab_correctDCO(RxData_2_wDCO,AGC_Set_Address);
[RxData_3] = warplab_correctDCO(RxData_3_wDCO,AGC_Set_Address);

% Find address where payolad starts and address where the first long symbol in the long training symbols starts
[FirstLongSymbol_Start_2] = warplab_findLongTrainingStart(RxData_2,LongSymbol_time_up2,AGC_Set_Address);
[FirstLongSymbol_Start_3] = warplab_findLongTrainingStart(RxData_3,LongSymbol_time_up2,AGC_Set_Address);

Payload_Start_2 = FirstLongSymbol_Start_2 + 320 + 32; % Long training is 320 samples and there are 32 samples of guard interval before pilots
Payload_Start_3 = FirstLongSymbol_Start_3 + 320 + 32; % Long training is 320 samples and there are 32 samples of guard interval before pilots


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Reset and disable the boards
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reset the AGC
warplab_sendCmd(udp_RxA, AGC_RESET, packetNum);

% Reset the receiver
warplab_sendCmd(udp_RxA, RX_DONEREADING, packetNum);

% Disable the receiver radio 2 & 3
warplab_sendCmd(udp_RxA, [RADIO2_RXDIS, RADIO3_RXDIS], packetNum);

% Disable transmission of samples stored in radio 2 & 3 Tx buffer
warplab_sendCmd(udp_Tx, [RADIO2TXBUFF_TXDIS, RADIO3TXBUFF_TXDIS], packetNum);

% Disable the transmitter radio 2 & 3
warplab_sendCmd(udp_Tx, [RADIO2_TXDIS, RADIO3_TXDIS], packetNum);

% Enable radios' receive buffer for storage of samples
warplab_sendCmd(udp_RxA, [RADIO2RXBUFF_RXDIS, RADIO3RXBUFF_RXDIS], packetNum);

% Close sockets
pnet('closeall');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. Computation and Results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute Channel Estimate %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define parameters useful for computation of channel estimate
lenTx2 = length(TxData_2)-673-size(Detect_Mod,2);
lenTx3 = length(TxData_3)-673-size(Detect_Mod,2);
lenRx2 = length(RxData_2)-Payload_Start_2;
lenRx3 = length(RxData_3)-Payload_Start_3;
slice_len = min([lenTx2,lenTx3,lenRx2,lenRx3]); % Length of Channel Estimation
TxData_2_Slice = TxData_2(673:673+slice_len);
TxData_3_Slice = TxData_3(673:673+slice_len);
RxData_2_Slice = RxData_2(Payload_Start_2:Payload_Start_2+slice_len);
RxData_3_Slice = RxData_3(Payload_Start_3:Payload_Start_3+slice_len);

% Modifying code to make Tx = Rx to check for validity of channel estimation
%RxData_2_Slice = TxData_2_Slice;
%RxData_3_Slice = TxData_3_Slice;

% Put data together for simplicity (each antenna in each row)
TxData = [TxData_2_Slice; TxData_3_Slice];
RxData = [RxData_2_Slice; RxData_3_Slice];
TxData_Mod = zeros(length(Num_Tx)*length(Num_Rx),(Num_Samps_PerAntPerChanEst-10)*Num_ChanEst);
RxData_Mod = zeros(Num_Rx^2,(Num_Samps_PerAntPerChanEst-10)*Num_ChanEst);

%%% Transmiters %%%
for a=1:Num_Tx % Repeat for each antenna
    for b=1:Num_ChanEst % Repeat for total number of segments
        row = (a-1)*Num_Samps_PerAntPerChanEst;
        column = (b-1)*Num_Samps_PerAntPerChanEst*Num_Tx;
        temp = (b-1)*(Num_Samps_PerAntPerChanEst-10);
        % Modify the numeric values to determine the range of pilot take into account
        TxData_Mod(a,temp+1:temp+87) = TxData(a,row+column+6:row+column+92);
    end
end

% Repeating the TxData_Mod to fit the dimention of RxData_Mod
for c=1:Num_Rx
    TxData_Mod((c-1)*Num_Tx+1:(c-1)*Num_Tx+Num_Tx,:) = TxData_Mod(1:Num_Tx,:);
end    

%%% Receivers %%%
for x=1:Num_Rx % Repeat for each antenna
    for y=1:Num_Rx % Repeat for the different types of data
        for z=1:Num_ChanEst % Repeat for total number of segments
            row = (y-1)*Num_Samps_PerAntPerChanEst;
            column = (z-1)*Num_Samps_PerAntPerChanEst*Num_Tx;
            temp = (z-1)*(Num_Samps_PerAntPerChanEst-10);
            RxData_Mod((x-1)*Num_Rx+y,temp+1:temp+87) = RxData(x,row+column+6:row+column+92);
        end
    end
end

% % Currently, I'm only taking the middle 87 samples of each pilot for calculation

%%% Calculation %%%
% Compute the magnitude and the phase of the data
% NOTE: TxData_Mag is all 1 so Chan_Est_Mag == RxData_Mag
TxData_Mag = abs(TxData_Mod);
TxData_Pha = angle(TxData_Mod);
RxData_Mag = abs(RxData_Mod);
RxData_Pha = angle(RxData_Mod);

% Channel Estimation calculaion
Chan_Est_Mag = RxData_Mag./TxData_Mag;
Chan_Est_Pha = RxData_Pha-TxData_Pha;
Chan_Est = Chan_Est_Mag.*exp(i*Chan_Est_Pha);

% Preallocation
Chan_Est_H = zeros(Num_Rx,Num_Tx,size(TxData_Mod,2));
Chan_Est_Cond = zeros(1,size(TxData_Mod,2));
Chan_Est_Det = zeros(1,size(TxData_Mod,2));

% % Can be easily changed to fit other setups; too much work to make it general
for k=1:size(TxData_Mod,2)
    Chan_Est_H(:,:,k) = [Chan_Est(1,k) Chan_Est(2,k);Chan_Est(3,k) Chan_Est(4,k)]; % H-matrix
    Chan_Est_Cond(k) = cond(Chan_Est_H(:,:,k));
    Chan_Est_Det(k) = det(Chan_Est_H(:,:,k));
end

% Results of the Channel Estimation
Chan_Est_H = mean(Chan_Est_H,3)
Determinant = mean(abs(Chan_Est_Det))
Condition_Number = mean(Chan_Est_Cond)

%%% Plots %%%
% Determinant and Condition Number
figure
range = [0 length(TxData_Mod)]; % To plot the average value
subplot(2,1,1)
plot(abs(Chan_Est_Det)); hold on
plot(range,[Determinant Determinant],'g--')
title('Determinant')
xlabel('n (samples)')
subplot(2,1,2)
plot(Chan_Est_Cond); hold on
plot(range,[Condition_Number Condition_Number],'g--')
title('Condition Number')
xlabel('n (samples)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute Detection (Sphere Decoding) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extract out the received detection samples
RxData_2_Detect = RxData_2(Payload_Start_2+slice_len+1:Payload_Start_2+slice_len+size(Detect_Mod,2));
RxData_3_Detect = RxData_3(Payload_Start_3+slice_len+1:Payload_Start_3+slice_len+size(Detect_Mod,2));

% QR decomposition on the Channel Matrix
[Q,R] = qr(Chan_Est_H);

% Preallocation
RxData_Detect = [RxData_2_Detect; RxData_3_Detect];
RxData_Detect_Mod = zeros(Num_Tx,Num_Data);
Receive_Sample = zeros(Num_Tx,Num_Data);

% Reduce the samples back to the original number of samples (forming the y part of the formula)
% Took off the erratic values on either ends
for q=1:Num_Data
    temp = (q-1)*(Num_Pha*32+1);
    RxData_Detect_Mod(1,q) = mean(RxData_Detect(1,temp+11:temp+Num_Pha*32-9)./exp(t(11:Num_Pha*32-9)*i*2*pi*1.25e6));
    RxData_Detect_Mod(2,q) = mean(RxData_Detect(2,temp+11:temp+Num_Pha*32-9)./exp(t(11:Num_Pha*32-9)*i*2*pi*1.25e6)); 
end

% Performing y'=Q'*y
yprime = Q'*(Max_Power*RxData_Detect_Mod(:,1:Num_Data)); 

% Implementing Sphere Decoding
for num=1:Num_Data
    
    %%% Going through the tree once to set the initial radius R %%%
    R_Min = 0; % Initialize the minimum radius
    Child_Node = [0:Mod_Order-1;0:Mod_Order-1]; % Initialize the child nodes
    
    for depth=Num_Tx:-1:1 % Accounts for the depth of the tree (number of layers)
        storage = abs(yprime(depth,num)-R(depth,:)*qammod(Child_Node(:,1:Mod_Order),Mod_Order,0,'gray')).^2; 
        [value,loc] = min(storage);
        R_Min = R_Min + value; % Updating the radius
        Child_Node(depth,:) = loc-1; % Updating the nodes
    end
    
    %%% Going through the tree again to find the answer %%%
    Depth_Count = Num_Tx+1;   % Counter for how far down the tree the function is currently; -1 for every down, +1 for every up
    Radius_Track = zeros(1,Num_Tx);   % Counter vector for the minimum radius at each level
    Node_Track = [0:Mod_Order-1;0:Mod_Order-1];   % Keeping track of nodes
    
    [Current_Rad,Current_Loc] = tree_traverse_sd (yprime(:,num),R_Min,Child_Node(:,1),R,Mod_Order,Depth_Count,Radius_Track,Node_Track);
    
    Receive_Sample(:,num) = (1/Max_Power)*qammod(Current_Loc,Mod_Order,0,'gray');
end

% Display results
Detect_Sample - Receive_Sample
Num_Error = length(find(Detect_Sample - Receive_Sample))

% Plot used for debugging
figure
plot(Detect_Sample,'bo','MarkerSize',14)
hold on
plot(Receive_Sample,'rx','MarkerSize',14)

