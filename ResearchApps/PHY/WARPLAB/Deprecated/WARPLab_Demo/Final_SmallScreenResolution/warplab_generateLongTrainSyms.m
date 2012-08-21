function [LongTrainingSyms_up2,LongSymbol_time_up2,LongSymbol_time,LongSymbol_freq] = warplab_generateLongTrainingSyms

% Generate one long training symbol
LongSymbol_freq_bot = [0 0 0 0 0 0 1 1 -1 -1 1 1 -1 1 -1 1 1 1 1 1 1 -1 -1 1 1 -1 1 -1 1 1 1 1]';
LongSymbol_freq_top = [1 -1 -1 1 1 -1 1 -1 1 -1 -1 -1 -1 -1 1 1 -1 -1 1 -1 1 -1 1 1 1 1 0 0 0 0 0]';
LongSymbol_freq = [LongSymbol_freq_bot ; 0 ; LongSymbol_freq_top];
LongSymbol_time = ifft(fftshift(LongSymbol_freq)).';
LongSymbol_time_up2 = interp(LongSymbol_time,2); % Upsample by 2. This is 
% the reference sequence that will be used for timing synchronization. It
% is upsampled by 2 so that the signal has the desired bandwidth (~20MHz)
scale = 1/max([ max(abs(real(LongSymbol_time_up2))), max(abs(imag(LongSymbol_time_up2))) ]);
LongSymbol_time_up2 = scale * LongSymbol_time_up2;

% Concatenate two long training symbols and add cyclic prefix
%longsyms_2_cp = [longSymbol_time(33:64) repmat(longSymbol_time,1,2)];
%longsyms_2_cp_up2 = interp(longsyms_2_cp,2); % Upsample by 2
LongTrainingSyms_up2 = [LongSymbol_time_up2(65:128) repmat(LongSymbol_time_up2,1,2)];

% Concatenate long training symbols with payload
%DataVecOUT = [longsyms_2_cp_up2 DataVecIN];
% 
% figure
% subplot(2,2,1)
% plot(real(LongSymbol_time_up2))
% subplot(2,2,2)
% plot(imag(LongSymbol_time_up2))
% subplot(2,2,3)
% plot(abs(LongSymbol_time_up2))
% subplot(2,2,4)
% plot(angle(LongSymbol_time_up2))
