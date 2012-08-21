function value_out = warplab_readRegister(nodeHandle, register_Id)

pktNoTx = 1;

ReadWrite = 0; % Set ReadWrite to 0 to read register

% Set the packet to be sent to the WARP node
pktDataTx = [pktNoTx, register_Id, ReadWrite];

datarec = warplab_pktSend(nodeHandle, pktDataTx);
pktNoTx = pktNoTx+1;

value_out =  datarec(4);

