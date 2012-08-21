% Plot first 80 transmitted bits and first 80 received bits in a stem plot
figure;
subplot(2,1,1)
stem(x(1:80),'filled');
title('Transmitted Bits');
xlabel('Bit Index'); ylabel('Binary Value');
subplot(2,1,2)
stem(z(1:80),'filled');
title('Received Bits');
xlabel('Bit Index'); ylabel('Binary Value');

% Plot transmitted and received constellations

% Scatter Plot of received and transmitted constellation points
% h = scatterplot(yrx_bb_mf_ds(nsym_preamble+1:end),1,0,'g.');
h = scatterplot(yrx_bb_mf_ds_mrc_norm,1,0,'g.');
hold on;
%scatterplot(ytx_mod_norm(nsym_preamble+1:end),1,0,'k*',h);
scatterplot(ytx_mod_norm,1,0,'k*',h);
title('Constellations');
legend('Received','Transmitted');
axis([-2 2 -2 2]); % Set axis ranges.
hold off;

% Plot first 80 transmitted bits and first 80 received bits in a stem plot
figure;
subplot(2,1,1)
stem(x(1:80),'filled');
title('Transmitted Bits');
xlabel('Bit Index'); ylabel('Binary Value');
subplot(2,1,2)
stem(z(1:80),'filled');
title('Received Bits');
xlabel('Bit Index'); ylabel('Binary Value');

% Plot transmitted and received constellations

% Scatter Plot of received and transmitted constellation points
% h = scatterplot(yrx_bb_mf_ds_alm_norm(nsym_preamble+1:end),1,0,'g.');
h = scatterplot(yrx_bb_mf_ds_alm_norm,1,0,'g.');
hold on;
%scatterplot(ytx_mod_norm(nsym_preamble+1:end),1,0,'k*',h);
scatterplot(ytx_mod_norm,1,0,'k*',h);
title('Constellations');
legend('Received','Transmitted');
axis([-2 2 -2 2]); % Set axis ranges.
hold off;