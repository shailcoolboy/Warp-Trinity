% OFDM MU-MIMO channel estimation 
% 07/25/2011
% xyzhang
%function output = chEstMultiRx()
clear all;
USESIM = 0;
DEBUG_OUT = 1;
osamp = 8; % Oversampling rate or Number of samples per symbol, 40Mhz/osamp wide band
fout = 1;
RSSthresh = 1e-3;
if USESIM
    osamp = 1;
    skipsamples = 32;
    maxRead = 1000;
    fin = fopen('sim_modulated.dat', 'rb');
else
    skipsamples = 100;
    maxRead = 100000;
    %fin = fopen('insamples_0727outdoor3.dat', 'rb');
    %fin = fopen('insamples.dat', 'rb');
    %fin = fopen('insamples_Node2.dat', 'rb');
    fin = fopen('C:\Users\xyzhang\Desktop\insamples_flat3.dat', 'rb');
end

numRxAntenna = 4; %floor(length(fin(:,1))/2);
numTxAntenna = 4; 

mt = fread(fin, [numRxAntenna*2, maxRead], 'float32');
fclose(fin);

% Separate antennas; Convert to complex numbers
for a = 1:numRxAntenna
    sigin(a,:) = mt(2*a-1, :) + j*mt(2*a, :);
end

sigLen = length(sigin(1,:));

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
%LTF_time_up2 = interp(LTF_time, osamp); % Upsample by 2 so that
%scale = 1/max([ max(abs(real(LTF_time_up2))), max(abs(imag(LTF_time_up2))) ]);
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
    selfcorr = sum(sigin(1, ns+1:ns+16).*conj(sigin(1, ns-15:ns)));
    energy = sum(abs(sigin(1, ns+1:ns+16)).^2);

    % --- Update smoothed energy level and SNR queue -----
    if (USESIM && abs(sigin(1, ns+1)) == 0)
        sigin(1, ns+1) = 1e-8;
    end
    smsEng = smsEng*(1-1/smsEng_windowSize) + 1/smsEng_windowSize*abs(sigin(1, ns+1))^2;
    smsEngQ(end+1) = smsEng;
    smsEngQ(1) = [];

    if (smsEngQ(1) <= 0)
        SNR = 0;
    else
        SNR = 10*log10(smsEng/smsEngQ(1));
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
    fprintf(fout, '!!! Self-corr peak detected at sample %d\n', ns);
    firstSTFpos = ns;
    SNRQ = zeros(SNRQsize,1);
    selfcorrQ = zeros(selfcorrQsize,1);
	selfcorrPeak = energy;

    % ---- Search for the first peak via cross-corr with STF ----
    af = 1; 
    peakPos = 0; 
    for k = 1:16
        crosscorrSTF = sum(sigin(1, ns+k:ns+k+15).*conj(STF_t(2:17)));
        if DEBUG_OUT 
            crosscorrOut(ns+k) = crosscorrSTF; 
            selfcorrOut(ns+k) = sum(sigin(1, ns+1:ns+16).*conj(sigin(1, ns-15:ns)));
            energyOut(ns+k) = sum(abs(sigin(1, ns+1:ns+16)).^2);
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
        crosscorrSTF = sum(sigin(1, ns+k:ns+k+15).*conj(STF_t(2:17)));
        if DEBUG_OUT 
            crosscorrOut(ns+k) = crosscorrSTF; 
            selfcorrOut(ns+k) = sum(sigin(1, ns+1:ns+16).*conj(sigin(1, ns-15:ns)));
            energyOut(ns+k) = sum(abs(sigin(1, ns+1:ns+16)).^2);
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
        %{
        tempselfcorr = sum(sigin(ns+k+1:ns+k+16).*conj(sigin(ns+k-15:ns+k)));
        tempselfcorr = abs(tempselfcorr);
        tempEng = sum(abs(sigin(ns+k+1:ns+k+16)).^2);
        if (tempselfcorr/tempEng>1/corr2Engthresh && ...
            tempselfcorr/tempEng<corr2Engthresh )
            selfcorrQ(end+1) = 1;
        else
            selfcorrQ(end+1) = 0;
        end
        selfcorrQ(1) = [];

        if (sum(selfcorrQ(end-15:end))/16 < selfcorrQthresh)
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
    fprintf(1, 'numpeak %d\n', numPeak);
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
    for t = ns:ns+80
        %crosscorrLTF(t) = abs(sum(sigin(1, t+1:t+64).*conj(LTF_t(1:64))));
        crosscorrLTF(t) = abs(sum(sigin(1, t+1:t+128).*conj(repmat(LTF_t(1:64),1,2))));
    end
    LTFpeakPos = ns + 32; % initialize
    for t = ns:ns+80-6
        if (crosscorrLTF(t) > mean(crosscorrLTF(ns:ns+80)) && ...
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
    %LTFpeakPos = LTFpeakPos-2;
     
    %st = ns; % the last sample in STF (near ltf) 
    st = LTFpeakPos - 32;
    fprintf(1, 'LTFpeakPos=%d STF last pos %d \n', LTFpeakPos, st);
    if numPkt == 1
        firstPktsample = ns;
    end
    
    %Estimate freq offset
    %st = 180;
    fftoffset = 0;
    op = 32-fftoffset;
    co = sum(sigin(1, (st+op+1):(st+op+64)).*conj(sigin(1, (st+op+65):(st+op+65+63))));
    %iFreq = atan(imag(co)/real(co))/64;
    iFreq = angle(co)/64;
    fprintf(fout, '=== angle: %f \n', iFreq);

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
        ltfch(atn, atnt, k) = ltffft(k)/LTF_shift(k);
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
	for k=1:32
        ltfch(atn, atnt, k) = ltfch(atn, atnt, k)*exp(-j*a*(k+32));% k+32
    end
    for k=33:64
        ltfch(atn, atnt, k) = ltfch(atn, atnt, k)*exp(-j*a*(k-32));%k-32
    end
	
	%{
	x = 2:21;
	y = squeeze(unwrap(angle(ltfch(atn, atnt, x))));
	ft1 = polyfit(x.',y,1);
	x = 64-21:64;
	y = squeeze(unwrap(angle(ltfch(atn, atnt, x))));
	ft2 = polyfit(x.',y,1); 
    for k=1:32
        ltfch(atn, atnt, k) = ltfch(atn, atnt, k)*exp(-j*ft1(1)*(k+32));% k+32
    end
    for k=33:64
        ltfch(atn, atnt, k) = ltfch(atn, atnt, k)*exp(-j*ft2(1)*(k-32));%k-32
    end
	if (atn==1 && atnt==1)
			fprintf(1, 'a1=%f a2=%f ft1=%f ft2=%f\n', a1, a2, ft1(1), ft2(1));
            figure(303);
            plot(x, y, '-o');
	end
	%}

    % ------------- Decode OFDM data symbols ----------------
    % TODO..
    %totalSymb = pktSize_Bits/numBitsInSymb;
    %nsymbol = 0;
    end %end for atn = 1:numRxAntenna

    if DEBUG_OUT
			for t = 1:160
                if (ns+64 > length(sigin(atnt,:))) break; end
				selfcorrOut(ns) = sum(sigin(1, ns+1:ns+16).*conj(sigin(1, ns-15:ns)));
				energyOut(ns) = sum(abs(sigin(1, ns+1:ns+16)).^2);
				%crosscorrOut(ns) = sum(sigin(1, ns+1:ns+16).*conj(STF_t(2:17)));
				crosscorrOut(ns) = sum(sigin(atnt, ns+1:ns+64).*conj(LTF_t(1:64)));
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
        break;
    end
%end % end while ns < siglen


%% ============= Visualize the results ==============
figure(200);
%plot(1:length(crosscorrOut), abs(crosscorrOut), '-^');
plot(1:length(selfcorrOut), abs(selfcorrOut), '-rx', ...
    1:length(energyOut), energyOut, '-bo', ...
    'LineWidth', 2);
%     1:length(crosscorrOut), abs(crosscorrOut)/2, '-g^', 

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
    %if rx == 1 dag(rx,tx,:) = unwrap(ag(rx,tx,:))*180/pi; continue; end
    if(rx==1&&tx==1) dag(rx,tx,:) = unwrap(ag(rx,tx,:))*180/pi; continue; end
    dag(rx,tx,:) = ag(rx,tx,:) - ag(1,1,:);
    dag(rx,tx,:) = unwrap(dag(rx,tx,:))*180/pi;
end
end

x=1:64;
xf = centerFreq - (x-32)*40e6/osamp/64;
figure(206);
ct = 0;
for tx = 1:numTxAntenna
    if (tx == numTxAntenna/2+1)
        %hold off;
        figure(207);
        ct = 0;
    end 
    for rx = 1:numRxAntenna
        ct = ct + 1;
        subplot(numRxAntenna/2, numTxAntenna, ct);
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
        subplot(numRxAntenna/2, numTxAntenna, ct);
        plot(xf, squeeze(abs(ltfch(rx,tx,:))), '-x', ...
            'LineWidth', 2, 'MarkerSize', 10);
        tstr = sprintf('Rx%d Tx%d amplitude', rx, tx);
        title(tstr);
        ylabel('Magnitude');
        %hold on;
    end
end
%hold off;


% ---- store channel gain of one subcarrier over time ------
oSubc = 22;
oPhase(numPkt) = dag(2,1,oSubc);
oMag(numPkt) = abs(ltfch(2,1,oSubc));

%pause(3);
pause;
%end
end

figure(200);
plot(1:length(selfcorrOut), abs(selfcorrOut), '-rx', ...
    1:length(energyOut), energyOut, '-bo', ...
    1:length(crosscorrOut), abs(crosscorrOut)/2, '-g^', ...
    'LineWidth', 2);

if (oMag)
figure(208);
subplot(1,2,1);
plot(oMag, '-bx', 'LineWidth', 2);
title('Magnitude');
subplot(1,2,2);
plot(oPhase, '-ro', 'LineWidth', 2);
title('Phase');
end
