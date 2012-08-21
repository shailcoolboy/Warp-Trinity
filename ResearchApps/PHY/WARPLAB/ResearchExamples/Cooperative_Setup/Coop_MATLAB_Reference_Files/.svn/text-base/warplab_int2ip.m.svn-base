function dottedIPout = warplab_int2IP(intIn)

addrChars(4) = mod(intIn, 2^8);
addrChars(3) = mod(bitshift(intIn, -8), 2^8);
addrChars(2) = mod(bitshift(intIn, -16), 2^8);
addrChars(1) = mod(bitshift(intIn, -24), 2^8);

dottedIPout = sprintf('%d.%d.%d.%d', addrChars);
