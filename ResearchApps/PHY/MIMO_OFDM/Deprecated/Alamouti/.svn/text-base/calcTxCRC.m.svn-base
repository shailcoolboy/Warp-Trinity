function crcOut = calcTxCRC(thePacketBytes)
%Based on the C code example at:
%http://www.packet.cc/files/CRC32-code.html
CRCPolynomial = hex2dec('04c11db7');
CRC_Table = CRC_table_gen(CRCPolynomial);

init_crc = 0;
myData = thePacketBytes;

crc_accum = init_crc;
for n=1:length(myData)
	x = bitshift(crc_accum,-24,32);
	x = bitxor(x,myData(n));
	x = bitand(x,hex2dec('ff'));
	crc_accum = bitxor(bitshift(crc_accum,8,32),CRC_Table(x+1));
    crc_tracking(n) = crc_accum;
end

TxCRC32 = crc_accum;
TxCRC32_b3 = bitand(bitshift(TxCRC32,-24,32),hex2dec('ff'));
TxCRC32_b2 = bitand(bitshift(TxCRC32,-16,32),hex2dec('ff'));
TxCRC32_b1 = bitand(bitshift(TxCRC32,-8,32),hex2dec('ff'));
TxCRC32_b0 = bitand(TxCRC32,hex2dec('ff'));

crcOut = [TxCRC32_b3 TxCRC32_b2 TxCRC32_b1 TxCRC32_b0];
%crcOut = fliplr([TxCRC32_b3 TxCRC32_b2 TxCRC32_b1 TxCRC32_b0]);
