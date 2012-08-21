warning off;

%Compile-time maximum values; used to set precision of control logic values
max_OFDM_symbols = 2047;
max_num_subcarriers = 64;
max_CP_length = 16;
max_num_baseRateSymbols = 31;
max_num_trainingSymbols = 15;
max_numBytes = 16384;

%Hard-coded OFDM parameters for now; these might be dynamic some day
numSubcarriers = 64;
CPLength = 16;

%Set SISO mode
tx_SISO_Mode = 1;

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
longsyms_2 = [repmat(longSymbol_time,1,2) longSymbol_time(1:32)];

%Scale the resulting time-domain preamble to fit [-1,1]
preamble = 6*[0 shortsyms_10 longsyms_2];
preamble_I = real(preamble);%[+1*ones(1,length(preamble)-1) -0.1];
preamble_Q = imag(preamble);%[-1*ones(1,length(preamble)-1) +0.1];

%Configure the pilot tone registers
pilot1_indicies = 7 + ( (64-7) * 2^16);
pilot2_indicies = 21 + ( (64-21) * 2^16);
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
%RAM_init_size = 4096;
BER_RAM_init_size = 2048; %only support BER tests up to 2048 bytes/packet
RAM_init_size = max_numBytes;

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
%Valid values are [0,2,4,6,8], meaning 0, QPSK, 16/64/256 QAM symbols per subcarrier
mod_baseRate = 2;
modMask_antA = 2;
modMask_antB = 2*(1-tx_SISO_Mode); %If in MIMO mode, load modulated symbols for ant B

modulation_antA = modMask_antA*subcarrier_masks;
modulation_antB = modMask_antB*subcarrier_masks;

modulation_antA = 15*subcarrier_masks;
modulation_antB = 15*subcarrier_masks;

modulation_baseRate = mod_baseRate*subcarrier_masks;

%Final vector must be: [AntennaA AntennaB BaseRate]
%AntA = AntB = BaseRate = 48 non-zero subcarriers -> 12 bytes/OFDM symbol with QPSK
subcarrier_QAM_Values = [modulation_antA modulation_antB modulation_baseRate];
numBytes_BaseRateOFDMSymbol = sum(modulation_baseRate)/8;

numBytes_AFullRateOFDMSymbol = sum(bitand(modMask_antA,modulation_antA))/8;
numBytes_BFullRateOFDMSymbol = sum(bitand(modMask_antB,modulation_antB))/8;

%numBytes_FullRateOFDMSymbol = sum(modulation_antA)/8;
numBytes_FullRateOFDMSymbol = numBytes_AFullRateOFDMSymbol;
if(tx_SISO_Mode == 1)
	numBytes_FullRateOFDMSymbol = numBytes_AFullRateOFDMSymbol;
else
	numBytes_FullRateOFDMSymbol = (numBytes_AFullRateOFDMSymbol + numBytes_BFullRateOFDMSymbol)/2;
end

%Example of how modulation data gets formatted as bytes in the packet's header; useed for simulation
subcarrier_QAM_Values_bytes = reshape([modulation_antA modulation_antB], 2, numSubcarriers);
subcarrier_QAM_Values_bytes = sum(subcarrier_QAM_Values_bytes .* [ones(1,64).*2^4; ones(1,64)]);

%Setup the packet length for simulation
numTrainingSymbols = 2;
numBaseRateSymbols = 2;

%Setup the packet contents
rand('state',1); %Get the same packet each time for BER testing

%Calculate the number of bytes in the packet, based on the number of OFDM symbols specified above
% In hardware, the user code will provide this value per-packet
pkt_numPayloadBytes = 1400+42-6;%6*24+1;
%1400+42 worked...

%Calculate the number of full rate OFDM symbols
% This number is actually the number of FFT frames which are calculated
% In SISO mode, it is double the number of actual OFDM symbols transmitted
% As a result, this value must be even, in any mode
if(tx_SISO_Mode == 1)
	numFullRateSymbols = 2*ceil((4+pkt_numPayloadBytes)/numBytes_FullRateOFDMSymbol);%124;
else
	numFullRateSymbols = ceil((4+pkt_numPayloadBytes)/numBytes_FullRateOFDMSymbol);%124;
end
numFullRateSymbols = numFullRateSymbols + mod(numFullRateSymbols, 2);

%Define the indicies (zero-indexed, like C) of some important bytes in the header
byteIndex_numPayloadBytes = [3 2];
byteIndex_simpleDynModMasks = 0;
numHeaderBytes = 24;

%Total number of bytes to process (header + payload + 32-bit payload checksum)
pkt_totalBytes = numHeaderBytes + pkt_numPayloadBytes + 4;

%Construct the packet header
% The PHY only cares about 3 bytess (length_lsb, length_msb and modMasks)
% In hardware, the MAC will use the rest of the header for MAC-ish stuff
packetHeader = [...
	(modMask_antA + modMask_antB*2^4) ... %byte 0
	0 ...
	floor((pkt_totalBytes/256))... %byte 2
	mod(pkt_totalBytes,256)... %byte 3
	zeros(1,20)	...
];

%Endian-flip at 64-bit boundaries to mimic the PLB packet buffer interface in hardware
packetHeader = [fliplr(packetHeader(1:8)) fliplr(packetHeader(9:16)) fliplr(packetHeader(17:24))];

%Assemble the rest of the packet, using random bytes for the full-rate payload
packet = [packetHeader 1:(pkt_numPayloadBytes-length(packetHeader)-4)];
%packet = [packetHeader 255.*ones(1, (pkt_numPayloadBytes-length(packetHeader)-4))];

packet = mod(packet,256); %Make sure each element is really just one byte

%Add the 32-bit checksum to the end of the payload
% In hardware, the checksum automatically over-writes the last four bytes of the payload
packet = [packet calcTxCRC(packet)];

%This value allows the simulated transmitter to start new packets
% leaving a few hundred cycles of idle time between each packet
simOnly_numSamples = length(preamble)+( (numSubcarriers+CPLength)*(numTrainingSymbols + numBaseRateSymbols + numFullRateSymbols/2) );

%Default value for the Tx symbol counts register
txReg_symbolCounts = (2^16 * numFullRateSymbols) + (2^8 *numBaseRateSymbols ) + numTrainingSymbols;

%Parameters to initialize the packet buffers
% The default packet is loaded at configuration, allowing real-time BER tests
% This packet will be overwritten in hardware when user-code loads packets
packet_length = length(packet)-1;
RAM_init_values = [packet, zeros(1,RAM_init_size-1-packet_length)];

BER_RAM_init_values = RAM_init_values(1:BER_RAM_init_size);
BER_RAM_init_values = reshape(flipud(reshape(BER_RAM_init_values, 8, BER_RAM_init_size/8)), 1, BER_RAM_init_size);

%LPF coefficients for the interpolation/decimation filters
lpf_h = [1.296923e-003 1.408510e-003 1.257711e-003 3.226648e-005 -2.519384e-003 -6.198394e-003 -1.022530e-002 -1.333438e-002 -1.410672e-002 -1.149196e-002 -5.345330e-003 3.224983e-003 1.190534e-002 1.770326e-002 1.787723e-002 1.101327e-002 -2.108767e-003 -1.821814e-002 -3.204219e-002 -3.756010e-002 -2.972681e-002 -6.174810e-003 3.165421e-002 7.836874e-002 1.256233e-001 1.640445e-001 1.855768e-001 1.855768e-001 1.640445e-001 1.256233e-001 7.836874e-002 3.165421e-002 -6.174810e-003 -2.972681e-002 -3.756010e-002 -3.204219e-002 -1.821814e-002 -2.108767e-003 1.101327e-002 1.787723e-002 1.770326e-002 1.190534e-002 3.224983e-003 -5.345330e-003 -1.149196e-002 -1.410672e-002 -1.333438e-002 -1.022530e-002 -6.198394e-003 -2.519384e-003 3.226648e-005 1.257711e-003 1.408510e-003 1.296923e-003];
lpf_h = firpm(53,[0 .18 .21 1],[1 1 0 0]);
%B = RCOSFIR(R, N_T, RATE, T)
lpf_h_tx = rcosfir(.25, 5, 5, 1, 'sqrt');
%lpf_h_rx = firpm(53,[0 .5 .55 1],[1 1 0 0]);
lpf_h_rx = rcosfir(.25, 5, 5, 1, 'sqrt');

%LSFR parameters, used for random payload mode
txLSFR_numBits = 13;
txLSFR_polynomials = {'21' '35' '0B' '1D' '35' '0B' '3D' '2B'};
txLSFR_initValues = {'3F' '1B' '03' '35' '17' '0A' '74' '39'};

%Precision for the constants which store the modulation values
modConstellation_prec = 8;
modConstellation_bp = 7;

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
modConstellation_qam16 = .75*[1 3 -1 -3]./3;
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

antB_preambleShift = 4;

%Fill in the TxControlBits register; each bit has a different purpose
%0x1: 1 SISO Mode
%0x2: 2 Random payload
%0x4: 4 Disable AntB preamble
%0x8: 8 Enable Pilot Scrambling (2^3)
tx_controlBits = (antB_preambleShift * 2^4) + (2^0 * tx_SISO_Mode) + 4*0 + 8*1;

%12-bit value: bits[5:0]=TxFFTScaling, bits[11:6]=RxFFTScaling
TxRx_FFTScaling = bin2dec('010111') + (bin2dec('000101') * 2^6);


%DataScrambling_Seq = zeros(1,32);
TxDataScrambling_Seq = [40 198 78 63 82 173 102 245 48 111 172 115 147 230 216 93 72 65 62 2 205 242 122 90 128 83 105 97 73 10 5 252];
RxDataScrambling_Seq = [40 198 78 63 82 173 102 245 48 111 172 115 147 230 216 93 72 65 62 2 205 242 122 90 128 83 105 97 73 10 5 252];
