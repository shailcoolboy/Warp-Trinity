function intOut = warplab_IP2int(dottedIP)

addrChars = sscanf(dottedIP, '%d.%d.%d.%d')';
intOut = 2^0 * addrChars(4) + 2^8 * addrChars(3) + 2^16 * addrChars(2) + 2^24 * addrChars(1);