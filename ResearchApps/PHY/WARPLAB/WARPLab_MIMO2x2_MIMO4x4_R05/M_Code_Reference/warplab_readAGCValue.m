function value_out = warplab_readAGCValue(nodeHandle, register_Id)

pktNoTx = 1;

% Set the packet to be sent to the WARP node
pktDataTx = [pktNoTx, register_Id];

datarec = warplab_pktSend(nodeHandle, pktDataTx);
pktNoTx = pktNoTx+1;

value_out =  datarec(4);

