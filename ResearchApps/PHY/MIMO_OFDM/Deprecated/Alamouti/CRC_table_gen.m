function CRC_Table = CRC_table_gen(CRCPolynomial)

%Based on the C code example at:
%http://www.packet.cc/files/CRC32-code.html


crc_accum = 0;
for n=0:255
	crc_accum = bitshift(n,24,32); %(unsigned long)(i<<24)
	
	for m=0:7
		x = bitshift(crc_accum,1,32);
		if(crc_accum >= 2^31)
			crc_accum = bitxor(x,CRCPolynomial);
		else
			crc_accum = x;
		end
	end

	CRC_Table(n+1) = crc_accum;
end
