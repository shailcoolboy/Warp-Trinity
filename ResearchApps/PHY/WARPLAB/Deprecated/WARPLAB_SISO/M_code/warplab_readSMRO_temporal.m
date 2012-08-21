function [rxData_out rxOTR_out rxRSSI_out] = warplab_readSMRO(udpSock, radio, numSamples)

warplab_siso_defines

pktNoTx = 1;

rxCmd = eval(sprintf('RADIO%d_RXDATA', radio));
rssiCmd = eval(sprintf('RADIO%d_RSSIDATA', radio));

%Read the RxData from the selected radio
rxData = [];
for n = 0:256:numSamples-1
	pktDataTx = [pktNoTx rxCmd n];
	datarec = warplab_pktSend(udpSock, pktDataTx);
	pktNoTx = pktNoTx+1;

	rxData = [rxData uint32(datarec(5:end))];
end

%Read the RSSI data from the selected radio
rssiData = [];
for n = 0:256:(numSamples/8)-1
	pktDataTx = [pktNoTx rssiCmd n];
	datarec = warplab_pktSend(udpSock, pktDataTx);
	pktNoTx = pktNoTx+1;

	rssiData = [rssiData uint32(datarec(5:end))];
end

%Mangle the received data
%Each received sample is a 32-bit value:
% [OTR_I 0 RX_I OTR_Q 0 RX_Q]
% OTR_I/OTR_Q: UFix1_0, incidates ADC overflow
% 0: UFix1_0, always zero
% RX_I/RX_Q: Fix14_13, raw ADC samples

rxData_I = uint16(bitshift(rxData, -16));
rxData_Q = uint16(bitand(rxData, hex2dec('0000FFFF')));

rxOTR_I = bitshift(rxData_I, -15);
rxOTR_Q = bitshift(rxData_Q, -15);

rxData_I = uint16(bitand(rxData_I, hex2dec('3FFF'))); %mask off top two bits
rxData_Isigns = uint16(bitshift(bitand(rxData_I, hex2dec('2000')), -13)); %get sign bit
rxData_I = double(typecast(bitor(rxData_I, rxData_Isigns*hex2dec('C000')),'int16'))./2^13;

rxData_Q = uint16(bitand(rxData_Q, hex2dec('3FFF'))); %mask off top two bits
rxData_Qsigns = uint16(bitshift(bitand(rxData_Q, hex2dec('2000')), -13)); %get sign bit
rxData_Q = double(typecast(bitor(rxData_Q, rxData_Qsigns*hex2dec('C000')),'int16'))./2^13;

%Mangle the RSSI data
%Each received sample is a 32-bit value:
% [zeros(1,6) RSSI_0 zeros(1,6) RSSI_1]
% RSSI_0/RSSI_1: Consequtive RSSI samples; RSSI_0 is older
rssi = [mod(rssiData, 1024);mod(bitshift(rssiData,-16),1024)];

rxData_out = complex(rxData_I, rxData_Q);
rxOTR_out = complex(rxOTR_I, rxOTR_Q);
rxRSSI_out = reshape(rssi, 1, length(rssiData)*2);
