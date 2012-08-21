for SNR = 50:-5:0

	SNR_sd = SNR - round( 10*log10(PowerRatio_s) + 10*log10(1/(d_sd^alphacoeff)) );
	SNR_sr = SNR_sd;
	SNR_rd = SNR_sd;
	
	if (SNR_sd>0 & SNR_sr>0 & SNR_rd>0)
		atten_A = ['00 atten_set C1-A {' int2str(SNR_sd) ' ' int2str(SNR_sr) ' ' int2str(SNR_sr) ' ' int2str(SNR_sd) '}\r']
		atten_B = ['00 atten_set C1-B {' int2str(SNR_rd) ' ' int2str(SNR_rd) ' ' int2str(SNR_rd) ' ' int2str(SNR_rd) '}\r']
		
		pnet(emulatorHandle, 'printf', ['00 atten_set C1-A {' int2str(SNR_sd) ' ' int2str(SNR_sr) ' ' int2str(SNR_sr) ' ' int2str(SNR_sd) '}\r']);
		pause(3)
		pnet(emulatorHandle, 'printf', ['00 atten_set C1-B {' int2str(SNR_rd) ' ' int2str(SNR_rd) ' ' int2str(SNR_rd) ' ' int2str(SNR_rd) '}\r']);
		pause(3)
		
		n_err_total_RSD = 0;
		n_err_total_RZF = 0;

		n_bits_RSD = 0;
		n_bits_RZF = 0;

		for pack_counter = 1:1e7
			toc
			pnet(emulatorHandle, 'printf', ['00 atten_set C1-A {' int2str(SNR_sd) ' ' int2str(SNR_sr) ' ' int2str(SNR_sr) ' ' int2str(SNR_sd) '}\r']);
			pause(3)
			pnet(emulatorHandle, 'printf', ['00 atten_set C1-B {' int2str(SNR_rd) ' ' int2str(SNR_rd) ' ' int2str(SNR_rd) ' ' int2str(SNR_rd) '}\r']);
			pause(3)

			coop_setup;
			[r,d, config] = s2rd(config);
			[sync_error, num_errs, num_bits] = dpost_no_relay(r, config);

				
			if (sync_error == 0)
				n_err_total_RSD = n_err_total_RSD + num_errs.SD;
				n_err_total_RZF = n_err_total_RZF + num_errs.ZF;

				n_bits_RSD = n_bits_RSD + num_bits.SD;
				n_bits_RZF = n_bits_RZF + num_bits.ZF;
			end

			savefile = (['pp_myerror', '_', num2str(PowerRatio_s), '_', num2str(SNR)])
			save (savefile);
			
		
			if (n_err_total_RZF > max_n_err && n_err_total_RSD >max_n_err)
				if pack_counter>pack_counter_max
					break;
				end
			end

		
		end

	end
end





