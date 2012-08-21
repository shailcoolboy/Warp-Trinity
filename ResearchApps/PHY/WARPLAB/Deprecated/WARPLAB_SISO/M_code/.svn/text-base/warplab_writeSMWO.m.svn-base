function pktNoTx = warplab_writeSMWO(udpSock, TxData, SMWO_id)

warplab_siso_defines

pktNoTx = 1;

if(length(TxData) > 2^14)
	disp('ERROR: TxData must contain 16384 (2^14) samples maximum!');
	return;
end

maxPayloadBytesPerPkt = 1024;

TxData_I_fi = int16(real(TxData)*2^15);
TxData_Q_fi = int16(imag(TxData)*2^15);

TxPktData = 2^16.*int32(TxData_I_fi) + int32(TxData_Q_fi);

%length(TxPktData) is the number of samples, each of which is a 32-bit value
%We'll send UDP packets with payloads of 1024 bytes, or 256 samples
%This results in a maximum of 64 UDP packets to download a full TxData

numPkts = ceil(length(TxPktData)*4/maxPayloadBytesPerPkt);

for n = 0:numPkts-1
	indexStart = ((n*maxPayloadBytesPerPkt/4)+1);
	indexEnd = min(length(TxPktData),((n+1)*maxPayloadBytesPerPkt/4));
	dataToSendTx = [pktNoTx SMWO_id indexStart-1 TxPktData(indexStart:indexEnd)];
	datarec = warplab_pktSend(udpSock, dataToSendTx);

	pktNoTx = pktNoTx+1;
end
