warning off;

fixScopes;

%Int filter options
txfilt_firpm = firpm(31, [0 .75*.25 1.25*.25 1], [1 1 0 0], [1 .2]);
txfilt_firpm = 0.95*txfilt_firpm./(max(txfilt_firpm));
txfilt_intfilt = [0 intfilt(4,4,.8)];

set(0, 'DefaultLineLineWidth', 1.5);

%Compile-time maximum values; used to set precision of control logic values
max_OFDM_symbols = 511;%2047;
max_num_subcarriers = 64;
max_CP_length = 16;
max_num_baseRateSymbols = 31;
max_num_trainingSymbols = 15;
max_numBytes = 16384;

%Hard-coded OFDM parameters for now; these might be dynamic some day
numSubcarriers = 64;
CPLength = 16;

%Set the transceiver mode - SISO and Alamouti must not both be 1!
tx_SISO_Mode = 0;
tx_Alamouti_Mode = 1;

%Cyclic Redundancy Check parameters
CRCPolynomial32 = hex2dec('04c11db7'); %CRC-32
CRCPolynomial16 = hex2dec('1021'); %CRC-CCIT
CRC_Table32 = CRC_table_gen(CRCPolynomial32, 32);
CRC_Table16 = CRC_table_gen(CRCPolynomial16, 16);

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
%shortsyms_10 = linspace(0,0.4-2^-13,160);
shortsyms_10 = repmat(shortSymbol_time,1,10);

%Concatenate and cyclicly extend two long symbols
%longsyms_2 = [longSymbol_time(33:64) repmat(longSymbol_time,1,2)];
%longSymbol_time = linspace(-1/6, 1/6, 64);
%longsyms_2 = [repmat(longSymbol_time,1,2) longSymbol_time(1:32)];%complex(linspace(-1,0.98,160), linspace(0.98,-1,160));%
%longsyms_2 = [longSymbol_time(33:64) repmat(longSymbol_time,1,2)];%complex(linspace(-1,0.98,160), linspace(0.98,-1,160));%
longsyms_2 = [longSymbol_time(49:64) repmat(longSymbol_time,1,2) longSymbol_time(1:16)];
%longsyms_2 = linspace(0.6,1-2^-13,160);%0.5*ones(1,160);%

%Scale the resulting time-domain preamble to fit [-1,1]
preamble_scale = 6;
preamble = preamble_scale*[shortsyms_10 longsyms_2];
preamble_I = real(preamble);
preamble_Q = imag(preamble);

%The preamble stored in memory is slightly different- it contains cyclic extensions of each half (STS/LTS)
% to make addressing easier for two antennas sending cyclicaly shifted preambles
%The preamble consists of 320 actual samples: [10xSTS] [2.5xLTS]
% Each half is padded with 8 samples before/after when stored in memory
preamble_ext = preamble_scale*[...
	shortSymbol_time(end-7:end) repmat(shortSymbol_time,1,10) shortSymbol_time(1:8) ...
	longSymbol_time(41:48) longSymbol_time(49:64) repmat(longSymbol_time,1,2) longSymbol_time(1:16) longSymbol_time(17:24)];

preamble_I_ROM = round(2^13*real(preamble_ext));
ii = find(preamble_I_ROM < 0);
preamble_I_ROM(ii) = 2^16 + preamble_I_ROM(ii);

preamble_Q_ROM = round(2^13*imag(preamble_ext));
ii = find(preamble_Q_ROM < 0);
preamble_Q_ROM(ii) = 2^16 + preamble_Q_ROM(ii);

preamble_ROM = preamble_I_ROM + preamble_Q_ROM*2^16;

%Configure the pilot tone registers
%pilot_indicies = 7 + ( (64-7) * 2^8) + (21 * 2^16) + ( (64-21) * 2^24);
pilot_indicies = 7 + ( (64-21) * 2^8) + ( (64-7) * 2^16) + (21 * 2^24);

%Values from hardware (~.7, like QPSK, to avoid saturation)
pilotValues = hex2dec('A57D') + (2^16 * hex2dec('5A82'));

%Actual BPSK (+/- 1)
%pilotValues = hex2dec('8000') + (2^16 * hex2dec('7FFF'));

%Training sequence, borrowed from 802.11a

%12 empty (DC + 11 HF)
%train = [0 -1 1 -1 1 -1 1 -1 1 -1 -1 -1 -1 1 1 -1 1 1 1 1 1 -1 -1 1 1 -1 -1 0 0 0 0 0 0 0 0 0 0 0 1 -1 1 1 1 -1 -1 -1 -1 1 1 -1 1 -1 1 1 -1 1 1 1 -1 -1 -1 -1 -1 -1];

%10 empty (DC + 9 HF)
train = [0 -1 1 -1 1 -1 1 -1 1 -1 -1 -1 -1 1 1 -1 1 1 1 1 1 -1 -1 1 1 -1 -1 1 0 0 0 0 0 0 0 0 0 -1 1 -1 1 1 1 -1 -1 -1 -1 1 1 -1 1 -1 1 1 -1 1 1 1 -1 -1 -1 -1 -1 -1];

%Match the training sequence to the pilot tone signs
train(8)  = 1;
train(22) = -1;
train(44) = 1;
train(58) = 1;

%train=zeros(1,length(train));

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

subcarrier_masks = ones(1,numSubcarriers);
subcarrier_masks(1)=0;  %DC tone at Xk=0
subcarrier_masks(2)=0;  %DC tone at Xk=0
subcarrier_masks(63)=0;  %DC tone at Xk=0
subcarrier_masks(8)=0; %pilot tone at Xk=7
subcarrier_masks(22)=0; %pilot tone at Xk=21
subcarrier_masks(44)=0; %pilot tone at Xk=43
subcarrier_masks(58)=0; %pilot tone at Xk=57
subcarrier_masks([29:32])=0; %zeros at higher frequencies
subcarrier_masks([33:37])=0; %zeros at higher frequencies

%Choose the modulation schemes to use for the base-rate and full-rate symbols
%Valid values are [0,2,4,6,8], meaning 0, QPSK, 16/64/256 QAM symbols per subcarrier
%QPSK/QPSK
mod_baseRate = 2;
modMask_antA = 2;
modMask_antB = 2; %AntB is ignored in SISO mode, so it's safe to leave this field non-zero all the time

%BPSK/16-QAM
%mod_baseRate = 1;
%modMask_antA = 4;
%modMask_antB = 4; %AntB is ignored in SISO mode, so it's safe to leave this field non-zero all the time

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
numHeaderBytes = 24;
numTrainingSymbols = 2;
numBaseRateSymbols = ceil(numHeaderBytes / numBytes_BaseRateOFDMSymbol);

%Setup the packet contents
rand('state',1); %Get the same packet each time for BER testing

%Calculate the number of bytes in the packet, based on the number of OFDM symbols specified above
% In hardware, the user code will provide this value per-packet
pkt_numPayloadBytes = (1412);%X OFDM symbols worth of payload, plus header and checksum

%Calculate the number of full rate OFDM symbols
% This number is actually the number of FFT frames which are calculated
% In SISO mode, it is double the number of actual OFDM symbols transmitted
% As a result, this value must be even, in any mode
if(tx_SISO_Mode == 1 || tx_Alamouti_Mode == 1)
	numFullRateSymbols = 2*ceil((4+pkt_numPayloadBytes)/numBytes_FullRateOFDMSymbol);%124;
else
	numFullRateSymbols = ceil((4+pkt_numPayloadBytes)/numBytes_FullRateOFDMSymbol);%124;
end
numFullRateSymbols = numFullRateSymbols + mod(numFullRateSymbols, 2);

%Define the indicies (zero-indexed, like C) of some important bytes in the header
byteIndex_numPayloadBytes = [3 2];
byteIndex_simpleDynModMasks = 0;

%Total number of bytes to process (header + payload + 32-bit payload checksum)
if(pkt_numPayloadBytes > 0)
    pkt_totalBytes = numHeaderBytes + pkt_numPayloadBytes + 4;
else
    pkt_totalBytes = numHeaderBytes;
end

%Construct the packet header
% The PHY only cares about 3 bytess (length_lsb, length_msb and modMasks)
% In hardware, the MAC will use the rest of the header for MAC-ish stuff
packetHeader = [...
	(modMask_antA + modMask_antB*2^4) ... %byte 0 mod masks
	3 ... %byte 1 code rate
	floor((pkt_totalBytes/256))... %byte 2 pkt size
	mod(pkt_totalBytes,256)... %byte 3 pkt size
	3 ... %src addr msb
    1 ... %src addr lsb
	2 ... %dst addr msb
    0 ... %dst addr lsb
	0 ... %relay addr msb
    0 ... %relay addr lsb
    2 ... %byte 10 pkt type
    zeros(1,13)	...
];

%Assemble the rest of the packet, using some filler bytes for the full-rate payload
%packet = [packetHeader 1:(pkt_numPayloadBytes)];
packet = [packetHeader zeros(1,pkt_numPayloadBytes)];

%Make sure each element is really just one byte
packet = mod(packet,256);

%Add the 32-bit checksum to the end of the payload (sim-only)
% In hardware, the checksum automatically over-writes the last four bytes of the payload
packet = [packet calcCRC32(packet)];

%Zero-pad the vector to fill a multiple of 8 bytes
packet = [packet zeros(1,8-mod(length(packet),8))];

%Endian-flip at 64-bit boundaries to mimic the PLB packet buffer interface in hardware
% [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 ...] becomes [8 7 6 5 4 3 2 1 16 15 14 13 12 11 10 9 ...]
packet = reshape(flipud(reshape(packet,8,length(packet)/8)),1,length(packet));

%This value allows the simulated transmitter to start new packets
% leaving a few hundred cycles of idle time between each packet
simOnly_numSamples = length(preamble)+( (numSubcarriers+CPLength)*(numTrainingSymbols + numBaseRateSymbols + numFullRateSymbols/2) );
simOnly_simLength = 1000 + 2 * (4 * (simOnly_numSamples + 500));

%Default value for the Tx symbol counts register
txReg_symbolCounts = (2^8 *numBaseRateSymbols ) + numTrainingSymbols;

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

antB_preambleShift = 3;

%Fill in the TxControlBits register; each bit has a different purpose
%0x1: 1 SISO Mode
%0x2: 2 Alamouti Mode
%0x4: 4 Disable AntB preamble
%0x8: 8 Enable Pilot Scrambling (2^3)
%0xF0: Preamble shift
%0x100: 256 Random payload
%0x200: 512 Swap Tx antennas
%0x400: 1024 Start Tx using software write
%0x800: 2048 Enable ExtTxEn port
%0x1000: Always use preSpin (instead of requring auto responder)
%0x2000: Capture random payloads
%0x4000: Enable AutoTwoTx
%0x8000: Enable TxRunning_d0 output
%0x10000: Enable TxRunning_d1 output
%0x20000: Tx int filt sel (0=intfilt, 1=firpm)
%0x3F0_0000: Tx post IFFT cyclic shift (0 = use only cyclic prefix)
tx_controlBits = (antB_preambleShift * 2^4) + (2^1 * tx_Alamouti_Mode) + ...
	(2^0 * tx_SISO_Mode) + 4*0 + 8*1 + 0*256 + 512*0 + 1024*0 + ...
	0*hex2dec('1000') + 0*hex2dec('2000') + 0*hex2dec('4000') + ...
	1*hex2dec('8000') + 1*hex2dec('10000') + hex2dec('20000') + ...
	16*hex2dec('100000');

%0x0000_00FF: External TxEn delay
%0x0000_0F00: Extra Tx/rx-Tx delay
%0x000F_F000: TxRunning_d output delay
tx_delays = (50*2^0) + (0*2^8) + (30*2^12);

%tx_scaling = (2480) + (9792 * 2^16);
%tx_scaling = (4365) + (14267 * 2^16);
tx_scaling = (3072) + (12288 * 2^16);

%12-bit value: bits[5:0]=TxFFTScaling, bits[11:6]=RxFFTScaling
%TxRx_FFTScaling = bin2dec('010111') + (bin2dec('000101') * 2^6);
% TxRx_FFTScaling = ...
% 	(3 * 2^0) + ... %Tx stage3
% 	(1 * 2^2) + ... %Tx stage2
% 	(1 * 2^4) + ... %Tx stage1
% 	(1 * 2^6) + ... %Rx stage3
% 	(1 * 2^8) + ... %Rx stage2
% 	(0 * 2^10); %Rx stage1

TxRx_FFTScaling = ...
	(3 * 2^0) + ... %Tx stage3
	(2 * 2^2) + ... %Tx stage2
	(1 * 2^4) + ... %Tx stage1
	(1 * 2^6) + ... %Rx stage3
	(1 * 2^8) + ... %Rx stage2
	(0 * 2^10); %Rx stage1

%DataScrambling_Seq = zeros(1,32);
TxDataScrambling_Seq = [40 198 78 63 82 173 102 245 48 111 172 115 147 230 216 93 72 65 62 2 205 242 122 90 128 83 105 97 73 10 5 252];
RxDataScrambling_Seq = [40 198 78 63 82 173 102 245 48 111 172 115 147 230 216 93 72 65 62 2 205 242 122 90 128 83 105 97 73 10 5 252];


%AutoReply params
ActionID_Disabled = 0;
ActionID_SetFlagA = 62;
ActionID_SetFlagB = 61;
ActionID_AFTransmit = 31;

PHY_AUTORESPONSE_MATCH_LENGTH_OFFSET = 5;
PHY_AUTORESPONSE_MATCH_VALUE_OFFSET = 8;

PHY_AUTORESPONSE_REQ_MATCH0 = hex2dec('001');
PHY_AUTORESPONSE_REQ_MATCH1 = hex2dec('002');
PHY_AUTORESPONSE_REQ_MATCH2 = hex2dec('004');
PHY_AUTORESPONSE_REQ_MATCH3 = hex2dec('008');
PHY_AUTORESPONSE_REQ_MATCH4 = hex2dec('010');
PHY_AUTORESPONSE_REQ_MATCH5 = hex2dec('020');
PHY_AUTORESPONSE_REQ_MATCH6 = hex2dec('040');
PHY_AUTORESPONSE_REQ_MATCH7 = hex2dec('080');

PHY_AUTORESPONSE_REQ_GOODHDR = hex2dec('800');
PHY_AUTORESPONSE_REQ_BADPKT = hex2dec('1000');
PHY_AUTORESPONSE_REQ_GOODPKT = hex2dec('2000');
PHY_AUTORESPONSE_REQ_FLAGA = hex2dec('4000');
PHY_AUTORESPONSE_REQ_FLAGB = hex2dec('8000');

PHY_AUTORESPONSE_ACT_HDRTRANS_EN = hex2dec('10000');
PHY_AUTORESPONSE_ACT_PRECFO_EN = hex2dec('20000');
PHY_AUTORESPONSE_ACT_ID_OFFSET = 18;
PHY_AUTORESPONSE_ACT_PARAM_OFFSET = 24;

%14=goodPkt, 18:24=actionID
%Action0_Config = (PHY_AUTORESPONSE_REQ_MATCH0 + PHY_AUTORESPONSE_REQ_MATCH1 + PHY_AUTORESPONSE_REQ_GOODHDR + PHY_AUTORESPONSE_REQ_GOODPKT) + (2 * 2^PHY_AUTORESPONSE_ACT_ID_OFFSET) + (100 * 2^PHY_AUTORESPONSE_ACT_PARAM_OFFSET);
%Action0_Config = 31*2^18 + 100*2^24; %AF testing
%Action0_Config = 2^14 + ActionID_SetFlagA*2^18 + 100*2^24; %Flag A testing
Action0_Config = 0; %Disabled
%Match0_Config = 0;%Disabled
Match0_Config = 0;%10 + (1 * 2^6) + (packetHeader(11) * 2^8);


%Testing: Config for Node 0:
Action0_Config = 0* 31*2^18 + 0*2^24 + PHY_AUTORESPONSE_REQ_GOODHDR + PHY_AUTORESPONSE_REQ_GOODPKT + PHY_AUTORESPONSE_REQ_FLAGA;%AF 
Action1_Config = 0* 62*2^18 + PHY_AUTORESPONSE_REQ_GOODHDR + PHY_AUTORESPONSE_REQ_GOODPKT;%Set FlagA
Action2_Config = 0;%hex2dec('41005');
Action3_Config = 0;
Action4_Config = 0;
Action5_Config = 0;

Match0_Config = 0;%hex2dec('246'); %Addressed to 0x0200
Match1_Config = 0;%hex2dec('12A'); %pktType 1 (DATA)
Match2_Config = 0;%hex2dec('22A'); %pktType 2 (NACK)
Match3_Config = 0;
Match4_Config = 0;
Match5_Config = 0;
Match6_Config = 0;
Match7_Config = 0;

%Testing: Config for Node 1:
%Action0_Config = hex2dec('0');
%Action1_Config = hex2dec('e5003'); %MATCH0|MATCH1|GOODPKT -> Send from 3
%Action2_Config = hex2dec('41005'); %MATCH0|MATCH2|? -> Send from 1
%Action3_Config = 0;
%Action4_Config = 0;
%Action5_Config = 0;

%Match0_Config = hex2dec('10346'); %Addressed to 0x0301
%Match1_Config = hex2dec('12A'); %pktType 1 (DATA)
%Match2_Config = hex2dec('22A'); %pktType 2 (NACK)
%Match3_Config = 0;
%Match4_Config = 0;
%Match5_Config = 0;

        