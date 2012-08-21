function result = warplab_initNodes(nodeHandles)
warplab_siso_defines

packetNum = 1;

%Send the SYNC packet to clear any stale triggers
warplab_sendSync(nodeHandles(1));

%Send the INITIALIZE packets
for n = [2:length(nodeHandles)]
	warplab_sendCmd(nodeHandles(n), INITIALIZE, packetNum);
end
