function [sync_error, zf, sd, hest, R_det_only] = rpost(input, config, CFO_matlab, rrr_cnt)
        CFO_matlab = config.CFO_matlab;
        R_det_only = 0;
        hest = [];
        zf = {};
		sd = {};
        %parameters that should be outside
        M_T = config.M_T;
        nsamp = config.nsamp;
        LongTrainingSyms_up2 = config.LongTrainingSyms_up2;
        LongSymbol_time_up2 = config.LongSymbol_time_up2;
        LongSymbol_time = config.LongSymbol_time;
        LongSymbol_freq = config.LongSymbol_freq;
        scale_LongTrainingSyms = config.scale_LongTrainingSyms;

        filterorder = config.filtorder;
        delay = config.delay;
        rolloff = config.rolloff;
        rrcfilter = config.rrcfilter;

        nsym_preamble = config.nsym_preamble;
        M = config.M;
        h_mod = config.h_mod;
        h_demod = config.h_demod;

        k = log2(M);
        

        size_segment = config.size_segment;
        nsym_pilot   = config.nsym_pilot;
        pilot_tone   =   config.pilot_tone;
       
        %optional should be deleted
        stream1 = config.stream1;
        stream2 = config.stream2;
        
        
        Node2_Radio2_RxData = input{1};
        Node2_Radio3_RxData = input{2};
        AGC_Set_Address = input{3};
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % 6. Downconvert from 5MHz to baseband
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        time = [0:1:length(Node2_Radio2_RxData)-1]/40e6; % Sampling Freq. is 40MHz
        yrx1_bb = Node2_Radio2_RxData .* exp(-sqrt(-1)*2*pi*5e6*time);   %Downconvert to baseband
        yrx2_bb = Node2_Radio3_RxData .* exp(-sqrt(-1)*2*pi*5e6*time);   %Downconvert to baseband

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % 7. Filter the received signal with a Matched Filter (matched to the pulse
        % shaping filter), detect preamble, and downsample output of Matched Filter
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Store received samples as a column vector
        yrx1_bb = yrx1_bb.';
        yrx2_bb = yrx2_bb.';

        % Matched filter: Filter received signal using the SRRC filter


        
        AGC_Set_Address = AGC_Set_Address + 160;
        
        
        [LongTrainingStart,ValidStart_1, Corr_1] = warplab_findLongTrainingStart(yrx1_bb,LongSymbol_time_up2,AGC_Set_Address);
        preamble_start_1 = LongTrainingStart+32;
        [LongTrainingStart,ValidStart_2, Corr_2] = warplab_findLongTrainingStart(yrx2_bb,LongSymbol_time_up2,AGC_Set_Address);
        preamble_start_2 = LongTrainingStart+32;
        
		sync_error = 0;
            if (ValidStart_1 + ValidStart_2 < M_T)
				sync_error = 1;
                return
            end


        yrx1_bb_mf = rcosflt(yrx1_bb,1,nsamp,'Fs/filter',rrcfilter);
        yrx2_bb_mf = rcosflt(yrx2_bb,1,nsamp,'Fs/filter',rrcfilter);
        
        yrx1_bb_mf = yrx1_bb_mf(1+2*delay*nsamp:end);
        yrx2_bb_mf = yrx2_bb_mf(1+2*delay*nsamp:end);


        % Pull out rx vector and downsample
        rx1 = downsample(yrx1_bb_mf(preamble_start_1+nsym_preamble*nsamp:end), nsamp);
        rx2 = downsample(yrx2_bb_mf(preamble_start_2+nsym_preamble*nsamp:end), nsamp);

        rx_size = min(length(rx1), length(rx2));

        rx1 = rx1(1:rx_size);
        rx2 = rx2(1:rx_size);

        % Pull out pilot tones
        [train_rx1_a train_rx1_b]= gather_pilots(rx1, size_segment,nsym_pilot);
        [train_rx2_a train_rx2_b]= gather_pilots(rx2, size_segment,nsym_pilot);

        % %%%% estimating channel
        [h11 h21] = st_chan_est(train_rx1_a, train_rx1_b, pilot_tone);
        [h12 h22] = st_chan_est(train_rx2_a, train_rx2_b, pilot_tone);

        drift.tx1.avg = mean([h11.drift, h21.drift]);
        drift.tx2.avg = mean([h12.drift, h22.drift]);


        if CFO_matlab == 1
            rx1 = rx1 .* exp(sqrt(-1)*-drift.tx1.avg/(size_segment+2)*[0:1:length(rx1)-1]).';
            rx2 = rx2 .* exp(sqrt(-1)*-drift.tx2.avg/(size_segment+2)*[0:1:length(rx2)-1]).';

            h11.avg = sum(h11.raw .* exp(sqrt(-1)*-drift.tx1.avg*[0:1:length(h11.raw)-1]).')/length(h11.raw);
            h21.avg = sum(h21.raw .* exp(sqrt(-1)*-drift.tx1.avg*[0:1:length(h21.raw)-1]).')/length(h21.raw);

            h12.avg = sum(h12.raw .* exp(sqrt(-1)*-drift.tx2.avg*[0:1:length(h12.raw)-1]).')/length(h12.raw);
            h22.avg = sum(h22.raw .* exp(sqrt(-1)*-drift.tx2.avg*[0:1:length(h22.raw)-1]).')/length(h22.raw);
        else

            h11.avg = sum(h11.raw)/length(h11.raw);
            h12.avg = sum(h12.raw)/length(h12.raw);
            h21.avg = sum(h21.raw)/length(h21.raw);
            h22.avg = sum(h22.raw)/length(h22.raw);
        end

       hest = [h11.avg h21.avg
            h12.avg h22.avg];
        %Pull payload from rx1, rx2;
        payload_rx1 = gather_payload(rx1, size_segment, nsym_pilot);
        payload_rx2 = gather_payload(rx2, size_segment, nsym_pilot);

        load tmp_var

        vec_length = size(payload_rx2);

        s_i = modulate(h_mod,[0:M-1])/(sqrt(M)-1);
        recv_payload_SD = zeros(M_T,vec_length(1));

        for vec_len_cntr = 1 : config.nbits/config.k
            y_received = (transpose([payload_rx1(vec_len_cntr,1), payload_rx2(vec_len_cntr,1)]));
            recv_payload_SD(:,vec_len_cntr) = dfs_det (y_received, hest, M, s_i, M_T);
        end


        z1_SD = de2bi(recv_payload_SD(1,:),'left-msb'); % Convert integers to bits.
        % Convert z from a matrix to a vector.
        z1_SD = reshape(z1_SD.',prod(size(z1_SD)),1);

        z2_SD = de2bi(recv_payload_SD(2,:),'left-msb'); % Convert integers to bits.
        % Convert z from a matrix to a vector.
        z2_SD = reshape(z2_SD.',prod(size(z2_SD)),1);


        z1_SD = z1_SD(1:min(length(z1_SD), length(stream1)));
        z2_SD = z2_SD(1:min(length(z2_SD), length(stream2)));

        
        
        
        % % Calculate bit error rate
        % % Compare x and z to obtain the number of errors and the bit error rate
        [number_of_errors.tx1.SD,bit_error_rate.tx1.SD] = biterr(stream1(1:length(z1_SD)-10),z1_SD(1:end-10));
        [number_of_errors.tx2.SD,bit_error_rate.tx2.SD] = biterr(stream2(1:length(z2_SD)-10),z2_SD(1:end-10));

        num_errs.SD = number_of_errors.tx1.SD+number_of_errors.tx2.SD;
        num_bits.SD = length(z1_SD)+length(z2_SD)-20;

        recv_payload_ZF = inv(hest)*(transpose([payload_rx1, payload_rx2]))*(sqrt(M)-1);
        % demodulate
        zsym_rx1 = qamdemod(recv_payload_ZF(1,:),M, 0, 'gray');
        zsym_rx2 = qamdemod(recv_payload_ZF(2,:),M, 0, 'gray');
        % Map Symbols to Bits
        z1_ZF = de2bi(zsym_rx1,'left-msb'); % Convert integers to bits.
        % Convert z from a matrix to a vector.
        z1_ZF = reshape(z1_ZF.',prod(size(z1_ZF)),1);

        z2_ZF = de2bi(zsym_rx2,'left-msb'); % Convert integers to bits.
        % Convert z from a matrix to a vector.
        z2_ZF = reshape(z2_ZF.',prod(size(z2_ZF)),1);

        z1_ZF = z1_ZF(1:min(length(z1_ZF), length(stream1)));
        z2_ZF = z2_ZF(1:min(length(z2_ZF), length(stream2)));
        
        % % Calculate bit error rate
        % % Compare x and z to obtain the number of errors and the bit error rate
        [number_of_errors.tx1.ZF,bit_error_rate.tx1.ZF] = biterr(stream1(1:length(z1_ZF)-10),z1_ZF(1:end-10));
        [number_of_errors.tx2.ZF,bit_error_rate.tx2.ZF] = biterr(stream2(1:length(z2_ZF)-10),z2_ZF(1:end-10));

        num_errs.ZF = number_of_errors.tx1.ZF+number_of_errors.tx2.ZF;
        num_bits.ZF = length(z1_ZF)+length(z2_ZF)-20;


        [num_errs.ZF num_errs.SD];

        number_of_errors.tx1;
        number_of_errors.tx2;

        
        z1_ZF_bits = bi2de(reshape(z1_ZF,k,length(z1_ZF)/k).','left-msb');
        z2_ZF_bits = bi2de(reshape(z2_ZF,k,length(z2_ZF)/k).','left-msb');
        zf{1} = modulate(h_mod, z1_ZF_bits)/(sqrt(M)-1);
        zf{2} = modulate(h_mod, z2_ZF_bits)/(sqrt(M)-1);

        z1_SD_bits = bi2de(reshape(z1_SD,k,length(z1_SD)/k).','left-msb');
        z2_SD_bits = bi2de(reshape(z2_SD,k,length(z2_SD)/k).','left-msb');
        sd{1} = modulate(h_mod, z1_SD_bits)/(sqrt(M)-1);
        sd{2} = modulate(h_mod, z2_SD_bits)/(sqrt(M)-1);

        
        R_det_only = num_errs.SD;
        

