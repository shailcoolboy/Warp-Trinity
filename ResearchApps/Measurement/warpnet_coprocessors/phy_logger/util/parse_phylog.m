function output_struct = parse_phylog(filename, maxRows)
% Field Sizes
% RXPHYDUMP_SIZE_EVMPERSC =	256 (4*( 64 Fix32_26))
% RXPHYDUMP_SIZE_EVMPERSYM=	512 (4*(128 Fix32_14))
% RXPHYDUMP_SIZE_CHANEST =	256 (4*( 64 Fix32_30))
% 
% Record Format (1316 bytes max, if all fields are included):
% [0:3] param0
% [4:7] param1
% [8:11] param2
% [12:15] param3
% [16]	unsigned char structID;
% [17]	unsigned char nodeID;
% [18:19]	unsigned short seqNum;
% [20]	unsigned char pktType;
% [21]	unsigned char rxStatus;
% [22]	unsigned char includedData;
% [23]	unsigned char reserved0;
% [24:25]	unsigned short rssi;
% [26:27]	unsigned short rxGains;
% [28:31]	unsigned int cfoEst_coarse; (Fix32_32)
% [32:35]	unsigned int cfoEst_pilots; (Fix32_32)
% [36:291]	unsigned char evm_per_sc[RXPHYDUMP_SIZE_EVMPERSC]
% [292:803]	unsigned char evm_per_sym[RXPHYDUMP_SIZE_EVMPERSYM]
% [804:1059]	unsigned char chanest_AA[RXPHYDUMP_SIZE_CHANEST]
% [1060:1315]	unsigned char chanest_BA[RXPHYDUMP_SIZE_CHANEST]

output_struct = struct;

recsize = 1316;

%H/P=1/2, payload=1412B
syms_per_pkt = 128;

fid = fopen(filename, 'r', 'b');

if(fid < 1)
    error('FILE', 'Error opening PHY log file!');
    return;
end


fseek(fid, 0, 'bof');
output_struct.params0 = fread(fid, [maxRows], 'uint32=>double', recsize-4);

fseek(fid, 4, 'bof');
output_struct.params1 = fread(fid, [maxRows],  'uint32=>double', recsize-4);

fseek(fid, 8, 'bof');
output_struct.params2 = fread(fid, [maxRows],  'uint32=>double', recsize-4);

fseek(fid, 12, 'bof');
output_struct.params3 = fread(fid, [maxRows],  'uint32=>double', recsize-4);

fseek(fid, 16, 'bof');
output_struct.structIDs = fread(fid, [maxRows],  '*uint8', recsize-1);

fseek(fid, 18, 'bof');
output_struct.seqNums = fread(fid, [maxRows],  'uint16=>double', recsize-2);

fseek(fid, 20, 'bof');
output_struct.pktTypes = fread(fid, [maxRows],  '*uint8', recsize-1);

fseek(fid, 21, 'bof');
output_struct.rxStatuses = fread(fid, [maxRows],  '*uint8', recsize-1);

fseek(fid, 24, 'bof');
rssis = fread(fid, [maxRows],  'uint16=>double', recsize-2);
output_struct.rssis = rssis./16;

fseek(fid, 26, 'bof');
rxGains = fread(fid, [maxRows],  '*uint16', recsize-2);

rxGains_A = bitand(rxGains, hex2dec('FF'));
rxGains_B = bitshift(bitand(rxGains, hex2dec('FF00')), -8);
output_struct.rxGainsRF_A = double(bitshift(bitand(rxGains_A, hex2dec('60')), -5));
output_struct.rxGainsBB_A = double(bitand(rxGains_A, hex2dec('1F')));
output_struct.rxGainsRF_B = double(bitshift(bitand(rxGains_B, hex2dec('60')), -5));
output_struct.rxGainsBB_B = double(bitand(rxGains_B, hex2dec('1F')));

fseek(fid, 28, 'bof');
cfoEsts_c = fread(fid, [maxRows],  'int32=>double', recsize-4);
output_struct.cfoEsts_c = cfoEsts_c./2^32;

fseek(fid, 32, 'bof');
cfoEsts_p = fread(fid, [maxRows],  'int32=>double', recsize-4);
output_struct.cfoEsts_p = cfoEsts_p./2^32;

fseek(fid, 36, 'bof');
evms_per_sc = fread(fid, [64, maxRows], '64*uint32=>double', recsize-256);
output_struct.evms_per_sc = evms_per_sc./(syms_per_pkt*2^26);

fseek(fid, 292, 'bof');
evms_per_sym = fread(fid, [128, maxRows], '128*uint32=>double', recsize-512);
output_struct.evms_per_sym = evms_per_sym(1:syms_per_pkt, :)./(48*2^14);

fseek(fid, 804, 'bof');
chanests_AA = fread(fid, [64, maxRows], '64*uint32=>double', recsize-256);
output_struct.chanests_AA = sqrt(chanests_AA./2^30);

fseek(fid, 1060, 'bof');
chanests_BA = fread(fid, [64, maxRows], '64*uint32=>double', recsize-256);
output_struct.chanests_BA = sqrt(chanests_BA./2^30);

fclose(fid);
