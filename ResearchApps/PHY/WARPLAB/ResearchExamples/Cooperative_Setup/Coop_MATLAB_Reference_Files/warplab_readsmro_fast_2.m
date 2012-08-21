function [rawData] = warplab_readSMRO_fast_2(udpSock, SMRO_id, numSamples)

pktNoTx = 1;

% rxCmd = eval(sprintf('RADIO%d_RXDATA', radio));
% rssiCmd = eval(sprintf('RADIO%d_RSSIDATA', radio));

%Read the raw samples from the selected SMRO
rawData = zeros(1,2^12); %2^14 / 4 return values

%	pktDataTx = [pktNoTx SMRO_id n];
%	datarec = warplab_pktSend(udpSock, pktDataTx);


%Set the bulk transfer request
%This will return an integral number of UDP packets, each containing 256 samples
%Argument 3 defines the first "block" of 256 samples to return (indexed from 0)
%Argument 4 defines the number of blocks to return
%Argument 5 defines the inter-packet delay imposed by the FPGA
pktDataTx = [pktNoTx SMRO_id 0 ceil(numSamples/256) 0];

%Use the new pnet command to receive all the packets in one call, returning a single vector with all 2^14 samples
rawData = pnet(udpSock, 'bulkRxBuff', int32(pktDataTx));

%Each packet contains 256 samples, preceded by 4 control values:
%[pktNum ACK command sampOffset]
%sampOffset is the sample number (zero indexed) of the first sample in that packet
pktStarts = 1:260:length(rawData);

%Extract the sampOffset values from every received packet
% receivedOffsets = rawData(pktStarts + 3);
% if(sum(receivedOffsets) ~= sum(0:256:numSamples-1)) %does this handle all cases of numSamples?!
% %if(~isempty(setdiff(receivedOffsets, [1:256:length(rawData)])))
% 	%Error! At least one sampOffset is missing
% 	%Start an old-fashioned 1-by-1 download and return that
% 	%Assumes non-bulk CMD ID is 100 less (in warplab_defines.m)
% 	rawData = warplab_readSMRO(udpSock, (SMRO_id-100), numSamples);
% 	return;
% end

valsToIngore = [pktStarts pktStarts+1 pktStarts+2 pktStarts+3];
rawData = rawData(setdiff([1:length(rawData)], valsToIngore));

if(numSamples < length(rawData))
	rawData = rawData(1:numSamples);
end
