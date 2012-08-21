%%%%%n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Using WARPLab to Estimate the Amplitude and Phase of a Narrowband Flat 
% Fading 1-Input 1-Output Wireless Channel (1x1 MIMO Configuration)
% Both boards use radio 2
% -- Sequentially send tones from different TX antennas and estimate the
% channel gain at each RX antenna
% ---- by xyzhang
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
% The specific steps implemented in this script are the following:
pfile = 'channelTrace0125_indoor_phase_sync_seq.txt';
afile = 'channelTrace0125_indoor_amplitude_sync_seq.txt';
%getTrace = 0; % 1: collect traces
procSamples = 1; % process traces


CarrierChannel = 14; % Channel in the 2.4 GHz band. In [1:14]
TxGain_RF = 25; %40;  % Tx RF Gain. In [0:63]
TxGain_BB = 1;%1;% Tx Baseband Gain. In [0:3]

RxGain_BB = 15;% 13;% Rx Baseband Gain. In [0:31]
RxGain_RF = 1;%2;% Rx RF Gain. In [1:3] 
numTxNode = 1; % must be 1
txID = 1; 
numRxNode = 2; 
numTxAntenna = 2; 
numRxAntenna = 2; 
numRxCapture = 10; 
FREQ_COMPEN = 1;

TxDelay = 100; % Number of noise samples per Rx capture. In [0:2^14]
rxCaptureSize = 2^14 - 1; 
Fs = 40e6; 
filterOrder = 256; 

basefreq = 1e6; % 
%incfreq = 0.5e6;
%for txn = 1:numTxNode 
%for txa = 1:numTxAntenna 
%    txfreq(txa,txn) = basefreq;
%    basefreq = basefreq + incfreq;
%end
%end
%
%
%if basefreq > 9.5e6 % max bandwidth exceeded
%    fprintf(1, 'ERROR! Freq overflow!\n');
%    %pause;
%end

% Prepare some data to be transmitted
TxLength = 2^14-1-TxDelay; % Length of transmission. In [0:2^14-1-TxDelay]
t = 0:(1/40e6):TxLength/40e6 - 1/40e6; %Create time vector.
% Create a signal to transmit, the signal can be real or complex.
% The signal must meet the following requirements:
% - Signal to transmit must be a row vector.
% - The amplitude of the real part must be in [-1:1] and the amplitude 
% of the imaginary part must be in [-1:1]. 
% - Highest frequency component is limited to 9.5 MHz (signal bandwidth
% is limited to 19 MHz)
% - Lowest frequency component is limited to 30 kHz
allTxSamples = exp(t*j*2*pi*basefreq);
sLen = length(allTxSamples);
perAtnLen = floor(sLen/numTxAntenna);
TxScaler = ones(numTxAntenna, numTxNode);
for txn = 1:numTxNode
for txa = 1:numTxAntenna
    %TxData(:,txa,txn) = exp(t*j*2*pi*txfreq(txa,txn));
    TxData(:,txa,txn) = zeros(length(t),1);
    myRange = (txa-1)*perAtnLen+1:txa*perAtnLen;
    TxData(myRange,txa,txn) = allTxSamples(myRange);
    %{
    for k = 1:sLen
        if k >= (txa-1)*perAtnLen+1 && k <= txa*perAtnLen
            TxData(k,txa,txn) = allTxSamples(k);
        else
            TxData(k,txa,txn) = 0;
        end
    end
    %}
end
end


% 0. Transmit a narrowband signal using Warplab.  
% First transmit from Tx radio 1 while silencing other radios, then transmit
% from Tx radio 2, etc. During each transmission all receive radios are
% capturing data. 
% 1. Remove from the received vectors the samples that do not correspond to 
% transmitted data.
% 2. Compute the amplitude and the phase of the transmitted and received 
% samples
% 3. Compute the channel amplitude and channel phase per sample for each of
% the 16 SISO channels, and compute the channel matrix

% Note: The amplitude and phase computed in this exercise correspond to the
% amplitude and phase of the channel together with the amplitude and phase 
% of the hardware. In other words, the effect of the radios is also part of
% the channel.

%if getTrace==1 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0. Transmit a narrowband signal using Warplab. %%%%%%%%%%%%%%%%%%%
% 0.0. Initialization and definition of parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Load some global definitions (packet types, etc.)
warplab_defines

% Create Socket handles and initialize nodes
%[socketHandles, packetNum] = warplab_initialize;
%[socketHandles, packetNum] = warplab_initialize(numRxNode*2);
[socketHandles, packetNum] = warplab_initialize(3); %test

% Separate the socket handles for easier access
% The first socket handle is always the magic SYNC
% The rest of the handles are the handles to the WARP nodes
udp_Sync = socketHandles(1);
ncount = 1;
%{
for n = 1:numTxNode
    udp_txnode(n) = socketHandles(n+1);
end
for n = 1:numRxNode
    udp_rxnode(n) = socketHandles(1+numTxNode+n);
end
%}

%udp_txnode(1) = socketHandles(txID*2);
udp_txnode(1) = socketHandles(2); %test
for rxn = 1:numRxNode
	%udp_rxnode(rxn) = socketHandles(rxn*2+1);
end
udp_rxnode(1) = socketHandles(3);
udp_rxnode(2) = socketHandles(4);


% Define WARPLab parameters. 
TxMode = 1; % Transmission mode. In [0:1] 
            % 0: Single Transmission 
            % 1: Continuous Transmission. Tx board will continue 
            % transmitting the vector of samples until the user manually
            % disables the transmitter. 

% Note: For this experiment node 1 will be set as the transmitter and node 
% 2 will be set as the receiver (this is done later in the code), hence, 
% there is no need to define receive gains for node1 and there is no
% need to define transmitter gains for node2.
MGC_AGC_Select = 0;
%Node2_MGC_AGC_Select = 0;   % Set MGC_AGC_Select=1 to enable Automatic Gain Control (AGC). 
                            % Set MGC_AGC_Select=0 to enable Manual Gain Control (MGC).
                            % By default, the nodes are set to MGC.  

% Download the WARPLab parameters to the WARP nodes. 
% The nodes store the TxDelay, TxLength, and TxMode parameters in 
% registers defined in the WARPLab sysgen model. The nodes set radio 
% related parameters CarrierChannel, TxGains, and RxGains, using the 
% radio controller functions.
% The TxDelay, TxLength, and TxMode parameters need to be known at the transmitter;
% the receiver doesn't require knowledge of these parameters (the receiver
% will always capture 2^14 samples). For this exercise node 1 will be set as
% the transmitter (this is done later in the code). Since TxDelay, TxLength and
% TxMode are only required at the transmitter we download the TxDelay, TxLength and
% TxMode parameters only to the transmitter node (node 1).
for txn = 1:numTxNode
    warplab_writeRegister(udp_txnode(txn),TX_DELAY,TxDelay);
    warplab_writeRegister(udp_txnode(txn),TX_LENGTH,TxLength);
    warplab_writeRegister(udp_txnode(txn),TX_MODE,TxMode);
    warplab_setRadioParameter(udp_txnode(txn),CARRIER_CHANNEL,CarrierChannel);
for txa = 1:numTxAntenna
    txa1 = mod(txa, 4) + 1;
    % Node 1 will be set as the transmiatter so download Tx gains to node 1.
    radiovar = eval(sprintf('RADIO%d_TXGAINS',txa1));
    warplab_setRadioParameter(udp_txnode(txn), radiovar,(TxGain_RF + TxGain_BB*2^16));
end
end


for rxn = 1:numRxNode
    warplab_setRadioParameter(udp_rxnode(rxn),CARRIER_CHANNEL,CarrierChannel);
    warplab_setAGCParameter(udp_rxnode(rxn), MGC_AGC_SEL, MGC_AGC_Select);
for rxa = 1:numRxAntenna
	rxa1 = mod(rxa, 4) + 1;
    radiovar = eval(sprintf('RADIO%d_RXGAINS',rxa1));
    warplab_setRadioParameter(udp_rxnode(rxn), radiovar,(RxGain_BB + RxGain_RF*2^16)); 
end
end

% Set MGC mode in receiver
%warplab_setAGCParameter(udp_node2,MGC_AGC_SEL, Node2_MGC_AGC_Select);
%warplab_setAGCParameter(udp_node3,MGC_AGC_SEL, Node3_MGC_AGC_Select);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0.1. Generate a vector of samples to transmit and send the samples to the 
% Warp board (Sample Frequency is 40MHz)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Prepare some data to be transmitted
%t = 0:(1/40e6):TxLength/40e6 - 1/40e6; %Create time vector.
% Create a signal to transmit, the signal can be real or complex.
% The signal must meet the following requirements:
% - Signal to transmit must be a row vector.
% - The amplitude of the real part must be in [-1:1] and the amplitude 
% of the imaginary part must be in [-1:1]. 
% - Highest frequency component is limited to 9.5 MHz (signal bandwidth
% is limited to 19 MHz)
% - Lowest frequency component is limited to 30 kHz
%{
for txn = 1:numTxNode
for txa = 1:numTxAntenna
    %TxData(:,txa,txn) = exp(t*j*2*pi*txfreq(txa,txn));
    %TxData(:,txa,txn) = exp(t*j*2*pi*1e6);
    radiovar = eval(sprintf('RADIO%d_TXDATA',txa));
    warplab_writeSMWO(udp_txnode(txn), radiovar, TxScaler(txa,txn)*TxData(:,txa,txn).');
end
end
%}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Prepare boards for transmission from one Tx radio and reception on 
% both receiver antennas. Send trigger to start transmission and reception 
% (trigger is the SYNC packet)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for txn = 1:numTxNode
for txa = 1:numTxAntenna
        txa1 = mod(txa, 4) + 1;
    radiovar = eval(sprintf('RADIO%d_TXEN', txa1));
    warplab_sendCmd(udp_txnode(txn), radiovar, packetNum);
    radiovar = eval(sprintf('RADIO%dTXBUFF_TXEN', txa1));
    warplab_sendCmd(udp_txnode(txn), radiovar, packetNum);
end
end

for rxn = 1:numRxNode
for rxa = 1:numRxAntenna
	rxa1 = mod(rxa, 4) + 1;
    radiovar = eval(sprintf('RADIO%d_RXEN', rxa1));
    warplab_sendCmd(udp_rxnode(rxn), radiovar, packetNum);
    radiovar = eval(sprintf('RADIO%dRXBUFF_RXEN', rxa1));
    warplab_sendCmd(udp_rxnode(rxn), radiovar, packetNum);
end
end







%% ============= Start TX and RX capture ==============
for c = 1:numRxCapture % receive for numRxCapture times


fprintf(1, '======= Start channel snapshot %d !========\n', c);
fprintf(1, 'TxScaler(1,1)=%f+%fj, TxScaler(2,1)=%f+%fj\n', ...
    real(TxScaler(1,1)), imag(TxScaler(1,1)), real(TxScaler(2,1)), imag(TxScaler(2,1)));

for rxn = 1:numRxNode
for rxa = 1:numRxAntenna
    sf = sprintf('singleToneSamples_a%d_r%d_t%d.dat', rxa, rxn, txID);
    fsout(rxa,rxn) = fopen(sf, 'wb');
end
end

for txn = 1:numTxNode
for txa = 1:numTxAntenna
    %TxData(:,txa,txn) = exp(t*j*2*pi*txfreq(txa,txn));
    %TxData(:,txa,txn) = exp(t*j*2*pi*1e6);
        txa1 = mod(txa, 4) + 1;
    radiovar = eval(sprintf('RADIO%d_TXDATA',txa1));
    
    if (mod(c,2) == -1)
        warplab_writeSMWO(udp_txnode(txn), radiovar, allTxSamples);
    else
        warplab_writeSMWO(udp_txnode(txn), radiovar, TxScaler(txa,txn)*TxData(:,txa,txn).');
    end
end
end

    

% -------------
% Prime transmitter state machine in node 1. Node 1 will be 
% waiting for the SYNC packet. Transmission from node 1 will be triggered 
% when node 1 receives the SYNC packet.
% warplab_sendCmd(udp_node1, TX_START, packetNum);
for txn = 1:numTxNode
    warplab_sendCmd(udp_txnode(txn), TX_START, packetNum);
end
% Prime receiver state machine in node 2. Node 2 will be waiting for the SYNC
% packet. Capture at node 2 will be triggered when node 2 receives the SYNC
% packet.
for rxn = 1:numRxNode
    warplab_sendCmd(udp_rxnode(rxn), RX_START, packetNum);
end

% Send the SYNC packet
warplab_sendSync(udp_Sync);

% ***** Read the received smaples from the WARP board
% Read back the received samples 
for rxn = 1:numRxNode
for rxa = 1:numRxAntenna
	rxa1 = mod(rxa, 4) + 1;
    radiovar = eval(sprintf('RADIO%d_RXDATA',rxa1));
    RawRxData(:,rxa,rxn) = warplab_readSMRO(udp_rxnode(rxn), radiovar, TxLength+TxDelay);
    fwrite(fsout(rxa,rxn), RawRxData(:,rxa,rxn), 'uint32');
end 
end 

%{
% ***** Reset and disable the boards *****
for txn = 1:numTxNode
for txa = 1:numTxAntenna
    radiovar = eval(sprintf('RADIO%dTXBUFF_TXDIS', txa));
    %warplab_sendCmd(udp_txnode(txn), radiovar, packetNum);
    radiovar = eval(sprintf('RADIO%d_TXDIS', txa));
    %warplab_sendCmd(udp_txnode(txn), radiovar, packetNum);
end
end

for rxn = 1:numRxNode
    warplab_sendCmd(udp_rxnode(rxn), RX_DONEREADING, packetNum);
    for rxa = 1:numRxAntenna
		rxa1 = mod(rxa, 4) + 1;
        radiovar = eval(sprintf('RADIO%dRXBUFF_RXDIS', rxa1));
        %warplab_sendCmd(udp_rxnode(rxn), radiovar, packetNum);
        radiovar = eval(sprintf('RADIO%d_RXDIS', rxa1));
        %warplab_sendCmd(udp_rxnode(rxn), radiovar, packetNum);
    end
end
%}

for rxn = 1:numRxNode
for rxa = 1:numRxAntenna
    %sf = sprintf('singleToneSamples_a%d_r%d_t%d.dat', rxa, rxn, txID);
    fclose(fsout(rxa,rxn));
end
end

% ============== Process all data ================


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Remove from the received vector the samples that do not correspond to 
% transmitted data. In other words, remove from the received vector samples
% 1 to TxDelay. This step will remove samples that correspond to measured
% noise and make the RxData vector the same length as the TxData vector
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Process the received samples to obtain meaningful data
for rxn = 1:numRxNode
for rxa = 1:numRxAntenna
    sf = sprintf('singleToneSamples_a%d_r%d_t%d.dat', rxa, rxn, txID);
    %[RxData(:,rxa,rxn), RxOTR(:,rxa,rxn)] = warplab_processRawRxData(RawRxData(:,rxa,rxn));
	sff = fopen(sf, 'rb');
	samples = fread(sff, [1 inf], 'uint32');
	fclose(sff);
    [RxData(:,rxa,rxn), RxOTR(:,rxa,rxn)] = warplab_processRawRxData(samples);
    allcRxData(:,rxa,rxn) = squeeze(RxData(:, rxa, rxn));
end
end


%% ---- compute channel gain for each capture --------
%for txn=1:numTxNode
	for rxn=1:numRxNode
		fname = sprintf('singleTone_trace_amp_r%d_t%d.txt', rxn, txID);
		fda(rxn,txID) = fopen(fname, 'w');
		fname = sprintf('singleTone_trace_phs_r%d_t%d.txt', rxn, txID);
		fdp(rxn,txID) = fopen(fname, 'w');
	end
%end
nRxCapture = floor(length(allcRxData(:,1,1))/rxCaptureSize);
%for nc = 1:1%nRxCapture
nc = c;
for rxn = 1:numRxNode
for rxa = 1:numRxAntenna
	%cRxData(:,rxa,rxn) = allcRxData((nc-1)*rxCaptureSize+TxDelay+1:nc*rxCaptureSize, rxa, rxn);
    cRxData(:,rxa,rxn) = allcRxData(:, rxa, rxn);
	%{
    if (nc==1 && rxn==1 && rxa==2)
        fd = fopen('singleToneOut.txt','w');
        fprintf(fd, '%g %g\n', [real(cRxData(:,rxa,rxn)) imag(cRxData(:,rxa,rxn))]');
        fclose(fd);
		fprintf(1, 'Output!!!\n');
    end
	%}
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Compute the amplitude and the phase of the transmitted and received 
% sammples
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ***** Compute channel gain *****
for txn = 1:numTxNode
for txa = 1:numTxAntenna
    %phase_Tx = angle(squeeze(TxData(:,txa,txn)));
    %phase_Tx_unw = unwrap(phase_Tx);
    %phase_Tx = phase_Tx*180/pi; %Convert to degrees
    %phase_Tx_unw = phase_Tx_unw*180/pi; %Convert to degrees
     
    for rxn = 1:numRxNode
    for rxa = 1:numRxAntenna

    %{
    % Get my own signal, filter others
    fff = fir1(filterOrder, ...
        [(txfreq(txa,txn)-0.5*incfreq)*2/Fs (txfreq(txa,txn)+0.5*incfreq)*2/Fs]); 
	%ins = load('singleToneOut.txt');
    fRx = filter(fff, 1, cRxData(:,rxa,rxn));
    %fRx = filter(fff, 1, ins);


    if (nc==1 && rxn==1 && rxa==2)
        FFTpoints = 512;
        yo = fft(fRx, FFTpoints);
        figure(114);
        for k = 1:FFTpoints
            x_f(k) = (k-FFTpoints/2)/(FFTpoints) * Fs;
        end
        plot(x_f, abs(fftshift(yo)));
        grid minor;	
        %pause;
    end

    %fRx = cRxData(:,rxa,rxn);
    % Compute channel magnitude
    tc = abs(fRx)./abs(TxData(:,txa,txn)); 
    channel_amplitude(:,rxa,rxn,txa,txn) = tc;%tc(500:end);
    phase_Rx = angle(fRx);
    %}
     
    
        
    if (mod(c,2) == -1)
        myVec = floor(1:length(allTxSamples)/2);
        channel_amplitude(:,rxa,rxn,txa,txn) = ...
            abs(cRxData(myVec,rxa,rxn))./abs(allTxSamples(myVec).');
        phase_Tx = angle(allTxSamples.');
        %phase_Tx = phase_Tx*180/pi; %Convert to degrees
        phase_Tx_unw = unwrap(phase_Tx);
        phase_Tx_unw = phase_Tx_unw*180/pi; %Convert to degrees
    else
		myVec = (txa-1)*perAtnLen+1:txa*perAtnLen;
        channel_amplitude(:,rxa,rxn,txa,txn) = ...
            abs(cRxData(myVec,rxa,rxn))./abs(TxData(myVec,txa,txn)); 
        phase_Tx = angle(TxData(:,txa,txn));
        %phase_Tx = phase_Tx*180/pi; %Convert to degrees
        phase_Tx_unw = unwrap(phase_Tx);
        phase_Tx_unw = phase_Tx_unw*180/pi; %Convert to degrees
    end
    
    phaseRx = angle(cRxData(myVec,rxa,rxn));  
    phase_Rx_unw = unwrap(phaseRx);
    phase_Rx = phaseRx*180/pi; %Convert to degrees
    phase_Rx_unw = phase_Rx_unw*180/pi; %Convert to degrees

    % Compute channel phase
    pha = phase_Rx_unw - phase_Tx_unw(myVec);
    
    % Remove frequency offset
    len = length(pha(:,1));
    x = 1000:length(pha(:,1));
    p1 = pha(x, 1);
    ft = polyfit(x.', p1, 1);
    a = ft(1);
    x1 = 1:len;
    
    if FREQ_COMPEN == 0
        po(:,1) = pha(:,1);
    else
        po(:,1) = pha(:,1) - (a*x1'); % remove freq offset
    end
    po = po - 360*floor(po./360);
    channel_phase(:,rxa,rxn,txa,txn) = po;
    %channel_phase(:,rxa,rxn,txa,txn) = pha;

	% Compute relative phase, relative to rxradio1, txradio2
	%if (rxa==1) continue; end
	%rel_phase(:,rxa,rxn,txa,txn) = channel_phase(:,rxa,rxn,txa,txn)-channel_phase(:,1,rxn,1,txn); %test co
    end
    end
end
end

% 0126: calculate tx scaler
if (mod(c,2) == -1)
    ost = 200;
    testCHAMP = channel_amplitude(ost:end-ost,1,1,1,1);
    testCHPHS = channel_phase(ost:end-ost,1,1,1,1);
    h1 = mean(testCHAMP) * exp(j * mean(testCHPHS)/180*pi);
    testCHAMP = channel_amplitude(ost:end-ost,1,1,2,1);
    testCHPHS = channel_phase(ost:end-ost,1,1,2,1);
    h2 = mean(testCHAMP) * exp(j * mean(testCHPHS)/180*pi);
    alpha = h2/h1;
    TxScaler(2,1) = (2/(1+alpha^2))^0.5;
    TxScaler(1,1) = (2*alpha^2/(1+alpha^2))^0.5;
    TxScaler(1,1) = -TxScaler(1,1) * exp(j * angle(alpha));
	TxScaler = TxScaler/norm(TxScaler);
end

% Test
% rel_phase(:,2,1,3,1) = channel_phase(:,2,1,3,1)-channel_phase(:,1,1,2,1);


% ======= Plot the result in one capture ==========

% Plot channel amplitude
figure(4);
%plot(squeeze(channel_amplitude(:,2,2,1,1)));
subplot(2,1,1);
sT = 300;
sqamp = squeeze(channel_amplitude(:,1,1,1,1));
samp1 =sqamp(sT:end);
plot(samp1);
mamp = mean(samp1);
vamp = std(samp1);
sout = sprintf('Amp RxAtn1TxAtn1 mean=%f std/mean=%f', mamp, vamp/mamp);
title(sout);
xlabel('n (samples)'); ylabel('Amplitude');
subplot(2,1,2);
sqamp = squeeze(channel_amplitude(:,2,1,1,1));
samp1 =sqamp(sT:end);
plot(samp1);
mamp = mean(samp1);
vamp = std(samp1);
sout = sprintf('Amp RxAtn1TxAtn2 mean=%f std/mean=%f', mamp, vamp/mamp);
title(sout);
xlabel('n (samples)'); ylabel('Amplitude');


%Plot channel phase
figure(6);
subplot(2,1,1);
ps1 = squeeze(channel_phase(:,1,2,1,1));
ps2 = ps1(sT:end);
plot(ps2);
mps= mean(ps2);
vps = std(ps2);
xlabel('n (samples)'); ylabel('Degrees');
sout = sprintf('Phase RxAtn1TxAtn1 mean=%f std=%f', mps, vps);
%fprintf(1, 'Phase ant1 mean=%f std=%f\n', mps, vps);
title(sout);
subplot(2,1,2);
ps1 = squeeze(channel_phase(:,2,2,1,1));
ps2 = ps1(sT:end);
plot(ps2);
mps= mean(ps2);
vps = std(ps2);
xlabel('n (samples)'); ylabel('Degrees');
sout = sprintf('Phase RxAtn1TxAtn2 mean=%f std=%f', mps, vps);
%fprintf(1, 'Phase ant1 mean=%f std=%f\n', mps, vps);
title(sout);

figure(8);
subplot(1,2,1);
pdiff = squeeze(channel_phase(:,1,1,1,1)) - squeeze(channel_phase(:,2,1,1,1));
pdiff1 = pdiff(sT:end);
plot(pdiff1);
xlabel('n (samples)'); ylabel('Degrees');
sout = sprintf('phase diff: txAtn1->rx1Atn1, txAtn1->rx2Atn1');
title(sout);
subplot(1,2,2);
adiff = squeeze(channel_amplitude(:,1,1,1,1)) - squeeze(channel_amplitude(:,1,2,1,1));
adiff1 = adiff(sT:end);
plot(adiff1);
xlabel('n (samples)'); ylabel('Degrees');
sout = sprintf('amp diff: txAtn1->rx1Atn1, txAtn1->rx2Atn1');
title(sout);


%clear allcRxData, RxData;
for rxn = 1:numRxNode
for rxa = 1:numRxAntenna
    %sf = sprintf('singleToneSamples_a%d_r%d_t%d.dat', rxa, rxn, txID);
    fclose(fsout(rxa,rxn));
end
end

%pause;
clear po; 
clear cRxData;
clear channel_amplitude;
clear channel_phase;
end % end for c = 1:numRxCapture

fprintf(1, 'Finish rxcapture, reset board\n');
% ***** Reset and disable the boards *****
for txn = 1:numTxNode
for txa = 1:numTxAntenna
    txa1 = mod(txa, 4) + 1;
    radiovar = eval(sprintf('RADIO%dTXBUFF_TXDIS', txa1));
    warplab_sendCmd(udp_txnode(txn), radiovar, packetNum);
    radiovar = eval(sprintf('RADIO%d_TXDIS', txa1));
    warplab_sendCmd(udp_txnode(txn), radiovar, packetNum);
end
end

for rxn = 1:numRxNode
    warplab_sendCmd(udp_rxnode(rxn), RX_DONEREADING, packetNum);
    for rxa = 1:numRxAntenna
		rxa1 = mod(rxa, 4) + 1;
        radiovar = eval(sprintf('RADIO%dRXBUFF_RXDIS', rxa1));
        warplab_sendCmd(udp_rxnode(rxn), radiovar, packetNum);
        radiovar = eval(sprintf('RADIO%d_RXDIS', rxa1));
        warplab_sendCmd(udp_rxnode(rxn), radiovar, packetNum);
    end
end

% Close sockets
pnet('closeall');

%end % end if getTrace==1

%{
% Compute relative phase, relative to rxradio1, txradio1
for txn = 1:numTxNode
for txa = 1:numTxAntenna
    for rxn = 1:numRxNode
    for rxa = 1:numRxAntenna
        ta = ceil(numTxAntenna/2); % use the one with middle freq as pilot
		%ta = 3;
        rel = channel_phase(:,rxa,rxn,txa,txn);
        %{
		if (rxa == 1)
			rel = channel_phase(:,rxa,rxn,txa,txn);
		else
	    	rel = channel_phase(:,rxa,rxn,txa,txn)-channel_phase(:,1,rxn,ta,txn);
		end
        %}
		if (mean(rel(300:end) < 0)) rel = rel + 360; end
	    rel_phase(:,rxa,rxn,txa,txn) = rel;
    end
    end
end
end

% prepare output
%for txn=1:numTxNode
	for rxn=1:numRxNode
		for k=1:length(rel_phase(:,1,1,1,1))
			oPhase(k,:) = reshape(rel_phase(k,:,rxn,:,txn), 1, numRxAntenna*numTxAntenna);
			oAmp(k,:) = reshape(channel_amplitude(k,:,rxn,:,txn), 1, numRxAntenna*numTxAntenna);

		end
		
		fprintf(fda(rxn,txID), '%g ', mean(oAmp(1000:end,:)));
		fprintf(fda(rxn,txID), '\n');
		fprintf(fdp(rxn,txID), '%g ', mean(oPhase(1000:end,:)));
		fprintf(fdp(rxn,txID), '\n'); 
	end
%end


%{
fo = fopen(afile, 'w');
cho = [channel_amplitude_Tx2_Rx2];
fprintf(fo, '%g \n', cho);
fclose(fo);
%}
%fo = fopen('temp.txt', 'w');
% Compute the channel phases 
%channel_phase_Tx2_Rx2 = channel_phase_Tx2_Rx2 - 360*floor(channel_phase_Tx2_Rx2./360);
%fprintf(fo, '%g \n', [channel_phase_Tx2_Rx2]);
%fclose(fo);


% Plot channel amplitude
figure(4);
%plot(squeeze(channel_amplitude(:,2,2,1,1)));
sT = 300;
sqamp = squeeze(channel_amplitude(:,1,1,1,1));
samp1 =sqamp(sT:end);
plot(samp1);
mamp = mean(samp1);
vamp = std(samp1);
sout = sprintf('CHampTx3Rx2 mean=%f std/mean=%f', mamp, vamp/mamp);
title(sout);
%title('CHamp Tx2Rx2');
xlabel('n (samples)'); ylabel('Amplitude');

fprintf(1, 'Amp RXant1 mean=%f std/mean=%f\n', mamp, vamp/mamp);
sqamp = squeeze(channel_amplitude(:,2,1,1,1));
samp1 =sqamp(sT:end);
mamp = mean(samp1);
vamp = std(samp1);
fprintf(1, 'Amp RXant2 mean=%f std/mean=%f\n', mamp, vamp/mamp);

%fo = fopen('singleToneOut.txt', 'w');
%fprintf(fo, '%g\n', cRxData(:,2,1));
%fclose(fo);

%Plot channel phase
figure(6);
%plot(channel_phase_Tx2_Rx2);
%plot(po);
%plot(squeeze(channel_phase(:,2,1,2,1)))
%y1=squeeze(channel_phase(:,2,1,2,1));
%y2=squeeze(channel_phase(:,1,1,2,1)); 
%plot(1:length(y1), y1, '-r', 1:length(y2), y2, '-b')
%plot(squeeze(rel_phase(:,2,2,1,1)));
ps1 = squeeze(rel_phase(:,1,1,1,1));
ps2 = ps1(sT:end);
ps1 = squeeze(rel_phase(:,1,2,1,1));
ps2_diff = ps1(sT:end);
ps2_diff = ps1-ps2_diff;
plot(ps2_diff);
mps= mean(ps2);
vps = std(ps2);
xlabel('n (samples)'); ylabel('Degrees');
sout = sprintf('CHphaseTx3Rx2 mean=%f std=%f', mps, vps);
fprintf(1, 'Phase ant1 mean=%f std=%f\n', mps, vps);
title(sout);

ps1 = squeeze(rel_phase(:,2,1,1,1));
ps2 = ps1(sT:end);
mps= mean(ps2);
vps = std(ps2);
fprintf(1, 'Phase ant2 mean=%f std=%f\n', mps, vps);

%fprintf(1, 'amplitude mean: %f \n', mean(channel_amplitude(1000:end, 2,1,2,1)));
%fprintf(1, 'amplitude std: %f \n', std(channel_amplitude(1000:end, 2,1,2,1)));
%fprintf(1, 'phase mean: %f \n', mean(channel_phase(1000:end, 2,1,2,1)));
%fprintf(1, 'phase std: %f \n', std(channel_phase(1000:end, 2,1,2,1)));
%pause;

%end % end for nc = 1:nRxCapture



fclose('all');
%{
for txn=1:numTxNode
	for rxn=1:numRxNode
		fname = sprintf('singleTone_trace_amp_r%d_t%d.txt', rxn, txID);
		fda = fclose(fname);
		fname = sprintf('singleTone_trace_phs_r%d_t%d.txt', rxn, txID);
		fdp = fclose(fname);
	end
end
%}

%}
