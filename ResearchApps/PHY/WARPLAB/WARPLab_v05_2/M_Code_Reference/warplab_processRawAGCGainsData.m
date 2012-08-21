function [GainsRF,GainsBB] = warplab_processRawAGCGainsData(RawGainData)

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
% 1 unused bit

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
% GainRF_A: RF gains set by radio on daughtercard slot 1
% GainRF_B: RF gains set by radio on daughtercard slot 2
% GainRF_C: RF gains set by radio on daughtercard slot 3
% GainRF_D: RF gains set by radio on daughtercard slot 4

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
% GainBB_A: BaseBand gains set by radio on daughtercard slot 1
% GainBB_B: BaseBand gains set by radio on daughtercard slot 2
% GainBB_C: BaseBand gains set by radio on daughtercard slot 3
% GainBB_D: BaseBand gains set by radio on daughtercard slot 4


