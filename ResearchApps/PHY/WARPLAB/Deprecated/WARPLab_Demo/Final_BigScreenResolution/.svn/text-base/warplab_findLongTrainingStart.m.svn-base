function [LongTrainingStart] = warplab_findLongTrainingStart(RxData,LongTrainingSymbols_up2,AGC_Set_Address)

% The long training symbols are used for timing synchronization

% The long training symbols (LongTrainingSymbols_up2) consist of two long
% symbols with a 64 sample cyclic prefix. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Step 0: Correlate with reference signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The long training symbols arrive within the 672 samples after the AGC
% sets the gains. Hence, to find the long training symbols we will only 
% consider the 672 samples after the AGC sets the gains. 
RxData_Window = RxData(AGC_Set_Address+1:AGC_Set_Address+672);

% Correlate the received signal (RxData_Window) with the long training
% symbols (LongTrainingSymbols_up2). Beacause of the symmetry of the
% LongTrainingSymbols_up2 signal we can use the conv() function to perform
% the correlation.

Conv = conv(RxData_Window,LongTrainingSymbols_up2);
Corr = abs(Conv);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Step 1: Find the two peaks in the Corr vector. These peaks indicate the
% end of a long symbol. The long training sysmbols consist of two long
% symbols
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[CorrSorted, CorrSortedIndices] = sort(Corr);
CorrSortedIndices=CorrSortedIndices(end:-1:1);
peak_1_index = CorrSortedIndices(1);
peak_2_index = CorrSortedIndices(2);
% The two peaks must be 64x2=128 samples away. One peak's correlation (for 
% example peak A) may be much higher or wider than the other one, resulting
% in two or more values around peak A being larger than peak B. In that 
% case variables peak_1_index and peak_2_index are only a few samples away,
% instead of 128 samples away. The following if statement checks that the two peak
% indexes peak_1_index and peak_2_index are not corresponding to the same
% peak. IF so it tries to correct and checks again, it corrects again and
% if the third check fails then it gives up.
if(128 ~= abs(peak_2_index-peak_1_index))
    peak_2_index = CorrSortedIndices(3);
end
if(128 ~= abs(peak_2_index-peak_1_index))
    peak_2_index = CorrSortedIndices(4);
end
if(128 ~= abs(peak_2_index-peak_1_index))
    peak_2_index = CorrSortedIndices(5);
end
if(128 ~= abs(peak_2_index-peak_1_index))
    disp('Invalid correlation values for timing synchronization !')
    peak1 = peak_1_index
    peak2 = peak_2_index
    peakdiff = peak_2_index-peak_1_index
end

if(peak_1_index > peak_2_index)
    var = peak_1_index;
    peak_1_index = peak_2_index;
    peak_2_index = var;
end

% Store Address where the first long symbol in the long training symbols 
% starts
FirstLongSymbol_Start = peak_1_index - 128;
% Long training symbols have a 64 sample cyclic prefix hence long training
% symbols start 64 samples before the first long symbol starts
LongTrainingStart = FirstLongSymbol_Start - 64;
% Take in count the AGC_Set_Address offset
LongTrainingStart = LongTrainingStart + AGC_Set_Address;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plotting for debugging purposes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure
% subplot(2,2,1)
% plot(real(Conv))
% subplot(2,2,2)
% plot(imag(Conv))
% subplot(2,2,3)
% plot(Corr)
% subplot(2,2,4)
% plot(angle(Conv))

