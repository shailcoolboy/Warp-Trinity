%Make sure the Tx init has already been loaded
ofdm_tx_mimo_init;

Symbol_Timing_Offset = 8; %15 = no offset
PktDet_Delay = 26 + Symbol_Timing_Offset*2^7;


pktByteNums =	numHeaderBytes + ...
				byteIndex_numPayloadBytes(1)*2^8 + ...
				byteIndex_numPayloadBytes(2)*2^16 + ...
				byteIndex_simpleDynModMasks * 2^24;

rx_SISO_Mode = tx_SISO_Mode;

%Load the packet timing control file
ofdm_rx_init_packetTimingControl;

%Packet detection threshold
pkt_crossCorr_thresh = 0.7;
pkt_energy_thresh = 0;


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
	15 * 2^3 + ... %4 bits[LSB:MSB]=[goodPkt, badPkt, goodHdr, badHdr] interrupt enables
	0 * 2^7; %1 bit for TxDone enable

%32-bit register holds both pkt buffer offsets (16LSB+8) and interrupt control (8LSB)
reg_Interrupt_PktBuf_Control = ...
	reg_InterruptControl + ...
	1 * 2^16 + ... %6 bits for Tx pkt buff offset
	0 * 2^24; %6 bits for Rx pkt buff offset
	
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
%0x8:	8: Big sub-pkt buffer mode (16KB max pkt size)
%0x10:	16: Enable SISO mode
%0x20:	32: Require 2 long correlations for pkt detection
%0x40:	64: Require short correlation or ext pkt detection
%0x80:	128: External pkt detection
%0x100:	256: Internal Pkt Detection
%0x200:	512: bypass CFO correction
%0x400:	1024: Enable coarse CFO estimation
%0x800:	2048: Use new coarse CFO calculation
%0x1000:4096: Use LongCorr for CFO reset
%0x2000:8192: Use real arctan for pilot phase calc
%0x4000:16384: Bypass division during EQ

%0x10000:65536: Enable simple dynamic modulation
%0x20000:131072: Enable switching diversity
%0x40000:262144: Use antenna B in SISO mode
%0x80000:524288: Enable Rx reset on bad header CRC

rx_controlBits = 1 * 2 ... %Long correlation
		 + 1 * 4 ... %Dyn pkt lengths
		 + 0 * 8 ... %1=big sub-pkt buffers
		 + 1 * 16 * rx_SISO_Mode ...
		 + 1 * 32 ... %2 long correlations
		 + 1 * 64 ... %short correlation
		 + 0 * 128 ... %ext pkt det
		 + 1 * 256 ... %int pkt det
		 + 0 * 512 ... %bypass CFO
		 + 1 * 1024 ... %1=Enable coarse CFO estimation
		 + 0 * 2048 ... %1=use new coarse CFO calc
		 + 1 * 4096 ... %Long correlation for CFO
		 + 1 * 8192 ... %Real arctan for CFO
		 + 0 * 16384 ... %1=Bypass EQ division
		 + 1 * 65536 ... %1=Use simple dynamic modulation
		 + 1 * 131072 ... %1=Use switching diversity in SISO mode
		 + 0 * 262144 ... %1=force AntB in SISO mode
		 + 1 * 524288;    %1=Reset Rx on bad header

%Post-equalization scaling
%This value is used to scale the equalizer's output before demodulation
%This is used to correct for any fixed gain/attenuation the full system has
% The value shouldn't be channel or modulation dependent
% It does depend on the number of training symbols (1/training)
rxScaling = 2;

% This scaling value resides in a UFix_32_0 register
%  The value is split into two 16 bit values, then
%   each is re-interpreted as a UFix_16_11
rx_postEq_scaling = round(rxScaling*2^11) * (1 + 2^16);
%mod((rxScaling*2^11),2^16) + (2^16 * mod((rxScaling*2^11),2^16));

Rx_PhaseNoiseTrack_Kalpha = 0.5;
Rx_PhaseNoiseTrack_Kbeta = 0.5;
Rx_PhaseNoiseTrack_Kgamma = 0.5;

Rx_PhaseNoiseTrack_K = 0.6094;%hex2dec('2700000')/2^26;
%Rx_PhaseNoiseTrack_K = 0.15;

freqOffset_track_filtCoef_p = hex2dec('d0000')/2^32;
freqOffset_track_filtCoef_i = hex2dec('2500')/2^32;

Rx_CoarseCFO_K = 0.2;

%Load Chipscope capture data
AntA_ADC_I = 0;AntA_ADC_Q = 0; csInterp = 1; t_start = 1;
%xlloadchipScopeData('Y:\RxPkt_v00_QAM16_good.prn'); csInterp = 1; t_start = 350;

rxAntI.time = [];
rxAntQ.time = [];
rxAntI.signals.values = AntA_ADC_I(t_start:csInterp:end);
rxAntQ.signals.values = AntA_ADC_Q(t_start:csInterp:end);


%Packet Detection
avgLen=16;
diffLen=40;
diffMode_diffThresh=4000;
diffMode_avgThresh=2000;
avgMode_avgThresh=4000;
modeSel=1;
successWindow=48;
resetDuration=32;

maxPacketSize = 50000;
histLength = 2048; %512

eventCounterNumBits = 32;


