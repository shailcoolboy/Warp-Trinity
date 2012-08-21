function result = warplab_writeRegister(nodeHandle, register_Id, parameter_Value)

packetNum = 1;

ReadWrite = 1; % Set ReadWrite to 1 to write to register

% Set the packet to be sent to the WARP node
pktDataTx = [packetNum, register_Id, ReadWrite, parameter_Value];

datarec = warplab_pktSend(nodeHandle, pktDataTx);

