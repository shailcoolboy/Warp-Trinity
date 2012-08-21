function result = warplab_setOptions(nodeHandles,options)
warplab_siso_defines

packetNum = 1;

%Send the SET_OPTIONS packets
pktDataTx = [packetNum SET_OPTIONS options];

 for n = [2:length(nodeHandles)]
 	datarec = warplab_pktSend(nodeHandles(n), pktDataTx);
end
