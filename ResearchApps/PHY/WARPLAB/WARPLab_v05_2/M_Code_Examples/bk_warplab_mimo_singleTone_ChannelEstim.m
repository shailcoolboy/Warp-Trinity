%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Using WARPLab to Estimate the Amplitude and Phase of a Narrowband Flat 
% Fading 1-Input 1-Output Wireless Channel (1x1 MIMO Configuration)
% Both boards use radio 2
% ---- by xyzhang
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
% The specific steps implemented in this script are the following:
pfile = 'channelTrace0721_indoor_phase.txt';
afile = 'channelTrace0721_indoor_amplitude.txt';

CarrierChannel = 14; % Channel in the 2.4 GHz band. In [1:14]
TxGain_RF = 40;  % Tx RF Gain. In [0:63]
TxGain_BB = 1;% Tx Baseband Gain. In [0:3]

RxGain_BB = 13;% Rx Baseband Gain. In [0:31]
RxGain_RF = 1;% Rx RF Gain. In [1:3] 
numTxNode = 1;
numRxNode = 1;
numTxAntenna = 3;
numRxAntenna = 4;
Fs = 40e6;
filterOrder = 256;

basefreq = 1e6; % 
incfreq =1e6;
for txn = 1:numTxNode
for txa = 1:numTxAntenna
    txfreq(txa,txn) = basefreq;
    basefreq = basefreq + incfreq;
end
end
if basefreq > 9.5e6 % max bandwidth exceeded
    fprintf(1, 'ERROR! Freq overflow!\n');
    %pause;
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0. Transmit a narrowband signal using Warplab. %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0.0. Initialization and definition of parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Load some global definitions (packet types, etc.)
warplab_defines

% Create Socket handles and initialize nodes
%[socketHandles, packetNum] = warplab_initialize;
[socketHandles, packetNum] = warplab_initialize(numRxNode+numTxNode);

% Separate the socket handles for easier access
% The first socket handle is always the magic SYNC
% The rest of the handles are the handles to the WARP nodes
udp_Sync = socketHandles(1);
ncount = 1;
for n = 1:numTxNode
    udp_txnode(n) = socketHandles(n+1);
end
for n = 1:numRxNode
    udp_rxnode(n) = socketHandles(1+numTxNode+n);
end


% Define WARPLab parameters. 
TxDelay = 1000; % Number of noise samples per Rx capture. In [0:2^14]
TxLength = 2^14-1-1000; % Length of transmission. In [0:2^14-1-TxDelay]
TxMode = 0; % Transmission mode. In [0:1] 
            % 0: Single Transmission 
            % 1: Continuous Transmission. Tx board will continue 
            % transmitting the vector of samples until the user manually
            % disables the transmitter. 

%{
Node1_Radio1_TxGain_BB = TxGain_BB; % Tx Baseband Gain. In [0:3]
Node1_Radio1_TxGain_RF = TxGain_RF;% Tx RF Gain. In [0:63]
Node1_Radio2_TxGain_BB = TxGain_BB; % Tx Baseband Gain. In [0:3]
Node1_Radio2_TxGain_RF = TxGain_RF;% Tx RF Gain. In [0:63]
Node1_Radio3_TxGain_BB = TxGain_BB; % Tx Baseband Gain. In [0:3]
Node1_Radio3_TxGain_RF = TxGain_RF; % Tx RF Gain. In [0:63]
Node1_Radio4_TxGain_BB = TxGain_BB; % Tx Baseband Gain. In [0:3]
Node1_Radio4_TxGain_RF = TxGain_RF; % Tx RF Gain. In [0:63]

Node2_Radio1_RxGain_BB = RxGain_BB; % Rx Baseband Gain. In [0:31]
Node2_Radio1_RxGain_RF = RxGain_RF; % Rx RF Gain. In [1:3]  
Node2_Radio2_RxGain_BB = RxGain_BB; % Rx Baseband Gain. In [0:31]
Node2_Radio2_RxGain_RF = RxGain_RF; % Rx RF Gain. In [1:3]  
Node2_Radio3_RxGain_BB = RxGain_BB; % Rx Baseband Gain. In [0:31]
Node2_Radio3_RxGain_RF = RxGain_RF; % Rx RF Gain. In [1:3]  
Node2_Radio4_RxGain_BB = RxGain_BB; % Rx Baseband Gain. In [0:31]
Node2_Radio4_RxGain_RF = RxGain_RF; % Rx RF Gain. In [1:3]  
%}

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
    % Node 1 will be set as the transmitter so download Tx gains to node 1.
    radiovar = eval(sprintf('RADIO%d_TXGAINS',txa));
    warplab_setRadioParameter(udp_txnode(txn), radiovar,(TxGain_RF + TxGain_BB*2^16));
end
end

%{
warplab_setRadioParameter(udp_txnode(1),RADIO1_TXGAINS,(TxGain_RF + TxGain_BB*2^16));
warplab_setRadioParameter(udp_node1,RADIO2_TXGAINS,(Node1_Radio2_TxGain_RF + Node1_Radio2_TxGain_BB*2^16));
warplab_setRadioParameter(udp_node1,RADIO3_TXGAINS,(Node1_Radio3_TxGain_RF + Node1_Radio3_TxGain_BB*2^16));
warplab_setRadioParameter(udp_node1,RADIO4_TXGAINS,(Node1_Radio4_TxGain_RF + Node1_Radio4_TxGain_BB*2^16));
%}

for rxn = 1:numRxNode
    warplab_setRadioParameter(udp_rxnode(rxn),CARRIER_CHANNEL,CarrierChannel);
    warplab_setAGCParameter(udp_rxnode(rxn), MGC_AGC_SEL, MGC_AGC_Select);
for rxa = 1:numRxAntenna
    radiovar = eval(sprintf('RADIO%d_RXGAINS',rxa));
    warplab_setRadioParameter(udp_rxnode(rxn), radiovar,(RxGain_BB + RxGain_RF*2^16)); 
end
end

%{
% Node 2 will be set as the receiver so download Rx gains to node 2.
warplab_setRadioParameter(udp_node2,RADIO1_RXGAINS,(Node2_Radio1_RxGain_BB + Node2_Radio1_RxGain_RF*2^16));
warplab_setRadioParameter(udp_node2,RADIO2_RXGAINS,(Node2_Radio2_RxGain_BB + Node2_Radio2_RxGain_RF*2^16));
warplab_setRadioParameter(udp_node2,RADIO3_RXGAINS,(Node2_Radio3_RxGain_BB + Node2_Radio3_RxGain_RF*2^16));
warplab_setRadioParameter(udp_node2,RADIO4_RXGAINS,(Node2_Radio4_RxGain_BB + Node2_Radio4_RxGain_RF*2^16));

warplab_setRadioParameter(udp_node3,RADIO1_RXGAINS,(Node3_Radio1_RxGain_BB + Node3_Radio1_RxGain_RF*2^16));
warplab_setRadioParameter(udp_node3,RADIO2_RXGAINS,(Node3_Radio2_RxGain_BB + Node3_Radio2_RxGain_RF*2^16));
warplab_setRadioParameter(udp_node3,RADIO3_RXGAINS,(Node3_Radio3_RxGain_BB + Node3_Radio3_RxGain_RF*2^16));
warplab_setRadioParameter(udp_node3,RADIO4_RXGAINS,(Node3_Radio4_RxGain_BB + Node3_Radio4_RxGain_RF*2^16));
%}


% Set MGC mode in receiver
%warplab_setAGCParameter(udp_node2,MGC_AGC_SEL, Node2_MGC_AGC_Select);
%warplab_setAGCParameter(udp_node3,MGC_AGC_SEL, Node3_MGC_AGC_Select);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0.1. Generate a vector of samples to transmit and send the samples to the 
% Warp board (Sample Frequency is 40MHz)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Prepare some data to be transmitted
t = 0:(1/40e6):TxLength/40e6 - 1/40e6; %Create time vector.
% Create a signal to transmit, the signal can be real or complex.
% The signal must meet the following requirements:
% - Signal to transmit must be a row vector.
% - The amplitude of the real part must be in [-1:1] and the amplitude 
% of the imaginary part must be in [-1:1]. 
% - Highest frequency component is limited to 9.5 MHz (signal bandwidth
% is limited to 19 MHz)
% - Lowest frequency component is limited to 30 kHz
%{
Node1_Radio1_TxData = exp(t*j*2*pi*txfreq1);
Node1_Radio2_TxData = exp(t*j*2*pi*txfreq2);
Node1_Radio3_TxData = exp(t*j*2*pi*txfreq3);
Node1_Radio4_TxData = exp(t*j*2*pi*txfreq4);
%}
for txn = 1:numTxNode
for txa = 1:numTxAntenna
    TxData(:,txa,txn) = exp(t*j*2*pi*txfreq(txa,txn));
    %TxData(:,txa,txn) = exp(t*j*2*pi*1e6);
    radiovar = eval(sprintf('RADIO%d_TXDATA',txa));
    warplab_writeSMWO(udp_txnode(txn), radiovar, TxData(:,txa,txn).');
end
end


%{
% Download the samples to be transmitted to Tx radio buffer
warplab_writeSMWO(udp_node1, RADIO1_TXDATA, Node1_Radio1_TxData);
warplab_writeSMWO(udp_node1, RADIO2_TXDATA, Node1_Radio2_TxData);
warplab_writeSMWO(udp_node1, RADIO3_TXDATA, Node1_Radio3_TxData);
warplab_writeSMWO(udp_node1, RADIO4_TXDATA, Node1_Radio4_TxData);
%}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0.2 Prepare boards for transmission from one Tx radio and reception on 
% both receiver antennas. Send trigger to start transmission and reception 
% (trigger is the SYNC packet)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The following lines of code set node 1 as transmitter and node 2 as
% receiver; transmission and capture are triggered by sending the SYNC
% packet.

for txn = 1:numTxNode
for txa = 1:numTxAntenna
    radiovar = eval(sprintf('RADIO%d_TXEN', txa));
    warplab_sendCmd(udp_txnode(txn), radiovar, packetNum);
    radiovar = eval(sprintf('RADIO%dTXBUFF_TXEN', txa));
    warplab_sendCmd(udp_txnode(txn), radiovar, packetNum);
end
end
for rxn = 1:numRxNode
for rxa = 1:numRxAntenna
    radiovar = eval(sprintf('RADIO%d_RXEN', rxa));
    warplab_sendCmd(udp_rxnode(rxn), radiovar, packetNum);
    radiovar = eval(sprintf('RADIO%dRXBUFF_RXEN', rxa));
    warplab_sendCmd(udp_rxnode(rxn), radiovar, packetNum);
end
end


% -------------
% Enable transmitter radio path in radio 2 in node 1 
%warplab_sendCmd(udp_node1, RADIO2_TXEN, packetNum);
%warplab_sendCmd(udp_node1, [RADIO1_TXEN,RADIO2_TXEN,RADIO3_TXEN,RADIO4_TXEN], packetNum);

% Enable transmission of node1's radio 2 Tx buffer (enable 
% transmission of samples stored in radio 1 Tx Buffer in node 1)
%warplab_sendCmd(udp_node1, RADIO2TXBUFF_TXEN, packetNum);

% Enable receiver radio path in radios 2 in node 2 (enable radios 2 
% and 3 in node 2 as receivers)
%warplab_sendCmd(udp_node2, [RADIO2_RXEN], packetNum);
%warplab_sendCmd(udp_node1, [RADIO1TXBUFF_TXEN,RADIO2TXBUFF_TXEN,RADIO3TXBUFF_TXEN,RADIO4TXBUFF_TXEN], packetNum);


% Enable capture in node2's radio 2 Rx Buffer (enable radio 2 
% Rx buffer Rx buffer in node 2 for storage of samples)
%warplab_sendCmd(udp_node2, [RADIO2RXBUFF_RXEN], packetNum);
%warplab_sendCmd(udp_node2, [RADIO1_RXEN,RADIO2_RXEN,RADIO3_RXEN,RADIO4_RXEN], packetNum);
%warplab_sendCmd(udp_node3, [RADIO1_RXEN,RADIO2_RXEN,RADIO3_RXEN,RADIO4_RXEN], packetNum);



% Prime transmitter state machine in node 1. Node 1 will be 
% waiting for the SYNC packet. Transmission from node 1 will be triggered 
% when node 1 receives the SYNC packet.
%warplab_sendCmd(udp_node1, TX_START, packetNum);
for txn = 1:numTxNode
    warplab_sendCmd(udp_txnode(txn), TX_START, packetNum);
end

% Prime receiver state machine in node 2. Node 2 will be waiting for the SYNC
% packet. Capture at node 2 will be triggered when node 2 receives the SYNC
% packet.
%warplab_sendCmd(udp_node2, RX_START, packetNum);
%warplab_sendCmd(udp_node3, RX_START, packetNum);
for rxn = 1:numRxNode
    warplab_sendCmd(udp_rxnode(rxn), RX_START, packetNum);
end

% Send the SYNC packet
warplab_sendSync(udp_Sync);


% ***** Read the received smaples from the WARP board
% Read back the received samples 
for rxn = 1:numRxNode
for rxa = 1:numRxAntenna
    radiovar = eval(sprintf('RADIO%d_RXDATA',rxa));
    RawRxData(:,rxa,rxn) = warplab_readSMRO(udp_rxnode(rxn), radiovar, TxLength+TxDelay);
end
end
% Process the received samples to obtain meaningful data
for rxn = 1:numRxNode
for rxa = 1:numRxAntenna
    [RxData(:,rxa,rxn), RxOTR(:,rxa,rxn)] = warplab_processRawRxData(RawRxData(:,rxa,rxn));
end
end



% ***** Reset and disable the boards
for txn = 1:numTxNode
for txa = 1:numTxAntenna
    radiovar = eval(sprintf('RADIO%dTXBUFF_TXDIS', txa));
    warplab_sendCmd(udp_txnode(txn), radiovar, packetNum);
    radiovar = eval(sprintf('RADIO%d_TXDIS', txa));
    warplab_sendCmd(udp_txnode(txn), radiovar, packetNum);
end
end

% Set radio 2 Tx buffer in node 1 back to Tx disabled mode
%warplab_sendCmd(udp_node1, RADIO2TXBUFF_TXDIS, packetNum);
%warplab_sendCmd(udp_node1, [RADIO1TXBUFF_TXDIS,RADIO2TXBUFF_TXDIS,RADIO3TXBUFF_TXDIS,RADIO4TXBUFF_TXDIS], packetNum);

% Disable the transmitter radios
%warplab_sendCmd(udp_node1, RADIO2_TXDIS, packetNum);
%warplab_sendCmd(udp_node1, [RADIO1_TXDIS,RADIO2_TXDIS,RADIO3_TXDIS,RADIO4_TXDIS], packetNum);

for rxn = 1:numRxNode
    warplab_sendCmd(udp_rxnode(rxn), RX_DONEREADING, packetNum);
    for rxa = 1:numRxAntenna
        radiovar = eval(sprintf('RADIO%dRXBUFF_RXDIS', rxa));
        warplab_sendCmd(udp_rxnode(rxn), radiovar, packetNum);
        radiovar = eval(sprintf('RADIO%d_RXDIS', rxa));
        warplab_sendCmd(udp_rxnode(rxn), radiovar, packetNum);
    end
end

% Let the receiver know that samples have been read and system is ready for
% a new capture
%warplab_sendCmd(udp_node2, RX_DONEREADING, packetNum);
%warplab_sendCmd(udp_node3, RX_DONEREADING, packetNum);

% Set Rx buffer in node 2 back to Rx disabled mode
%warplab_sendCmd(udp_node2, [RADIO1RXBUFF_RXDIS, RADIO2RXBUFF_RXDIS, RADIO3RXBUFF_RXDIS, RADIO4RXBUFF_RXDIS], packetNum);
%warplab_sendCmd(udp_node3, [RADIO1RXBUFF_RXDIS, RADIO2RXBUFF_RXDIS, RADIO3RXBUFF_RXDIS, RADIO4RXBUFF_RXDIS], packetNum);

% Disable the receiver radios
%warplab_sendCmd(udp_node2, [RADIO1_RXDIS,RADIO2_RXDIS,RADIO3_RXDIS,RADIO4_RXDIS], packetNum); 
%warplab_sendCmd(udp_node3, [RADIO1_RXDIS,RADIO2_RXDIS,RADIO3_RXDIS,RADIO4_RXDIS], packetNum); 

% Close sockets
pnet('closeall');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Remove from the received vector the samples that do not correspond to 
% transmitted data. In other words, remove from the received vector samples
% 1 to TxDelay. This step will remove samples that correspond to measured
% noise and make the RxData vector the same length as the TxData vector
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for rxn = 1:numRxNode
    for rxa = 1:numRxAntenna
        cRxData(:,rxa,rxn) = squeeze(RxData(TxDelay+1:end, rxa, rxn));
    end
end
%{
Node2Rx1_RxData = Node2_Radio1_RxData(TxDelay+1:end);
Node2Rx2_RxData = Node2_Radio2_RxData(TxDelay+1:end);
Node2Rx3_RxData = Node2_Radio3_RxData(TxDelay+1:end);
Node2Rx4_RxData = Node2_Radio4_RxData(TxDelay+1:end);
Node3Rx1_RxData = Node3_Radio1_RxData(TxDelay+1:end);
Node3Rx2_RxData = Node3_Radio2_RxData(TxDelay+1:end);
Node3Rx3_RxData = Node3_Radio3_RxData(TxDelay+1:end);
Node3Rx4_RxData = Node3_Radio4_RxData(TxDelay+1:end);
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Compute the amplitude and the phase of the transmitted and received 
% sammples
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ***** Compute channel gain *****
for txn = 1:numTxNode
for txa = 1:numTxAntenna
phase_Tx = angle(squeeze(TxData(:,txa,txn)));
phase_Tx_unw = unwrap(phase_Tx);
phase_Tx = phase_Tx*180/pi; %Convert to degrees
phase_Tx_unw = phase_Tx_unw*180/pi; %Convert to degrees
    for rxn = 1:numRxNode
    for rxa = 1:numRxAntenna
    % Get my own signal, filter others
    fff = fir1(filterOrder, [(txfreq(txa,txn)-0.5*incfreq)*2/Fs (txfreq(txa,txn)+0.5*incfreq)*2/Fs]); 
    fRx = filter(fff, 1, cRxData(:,rxa,rxn));
    %fRx = cRxData(:,rxa,rxn);
    % Compute channel magnitude
    tc = abs(fRx)./abs(TxData(:,txa,txn)); 
    channel_amplitude(:,rxa,rxn,txa,txn) = tc;%tc(500:end);
    
    phase_Rx = angle(fRx);
    phase_Rx_unw = unwrap(phase_Rx);
    phase_Rx = phase_Rx*180/pi; %Convert to degrees
    phase_Rx_unw = phase_Rx_unw*180/pi; %Convert to degrees

    % Compute channel phase
    pha = phase_Rx_unw - phase_Tx_unw;
    % Remove frequency offset
    len = length(pha(:,1));
    x = 1000:length(pha(:,1));
    p1 = pha(x, 1);
    ft = polyfit(x.', p1, 1);
    a = ft(1);
    x1 = 1:len;
    po(:,1) = pha(:,1) - (a*x1');
    po = po - 360*floor(po./360);
    channel_phase(:,rxa,rxn,txa,txn) = po;
    %channel_phase(:,rxa,rxn,txa,txn) = pha;

	% Compute relative phase, relative to rxradio1, txradio2
	if (rxa==1) continue; end
	%rel_phase(:,rxa,rxn,txa,txn) = channel_phase(:,rxa,rxn,txa,txn)-channel_phase(:,1,rxn,1,txn); %test co
    end
    end
end
end
% Test
rel_phase(:,2,1,3,1) = channel_phase(:,2,1,3,1)-channel_phase(:,1,1,2,1);
%rel_phase(:,2,1,3,1) = rel_phase(:,2,1,3,1) - 360*floor(rel_phase(:,2,1,3,1)/360);


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

%{
channel_phase_Node2Rx1Tx1 = phase_Tx2_Rx2_RxData_unw - phase_TxData_unw;

%pha = load('temp.txt');
%amp = load('~/Desktop/channelTrace_amplitude.txt');
pha = channel_phase_Tx2_Rx2.';
len = length(pha(:,1));
x = 1000:length(pha(:,1));
p1 = pha(x, 1);
%cv = cov(x, p1, 1);
%a = cv(1,end) / var(x);
%b = mean(p1);% - a * mean(x);
ft = polyfit(x.', p1, 1);
a = ft(1);
%fprintf(1, 'a11=%g b11=%g\n', a11, b11);
%plot(x,a11*x+b11,'-y', 'LineWidth', 4);
x1 = 1:len;
po(:,1) = pha(:,1) - (a*x1');
po = po - 360*floor(po./360);

fo = fopen(pfile, 'w');
fprintf(fo, '%g\n', po');
fclose(fo);
%}

% Plot channel amplitude
figure(4);
plot(squeeze(channel_amplitude(:,2,1,2,1)))
title('CHamp Tx2Rx2')
xlabel('n (samples)'); ylabel('Amplitude');

fo = fopen('singleToneOut.txt', 'w');
fprintf(fo, '%g\n', cRxData(:,2,1));
fclose(fo);

%Plot channel phase
figure(6);
%plot(channel_phase_Tx2_Rx2);
%plot(po);
%plot(squeeze(channel_phase(:,2,1,2,1)))
y1=squeeze(channel_phase(:,2,1,2,1));
y2=squeeze(channel_phase(:,1,1,2,1)); 
%plot(1:length(y1), y1, '-r', 1:length(y2), y2, '-b')
plot(squeeze(rel_phase(:,2,1,3,1)))
xlabel('n (samples)'); ylabel('Degrees');
title('CHphaseTx2Rx2');

fprintf(1, 'amplitude mean: %f \n', mean(channel_amplitude(1000:end, 2,1,2,1)));
fprintf(1, 'amplitude std: %f \n', std(channel_amplitude(1000:end, 2,1,2,1)));
fprintf(1, 'phase mean: %f \n', mean(channel_phase(1000:end, 2,1,2,1)));
fprintf(1, 'phase std: %f \n', std(channel_phase(1000:end, 2,1,2,1)));

