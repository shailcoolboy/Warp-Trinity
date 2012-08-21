function [rawData] = warplab_readSMRO(udpSock, SMRO_id, numSamples)

warplab_siso_defines

pktNoTx = 1;

% rxCmd = eval(sprintf('RADIO%d_RXDATA', radio));
% rssiCmd = eval(sprintf('RADIO%d_RSSIDATA', radio));

%Read the raw samples from the selected SMRO
rawData = [];
for n = 0:256:numSamples-1
	pktDataTx = [pktNoTx SMRO_id n];
	datarec = warplab_pktSend(udpSock, pktDataTx);
	pktNoTx = pktNoTx+1;

	rawData = [rawData uint32(datarec(5:end))];
end

