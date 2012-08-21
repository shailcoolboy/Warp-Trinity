config.M_T = 2;
config.nsamp = 128;
[config.LongTrainingSyms_up2,config.LongSymbol_time_up2,config.LongSymbol_time,config.LongSymbol_freq,config.scale_LongTrainingSyms] = warplab_generateLongTrainSyms;

config.filtorder = 1024;               % Filter order
config.delay = config.filtorder/(config.nsamp*2);  % Group delay (# of input samples).
config.rolloff = 0.3;                % Rolloff factor of filter
config.rrcfilter = rcosine(1,config.nsamp,'fir/sqrt',config.rolloff,config.delay); % Create SRRC filter

config.nsym_preamble = length(config.LongTrainingSyms_up2)/config.nsamp;                           % Number of preamble symbols
config.M = 16;
config.h_mod = modem.qammod('M', config.M, 'SymbolOrder', 'Gray');
config.h_demod = modem.qamdemod(config.h_mod);

config.CarrierChannel = 4;

config.emulator_select = 1; %if '1', then emulator is used.

config.TX_gain= 40;

config.CFO_matlab = 0;

%figure out tx1 length;

%config.size_segment = floor(length(txin)/num_pilot);