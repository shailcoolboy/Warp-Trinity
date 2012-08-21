% WARPLab code for implementation of the cooperative partial detection 

clear all;clc;close all

warning off;

FDF_CPD = 1 %if '0', perform full detect-and-forward. If '1', perform partial detecte-and-forward

% Relative Relay location
d_sd = 1; %source-destination distance
d_sr = 0.5; %source-relay distance
d_rd = d_sd - d_sr; %relay-destination distance
alphacoeff = 3; %Path loss exponent

max_n_err = 1000;
pack_counter_max = 1000;


%setup socket handles for WARPLAB
% Create Socket handles and intialize nodes
[config.socketHandles, config.packetNum] = warplab_initialize(3);

PowerRatio_s = 0.5; %Ratio of the source power to (relay+source) power
SNR = 25 % Note that the transmit power is fixed in the config.TX_gain variable in coop_setup.m file. SNR variable is used when the channel emulator is used. 

SNR_sd = SNR - round( 10*log10(PowerRatio_s) + 10*log10(1/(d_sd^alphacoeff)) ) %source-destination power loss value
sigma_2_sd = 10^((SNR_sd-50)/10);

SNR_sr = SNR - round( 10*log10(PowerRatio_s) + 10*log10(1/(d_sr^alphacoeff)) ) %source-relay power loss value
sigma_2_sr = 10^((SNR_sr-50)/10)

SNR_rd = SNR - round( 10*log10(1-PowerRatio_s) + 10*log10(1/(d_rd^alphacoeff)) )%relay-destination power loss value
sigma_2_rd = 10^((SNR_rd-50)/10)

n_err_total_RSD.zf = 0;
n_err_total_RSD.sd = 0;
n_err_total_RZF.zf = 0;
n_err_total_RZF.sd = 0;

n_err_total_RSD_dl.zf = 0;
n_err_total_RSD_dl.sd = 0;

n_bits_RSD = 0;
n_bits_RZF = 0;
n_bits_RSD_dl = 0;

coop_setup; %Sets the system variables
config.sigma_2_sd = sigma_2_sd;
config.sigma_2_sr = sigma_2_sr;
config.sigma_2_rd = sigma_2_rd;


channel_tracker.sr = zeros(2,2,100);
channel_tracker.sd = zeros(2,2,100);
channel_tracker.rd = zeros(2,2,100);

relay_only_total = 0;
source_only_total = 0;



trcc_tot.D = 0;
trcc_tot.R = 0;

sat_flag_tracker = [];
symb_err_tracker = [];



for pkt_cntr = 1:1e7
    disp('------------------------------');
    pkt_cntr
    
    % Transmit from source to relay and destinatio
    [r,d, config, sat_flag.s2rd, agc_read_s{pkt_cntr}] = s2rd_STC(config,pkt_cntr);
    % perform detection in the relay
    [sync_error, zf,sd, hest, R_det_only] = rpost(r, config,1,pkt_cntr);
    sat_flag_tracker.rdet(pkt_cntr) = sat_flag.s2rd.r;
    sat_flag_tracker.d(pkt_cntr) = sat_flag.s2rd.d;

    if FDF_CPD == 0 % Full Detect and Forward scenario
        if ( sync_error == 0 && sat_flag_tracker.rdet(pkt_cntr)==0 && sat_flag_tracker.d(pkt_cntr)== 0 )
            symb_err_tracker.rdet(pkt_cntr) = R_det_only;
            % Relay transmission to destination.
            [output.sd, sat_flag.r2dst.sd, agc_read_r{pkt_cntr}] = r2dst(sd,config,pkt_cntr);
            % Destination processing and combining
            [sync_error RSD_num_errs RSD_num_bits hest relay_only source_only] = dpost(output.sd,d,config,pkt_cntr);
            sat_flag_tracker.d2(pkt_cntr) = sat_flag.r2dst.sd;

            % Generating error statistics
            if (sync_error==0 && sat_flag_tracker.d2(pkt_cntr)==0 )
                relay_only_total = relay_only_total + relay_only;
                source_only_total = source_only_total + source_only;

                symb_err_tracker.r(pkt_cntr) = relay_only;
                symb_err_tracker.s(pkt_cntr) = source_only;
                n_bits_RSD = n_bits_RSD + RSD_num_bits.SD;
                n_err_total_RSD.sd = n_err_total_RSD.sd + RSD_num_errs.SD;
                n_err_total_RSD.sd/n_bits_RSD
                RSD_num_errs_iter(pkt_cntr) = RSD_num_errs.SD;
                num_bits_iter(pkt_cntr) = RSD_num_bits.SD;

            end
        end

    elseif FDF_CPD == 1 % Partial Detect and Forward scenario
        if ( sync_error == 0 && sat_flag_tracker.rdet(pkt_cntr)==0 && sat_flag_tracker.d(pkt_cntr)== 0 )
            symb_err_tracker.rdet(pkt_cntr) = R_det_only;
            % Relay transmission of partial data to destination.
            [output.sd, sat_flag.r2dst.sd, agc_read_r{pkt_cntr}] = partial_r2dst(sd,config,pkt_cntr);
            % Destination processing and combining
            [sync_error RSD_num_errs RSD_num_bits hest relay_only source_only] = partial_dpost(output.sd,d,config,pkt_cntr);
            sat_flag_tracker.d2(pkt_cntr) = sat_flag.r2dst.sd;

            % Generating error statistics
            if (sync_error==0 && sat_flag_tracker.d2(pkt_cntr)==0 )
                relay_only_total = relay_only_total + relay_only;
                source_only_total = source_only_total + source_only;

                symb_err_tracker.r(pkt_cntr) = relay_only;
                symb_err_tracker.s(pkt_cntr) = source_only;
                n_bits_RSD = n_bits_RSD + RSD_num_bits.SD;
                n_err_total_RSD.sd = n_err_total_RSD.sd + RSD_num_errs.SD;
                n_err_total_RSD.sd/n_bits_RSD
                RSD_num_errs_iter(pkt_cntr) = RSD_num_errs.SD;
                num_bits_iter(pkt_cntr) = RSD_num_bits.SD;
            end
        end


    end
end

