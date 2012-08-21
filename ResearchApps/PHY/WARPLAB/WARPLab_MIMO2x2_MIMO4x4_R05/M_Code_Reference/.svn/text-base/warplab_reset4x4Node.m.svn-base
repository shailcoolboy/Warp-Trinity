function result = warplab_reset4x4Node(nodeHandle)

% Use this function to reset a node that is programmed with the 
% warplab_mimo_4x4_v03.bit bitstream.
warplab_defines

packetNum = 1;

% Set parameters to default values
warplab_writeRegister(nodeHandle,CAPT_OFFSET,0);
warplab_writeRegister(nodeHandle,TX_LENGTH,2^14-1);


% Set all Tx buffers in node to Tx disabled mode
warplab_sendCmd(nodeHandle, [RADIO1TXBUFF_TXDIS, RADIO2TXBUFF_TXDIS, RADIO3TXBUFF_TXDIS, RADIO4TXBUFF_TXDIS], packetNum);

% Disable the transmitter radios
warplab_sendCmd(nodeHandle, [RADIO1_TXDIS, RADIO2_TXDIS, RADIO3_TXDIS, RADIO4_TXDIS], packetNum);

% Let the receiver know that system is ready for a new capture
warplab_sendCmd(nodeHandle, RX_DONEREADING, packetNum);

% Set all Rx buffers in node to Rx disabled mode
warplab_sendCmd(nodeHandle, [RADIO1RXBUFF_RXDIS, RADIO2RXBUFF_RXDIS, RADIO3RXBUFF_RXDIS, RADIO4RXBUFF_RXDIS], packetNum);

% Disable the receiver radios
warplab_sendCmd(nodeHandle, [RADIO1_RXDIS, RADIO2_RXDIS, RADIO3_RXDIS, RADIO4_RXDIS], packetNum);
