function datarec = warplab_sendCmd(udpSock, command, packetNum)

%Enable Rx Radio #2
pktDataTx = [packetNum command];
datarec = warplab_pktSend(udpSock, pktDataTx);
