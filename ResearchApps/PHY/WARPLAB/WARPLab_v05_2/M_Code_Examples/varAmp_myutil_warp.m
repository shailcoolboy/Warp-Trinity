function u = varAmp_myutil_warp(x)
    global numAE numCL w CHrt N0 v;
    u = 0;
    for i = 1:numCL 
        Prx = 0;
        for kk = 1:numAE
            Prx = Prx + CHrt(i, kk) * v(kk, i);
        end
        Prx = abs(Prx * Prx) * x(i);
        u = u + w(i) * log2(1 + Prx / N0);
    end
    u = -u;
