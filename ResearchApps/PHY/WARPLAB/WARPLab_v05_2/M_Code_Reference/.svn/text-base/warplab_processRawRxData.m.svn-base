function [RxData,RxOTR] = warplab_processRawRxData(RawRxData)

%Mangle the received data
%Each received sample is a 32-bit value:
% [OTR_I 0 RX_I OTR_Q 0 RX_Q]
% OTR_I/OTR_Q: UFix1_0, incidates ADC overflow
% 0: UFix1_0, always zero
% RX_I/RX_Q: Fix14_13, raw ADC samples

rxData_I = uint16(bitshift(RawRxData, -16));
rxData_Q = uint16(bitand(RawRxData, hex2dec('0000FFFF')));

rxOTR_I = bitshift(rxData_I, -15);
rxOTR_Q = bitshift(rxData_Q, -15);

rxData_I = uint16(bitand(rxData_I, hex2dec('3FFF'))); %mask off top two bits
rxData_Isigns = uint16(bitshift(bitand(rxData_I, hex2dec('2000')), -13)); %get sign bit
rxData_I = double(typecast(bitor(rxData_I, rxData_Isigns*hex2dec('C000')),'int16'))./2^13;

rxData_Q = uint16(bitand(rxData_Q, hex2dec('3FFF'))); %mask off top two bits
rxData_Qsigns = uint16(bitshift(bitand(rxData_Q, hex2dec('2000')), -13)); %get sign bit
rxData_Q = double(typecast(bitor(rxData_Q, rxData_Qsigns*hex2dec('C000')),'int16'))./2^13;

RxData = complex(rxData_I, rxData_Q);
RxOTR = complex(rxOTR_I, rxOTR_Q);
