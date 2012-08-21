n = 1;
srca = randn(1,n)+sqrt(-1)*randn(1,n);
srcb = randn(1,n)+sqrt(-1)*randn(1,n);

tx1 = zeros(1,length(srca)*2);

tx2 = zeros(1,length(srca)*2);



tx1(1:2:end) = srca;

tx1(2:2:end) = -conj(srcb);

tx2(1:2:end) = srcb;

tx2(2:2:end) = conj(srca);



h = rand(2,2)+sqrt(-1)*rand(2,2);



rx = h*[tx1; tx2];



%zz = inv(h)*rx;







[h2] = st_chan_est_gen(srca, srcb, rx);



