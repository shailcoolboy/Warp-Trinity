%Assumes that a short symbol starts at time 0; everything else is
% paramaterized below
pktTiming_controlCounter_bits = 16; %ceil(log2(tx_packetLength))

%Structure of packet following detection
%Short symbols
pktTiming_ss_num = 6;
pktTiming_ss_length = length(shortSymbol_time);

%Long symbols
pktTiming_ls_num = 2;
pktTiming_ls_length = length(longSymbol_time);

%Long symbol cyclic prefix
pktTiming_lscp_length = 32;

%Symbol and Payload length
pktTiming_symbol_length = numSubcarriers + CPLength;
%pktTiming_payload_length = tx_symbolLength * tx_numSymbols;

%Counter values for various points in the packet structure
pktTiming_count_ssStart = 0;
pktTiming_count_lscpStart = (pktTiming_count_ssStart + pktTiming_ss_num*pktTiming_ss_length);
pktTiming_count_lsStart = (pktTiming_count_lscpStart + pktTiming_lscp_length);
pktTiming_count_payloadStart = pktTiming_count_lsStart + pktTiming_ls_num*pktTiming_ls_length;
%%pktTiming_count_packetDone = pktTiming_count_payloadStart + pktTiming_payload_length;

% Count values at which to capture the accumulator output
% Generate four ss_latchAccum pulses and one ls_latchAccum pulse
%  Ignore the last short symbol cross correlation to avoid problems with
%   possible correlating with the first few samples of the longsym prefix
freqSync_coarse_count_ss_latchAccum = 2+pktTiming_count_ssStart+pktTiming_ss_length+[pktTiming_ss_length : pktTiming_ss_length : (pktTiming_ss_num-2)*pktTiming_ss_length];
freqSync_coarse_count_ls_latchAccum = (-18) + 2+pktTiming_count_lsStart+pktTiming_ls_length+[pktTiming_ls_length:pktTiming_ls_length:(pktTiming_ls_num-1)*pktTiming_ls_length];
freqSync_coarse_count_latchAccum = [freqSync_coarse_count_ss_latchAccum freqSync_coarse_count_ls_latchAccum];

% Count values at which to reset the accumulator; these should precede pktTiming_coarse_ss_length accumulations by one cycle
%  Normally: [15 31 47 63 127]
freqSync_coarse_count_ss_accumReset = freqSync_coarse_count_ss_latchAccum - pktTiming_ss_length;
freqSync_coarse_count_ls_accumReset = freqSync_coarse_count_ls_latchAccum - pktTiming_ls_length;
freqSync_coarse_count_accumReset = [freqSync_coarse_count_ss_accumReset freqSync_coarse_count_ls_accumReset];

%Skip the first two short symbol accumulations - AGC doesn't settle in time to use all four
%freqSync_coarse_count_latchAccum = [freqSync_coarse_count_latchAccum(3:end) 0 0];
%freqSync_coarse_count_accumReset = [freqSync_coarse_count_accumReset(3:end) 0 0];

%Bypass this scheme for triggering the long-symbol calculaion
freqSync_coarse_count_latchAccum = [freqSync_coarse_count_latchAccum(3:end-1) 0 0 0];
freqSync_coarse_count_accumReset = [freqSync_coarse_count_accumReset(3:end-1) 0 0 0];

