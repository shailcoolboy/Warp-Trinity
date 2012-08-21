function result = warplab_reset2x2Node(nodeHandle)

% Use this function to reset a node that is programmed with the 
% warplab_mimo_2x2_v03.bit bitstream.
warplab_defines

packetNum = 1;

% Make sure continuous transmission is stop
warplab_sendCmd(nodeHandle, TX_STOP, packetNum); % Resets the output and read 
% address of the transmitter buffer without disabling the transmitter
% radio. 

% Set parameters to default values
warplab_writeRegister(nodeHandle,TX_DELAY,0);
warplab_writeRegister(nodeHandle,TX_LENGTH,2^14-1);
warplab_writeRegister(nodeHandle,TX_MODE,0);

% Set all Tx buffers in node to Tx disabled mode
warplab_sendCmd(nodeHandle, [RADIO2TXBUFF_TXDIS, RADIO3TXBUFF_TXDIS], packetNum);

% Disable the transmitter radios
warplab_sendCmd(nodeHandle, [RADIO2_TXDIS, RADIO3_TXDIS], packetNum);

% Let the receiver know that system is ready for a new capture
warplab_sendCmd(nodeHandle, RX_DONEREADING, packetNum);

% Set all Rx buffers in node to Rx disabled mode
warplab_sendCmd(nodeHandle, [RADIO2RXBUFF_RXDIS, RADIO3RXBUFF_RXDIS], packetNum);

% Disable the receiver radios
warplab_sendCmd(nodeHandle, [RADIO2_RXDIS, RADIO3_RXDIS], packetNum);