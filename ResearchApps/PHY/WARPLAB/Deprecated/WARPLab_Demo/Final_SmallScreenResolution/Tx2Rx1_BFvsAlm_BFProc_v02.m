%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Using Warplab to Transmit Beamformed symbols Over a 
% Wireless Channel.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 8. Upsample the symbols to transmit and filter 
% using a pulse shaping filter. Scale payload to span -1,1 range
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Upsample and apply square root raised cosine filter.
ytx_mod_filt = rcosflt(ytx_mod_norm,1,nsamp_PerSymb,'filter',rrcfilter);
ytx_mod_filt = ytx_mod_filt.';
scale_Payload = max([ max(abs(real(ytx_mod_filt))), max(abs(imag(ytx_mod_filt))) ]);
% scale_Payload = 5;
ytx_mod_filt = ytx_mod_filt/scale_Payload;

% Stem Plot of symbols before and after Squared Root Raised 
% Cosine (SRRC) filter
% Plots first 30 symbols. 
% Plots I and Q in different windows
% figure; % Create new figure window.
% subplot(2,1,1)
% stem([1:nsamp_PerSymb:nsamp_PerSymb*30],real(ytx_mod_norm(1:30)));
% hold
% stem(real(ytx_mod_filt(1+delay*nsamp_PerSymb:1+30*nsamp_PerSymb+delay*nsamp_PerSymb)),'r');
% title('I Signal');
% xlabel('n (sample)'); ylabel('Amplitude');
% legend('Before SRRC Filter','After SRRC Filter');
% subplot(2,1,2)
% stem([1:nsamp_PerSymb:nsamp_PerSymb*30],imag(ytx_mod_norm(1:30)));
% hold
% stem(imag(ytx_mod_filt(1+delay*nsamp_PerSymb:1+30*nsamp_PerSymb+delay*nsamp_PerSymb)),'r');
% title('Q Signal');
% xlabel('n (sample)'); ylabel('Amplitude');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 9. Upconvert payload to 1.25MHz
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
time = [0:1:length(ytx_mod_filt)-1]/40e6; % Sampling Freq. is 40MHz
ytx_mod_filt_up = ytx_mod_filt .* exp(sqrt(-1)*2*pi*1.25e6*time);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 10. Append training, guard interval and pilots
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ytx_mod_filt_up_1 = [TrainGuardPilots_1, ytx_mod_filt_up];
ytx_mod_filt_up_2 = [TrainGuardPilots_2, ytx_mod_filt_up];
ytx_mod_filt_up_3 = [TrainGuardPilots_3, ytx_mod_filt_up];
% ytx_mod_filt_up_4 = [TrainGuardPilots_4, ytx_mod_filt_up];

% TxData_1 = ytx_mod_filt_up_1;
TxData_2 = ytx_mod_filt_up_2;
TxData_3 = ytx_mod_filt_up_3;
% TxData_4 = ytx_mod_filt_up_4;

if(1 == channel_select)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 11. Transmit training and pilots over a wireless channel using Warplab. 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Set Tx Gains
%     warplab_setRadioAGCParameter(udp_node1,RADIO1_TXGAINS,(Node1_Radio1_TxGain_RF + Node1_Radio1_TxGain_BB*2^16));
    warplab_setRadioAGCParameter(udp_node1,RADIO2_TXGAINS,(Node1_Radio2_TxGain_RF(index_Total_Loops_Vec) + Node1_Radio2_TxGain_BB(index_Total_Loops_Vec)*2^16));
    warplab_setRadioAGCParameter(udp_node1,RADIO3_TXGAINS,(Node1_Radio3_TxGain_RF(index_Total_Loops_Vec) + Node1_Radio3_TxGain_BB(index_Total_Loops_Vec)*2^16));
%     warplab_setRadioAGCParameter(udp_node1,RADIO4_TXGAINS,(Node1_Radio4_TxGain_RF + Node1_Radio4_TxGain_BB*2^16));

    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % % 11.2 Download the samples to be transmitted.
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % warplab_writeSMWO(udp_node1, RADIO1_TXDATA, TxData_1); % Download samples to 
    % % radio 1 Tx Buffer
    warplab_writeSMWO(udp_node1, RADIO2_TXDATA, TxData_2); % Download samples to 
    % radio 2 Tx Buffer
    warplab_writeSMWO(udp_node1, RADIO3_TXDATA, TxData_3); % Download samples to 
    % radio 3 Tx Buffer
    % warplab_writeSMWO(udp_node1, RADIO4_TXDATA, TxData_4); % Download samples to 
    % % radio 4 Tx Buffer
    % 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 11.3 Prepare boards for transmission and reception and send trigger to 
    % start transmission and reception (trigger is the SYNC packet)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % The following lines of code set node 1 as transmitter and node 2 as
    % receiver; transmission and capture are triggered by sending the SYNC
    % packet.

    % Enable transmitter radio path in all radios in node 1 (enable all radios 
    % in node 1 as transmitters)
    warplab_sendCmd(udp_node1, [RADIO2_TXEN ,RADIO3_TXEN], packetNum);

    % Enable transmission of node1's  Tx buffers (enable 
    % transmission of samples stored in all radio Tx buffers in node 1)
    warplab_sendCmd(udp_node1, [RADIO2TXBUFF_TXEN, RADIO3TXBUFF_TXEN], packetNum);
    
    % Enable receiver radio path in all radios in node 2 (enable all radios
    % in node 2 as receivers)
    warplab_sendCmd(udp_node2, [RADIO2_RXEN], packetNum);
    
    % Enable capture in node2's Rx Buffers (enable all Rx buffers in node 2 
    % for storage of samples)
    warplab_sendCmd(udp_node2, [RADIO2RXBUFF_RXEN], packetNum);
    
    % Prime transmitter state machine in node 1. Node 1 will be 
    % waiting for the SYNC packet. Transmission from node 1 will be triggered 
    % when node 1 receives the SYNC packet.
    warplab_sendCmd(udp_node1, TX_START, packetNum);
    
    % Prime receiver state machine in node 2. Node 2 will be waiting 
    % for the SYNC packet. Capture at node 2 will be triggered when node 2 
    % receives the SYNC packet.
    warplab_sendCmd(udp_node2, RX_START, packetNum);
    
    % Send the SYNC packet
    warplab_sendSync(udp_Sync);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 11.4. Read the received samples from the Warp board, read AGC values, 
    % filter DC offset, and solve timing synchronization
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Reading is done in chunks of 256 samples. There is some small jitter in the 
    % time the SYNC packet triggers TX and the time the SYNC packet triggers 
    % capture. We will read an integer number of 256 chunks, this will leave 
    % some fudge factor (read more samples) for the situation in which the
    % capture starts before the transmission
    nsamps_Read = ceil(nsamp_TGP/256)*256;
    
    % Read back the received samples from radio 1
    % [RawRxData_1_wDCO] = warplab_readSMRO(udp_node2, RADIO1_RXDATA, nsamps_Read);
    % Read back the received samples from radio 2
    [RawRxData_2_wDCO] = warplab_readSMRO(udp_node2, RADIO2_RXDATA, nsamps_Read);
    % Read back the received samples from radio 3
    % [RawRxData_3_wDCO] = warplab_readSMRO(udp_node2, RADIO3_RXDATA, nsamps_Read);
    % % Read back the received samples from radio 4
    % [RawRxData_4_wDCO] = warplab_readSMRO(udp_node2, RADIO4_RXDATA, nsamps_Read);
    % Process the received samples to obtain meaningful data
    % [RxData_1_wDCO,RxOTR_1] = warplab_processRawRxData(RawRxData_1_wDCO);
    [RxData_2_wDCO,RxOTR_2] = warplab_processRawRxData(RawRxData_2_wDCO);
    % [RxData_3_wDCO,RxOTR_3] = warplab_processRawRxData(RawRxData_3_wDCO);
    % [RxData_4_wDCO,RxOTR_4] = warplab_processRawRxData(RawRxData_4_wDCO);
    % 
    % Read the address where the AGC fixes the gains
    [AGC_Set_Address] = warplab_readRegister(udp_node2,AGC_DONE_ADDR);
    % Read the gains that were set by the AGC
    % [GainsRF_Init,GainsBB_Init] = warplab_readAGCGains(udp_node2);
    
    % Remove DC Offset (DCO) from RxData
    % [RxData_1] = warplab_correctDCO(RxData_1_wDCO,AGC_Set_Address);
    [RxData_2] = warplab_correctDCO(RxData_2_wDCO,AGC_Set_Address);
    % [RxData_3] = warplab_correctDCO(RxData_3_wDCO,AGC_Set_Address);
    % [RxData_4] = warplab_correctDCO(RxData_4_wDCO,AGC_Set_Address);
    
    % Solve timing synchronization: Find address where long training symbols start 
    ValidStart_1 = 0; ValidStart_2=0; ValidStart_3 = 0; ValidStart_4 = 0;
    % [LongTrainingStart_1_Init,ValidStart_1] = warplab_findLongTrainingStart(RxData_1,LongSymbol_time_up2,AGC_Set_Address);
    [LongTrainingStart_2_Init,ValidStart_2] = warplab_findLongTrainingStart_BFAL(RxData_2,LongSymbol_time_up2,AGC_Set_Address);
    % [LongTrainingStart_3_Init,ValidStart_3] = warplab_findLongTrainingStart(RxData_3,LongSymbol_time_up2,AGC_Set_Address);
    % [LongTrainingStart_4_Init,ValidStart_4] = warplab_findLongTrainingStart(RxData_4,LongSymbol_time_up2,AGC_Set_Address);
    
    % Compute address where pilots start
    % Pilots_Start_1_Init = LongTrainingStart_1_Init + 320 + 32; % Long training is 320 samples and there are 32 samples of guard interval before pilots
    Pilots_Start_2_Init = LongTrainingStart_2_Init + 320 + 32; % Long training is 320 samples and there are 32 samples of guard interval before pilots
    % Pilots_Start_3_Init = LongTrainingStart_3_Init + 320 + 32; % Long training is 320 samples and there are 32 samples of guard interval before pilots
    % Pilots_Start_4_Init = LongTrainingStart_4_Init + 320 + 32; % Long training is 320 samples and there are 32 samples of guard interval before pilots
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 11.5 Reset AGC and Rx bufer  
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Reset the AGC.
    warplab_sendCmd(udp_node2, AGC_RESET, packetNum);
    
    % Let the receiver know that samples have been read and system is ready for
    % a new capture
    warplab_sendCmd(udp_node2, RX_DONEREADING, packetNum);
end

if(0 == channel_select)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % START OF CODE FOR DEBUGGING WITHOUT TX OVER WARP BOARDS. This code
    % replaces section 11 in code
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Create a channel matrix and pass data through this channel
    
    var_real_imag = 1/2;
    Channel = sqrt(var_real_imag)*randn(Num_Rx,Num_Tx) + ...
            sqrt(-1)*sqrt(var_real_imag)*randn(Num_Rx,Num_Tx);
    % Channel_In = [TxData_1;TxData_2;TxData_3;TxData_4];
    Channel_In = [TxData_2;TxData_3];
    Channel_Out = Channel * Channel_In;
    
    nsamps_Read = ceil(nsamp_TGP/256)*256;
    
    % RxData_1_wDCO = Channel_Out(1,1:nsamps_Read);
    % RxData_2_wDCO = Channel_Out(2,1:nsamps_Read);
    RxData_2_wDCO = Channel_Out(1,1:nsamps_Read);
    % RxData_3_wDCO = Channel_Out(3,1:nsamps_Read);
    % RxData_4_wDCO = Channel_Out(4,1:nsamps_Read);
    
    % RxData_1 = RxData_1_wDCO;
    RxData_2 = RxData_2_wDCO;
    % RxData_3 = RxData_3_wDCO;
    % RxData_4 = RxData_4_wDCO;
    
    % GainsRF_Init = [2,3,2,3];
    % GainsBB_Init = [1,5,10,15];
    % Gains are not need for one Rx antenna
    
    % Find address where payolad starts and address where the first long symbol
    % in the long training symbols starts
    AGC_Set_Address = 0;
    ValidStart_1 = 0; ValidStart_2=0; ValidStart_3 = 0; ValidStart_4 = 0;
    % [LongTrainingStart_1_Init,ValidStart_1] = warplab_findLongTrainingStart(RxData_1,LongSymbol_time_up2,AGC_Set_Address);
    [LongTrainingStart_2_Init,ValidStart_2] = warplab_findLongTrainingStart_BFAL(RxData_2,LongSymbol_time_up2,AGC_Set_Address);
    % [LongTrainingStart_3_Init,ValidStart_3] = warplab_findLongTrainingStart(RxData_3,LongSymbol_time_up2,AGC_Set_Address);
    % [LongTrainingStart_4_Init,ValidStart_4] = warplab_findLongTrainingStart(RxData_4,LongSymbol_time_up2,AGC_Set_Address);
    % Pilots_Start_1_Init = LongTrainingStart_1_Init + 320 + 32; % Long training is 320 samples and there are 32 samples of guard interval before pilots
    Pilots_Start_2_Init = LongTrainingStart_2_Init + 320 + 32; % Long training is 320 samples and there are 32 samples of guard interval before pilots
    % Pilots_Start_3_Init = LongTrainingStart_3_Init + 320 + 32; % Long training is 320 samples and there are 32 samples of guard interval before pilots
    % Pilots_Start_4_Init = LongTrainingStart_4_Init + 320 + 32; % Long training is 320 samples and there are 32 samples of guard interval before pilots
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % END OF CODE FOR DEBUGGING WITHOUT TX OVER WARP BOARDS
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end


if (Num_Rx == (ValidStart_1+ValidStart_2+ValidStart_3+ValidStart_4))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 12. Compute Initial Channel estimate and Quantize it
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Slice pilot data
% TxData_1_Pilots = TxData_1(673:673+nsamp_Pilots-1);
TxData_2_Pilots = TxData_2(673:673+nsamp_Pilots-1);
TxData_3_Pilots = TxData_3(673:673+nsamp_Pilots-1);
% TxData_4_Pilots = TxData_4(673:673+nsamp_Pilots-1);

% RxData_1_Pilots = RxData_1(Pilots_Start_1_Init:Pilots_Start_1_Init+nsamp_Pilots-1);
RxData_2_Pilots = RxData_2(Pilots_Start_2_Init:Pilots_Start_2_Init+nsamp_Pilots-1);
% RxData_3_Pilots = RxData_3(Pilots_Start_3_Init:Pilots_Start_3_Init+nsamp_Pilots-1);
% RxData_4_Pilots = RxData_4(Pilots_Start_4_Init:Pilots_Start_4_Init+nsamp_Pilots-1);

% Create vectors of Tx and Rx Pilots
% TxData = [TxData_1_Pilots,TxData_2_Pilots,TxData_3_Pilots,TxData_4_Pilots];
% RxData_Init = [RxData_1_Pilots,RxData_2_Pilots,RxData_3_Pilots,RxData_4_Pilots];
TxData = [TxData_2_Pilots,TxData_3_Pilots];
RxData_Init = [RxData_2_Pilots];

% Reshape data in way that facilitates computation of channel estimate
TxData_R = reshape(TxData,[],1,Num_Tx);
TxData_RR = repmat(TxData_R,1,Num_Rx); % Dim1:Samples, Dim2:Rx, Dim3:Tx
RxData_R_Init = reshape(RxData_Init,[],Num_Rx,1);
RxData_RR_Init = repmat(RxData_R_Init,[1,1,Num_Tx]); % Dim1:Samples, Dim2:Rx, Dim3:Tx

% Compute estimate of channel real and imaginary part
realCE_Init = real(RxData_RR_Init.*conj(TxData_RR)./(abs(TxData_RR).^2));
imagCE_Init = imag(RxData_RR_Init.*conj(TxData_RR)./(abs(TxData_RR).^2));
% Find mask for invalid values and mask invalid values in channel estimate
mask_Init = isfinite(realCE_Init);
mask_Init = find(0 == mask_Init);
realCE_Init(mask_Init) = 0;
imagCE_Init(mask_Init) = 0;

% Compute Average
avgrealCE_Init = sum(realCE_Init,1)/(n_ChanEst*nsamp_PerAntPerChanEst);
avgimagCE_Init = sum(imagCE_Init,1)/(n_ChanEst*nsamp_PerAntPerChanEst);

% Reshape to obtain channel matrix
avgrealCE_Init = reshape(avgrealCE_Init,Num_Rx,Num_Tx);
avgimagCE_Init = reshape(avgimagCE_Init,Num_Rx,Num_Tx);
CE_Init_RxGains = avgrealCE_Init + sqrt(-1)*avgimagCE_Init;

% NO NEED TO SCALE FOR 1 RX ANTENNA
% % Scale RxData according to inverse of AGC gains to obtain data signal 
% % before AGC scaling. 
% dBGainsRF_Init = (GainsRF_Init - 1)*15;
% dBGainsBB_Init = GainsBB_Init*2;
% ScaleRF_Init = 10.^(dBGainsRF_Init/10);
% ScaleBB_Init = 10.^(dBGainsBB_Init/10);
% Scale_RxGains_Init = ScaleRF_Init.*ScaleBB_Init;
% Scale_RxGains_Init = 1./ Scale_RxGains_Init;
% Scale_RxGains_Init = diag(Scale_RxGains_Init);
% CE_Init = Scale_RxGains_Init * CE_Init_RxGains;
CE_Init = CE_Init_RxGains;

% Quantize channel estimate
Q_Init = CE_Init * Codebook_Original.'; % Columns correspond to codewords
Qabs2_Init = abs(Q_Init).^2; % Colums of Q specify codewords
% Channel_Gain2_Init = sum(Qabs2_Init);
Channel_Gain2_Init = Qabs2_Init;
[Channel_Gain2_max_Init,Index_Init] = max(Channel_Gain2_Init);
Channel_Gain_Init_BF = sqrt(Channel_Gain2_max_Init);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 13. Beamform the data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TxData_1_BF = TxData_1 * Codebook_Original(Index_Init,1);
% TxData_2_BF = TxData_2 * Codebook_Original(Index_Init,2);
% TxData_3_BF = TxData_3 * Codebook_Original(Index_Init,3);
% TxData_4_BF = TxData_4 * Codebook_Original(Index_Init,4);
TxData_2_BF = TxData_2 * Codebook_Original(Index_Init,1);
TxData_3_BF = TxData_3 * Codebook_Original(Index_Init,2);

if(1 == channel_select)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 14. Transmit beamformed training, pilots, and payload, over a wireless 
    % channel using Warplab. 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 14.2 Download the samples to be transmitted.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % warplab_writeSMWO(udp_node1, RADIO1_TXDATA, TxData_1_BF); % Download samples to 
    % % radio 1 Tx Buffer
    warplab_writeSMWO(udp_node1, RADIO2_TXDATA, TxData_2_BF); % Download samples to 
    % radio 2 Tx Buffer
    warplab_writeSMWO(udp_node1, RADIO3_TXDATA, TxData_3_BF); % Download samples to 
    % radio 3 Tx Buffer
    % warplab_writeSMWO(udp_node1, RADIO4_TXDATA, TxData_4_BF); % Download samples to 
    % % radio 4 Tx Buffer
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 14.3 Prepare boards for transmission and reception and send trigger to 
    % start transmission and reception (trigger is the SYNC packet)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Prime transmitter state machine in node 1. Node 1 will be 
    % waiting for the SYNC packet. Transmission from node 1 will be triggered 
    % when node 1 receives the SYNC packet.
    warplab_sendCmd(udp_node1, TX_START, packetNum);
    
    % Prime receiver state machine in node 2. Node 2 will be waiting 
    % for the SYNC packet. Capture at node 2 will be triggered when node 2 
    % receives the SYNC packet.
    warplab_sendCmd(udp_node2, RX_START, packetNum);
    
    % Send the SYNC packet
    warplab_sendSync(udp_Sync);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 14.4. Read the received samples from the Warp board, read AGC values, 
    % filter DC offset, and solve timing synchronization
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Read maximum number of samples
    nsamps_Read = 2^14;
    
    % Read back the received samples from radio 1
    % [RawRxData_1_BF_wDCO] = warplab_readSMRO(udp_node2, RADIO1_RXDATA, nsamps_Read);
    % Read back the received samples from radio 2
    [RawRxData_2_BF_wDCO] = warplab_readSMRO(udp_node2, RADIO2_RXDATA, nsamps_Read);
    % Read back the received samples from radio 3
    % [RawRxData_3_BF_wDCO] = warplab_readSMRO(udp_node2, RADIO3_RXDATA, nsamps_Read);
    % Read back the received samples from radio 4
    % [RawRxData_4_BF_wDCO] = warplab_readSMRO(udp_node2, RADIO4_RXDATA, nsamps_Read);
    % Process the received samples to obtain meaningful data
    % [RxData_1_BF_wDCO,RxOTR_1] = warplab_processRawRxData(RawRxData_1_BF_wDCO);
    [RxData_2_BF_wDCO,RxOTR_2] = warplab_processRawRxData(RawRxData_2_BF_wDCO);
    % [RxData_3_BF_wDCO,RxOTR_3] = warplab_processRawRxData(RawRxData_3_BF_wDCO);
    % [RxData_4_BF_wDCO,RxOTR_4] = warplab_processRawRxData(RawRxData_4_BF_wDCO);
    % 
    % % Read the address where the AGC fixes the gains
    [AGC_Set_Address_BF] = warplab_readRegister(udp_node2,AGC_DONE_ADDR);
    % Read the gains that were set by the AGC
    % [GainsRF_BF,GainsBB_BF] = warplab_readAGCGains(udp_node2);
    
    % Remove DC Offset (DCO) from RxData
    % [RxData_1_BF] = warplab_correctDCO(RxData_1_BF_wDCO,AGC_Set_Address_BF);
    [RxData_2_BF] = warplab_correctDCO(RxData_2_BF_wDCO,AGC_Set_Address_BF);
    % [RxData_3_BF] = warplab_correctDCO(RxData_3_BF_wDCO,AGC_Set_Address_BF);
    % [RxData_4_BF] = warplab_correctDCO(RxData_4_BF_wDCO,AGC_Set_Address_BF);
    
    % Solve timing synchronization: Find address where long training symbols start 
    ValidStart_1 = 0; ValidStart_2=0; ValidStart_3 = 0; ValidStart_4 = 0;
    % [LongTrainingStart_1_BF,ValidStart_1] = warplab_findLongTrainingStart(RxData_1_BF,LongSymbol_time_up2,AGC_Set_Address_BF);
    [LongTrainingStart_2_BF,ValidStart_2] = warplab_findLongTrainingStart_BFAL(RxData_2_BF,LongSymbol_time_up2,AGC_Set_Address_BF);
    % [LongTrainingStart_3_BF,ValidStart_3] = warplab_findLongTrainingStart(RxData_3_BF,LongSymbol_time_up2,AGC_Set_Address_BF);
    % [LongTrainingStart_4_BF,ValidStart_4] = warplab_findLongTrainingStart(RxData_4_BF,LongSymbol_time_up2,AGC_Set_Address_BF);
    
    % Compute Address where pilots start
    % Pilots_Start_1_BF = LongTrainingStart_1_BF + 320 + 32; % Long training is 320 samples and there are 32 samples of guard interval before pilots
    Pilots_Start_2_BF = LongTrainingStart_2_BF + 320 + 32; % Long training is 320 samples and there are 32 samples of guard interval before pilots
    % Pilots_Start_3_BF = LongTrainingStart_3_BF + 320 + 32; % Long training is 320 samples and there are 32 samples of guard interval before pilots
    % Pilots_Start_4_BF = LongTrainingStart_4_BF + 320 + 32; % Long training is 320 samples and there are 32 samples of guard interval before pilots
    
    % Compute Address where payload starts
    % Payload_Start_1_BF = Pilots_Start_1_BF + nsamp_Pilots;
    Payload_Start_2_BF = Pilots_Start_2_BF + nsamp_Pilots;
    % Payload_Start_3_BF = Pilots_Start_3_BF + nsamp_Pilots;
    % Payload_Start_4_BF = Pilots_Start_4_BF + nsamp_Pilots;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 14.5 Reset AGC and Rx bufer
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Reset the AGC
    warplab_sendCmd(udp_node2, AGC_RESET, packetNum);
    
    % Let the receiver know that samples have been read and system is ready for
    % a new capture
    warplab_sendCmd(udp_node2, RX_DONEREADING, packetNum);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 14.6 Disable the boards  
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Set all Tx buffers in node 1 back to Tx disabled mode
    warplab_sendCmd(udp_node1, [RADIO2TXBUFF_TXDIS, RADIO3TXBUFF_TXDIS], packetNum);
    
    % Disable the transmitter radios
    warplab_sendCmd(udp_node1, [RADIO2_TXDIS, RADIO3_TXDIS], packetNum);
    
    % Set all Rx buffers in node 2 back to Rx disabled mode
    warplab_sendCmd(udp_node2, [RADIO2RXBUFF_RXDIS], packetNum);
    
    % Disable the receiver radios
    warplab_sendCmd(udp_node2, [RADIO2_RXDIS], packetNum);
    
%     % Close sockets
%     pnet('closeall');
end

if(0 == channel_select)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % START OF CODE FOR DEBUGGING WITHOUT TX OVER WARP BOARDS. This code
    % replaces section 14 in code
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Channel_In = [TxData_1_BF;TxData_2_BF;TxData_3_BF;TxData_4_BF];
    Channel_In = [TxData_2_BF;TxData_3_BF];
    Channel_Out = Channel * Channel_In;
    
    nsamps_Read = nsamp_TGP+nsamp_Payload;
    
    % RxData_1_BF_wDCO = Channel_Out(1,1:nsamps_Read);
    % RxData_2_BF_wDCO = Channel_Out(2,1:nsamps_Read);
    RxData_2_BF_wDCO = Channel_Out(1,1:nsamps_Read);
    % RxData_3_BF_wDCO = Channel_Out(3,1:nsamps_Read);
    % RxData_4_BF_wDCO = Channel_Out(4,1:nsamps_Read);
    
    % RxData_1_BF = RxData_1_BF_wDCO;
    RxData_2_BF = RxData_2_BF_wDCO;
    % RxData_3_BF = RxData_3_BF_wDCO;
    % RxData_4_BF = RxData_4_BF_wDCO;
    
    % GainsRF_BF = [2,2,2,2];
    % GainsBB_BF = [1,1,1,1];
    
    
    % Find address where payolad starts and address where the first long symbol
    % in the long training symbols starts
    AGC_Set_Address = 0;
    ValidStart_1 = 0; ValidStart_2=0; ValidStart_3 = 0; ValidStart_4 = 0;
    % [LongTrainingStart_1_BF,ValidStart_1] = warplab_findLongTrainingStart(RxData_1_BF,LongSymbol_time_up2,AGC_Set_Address);
    [LongTrainingStart_2_BF,ValidStart_2] = warplab_findLongTrainingStart_BFAL(RxData_2_BF,LongSymbol_time_up2,AGC_Set_Address);
    % [LongTrainingStart_3_BF,ValidStart_3] = warplab_findLongTrainingStart(RxData_3_BF,LongSymbol_time_up2,AGC_Set_Address);
    % [LongTrainingStart_4_BF,ValidStart_4] = warplab_findLongTrainingStart(RxData_4_BF,LongSymbol_time_up2,AGC_Set_Address);
    % Pilots_Start_1_BF = LongTrainingStart_1_BF + 320 + 32; % Long training is 320 samples and there are 32 samples of guard interval before pilots
    Pilots_Start_2_BF = LongTrainingStart_2_BF + 320 + 32; % Long training is 320 samples and there are 32 samples of guard interval before pilots
    % Pilots_Start_3_BF = LongTrainingStart_3_BF + 320 + 32; % Long training is 320 samples and there are 32 samples of guard interval before pilots
    % Pilots_Start_4_BF = LongTrainingStart_4_BF + 320 + 32; % Long training is 320 samples and there are 32 samples of guard interval before pilots
    % Payload_Start_1_BF = Pilots_Start_1_BF + nsamp_Pilots;
    Payload_Start_2_BF = Pilots_Start_2_BF + nsamp_Pilots;
    % Payload_Start_3_BF = Pilots_Start_3_BF + nsamp_Pilots;
    % Payload_Start_4_BF = Pilots_Start_4_BF + nsamp_Pilots;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % END OF CODE FOR DEBUGGING WITHOUT TX OVER WARP BOARDS
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

if (Num_Rx == (ValidStart_1+ValidStart_2+ValidStart_3+ValidStart_4))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 15. Compute Channel estimate with beamformed data and Quantize it to
% check coherence time was long enough
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Slice pilot data
% TxData_1_Pilots = TxData_1(673:673+nsamp_Pilots-1);
TxData_2_Pilots = TxData_2(673:673+nsamp_Pilots-1);
% TxData_3_Pilots = TxData_3(673:673+nsamp_Pilots-1);
% TxData_4_Pilots = TxData_4(673:673+nsamp_Pilots-1);

% RxData_1_Pilots_BF = RxData_1_BF(Pilots_Start_1_BF:Pilots_Start_1_BF+nsamp_Pilots-1);
RxData_2_Pilots_BF = RxData_2_BF(Pilots_Start_2_BF:Pilots_Start_2_BF+nsamp_Pilots-1);
% RxData_3_Pilots_BF = RxData_3_BF(Pilots_Start_3_BF:Pilots_Start_3_BF+nsamp_Pilots-1);
% RxData_4_Pilots_BF = RxData_4_BF(Pilots_Start_4_BF:Pilots_Start_4_BF+nsamp_Pilots-1);

% Create vectors of Tx and Rx Pilots
% TxData = [TxData_1_Pilots,TxData_2_Pilots,TxData_3_Pilots,TxData_4_Pilots];
% RxData_BF = [RxData_1_Pilots_BF,RxData_2_Pilots_BF,RxData_3_Pilots_BF,RxData_4_Pilots_BF];
TxData = [TxData_2_Pilots,TxData_3_Pilots];
RxData_BF = [RxData_2_Pilots_BF];

% Reshape data in way that facilitates computation of channel estimate
TxData_R = reshape(TxData,[],1,Num_Tx);
TxData_RR = repmat(TxData_R,1,Num_Rx); % Dim1:Samples, Dim2:Rx, Dim3:Tx
RxData_BF_R = reshape(RxData_BF,[],Num_Rx,1);
RxData_BF_RR = repmat(RxData_BF_R,[1,1,Num_Tx]); % Dim1:Samples, Dim2:Rx, Dim3:Tx

% Compute estimate of channel real and imaginary part
realCE_BF = real(RxData_BF_RR.*conj(TxData_RR)./(abs(TxData_RR).^2));
imagCE_BF = imag(RxData_BF_RR.*conj(TxData_RR)./(abs(TxData_RR).^2));
% Find mask for invalid values and mask invalid values in channel estimate
mask_BF = isfinite(realCE_BF);
mask_BF = find(0 == mask_BF);
realCE_BF(mask_BF) = 0;
imagCE_BF(mask_BF) = 0;

% Compute Average
avgrealCE_BF = sum(realCE_BF,1)/(n_ChanEst*nsamp_PerAntPerChanEst);
avgimagCE_BF = sum(imagCE_BF,1)/(n_ChanEst*nsamp_PerAntPerChanEst);

% Reshape to obtain channel matrix
avgrealCE_BF = reshape(avgrealCE_BF,Num_Rx,Num_Tx);
avgimagCE_BF = reshape(avgimagCE_BF,Num_Rx,Num_Tx);
CE_BF_RxGains = avgrealCE_BF + sqrt(-1)*avgimagCE_BF;

% NO NEED TO SCALE FOR 1 RX ANTENNA
% Scale RxData according to inverse of AGC gains to obtain data signal 
% before AGC scaling. 
% dBGainsRF_BF = (GainsRF_BF - 1)*15;
% dBGainsBB_BF = GainsBB_BF*2;
% ScaleRF_BF = 10.^(dBGainsRF_BF/10);
% ScaleBB_BF = 10.^(dBGainsBB_BF/10);
% Scale_RxGains_BF = ScaleRF_BF.*ScaleBB_BF;
% Scale_RxGains_BF = 1./ Scale_RxGains_BF;
% Scale_RxGains_BF = diag(Scale_RxGains_BF);
% CE_BF = Scale_RxGains_BF * CE_BF_RxGains;
CE_BF = CE_BF_RxGains;

% Remove BF effect from channel estimate. This is for comparissons.
BFInv = 1./Codebook_Original(Index_Init,:);
BFInvDiag = diag(BFInv);
CE_NoBF_RxGains = CE_BF_RxGains*BFInvDiag;
CE_NoBF = CE_BF*BFInvDiag;

% Quantize channel estimate
Q_check = CE_NoBF * Codebook_Original.'; % Columns correspond to codewords
Qabs2_check = abs(Q_check).^2; % Colums of Q specify codewords
% Channel_Gain2_check = sum(Qabs2_check);
Channel_Gain2_check = Qabs2_check;
[Channel_Gain2_max_check,Index_check] = max(Channel_Gain2_check);
Channel_Gain_max_check = sqrt(Channel_Gain2_max_check);

% Compare SNR with BF and SNR without BF
Channel_Gain_BF_Init = sqrt(sum(abs( CE_Init * (Codebook_Original(Index_Init,:).') ).^2));
% Channel_Gain_BF = sqrt(sum(abs(CE_BF*[1;1;1;1]).^2));
Channel_Gain_BF = sqrt(sum(abs(CE_BF*[1;1]).^2));
Channel_Gain_BF2 = sqrt(sum(abs( CE_NoBF * (Codebook_Original(Index_Init,:).') ).^2));
% SNR_BFNOT = sqrt(sum(abs( CE_NoBF * [1/sqrt(4);1/sqrt(4);1/sqrt(4);1/sqrt(4)]).^2));
SNR_BFNOT = sqrt(sum(abs( CE_NoBF * [1/sqrt(2);1/sqrt(2)]).^2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Slice payload samples, and downconvert payload to 1.25MHz
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Slice
% RxData_1_BF_Payload = RxData_1_BF(Payload_Start_1_BF:Payload_Start_1_BF+nsamp_Payload-1);
RxData_2_BF_Payload = RxData_2_BF(Payload_Start_2_BF:Payload_Start_2_BF+nsamp_Payload-1);
% RxData_3_BF_Payload = RxData_3_BF(Payload_Start_3_BF:Payload_Start_3_BF+nsamp_Payload-1);
% RxData_4_BF_Payload = RxData_4_BF(Payload_Start_4_BF:Payload_Start_4_BF+nsamp_Payload-1);

% Downconvert payload
% time = [0:1:length(RxData_1_BF_Payload)-1]/40e6; % Sampling Freq. is 40MHz
time = [0:1:length(RxData_2_BF_Payload)-1]/40e6; % Sampling Freq. is 40MHz
% yrx_bb_1 = RxData_1_BF_Payload .* exp(-sqrt(-1)*2*pi*1.25e6*time);
yrx_bb_2 = RxData_2_BF_Payload .* exp(-sqrt(-1)*2*pi*1.25e6*time);
% yrx_bb_3 = RxData_3_BF_Payload .* exp(-sqrt(-1)*2*pi*1.25e6*time);
% yrx_bb_4 = RxData_4_BF_Payload .* exp(-sqrt(-1)*2*pi*1.25e6*time);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filter payload samples with a Matched Filter (matched to the pulse 
% shaping filter), and downsample output of Matched Filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Matched filter: Filter received signal using the SRRC filter
% yrx_bb_mf_1 = rcosflt(yrx_bb_1,1,nsamp_PerSymb,'Fs/filter',rrcfilter);
yrx_bb_mf_2 = rcosflt(yrx_bb_2,1,nsamp_PerSymb,'Fs/filter',rrcfilter);
% yrx_bb_mf_3 = rcosflt(yrx_bb_3,1,nsamp_PerSymb,'Fs/filter',rrcfilter);
% yrx_bb_mf_4 = rcosflt(yrx_bb_4,1,nsamp_PerSymb,'Fs/filter',rrcfilter);

% Downsample output of Matched Filter
first_sample_index = 1+2*delay*nsamp_PerSymb; % Twice delay because signal goes through 2 filtering stages

% yrx_bb_mf_ds_1 = yrx_bb_mf_1(first_sample_index:end);
yrx_bb_mf_ds_2 = yrx_bb_mf_2(first_sample_index:end);
% yrx_bb_mf_ds_3 = yrx_bb_mf_3(first_sample_index:end);
% yrx_bb_mf_ds_4 = yrx_bb_mf_4(first_sample_index:end);

% yrx_bb_mf_ds_1 = downsample(yrx_bb_mf_ds_1,nsamp_PerSymb);
yrx_bb_mf_ds_2 = downsample(yrx_bb_mf_ds_2,nsamp_PerSymb);
% yrx_bb_mf_ds_3 = downsample(yrx_bb_mf_ds_3,nsamp_PerSymb);
% yrx_bb_mf_ds_4 = downsample(yrx_bb_mf_ds_4,nsamp_PerSymb);

% Account for delay of filter (Twice delay because signal goes through 2 filtering stages)
% yrx_bb_mf_ds_1 = yrx_bb_mf_ds_1(1:end-2*delay); 
yrx_bb_mf_ds_2 = yrx_bb_mf_ds_2(1:end-2*delay); 
% yrx_bb_mf_ds_3 = yrx_bb_mf_ds_3(1:end-2*delay); 
% yrx_bb_mf_ds_4 = yrx_bb_mf_ds_4(1:end-2*delay); 

if(0 == channel_select)
    if (1 == noise_select)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % START OF CODE FOR DEBUGGING WITHOUT TX OVER WARP BOARDS. This code
    % adds AWGN to the received signal
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Compute noise variance from EbNodB
    EsNodB = EbNodB(index_Total_Loops_Vec) + 10*log10(k);
    EsNo = 10^(EsNodB/10);
    var_noise = 1/(EsNo);
    % Generate noise vector
    size_noise = size(yrx_bb_mf_ds_2);
    noise = randn(size_noise) + sqrt(-1)*randn(size_noise);
%     noise = sqrt(var_noise/2)*noise;
    noise = sqrt(var_noise/2)*noise/scale_Payload;
    % Scale by same factor as payload was scaled
    %noise = noise/scale_Payload/sqrt(2);
    yrx_bb_mf_ds_2 = yrx_bb_mf_ds_2 + noise;
%     EsNodB = EbNodB + 10*log10(k);
%     yrx_bb_mf_ds_2 = awgn(yrx_bb_mf_ds_2,EsNodB,'measured');
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % END OF CODE FOR DEBUGGING WITHOUT TX OVER WARP BOARDS
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Maximum Ratio Combining
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute MRC vector
% MRC = CE_BF_RxGains*[1;1;1;1];
MRC = CE_BF_RxGains*[1;1];
MRC = MRC'; % Compute conjugate transpose

% Arrange received data in matrix form
% yrx_bb_mf_ds = [yrx_bb_mf_ds_1,yrx_bb_mf_ds_2,yrx_bb_mf_ds_3,yrx_bb_mf_ds_4].';
yrx_bb_mf_ds = [yrx_bb_mf_ds_2].';

% Maximum Ratio combine received data
yrx_bb_mf_ds_mrc = MRC * yrx_bb_mf_ds;

% Normalize
% yrx_bb_mf_ds_mrc_norm = yrx_bb_mf_ds_mrc / norm(MRC)^2 * scale_Payload *100000;
% yrx_bb_mf_ds_mrc_norm = yrx_bb_mf_ds_mrc / norm(MRC)^2 * scale_Payload;
% yrx_bb_mf_ds_mrc_norm = yrx_bb_mf_ds_mrc / norm(MRC)^2;
% yrx_bb_mf_ds_mrc_norm = yrx_bb_mf_ds_mrc / norm(MRC)^2;
yrx_bb_mf_ds_mrc_norm = yrx_bb_mf_ds_mrc / norm(MRC)^2 * scale_Payload;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Demodulate and recover the transmitted bitstream
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(0 == dpskqam_select)
    % Demodulate signal using DQPSK
    zsym = dpskdemod(yrx_bb_mf_ds_mrc_norm.',M,0,'gray');
end

% Demodulate signal using QPSK. First scale constellation.
if(1 == dpskqam_select)
    yrx_bb_mf_ds_mrc_norm_scaled = yrx_bb_mf_ds_mrc_norm/scaleConstellation;
    zsym = qamdemod(yrx_bb_mf_ds_mrc_norm_scaled.',M,0,'gray');
end

% Map Symbols to Bits
z = de2bi(zsym,'left-msb'); % Convert integers to bits.
% Convert z from a matrix to a vector.
z = reshape(z.',numel(z),1);

% Plot first 80 transmitted bits and first 80 received bits in a stem plot
% figure;
% subplot(2,1,1)
% stem(x(1:80),'filled');
% title('Transmitted Bits');
% xlabel('Bit Index'); ylabel('Binary Value');
% subplot(2,1,2)
% stem(z(1:80),'filled');
% title('Received Bits');
% xlabel('Bit Index'); ylabel('Binary Value');
% 
% % Plot transmitted and received constellations
% 
% % Scatter Plot of received and transmitted constellation points
% % h = scatterplot(yrx_bb_mf_ds(nsym_preamble+1:end),1,0,'g.');
% h = scatterplot(yrx_bb_mf_ds_mrc_norm,1,0,'g.');
% hold on;
% %scatterplot(ytx_mod_norm(nsym_preamble+1:end),1,0,'k*',h);
% scatterplot(ytx_mod_norm,1,0,'k*',h);
% title('Constellations');
% legend('Received','Transmitted');
% axis([-2 2 -2 2]); % Set axis ranges.
% hold off;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 7. Compute the Bit Error Rate (BER)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(0 == dpskqam_select)
    % Compare x and z to obtain the number of errors and the bit error rate
    [number_of_errors,bit_error_rate] = biterr(x(k+1:length(z)),z(k+1:length(z)));
    % We start comparing at k+1 because the first k bits are always
    % lost in DQPSK. We compare until length(z) because z may be shorter than
    % x due to the fact that some bits (approx 1 to 5) may be lost fue to the 
    % jitter of the synch pulse.
    number_of_bits = length(z)-k;
end

if(1 == dpskqam_select)
    % Compare x and z to obtain the number of errors and the bit error rate
    [number_of_errors,bit_error_rate] = biterr(x(1:length(z)),z(1:length(z)));
    % We start comparing at three because the first two bits are always
    % lost in DQPSK. We compare until length(z) because z may be shorter than
    % xdue to the fact that some bits (approx 1 to 5) may be lost fue to the 
    % jitter of the synch pulse.
    number_of_bits = length(z);
end

end
end
    
