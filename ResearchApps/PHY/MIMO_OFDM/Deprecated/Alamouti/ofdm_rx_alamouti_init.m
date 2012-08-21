%Make sure the Tx init has already been loaded
ofdm_tx_alamouti_init;

Symbol_Timing_Offset = 8; %16 = no offset
PktDet_Delay = 26 + Symbol_Timing_Offset*2^7 + 4*2^16; %PkyDetDly + SymbomTiming + CFOTimingDly

%rx_SISO_Mode = tx_SISO_Mode;
rx_SISO_Mode = 0;

%Long correlation parameters
rx_longCorrThresh = 3000;%3000;
rx_longCorrCountLoad = 251-16;%235;

%Load the packet timing control file
ofdm_rx_init_packetTimingControl;

%Packet detection threshold
pkt_crossCorr_thresh = 0.7;
pkt_energy_thresh = 0;

%define INIT_B_KIVAL 0x2500
%define INIT_B_KPVAL 0xD0000
freqOffset_track_filtCoef_i = hex2dec('2500')/2^32;
freqOffset_track_filtCoef_p = hex2dec('D0000')/2^32;

%define INIT_A_KPVAL 0//0x7FFFFFFF//0xA6800
freqOffset_track_filtCoef_A_p = 0;
%freqOffset_track_filtCoef_A_k = 0;
%freqOffset_track_filtCoef_k = 0*1.8e-3;

freqOffset_coarse_filtCoef_i = 0e-4;
freqOffset_coarse_filtCoef_p = 0e-3;

%define INIT_PN_KVAL 0x2700000//xFFFFFFFF
%define INIT_PN_KAlphaVAL 0x40000000
%define INIT_PN_KBetaVAL 0x40000000
%define INIT_PN_KGammaVAL 0x40000000
Rx_PhaseNoiseTrack_Kalpha = 0.5;
Rx_PhaseNoiseTrack_Kbeta = 0.5;
Rx_PhaseNoiseTrack_Kgamma = 0.5;
Rx_PhaseNoiseTrack_K = hex2dec('2700000')*2^-26;

Rx_CoarseCFO_Kalpha = 0.1;
Rx_CoarseCFO_Kbeta = 0.5;
Rx_CoarseCFO_Kgamma = 0.5;
Rx_CoarseCFO_K = 0.00231213872832;


%Initialization values for the long correlator
% The correlator only stores the signs of the values in a long trainin symbol
% This code and the correlator block were designed by Dr. Chris Dick

%Shift the correlation pattern by 16 to allow the calculation
% to finish in time to decide the beginning of the payload
%L = [longSymbol_time(50:64) longSymbol_time(1:49)];
L = [longSymbol_time];

ccr = -1*sign(real(fliplr(L)));
ccr = [ccr 0];
ii = find(ccr==0);
ccr(ii)=1;

cci = 1*sign(fliplr(imag(L)));
cci = [cci 0];
ii=find(cci==0);
cci(ii)=1;

ii = find(ccr==-1);
hr = zeros(1,length(ccr));
hr(ii) = 1;

ii = find(cci==-1);
hi = zeros(1,length(cci));
hi(ii) = 1;

long_cor_acc_n_bits = 4;
Tr1 = 1/4;


%Demodulator input precision
symbol_unmap_bp= 15;
symbol_unmap_nb= 16;

%Popluate the RxControlBits register
% Each bit has a different function
%0x1:	1: Reset BER
%0x2:	2: Require long correlation for pkt detection
%0x4:	4: Enable dynamic packet lengths
%0x8:	8: Enable simple dynamic modulation
%0x10:	16: Force Rx antenna B (no div switching)
%0x20:	32: Require 2 long correlations for pkt detection
%0x40:	64: Require short correlation or ext pkt detection
%0x80:	128: External pkt detection
%0x100:	256: Internal Pkt Detection
%0x200:	512: bypass CFO correction
%0x400:	1024: Use LTS for CFO
%0x800:	2048: Use STS for CFO
%0x1000:4096: Use LongCorr for CFO reset
%0x2000:8192: Use real arctan for pilot phase calc
%0x4000:16384: Use diff instead of integral in CFO loop filt
%0x8000:32768: Repeat CFO during training symbols
%0x10000:65536: Enable switching diversity
%0x20000:131072: Enable quad long-corr thresh checking 
%0x40000:262144: Enable new coarse CFO calc
%0x80000:524288: Enable Rx reset on bad header CRC

rx_controlBits = 1 * 2 ... %Long correlation
		 + 1 * 4 ... %Dyn pkt lengths
		 + 1 * 8  ...%1=enable simple dynamic mod
		 + 0 * 16 ...%1=force Rx on antB
		 + 1 * 32 ... %2 long correlations
		 + 0 * 64 ... %short correlation
		 + 0 * 128 ... %ext pkt det
		 + 1 * 256 ... %int pkt det
		 + 0 * 512 ... %bypass CFO
		 + 0 * 1024 ... %LTS for CFO
		 + 0 * 2048 ... %STS for CFO
		 + 1 * 4096 ... %Long correlation for CFO
		 + 1 * 8192 ... %Real arctan for CFO
		 + 0 * 16384 ... %Diff in CFO loop filt
		 + 0 * 32768 ... %Use training for CFO
		 + 0 * 65536 ... %Use switching diversity
		 + 1 * 131072 ...%Use quad long corr thresh
		 + 1 * 262144 ... %1=Use newer coarse CFO calc
		 + 1 * 524288;    %1=Reset Rx PHY on header CRC failure

%Most-equalization scaling
%This value is used to scale the equalizer's output before demodulation
%This is used to correct for any fixed gain/attenuation the full system has
% The value shouldn't be channel or modulation dependent
rxScaling = 1;

% This scaling value resides in a UFix_32_0 register
%  The value is split into two 16 bit values, then
%   each is re-interpreted as a UFix_16_11
rx_postEq_scaling = round(rxScaling*2^11) * (1 + 2^16); 
