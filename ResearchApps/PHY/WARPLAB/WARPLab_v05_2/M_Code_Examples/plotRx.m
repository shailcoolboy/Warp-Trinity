% OFDM MU-MIMO channel estimation 
% 07/25/2011
% xyzhang
%function output = chEstMultiRx()
clear all;
USESIM = 1;
DEBUG_OUT = 1;
osamp = 8; % Oversampling rate or Number of samples per symbol, 40Mhz/osamp wide band
fout = 1;
RSSthresh = 1e-3;
txID=1;
rxID=1;
numRxAntenna = 1; %floor(length(fin(:,1))/2);
numTxAntenna = 4; 

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
    %fin = fopen('C:\Users\xyzhang\Desktop\insamples_flat3.dat', 'rb');
    fin = fopen('OFDMsamples_a1_r1_t1.dat', 'rb');
end



%{
mt = fread(fin, [numRxAntenna*2, maxRead], 'float32');
fclose(fin);

% Separate antennas; Convert to complex numbers
for a = 1:numRxAntenna
    sigin(a,:) = mt(2*a-1, :) + j*mt(2*a, :);
end
%}

for rxa = 1:numRxAntenna
    sf = sprintf('OFDMsamples_a%d_r%d_t%d.dat', rxa, rxID, txID);
    %fprintf(1, 'Load file %s\n', sf);
    %[RxData(:,rxa,rxn), RxOTR(:,rxa,rxn)] = warplab_processRawRxData(RawRxData(:,rxa,rxn));
	sff = fopen(sf, 'rb');
	samples = fread(sff, [1 inf], 'uint32');
	fclose(sff);
    [rxData, rxOTR] = warplab_processRawRxData(samples);
	rxData1 = downsample(rxData, osamp);
    sigin(rxa, :) = squeeze(rxData1);
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
    crossCorr = sum(sigin(1, ns+1:ns+16).*conj(STF_t(2:17)));
    crossCorrLTF = abs(sum(sigin(1, ns+1:ns+64).*conj(LTF_t(1:64))));
    
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
        crosscorrOut(ns) = crossCorr;
        crosscorrOutLTF(ns)= crossCorrLTF;
    end
   
	ns = ns + 1;
end % end while < sigLen

%% ============= Visualize the results ==============
figure(500);
set(gca, 'FontSize', 18);
%plot(1:length(crosscorrOut), abs(crosscorrOut), '-^');
plot(1:length(selfcorrOut), abs(selfcorrOut), '-rx', ...
    1:length(energyOut), energyOut, '-bo', ...
    1:length(crosscorrOutLTF), abs(crosscorrOutLTF), '-k>', ...
    'LineWidth', 2);
    %1:length(crosscorrOut), abs(crosscorrOut)/2, '-g^',
    %1:length(crosscorrOutLTF), abs(crosscorrOutLTF), '-k',   
%r = 4500:5150;
%r1 = 4770:5150;
%r2 = 4500:4770;
%plot(r, abs(selfcorrOut(r)), '-rx', ...
%    r, energyOut(r), '-b', ...
%    r2, abs(crosscorrOut(r2))/2, '-g', ...
%    r1, abs(crosscorrOutLTF(r1))/10, '-k', ...
%    'LineWidth', 2);
xlabel('Sample index');

th=1.15;
fo1 = fopen('logplot.txt','w');
for k=1:length(crosscorrOutLTF)
    if (abs(crosscorrOutLTF(k)) > th)
        fprintf(fo1, '%d\n', k);
        %fprintf(1, '%d\n', k);
    end
end
fclose(fo1);
fi1 = load('logplot.txt');
for k = 3:length(fi1)
    df(k) = fi1(k) - fi1(k-2);
end
df=df';
