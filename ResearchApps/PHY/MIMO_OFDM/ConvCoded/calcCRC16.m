function crcOut = calcCRC16(thePacketBytes)
%Based on the C code example at:
%http://www.netrino.com/Embedded-Systems/How-To/CRC-Calculation-C-Code
%Uses CRC-CCIT standard checksum polynomial/formatting

CRCPolynomial = hex2dec('1021');
CRC_Table = CRC_table_gen(CRCPolynomial, 16);

%init_crc = hex2dec('FFFF');
init_crc = 0;
myData = thePacketBytes;

crc_accum = init_crc;
for n=1:length(myData)
	x = bitshift(crc_accum,-8,16);
	x = bitxor(x, myData(n));
	x = bitand(x,hex2dec('ff'));
	crc_accum = bitxor(bitshift(crc_accum,8,16),CRC_Table(x+1));
    crc_tracking(n) = crc_accum;
end

TxCRC16 = bitand(crc_accum, hex2dec('ffff'));

TxCRC16_b1 = bitand(bitshift(TxCRC16,-8,32),hex2dec('ff'));
TxCRC16_b0 = bitand(TxCRC16,hex2dec('ff'));

crcOut = [TxCRC16_b1 TxCRC16_b0];
