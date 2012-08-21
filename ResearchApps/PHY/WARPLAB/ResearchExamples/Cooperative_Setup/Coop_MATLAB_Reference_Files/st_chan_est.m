function [h1 h2] = st_chan_est(train_a, train_b, pilot_tone)

    %%%% estimating channel using space time code
    h1.raw = -(-conj(pilot_tone).*train_a + pilot_tone.*train_b)./2;
    h2.raw =  ( conj(pilot_tone).*train_a + pilot_tone.*train_b)./2;

    h1.angle = angle(h1.raw);
    h2.angle = angle(h2.raw);

    h1.diff = h1.angle(2:end) - h1.angle(1:end-1);
    h2.diff = h2.angle(2:end) - h2.angle(1:end-1);

    h1.wrap = abs(h1.diff)>pi;
    h2.wrap = abs(h2.diff)>pi;

    h1.diff = h1.diff - sign(h1.diff).*h1.wrap*2*pi;
    h2.diff = h2.diff - sign(h2.diff).*h2.wrap*2*pi;

    h1.drift = mean(h1.diff);
    h2.drift = mean(h2.diff);