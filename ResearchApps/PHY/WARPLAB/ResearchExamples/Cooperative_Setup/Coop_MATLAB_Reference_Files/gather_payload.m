function payload = gather_payload(rx, size_segment, nsym_pilot, npilots)

payload = zeros(length(rx)-2*nsym_pilot, 1);

for i = 1:1:nsym_pilot    
    tindex = 1+(size_segment+2)*(i-1);
    pindex = tindex+2;
    if (not(i == nsym_pilot)    )    
       payload(1+(i-1)*(size_segment):i*(size_segment))  = rx(pindex:pindex+size_segment-1);
    else
       payload(1+(i-1)*(size_segment):end)  = rx(pindex:end);
    end
end