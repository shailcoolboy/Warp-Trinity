function [GainsRF,GainsBB] = warplab_readAGCGains(nodeHandle)

warplab_defines_AGC

pktNoTx = 1;

% Set the packet to be sent to the WARP node
pktDataTx = [pktNoTx, READ_AGC_GAINS];

datarec = warplab_pktSend(nodeHandle, pktDataTx);
pktNoTx = pktNoTx+1;

RawGainData =  datarec(4);

%Process Raw Gain Data (RawGainData) to obtain meaningful gain values
%Mangle the received data
%Each received sample is a 32-bit value:
% [Gains_D Gains_C Gains_B Gains_A]
% Gains_A: [GainBB_A,GainRF_A]
% Gains_B: [GainBB_B,GainRF_B]
% Gains_C: [GainBB_C,GainRF_C]
% Gains_D: [GainBB_D,GainRF_D]
% Each GainsX is 8 bits:
% GainRF: 2 bits
% GainBB: 5 bits
% 1 unused bitv

Gains_A = uint16(bitand(RawGainData, hex2dec('000000FF')));
Gains_B = uint16(bitand(bitshift(RawGainData, -8),hex2dec('000000FF')));
Gains_C = uint16(bitand(bitshift(RawGainData, -16),hex2dec('000000FF')));
Gains_D = uint16(bitand(bitshift(RawGainData, -24),hex2dec('000000FF')));

GainRF_A = uint16(bitand(Gains_A,hex2dec('03')));
GainRF_B = uint16(bitand(Gains_B,hex2dec('03')));
GainRF_C = uint16(bitand(Gains_C,hex2dec('03')));
GainRF_D = uint16(bitand(Gains_D,hex2dec('03')));
GainsRF = [GainRF_A, GainRF_B, GainRF_C, GainRF_D];
GainsRF = double(GainsRF);

GainBB_A = uint16(bitand(Gains_A,hex2dec('FC')));
GainBB_B = uint16(bitand(Gains_B,hex2dec('FC')));
GainBB_C = uint16(bitand(Gains_C,hex2dec('FC')));
GainBB_D = uint16(bitand(Gains_D,hex2dec('FC')));
GainBB_A = uint16(bitshift(Gains_A,-2));
GainBB_B = uint16(bitshift(Gains_B,-2));
GainBB_C = uint16(bitshift(Gains_C,-2));
GainBB_D = uint16(bitshift(Gains_D,-2));
GainsBB = [GainBB_A, GainBB_B, GainBB_C, GainBB_D];
GainsBB = double(GainsBB);


