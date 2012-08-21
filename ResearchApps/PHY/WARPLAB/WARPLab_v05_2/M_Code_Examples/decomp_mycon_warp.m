function [c, ceq] = fdecomp_mycon(x)
    global numAE numCL Ptx;
    for k = 1:numAE
        c(k) = 0;
        for ii = 1:numCL
            for kk = 1:numAE
                if (kk ~= k) continue; end
                 
                ct = (ii-1)*numAE + kk;
                c(k) = c(k) + x(ct)^2;
                ct = ct + numCL*numAE;
                c(k) = c(k) + x(ct)^2;
            end
        end
         
        c(k) = c(k) - Ptx;
    end
    ceq = [];
     
