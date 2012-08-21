% Multiple DAS cells, each with multiple TX antennas and multiple clients
% xyzhang
% 11/28/2011 
clear all;
% check: warp_init nodeID, vltf the same?

USESIM = 1; % whether to use simulation
numTxNode = 1;
txID = 1; % currently we only allow one transmitter with ID txID
numRxNode = 1;
numTxAntenna = 2; % number of tx antennas
numRxAntenna = 2; % number of rx antennas
osamp = 8; % Oversampling rate or Number of samples per symbol, 40Mhz/osamp wide band
if USESIM osamp = 1; end
debuglog = fopen('debuglog.txt','w');


totalPrecodeRounds = 8;
rxRadioIndexShift = 1; % count the Warp rx radio from 1+rxRadioIndexShift
txRadioIndexShift = 1; % count the Warp tx radio from 1+txRadioIndexShift
numRxCapture = 1; 

TxGain_RF = 40;  % Tx RF Gain. In [0:63] 
TxGain_BB = 1; % Tx Baseband Gain. In [0:3]
RxGain_BB = 10; % Rx Baseband Gain. In [0:31]
RxGain_RF = 2;%2; % Rx RF Gain. In [1:3] 
TxMode = 1; %1 for continuous transmission
MGC_AGC_Select = 0; %0 for MGC, 1 for AGC


TxDelay = 1000;
TxLength = 2^14-TxDelay; % Length of transmission. In [0:2^14-1-TxDelay]
CarrierChannel = 13; % Channel in the 2.4 GHz band. In [1:14]; 5GHz in [15:37]
pktsize_bytes = 10; 
for subc = 1:64
    %precodeM(:,:,subc) = eye(numTxAntenna, numRxNode);
    precodeM(:,:,subc) = eye(numTxAntenna, numRxAntenna);
end

% -------- Generate 802.11 STF ---------
STF = [0 0 0 0 0 0 0 0 1+i 0 0 0 -1+i 0 0 0 -1-i 0 0 0 1-i 0 0 0 -1-i 0 0 0 1-i 0 0 0 0 0 0 0 1-i 0 0 0 -1-i 0 0 0 1-i 0 0 0 -1-i 0 0 0 -1+i 0 0 0 1+i 0 0 0 0 0 0 0].';
% Before ifft, ensure the zero-frequency on index 1; minus-frequency begins
% from half (so the samples near the half-freq should be a sequence of 0s)
STF_t = ifft(fftshift(STF));
STF_t = STF_t(1:16).';
STF_10 = repmat(STF_t,1,10);
STF_I = real(STF_10);
STF_Q = imag(STF_10);
% Upsample by osamp so the standard preamble occupies a bandwidth of 
% +-40/osamp MHz (computed for a sampling frequency of 40 MHz)
[STF_I_up2] = interp(STF_I, osamp);
[STF_Q_up2] = interp(STF_Q, osamp);
% Scale to span -1,1 range of DAC
scale_ShortSyms = max([ max(abs(STF_I_up2)), max(abs(STF_Q_up2)) ]);
[STF_I_up2] = (1/scale_ShortSyms)*STF_I_up2;
[STF_Q_up2] = (1/scale_ShortSyms)*STF_Q_up2;
STF_up2 = (STF_I_up2 + sqrt(-1)*STF_Q_up2);


% -------- Generate 802.11 LTF -----------
LTF_freq_bot = [0 0 0 0 0 0 1 1 -1 -1 1 1 -1 1 -1 1 1 1 1 1 1 -1 -1 1 1 -1 1 -1 1 1 1 1]';
LTF_freq_top = [1 -1 -1 1 1 -1 1 -1 1 -1 -1 -1 -1 -1 1 1 -1 -1 1 -1 1 -1 1 1 1 1 0 0 0 0 0]';
LTF_freq = [LTF_freq_bot ; 0 ; LTF_freq_top];
%put the zero-frequency on index 1; minus-frequency begins from half
LTF_shift = fftshift(LTF_freq);
LTF_time = ifft(LTF_shift).';
LTF_time_up2 = interp(LTF_time, osamp); % Upsample 
scale = 1/max([ max(abs(real(LTF_time_up2))), max(abs(imag(LTF_time_up2))) ]);
LTF_time_up2 = scale * LTF_time_up2; % Scale to span -1,1 range of DAC 
% Concatenate two long training symbols and add cyclic prefix
%longsyms_2_cp = [LTF_time(33:64) repmat(LTF_time,1,2)];
%longsyms_2_cp_up2 = interp(longsyms_2_cp,2); % Upsample by 2
LTF_up2 = [LTF_time_up2(32*osamp+1:64*osamp) repmat(LTF_time_up2,1,2)];

% ------ VHT-LTF: used for estimating the precoded channel -------
% --- for rx 1 ---
VLTF_freq_bot(1,:) = [0 0 0 0 0 0 1 -1 -1 1 1 1 -1 -1 -1 1 -1 1 1 -1 1 -1 1 1 1 -1 1 -1 -1 1 1 1]';
VLTF_freq_top(1,:) = [-1 -1 -1 1 -1 1 1 -1 1 -1 -1 1 -1 -1 1 1 -1 -1 1 -1 -1 -1 1 1 -1 1 0 0 0 0 0]';
VLTF_freq(1,:) = [VLTF_freq_bot(1,:) 0 VLTF_freq_top(1,:)];
%VLTF_shift(:,1) = fftshift(VLTF_freq(1,:));
%VLTF_t(:,1) = ifft(VLTF_shift(:,1));
%VLTFscale(1) = 1/max([ max(abs(real(VLTF_t(:,1)))), max(abs(imag(VLTF_t(:,1)))) ]);
%VLTF_t_up2 = interp(VLTF_t(:,1), osamp);
%VLTF_t_up2 = VLTFscale(1) * VLTF_t_up2;
%VLTF_t_up = [VLTF_t_up2((64-16)*osamp+1:64*osamp); VLTF_t_up2];

% --- for rx 2 ---
% VLTF_freq: numRxAntenna X numSubcarriers
VLTF_freq_bot(2,:) = [0 0 0 0 0 0 -1 -1 1 -1 1 1 -1 1 -1 -1 -1 1 -1 1 1 -1 1 1 1 -1 1 -1 -1 -1 1 1]';
VLTF_freq_top(2,:) = [1 -1 1 -1 -1 -1 1 1 -1 1 -1 -1 1 -1 -1 1 1 -1 1 1 -1 1 1 1 -1 -1 0 0 0 0 0]';
VLTF_freq(2,:) = [VLTF_freq_bot(2,:) 0 VLTF_freq_top(2,:)];
%VLTF_shift(:,2) = fftshift(VLTF_freq(2,:));


% -------- Generate OFDM data symbol -----------
% ******* Add pilot tone ********
%{
% Generate data bits to be transmitted
numbits = pktsize_bytes*8;
fg = fopen('inbits.dat', 'wb');
bt = [0 1 0 1 0 0 1 1];
bto = [];
for s = 1:pktsize_bytes
    bto = [bto bt];
end
fwrite(fg, bto, 'int8');
fclose(fg);
%}


%fin = fopen('inbits.dat', 'rb');
%inb = fread(fin, pktsize_bytes*8, 'int8');
fg = fopen('databits.dat', 'w');
for k = 1:48    
	%for kk = 1:2    
	if (rand < 0.5)       
		fprintf(fg, '1 1');   
	else        
		fprintf(fg, '0 0');    
	end    
	%end
	fprintf(fg, '\n');
end
fclose(fg);

inb = load('databits.dat');
pktDataLen = length(inb(:,1)); 
s = 1;
posInSymb = 0;
posOut = 0;
while s <= pktDataLen 
    posOut = posOut + 1;
    
    posInSymb = posInSymb + 1;
    if (posInSymb == 65)
        posInSymb = 1;
    end
     
    % Insert pilot at 7, 21, 43 and 57th subcarriers
    if (posInSymb == (7+1) || posInSymb == (21+1) ...
        || posInSymb == (64-21+1) || posInSymb == (64-7+1))
        for rxn = 1:numRxAntenna
            symbIn(posOut, rxn) = 1 + 0*i;
        end
        continue;
    end 
    % zero-freq in index1, minus-freq near half-sequence
    if (posInSymb==1 || (posInSymb > 27 && posInSymb < 64-26+1))
        %symbIn(posOut) = 0 + 0*i;
        for rxn = 1:numRxAntenna
            symbIn(posOut, rxn) = 0 + 0*i;
        end 
        continue;
    end 
    
    for rxn = 1:numRxNode
        if (inb(s,rxn)==0) 
        %if (inb(s,1)==0) 
            symbIn(posOut, rxn) = -1 + 0*i;
        else
            symbIn(posOut, rxn) = 1 + 0*i;
        end
    end 
     
    %symbIn(posOut) = inb(s) + 0*i;
    s = s + 1; 

    %{
    % Test: make the first symbol all 1
    if posOut < 65
        symbIn(posOut) = 1 + 0*i;
    end
    %} 
end
 

% ========== Initializaton of WARP radio parameters ========
if USESIM == 0
%Load some global definitions (packet types, etc.)
warplab_defines

% Create Socket handles and intialize nodes
%[socketHandles, packetNum] = warplab_initialize;
%[socketHandles, packetNum] = warplab_initialize(3);%test
[socketHandles, packetNum] = warplab_initialize(1+numRxNode);

% Separate the socket handles for easier access
% The first socket handle is always the magic SYNC
% The rest of the handles are the handles to the WARP nodesb
udp_Sync = socketHandles(1);
%{
ncount = 1;
for n = 1:numTxNode
    udp_txnode(n) = socketHandles(n+1);
end
for n = 1:numRxNode
    udp_rxnode(n) = socketHandles(1+numTxNode+n);
end
%}
%udp_txnode(1) = socketHandles(txID*2);
udp_txnode(1) = socketHandles(2);
%udp_txnode(2) = socketHandles(3);
for rxn = 1:numRxNode
	%udp_rxnode(rxn) = socketHandles(2+rxn);
end
udp_rxnode(1) = socketHandles(3);
%udp_rxnode(2) = socketHandles(4);


%Node2_MGC_AGC_Select = 0;   % Set MGC_AGC_Select=1 to enable Automatic Gain Control (AGC). 
                            % Set MGC_AGC_Select=0 to enable Manual Gain Control (MGC).
                            % By default, the nodes are set to MGC.  
%Node3_MGC_AGC_Select = 0;

%Node2_TargetdBmAGC = -6;     % AGC's target dBm
%Node2_NoiseEstdBmAGC = -95;  % AGC's Noise Estimate in dBm
%% Download AGC parameters to node 2
%warplab_setRadioAGCParameter(udp_node2,SET_AGC_TARGET_dBm,Node2_TargetdBmAGC);
%warplab_setRadioAGCParameter(udp_node2,SET_AGC_NOISEEST_dBm,Node2_NoiseEstdBmAGC);
%warplab_setRadioAGCParameter(udp_node2,SET_AGC_TRIG_DELAY,agc_trigger_nsamp_delay);
%DCOffset_FPGA_Enabled = 0;
%warplab_setRadioAGCParameter(udp_node2,AGC_DCO_EN,DCOffset_FPGA_Enabled);

% TxMode parameters only to the transmitter node (node 1).
for txn = 1:numTxNode
    warplab_writeRegister(udp_txnode(txn),TX_DELAY,TxDelay);
    warplab_writeRegister(udp_txnode(txn),TX_LENGTH,TxLength);
    warplab_writeRegister(udp_txnode(txn),TX_MODE,TxMode);
    warplab_setRadioParameter(udp_txnode(txn),CARRIER_CHANNEL,CarrierChannel);
for txa = 1:numTxAntenna
	txa1 = mod(txa+txRadioIndexShift-1, 4) + 1;
    % Node 1 will be set as the transmitter so download Tx gains to node 1.
    radiovar = eval(sprintf('RADIO%d_TXGAINS',txa1));
    warplab_setRadioParameter(udp_txnode(txn), radiovar,(TxGain_RF + TxGain_BB*2^16));
end
end


for rxn = 1:numRxNode
    warplab_setRadioParameter(udp_rxnode(rxn),CARRIER_CHANNEL,CarrierChannel);
    warplab_setAGCParameter(udp_rxnode(rxn), MGC_AGC_SEL, MGC_AGC_Select);
for rxa = 1:numRxAntenna
	rxa1 = mod(rxa+rxRadioIndexShift-1, 4) + 1;
    radiovar = eval(sprintf('RADIO%d_RXGAINS',rxa1));
    warplab_setRadioParameter(udp_rxnode(rxn), radiovar, (RxGain_BB + RxGain_RF*2^16)); 
end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Prepare WARP boards for transmission and reception and send trigger to
% start transmission and reception (trigger is the SYNC packet)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for txn = 1:numTxNode
for txa = 1:numTxAntenna
    %txa1 = mod(txa, 4)+txRadioIndexShift;
	txa1 = mod(txa+txRadioIndexShift-1, 4) + 1;
    radiovar = eval(sprintf('RADIO%d_TXEN', txa1));
    warplab_sendCmd(udp_txnode(txn), radiovar, packetNum);
    radiovar = eval(sprintf('RADIO%dTXBUFF_TXEN', txa1));
    warplab_sendCmd(udp_txnode(txn), radiovar, packetNum);
end
end
for rxn = 1:numRxNode
for rxa = 1:numRxAntenna
	%rxa1 = mod(rxa, 4)+rxRadioIndexShift; 
	rxa1 = mod(rxa+rxRadioIndexShift-1, 4) + 1;
    radiovar = eval(sprintf('RADIO%d_RXEN', rxa1));
    warplab_sendCmd(udp_rxnode(rxn), radiovar, packetNum);
    radiovar = eval(sprintf('RADIO%dRXBUFF_RXEN', rxa1));
    warplab_sendCmd(udp_rxnode(rxn), radiovar, packetNum);
end
end



end % end if USESIM
% ================= End initialization of WARP ===================


% ================= Apply semi-realtime precoding =====================
for numPrecodeRounds = 1:totalPrecodeRounds
% precoding
for s = 1:64 %subcarrier index 
    %if (s <= 6 || s >= 60 || s == 33) continue; end 
	% Antenna power allocation here
	ampScaler = 0;
	
    for txa = 1:numTxAntenna
    	sc = sum(abs(precodeM(txa,:,s)));
		if (sc > ampScaler) ampScaler=sc; end
	end
	%if ampScaler > 0 ampScaler = 1; end
	if ampScaler > 0 ampScaler = 1/ampScaler; end
	
    for txa = 1:numTxAntenna
        % FIXME: per antenna power constraint?
        % See calcZFRXPr.m in quickDirtSim
        VLTF_coded(s, txa) = precodeM(txa,:,s) * VLTF_freq(:,s);
		if (abs(VLTF_coded(s, txa)) > ampScaler)  ampScaler=VLTF_coded(s, txa); end
        if (isnan(VLTF_coded(s, txa))) 
            VLTF_coded(s, txa) = 0;
        end
    end 
	%VLTF_coded(s, :) = VLTF_coded(s, :) * ampScaler; 
end

maxamp=0;
for txa = 1:numTxAntenna
    vt = ifft(fftshift(VLTF_coded(:,txa)), 64);
	%vt = vt/max([max(abs(real(vt))) max(abs(imag(vt)))]);
    VLTF_t(txa, :) = [vt(64-16+1:64); vt].';
	%tmp = max([max(abs(real(vt))) max(abs(imag(vt)))]);
	tmp = max(abs(VLTF_t(txa, :)));
	if (tmp > maxamp) maxamp = tmp; end
    VLTF_t_up(txa, :) = interp(VLTF_t(txa, :), osamp);
end
VLTF_t = VLTF_t/maxamp;

% *** Zero-forcing precoding for data in each subcarrier ***
for s = 1:64 %subcarrier index
    for txa = 1:numTxAntenna
        %pilotOut(s, txa) = precodeM(txa,:,s) * symbIn(s,:).';
        pilotOut(s, txa) = precodeM(txa,:,mod(s+31,64)+1) * symbIn(s,:).';
    end 
end

% *** IFFT: generate time domain data signal 
DATAamplitudeScaler = 1;%sqrt(1/52); %sqrt(1/52);% FIXME
l1 = length(pilotOut);

for txa = 1:numTxAntenna
    outCount = 0;
    for ds = 1:64:l1
        ifftOut = ifft(pilotOut(ds:ds+63,txa), 64);

        % *** Add guard interval 
        for s = 0:(80-1)
            ind = mod(s+64-16, 64) + 1;
            outCount = outCount + 1; 
            output_t(outCount,txa) = DATAamplitudeScaler * ifftOut(ind);   
        end
    end

	%tmp = max(abs(output_t(:, txa)));
	%if (tmp > maxamp) maxamp = tmp; end
	DATA_up2(:,txa) = interp(output_t(:,txa), osamp); % Upsample 
	tmp = max(abs(DATA_up2(:, txa)));
	if (tmp > maxamp) maxamp = tmp; end
    % ******* Pulse shaping *******
    % Smooth transition between LTF and LSIG
    % FIXME
    % kkk=1;
end  % end for ds = 1:64:l1

%DATA_up2 = zeros(1,800);
for txa = 1:numTxAntenna
     DATA_up2(:,txa) = DATA_up2(:,txa) / maxamp; 
end


% ------- Concatenate all tx samples ---------
zero_vector = zeros(1, length(LTF_up2));
zero_data = zeros(1, length(DATA_up2));


%for txn = 1:numTxNode
txn = 1;
%td = [STF_up2, LTF_up2, zero_vector, zero_vector, zero_vector, DATA_up2(:,1).'];
%td = [STF_up2, LTF_up2, zero_vector, DATA_up2(:,1).'];
%td = [STF_up2, LTF_up2, zero_vector, VLTF_t_up(1,:)];
%td = [STF_up2, LTF_up2, zero_vector, VLTF_t_up(1,:), DATA_up2(:,1).'];
td = [zeros(1,length(STF_up2)), LTF_up2, zero_vector, VLTF_t_up(1,:), DATA_up2(:,1).'];
%td(1) = 0.5*td(1);
%td(length(STF_up2)) = 0.5 * td(length(STF_up2));%windowing
%td(length(STF_up2)+1) = 0.5 * td(length(STF_up2)+1);
%td(length(STF_up2+LTF_up2)) = 0.5 * td(length(STF_up2+LTF_up2));
%td = repmat(td, 1, 1); %5);  % make 5 duplicates
%%filterOrder = 256;
%%fff = fir1(filterOrder, 1/osamp);
%%td = filter(fff, 1, td);  
%ltff = LTF_freq;% * precodeM(1,:); % precoding for antenna 1
%ltft = ifft(fftshift(LTF_freq)).';
%ltft_up = interp(LTF_time, osamp); % Upsample 
%scale = 1/max([ max(abs(real(ltft_up))), max(abs(imag(ltft_up))) ]);
%ltft_up = scale * ltft_up; % Scale to span -1,1 range of DAC 
%% Concatenate two long training symbols and add cyclic prefix
%LTFup_a1 = [LTF_time_up2(32*osamp+1:64*osamp) repmat(LTF_time_up2,1,2)]; 
% 
%pktLen = length(td);
if (USESIM==0)
    TxData(:,1,txn) = [td zeros(1,max(1,TxLength-length(td)))];
else
    TxData(:,1,txn) = [zero_vector td zeros(1,max(1,TxLength-length(td)))];
end
%TxData(:,1,txn) = TxData(:,1,txn)/2;

%td = [STF_up2, zero_vector, LTF_up2, zero_vector, zero_vector, DATA_up2(:,2).'];
%td = [zeros(1,length(STF_up2)), zero_vector, LTF_up2, zero_vector, zero_vector, DATA_up2(:,2).'];
%%td = [zeros(1,length(STF_up2)), zero_vector, LTF_up2, DATA_up2(:,2).'];
%td = [zeros(1,length(STF_up2)), zero_vector, LTF_up2, VLTF_t_up(2,:)];
%td = [zeros(1,length(STF_up2)), zero_vector, LTF_up2, VLTF_t_up(2,:), DATA_up2(:,2).'];
td = [STF_up2, zero_vector, LTF_up2, VLTF_t_up(2,:), DATA_up2(:,2).'];
%td = [STF_up2, zero_vector, LTF_up2, VLTF_t_up(2,:)];
%td(1) = 0.5*td(1);
%td(length(STF_up2)) = 0.5 * td(length(STF_up2));%windowing
%td(length(STF_up2)+length(zero_vector)+1) = 0.5 * td(length(STF_up2)+length(zero_vector)+1);
%td(length(STF_up2+length(zero_vector)+LTF_up2)) = 0.5 * td(length(STF_up2+length(zero_vector)+LTF_up2));
%td = repmat(td, 1, 1); %5);  % make 5 duplicates
%td = filter(fff, 1, td);  
%ltff = LTF_freq; % precoding for antenna 1
%ltft = ifft(fftshift(LTF_freq)).';
%ltft_up = interp(LTF_time, osamp); % Upsample 
%scale = 1/max([ max(abs(real(ltft_up))), max(abs(imag(ltft_up))) ]);
%ltft_up = scale * ltft_up; % Scale to span -1,1 range of DAC  
%TxData(:,2,txn) = [td zeros(1,max(1,TxLength-length(td)))];
if (USESIM==0)
    TxData(:,2,txn) = [td zeros(1,max(1,TxLength-length(td)))];
else
    TxData(:,2,txn) = [zero_vector td zeros(1,max(1,TxLength-length(td)))];
end
%TxData(:,2,txn) = TxData(:,2,txn)/2;

 
%{
td = [STF_up2, zero_vector, zero_vector, LTF_up2, zero_vector, DATA_up2(:,3).'];
%td(1) = 0.5*td(1);
%td(length(STF_up2)) = 0.5 * td(length(STF_up2));%windowing
%td(length(STF_up2)+2*length(zero_vector)+1) = 0.5 * td(length(STF_up2)+2*length(zero_vector)+1);
%td(length(STF_up2+2*length(zero_vector)+LTF_up2)) = 0.5 * td(length(STF_up2+2*length(zero_vector)+LTF_up2));
%td = repmat(td, 1, 1); %5);  % make 5 duplicates
%td = filter(fff, 1, td);  
ltff = LTF_freq; % precoding for antenna 1
ltft = ifft(fftshift(LTF_freq)).';
ltft_up = interp(LTF_time, osamp); % Upsample 
scale = 1/max([ max(abs(real(ltft_up))), max(abs(imag(ltft_up))) ]);
ltft_up = scale * ltft_up; % Scale to span -1,1 range of DAC  
TxData(:,3,txn) = [td zeros(1,max(1,TxLength-length(td)))];

td = [STF_up2, zero_vector, zero_vector, zero_vector, LTF_up2, DATA_up2(:,4).'];
%td(1) = 0.5*td(1);
%td(length(STF_up2)) = 0.5 * td(length(STF_up2));%windowing
%td(length(STF_up2)+3*length(zero_vector)+1) = 0.5 * td(length(STF_up2)+3*length(zero_vector)+1);
%td(length(STF_up2+3*length(zero_vector)+LTF_up2)) = 0.5 * td(length(STF_up2+3*length(zero_vector)+LTF_up2)); 
%td = repmat(td, 1, 1); %5);  % make 5 duplicates
%td = filter(fff, 1, td);  
ltff = LTF_freq; % precoding for antenna 1
ltft = ifft(fftshift(LTF_freq)).';
ltft_up = interp(LTF_time, osamp); % Upsample 
scale = 1/max([ max(abs(real(ltft_up))), max(abs(imag(ltft_up))) ]);
ltft_up = scale * ltft_up; % Scale to span -1,1 range of DAC
TxData(:,4,txn) = [td zeros(1,max(1,TxLength-length(td)))];
%} 
 
%radiovar = eval(sprintf('RADIO%d_TXDATA',txa));
%warplab_writeSMWO(udp_txnode(txn), radiovar, TxData(:,txa,txn).');
%end

%{
% Test0824: multiple nodes transmitting concurrently
td = [STF_up2, LTF_up2, zero_vector, zero_vector, zero_vector, DATA_up2];
pktLen = length(td);
TxData(:,1,1) = [td zeros(1,pktLen) zeros(1,max(1,TxLength-2*pktLen))];
%TxData(:,1,2) = zeros(length(TxData(:,1,1)), 1);
TxData(:,1,2) = [zeros(1,pktLen) td zeros(1,max(1,TxLength-2*pktLen))];
%TxData(:,1,1) = zeros(length(TxData(:,1,2)), 1);
%}

if USESIM == 1
    % Signals from different antennas combine at the receive antenna 
    % Assume two receivers, each with one antenna 
    % fname = 'sim_modulated.dat';
    fname = 'sim_modulated_Rx1.dat'; 
    CH(1, :) = [0.8-0.6j 1 1+j 1-j]; 
    fo = fopen(fname, 'wb'); 
    txd1 = TxData(:,1,txID)*CH(1,1) + TxData(:,2,txID)*CH(1,2);% ...
    %        + TxData(:,3,txID)*CH(1,3) + TxData(:,4,txID)*CH(1,4);
    %fwrite(fo, [real(txd1); imag(txd1)], 'float32'); 
    % generate "standard" format for complex numbers [real imag, real imag,...]
    o1 = [];
    a = real(txd1);
    b = imag(txd1);
    for k = 1:length(txd1)
        o1 = [o1 a(k) b(k)];
    end
    %o1 = [a b];
    fwrite(fo, o1, 'float32');
    fclose(fo);
     
     
    fname = 'sim_modulated_Rx2.dat'; 
    CH(2, :) = [j 1-j 1 0.5];
    fo = fopen(fname, 'wb'); 
    txd2 = TxData(:,1,txID)*CH(2,1) + TxData(:,2,txID)*CH(2,2);% ...
    %        + TxData(:,3,txID)*CH(2,3) + TxData(:,4,txID)*CH(2,4);
    %fwrite(fo, [real(txd2); imag(txd2)], 'float32'); 
    o1 = [];
    a = real(txd2);
    b = imag(txd2);
    for k = 1:length(txd1)
        o1 = [o1 a(k) b(k)];
    end
    %o1 = [a b];
    fwrite(fo, o1, 'float32');
    fclose(fo);
    %decode_MUMIMO(Node1_Radio2_TxData.');
     
    % ============ OFDM detection, channel estimaiton and decoding ====
    for rxn = 1:numRxNode
    	multiRxDAS(rxn, txID);
        %multiRxDAS_0214_sameDataOK(rxn, txID);
		%pause;
    end
    %multiRxDAS(1, txID);
    %multiRxDAS_mAntenna(2, txID);

    % ============ Update precoding matrix ============
    maxChannelRealize = 2;
    nc = 1; % index of the measurement to be applied in calc precoding matrix
    maxRxAntenna = 1;
    maxTxAntenna = 4;
    % extract channel matrix
    for rxn = 1:numRxAntenna
        f1 = sprintf('OFDM_trace_amp_r%d_t%d.txt', rxn, txID);
        %tr = load(f1);
        tr_amp(:,:) = load(f1); %tr(1:maxChannelRealize,:);
        f2 = sprintf('OFDM_trace_phs_r%d_t%d.txt', rxn, txID);
        %tr = load(f2);
        tr_pha(:,:) = load(f2); %tr(1:maxChannelRealize,:)/180;  
        for subc = 1:64
        amplitude = tr_amp(subc,:);
        phase = tr_pha(subc,:)/180*pi;
        gain = amplitude.*exp(j*phase);
        %CH1 = reshape(gain, maxRxAntenna, maxTxAntenna);
        %CH(:,:,subc,rxn) = CH1(1:numRxAntenna, 1:numTxAntenna);
        estCH(rxn,:,subc) = gain; 
        end 
    end

    % Calculate precoding matrix for each subcarrier
    % the precoding matrix is the pseudoinverse of the MU-MIMO channel matrix
    for subc = 1:64
		if (subc <= 6 || subc >= 60 || subc == 33) continue; end 
        H1 = [];
        for rxn = 1:numRxNode
            %H2 = squeeze(CH(:,:,subc,rxn));
            %H1 = [H1 H2.'];
            H1 = [H1 estCH(rxn,:,subc).'];
        end
        H1 = H1.';
        %if (norm(H1)==0) continue; end
        precodeM(:,:,subc) = H1' * inv(H1 * H1'); 
    end
else % run on WARP



%% ============= Start tx and rx =======================


fprintf(1, '=======================\n');
fprintf(1, '==== Start precodeRound %d \n', numPrecodeRounds);
sf = fopen('OFDMsamples_a%d_r%d_t%d.dat', 'wb');

% --- store samples to file ---
for rxn = 1:numRxNode
for rxa = 1:numRxAntenna	
    sf = sprintf('OFDMsamples_a%d_r%d_t%d.dat', rxa, rxn, txID);
    fsout(rxa,rxn) = fopen(sf, 'wb');
end
end


for txn = 1:numTxNode
for txa = 1:numTxAntenna
    %txa1 = mod(txa, 4)+txRadioIndexShift;
	txa1 = mod(txa+txRadioIndexShift-1, 4) + 1;
    radiovar = eval(sprintf('RADIO%d_TXDATA',txa1));
    warplab_writeSMWO(udp_txnode(txn), radiovar, TxData(:,txa,txn).');
end
end


% Prime transmitter state machine in node 1. Node 1 will be
% waiting for the SYNC packet. Transmission from node 1 will be triggered
% when node 1 receives the SYNC packet.
%warplab_sendCmd(udp_node1, TX_START, packetNum);
for txn = 1:numTxNode
    warplab_sendCmd(udp_txnode(txn), TX_START, packetNum);
end


for rxn = 1:numRxNode
    %xyz: this clears the RX buffer
    warplab_sendCmd(udp_rxnode(rxn), RX_START, packetNum); 
end


% Prime receiver state machine in node 2. Node 2 will be waiting
% for the SYNC packet. Capture at node 2 will be triggered when node 2
% receives the SYNC packet.
%warplab_sendCmd(udp_node2, RX_START, packetNum);
%warplab_sendCmd(udp_node3, RX_START, packetNum);

% Send the SYNC packet
warplab_sendSync(udp_Sync);

% Leave continuous transmitter on for nsec seconds
nsec = 0.001;
pause(nsec);

% Stop transmission
%warplab_sendCmd(udp_node1, TX_STOP, packetNum); % Resets the output and read 
% address of the transmitter buffer without disabling the transmitter radio. 
for txn = 1:numTxNode
warplab_sendCmd(udp_txnode(txn), TX_STOP, packetNum); % Resets the output and read  address of the transmitter buffer without disabling the transmitter radio. 
end


% ***** Read the received smaples from the WARP board
% Read back the received samples 
for rxn = 1:numRxNode
for rxa = 1:numRxAntenna
	%rxa1 = mod(rxa, 4)+rxRadioIndexShift; 
	rxa1 = mod(rxa+rxRadioIndexShift-1, 4) + 1;
    radiovar = eval(sprintf('RADIO%d_RXDATA',rxa1));
    RawRxData(:,rxa,rxn) = warplab_readSMRO(udp_rxnode(rxn), radiovar, TxLength+TxDelay);
    fwrite(fsout(rxa,rxn), RawRxData(:,rxa,rxn), 'uint32');
end 
end 


for rxn = 1:numRxNode
for rxa = 1:numRxAntenna
    %sf = sprintf('singleToneSamples_a%d_r%d', rxa, rxn);
    fclose(fsout(rxa,rxn));
end
end
% Reset the AGC
%warplab_sendCmd(udp_node2, AGC_RESET, packetNum);


%Close sockets
%pnet('closeall'); -- put to the end


% ============ OFDM detection, channel estimaiton and decoding ============
% convert to channel matrix trace
%for rxn = 1:numRxNode
%    multiRxDAS(rxn, txID);
%	%pause;
%end
multiRxDAS(1, txID);
%multiRxDAS_mAntenna(2, txID);



% ============ Update precoding matrix ============
    maxChannelRealize = 2;
    nc = 1; % index of the measurement to be applied in calc precoding matrix
    maxRxAntenna = 1;
    maxTxAntenna = 4;
	%{
    % extract channel matrix
    for rxn = 1:numRxAntenna
        f1 = sprintf('OFDM_trace_amp_r%d_t%d.txt', rxn, txID);
        %tr = load(f1);
        tr_amp = load(f1); %tr(1:maxChannelRealize,:);
        f2 = sprintf('OFDM_trace_phs_r%d_t%d.txt', rxn, txID);
        %tr = load(f2);
        tr_pha = load(f2); %tr(1:maxChannelRealize,:)/180;  
        for subc = 1:64
        amplitude = tr_amp(subc,:);
        phase = tr_pha(subc,:)/180*pi;
        gain = amplitude.*exp(j*phase);
        %CH1 = reshape(gain, maxRxAntenna, maxTxAntenna);
        %CH(:,:,subc,rxn) = CH1(1:numRxAntenna, 1:numTxAntenna);
        estCH(rxn,:,subc) = gain; 
        end 
    end
	%}

	 	f1 = sprintf('OFDM_trace_amp_r%d_t%d.txt', 1, txID);
        tr_amp = load(f1);
        f2 = sprintf('OFDM_trace_phs_r%d_t%d.txt', 1, txID);
        tr_pha = load(f2);
        for subc = 1:64
				amplitude = tr_amp(subc,:);
				phase = tr_pha(subc,:)/180*pi;
				gain = amplitude.*exp(j*phase);
        		estCH(1,:,subc) = gain(1:2); 
        		estCH(2,:,subc) = gain(3:4); 
		end
        
	% plot and compare the channel from the two nodes
	pdiff =  squeeze(unwrap(angle(estCH(2,2,:)))) - squeeze(unwrap(angle(estCH(1,1,:))));
	tlen = length(pdiff);
	%fprintf(debuglog, 'chdiff %f+j%f\n', real(chdiff), imag(chdiff));
	%fprintf(1, 'chdiff %f+j%f\n', real(chdiff), imag(chdiff));
	figure(508);
	subplot(1,2,1);
	plot(1:tlen, squeeze(abs(estCH(2,2,:))./abs(estCH(1,1,:))), '-o');
	title('amp diff');
	subplot(1,2,2);
	plot(1:tlen, pdiff*180/pi, '-x');
	title('phase diff');
	 

    % Calculate precoding matrix for each subcarrier
    % the precoding matrix is the pseudoinverse of the MU-MIMO channel matrix
    for subc = 1:64
		if (subc <= 6 || subc >= 60 || subc == 33) continue; end 
        H1 = [];
        for rxn = 1:numRxAntenna
            %H2 = squeeze(CH(:,:,subc,rxn));
            %H1 = [H1 H2.'];
            H1 = [H1 estCH(rxn,:,subc).'];
        end
        H1 = H1.';
        %precodeM(:,:,subc) = H1' * inv(H1 * H1'); 
    end




% ========= Write samples to file =============
%{
fout = fopen('insamples_Node2.dat', 'wb');
fwrite(fout, [real(oNode2_Radio1_RxData); imag(oNode2_Radio1_RxData); ...
            real(oNode2_Radio2_RxData); imag(oNode2_Radio2_RxData); ...
            real(oNode2_Radio3_RxData); imag(oNode2_Radio3_RxData); ...
            real(oNode2_Radio4_RxData); imag(oNode2_Radio4_RxData)], ...
            'float32'); 
fclose(fout);

fout = fopen('insamples_Node3.dat', 'wb');
fwrite(fout, [real(oNode3_Radio1_RxData); imag(oNode3_Radio1_RxData); ...
            real(oNode3_Radio2_RxData); imag(oNode3_Radio2_RxData); ...
            real(oNode3_Radio3_RxData); imag(oNode3_Radio3_RxData); ...
            real(oNode3_Radio4_RxData); imag(oNode3_Radio4_RxData)], ...
            'float32'); 
fclose(fout);


fprintf(1, 'Start processing\n');
%}
%rxMulti();


end % end if USESIM==0
pause(0.5);
end % end for numPrecodeRounds = 1:totalPrecodeRounds



% ============ Reset and disable the boards ==========
if USESIM == 0
% ---- Disable transmitter ------------
for txn = 1:numTxNode
for txa = 1:4
    %txa1 = mod(txa, 4)+txRadioIndexShift;
	txa1 = mod(txa+txRadioIndexShift-1, 4) + 1;
    radiovar = eval(sprintf('RADIO%dTXBUFF_TXDIS', txa1));
    warplab_sendCmd(udp_txnode(txn), radiovar, packetNum);
    radiovar = eval(sprintf('RADIO%d_TXDIS', txa1));
    warplab_sendCmd(udp_txnode(txn), radiovar, packetNum);
end
    warplab_writeRegister(udp_txnode(txn),TX_MODE, 0);
end

% ---- Disable receiver ------------
for rxn = 1:numRxNode
    warplab_sendCmd(udp_rxnode(rxn), RX_DONEREADING, packetNum);
    for rxa = 1:4
		%rxa1 = mod(rxa, 4)+rxRadioIndexShift; 
		rxa1 = mod(rxa+rxRadioIndexShift-1, 4) + 1;
        radiovar = eval(sprintf('RADIO%dRXBUFF_RXDIS', rxa1));
        warplab_sendCmd(udp_rxnode(rxn), radiovar, packetNum);
        radiovar = eval(sprintf('RADIO%d_RXDIS', rxa1));
        warplab_sendCmd(udp_rxnode(rxn), radiovar, packetNum);
    end
end


%{
% Set radio 2 Tx buffer in node 1 back to Tx disabled mode
warplab_sendCmd(udp_node1, [RADIO1TXBUFF_TXDIS,RADIO2TXBUFF_TXDIS,RADIO3TXBUFF_TXDIS,RADIO4TXBUFF_TXDIS], packetNum);

% Disable the transmitter radio
warplab_sendCmd(udp_node1, [RADIO1_TXDIS,RADIO2_TXDIS,RADIO3_TXDIS,RADIO4_TXDIS], packetNum);

% Disable continous tranmsission mode
TxMode = 0;
warplab_writeRegister(udp_node1,TX_MODE,TxMode);
%}


%Close sockets
pnet('closeall');
end
fclose(debuglog);
