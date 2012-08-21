% File: mimo_channel_test.m
% -------------------------
% This script test the mimo_chan function from communication toolbox.

close all;
clear all;

ts = 10e-6; % sampling duration in seconds.
fd = 0;     % doppler frequency in hertz.
nt = 2;     % number of tx ant.
nr = 4;     % number of rx ant.

chan_mimo = mimochan(nt, nr, ts, fd);

pg = squeeze(chan_mimo.PathGains).'; % store path gains in channel matrix, nr x nt
pg_rx = sum(abs(pg).^2,2);           % path gains on each rx ant.
pg_tx = sum(abs(pg).^2,1);

% mimochan normalize power upon tx, 1 unit power transmitted at one
% tx ant. will be disseminated at each rx ant. with a total power of 1
% unit.

Ts = 10e-6;
doppler_max = 0;
path_delays_norm = 0;
pdp = 0;

chan = rayleighchan(Ts,doppler_max,path_delays_norm*Ts,pdp);




% End of script.