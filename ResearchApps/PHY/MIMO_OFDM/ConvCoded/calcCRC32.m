function crcOut = calcCRC32(thePacketBytes)
%Based on the C code example at:
%http://www.netrino.com/Embedded-Systems/How-To/CRC-Calculation-C-Code
%Uses slightly modified version of CRC-32:
% No output XOR
% No bit-order swapping on message or digest bytes

CRCPolynomial = hex2dec('04c11db7');
CRC_Table = CRC_table_gen(CRCPolynomial, 32);

init_crc = hex2dec('ffffffff');
myData = thePacketBytes;
%de2bi(49,'left-msb',8))
crc_accum = init_crc;
for n=1:length(myData)
	x = bitshift(crc_accum,-24,32);
%CRC32 would swap bit order here:
%	x = bitxor(x, bi2de( de2bi(myData(n),'left-msb',8)));
	x = bitxor(x, myData(n));
	x = bitand(x,hex2dec('ff'));
	crc_accum = bitxor(bitshift(crc_accum,8,32),CRC_Table(x+1));
    crc_tracking(n) = crc_accum;
end

CRC32 = crc_accum;
%CRC32 would XOR with all ones, then reorder bits here:
%CRC32 = bitxor(CRC32, hex2dec('ffffffff'));
%CRC32 = bi2de(de2bi(CRC32,'left-msb',32));

CRC32_b3 = bitand(bitshift(CRC32,-24,32),hex2dec('ff'));
CRC32_b2 = bitand(bitshift(CRC32,-16,32),hex2dec('ff'));
CRC32_b1 = bitand(bitshift(CRC32,-8,32),hex2dec('ff'));
CRC32_b0 = bitand(CRC32,hex2dec('ff'));

crcOut = [CRC32_b3 CRC32_b2 CRC32_b1 CRC32_b0];
