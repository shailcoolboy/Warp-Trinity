function datarec = warplab_sendCmd(udpSock, commands, packetNum)

for local_count = 1:length(commands)
    pktDataTx = [packetNum commands(local_count)];
    datarec(local_count,:) = warplab_pktSend(udpSock, pktDataTx);
end