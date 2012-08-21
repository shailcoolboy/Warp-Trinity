%Make sure the Tx init has already been loaded
ofdm_tx_supermimo_init;

%Do not use 16! Breaks Alamouti Rx timing
%Symbol_Timing_Offset = 15; %Use for no cyclic shift offset w/ antB preamble enabled, countLoad=229

%Symbol_Timing_Offset = 12; %Use for no cyclic shift offset w/ SISO, antB channel disabled, countLoad=229
Symbol_Timing_Offset = 10;

PktDet_Delay = 58+32 + ... %UFix7_0 packet detect delay
    Symbol_Timing_Offset*2^7 + ... %UFix6_0 FFT window offset
    0*2^16 + ... %UFix5_0 CFO calc delay, in samples
    (117* 2^24); %UFix8_8 threshold
%    (round(0.15 * 2^8)* 2^24); %UFix8_8 threshold

pktByteNums =	numHeaderBytes + ...
				byteIndex_numPayloadBytes(1)*2^8 + ...
				byteIndex_numPayloadBytes(2)*2^16 + ...
				byteIndex_simpleDynModMasks * 2^24;

rx_SISO_Mode = tx_SISO_Mode;

pktTiming_controlCounter_bits = 16;

%Structure of packet following detection
%Short symbols
pktTiming_ss_num = 6;
pktTiming_ss_length = length(shortSymbol_time);
%Long symbols
pktTiming_ls_num = 2;
pktTiming_ls_length = length(longSymbol_time);
%Long symbol cyclic prefix
pktTiming_lscp_length = 32;

pktTiming_count_ssStart = 0;
pktTiming_count_lscpStart = (pktTiming_count_ssStart + pktTiming_ss_num*pktTiming_ss_length);
pktTiming_count_lsStart = (pktTiming_count_lscpStart + pktTiming_lscp_length);
pktTiming_count_payloadStart = pktTiming_count_lsStart + pktTiming_ls_num*pktTiming_ls_length;

%Packet detection threshold
pkt_crossCorr_thresh = 0.7;
pkt_energy_thresh = 0;

rxReg_pktDetCorr = ...
	2^00 * (floor(0.7*128)) + ...	%min correlation/power ratio (UFix8_7)
	2^08 * (300) + ...				%min power
	0;

%In alamouti mode, the Rx syncs to the earlier preamble
%LongCorrCounterLoad = 229;
%LongCorrCounterLoad = 232;
LongCorrCounterLoad = 253-8;%234;

Rx_PktDet_LongCorrThresholds = 8000;

Rx_PktDet_LongCorr_Params = LongCorrCounterLoad + 0*2^8 + 0*2^16 + 255*2^24;

%Interrupt control register has 8 bits:
%0: Rx Pkt Interrupts Reset
%1: Rx Header Interrupts Reset
%2: Tx Done Interrupt Reset
%3: Rx Good Pkt Interrupt Enable
%4: Rx Bad Pkt Interrupt Enable
%5: Rx Good Header Interrupt Enable
%6: Rx Bad Header Interrupt Enable
%7: Tx Done Interrupt Enable
reg_InterruptControl = ...
	0 + ...  %3 bits [RxPkt, RxHeader, TxDone] interrupt resets
	0*15 * 2^3 + ... %4 bits[LSB:MSB]=[goodPkt, badPkt, goodHdr, badHdr] interrupt enables
	0 * 2^7; %1 bit for TxDone enable

%32-bit register holds both pkt buffer offsets (16LSB+8) and interrupt control (8LSB)
reg_Interrupt_PktBuf_Control = ...
	reg_InterruptControl + ...
	1 * 2^16 + ... %6 bits for Tx pkt buff offset
	0 * 2^24; %6 bits for Rx pkt buff offset

minPilotChanMag = (0.01 * 2^12); %UFix12_12
reg_PilotCalcParams = (4 * 2^16) + (minPilotChanMag);

regRx_preCFOoptions = ...
	0 * 2^0 + ... %Use coarse CFO estimate
	1 * 2^1 + ... %Use pilot CFO estimate
	0;

regRx_pilotCalcCorrection = round(1.00115 * 2^31);
regRx_coarseCalcCorrection = round((1.3e-3 - 1.2982e-3)*2^32);
%Initialization values for the long correlator
% The correlator only stores the signs of the values in a long trainin symbol
% This code and the correlator block were designed by Dr. Chris Dick

%Fix2_0 version of longSym
longCorr_coef_nbits = 3;
longCorr_coef_bp = 0;
LTS = fliplr(longSymbol_time./max(abs(longSymbol_time)));

%longCorr_coef_i = [-1*sign(real(fliplr(LTS))) 0];
%longCorr_coef_q = [sign(imag(fliplr(LTS))) 0];

longCorr_coef_i = [-4*real(LTS) 0];
longCorr_coef_q = [4*imag(LTS) 0];
ii = find(longCorr_coef_i < -3.5);
longCorr_coef_i(ii) = -3;
ii = find(longCorr_coef_q < -3.5);
longCorr_coef_q(ii) = -3;

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

long_cor_acc_n_bits = 6;
%long_cor_acc_n_bits = 4;
Tr1 = 1/4;

%Demodulator input precision
symbol_unmap_bp= 15;
symbol_unmap_nb= 16;

RxReg_FixedPktLen = 0;%2^32 + 512;

%Popluate the RxControlBits register
% Each bit has a different function
%0x1:	1: Reset BER
%0x2:	2: Require long correlation for pkt detection
%0x4:	4: Enable dynamic packet lengths
%0x8:	8: Big sub-pkt buffer mode (16KB max pkt size)
%0x10:	16: Enable SISO mode
%0x20:	32: Require 2 long correlations for pkt detection
%0x40:	64: Require short correlation or ext pkt detection
%0x80:	128: Record channel estimates
%0x100:	256: Record channel estimate magnitudes
%0x200:	512: bypass CFO correction
%0x400:	1024: Enable coarse CFO estimation
%0x800:	2048: CFO debug output selection
%0x1000:4096: Compensate for RF gain in RSSI input
%0x4000:16384: Bypass division during EQ
%0x8000:32768: Disable Rx PHY on Tx (not useful for simulation!)
%0x1_0000:65536: Enable simple dynamic modulation
%0x2_0000:131072: Enable switching diversity
%0x4_0000:262144: Use antenna B in SISO mode
%0x8_0000:524288: Enable Rx reset on bad header CRC
%0x10_0000: 1048576: Enable Rx Alamouti mode
%0x20_0000: 2097152: Enable flexBER mode
%0x40_0000: 4194304: Ignore headers for BER
%0x80_0000: 8388608: Per-packet BER reset
%0x100_0000: 16777216: Force-enable radio RxEn
%0x200_0000: 33554432: SaveAF waveform
%0x400_0000: Reset autoResponse flagA
%0x800_0000: Reset autoResponse flagB
%0x2000_0000: 536870912: Enable channel magnitude masking (only useful in Alamouti mode)
%0x8000_0000: 2147483648: Global Rx reset

rx_controlBits = 1 * 2 ... %Long correlation
		 + 1 * 4 ... %Dyn pkt lengths
		 + 0 * 8 ... %1=big sub-pkt buffers
		 + 1 * 16 * rx_SISO_Mode ...
		 + 1 * 32 ... %2 long correlations
		 + 1 * 64 ... %short correlation
		 + 1 * 128 ... %record channel estimates
		 + 1 * 256 ... %record channel estimate mags
		 + 1 * 512 ... %bypass CFO%%%%%%%%%%%%
		 + 1 * 1024 ... %1=Enable coarse CFO estimation
		 + 1 * 4096 ... %Compensate for RFgain in RSSI input
		 + 0 * 16384 ... %1=Bypass EQ division
		 + 0 * 32768 ... %0=Don't disable Rx during Tx
		 + 1 * 65536 ... %1=Use simple dynamic modulation
		 + 0 * 131072 ... %1=Use switching diversity in SISO mode
		 + 0 * 262144 ... %1=force AntB in SISO mode
		 + 1 * 524288 ... %1=Reset Rx on bad header
		 + 1 * 1048576 * tx_Alamouti_Mode ...
		 + 0 * 2097152 ... %1=flex BER mode
         + 1 * 33554432 ... %1=Save AF waveform
		 + 0 * 4194304 ... %1=ignore headers (and header-only packets) for BER calculation
		 + 0 * 8388608 ... %1=Per-packet BER reset
		 + 0 * 16777216 ... %Don't force RxEn in simulation (used in hardware though)
		 + 1 * 536870912 * tx_Alamouti_Mode ... %Enables chan mag checking/masking
		 + 0 * 2147483648; %Global Rx reset
	 
	 
%Min chan est magnitudes (Two UFix16_15 values, re-interpreted as UFix16_0)
regRx_chanEst_minMag = ((0.5)*2^15) + ((0.5 * 2^15)*2^16);

%Post-equalization scaling
%This value is used to scale the equalizer's output before demodulation
%This is used to correct for any fixed gain/attenuation the full system has
% The value shouldn't be channel or modulation dependent
% It does depend on the number of training symbols (1/training)
if(tx_SISO_Mode)
	rxScaling = 2;
else
	rxScaling = 1;
end

%AF scaling; UFix18_12
reg_AF_Tx_Scaling = 2944;%2 * 2^12;

reg_AF_Tx_Blanking = (320+80) + ( (320+80+79)*2^16);

% This scaling value resides in a UFix_32_0 register
%  The value is split into two 16 bit values, then
%   each is re-interpreted as a UFix_16_11
rx_postEq_scaling = round(rxScaling*2^11) * (1 + 2^16);
%mod((rxScaling*2^11),2^16) + (2^16 * mod((rxScaling*2^11),2^16));

%Load Chipscope capture data
AntA_ADC_I = 0;AntA_ADC_Q = 0; csInterp = 1; t_start = 1; t_stop = 1;%2260;
%xlLoadChipScopeData('cs_capts\v15_19_1_badPkt_v0.prn'); csInterp = 1; t_start = 392;

rxAntI.time = [];
rxAntQ.time = [];
rxAntI.signals.values = AntA_ADC_I(t_start:csInterp:end);
rxAntQ.signals.values = AntA_ADC_Q(t_start:csInterp:end);
if(length(AntA_ADC_I) > 1)
    simOnly_simLength = 1000 + 4*(length(AntA_ADC_I) - t_start);
end

