function [h] = st_chan_est_gen(ref_a, ref_b, rx)

h = [];

%%%% estimating channel using space time code

for ii = 1:length(ref_a)
    x = [ref_a(ii) -conj(ref_b(ii));ref_b(ii) conj(ref_a(ii))];
    r = rx(:,ii*2-1:ii*2);
    h (:,:,ii)= [r*inv(x)];
end



