function hest = chan_est(input, ref, nsym_CP)
	
	input = input(nsym_CP+1:end);
	hest = fft(input)./ ref.';