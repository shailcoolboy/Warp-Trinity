h64 = firpm(63, [0 0.7813*.25 1.28*.25 1], [1 1 0 0], [1 .2]);
h64 = 0.99*(h64./max(h64));% .* filter_coeff_scaling;


%y = permute(reshape(x,4,4,4),[2 1 3]);
h64_rs = permute(reshape(h64(1:64),4,4,4),[2 1 3]);

h32 = firpm(31, [0 .75*.25 1.25*.25 1], [1 1 0 0], [1 .2]);
h32 = 0.95*h32./(max(h32));
h32_rs = h32;