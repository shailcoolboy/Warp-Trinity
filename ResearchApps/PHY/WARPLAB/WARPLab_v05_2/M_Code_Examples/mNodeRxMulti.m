% OFDM MU-MIMO channel estimation 
% 07/25/2011
% xyzhang
%function output = chEstMultiRx()
clear all;
%function f = mNodeRxMulti(rxID, txID)
USESIM = 0;
DEBUG_OUT = 1;
osamp = 8; % Oversampling rate or Number of samples per symbol, 40Mhz/osamp wide band
if USESIM==1 osamp=1; end;
txID = 1; % currently we only allow one transmitter with ID txID
rxID = 1; % currently we only allow one receiver to be processed each time
rdID = 1; % use samples from radio rdID to do packet sync and detection
numRxAntenna = 2; 
numTxAntenna = 2; 
skipsamples = 100;
RSSthresh = 0.0005;
figureOut = 0;
LSE_COMPEN = 0;% LSE compensation of phase offset over subcarriers
FREQ_COMPEN = 1; % you don't need this if you're using LSE_COMPEN
oSubc = 22;

fout1 = fopen('decodelog.txt','w');
if USESIM 
osamp = 1;
% --- 12/02/2011 MU-MIMO test ---
maxRead = 10000;
%fin = fopen('insamples.dat', 'rb');
%fin = fopen('sim_modulated_Rx1.dat', 'rb');
fname = sprintf('sim_modulated_Rx%d.dat', rxID);
fin = fopen(fname, 'rb');
mt = fread(fin, [2, maxRead], 'float32');
fclose(fin); 
sigin(1,:) = mt(1,:) + j*mt(2,:);
% --- end 12/02/2011 ---
else 
% Process th received samples to obtain meaningful data
%for rxn = 1:numRxNode
for rxa = 1:numRxAntenna
    sf = sprintf('OFDMsamples_a%d_r%d_t%d.dat', rxa, rxID, txID);
    %fprintf(1, 'Load file %s\n', sf);
    %[RxData(:,rxa,rxn), RxOTR(:,rxa,rxn)] = warplab_processRawRxData(RawRxData(:,rxa,rxn));
	sff = fopen(sf, 'rb');
	samples = fread(sff, [1 inf], 'uint32');
	fclose(sff);
    [rxData, rxOTR] = warplab_processRawRxData(samples);
	rxData1 = downsample(rxData, osamp);

%{
Fs = 40e6;
filterOrder = 256;
fff = fir1(filterOrder, 1/osamp);
rxData2 = filter(fff, 1, rxData);    % 
rxData1 = downsample(rxData2, osamp);
%}
 
    sigin(rxa, :) = squeeze(rxData1);
end
end


fout = 1;
%{
if USESIM
    osamp = 1;
    skipsamples = 32;
    maxRead = 1000;
    fin = fopen('sim_modulated.dat', 'rb');
else
    skipsamples = 100;
    maxRead = 100000;
    %fin = fopen('insamples_0727outdoor3.dat', 'rb');
    fin = fopen('insamples.dat', 'rb');
    %fin = fopen('insamples_Node2.dat', 'rb');
    %fin = fopen('C:\Users\xyzhang\Desktop\insamples_flat3.dat', 'rb');
end
%}

%{
numRxAntenna = 4; %floor(length(fin(:,1))/2);
numTxAntenna = 4; 
mt = fread(fin, [numRxAntenna*2, maxRead], 'float32');
fclose(fin);
% Separate antennas; Convert to complex numbers
for a = 1:numRxAntenna
    sigin(a,:) = mt(2*a-1, :) + j*mt(2*a, :);
end
%}

sigLen = length(sigin(rdID,:));

% --- original bits, for checking BER ---
%pktSize_Bits = 100*8;
%numBitsInSymb = 48;
%bitin = fopen('databits.dat', 'rb');
%bitData = fread(bitin, pktSize_Bits, 'int8');
%fclose(bitin);


% xyz TODO: move this to a global file
STF = [0 0 0 0 0 0 0 0 1+i 0 0 0 -1+i 0 0 0 -1-i 0 0 0 1-i 0 0 0 -1-i 0 0 0 1-i 0 0 0 0 0 0 0 1-i 0 0 0 -1-i 0 0 0 1-i 0 0 0 -1-i 0 0 0 -1+i 0 0 0 1+i 0 0 0 0 0 0 0].';
STF_t = ifft(fftshift(STF)).';
STF_t_short = STF_t(1:16);
STF_10 = repmat(STF_t_short,1,10);
%STF_I = real(STF_10);
%STF_Q = imag(STF_10);


LTF_freq_bot = [0 0 0 0 0 0 1 1 -1 -1 1 1 -1 1 -1 1 1 1 1 1 1 -1 -1 1 1 -1 1 -1 1 1 1 1]';
LTF_freq_top = [1 -1 -1 1 1 -1 1 -1 1 -1 -1 -1 -1 -1 1 1 -1 -1 1 -1 1 -1 1 1 1 1 0 0 0 0 0]';
LTF_freq = [LTF_freq_bot ; 0 ; LTF_freq_top];
LTF_shift = fftshift(LTF_freq);
LTF_t = ifft(LTF_shift).';
LTF_t160 = [LTF_t(32+1:64) repmat(LTF_t,1,2)];
%LTF_time_up2 = interp(LTF_time, osamp); % Upsample by 2 so that
LTFscale = 1/max([ max(abs(real(LTF_t))), max(abs(imag(LTF_t))) ]);
%LTF_time_up2 = scale * LTF_time_up2; % Scale to span -1,1 range of DAC


% =========== Initialize parameters ===========
numPkt = 0;
smsEng_windowSize = 16;
smsEng = 0; %smoothed energy level
smsEngQ = zeros(64,1);

SNRQsize = 64;
SNRQ = zeros(SNRQsize, 1);
SNRthresh = 2;
SNRQthresh = 0.6;


selfcorrQsize = 16;
selfcorrQ = zeros(selfcorrQsize, 1);
selfcorrQthresh = 0.8; 

prevPktPos = 0;
corr2Engthresh = 0.9;
avgCrosscorr = zeros(16, 1);

%expectPktPos = 0;
%expectPktSeq = 0;
%prevFalsePos = 0;

% init enegy and self-corr
%selfcorr = sum(sigin(ns:ns+31).*conj(sigin(ns-32:ns-1)));
%energy = sum(abs(sigin(ns:ns+31)).^2);


% =========== Loop through all samples ============
ns = skipsamples;
oMag = [];
while ns < sigLen - 161
   % --- Update self-corr and energy level
    selfcorr = sum(sigin(rdID, ns+1:ns+16).*conj(sigin(rdID, ns-15:ns)));
    energy = sum(abs(sigin(rdID, ns+1:ns+16)).^2);

    % --- Update smoothed energy level and SNR queue -----
    if (USESIM && abs(sigin(rdID, ns+1)) == 0)
        sigin(rdID, ns+1) = 1e-8;
    end
    smsEng = smsEng*(1-1/smsEng_windowSize) + 1/smsEng_windowSize*abs(sigin(rdID, ns+1))^2;
    smsEngQ(end+1) = smsEng;
    smsEngQ(1) = [];

    if (smsEngQ(2) <= 0)
        SNR = 0;
    else
        SNR = 10*log10(smsEng/smsEngQ(2));
    end
    if (SNR > SNRthresh && energy > RSSthresh)
        SNRQ(end+1) = 1;
    else
        SNRQ(end+1) = 0;
    end
    SNRQ(1) = [];

    if DEBUG_OUT
        smsEngOut(ns) = smsEng;
        selfcorrOut(ns) = selfcorr;
        energyOut(ns) = energy;
    end
    maxSTFcrossCorrPeak = 0;
    
    % ----- Update self-correlation queue -------
    if ((ns - prevPktPos) > 2*SNRQsize && ...
        (abs(selfcorr)/energy>corr2Engthresh && ...
        abs(selfcorr)/energy<1/corr2Engthresh))
        %ns = ns + 1;
        %continue;
        selfcorrQ(end+1) = 1;
    else
        selfcorrQ(end+1) = 0;
    end
    selfcorrQ(1) = [];

    % ---- Decision: self-correlation and energy detection ----
    if (sum(SNRQ(end-16:end))/16< SNRQthresh || ...
        sum(selfcorrQ)/length(selfcorrQ) < selfcorrQthresh)
        %fprintf(fout, 'Pos %d SNRQfrac = %f\n', ns, sum(SNRQ)/SNRQsize);
        ns = ns + 1;
        continue;
    end

    % ---- Self-corr peak detected ---- 
    fprintf(fout, '!!! Self-corr peak detected at sample %d level %f\n', ns, energy);
    firstSTFpos = ns;
    
	selfcorrPeak = energy;

    % ---- Search for the first peak via cross-corr with STF ----
    af = 1; 
    peakPos = 0; 
    for k = 1:16
        crosscorrSTF = sum(sigin(rdID, ns+k:ns+k+15).*conj(STF_t(2:17)));
        if DEBUG_OUT 
            crosscorrOut(ns+k) = crosscorrSTF; 
            selfcorrOut(ns+k) = sum(sigin(rdID, ns+1:ns+16).*conj(sigin(rdID, ns-15:ns)));
            energyOut(ns+k) = sum(abs(sigin(rdID, ns+1:ns+16)).^2);
        end
        if k==1
            avgCrosscorr(1) = abs(crosscorrSTF);
            continue;
        end
        avgCrosscorr(k) = af*abs(crosscorrSTF) + (1-af)*avgCrosscorr(k-1);
    end
    for k=2:15
        % detect a peak in the avgCrosscorr curve
        if (avgCrosscorr(k) > maxSTFcrossCorrPeak &&...
               avgCrosscorr(k) > avgCrosscorr(k-1) &&...
               (k<4||avgCrosscorr(k) > avgCrosscorr(k-3)) &&...
               (k<6||avgCrosscorr(k) > avgCrosscorr(k-5)) &&...
               avgCrosscorr(k) > avgCrosscorr(k+1) &&...
               (k>16-3 || avgCrosscorr(k) > avgCrosscorr(k+3)) &&...
               (k>16-5 || avgCrosscorr(k) > avgCrosscorr(k+5)))
                
            maxSTFcrossCorrPeak = avgCrosscorr(k);
            peakPos = k;
            if DEBUG_OUT
                fprintf(fout, 'peakPos %d, maxSTFcrossCorrPeak %f\n', ...
                        peakPos, maxSTFcrossCorrPeak);
            end
        end
    end
    ns = ns + peakPos;


    % ------- Detect other peaks ---------
    % Calculate avgCrosscorr of all the following sample positions
    numPeak = 1;
    psamples = 16*9;
    for k = 1:psamples %max number of peaks is 9
        crosscorrSTF = sum(sigin(rdID, ns+k:ns+k+15).*conj(STF_t(2:17)));
        if DEBUG_OUT 
            crosscorrOut(ns+k) = crosscorrSTF; 
            selfcorrOut(ns+k) = sum(sigin(rdID, ns+1:ns+16).*conj(sigin(rdID, ns-15:ns)));
            energyOut(ns+k) = sum(abs(sigin(rdID, ns+1:ns+16)).^2);
        end
        if k==1
            avgCrosscorr(1) = abs(crosscorrSTF);
            continue;
        end
        avgCrosscorr(k) = af*abs(crosscorrSTF) + (1-af)*avgCrosscorr(k-1);
    end
	if DEBUG_OUT 
		tp = max(abs(crosscorrOut(end-160:end)));
		crosscorrOut(end-160:end) = crosscorrOut(end-160:end)...
				* abs(selfcorrPeak)/tp;
	end
    peakPos = 0;
    for k=2:psamples %
        if (avgCrosscorr(k) > maxSTFcrossCorrPeak*0.8 &&...
           avgCrosscorr(k) > avgCrosscorr(k-1) && ... 
           (k<3||avgCrosscorr(k) > avgCrosscorr(k-2)) && ... 
           (k<4||avgCrosscorr(k) > avgCrosscorr(k-3)) &&...
           (k<6||avgCrosscorr(k) > avgCrosscorr(k-5)) &&...
           (k>psamples-1 || avgCrosscorr(k) > avgCrosscorr(k+1)) &&...
           (k>psamples-2 || avgCrosscorr(k) > avgCrosscorr(k+2)) &&...
           (k>psamples-3 || avgCrosscorr(k) > avgCrosscorr(k+3)) &&...
           (k>psamples-5 || avgCrosscorr(k) > avgCrosscorr(k+5)))
        %if (avgCrosscorr(k) > maxSTFcrossCorrPeak*0.7 &&...
        %   avgCrosscorr(k) > avgCrosscorr(k-1) && ... 
        %   avgCrosscorr(k) > avgCrosscorr(k+1))
         
            numPeak = numPeak + 1;
            peakPos = k;
            if DEBUG_OUT
            fprintf(1, 'peak at %d, avgCrosscorr=%g\n', ...
                    ns+k, avgCrosscorr(k));
            end
        end

        if k-peakPos > 18 % no more peaks
            if DEBUG_OUT
                fprintf(1, 'No more peaks at %d\n', ns+k);
            end
            break;
        end
		 
        % End of STF: self-corr ends
        tempselfcorr = sum(sigin(rdID, ns+k+1:ns+k+16).*conj(sigin(rdID, ns+k-15:ns+k)));
        tempselfcorr = abs(tempselfcorr);
        tempEng = sum(abs(sigin(rdID, ns+k+1:ns+k+16)).^2);
        if (tempselfcorr/tempEng>corr2Engthresh && ...
            tempselfcorr/tempEng<1/corr2Engthresh )
            selfcorrQ(end+1) = 1;
        else
            selfcorrQ(end+1) = 0;
        end
        selfcorrQ(1) = [];

        if (sum(selfcorrQ(end-15:end))/16 < selfcorrQthresh)
			if DEBUG_OUT
                fprintf(fout, 'selfcorr fail. End of STF at %d\n', ns+k);
            end
			endSTF = ns + k;
			break; 
		end
		%{
		energy1 = sum(abs(sigin(rdID, ns+k-1:ns+k-1+16)).^2);
    	energy2 = sum(abs(sigin(rdID, ns+k:ns+k+16)).^2);
		if( ns+k>270 && (energy1/selfcorrPeak < corr2Engthresh || energy1/selfcorrPeak > 1/corr2Engthresh) &&(energy2/selfcorrPeak < corr2Engthresh || energy2/selfcorrPeak > 1/corr2Engthresh))
		     if DEBUG_OUT
                fprintf(fout, 'selfcorr fail. End of STF at %d\n', ns+k);
             end
			 endSTF = ns + k;
			 break;
 		end 
		%}
        % ---- Decision: self-correlation and energy detection ----
        if (ns+k-firstSTFpos > length(STF_10))
            if DEBUG_OUT
                fprintf(fout, 'End of STF at %d\n', ns+k);
            end
            endSTF = ns+k;
            break;
        end
    end %end for k=2:psamples

	% reset
	SNRQ = zeros(SNRQsize,1);
    selfcorrQ = zeros(selfcorrQsize,1); 

    fprintf(1, 'numpeak %d\n', numPeak);
	if (numPeak < 4) continue; end
    ns = ns + peakPos + 16;
	 
     
    % ========= Packet detected, continue to decode ==========
    numPkt = numPkt + 1;
    noisefloor = mean(smsEngQ(1:10));
    fprintf(fout, 'Detect at %d \n', ns);
%    if DEBUG_OUT
%    for t = 1:16
%        selfcorrOut(ns) = sum(sigin(ns+1:ns+16).*conj(sigin(ns-15:ns)));
%        energyOut(ns) = sum(abs(sigin(ns+1:ns+16)).^2);
%        ns = ns + 1;
%    end
%    end

    % --------------- LTF channel estimate ----------------
    % Get the exact position of LTF via crosscorr
	for t = ns-16:ns+63
    %for t = ns:ns+160
    %for t = ns-80:ns+80
        crosscorrLTF(t) = abs(sum(sigin(rdID, t+1:t+64).*conj(LTF_t(1:64))));
        %crosscorrLTF(t) = abs(sum(sigin(rdID, t+1:t+128).*conj(repmat(LTF_t(1:64),1,2))));
        %crosscorrLTF(t) = abs(sum(sigin(rdID, t+1:t+160).*conj(LTF_t160)));
    end

    % Find the largest peak
    %{
    LTFpeakPos = ns + 32; % initialize
    for t0 = ns:ns+80-6
       
        if (crosscorrLTF(t) > mean(crosscorrLTF(ns:ns+160)) && ...
            crosscorrLTF(t) >  crosscorrLTF(t-1) && ...
            crosscorrLTF(t) >  crosscorrLTF(t-2) && ...
            crosscorrLTF(t) >  1.1*crosscorrLTF(t-3) && ...
            crosscorrLTF(t) >  1.1*crosscorrLTF(t-4) && ...
            crosscorrLTF(t) >  1.1*crosscorrLTF(t-5) && ...
            crosscorrLTF(t) >  crosscorrLTF(t+1) && ...
            crosscorrLTF(t) >  crosscorrLTF(t+2) && ...
            crosscorrLTF(t) >  1.1*crosscorrLTF(t+3) && ...
            crosscorrLTF(t) >  1.1*crosscorrLTF(t+4) && ...
            crosscorrLTF(t) >  1.1*crosscorrLTF(t+5)...
           )
       
        LTFpeakPos = t;
        break;
        end
    end
    %}
    %LTFpeakPos = LTFpeakPos-2;
    
    [maxPeak, peakPos] = max(crosscorrLTF(ns-16:ns+63));
    %[maxPeak, peakPos] = max(crosscorrLTF(ns:ns+80));
    %[maxPeak, peakPos] = max(crosscorrLTF(ns-80:ns+80));
    LTFpeakPos = ns-16-1 + peakPos;
    %LTFpeakPos = ns-33 + peakPos;
	 
    %st = ns; % the last sample in STF (near ltf) 
    st = LTFpeakPos - 32;
    %st = LTFpeakPos;
    fprintf(1, 'LTFpeakPos = %d\n', LTFpeakPos);
    fprintf(fout1, 'LTFpeakPos = %d\n', LTFpeakPos);
    if numPkt == 1
        firstPktsample = ns;
    end
    
    %Estimate freq offset
    %st = 180;
    fftoffset = 0;
    op = 32-fftoffset;
    co = sum(sigin(rdID, (st+op+1):(st+op+64)).*conj(sigin(rdID, (st+op+65):(st+op+65+63))));
    %iFreq = atan(imag(co)/real(co))/64;
    iFreq = angle(co)/64;
    fprintf(fout, '=== angle: %f \n', iFreq);
    if FREQ_COMPEN == 0 iFreq = 0; end

    % --- Estimate the channel from each tx antenna to each rx antenna --- 
    for atnt = 1:numTxAntenna
    for atn = 1:numRxAntenna
    % --- freq compensation ---
    delTheta = iFreq;
    for k = 1:64
        e0(k) = sigin(atn, st + op + (atnt-1)*160 + k);
        e0(k) = e0(k) * exp(j*delTheta*((atnt-1)*160 + k-1));
    end

    % --- estimate channel of each subcarrier
    ltffft = fft(e0, 64);
    for k = 2:64
        if (k > 27 && k < 64-25)
            continue;
        end
        % --- Rx antenna atn, subcarrier k ---
        ltfch(atn, atnt, k) = ltffft(k)/LTF_shift(k)/LTFscale;
    end
     
    % ---- Least square estimation (LSE) of residual freq offset
    %{
    pha = [angle(ltfch(64-14:64)) angle(ltfch(2:15))];
    for xx = 1:15 x(xx) = xx; end
    for xx = 16:length(pha) x(xx) = xx+1; end
    cv = cov(x, pha, 1);
    a = cv(1,end) / var(x);
    %b = mean(pha) - a * mean(x);
    %fprintf(1, 'a11=%g b11=%g\n', a11, b11);
    %plot(x,a11*x+b11,'-y', 'LineWidth', 4);
    %x1 = 1:len;
    %po(:,1) = pha(:,1) - (a*x1'+b);
    %}
	 
	
	%{
    x = 2:21;
    pha = squeeze(unwrap(angle(ltfch(atn, atnt, x))));
    %pha = pha.';
    cv = cov(x, pha, 1);
    a1 = cv(1,end) / var(x);
    x = 64-21:64;
    pha = squeeze(unwrap(angle(ltfch(atn, atnt, x)))); 
    cv = cov(x, pha, 1);
    a2 = cv(1,end) / var(x);
    a = (a1+a2)/2;
    %a = a2;
    %b = mean(pha) - a * mean(x);

    if LSE_COMPEN
	for k=1:32
        ltfch(atn, atnt, k) = ltfch(atn, atnt, k)*exp(-j*a*(k+32));% k+32
    end
    for k=33:64
        ltfch(atn, atnt, k) = ltfch(atn, atnt, k)*exp(-j*a*(k-32));%k-32
    end
    end
	%}
    
	x = 2:21;
	y = squeeze(unwrap(angle(ltfch(atn, atnt, x))));
	ft1 = polyfit(x.',y,1);
	%{
	sumadd = 0;
	if (ft1(1)>0)
		for k=2:length(y)
			if (y(k-1)-y(k) > 0.5*pi)
				sumadd = sumadd + 2*pi;
			end
		y(k) = y(k) + sumadd;
		end
	else
		for k=2:length(y)
			if (y(k-1)-y(k) < 0.5*pi)
				sumadd = sumadd - 2*pi;
			end
		y(k) = y(k) + sumadd;
		end
	end
	ft1 = polyfit(x.',y,1);
	%}
	x1 = 64-21:64;
	y1 = squeeze(unwrap(angle(ltfch(atn, atnt, x1))));
	ft2 = polyfit(x1.',y1,1); 
	%{
	sumadd = 0;
	if (ft2(1)>0)
		for k=2:length(y)
			if (y1(k-1)-y1(k) > 0.5*pi)
				sumadd = sumadd + 2*pi;
			end
		y1(k) = y1(k) + sumadd;
		end
	else
		for k=2:length(y)
			if (y1(k-1)-y1(k) < 0.5*pi)
				sumadd = sumadd - 2*pi;
			end
		y1(k) = y1(k) + sumadd;
		end
	end 
	ft2 = polyfit(x1.',y1,1); 
	%}
	if (LSE_COMPEN == 1)
	figure(306);
	subplot(1,2,1);
	plot(1:64, squeeze(unwrap(angle(ltfch(atn, atnt, :)))), '-o');
	title('Before LSE compen');
    for k=1:32
        ltfch(atn, atnt, k) = ltfch(atn, atnt, k)*exp(-j*ft1(1)*(k+32));% k+32
    end
    for k=33:64
        ltfch(atn, atnt, k) = ltfch(atn, atnt, k)*exp(-j*ft2(1)*(k-32));%k-32
    end
	subplot(1,2,2);
	plot(1:64, squeeze(unwrap(angle(ltfch(atn, atnt, :)))), '-x');
	title('After LSE compen');
	end
	figure(211);
    plot(real(squeeze(ltfch(1,1,:))), imag(squeeze(ltfch(1,1,:))), '+r', ...
        'LineWidth', 2, 'MarkerSize', 10);
    stt = sprintf('LTF channel gain rx node %d', rxID);
    title(stt); 
     
	%if (atn==1 && atnt==2)
			%fprintf(1, 'ft1=%f ft2=%f ft1=%f ft2=%f\n', a1, a2, ft1(1), ft2(1));
    %        figure(303);
    %        plot(x, y, '-bo', x, ft1(1)*x+ft1(2),'-rx');
	%end
	fprintf(1, 'LSE a1=%f, a2=%f\n', ft1(1), ft2(1));

    % ------------- Decode OFDM data symbols ----------------
    % TODO..
    %totalSymb = pktSize_Bits/numBitsInSymb;
    %nsymbol = 0;
    end %end for atn = 1:numRxAntenna

    if DEBUG_OUT
			for t = 1:160
                if (ns+64 > length(sigin(atn,:))) break; end
				selfcorrOut(ns) = sum(sigin(rdID, ns+1:ns+16).*conj(sigin(rdID, ns-15:ns)));
				energyOut(ns) = sum(abs(sigin(rdID, ns+1:ns+16)).^2);
				%crosscorrOut(ns) = sum(sigin(rdID, ns+1:ns+16).*conj(STF_t(2:17)));
				crosscorrOut(ns) = abs(sum(sigin(rdID, ns+1:ns+64).*conj(LTF_t(1:64))));
				%crosscorrOut(ns) = sum(sigin(rdID, ns+1:ns+160).*conj(LTF_t160));
				ns = ns + 1;
			end
	else 
				ns = ns + 160; 
	end
		tp = max(abs(crosscorrOut(end-160:end)));
		crosscorrOut(end-160:end) = crosscorrOut(end-160:end)...
				* abs(selfcorrPeak) / tp;
    end %end for atnt = 1:numTxAntenna 

    % ------- end decoding OFDM data symbols ---------
    if (numPkt == 6) %test
        %break;
    end
%end % end while ns < siglen


%% ============= Visualize the results ==============
figure(200);
%plot(1:length(crosscorrOut), abs(crosscorrOut), '-^');
plot(1:length(selfcorrOut), abs(selfcorrOut), '-rx', ...
    1:length(energyOut), energyOut, '-bo', ...
    1:length(crosscorrOut), ...
    abs(crosscorrOut)/max(abs(crosscorrOut))*max(energyOut), '-g^', ...
    'LineWidth', 2);


%figure(102);
%plot(real(ltfch), imag(ltfch), 'x', 'LineWidth', 2);
%hold on;
%for k=1:length(ltfch);
%    text(real(ltfch(k)), imag(ltfch(k)), int2str(k));
%    hold on;
%end
%title('Channel gain (real, imag) of each subcarrier');
%hold off;

if numPkt == 0
    %return;
end




centerFreq = 2.478e9;
% ------------ Plot phase --------
for tx = 1:numTxAntenna
for rx = 1:numRxAntenna   
    tp = [squeeze(ltfch(rx,tx,33:64)).' 0 squeeze(ltfch(rx,tx,2:32)).'];
    ag(rx,tx,:) = angle(tp);
end
end

for tx = 1:numTxAntenna
for rx = 1:numRxAntenna
	%dag(rx,tx,:) = unwrap(ag(rx,tx,:))*180/pi;
	
    %if rx == 1 dag(rx,tx,:) = unwrap(ag(rx,tx,:))*180/pi; continue; end
    if(rx==rdID&&tx==1) dag(rx,tx,:) = unwrap(ag(rx,tx,:))*180/pi; continue; end
    dag(rx,tx,:) = ag(rx,tx,:) - ag(1,1,:);
    dag(rx,tx,:) = unwrap(dag(rx,tx,:))*180/pi;
	
end
end

x=1:64;
xf = centerFreq - (x-32)*40e6/osamp/64;
figure(206);
ct = 0;
for tx = 1:numTxAntenna
    if (tx == ceil(numTxAntenna/2)+1)
        %hold off;
        figure(207);
        ct = 0;
    end 
    for rx = 1:numRxAntenna
        ct = ct + 1;
        subplot(numRxAntenna, numTxAntenna, ct);
        plot(xf, squeeze(dag(rx,tx,:)), '-x', 'LineWidth', 2, 'MarkerSize', 10);
        if rx==1
            tstr = sprintf('Rx%d Tx%d phase', rx, tx);
        else
            tstr = sprintf('Rx%d Tx%d relative phase', rx, tx);
        end
        title(tstr);
    end
    %hold on;
end
%hold off;


% ------------ Plot amplitude --------
for k=1:33
    xf(k) = centerFreq + (k-1)*40e6/osamp/64;
end
for k=34:64
    xf(k) = centerFreq - (65-k)*40e6/osamp/64;
end

%{
figure(204);
ct = 0;
for tx = 1:numTxAntenna
    if (tx == numTxAntenna/2+1)
        %hold off;
        figure(205);
        ct = 0;
    end
    for rx = 1:numRxAntenna
        ct = ct + 1;
        subplot(numRxAntenna, numTxAntenna, ct);
        plot(xf, squeeze(abs(ltfch(rx,tx,:))), '-x', ...
            'LineWidth', 2, 'MarkerSize', 10);
        tstr = sprintf('Rx%d Tx%d amplitude', rx, tx);
        title(tstr);
        ylabel('Magnitude');
        %hold on;
    end
end
%hold off;
%}

% ---- store channel gain of one subcarrier over time ------

ooPhase(numPkt, :) = reshape(dag(:,:,oSubc), 1, numTxAntenna*numRxAntenna);
oPhase(numPkt) = dag(rdID,1,oSubc);
ooMag(numPkt, :) = reshape(abs(ltfch(:,:,oSubc)), 1, numTxAntenna*numRxAntenna);
oMag(numPkt) = abs(ltfch(rdID,1,oSubc));

%pause(3);
pause;
end % end while ns < siglen

if figureOut
figure(200);
plot(1:length(selfcorrOut), abs(selfcorrOut), '-rx', ...
    1:length(energyOut), energyOut, '-bo', ...
    1:length(crosscorrOut), ...
    abs(crosscorrOut)/max(abs(crosscorrOut))*max(energyOut), '-g^', ...
    'LineWidth', 2);
end
%abs(crosscorrOut)/2, '-g^', ...
    
if (oMag)
    for k=1:length(oPhase)
       if oPhase(k) < 0
           oPhase(k) = oPhase(k) + 360;
       end
    end
%{
figure(208);
subplot(1,2,1);
plot(oMag, '-bx', 'LineWidth', 2);
title('Magnitude');
subplot(1,2,2);
plot(oPhase, '-ro', 'LineWidth', 2);
title('Phase');
%}

fname = sprintf('OFDM_trace_amp_r%d_t%d.txt', rxID,txID);
fda = fopen(fname, 'w');
fname = sprintf('OFDM_trace_phs_r%d_t%d.txt', rxID,txID);
fdp = fopen(fname, 'w');
for k=1:length(ooMag(:,1))
	fprintf(fda, '%g ', ooMag(k,:));
	fprintf(fda, '\n');
	fprintf(fdp, '%g ', ooPhase(k,:));
	fprintf(fdp, '\n'); 
end
fclose(fda);
fclose(fdp);
end % end if(oMag)

fclose(fout1);
