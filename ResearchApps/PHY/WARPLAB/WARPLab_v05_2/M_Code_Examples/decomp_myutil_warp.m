function u = fdecomp_myutil(x)
    global numAE numCL wt CHrt N0;
    u = 0;
    for i = 1:numCL
        Prx = 0;
        for ii = 1:numCL
            for kk = 1:numAE
                ct = (ii-1)*numAE + kk;
                Prx = Prx + real(CHrt(ii, kk)) * x(ct);
                ct = ct + numCL*numAE;
                Prx = Prx - imag(CHrt(ii, kk)) * x(ct);
            end
        end 
        Prx = Prx*Prx;
        u = u + wt(i) * log2(1 + Prx / N0);
    end
    u = -u;
