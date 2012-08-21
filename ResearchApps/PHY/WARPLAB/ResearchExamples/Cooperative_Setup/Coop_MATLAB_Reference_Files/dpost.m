function [sync_error, num_errs num_bits hest relay_only source_only] = dpost(input_r, input_s,config,rrr_cnt)
CFO_matlab = config.CFO_matlab;
relay_only=0;
source_only=0;
sync_error = 1;
hest = [];
num_bits.SD = 0;
num_bits.ZF = 0;
num_errs.SD = 0;
num_errs.ZF = 0;

num_errs = 0;
num_bits = 0;
M_T = config.M_T;
nsamp = config.nsamp;
LongTrainingSyms_up2 = config.LongTrainingSyms_up2;
LongSymbol_time_up2 = config.LongSymbol_time_up2;
LongSymbol_time = config.LongSymbol_time;
LongSymbol_freq = config.LongSymbol_freq;
scale_LongTrainingSyms = config.scale_LongTrainingSyms;

filterorder = config.filtorder;
delay = config.delay;
rolloff = config.rolloff;
rrcfilter = config.rrcfilter;

nsym_preamble = config.nsym_preamble;
M = config.M;
h_mod = config.h_mod;
h_demod = config.h_demod;

k = log2(M);

size_segment = config.size_segment;
nsym_pilot   = config.nsym_pilot;
pilot_tone   =   config.pilot_tone;

stream1 = config.stream1;
stream2 = config.stream2;



%%%%%%%%%%%%%%%%%%%%% Relay:
time = [0:1:length(input_r{1})-1]/40e6; % Sampling Freq. is 40MHz
yrx1_bb = input_r{1} .* exp(-sqrt(-1)*2*pi*5e6*time);   %Downconvert to baseband
yrx2_bb = input_r{2} .* exp(-sqrt(-1)*2*pi*5e6*time);   %Downconvert to baseband

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 7. Filter the received signal with a Matched Filter (matched to the pulse
% shaping filter), detect preamble, and downsample output of Matched Filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Store received samples as a column vector
yrx1_bb = yrx1_bb.';
yrx2_bb = yrx2_bb.';

AGC_Set_Address = input_r{3};
AGC_Set_Address = AGC_Set_Address + 160;

LongSymbol_time_up2 = config.LongSymbol_time_up2;
[LongTrainingStart_1,ValidStart_1, R_Corr_1] = warplab_findLongTrainingStart(yrx1_bb,LongSymbol_time_up2,AGC_Set_Address);
% preamble_start_1 = LongTrainingStart + length(LongTrainingSyms_up2_norm)
preamble_start_1 = LongTrainingStart_1+32;
[LongTrainingStart_2,ValidStart_2, R_Corr_2] = warplab_findLongTrainingStart(yrx2_bb,LongSymbol_time_up2,AGC_Set_Address);
% preamble_start_2 = LongTrainingStart + length(LongTrainingSyms_up2_norm)
preamble_start_2 = LongTrainingStart_2+32;

sync_error_r = 0;
if (ValidStart_1 + ValidStart_2 < M_T)
    sync_error_r = 1;
    return
end


yrx1_bb_mf = rcosflt(yrx1_bb,1,nsamp,'Fs/filter',rrcfilter);
yrx2_bb_mf = rcosflt(yrx2_bb,1,nsamp,'Fs/filter',rrcfilter);

yrx1_bb_mf = yrx1_bb_mf(1+2*delay*nsamp:end);
yrx2_bb_mf = yrx2_bb_mf(1+2*delay*nsamp:end);


% Pull out rx vector and downsample
rx1 = downsample(yrx1_bb_mf(preamble_start_1+nsym_preamble*nsamp:end), nsamp);
rx2 = downsample(yrx2_bb_mf(preamble_start_2+nsym_preamble*nsamp:end), nsamp);

rx_size = min(length(rx1), length(rx2));

rx1 = rx1(1:rx_size);
rx2 = rx2(1:rx_size);

% Pull out pilot tones
[train_rx1_a train_rx1_b]= gather_pilots(rx1, size_segment,nsym_pilot);
[train_rx2_a train_rx2_b]= gather_pilots(rx2, size_segment,nsym_pilot);

% %%%% estimating channel
[h11 h21] = st_chan_est(train_rx1_a, train_rx1_b, pilot_tone);
[h12 h22] = st_chan_est(train_rx2_a, train_rx2_b, pilot_tone);

drift.tx1.avg = mean([h11.drift, h21.drift]);
drift.tx2.avg = mean([h12.drift, h22.drift]);

if CFO_matlab == 1
    rx1 = rx1 .* exp(sqrt(-1)*-drift.tx1.avg/(size_segment+2)*[0:1:length(rx1)-1]).';
    rx2 = rx2 .* exp(sqrt(-1)*-drift.tx2.avg/(size_segment+2)*[0:1:length(rx2)-1]).';

    h11.avg = sum(h11.raw .* exp(sqrt(-1)*-drift.tx1.avg*[0:1:length(h11.raw)-1]).')/length(h11.raw);
    h21.avg = sum(h21.raw .* exp(sqrt(-1)*-drift.tx1.avg*[0:1:length(h21.raw)-1]).')/length(h21.raw);

    h12.avg = sum(h12.raw .* exp(sqrt(-1)*-drift.tx2.avg*[0:1:length(h12.raw)-1]).')/length(h12.raw);
    h22.avg = sum(h22.raw .* exp(sqrt(-1)*-drift.tx2.avg*[0:1:length(h22.raw)-1]).')/length(h22.raw);
else

    h11.avg = sum(h11.raw)/length(h11.raw);
    h12.avg = sum(h12.raw)/length(h12.raw);
    h21.avg = sum(h21.raw)/length(h21.raw);
    h22.avg = sum(h22.raw)/length(h22.raw);
end

hest.R = [h11.avg h21.avg
    h12.avg h22.avg];
%Pull payload from rx1, rx2;
payload_rx1_R = gather_payload(rx1, size_segment, nsym_pilot);
payload_rx2_R = gather_payload(rx2, size_segment, nsym_pilot);


vec_length.R = size(payload_rx2_R);


%%%%%%%%%%%%%%%%%%%%% Source:
time = [0:1:length(input_s{1})-1]/40e6; % Sampling Freq. is 40MHz
yrx1_bb = input_s{1} .* exp(-sqrt(-1)*2*pi*5e6*time);   %Downconvert to baseband
yrx2_bb = input_s{2} .* exp(-sqrt(-1)*2*pi*5e6*time);   %Downconvert to baseband

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 7. Filter the received signal with a Matched Filter (matched to the pulse
% shaping filter), detect preamble, and downsample output of Matched Filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Store received samples as a column vector
yrx1_bb = yrx1_bb.';
yrx2_bb = yrx2_bb.';

AGC_Set_Address = input_s{3};
AGC_Set_Address = AGC_Set_Address + 160;

LongSymbol_time_up2 = config.LongSymbol_time_up2;
[LongTrainingStart_1,ValidStart_1, Corr_1] = warplab_findLongTrainingStart(yrx1_bb,LongSymbol_time_up2,AGC_Set_Address);
% preamble_start_1 = LongTrainingStart + length(LongTrainingSyms_up2_norm)
preamble_start_1 = LongTrainingStart_1+32;
[LongTrainingStart_2,ValidStart_2, Corr_2] = warplab_findLongTrainingStart(yrx2_bb,LongSymbol_time_up2,AGC_Set_Address);
% preamble_start_2 = LongTrainingStart + length(LongTrainingSyms_up2_norm)
preamble_start_2 = LongTrainingStart_2+32;


sync_error_d = 0;
if (ValidStart_1 + ValidStart_2 < M_T)
    sync_error_d = 1;
    return;
end

yrx1_bb_mf = rcosflt(yrx1_bb,1,nsamp,'Fs/filter',rrcfilter);
yrx2_bb_mf = rcosflt(yrx2_bb,1,nsamp,'Fs/filter',rrcfilter);

yrx1_bb_mf = yrx1_bb_mf(1+2*delay*nsamp:end);
yrx2_bb_mf = yrx2_bb_mf(1+2*delay*nsamp:end);


% Pull out rx vector and downsample
rx1 = downsample(yrx1_bb_mf(preamble_start_1+nsym_preamble*nsamp:end), nsamp);
rx2 = downsample(yrx2_bb_mf(preamble_start_2+nsym_preamble*nsamp:end), nsamp);

rx_size = min(length(rx1), length(rx2));

rx1 = rx1(1:rx_size);
rx2 = rx2(1:rx_size);

% Pull out pilot tones
[train_rx1_a train_rx1_b]= gather_pilots(rx1, size_segment,nsym_pilot);
[train_rx2_a train_rx2_b]= gather_pilots(rx2, size_segment,nsym_pilot);

% %%%% estimating channel
[h11 h21] = st_chan_est(train_rx1_a, train_rx1_b, pilot_tone);
[h12 h22] = st_chan_est(train_rx2_a, train_rx2_b, pilot_tone);

drift.tx1.avg = mean([h11.drift, h21.drift]);
drift.tx2.avg = mean([h12.drift, h22.drift]);

if CFO_matlab == 1
    rx1 = rx1 .* exp(sqrt(-1)*-drift.tx1.avg/(size_segment+2)*[0:1:length(rx1)-1]).';
    rx2 = rx2 .* exp(sqrt(-1)*-drift.tx2.avg/(size_segment+2)*[0:1:length(rx2)-1]).';

    h11.avg = sum(h11.raw .* exp(sqrt(-1)*-drift.tx1.avg*[0:1:length(h11.raw)-1]).')/length(h11.raw);
    h21.avg = sum(h21.raw .* exp(sqrt(-1)*-drift.tx1.avg*[0:1:length(h21.raw)-1]).')/length(h21.raw);

    h12.avg = sum(h12.raw .* exp(sqrt(-1)*-drift.tx2.avg*[0:1:length(h12.raw)-1]).')/length(h12.raw);
    h22.avg = sum(h22.raw .* exp(sqrt(-1)*-drift.tx2.avg*[0:1:length(h22.raw)-1]).')/length(h22.raw);
else

    h11.avg = sum(h11.raw)/length(h11.raw);
    h12.avg = sum(h12.raw)/length(h12.raw);
    h21.avg = sum(h21.raw)/length(h21.raw);
    h22.avg = sum(h22.raw)/length(h22.raw);
end

hest.S = [h11.avg h21.avg
    h12.avg h22.avg];
%Pull payload from rx1, rx2;
payload_rx1_S = gather_payload(rx1, size_segment, nsym_pilot);
payload_rx2_S = gather_payload(rx2, size_segment, nsym_pilot);

vec_length.S = size(payload_rx2_R);


r_vector = (transpose([payload_rx1_R(1:vec_length.R,1), payload_rx2_R(1:vec_length.R,1)]));
s_vector = (transpose([payload_rx1_S(1:vec_length.S,1), payload_rx2_S(1:vec_length.S,1)]));

if (length(s_vector) ~= length(r_vector))
    sync_error = 1;
    return;
end


white_filter = (config.sigma_2_sd*hest.S'*hest.S + config.sigma_2_rd*hest.R'*hest.R)^(-1/2);

y_received_matrix = white_filter * (hest.S'*s_vector + hest.R'*r_vector);
hest_equi = white_filter * (hest.S'*hest.S + hest.R'*hest.R);



%%%%% ZF
recv_payload_ZF = inv(hest_equi)*y_received_matrix*(sqrt(M)-1);
% demodulate
zsym_rx1 = qamdemod(recv_payload_ZF(1,:),M, 0, 'gray');
zsym_rx2 = qamdemod(recv_payload_ZF(2,:),M, 0, 'gray');
% Map Symbols to Bits
z1_ZF = de2bi(zsym_rx1,'left-msb'); % Convert integers to bits.
% Convert z from a matrix to a vector.
z1_ZF = reshape(z1_ZF.',prod(size(z1_ZF)),1);

z2_ZF = de2bi(zsym_rx2,'left-msb'); % Convert integers to bits.
% Convert z from a matrix to a vector.
z2_ZF = reshape(z2_ZF.',prod(size(z2_ZF)),1);

z1_ZF = z1_ZF(1:min(length(z1_ZF), length(stream1)));
z2_ZF = z2_ZF(1:min(length(z2_ZF), length(stream2)));

[number_of_errors.tx1.ZF,bit_error_rate.tx1.ZF] = biterr(stream1(1:length(z1_ZF)-10),z1_ZF(1:end-10));
[number_of_errors.tx2.ZF,bit_error_rate.tx2.ZF] = biterr(stream2(1:length(z2_ZF)-10),z2_ZF(1:end-10));

num_errs.ZF = number_of_errors.tx1.ZF+number_of_errors.tx2.ZF;
num_bits.ZF = length(z1_ZF)+length(z2_ZF)-20;

s_i = modulate(h_mod,[0:M-1])/(sqrt(M)-1);

det_l = vec_length.S(1);

recv_payload_SD = zeros(M_T,det_l);

for vec_len_cntr = 1 : config.nbits/config.k
    y_received = y_received_matrix(:,vec_len_cntr);
    recv_payload_SD(:,vec_len_cntr) = dfs_det (y_received, hest_equi, M, s_i, M_T);
end


z1_SD = de2bi(recv_payload_SD(1,:),'left-msb'); % Convert integers to bits.
% Convert z from a matrix to a vector.
z1_SD = reshape(z1_SD.',prod(size(z1_SD)),1);

z2_SD = de2bi(recv_payload_SD(2,:),'left-msb'); % Convert integers to bits.
% Convert z from a matrix to a vector.
z2_SD = reshape(z2_SD.',prod(size(z2_SD)),1);
z1_SD = z1_SD(1:min(length(z1_SD), length(stream1)));
z2_SD = z2_SD(1:min(length(z2_SD), length(stream2)));


% % Calculate bit error rate
% % Compare x and z to obtain the number of errors and the bit error rate
[number_of_errors.tx1.SD,bit_error_rate.tx1.SD] = biterr(stream1(1:length(z1_SD)-10),z1_SD(1:end-10));
[number_of_errors.tx2.SD,bit_error_rate.tx2.SD] = biterr(stream2(1:length(z2_SD)-10),z2_SD(1:end-10));

num_errs.SD = number_of_errors.tx1.SD+number_of_errors.tx2.SD;
num_bits.SD = length(z1_SD)+length(z2_SD)-20;

sync_error = sync_error_d+sync_error_r;

load tmp_var

%%%%%%%%%%%%%%%%%%%%%%%
%% detecting just based on the relay message and source message,
%% separately.
det_l = 50;

comb_only = norm(abs(modulate(h_mod, recv_payload_SD(1,1:det_l)) -  3*tx1_mod(1:det_l).'))+...
    norm(abs(modulate(h_mod, recv_payload_SD(2,1:det_l)) -  3*tx2_mod(1:det_l).'));
y_received_matrix = r_vector;
hest_equi = hest.R;
for vec_len_cntr = 1 : config.nbits/config.k
    y_received = y_received_matrix(:,vec_len_cntr);
    recv_payload_SD(:,vec_len_cntr) = dfs_det (y_received, hest_equi, M, s_i, M_T);
end
z1_SD = de2bi(recv_payload_SD(1,:),'left-msb'); % Convert integers to bits.
% Convert z from a matrix to a vector.
z1_SD = reshape(z1_SD.',prod(size(z1_SD)),1);

z2_SD = de2bi(recv_payload_SD(2,:),'left-msb'); % Convert integers to bits.
% Convert z from a matrix to a vector.
z2_SD = reshape(z2_SD.',prod(size(z2_SD)),1);
z1_SD = z1_SD(1:min(length(z1_SD), length(stream1)));
z2_SD = z2_SD(1:min(length(z2_SD), length(stream2)));
[number_of_errors.tx1.SD,bit_error_rate.tx1.SD] = biterr(stream1(1:length(z1_SD)-10),z1_SD(1:end-10));
[number_of_errors.tx2.SD,bit_error_rate.tx2.SD] = biterr(stream2(1:length(z2_SD)-10),z2_SD(1:end-10));

relay_only = number_of_errors.tx1.SD+number_of_errors.tx2.SD;


y_received_matrix = s_vector;
hest_equi = hest.S;
for vec_len_cntr = 1 : config.nbits/config.k
    y_received = y_received_matrix(:,vec_len_cntr);
    recv_payload_SD(:,vec_len_cntr) = dfs_det (y_received, hest_equi, M, s_i, M_T);
end

z1_SD = de2bi(recv_payload_SD(1,:),'left-msb'); % Convert integers to bits.
% Convert z from a matrix to a vector.
z1_SD = reshape(z1_SD.',prod(size(z1_SD)),1);
z2_SD = de2bi(recv_payload_SD(2,:),'left-msb'); % Convert integers to bits.
% Convert z from a matrix to a vector.
z2_SD = reshape(z2_SD.',prod(size(z2_SD)),1);
z1_SD = z1_SD(1:min(length(z1_SD), length(stream1)));
z2_SD = z2_SD(1:min(length(z2_SD), length(stream2)));
[number_of_errors.tx1.SD,bit_error_rate.tx1.SD] = biterr(stream1(1:length(z1_SD)-10),z1_SD(1:end-10));
[number_of_errors.tx2.SD,bit_error_rate.tx2.SD] = biterr(stream2(1:length(z2_SD)-10),z2_SD(1:end-10));

source_only = number_of_errors.tx1.SD+number_of_errors.tx2.SD;


