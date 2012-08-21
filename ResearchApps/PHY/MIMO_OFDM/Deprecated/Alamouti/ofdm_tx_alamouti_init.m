warning off;

%Compile-time maximum values; used to set precision of control logic values
max_OFDM_symbols = 2047;
max_num_subcarriers = 64;
max_CP_length = 16;
max_num_baseRateSymbols = 31;
max_num_trainingSymbols = 15;

%Hard-coded OFDM parameters for now; these might be dynamic some day
numSubcarriers = 64;
CPLength = 16;

%Set SISO mode
%tx_SISO_Mode = 1;
tx_alamouti_mode = 1;

%Cyclic Redundancy Check parameters
CRCPolynomial = hex2dec('04c11db7');
CRC_Table = CRC_table_gen(CRCPolynomial);

%Define the preamble which is pre-pended to each packet
%These long and short symbols are borrowed from the 802.11a PHY standard
shortSymbol_freq = [0 0 0 0 0 0 0 0 1+i 0 0 0 -1+i 0 0 0 -1-i 0 0 0 1-i 0 0 0 -1-i 0 0 0 1-i 0 0 0 0 0 0 0 1-i 0 0 0 -1-i 0 0 0 1-i 0 0 0 -1-i 0 0 0 -1+i 0 0 0 1+i 0 0 0 0 0 0 0].';
shortSymbol_time = ifft(fftshift(shortSymbol_freq));
shortSymbol_time = shortSymbol_time(1:16).';

longSymbol_freq_bot = [0 0 0 0 0 0 1 1 -1 -1 1 1 -1 1 -1 1 1 1 1 1 1 -1 -1 1 1 -1 1 -1 1 1 1 1]';
longSymbol_freq_top = [1 -1 -1 1 1 -1 1 -1 1 -1 -1 -1 -1 -1 1 1 -1 -1 1 -1 1 -1 1 1 1 1 0 0 0 0 0]';
longSymbol_freq = [longSymbol_freq_bot ; 0 ; longSymbol_freq_top];
longSymbol_time = ifft(fftshift(longSymbol_freq)).';

%Concatenate 10 short symbols together
shortsyms_10 = repmat(shortSymbol_time,1,10);

%Concatenate and cyclicly extend two long symbols
%longsyms_2 = [longSymbol_time(33:64) repmat(longSymbol_time,1,2)];
%longSymbol_time = linspace(-1/6, 1/6, 64);
%longsyms_2 = [longSymbol_time(end-31:end) repmat(longSymbol_time,1,2)];
longsyms_2 = [repmat(longSymbol_time,1,2) longSymbol_time(1:32)];

%Scale the resulting time-domain preamble to fit [-1,1]
preamble = 6*[0 shortsyms_10 longsyms_2];
preamble_ssOnly = 6*[0 shortsyms_10 zeros(1,length(longsyms_2))];

%randseed(1);
%preamble = 6*[0 complex(randn(1,160),randn(1,160)).*0.01 longsyms_2];

preamble_I = real(preamble);%[+1*ones(1,length(preamble)-1) -0.1];
preamble_Q = imag(preamble);%[-1*ones(1,length(preamble)-1) +0.1];

%Configure the pilot tone registers
pilot1_indicies = 7 + ( (64-7) * 2^16);
pilot2_indicies = 21 + ( (64-21) * 2^16);
%pilotValue_pos = hex2dec('7FFF') + (2^16 * hex2dec('7FFF'));%+0.9;
%pilotValue_neg = hex2dec('8000') + (2^16 * hex2dec('8000'));%-0.9;
pilotValue_pos = hex2dec('7FFF') + (2^16 * 0);%+0.9;
pilotValue_neg = hex2dec('8000') + (2^16 * 0);%-0.9;

%Training sequence, borrowed from 802.11a
train = [0 -1 1 -1 1 -1 1 -1 1 -1 -1 -1 -1 1 1 -1 1 1 1 1 1 -1 -1 1 1 -1 -1 0 0 0 0 0 0 0 0 0 0 0 1 -1 1 1 1 -1 -1 -1 -1 1 1 -1 1 -1 1 1 -1 1 1 1 -1 -1 -1 -1 -1 -1];
train = train * -1;
train(22) = -1;
train(58) = 1;

%MIMO training; use the same sequence for both antennas
train = [train train];

%Maximum number of bytes per packet
RAM_init_size = 4096;

%Standard 48-active subcarriers
subcarrier_masks = ones(1,numSubcarriers);
subcarrier_masks(1)=0;  %DC tone at Xk=0
subcarrier_masks(8)=0; %pilot tone at Xk=7
subcarrier_masks(22)=0; %pilot tone at Xk=21
subcarrier_masks(44)=0; %pilot tone at Xk=43
subcarrier_masks(58)=0; %pilot tone at Xk=57
subcarrier_masks([28:32])=0; %zeros at higher frequencies
subcarrier_masks([33:38])=0; %zeros at higher frequencies

%Choose the modulation schemes to use for the base-rate and full-rate symbols
%Replcae the "2" with one of [0,2,4,6,8] to use 0, QPSK, 16/64/256 QAM
modMask_baseRate = 2;
modMask_fullRate = 2;
modulation_baseRate = modMask_baseRate*subcarrier_masks;
modulation_fullRate = modMask_fullRate*subcarrier_masks;

%Final vector must be: [FullRate BaseRate]
subcarrier_QAM_Values = [modulation_fullRate modulation_baseRate];
numBytes_BaseRateOFDMSymbol = sum(modulation_baseRate)/8;
numBytes_FullRateOFDMSymbol = sum(modulation_fullRate)/8;

%Setup the packet length for simulation
numTrainingSymbols = 4;
%numFullRateSymbols = ceil(120/12);%124;
numBaseRateSymbols = 2;

%Setup the packet contents
rand('state',1); %Get the same packet each time for BER testing

%Define the packet's header & other meta-information
pkt_MACAddr_RX = randint(1,6,255); %Radnom MAC addresses
pkt_MACAddr_TX = randint(1,6,255);
pkt_version = 1;
pkt_rate = 2;
pkt_pktType = 0;
pkt_reserved = [0 0 0 0 0]; % 6 bytes

%Define the indicies (zero-indexed, like C) of some important bytes in the header
%Define the indicies (zero-indexed, like C) of some important bytes in the header
%byteIndex_numPayloadBytes = [22 23];
%byteIndex_simpleDynModMasks = 8;
byteIndex_numPayloadBytes = [9 10];
byteIndex_simpleDynModMasks = 8;
numHeaderBytes = 24;


%Define the some header meta-data that is common to every packet
% Number of header bytes, used to insert the header checksum in the right spot
% Indicies of three header bytes - 16-bit packet length and 8-bit modulation masks
% It is required that the Tx and Rx nodes have matching values ahead of time
pktByteNums =	numHeaderBytes + ...
				byteIndex_numPayloadBytes(1)*2^8 + ...
				byteIndex_numPayloadBytes(2)*2^16 + ...
				byteIndex_simpleDynModMasks * 2^24;

%Calculate the number of bytes in the packet, based on the number of OFDM symbols specified above
% In hardware, the user code will provide this value per-packet
pkt_numPayloadBytes = 24+4+20+20+500;%1400;%numBytes_BaseRateOFDMSymbol*numBaseRateSymbols + numBytes_FullRateOFDMSymbol*numFullRateSymbols;
%numFullRateSymbols = ceil( (pkt_numPayloadBytes/numBytes_FullRateOFDMSymbol) - numBaseRateSymbols );%124;
numFullRateSymbols = ceil((pkt_numPayloadBytes - numBytes_BaseRateOFDMSymbol*numBaseRateSymbols)/numBytes_FullRateOFDMSymbol);
numFullRateSymbols = numFullRateSymbols + mod(numFullRateSymbols, 2);

%Construct the packet header (base-rate symbol data) byte-by-byte
packetHeader = [...
	pkt_MACAddr_RX...	%bytes 0-5
	pkt_MACAddr_TX...	%bytes 6-11
	pkt_version...		%byte 12
	floor((pkt_numPayloadBytes/256))... %byte 13
	mod(pkt_numPayloadBytes,256)... %byte 14
	(modMask_fullRate) ... %byte 15
	pkt_rate...			%byte 16
	pkt_pktType...		%byte 17
	0 ...				%byte 18
	pkt_reserved... %bytes 19-23
	];

%Construct the packet header (base-rate symbol data) byte-by-byte
%packetHeader = [...
%	pkt_MACAddr_RX...	%bytes 0-5
%	pkt_MACAddr_TX...	%bytes 6-11
%	pkt_version...		%byte 12
%	pkt_rate...			%byte 13
%	pkt_pktType...		%byte 14
%	0 ...				%byte 15
%	floor((pkt_numPayloadBytes/256))... %byte 16
%	mod(pkt_numPayloadBytes,256)... %byte 17
%	pkt_reserved... %bytes 18-23
%	];

%Assemble the rest of the packet, using random bytes for the full-rate payload
%packet = [packetHeader 1:-4+(numBytes_FullRateOFDMSymbol*numFullRateSymbols)];
%packet = [packetHeader randint(1,(pkt_numPayloadBytes-4-24),255)];%1:(pkt_numPayloadBytes-4-24)];
packet = [packetHeader 1:(pkt_numPayloadBytes-length(packetHeader)-4)];

%Add the 32-bit checksum to the end of the payload
% In hardware, the checksum automatically over-writes the last four bytes of the payload
packet = mod(packet,256);
packet = [packet calcTxCRC(packet)];

%This value allows the simulated transmitter to start new packets
% leaving a few hundred cycles of idle time between each packet
simOnly_numSamples = length(preamble)+( (numSubcarriers+CPLength)*(numTrainingSymbols + numBaseRateSymbols + numFullRateSymbols) );

%Parameters to initialize the packet buffers
% The default packet is loaded at configuration, allowing real-time BER tests
% This packet will be overwritten in hardware when user-code loads packets
packet_length = length(packet)-1;
RAM_init_values = [packet, zeros(1,RAM_init_size-1-packet_length)];

BER_RAM_init_values = reshape(flipud(reshape(RAM_init_values, 8, RAM_init_size/8)), 1, RAM_init_size);

%LSFR parameters, used for random payload mode
txLSFR_numBits = 13;
txLSFR_polynomials = {'21' '35' '0B' '1D' '35' '0B' '3D' '2B'};
txLSFR_initValues = {'3F' '1B' '03' '35' '17' '0A' '74' '39'};

%Precision for the constants which store the modulation values
modConstellation_prec = 8;
modConstellation_bp = 7;

TxRx_FFTScaling = bin2dec('011011') + (bin2dec('000101') * 2^6);

%Defintion of the various constellations
%Gray coded bit-symbol mappings
%Borrowed from the IEEE 802.16 specification
% IEEE Std 802.16-2004 Tables 153-155 (pg. 329)

%QPSK constellation
%2 bits per symbol, 1 bit per I/Q
% I = MSB, Q = LSB
%modConstellation_qpsk = [1 -1];
modConstellation_qpsk = [1 -1]./sqrt(2);
%modConstellation_qpsk = (1-2^-modConstellation_bp).*modConstellation_qpsk./(max(abs(modConstellation_qpsk)));

%16-QAM constellation
%4 bits per symbol, 2 bits per I/Q
% I = 2MSB, Q = 2LSB
modConstellation_qam16 = 0.75*[1 3 -1 -3]./3;
%modConstellation_qam16 = [1 3 -1 -3];
%modConstellation_qam16 = [1 3 -1 -3]./sqrt(10);
%modConstellation_qam16 = (1-2^-modConstellation_bp).*modConstellation_qam16./(max(abs(modConstellation_qam16)));

%FIXME: 64/256QAM constellations exceed +/-1, which won't fit in the current data types!
%64-QAM constellation
%6 bits per symbol, 3 bits per I/Q
% I = 3MSB, Q = 3LSB
modConstellation_qam64 = 0.875*[3 1 5 7 -3 -1 -5 -7]./7;
%modConstellation_qam64 = [3 1 5 7 -3 -1 -5 -7];
%modConstellation_qam64 = [3 1 5 7 -3 -1 -5 -7]./(7*3/sqrt(10));%sqrt(42);
%modConstellation_qam64 = (1-2^-modConstellation_bp).*modConstellation_qam64./(max(abs(modConstellation_qam64)));

%256-QAM constellation
%8 bits per symbol, 4 bits per I/Q
% I = 4MSB, Q = 4LSB
modConstellation_qam256 = 0.9375*[3 1 5 7 11 9 13 15 -3 -1 -5 -7 -11 -9 -13 -15]./15;
%modConstellation_qam256 = [3 1 5 7 11 9 13 15 -3 -1 -5 -7 -11 -9 -13 -15];
%1/(modnorm(qammod(0:255,256),'avpow',1))^2
%modConstellation_qam256 = [3 1 5 7 11 9 13 15 -3 -1 -5 -7 -11 -9 -13 -15]./sqrt(170);
%modConstellation_qam256 = (1-2^-modConstellation_bp).*modConstellation_qam256./(max(abs(modConstellation_qam256)));

%interpFilter = firpm(40, [0 0.18 0.25 1], [1 1 0 0]);
[x, interpFilter] = interp(longSymbol_time, 5);
[x, interpFilter_4] = interp(longSymbol_time, 4);
%interpFilter_4 = firpm(31,[0 0.22 0.32 1], [1 1 0 0]);
%interpFilter_4 = firpm(31,[0 (1-52/64)*.25 (1+52/64)*.25 1], [1 1 0 0]);
%interpFilter_4 = 2*interpFilter_4./norm(interpFilter_4);
%interpFilter_4 = rcosfir(0.2, 4, 4, 1);

antB_preambleShift = 4;

%Popluate the TxControlBits register
%0x1:	1: Unused
%0x2:	2: Unused
%0x4:	4: Disable antenna B preamble
%0x8:	8: Enable pilot tone scrambling
%0xF0:	 : Antenna B preamble shift
%0x100:	256: Enable re-transmission (relay mode)
%0x200:	512: Swap antenna A/B (sends stream B first in relay mode)
%0x400: 1024: Enable Tx PreCFO
%0x800: 2048: Enable relay re-transmission
%0xFFFF0000: Delay before re-transmission

tx_controlBits = ...
		   0 * 1 ... %Unused
		 + 0 * 2 ... %Unused
		 + 0 * 4 ... %0=enable antenna B preamble
		 + 1 * 8 ... %1=enable pilot scrambling
		 + 1 * 16 * (antB_preambleShift) ... %4-bit preamble shift
		 + 0 * 256 ... %1=relay mode
		 + 0 * 512 ... %1=antenna swap
         + 1 * 1024 ... %1=enable Tx preCFO
         + 1 * 2048 ... %1=Enable relay (DF) re-transmission on goodPkt
		 + 1 * 2^16 * 1000; %16-bit re-transmit delay

%DataScrambling_Seq = zeros(1,32);
TxDataScrambling_Seq = [40 198 78 63 82 173 102 245 48 111 172 115 147 230 216 93 72 65 62 2 205 242 122 90 128 83 105 97 73 10 5 252];
RxDataScrambling_Seq = [40 198 78 63 82 173 102 245 48 111 172 115 147 230 216 93 72 65 62 2 205 242 122 90 128 83 105 97 73 10 5 252];

%Load Chipscope capture data
AntA_ADC_I = 0;AntA_ADC_Q = 0; csInterp = 2; t_start = 1;
%xlloadchipScopeData('cfo_v06_capt1_coarseEstOffBy10x.prn'); csInterp = 2; t_start = 1000;
%xlloadchipScopeData('cfo_v08_coarseCfoTooBig_1.prn'); csInterp = 2; t_start = 2913;
%xlloadchipScopeData('cfo_v08_coarseCfoGood_0.prn'); csInterp = 2; t_start = 535;
rxAntI.time = [];
rxAntQ.time = [];
rxAntI.signals.values = AntA_ADC_I(t_start:csInterp:end);
rxAntQ.signals.values = AntA_ADC_Q(t_start:csInterp:end);
