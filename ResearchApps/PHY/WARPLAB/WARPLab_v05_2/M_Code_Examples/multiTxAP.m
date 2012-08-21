% Multiple DAS cells, each with multiple TX antennas and multiple clients
% xyzhang
% 11/28/2011
clear all;
diary on;
diary('filename');
global VLTF_shift LTF_shift LTF_t LTFscale STF_t numTxAntenna ...
	CHout RawRxData DECODE_DATA;

USESIM = 0; % whether to use simulation
DEBUG_OUT = 1;

pause(10);
USE_POWEROPT = 1; % 0: no power opt 1: decomposed power alloc 2: equal power alloc for all streams 3: optimize stream amplitude
numTxNode = 1;
txID = 1; % currently we only allow one transmitter with ID txID
numRxNode = 1;
%rxID = 2;
numTxAntenna = 1; % number of tx antennas
numRxAntenna = 1; % number of rx antennas
osamp = 8; % Oversampling rate or Number of samples per symbol, 40Mhz/osamp wide band
numOFDMsymb = 15;
display('hey whats uppp');
if USESIM osamp = 1; end
debuglog = fopen('debuglog.txt','w');
for k=1:numRxNode % decoding log
		fn = sprintf('MUMIMO_decode_rxn%d.txt', k);
		delete(fn);
end

totalPrecodeRounds = 3;
rxRadioIndexShift = 1; % count the Warp rx radio from 1+rxRadioIndexShift
txRadioIndexShift = 4; % count the Warp tx radio from 1+txRadioIndexShift
numRxCapture = 1; 

TxGain_RF = 56;%56;  % Tx RF Gain. In [0:63] 
TxGain_BB = 2; % 1 Tx Baseband Gain. In [0:3]
RxGain_BB = 5; % Rx Baseband Gain. In [0:31]
RxGain_RF = 2;%3; % Rx RF Gain. In [1:3] 
TxMode = 1; %1 for continuous transmission
MGC_AGC_Select = 0; %0 for MGC, 1 for AGC


TxDelay = 1000;
TxLength = 2^14-TxDelay; % Length of transmission. In [0:2^14-1-TxDelay]
CarrierChannel = 14; % Channel in the 2.4 GHz band. In [1:14]; 5GHz in [15:37]
pktsize_bytes = 25; 
global precodeM;
for subc = 1:64
    precodeM(:,:,subc) = eye(numTxAntenna, numRxNode);
end



STF = [0 0 0 0 0 0 0 0 1+i 0 0 0 -1+i 0 0 0 -1-i 0 0 0 1-i 0 0 0 -1-i 0 0 0 1-i 0 0 0 0 0 0 0 1-i 0 0 0 -1-i 0 0 0 1-i 0 0 0 -1-i 0 0 0 -1+i 0 0 0 1+i 0 0 0 0 0 0 0].';
% Before ifft, ensure the zero-frequency on index 1; minus-frequency begins
% from half (so the samples near the half-freq should be a sequence of 0s)
STF_t = ifft(fftshift(STF)).';
STF_t_short = STF_t(1:16);
STF_10 = repmat(STF_t_short,1,10);
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


LTF_freq_bot = [0 0 0 0 0 0 1 1 -1 -1 1 1 -1 1 -1 1 1 1 1 1 1 -1 -1 1 1 -1 1 -1 1 1 1 1]';
LTF_freq_top = [1 -1 -1 1 1 -1 1 -1 1 -1 -1 -1 -1 -1 1 1 -1 -1 1 -1 1 -1 1 1 1 1 0 0 0 0 0]';
LTF_freq = [LTF_freq_bot ; 0 ; LTF_freq_top];
LTF_shift = fftshift(LTF_freq);
LTF_t = ifft(LTF_shift).';
%LTF_time_up2 = interp(LTF_time, osamp); % Upsample by 2 so that
LTFscale = 1/max([ max(abs(real(LTF_t))), max(abs(imag(LTF_t))) ]);
%LTF_time_up2 = scale * LTF_time_up2; % Scale to span -1,1 range of DAC
LTF_time = ifft(LTF_shift).';
LTF_time_up2 = interp(LTF_time, osamp); % Upsample 
scale = 1/max([ max(abs(real(LTF_time_up2))), max(abs(imag(LTF_time_up2))) ]);
LTF_time_up2 = scale * LTF_time_up2; % Scale to span -1,1 range of DAC 
% Concatenate two long training symbols and add cyclic prefix
%longsyms_2_cp = [LTF_time(33:64) repmat(LTF_time,1,2)];
%longsyms_2_cp_up2 = interp(longsyms_2_cp,2); % Upsample by 2
LTF_up2 = [LTF_time_up2(32*osamp+1:64*osamp) repmat(LTF_time_up2,1,2)];

% ------ VHT-LTF -------
VLTF_freq_bot(1,:) = [0 0 0 0 0 0 1 -1 -1 1 1 1 -1 -1 -1 1 -1 1 1 -1 1 -1 1 1 1 -1 1 -1 -1 1 1 1]';
VLTF_freq_top(1,:) = [-1 -1 -1 1 -1 1 1 -1 1 -1 -1 1 -1 -1 1 1 -1 -1 1 -1 -1 -1 1 1 -1 1 0 0 0 0 0]';

VLTF_freq_bot(2,:) = [0 0 0 0 0 0 -1 -1 1 -1 1 1 -1 1 -1 -1 -1 1 -1 1 1 -1 1 1 1 -1 1 -1 -1 -1 1 1]';
VLTF_freq_top(2,:) = [1 -1 1 -1 -1 -1 1 1 -1 1 -1 -1 1 -1 -1 1 1 -1 1 1 -1 1 1 1 -1 -1 0 0 0 0 0]';

% --- for rx 3 ---
VLTF_freq_bot(3,:) = [0 0 0 0 0 0 1 -1 -1 -1 -1 1 -1 1 1 -1 1 1 1 -1 -1 1 -1 -1 1 -1 -1 1 1 1 -1 -1]';
VLTF_freq_top(3,:) = [-1 1 1 1 -1 1 1 -1 -1 1 -1 1 1 -1 1 -1 1 -1 1 1 1 -1 1 -1 -1 1 0 0 0 0 0]';

% --- for rx 4 ---
VLTF_freq_bot(4,:) = [0 0 0 0 0 0 -1 1 -1 1 1 -1 -1 -1 -1 1 1 -1 1 1 1 -1 1 1 -1 -1 1 1 -1 1 1 -1]';
VLTF_freq_top(4,:) = [1 -1 -1 1 1 -1 -1 1 1 1 1 -1 -1 -1 1 -1 -1 1 -1 -1 -1 1 1 -1 1 -1 0 0 0 0 0]';

for rxn = 1:4
	VLTF_freq(rxn,:) = [VLTF_freq_bot(rxn,:) 0 VLTF_freq_top(rxn,:)];
end
VLTF_freq(1,:) = [VLTF_freq_bot(4,:) 0 VLTF_freq_top(4,:)];
VLTF_freq(4,:) = [VLTF_freq_bot(1,:) 0 VLTF_freq_top(1,:)];

for rxn = 1:4
	VLTF_freq(rxn,:) = VLTF_freq(1,:); %[VLTF_freq_bot(rxn,:) 0 VLTF_freq_top(rxn,:)];
	VLTF_shift(:,rxn) = fftshift(VLTF_freq(rxn,:));
	%VLTFt(:,rxn) = ifft(VLTF_shift(:,rxn)).';
	%VLTFscale(rxn) = 1/max([ max(abs(real(VLTFt(:,rxn)))), max(abs(imag(VLTFt(:,rxn)))) ]);
end


% -------- Generate OFDM data symbol -----------
fg = fopen('databits.dat', 'w');
numBits = 48*numOFDMsymb;
for k = 1:numBits 
	if (numTxAntenna==1&&numRxAntenna==1)%CSMA
			if (rand < 0.5)
				for kk = 1:numRxNode
					fprintf(fg, '1 ');
                    %display(kk);
                    %display('1');
				end
			else        
				for kk = 1:numRxNode
					fprintf(fg, '0 ');
                    %display(kk)
                    %display('0');
				end 
			end
	else
			for kk = 1:numRxNode
					if (rand < 0.5)
						%fprintf(fg, '1 1');   
					    fprintf(fg, '1 ');
					else        
						%fprintf(fg, '0 0');    
    					fprintf(fg, '0 ');
 					end 
			end
	end %end else if not CSMA
	fprintf(fg, '\n');
end
fclose(fg);


inb = load('databits.dat');
numBitsInPkt = length(inb(:,1)); 

s = 1;
posInSymb = 0;
posOut = 0;
while s <= numBitsInPkt
    posOut = posOut + 1;
    
    posInSymb = posInSymb + 1;
    if (posInSymb == 65)
        posInSymb = 1;
    end
     
    % Insert pilot at 7, 21, 43 and 57th subcarriers
    if (posInSymb == (7+1) || posInSymb == (21+1) ...
        || posInSymb == (64-21+1) || posInSymb == (64-7+1))
        for rxn = 1:numRxNode
            symbIn(posOut, rxn) = 1 + 0*i;
        end
        continue;
    end 
     
    % zero-freq in index1, minus-freq near half-sequence
    if (posInSymb==1 || (posInSymb > 27 && posInSymb < 64-26+1))
        %symbIn(posOut) = 0 + 0*i;
        for rxn = 1:numRxNode
            symbIn(posOut, rxn) = 0 + 0*i;
        end 
        continue;
    end 

    
    for rxn = 1:numRxNode
        if (inb(s,rxn)==0) 
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
  %sh = symbIn(:, 1);
  %sh1 = symbIn(:, 2);
  
 %display(posOut);

% ========== Initializaton of WARP radio parameters ========
if USESIM == 0
%Load some global definitions (packet types, etc.)
warplab_defines

% Create Socket handles and intialize nodes
%[socketHandles, packetNum] = warplab_initialize;
%[socketHandles, packetNum] = warplab_initialize(3);%test
[socketHandles, packetNum] = warplab_initialize(1+numRxNode);
%[socketHandles, packetNum] = warplab_initialize(3);

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
%rxl  
udp_rxnode(1) = socketHandles(3);
%udp_rxnode(2) = socketHandles(4);
%udp_rxnode(3) = socketHandles(5);
%udp_rxnode(4) = socketHandles(5);


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
    %display(rxa1);
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
    %display(txa1);
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
%if (numPrecodeRounds>1 && mod(numPrecodeRounds,260)~=0) 
if (numPrecodeRounds > 1) 
		DECODE_DATA=1; 
        display(numPrecodeRounds);
        int = int +1;
        display(int);
        %pause(2);
else
		DECODE_DATA=0; 
        int =0;
end
%display('okk');
%display(precodeM);
% precoding
for s = 1:64 %subcarrier index 
    %if (subc <= 6 || subc >= 60 || subc == 33) continue; end 
	% Antenna power allocation here
	if (numTxAntenna==3 && numRxAntenna==1) %CSMA
		precodeM(:,:,s) = zeros(1,numRxAntenna);
        %display('heyyyyyyyyyy')
		%precodeM(1,1,s) = 1;
        precodeM(:,:,s) = 1;
    end
    
    
    ampScaler = 0;
	if (USE_POWEROPT == 2) %equal power allocation for all streams
			for txa = 1:numTxAntenna
				sc = sum(abs(precodeM(txa,:,s)).^2);
				if (sc > ampScaler) ampScaler=sc; end
			end
	end
	%if ampScaler > 0 ampScaler = 1; end
	precodeScaler(s) = 0; 
	if ampScaler > 0 
			precodeScaler(s) = 1/ampScaler^0.5; 
    end
    
    %display(VLTF_freq(1:numRxNode,s));

    
    for txa = 1:numTxAntenna
        % FIXME: per antenna power constraint?
		if (USE_POWEROPT == 2)
        	VLTF_coded(s, txa) = precodeScaler(s) * precodeM(txa,:,s) * VLTF_freq(1:numRxNode,s);
		else
        	VLTF_coded(s, txa) = precodeM(txa,:,s) * VLTF_freq(1:numRxNode,s);
            %display('subcarrier');
            %display(s);
            %display('antenna');
            %display(txa);
            %display('vltf coded');
            %display(VLTF_coded(s, txa));
            %display('precoded');
            %display(precodeM(txa,:,s));
            %display('vltf freq');
            %display(VLTF_freq(1:numRxNode,s));
		end
		%sc = max([abs(real(VLTF_coded(s, txa))) abs(imag(VLTF_coded(s, txa)))]);
		%if (sc > ampScaler)  ampScaler=sc; end
        if (isnan(VLTF_coded(s, txa))) 
            VLTF_coded(s, txa) = 0;
        end
    end 
	%VLTF_coded(s, :) = VLTF_coded(s, :) / ampScaler; 
end


maxamp=0;
for txa = 1:numTxAntenna
    vt = ifft(fftshift(VLTF_coded(:,txa)), 64);
	%vt = vt/max([max(abs(real(vt))) max(abs(imag(vt)))]);
    VLTF_t(txa, :) = [vt(64-16+1:64); vt].';
	%tmp = max([max(abs(real(vt))) max(abs(imag(vt)))]);
	%tmp = max(abs(VLTF_t(txa, :)));
	%if (tmp > maxamp) maxamp = tmp; end
    VLTF_t_up(txa, :) = interp(VLTF_t(txa, :), osamp);
	tmp = max([ max(abs(real(VLTF_t_up(txa,:)))), max(abs(imag(VLTF_t_up(txa,:)))) ]);
	if (tmp > maxamp) maxamp = tmp; end
end
%VLTF_t = VLTF_t/maxamp;
VLTF_t_up = VLTF_t_up/maxamp;

%display('vlllll');
%display(VLTF_t_up);

% *** Zero-forcing precoding for data in each subcarrier ***
%numOFDMsymb = length(symbIn(:,1))/64;

for rxa = 1:numRxNode
for txa = 1:numTxAntenna
    %display(txa);
    %display(rxa);
  for os = 1:numOFDMsymb
  for s = 1:64 %subcarrier index
	sind = mod(s+31,64)+1;
	bindex = (os-1)*64+s;
    %for rxa = 1:numRxNode
    %for txa = 1:numTxAntenna
        
         %display('please');
         %display(bindex);
         
        %precodeM1(txa,:,s) = precodeM(txa,:,mod(s+31,64)+1);
        %pilotOut(s, txa) = precodeM1(txa,:,s) * pilotOut(s,:).';
		
        if(txa==1 && rxa ==1 || txa==2 && rxa ==2 || txa==3 && rxa ==3)
        if (USE_POWEROPT==2)
        	pilotOut(bindex, txa) = precodeScaler(sind)*precodeM(txa,:,sind) * symbIn(bindex,:).';
		else
        	%pilotOut(bindex, txa) = precodeM(txa,:,sind) * symbIn(bindex,rxa).';
            pilotOut(bindex, txa) = precodeM(txa,rxa,sind) * symbIn(bindex,rxa).';
           
            %display(symbIn(bindex,numRxNode))
            
            
           
            
            %display('precode');
            %display(precodeM(txa,rxa,sind));
            %display('symbol');
            %display(rxa);
            %display(symbIn(bindex,rxa));
            %display(symbIn(bindex,2));
            %display('pilot out');
            %display(pilotOut(bindex,txa));
        end
        end
        end
  end
  
  
  
  %  display('antena');
%display(txa)
%display(pilotOut(bindex, txa));

end

end

%mol= precodeM(:,:,:)
%display('pilot out');
%display(pilotOut);
%for ds = 1:numOFDMsymb
%    display(pilotOut((ds-1)*64+1:ds*64,1));
%    display(pilotOut((ds-1)*64+1:ds*64,2));
%end
% *** IFFT: generate time domain data signal 
maxamp = 0;
for txa = 1:numTxAntenna
    outCount = 0;
    for ds = 1:numOFDMsymb
        ifftOut = ifft(pilotOut((ds-1)*64+1:ds*64,txa), 64);

        % *** Add guard interval 
        for s = 0:(80-1)
            ind = mod(s+64-16, 64) + 1;
            outCount = outCount + 1; 
            output_t(outCount,txa) = ifftOut(ind);   
        end
    end

    %tmp = max(abs(output_t(:, txa)));
	%if (tmp > maxamp) maxamp = tmp; end
	DATA_up2(:,txa) = interp(output_t(:,txa), osamp); % Upsample 
	%tmp = max(abs(DATA_up2(:, txa)));
	tmp = max([max(abs(real(DATA_up2(:, txa)))), max(abs(imag(DATA_up2(:, txa))))]);
	if (tmp > maxamp) maxamp = tmp; end
	% ******* Pulse shaping *******
    % Smooth transition between LTF and LSIG
    % FIXME
end  % end for ds = 1:64:l1

for txa = 1:numTxAntenna
     DATA_up2(:,txa) = DATA_up2(:,txa) / maxamp; 
end


% ------- Concatenate all tx samples ---------
zero_vector = zeros(1, length(LTF_up2));
%zero_data = zeros(1, length(DATA_up2));


%for txn = 1:numTxNode
txn = 1;
%td = [STF_up2, LTF_up2, zero_vector, zero_vector, zero_vector, DATA_up2(:,1).'];
%td = [STF_up2, LTF_up2, zero_vector, DATA_up2(:,1).'];
%td = [STF_up2, LTF_up2, zero_vector, VLTF_t_up(1,:)];
if numTxAntenna == 1
td = [STF_up2, LTF_up2, VLTF_t_up(1,:), DATA_up2(:,1).'];
elseif numTxAntenna == 2
td = [STF_up2, LTF_up2, zero_vector, VLTF_t_up(1,:), DATA_up2(:,1).'];
elseif numTxAntenna == 3
td = [STF_up2, LTF_up2, zero_vector, zero_vector, VLTF_t_up(1,:), DATA_up2(:,1).'];
elseif numTxAntenna == 4
td = [STF_up2, LTF_up2, zero_vector,zero_vector, zero_vector, VLTF_t_up(1,:), DATA_up2(:,1).'];
end

if (TxLength-length(td) < 0)
	fprintf(1, 'ERROR!!! data overflow!\n');
	return;
end
if (USESIM==0)
    TxData(:,1,txn) = [td zeros(1,max(1,TxLength-length(td)))];
else
    TxData(:,1,txn) = [zero_vector td zeros(1,max(1,TxLength-length(td)))];
end


td = [];
if (numTxAntenna >= 2)
if numTxAntenna == 2
td = [STF_up2, zero_vector, LTF_up2, VLTF_t_up(2,:), DATA_up2(:,2).'];
elseif numTxAntenna == 3
td = [STF_up2, zero_vector, LTF_up2, zero_vector, VLTF_t_up(2,:), DATA_up2(:,2).'];
elseif numTxAntenna == 4
td = [STF_up2, zero_vector, LTF_up2, zero_vector, zero_vector, VLTF_t_up(2,:), DATA_up2(:,2).'];
end
end % end txantenna 2
if (USESIM==0)
    TxData(:,2,txn) = [td zeros(1,max(1,TxLength-length(td)))];
else
    TxData(:,2,txn) = [zero_vector td zeros(1,max(1,TxLength-length(td)))];
end

% tx antenna 3
td = [];
if (numTxAntenna >= 3)
if (numTxAntenna==3)
td = [STF_up2, zero_vector, zero_vector, LTF_up2, VLTF_t_up(3,:), DATA_up2(:,3).'];
elseif (numTxAntenna==4)
td = [STF_up2, zero_vector, zero_vector, LTF_up2, zero_vector, VLTF_t_up(3,:), DATA_up2(:,3).'];
end
end
if (USESIM==0)
    TxData(:,3,txn) = [td zeros(1,max(1,TxLength-length(td)))];
else
    TxData(:,3,txn) = [zero_vector td zeros(1,max(1,TxLength-length(td)))];
end

% tx antenna 4
td = [];
if (numTxAntenna >= 4)
td = [STF_up2, zero_vector, zero_vector, zero_vector, LTF_up2, VLTF_t_up(4,:), DATA_up2(:,4).'];
end
if (USESIM==0)
    TxData(:,4,txn) = [td zeros(1,max(1,TxLength-length(td)))];
else
    TxData(:,4,txn) = [zero_vector td zeros(1,max(1,TxLength-length(td)))];
end



if USESIM == 1
    % Signals from different antennas combine at the receive antenna 
    % Assume two receivers, each with one antenna 
    % fname = 'sim_modulated.dat';
    
    
    
    
    
    
    
    
    
    shail(:,1) = TxData(:,1,txID);
    shail(:,2) = TxData(:,2,txID);
    shail(:,3) = TxData(:,3,txID);
    if (numPrecodeRounds < 2)
    sh = [1 1 ; 1 1];
    sh1= [1 1; 1 1];
     
      ch=eye(3)*(1/1.414)*[(rand(3,3)+j*rand(3,3))]*eye(3);
      ch1=eye(3)*(1/1.414)*[(rand(3,3)+j*rand(3,3))]*eye(3);
   % display(ch);
    end
    
    if(mod(int,16)==0 )
        
     ch1=eye(3)*(1/1.414)*[(rand(3,3)+j*rand(3,3))]*eye(3);
     %display(ch1);
 
    end
    
    %display(ch);
    for i=1:length(shail)
        
           
         if(int<16)    
         y(i,1) = shail(i,1)*ch(1,1) + shail(i,2)*ch(1,2) + shail(i,3)*ch(1,3) ;
         y(i,2) = shail(i,1)*ch(2,1) + shail(i,2)*ch(2,2) + shail(i,3)*ch(2,3);
         y(i,3) = shail(i,1)*ch(3,1) + shail(i,2)*ch(3,2) + shail(i,3)*ch(3,3);
         else
             %display('hey')
             y(i,1) = shail(i,1)*ch1(1,1) + shail(i,2)*ch1(1,2) + shail(i,3)*ch1(1,3) ;
             y(i,2) = shail(i,1)*ch(2,1) + shail(i,2)*ch(2,2) + shail(i,3)*ch(2,3);
             y(i,3) = shail(i,1)*ch(3,1) + shail(i,2)*ch(3,2) + shail(i,3)*ch(3,3);
         end 
    end    
    
      %display(ch1);
    
    %y = filter(chan,shail); 
     %y(:,1) = shail(:,1)*ch(1,1) + shail(:,2)*ch(1,2) ;
     %y(:,2) = shail(:,1)*ch(2,1) + shail(:,2)*ch(2,2) ;
     
   
     x1= y(:,1);
     x2 = y(:,2);
     x3 = y(:,3);
    % mean(x1)
     %mean(x2)
    fname1 = 'sim_modulated_Rx1_m.dat';
    fo = fopen(fname1, 'wb'); 
    freq_dis = 0.0011/2/pi;
    for k = 1:length(x1)
		x1 = x1 * exp(-j*2*pi*freq_dis*k);
    end
    
    o1 = [];
    a = real(x1);
    b = imag(x1);
    for k = 1:length(x1)
        o1 = [o1 a(k) b(k)];
    end 
   
    fwrite(fo, o1, 'float32');
    fclose(fo);
   
    
    
    
     fname1 = 'sim_modulated_Rx2_m.dat'; 
        fo = fopen(fname1, 'wb'); 
    freq_dis = 0.0028/2/pi;
    for k = 1:length(x2)
		x2 = x2 * exp(-j*2*pi*freq_dis*k);
	end
        
    o2 = [];
    a = real(x2);
    b = imag(x2);
    for k = 1:length(x2)
        o2 = [o2 a(k) b(k)];
    end
    
    fwrite(fo, o2, 'float32');
    fclose(fo);
    
    
    fname1 = 'sim_modulated_Rx3_m.dat'; 
        fo = fopen(fname1, 'wb'); 
    o3 = [];
    a = real(x3);
    b = imag(x3);
    for k = 1:length(x3)
        o3 = [o3 a(k) b(k)];
    end
    
    fwrite(fo, o3, 'float32');
    fclose(fo);
      
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    fname = 'sim_modulated_Rx1.dat'; 
    CH(1, :) = [0.8-0.6j 10 1+j 1-j]/10; 
    %CH(1, :) = [0.8-0.6j 1 1+j 1-j]/10; 
    fo = fopen(fname, 'wb'); 
    txd1 = TxData(:,1,txID)*CH(1,1) + TxData(:,2,txID)*CH(1,2) ...
            + TxData(:,3,txID)*CH(1,3) + TxData(:,4,txID)*CH(1,4);
    %fwrite(fo, [real(txd1); imag(txd1)], 'float32'); 
    % generate "standard" format for complex numbers [real imag, real imag,...]
	freq_dis = 0.0011/2/pi;
    for k = 1:length(txd1)
		txd1(k) = txd1(k) * exp(-j*2*pi*freq_dis*k);
	end
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
    CH(2, :) = [j 10-j 1 0.5]/10;
    %CH(2, :) = [j 1-j 1 0.5]/10;
    fo = fopen(fname, 'wb'); 
    txd2 = TxData(:,1,txID)*CH(2,1) + TxData(:,2,txID)*CH(2,2)...
            + TxData(:,3,txID)*CH(2,3) + TxData(:,4,txID)*CH(2,4);
	freq_dis = 0.0028/2/pi;
	for k = 1:length(txd2)
		txd2(k) = txd2(k) * exp(-j*2*pi*freq_dis*k);
	end 
    o1 = [];
    a = real(txd2);
    b = imag(txd2);
    for k = 1:length(txd2)
        o1 = [o1 a(k) b(k)];
    end
    fwrite(fo, o1, 'float32');
    fclose(fo);
     
	fname = 'sim_modulated_Rx3.dat'; 
    CH(3, :) = [0.5+0.4j 9j 0.7-0.2j 0.8]/10;
    %CH(3, :) = [0.5+0.4j 0.9j 0.7-0.2j 0.8]/10;
    fo = fopen(fname, 'wb'); 
    txd2 = TxData(:,1,txID)*CH(3,1) + TxData(:,2,txID)*CH(3,2)...
            + TxData(:,3,txID)*CH(3,3) + TxData(:,4,txID)*CH(3,4);
	freq_dis = 0.0038/2/pi;
	for k = 1:length(txd2)
		txd2(k) = txd2(k) * exp(-j*2*pi*freq_dis*k);
	end 
    o1 = [];
    a = real(txd2);
    b = imag(txd2);
    for k = 1:length(txd2)
        o1 = [o1 a(k) b(k)];
    end
    fwrite(fo, o1, 'float32');
    fclose(fo);
     
	fname = 'sim_modulated_Rx4.dat'; 
    CH(4, :) = [0.3+0.6j 8-j -j 0.4-0.8j]/10;
    %CH(4, :) = [0.3+0.6j 0.8-j -j 0.4-0.8j]/10;
    fo = fopen(fname, 'wb'); 
    txd2 = TxData(:,1,txID)*CH(4,1) + TxData(:,2,txID)*CH(4,2)...
            + TxData(:,3,txID)*CH(4,3) + TxData(:,4,txID)*CH(4,4);
	freq_dis = 0.0059/2/pi;
	for k = 1:length(txd2)
		txd2(k) = txd2(k) * exp(-j*2*pi*freq_dis*k);
	end 
    o1 = [];
    a = real(txd2);
    b = imag(txd2);
    for k = 1:length(txd2)
        o1 = [o1 a(k) b(k)];
    end
    fwrite(fo, o1, 'float32');
    fclose(fo);
	 
     
    % ============ OFDM detection, channel estimaiton and decoding ====
    for rxn = 1:numRxNode
        multiRxDAS(rxn, txID);
		pause(0.5);
    end

% ============ Update precoding matrix ============
 if (numTxAntenna==1 && numRxAntenna==1) %CSMA
	for subc = 1:64
		precodeM(:,:,subc) = zeros(1,numRxNode);
		precodeM(1,1,subc) = 1;
	end
 else
 if (USE_POWEROPT == 0 || USE_POWEROPT == 2)
    % extract channel matrix
    for rxn = 1:numRxNode
        f1 = sprintf('OFDM_trace_amp_r%d_t%d.txt', rxn, txID);
        tr_amp = load(f1); %tr(1:maxChannelRealize,:);
        f2 = sprintf('OFDM_trace_phs_r%d_t%d.txt', rxn, txID);
        tr_pha = load(f2); %tr(1:maxChannelRealize,:)/180;  
        for subc = 1:64
        amplitude = tr_amp(subc,:);
        phase = tr_pha(subc,:)/180*pi;
        gain = amplitude.*exp(j*phase);
        estCH(rxn,:,subc) = gain; 
        end 
    end

    % Calculate precoding matrix for each subcarrier
    % the precoding matrix is the pseudoinverse of the MU-MIMO channel matrix
    for subc = 1:64
		
		if (subc <= 6 || subc >= 60 || subc == 33) continue; end 
		%{
        H1 = [];
        for rxn = 1:numRxNode
            H1 = [H1 estCH(rxn,:,subc).'];
        end
        H1 = H1.';
        %if (norm(H1)==0) continue; end
		%}
		H1 = squeeze(estCH(:,:,subc));
        precodeM(:,:,subc) = H1' * inv(H1 * H1'); 
    end
 elseif (USE_POWEROPT==1)% using joint power allocation and precoding
	decomp_powerAlloc_warp;
 elseif (USE_POWEROPT==3)
	varAmp_powerAlloc_warp;
 end 
 end %end if not CSMA
	
else % run on WARP



%% ============= Start tx and rx =======================


fprintf(1, '=======================\n');
fprintf(1, '==== Start precodeRound %d \n', numPrecodeRounds);


% --- store samples to file ---
%{
for rxn = 1:numRxNode
for rxa = 1:numRxAntenna	
    sf = sprintf('OFDMsamples_a%d_r%d_t%d.dat', rxa, rxn, txID);
    fsout(rxa,rxn) = fopen(sf, 'wb');
end
end
%}


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
    %fwrite(fsout(rxa,rxn), RawRxData(:,rxa,rxn), 'uint32');
end 
end 
%{
for rxn = 1:numRxNode
for rxa = 1:numRxAntenna
    %sf = sprintf('singleToneSamples_a%d_r%d', rxa, rxn);
    fclose(fsout(rxa,rxn));
end
end
%}
% Reset the AGC
%warplab_sendCmd(udp_node2, AGC_RESET, packetNum);


%Close sockets
%pnet('closeall'); -- put to the end


% ============ OFDM detection, channel estimaiton and decoding ============
% convert to channel matrix trace
detectFail = 0;
for rxn = 1:numRxNode
	fprintf(1, '--- Process RXN %d\n', rxn);
    if (multiRxDAS(rxn, txID) == -1)
		detectFail = 1;
	end
	if (DEBUG_OUT)
		pause(0.5);
	end
end

if (detectFail == 1) continue; end


% ============ Update precoding matrix ============
if (numTxAntenna==1 && numRxAntenna==1) %CSMA
	for subc = 1:64
		precodeM(:,:,subc) = zeros(1,numRxNode);
		precodeM(1,1,subc) = 1;
	end
else
if (USE_POWEROPT == 0 || USE_POWEROPT==2)
    % extract channel matrix
	%{
    for rxn = 1:numRxNode
        f1 = sprintf('OFDM_trace_amp_r%d_t%d.txt', rxn, txID);
        tr_amp = load(f1); %tr(1:maxChannelRealize,:);
        f2 = sprintf('OFDM_trace_phs_r%d_t%d.txt', rxn, txID);
        tr_pha = load(f2); %tr(1:maxChannelRealize,:)/180;  
		if (length(tr_amp) == 0) %nothing detected
			detectFail = 1;
			break;
		end
        for subc = 1:64
        	estCH(rxn,:,subc) = tr_amp(subc,:).*exp(j * tr_pha(subc,:)/180*pi);
        end 
    end
	if (detectFail == 1) continue; end
	%} 
	
	if (DEBUG_OUT)
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
	end 

    % Calculate precoding matrix for each subcarrier
    % the precoding matrix is the pseudoinverse of the MU-MIMO channel matrix
    for subc = 1:64
		if (subc <= 6 || subc >= 60 || subc == 33) continue; end 
		%{
        H1 = [];
        for rxn = 1:numRxNode
            %H2 = squeeze(CH(:,:,subc,rxn));
            %H1 = [H1 H2.'];
            H1 = [H1 estCH(rxn,:,subc).']; 
        end
        H1 = H1.';
		%}
		%H1 = squeeze(estCH(:,:,subc));
		H1 = squeeze(CHout(:,:,subc));
        % display('h1');
        % display(H1)
        %if (norm(H1)==0) continue; end
        precodeM(:,:,subc) = H1' * inv(H1 * H1'); 
    end
elseif (USE_POWEROPT==1 && numPrecodeRounds ~=totalPrecodeRounds) % use joint power control and precoding
	decomp_powerAlloc_warp; 
elseif (USE_POWEROPT==3 && numPrecodeRounds ~=totalPrecodeRounds)
	varAmp_powerAlloc_warp;
end
end%end if not CSMA


end % end if USESIM==0
%pause(0.5);
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


%Close sockets
pnet('closeall');
end
fclose(debuglog);
%24.2049
