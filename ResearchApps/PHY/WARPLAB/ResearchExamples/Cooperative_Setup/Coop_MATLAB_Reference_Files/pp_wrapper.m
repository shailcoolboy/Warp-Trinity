clear all;clc;
warning off;


d_sd = 1;
d_sr = 0.2;
d_rd = d_sd - d_sr;
alphacoeff = 3;

max_n_err = 1000;
pack_counter_max = 75;


%setup socket handles for WARPLAB
% Create Socket handles and intialize nodes
[config.socketHandles, config.packetNum] = warplab_initialize(3);
disp('finished warplab config');
%setup socket handles for the Emulator
ACE400WB_test
pause(2)
pnet(emulatorHandle, 'printf', '00 ace_set_input_power C1-A {8 8 8 8}\r');
pause(2)
pnet(emulatorHandle, 'printf', '00 ace_set_input_power C1-B {8 8 8 8}\r');
pause(2)
disp('finished emulator config');
tic;
PowerRatio_s = 1.0;

for SNR = 50:-5:20

	SNR_sd = SNR - round( 10*log10(PowerRatio_s) + 10*log10(1/(d_sd^alphacoeff)) );
	SNR_sr = SNR_sd;
	SNR_rd = SNR_sd;
	
	[SNR_sd, SNR_sr, SNR_rd]
	
	if (SNR_sd>0 & SNR_sr>0 & SNR_rd>0)
		atten_A = ['00 atten_set C1-A {' int2str(SNR_sd) ' ' int2str(SNR_sr) ' ' int2str(SNR_sr) ' ' int2str(SNR_sd) '}\r'];
		atten_B = ['00 atten_set C1-B {' int2str(SNR_rd) ' ' int2str(SNR_rd) ' ' int2str(SNR_rd) ' ' int2str(SNR_rd) '}\r'];
		
		disp(['setting A ' atten_A]);
		disp(['setting B ' atten_B]);
		
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
%			pnet(emulatorHandle, 'printf', ['00 atten_set C1-A {' int2str(SNR_sd) ' ' int2str(SNR_sr) ' ' int2str(SNR_sr) ' ' int2str(SNR_sd) '}\r']);
%			pause(3)
%			pnet(emulatorHandle, 'printf', ['00 atten_set C1-B {' int2str(SNR_rd) ' ' int2str(SNR_rd) ' ' int2str(SNR_rd) ' ' int2str(SNR_rd) '}\r']);
%			pause(3)

			coop_setup;
			[r,d, config] = s2rd(config);
			clear r;
			[sync_error, num_errs, num_bits] = dpost_no_relay(d, config);

				
			if (sync_error == 0)
				n_err_total_RSD = n_err_total_RSD + num_errs.SD;
				n_err_total_RZF = n_err_total_RZF + num_errs.ZF;

				n_bits_RSD = n_bits_RSD + num_bits.SD;
				n_bits_RZF = n_bits_RZF + num_bits.ZF;
				
				savefile = (['pp_sr_myerror2', '_', num2str(PowerRatio_s), '_', num2str(SNR)])
				save (savefile);
			end
			
			
			if (n_err_total_RZF > max_n_err && n_err_total_RSD >max_n_err)
				if pack_counter>pack_counter_max
					break;
				end
			end
		
		end

	end
end





