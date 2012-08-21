
% Stem Plot of signal before Matched Filter, after Matched Filter, and 
% after downsampling 
% Plots first 30 symbols. 
% Plots real and imaginary parts in different windows
figure; % Create new figure window.
subplot(2,1,1)
stem(real(yrx_bb_1(first_sample_index-(1+delay*nsamp_PerSymb):first_sample_index-(1+delay*nsamp_PerSymb)+30*nsamp_PerSymb)),'b');
% stem(real(yrx_bb(1+2*delay*nsamp+first_sample_index:1+2*delay*nsamp+...
%                                        first_sample_index+30*nsamp)),'b');
hold
stem(real(yrx_bb_mf_1(first_sample_index:first_sample_index+30*nsamp_PerSymb)),'r');
stem([1:nsamp_PerSymb:nsamp_PerSymb*30],real(yrx_bb_mf_ds_1(1:30)),'k');
title('I Symbols Rx1');
xlabel('n (sample)'); ylabel('Amplitude');
legend('Before Matched Filter','After Matched Filter','After Downsample');
subplot(2,1,2)
stem(imag(yrx_bb_1(first_sample_index-(1+delay*nsamp_PerSymb):first_sample_index-(1+delay*nsamp_PerSymb)+30*nsamp_PerSymb)),'b');
hold
stem(imag(yrx_bb_mf_1(first_sample_index:first_sample_index+30*nsamp_PerSymb)),'r');
stem([1:nsamp_PerSymb:nsamp_PerSymb*30],imag(yrx_bb_mf_ds_1(1:30)),'k');
title('Q Symbols Rx 1');
xlabel('n (sample)'); ylabel('Amplitude');

% Stem Plot of signal before Matched Filter, after Matched Filter, and 
% after downsampling 
% Plots first 30 symbols. 
% Plots real and imaginary parts in different windows
figure; % Create new figure window.
subplot(2,1,1)
stem(real(yrx_bb_2(first_sample_index-(1+delay*nsamp_PerSymb):first_sample_index-(1+delay*nsamp_PerSymb)+30*nsamp_PerSymb)),'b');
% stem(real(yrx_bb(1+2*delay*nsamp+first_sample_index:1+2*delay*nsamp+...
%                                        first_sample_index+30*nsamp)),'b');
hold
stem(real(yrx_bb_mf_2(first_sample_index:first_sample_index+30*nsamp_PerSymb)),'r');
stem([1:nsamp_PerSymb:nsamp_PerSymb*30],real(yrx_bb_mf_ds_2(1:30)),'k');
title('I Symbols Rx1');
xlabel('n (sample)'); ylabel('Amplitude');
legend('Before Matched Filter','After Matched Filter','After Downsample');
subplot(2,1,2)
stem(imag(yrx_bb_2(first_sample_index-(1+delay*nsamp_PerSymb):first_sample_index-(1+delay*nsamp_PerSymb)+30*nsamp_PerSymb)),'b');
hold
stem(imag(yrx_bb_mf_2(first_sample_index:first_sample_index+30*nsamp_PerSymb)),'r');
stem([1:nsamp_PerSymb:nsamp_PerSymb*30],imag(yrx_bb_mf_ds_2(1:30)),'k');
title('Q Symbols Rx 1');
xlabel('n (sample)'); ylabel('Amplitude');

% Stem Plot of signal before Matched Filter, after Matched Filter, and 
% after downsampling 
% Plots first 30 symbols. 
% Plots real and imaginary parts in different windows
figure; % Create new figure window.
subplot(2,1,1)
stem(real(yrx_bb_3(first_sample_index-(1+delay*nsamp_PerSymb):first_sample_index-(1+delay*nsamp_PerSymb)+30*nsamp_PerSymb)),'b');
% stem(real(yrx_bb(1+2*delay*nsamp+first_sample_index:1+2*delay*nsamp+...
%                                        first_sample_index+30*nsamp)),'b');
hold
stem(real(yrx_bb_mf_3(first_sample_index:first_sample_index+30*nsamp_PerSymb)),'r');
stem([1:nsamp_PerSymb:nsamp_PerSymb*30],real(yrx_bb_mf_ds_3(1:30)),'k');
title('I Symbols Rx1');
xlabel('n (sample)'); ylabel('Amplitude');
legend('Before Matched Filter','After Matched Filter','After Downsample');
subplot(2,1,2)
stem(imag(yrx_bb_3(first_sample_index-(1+delay*nsamp_PerSymb):first_sample_index-(1+delay*nsamp_PerSymb)+30*nsamp_PerSymb)),'b');
hold
stem(imag(yrx_bb_mf_3(first_sample_index:first_sample_index+30*nsamp_PerSymb)),'r');
stem([1:nsamp_PerSymb:nsamp_PerSymb*30],imag(yrx_bb_mf_ds_3(1:30)),'k');
title('Q Symbols Rx 1');
xlabel('n (sample)'); ylabel('Amplitude');

% Stem Plot of signal before Matched Filter, after Matched Filter, and 
% after downsampling 
% Plots first 30 symbols. 
% Plots real and imaginary parts in different windows
figure; % Create new figure window.
subplot(2,1,1)
stem(real(yrx_bb_4(first_sample_index-(1+delay*nsamp_PerSymb):first_sample_index-(1+delay*nsamp_PerSymb)+30*nsamp_PerSymb)),'b');
% stem(real(yrx_bb(1+2*delay*nsamp+first_sample_index:1+2*delay*nsamp+...
%                                        first_sample_index+30*nsamp)),'b');
hold
stem(real(yrx_bb_mf_4(first_sample_index:first_sample_index+30*nsamp_PerSymb)),'r');
stem([1:nsamp_PerSymb:nsamp_PerSymb*30],real(yrx_bb_mf_ds_4(1:30)),'k');
title('I Symbols Rx1');
xlabel('n (sample)'); ylabel('Amplitude');
legend('Before Matched Filter','After Matched Filter','After Downsample');
subplot(2,1,2)
stem(imag(yrx_bb_4(first_sample_index-(1+delay*nsamp_PerSymb):first_sample_index-(1+delay*nsamp_PerSymb)+30*nsamp_PerSymb)),'b');
hold
stem(imag(yrx_bb_mf_4(first_sample_index:first_sample_index+30*nsamp_PerSymb)),'r');
stem([1:nsamp_PerSymb:nsamp_PerSymb*30],imag(yrx_bb_mf_ds_4(1:30)),'k');
title('Q Symbols Rx 1');
xlabel('n (sample)'); ylabel('Amplitude');

% Scatter Plot of received and transmitted constellation points
% h = scatterplot(yrx_bb_mf_ds(nsym_preamble+1:end),1,0,'g.');
h = scatterplot(yrx_bb_mf_ds_mrc_norm,1,0,'g.');
hold on;
%scatterplot(ytx_mod(nsym_preamble+1:end),1,0,'k*',h);
scatterplot(ytx_mod,1,0,'k*',h);
title('Constellations');
legend('Received','Transmitted');
axis([-2 2 -2 2]); % Set axis ranges.
hold off;

% 
% % Scatter Plot of received and transmitted constellation points
% % h = scatterplot(yrx_bb_mf_ds(nsym_preamble+1:end),1,0,'g.');
% h = scatterplot(yrx_bb_mf_ds_1,1,0,'g.');
% hold on;
% %scatterplot(ytx_mod(nsym_preamble+1:end),1,0,'k*',h);
% scatterplot(ytx_mod,1,0,'k*',h);
% title('Constellations');
% legend('Received','Transmitted');
% axis([-2 2 -2 2]); % Set axis ranges.
% hold off;
