%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Using Warplab to Estimate the Amplitude and Phase of a Narrowband Flat 
% Fading Wireless Channel 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% In this lab exercise you will write a matlab script that transmits and
% receives data using Warplab and computes an estimate of the amplitude and 
% phase of the channel by comparing the transmitted and received data.

% The specific steps to be implemented are the following:

% 0. Transmit a narrowband signal using Warplab 
% 1. Remove from the received vector the samples that do not correspond to 
% transmitted data.
% 2. Compute the amplitude and the phase of the transmitted and received 
% sammples
% 3. Compute the channel amplitude and channel phase per sample

% NOTE 1 : The amplitude and phase computed in this exercise correspond to 
% the amplitude and phase of the channel together with the amplitude and 
% phase of the hardware. In other words, the effect of the radios is also 
% part of the channel.

% You will write a matlab script that implements the four steps above. 
% Part of the code is provided, some part of the code you will write. Read 
% the code below and fill in with your code wherever you are asked to do
% so.

% NOTE 2 : To avoid conflict with other groups using the boards, please 
% test the code you write in this script in any of the following three 
% ways:
%
% Option 1. Run this script from matlab's Command Window by entering the 
% name of the script (enter warplab_example_ChannelEstimation_WorkshopExercise 
% in matlab's Command Window).
% Option 2. In the menu bar go to Debug and select Run. If there
% are errors in the code, error messages will appear in the Command Window.
% Option 3. Press F5. If the are errors in the code, error messages will 
% appear in the Command Window.
%
% DO NOT USE the Evaluate selection option and DO NOT run the script by
% sections. To test any change, always run the whole script by following 
% any of the three options above.

try,
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Code to avoid conflict between users, only needed for the workshop, go to
% step 0 below to transmit a narrowband signal using Warplab
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid = fopen('c:\boards_lock.txt');

if(fid > -1)
    fclose('all');
	errordlg('Boards already in use - Please try again!');
	return;
end

!echo > c:\boards_lock.txt

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0. Transmit a narrowband signal using Warplab
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Follow the steps for transmission and reception of data using Warplab.
% These are the steps implemented in the previous lab exercise, the
% following sections (0.0 to 0.5) guide you through the steps.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0.0. Initializaton and definition of parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-------------------------------------------------------------------------%
% USER CODE HERE

% Follow the steps for Initializaton and definition of parameters.
% You can copy the code corresponding to step 0 in the previous lab 
% exercise and then paste it here. 

% Remember to set TxGainBB, TxGainRF, RxGainBB, and RxGainRF to the
% same values you used in the warplab_siso_GUI.

% For the code below to work, make sure the 'CaptOffset' variable exists 
% in the matlab workspace.

%Load some global definitions (packet types, etc.)
warplab_siso_defines

% Create Socket handles and intialize nodes
[socketHandles, packetNum] = warplab_initialize;

%Separate the socket handles for easier access
% The first socket handle is always the magic SYNC
% The rest can be arranged in any combination of Tx and Rx
udp_Sync = socketHandles(1);
udp_Tx = socketHandles(2);
udp_RxA = socketHandles(3);

% Define the warplab options (parameters)
CaptOffset = 1000; %Number of noise samples per Rx capture; in [0:2^14]
TxLength = 2^14-1000; %Length of transmission; in [0:2^14-CaptOffset]
TxGainBB = 3; %Tx Baseband Gain in [0:3]
TxGainRF = 40; %Tx RF Gain in [0:63]
RxGainBB = 12; %Rx Baseband Gain in [0:31]
RxGainRF = 1; %Rx RF Gain in [1:3]
CarrierChannel = 11; % Channel in the 2.4 GHz band. In [1:14]

% Define the options vector; the order of options is set by the FPGA's code
% (C code)
optionsVector = [CaptOffset TxLength-1 (RxGainBB + RxGainRF*2^16) (TxGainRF + TxGainBB*2^16) CarrierChannel]; 
% Send options vector to the nodes
warplab_setOptions(socketHandles,optionsVector);

%-------------------------------------------------------------------------%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0.1. Generate a vector of samples to transmit and send the samples to the 
% Warp board (Sample Frequency is 40MHz)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-------------------------------------------------------------------------%
% USER CODE HERE

% Follow the steps to Generate a vector of samples to transmit and send 
% the samples to the Warp board.
% You can copy the code corresponding to step 1 in the previous lab 
% exercise and then paste it here. 
% You can use the following two lines of code to generate the narrowband 
% signal:
% t = 0:(1/40e6):TxLength/40e6 - 1/40e6; 
% TxData = exp(t*j*2*pi*1e6); 

% For the code below to work, make sure the transmit vector is 
% stored in a variable called 'TxData'. Make sure 'TxData' exists 
% in the matlab workspace.

%Create time vector 't'
t = 0:(1/40e6):TxLength/40e6 - 1/40e6; 
TxData = exp(t*j*2*pi*1e6); % Create a signal to transmit. Signal must be a
% row vector. The signal can be real or complex, the only constraint is
% that the amplitude of the real part must be in [-1:1] and the amplitude 
% of the imaginary part must be in [-1:1]

% Download the samples to be transmitted
warplab_writeSMWO(udp_Tx, TxData, RADIO2_TXDATA);
%-------------------------------------------------------------------------%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0.2. Prepare boards for transmission and reception and send trigger to 
% start transmission and reception (trigger is the SYNC packet)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-------------------------------------------------------------------------%
% USER CODE HERE
% Follow the steps to prepare boards for transmission and reception and 
% send trigger to start transmission and reception.
% You can copy the code corresponding to step 2 in the previous lab 
% exercise and then paste it here. 

% Enable transmission
warplab_enableTx(udp_Tx);

% Enable reception
warplab_enableRx(udp_RxA);

% Send the SYNC packet
warplab_sendSync(udp_Sync);
%-------------------------------------------------------------------------%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0.3. Read the received samples from the Warp board
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-------------------------------------------------------------------------%
% USER CODE HERE
% Follow the steps to read the received samples from the Warp board.
% You can copy the code corresponding to step 3 in the previous lab 
% exercise and then paste it here. There is no need to read the RSSI, but
% you can do so.

% For the code below to work, make sure the received vector is 
% stored in a variable called 'RxData'. Make sure 'RxData' exists 
% in the matlab workspace.

% Read back the received samples
[RawRxData] = warplab_readSMRO(udp_RxA, RADIO2_RXDATA, TxLength+CaptOffset);
% Process the received samples to obtain meaningful data
[RxData,RxOTR] = warplab_processRawRxData(RawRxData);
% Read stored RSSI data OPTIONAL
[RawRSSIData] = warplab_readSMRO(udp_RxA, RADIO2_RSSIDATA, (TxLength+CaptOffset)/8);
% Procecss Raw RSSI data to obtain meningful RSSI values OPTIONAL
[RxRSSI] = warplab_processRawRSSIData(RawRSSIData);

%-------------------------------------------------------------------------%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0.4. Reset and disable the boards
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-------------------------------------------------------------------------%
% USER CODE HERE
% Follow the steps to reset and disable the boards.
% You can copy the code corresponding to step 4 in the previous lab 
% exercise and then paste it here. 

% Reset the receiver
warplab_sendCmd(udp_RxA, RX_DONEREADING, packetNum);

% Disable the receiver
warplab_sendCmd(udp_RxA, RADIO2_RXDIS, packetNum);

% Disable the transmitter
warplab_sendCmd(udp_Tx, RADIO2_TXDIS, packetNum);

% Close sockets
pnet('closeall');

%-------------------------------------------------------------------------%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0.5. Plot the transmitted and received data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-------------------------------------------------------------------------%
% USER CODE HERE
% If you are interested in looking at the received and transmitted data you
% can copy the code corresponding to step 5 in the previous lab exercise
% and paste it here

figure;
subplot(2,2,1);
plot(real(TxData));
title('Tx I');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(2,2,2);
plot(imag(TxData));
title('Tx Q');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(2,2,3);
plot(real(RxData));
title('Rx I');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.
subplot(2,2,4);
plot(imag(RxData));
title('Rx Q');
xlabel('n (samples)'); ylabel('Amplitude');
axis([0 2^14 -1 1]); % Set axis ranges.

%-------------------------------------------------------------------------%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Remove from the received vector the samples that do not correspond to 
% transmitted data. In other words, remove from the received vector samples
% 1 to CaptOffset. This step will remove samples that correspond to measured
% noise and make the RxData vector the same length as the TxData vector
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
RxData = RxData(CaptOffset+1:end);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Compute the amplitude and the phase of the transmitted and received 
% sammples
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-------------------------------------------------------------------------%
% USER CODE HERE
% Compute the magnitude per sample of the transmitted and received
% data. Store the magnitude of the transmitted data in a variable named 
% 'mag_TxData'. Store the magnitude of the received data in a variable
% named 'mag_RxData'.
% Hint: You can use Matlab's 'abs' function

mag_TxData = abs(TxData);
mag_RxData = abs(RxData);

%-------------------------------------------------------------------------%


%-------------------------------------------------------------------------%
% USER CODE HERE
% Compute the phase per sample of the transmitted and received
% data. Store the phase (in radians) of the transmitted data in a variable 
% named 'phase_TxData'. Store the phase (in radians) of the received data 
% in a variable named 'phase_RxData'. 
% Hint: You can use Matlab's 'angle' function

phase_TxData = angle(TxData);
phase_RxData = angle(RxData);

%-------------------------------------------------------------------------%

phase_TxData_unw = unwrap(phase_TxData); % Unwrap phase
phase_TxData = phase_TxData *180/pi; % Convert phase to degrees
phase_TxData_unw = phase_TxData_unw *180/pi; % Convert unwraped phase to degrees

phase_RxData_unw = unwrap(phase_RxData); % Unwrap phase
phase_RxData = phase_RxData *180/pi; % Convert phase to degrees
phase_RxData_unw = phase_RxData_unw *180/pi; % Convert unwraped phase to degrees

% Plot magnitude and phase of transmitted and received samples
figure;
subplot(2,3,1);
plot(mag_TxData);
title('Tx Magnitude');
xlabel('n (samples)'); ylabel('Amplitude');
subplot(2,3,2);
plot(phase_TxData);
title('Tx Phase');
xlabel('n (samples)'); ylabel('Degrees');
subplot(2,3,3);
plot(phase_TxData_unw);
title('Tx Phase unwrapped');
xlabel('n (samples)'); ylabel('Degrees');
subplot(2,3,4);
plot(mag_RxData);
title('Rx Magnitude');
xlabel('n (samples)'); ylabel('Amplitude');
subplot(2,3,5);
plot(phase_RxData);
title('Rx Phase');
xlabel('n (samples)'); ylabel('Degrees');
subplot(2,3,6);
plot(phase_RxData_unw);
title('Rx Phase unwrapped');
xlabel('n (samples)'); ylabel('Degrees');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Compute the channel amplitude and channel phase per sample
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-------------------------------------------------------------------------%
% USER CODE HERE
% Compute the channel amplitude per sample. Store the result in a variable 
% named 'channel_amplitude'
% Hint 1: 
% Channel amplitude = Magnitude of transmitted samples / Magnitude of received samples
% Hint 2:
% You can use Matlab's './' function to implement division of vetors entry 
% by entry. To learn more about this function enter 'help ./' in the Matlab
% command window

channel_amplitude = mag_RxData./mag_TxData;
%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% USER CODE HERE
% Compute the channel phase per sample. Store the result in a variable 
% named 'channel_phase'
% Hint 1: 
% Channel Phase = Phase of transmitted samples - Phase of received samples

channel_phase = phase_RxData_unw - phase_TxData_unw;
%-------------------------------------------------------------------------%

% Plot channel amplitude and phase
figure
subplot(2,1,1)
plot(channel_amplitude)
title('Channel Amplitude per sample');
xlabel('n (samples)'); ylabel('Amplitude');
subplot(2,1,2)
plot(channel_phase)
title('Channel Phase per sample');
xlabel('n (samples)'); ylabel('Degrees');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Code to avoid conflict between users, only needed for the workshop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pnet('closeall');
!del c:\boards_lock.txt
catch,
% Close sockets
pnet('closeall');
!del c:\boards_lock.txt
lasterr
end
