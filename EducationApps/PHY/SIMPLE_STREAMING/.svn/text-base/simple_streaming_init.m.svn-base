%VIQ AVERAGER
viqAvgLen = 128;




NUM = 35;
viqFilt = fir1(NUM,.1);

upconv_freq = 0.25;
downconv_freq = 0.25+1e-6; %Offset to simulator actual CFO

%LSFR parameters
txLSFR_numBits = 16;
txLSFR_polynomials = {'3921' '8435' '4A0B' '4F1D' '2835' '9A0B'};
txLSFR_initValues = {'3F' '1B' '03' '35' '17' '0A'};

modConstellation_prec = 8;
modConstellation_bp = 7;

%QPSK constellation
%2 bits per symbol, 1 bit per I/Q
% I = MSB, Q = LSB
modConstellation_qpsk = [1 -1]; %[1 -1]
%modConstellation_qpsk = (1-2^-modConstellation_bp).*modConstellation_qpsk./(max(abs(modConstellation_qpsk)));

%16-QAM constellation
%4 bits per symbol, 2 bits per I/Q
% I = 2MSB, Q = 2LSB
modConstellation_qam16 = [1 3 -1 -3];
modConstellation_qam16 = (1-2^-modConstellation_bp).*modConstellation_qam16./(max(abs(modConstellation_qam16)));

%64-QAM constellation
%6 bits per symbol, 3 bits per I/Q
% I = 3MSB, Q = 3LSB
modConstellation_qam64 = [3 1 5 7 -3 -1 -5 -7];
modConstellation_qam64 = (1-2^-modConstellation_bp).*modConstellation_qam64./(max(abs(modConstellation_qam64)));

bndwdth = 1/5500;
theta_0= 2*pi*bndwdth;
eta=sqrt(2)/2;

k_i= (4*theta_0*theta_0)/(1+2*eta*theta_0+theta_0*theta_0);
k_p= (4*eta*theta_0)/(1+2*eta*theta_0+theta_0*theta_0);

carrierRec_filt_K = .5 %01
carrierRec_filt_KP = k_p%g*(4*eta*theta_0)/(1+2*eta*theta_0+theta_0*theta_0);
carrierRec_filt_KI = k_i%g*(4*theta_0*theta_0)/(1+2*eta*theta_0+theta_0*theta_0);


bndwdth = 1/1000;
theta_0= 2*pi*bndwdth;
eta=sqrt(2)/2;

k_i= (4*theta_0*theta_0)/(1+2*eta*theta_0+theta_0*theta_0);
k_p= (4*eta*theta_0)/(1+2*eta*theta_0+theta_0*theta_0);

timingRec_filt_KP = k_p %g*(4*eta*theta_0)/(1+2*eta*theta_0+theta_0*theta_0);
timingRec_filt_KI = k_i %g*(4*theta_0*theta_0)/(1+2*eta*theta_0+theta_0*theta_0);
timingRec_filt_K = 1

mf = rcosfir(.3, 4, 8, 1,'sqrt');
dmf = conv(mf,[-1 0 1]);
dmf = dmf(2:end-1);

symbolRomLen = 2^13;
symbolRom = floor(rand(1,2^13) * 4);

%%%%Register Init%%%%
%Transmitter Setup
dac1Sel = 2;
dac2Sel = 2;
dac3Sel = 0;
txModSel = 1;
temp = fi(upconv_freq,0,32,32);
upConv = str2num(temp.dec);

%Receiver Setup
initialDelay = 0;
cfoReset = 0;
cfoEnable = 1;
cost = 1;
benefit = 1;
temp = fi(carrierRec_filt_K,0,32,25);
cfoK = str2num(temp.dec);
temp = fi(carrierRec_filt_KP,0,32,32);
cfoKP = str2num(temp.dec);
temp = fi(carrierRec_filt_KI,0,32,32);
cfoKI = str2num(temp.dec);
timingReset = 0;
temp = fi(timingRec_filt_K,0,32,29);
timingK = str2num(temp.dec);
temp = fi(timingRec_filt_KP,0,32,32);
timingKP = str2num(temp.dec);
temp = fi(timingRec_filt_KI,0,32,32);
timingKI = str2num(temp.dec);
rxInputSel = 2;
temp = fi(downconv_freq,0,32,32);
downConv = str2num(temp.dec);
%%%%%%%%%%%%%%%%%%%%%

