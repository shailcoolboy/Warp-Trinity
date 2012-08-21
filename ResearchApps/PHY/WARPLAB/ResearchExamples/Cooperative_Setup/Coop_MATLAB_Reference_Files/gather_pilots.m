function [rx_a rx_b] = gather_pilots(rx, size_segment, nsym_pilot)
rx_a = zeros(nsym_pilot,1);
rx_b = zeros(nsym_pilot,1);


for i = 1:1:nsym_pilot
    tindex = 1+(size_segment+2)*(i-1);
    
    rx_a(i) = rx(tindex);
    rx_b(i) = rx(tindex+1);
end

