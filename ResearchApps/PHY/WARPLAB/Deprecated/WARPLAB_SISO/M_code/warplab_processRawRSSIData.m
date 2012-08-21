function [RxRSSI] = warplab_processRawRSSIData(RawRSSIData)

%Mangle the RSSI data
%Each received sample is a 32-bit value:
% [zeros(1,6) RSSI_0 zeros(1,6) RSSI_1]
% RSSI_0/RSSI_1: Consequtive RSSI samples; RSSI_0 is older
rssi = [mod(RawRSSIData, 1024);mod(bitshift(RawRSSIData,-16),1024)];

RxRSSI = reshape(rssi, 1, length(RawRSSIData)*2);
