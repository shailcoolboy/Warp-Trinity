function result = warplab_setAGCParameter(nodeHandle,parameter_Id, parameter_Value)

packetNum = 1;

% Set the packet to be sent to the WARP node
pktDataTx = [packetNum, parameter_Id, parameter_Value];

datarec = warplab_pktSend(nodeHandle, pktDataTx);

