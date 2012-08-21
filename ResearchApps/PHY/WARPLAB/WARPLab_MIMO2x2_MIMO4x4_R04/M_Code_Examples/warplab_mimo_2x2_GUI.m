function varargout = warplab_mimo_2x2_GUI(varargin)
% WARPLAB_MIMO_2X2_GUI M-file for warplab_mimo_2x2_GUI.fig
%      WARPLAB_MIMO_2X2_GUI, by itself, creates a new WARPLAB_MIMO_2X2_GUI or raises the existing
%      singleton*.
%
%      H = WARPLAB_MIMO_2X2_GUI returns the handle to a new WARPLAB_MIMO_2X2_GUI or the handle to
%      the existing singleton*.
%
%      WARPLAB_MIMO_2X2_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WARPLAB_MIMO_2X2_GUI.M with the given input arguments.
%
%      WARPLAB_MIMO_2X2_GUI('Property','Value',...) creates a new WARPLAB_MIMO_2X2_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before warplab_mimo_2x2_GUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to warplab_mimo_2x2_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help warplab_mimo_2x2_GUI

% Last Modified by GUIDE v2.5 25-Jun-2008 14:28:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @warplab_mimo_2x2_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @warplab_mimo_2x2_GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
global warplab_mimo_2x2_GUI;
warplab_mimo_2x2_GUIdefines;

% --- Executes just before warplab_mimo_2x2_GUI is made visible.
function warplab_mimo_2x2_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to warplab_mimo_2x2_GUI (see VARARGIN)

% Choose default command line output for warplab_mimo_2x2_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%Close any stale sockets
pnet('closeall');

global warplab_mimo_2x2_GUI;

%Options
warplab_mimo_2x2_GUI.CaptOffset = 0; %Number of noise samples per Rx capture; in [0:2^14]
warplab_mimo_2x2_GUI.TxDelay = 0; %Number of noise samples per Rx capture; in [0:2^14]
warplab_mimo_2x2_GUI.TxLength = 2^14-1; %Length of transmission; in [0:2^14-TxDelay]
warplab_mimo_2x2_GUI.CarrierChannel = 8; % Channel in the 2.4 GHz band. In [1:14]
warplab_mimo_2x2_GUI.TxA_BB = 3; %Tx Baseband Gain in [0:3]
warplab_mimo_2x2_GUI.TxA_RF = 40; %Tx RF Gain in [0:63]
warplab_mimo_2x2_GUI.RxA_BB = 13; %Rx Baseband Gain in [0:31]
warplab_mimo_2x2_GUI.RxA_RF = 1; %Rx RF Gain in [1:3]
warplab_mimo_2x2_GUI.TxB_BB = 3; %Tx Baseband Gain in [0:3]
warplab_mimo_2x2_GUI.TxB_RF = 40; %Tx RF Gain in [0:63]
warplab_mimo_2x2_GUI.RxB_BB = 13; %Rx Baseband Gain in [0:31]
warplab_mimo_2x2_GUI.RxB_RF = 1; %Rx RF Gain in [1:3]
warplab_mimo_2x2_GUI.TxSelect = 2;
warplab_mimo_2x2_GUI.RxSelect = 2;

axes(handles.axes_RAI)
xlabel ('RxA I')
% labels x-axis as RxA I 
% A implies Radio 2

axes(handles.axes_RAQ)
xlabel ('RxA Q')
% labels x-axis as RxA Q
% A implies Radio 2

axes(handles.axes_RASpectrum)
xlabel ('RxA Spectrum')
% labels x-axis as RxA Spectrum
% A implies Radio 2

axes(handles.axes_RBI)
xlabel ('RxB I')
% labels x-axis as RxB I
% B implies Radio 2

axes(handles.axes_RBQ)
xlabel ('RxB Q')
% labels x-axis as RxB Q
% B implies Radio 2

axes(handles.axes_RBSpectrum)
xlabel ('RxB Spectrum')
% labels x-axis as RxB Spectrum
% B implies Radio 2

% --- Outputs from this function are returned to the command line.
function varargout = warplab_mimo_2x2_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function TxA_vector_Callback(hObject, eventdata, handles)
% hObject    handle to TxA_vector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TxA_vector as text
%        str2double(get(hObject,'String')) returns contents of TxA_vector as a double
global warplab_mimo_2x2_GUI;
warplab_mimo_2x2_GUIdefines;
evalin('base','t = 0:25e-9:(2^14-1)*25e-9;');
%define time variable
warplab_mimo_2x2_GUI.radio2TxData = evalin('base',get(hObject,'String'));
%define radio2TxData as string of vector


% --- Executes during object creation, after setting all properties.
function TxA_vector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TxA_vector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global warplab_mimo_2x2_GUI;
warplab_mimo_2x2_GUIdefines;
evalin('base','t = 0:25e-9:(2^14-1)*25e-9;');
%define time variable
warplab_mimo_2x2_GUI.radio2TxData = evalin('base',get(hObject,'String'));
%define radio2TxData as string of vector



function TxB_vector_Callback(hObject, eventdata, handles)
% hObject    handle to TxB_vector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TxB_vector as text
%        str2double(get(hObject,'String')) returns contents of TxB_vector as a double
global warplab_mimo_2x2_GUI;
warplab_mimo_2x2_GUIdefines;
evalin('base','t = 0:25e-9:(2^14-1)*25e-9;');
%define time variable
warplab_mimo_2x2_GUI.radio3TxData = evalin('base',get(hObject,'String'));
%define radio3TxData as string of vector



% --- Executes during object creation, after setting all properties.
function TxB_vector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TxB_vector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global warplab_mimo_2x2_GUI;
warplab_mimo_2x2_GUIdefines;
evalin('base','t = 0:25e-9:(2^14-1)*25e-9;');
%define time variable
warplab_mimo_2x2_GUI.radio3TxData = evalin('base',get(hObject,'String'));
%define radio3TxData as string of vector

% --- Executes on button press in gobutton.
function gobutton_Callback(hObject, eventdata, handles)
% hObject    handle to gobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global warplab_mimo_2x2_GUI;

set(hObject, 'Enable', 'Off');
% warplab_mimo_2x2_GUIdefines;

warplab_mimo_2x2_GUIinitialize;
% initialize GUI
set(handles.text31, 'String', '1');
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Start of Code to avoid conflict between users, only needed for the 
% % workshop
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% if(okToUseBoards == 0)
% 	set(hObject, 'Enable', 'On');
% %    set(handles.text_status, 'String', 'Done!');
% 	return;
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % End of Code to avoid conflict between users, only needed for the 
% % workshop
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   
updateOptions(hObject, eventdata, handles)

%Download the samples to be transmitted
warplab_writeSMWO(warplab_mimo_2x2_GUI.udp_node1, warplab_mimo_2x2_GUI.RADIO2_TXDATA, warplab_mimo_2x2_GUI.radio2TxData);
warplab_writeSMWO(warplab_mimo_2x2_GUI.udp_node1, warplab_mimo_2x2_GUI.RADIO3_TXDATA, warplab_mimo_2x2_GUI.radio3TxData);

%Enable Tx Radio #2
if warplab_mimo_2x2_GUI.TxSelect == 0;
    warplab_sendCmd(warplab_mimo_2x2_GUI.udp_node1, warplab_mimo_2x2_GUI.RADIO2_TXEN, warplab_mimo_2x2_GUI.pktNoTx);
    warplab_sendCmd(warplab_mimo_2x2_GUI.udp_node1, warplab_mimo_2x2_GUI.RADIO3_TXDIS, warplab_mimo_2x2_GUI.pktNoTx);
    warplab_sendCmd(warplab_mimo_2x2_GUI.udp_node1, warplab_mimo_2x2_GUI.RADIO2TXBUFF_TXEN, warplab_mimo_2x2_GUI.pktNoTx);
elseif warplab_mimo_2x2_GUI.TxSelect == 1;
    warplab_sendCmd(warplab_mimo_2x2_GUI.udp_node1, warplab_mimo_2x2_GUI.RADIO2_TXDIS, warplab_mimo_2x2_GUI.pktNoTx);
    warplab_sendCmd(warplab_mimo_2x2_GUI.udp_node1, warplab_mimo_2x2_GUI.RADIO3_TXEN, warplab_mimo_2x2_GUI.pktNoTx);
    warplab_sendCmd(warplab_mimo_2x2_GUI.udp_node1, warplab_mimo_2x2_GUI.RADIO3TXBUFF_TXEN, warplab_mimo_2x2_GUI.pktNoTx);
elseif warplab_mimo_2x2_GUI.TxSelect == 2;
    warplab_sendCmd(warplab_mimo_2x2_GUI.udp_node1, warplab_mimo_2x2_GUI.RADIO2_TXEN, warplab_mimo_2x2_GUI.pktNoTx);
    warplab_sendCmd(warplab_mimo_2x2_GUI.udp_node1, warplab_mimo_2x2_GUI.RADIO3_TXEN, warplab_mimo_2x2_GUI.pktNoTx);
    warplab_sendCmd(warplab_mimo_2x2_GUI.udp_node1, [warplab_mimo_2x2_GUI.RADIO2TXBUFF_TXEN, warplab_mimo_2x2_GUI.RADIO3TXBUFF_TXEN], warplab_mimo_2x2_GUI.pktNoTx);
end

set(handles.text31, 'String', '2');
%Enable Rx Radio #2
if warplab_mimo_2x2_GUI.RxSelect == 0;
    warplab_sendCmd(warplab_mimo_2x2_GUI.udp_node2, warplab_mimo_2x2_GUI.RADIO2_RXEN, warplab_mimo_2x2_GUI.pktNoTx);
    warplab_sendCmd(warplab_mimo_2x2_GUI.udp_node2, warplab_mimo_2x2_GUI.RADIO3_RXDIS, warplab_mimo_2x2_GUI.pktNoTx);
    warplab_sendCmd(warplab_mimo_2x2_GUI.udp_node2, warplab_mimo_2x2_GUI.RADIO2RXBUFF_RXEN, warplab_mimo_2x2_GUI.pktNoTx);
elseif warplab_mimo_2x2_GUI.RxSelect == 1;
    warplab_sendCmd(warplab_mimo_2x2_GUI.udp_node2, warplab_mimo_2x2_GUI.RADIO2_RXDIS, warplab_mimo_2x2_GUI.pktNoTx);
    warplab_sendCmd(warplab_mimo_2x2_GUI.udp_node2, warplab_mimo_2x2_GUI.RADIO3_RXEN, warplab_mimo_2x2_GUI.pktNoTx);
    warplab_sendCmd(warplab_mimo_2x2_GUI.udp_node2, warplab_mimo_2x2_GUI.RADIO3RXBUFF_RXEN, warplab_mimo_2x2_GUI.pktNoTx);
elseif warplab_mimo_2x2_GUI.RxSelect == 2;
    warplab_sendCmd(warplab_mimo_2x2_GUI.udp_node2, warplab_mimo_2x2_GUI.RADIO2_RXEN, warplab_mimo_2x2_GUI.pktNoTx);
    warplab_sendCmd(warplab_mimo_2x2_GUI.udp_node2, warplab_mimo_2x2_GUI.RADIO3_RXEN, warplab_mimo_2x2_GUI.pktNoTx);
    warplab_sendCmd(warplab_mimo_2x2_GUI.udp_node2, [warplab_mimo_2x2_GUI.RADIO2RXBUFF_RXEN, warplab_mimo_2x2_GUI.RADIO3RXBUFF_RXEN], warplab_mimo_2x2_GUI.pktNoTx);
end

set(handles.text31, 'String', '3');
%Enable the transmission
warplab_sendCmd(warplab_mimo_2x2_GUI.udp_node1, warplab_mimo_2x2_GUI.TX_START, warplab_mimo_2x2_GUI.pktNoTx);

%Enable the capture
warplab_sendCmd(warplab_mimo_2x2_GUI.udp_node2, warplab_mimo_2x2_GUI.RX_START, warplab_mimo_2x2_GUI.pktNoTx);

%Send the SYNC packet
warplab_sendSync(warplab_mimo_2x2_GUI.udp_Sync);

%Read back the received samples
global rxData_A rxData_B rxOTR_A rxOTR_B %rxRSSI_A rxRSSI_B;
rxData_A = zeros(1,2^14);
rxData_B = zeros(1,2^14);
rxOTR_A = zeros(1,2^14);
rxOTR_B = zeros(1,2^14);

set(handles.text31, 'String', '4');
%Read back the received samples
if warplab_mimo_2x2_GUI.RxSelect == 0;
    [RawRxData_A] = warplab_readSMRO(warplab_mimo_2x2_GUI.udp_node2, warplab_mimo_2x2_GUI.RADIO2_RXDATA, 2^14);
    [rxData_A,rxOTR_A] = warplab_processRawRxData(RawRxData_A);
elseif warplab_mimo_2x2_GUI.RxSelect == 1;
    [RawRxData_B] = warplab_readSMRO(warplab_mimo_2x2_GUI.udp_node2, warplab_mimo_2x2_GUI.RADIO3_RXDATA, 2^14);
    [rxData_B,rxOTR_B] = warplab_processRawRxData(RawRxData_B);
elseif warplab_mimo_2x2_GUI.RxSelect == 2;
    [RawRxData_A] = warplab_readSMRO(warplab_mimo_2x2_GUI.udp_node2, warplab_mimo_2x2_GUI.RADIO2_RXDATA, 2^14);
    [RawRxData_B] = warplab_readSMRO(warplab_mimo_2x2_GUI.udp_node2, warplab_mimo_2x2_GUI.RADIO3_RXDATA, 2^14);
    [rxData_A,rxOTR_A] = warplab_processRawRxData(RawRxData_A);
    [rxData_B,rxOTR_B] = warplab_processRawRxData(RawRxData_B);
end

% Process the received samples to obtain meaningful data
%[rxData_A,rxOTR_A] = warplab_processRawRxData(RawRxData_A);
%[rxData_B,rxOTR_B] = warplab_processRawRxData(RawRxData_B);

% Read stored RSSI data
%[RawRSSIData_A] = warplab_readSMRO(warplab_mimo_2x2_GUI.node_2, warplab_mimo_2x2_GUI.RADIO2_RSSIDATA, warplab_mimo_2x2_GUI.TxLength/8);
%[RawRSSIData_B] = warplab_readSMRO(warplab_mimo_2x2_GUI.node_2, warplab_mimo_2x2_GUI.RADIO3_RSSIDATA, warplab_mimo_2x2_GUI.TxLength/8);

% Procecss Raw RSSI data to obtain meningful RSSI values
%[rxRSSI_A] = warplab_processRawRSSIData(RawRSSIData_A);
%[rxRSSI_B] = warplab_processRawRSSIData(RawRSSIData_B);

set(handles.text31, 'String', '5');
%[rxData rxOTR rxRSSI] = warplab_RxDataRead(warplab_mimo_2x2_GUI.node_2, 2, warplab_mimo_2x2_GUI.TxLength);
evalin('base', 'global rxData_A rxData_B rxOTR_A rxOTR_B');

if warplab_mimo_2x2_GUI.TxSelect == 0;
   warplab_sendCmd(warplab_mimo_2x2_GUI.udp_node1, warplab_mimo_2x2_GUI.RADIO2TXBUFF_TXDIS, warplab_mimo_2x2_GUI.pktNoTx);
elseif warplab_mimo_2x2_GUI.TxSelect == 1;
    warplab_sendCmd(warplab_mimo_2x2_GUI.udp_node1, warplab_mimo_2x2_GUI.RADIO3TXBUFF_TXDIS, warplab_mimo_2x2_GUI.pktNoTx);
elseif warplab_mimo_2x2_GUI.TxSelect == 2;
    warplab_sendCmd(warplab_mimo_2x2_GUI.udp_node1, [warplab_mimo_2x2_GUI.RADIO2TXBUFF_TXDIS, warplab_mimo_2x2_GUI.RADIO3TXBUFF_TXDIS], warplab_mimo_2x2_GUI.pktNoTx);
end

if warplab_mimo_2x2_GUI.RxSelect == 0;
    warplab_sendCmd(warplab_mimo_2x2_GUI.udp_node2, warplab_mimo_2x2_GUI.RADIO2RXBUFF_RXDIS, warplab_mimo_2x2_GUI.pktNoTx);
elseif warplab_mimo_2x2_GUI.RxSelect == 1;
    warplab_sendCmd(warplab_mimo_2x2_GUI.udp_node2, warplab_mimo_2x2_GUI.RADIO3RXBUFF_RXDIS, warplab_mimo_2x2_GUI.pktNoTx);
elseif warplab_mimo_2x2_GUI.RxSelect == 2;
    warplab_sendCmd(warplab_mimo_2x2_GUI.udp_node2, [warplab_mimo_2x2_GUI.RADIO2RXBUFF_RXDIS, warplab_mimo_2x2_GUI.RADIO3RXBUFF_RXDIS], warplab_mimo_2x2_GUI.pktNoTx);
end

set(handles.text31, 'String', '6');

%Disable the transmitter
warplab_sendCmd(warplab_mimo_2x2_GUI.udp_node1, warplab_mimo_2x2_GUI.RADIO2_TXDIS, warplab_mimo_2x2_GUI.pktNoTx);
warplab_sendCmd(warplab_mimo_2x2_GUI.udp_node1, warplab_mimo_2x2_GUI.RADIO3_TXDIS, warplab_mimo_2x2_GUI.pktNoTx);

%Reset the receivers
warplab_sendCmd(warplab_mimo_2x2_GUI.udp_node2, warplab_mimo_2x2_GUI.RX_DONEREADING, warplab_mimo_2x2_GUI.pktNoTx);

%Disable the receiver
warplab_sendCmd(warplab_mimo_2x2_GUI.udp_node2, warplab_mimo_2x2_GUI.RADIO2_RXDIS, warplab_mimo_2x2_GUI.pktNoTx);
warplab_sendCmd(warplab_mimo_2x2_GUI.udp_node2, warplab_mimo_2x2_GUI.RADIO3_RXDIS, warplab_mimo_2x2_GUI.pktNoTx);

%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% % Start of Code to avoid conflict between users, only needed for the  
% % workshop 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% pnet('closeall');
% !del c:\boards_lock.txt 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% % End of Code to avoid conflict between users, only needed for the  
% % workshop 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 


set(handles.text31, 'String', '7');
axes(handles.axes_RAI); cla; c = axis(gca);
plot(real(rxData_A));
axis(gca, c); grid on;
xlabel('RxA I');
%plot real data on certain graph

axes(handles.axes_RAQ); cla; f1 = axis(gca);
plot(imag(rxData_A));
axis(gca, f1); grid on;
xlabel('RxA Q');
%plot imaginary data on certain graph

freq_axis = 40e6*(0:2^14)/2^14;
freq_axis_shift = fftshift(freq_axis);
freq_ticks=[freq_axis_shift(1:2^13)-freq_axis_shift(2^13),freq_axis_shift(2^13+1:2^14+1)];

axes(handles.axes_RASpectrum); cla; f2 = axis(gca);
spectrum=10*log10(abs(fftshift(fft(rxData_A))));
plot(freq_ticks(2^12:3*2^12),spectrum(2^12:3*2^12));
% spectrum=10*log10(abs(fftshift(fft(warplab_sisoGUI.radio2TxData))))
% plot(freq_ticks,10*log10(abs(fftshift(fft(warplab_sisoGUI.radio2TxData)))));
%plot(10*log10(abs(fft(warplab_sisoGUI.radio2TxData,2^14))));
%axis tight;
grid on;
xlabel('RxA Spectrum');

axes(handles.axes_RBI); cla; f3 = axis(gca);
plot(real(rxData_B));
axis(gca, f3); grid on;
xlabel('RxB I');
%plot real data on certain graph

axes(handles.axes_RBQ); cla; f4 = axis(gca);
plot(imag(rxData_B));
axis(gca, f4); grid on;
xlabel('RxB Q');
%plot imaginary data on certain graph

axes(handles.axes_RBSpectrum); cla; f5 = axis(gca);
spectrum=10*log10(abs(fftshift(fft(rxData_B))));
plot(freq_ticks(2^12:3*2^12),spectrum(2^12:3*2^12));
%plot(10*log10(abs(fftshift(fft(rxData)))));
%plot(10*log10(abs(fft(rxData,2^14))));
%axis tight;
grid on;
xlabel('RxB Spectrum');
set(hObject, 'Enable', 'On');

set(handles.text31, 'String', '8');
% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pnet('closeall');


function TxA_BB_Callback(hObject, eventdata, handles)
% hObject    handle to TxA_BB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TxA_BB as text
%        str2double(get(hObject,'String')) returns contents of TxA_BB as a double


% --- Executes during object creation, after setting all properties.
function TxA_BB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TxA_BB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global warplab_mimo_2x2_GUI;
set(hObject, 'String', sprintf('%d', warplab_mimo_2x2_GUI.TxA_BB));
% set value of TxA_BB (choosen by user) as gain

function TxB_BB_Callback(hObject, eventdata, handles)
% hObject    handle to TxB_BB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TxB_BB as text
%        str2double(get(hObject,'String')) returns contents of TxB_BB as a double


% --- Executes during object creation, after setting all properties.
function TxB_BB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TxB_BB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global warplab_mimo_2x2_GUI;
set(hObject, 'String', sprintf('%d', warplab_mimo_2x2_GUI.TxB_BB));
% set value of TxB_BB (choosen by user) as gain

function TxA_RF_Callback(hObject, eventdata, handles)
% hObject    handle to TxA_RF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TxA_RF as text
%        str2double(get(hObject,'String')) returns contents of TxA_RF as a double


% --- Executes during object creation, after setting all properties.
function TxA_RF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TxA_RF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global warplab_mimo_2x2_GUI;
set(hObject, 'String', sprintf('%d', warplab_mimo_2x2_GUI.TxA_RF));
% set value of TxA_RF (choosen by user) as gain

function TxB_RF_Callback(hObject, eventdata, handles)
% hObject    handle to TxB_RF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TxB_RF as text
%        str2double(get(hObject,'String')) returns contents of TxB_RF as a double


% --- Executes during object creation, after setting all properties.
function TxB_RF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TxB_RF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global warplab_mimo_2x2_GUI;
set(hObject, 'String', sprintf('%d', warplab_mimo_2x2_GUI.TxB_RF));
% set value of TxB_RF (choosen by user) as gain

function RxA_BB_Callback(hObject, eventdata, handles)
% hObject    handle to RxA_BB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RxA_BB as text
%        str2double(get(hObject,'String')) returns contents of RxA_BB as a double


% --- Executes during object creation, after setting all properties.
function RxA_BB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RxA_BB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global warplab_mimo_2x2_GUI;
set(hObject, 'String', sprintf('%d', warplab_mimo_2x2_GUI.RxA_BB));
% set value of RxA_BB (choosen by user) as gain

function RxA_RF_Callback(hObject, eventdata, handles)
% hObject    handle to RxA_RF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RxA_RF as text
%        str2double(get(hObject,'String')) returns contents of RxA_RF as a double


% --- Executes during object creation, after setting all properties.
function RxA_RF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RxA_RF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global warplab_mimo_2x2_GUI;
set(hObject, 'String', sprintf('%d', warplab_mimo_2x2_GUI.RxA_RF));
% set value of RxA_RF(choosen by user) as gain

function RxB_RF_Callback(hObject, eventdata, handles)
% hObject    handle to RxB_RF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RxB_RF as text
%        str2double(get(hObject,'String')) returns contents of RxB_RF as a double


% --- Executes during object creation, after setting all properties.
function RxB_RF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RxB_RF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global warplab_mimo_2x2_GUI;
set(hObject, 'String', sprintf('%d', warplab_mimo_2x2_GUI.RxB_RF));
% set value of RxB_RF (choosen by user) as gain

function RxB_BB_Callback(hObject, eventdata, handles)
% hObject    handle to RxB_BB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RxB_BB as text
%        str2double(get(hObject,'String')) returns contents of RxB_BB as a double


% --- Executes during object creation, after setting all properties.
function RxB_BB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RxB_BB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global warplab_mimo_2x2_GUI;
set(hObject, 'String', sprintf('%d', warplab_mimo_2x2_GUI.RxB_BB));
% set value of RxB_BB (choosen by user) as gain

function Channel_Callback(hObject, eventdata, handles)
% hObject    handle to Channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Channel as text
%        str2double(get(hObject,'String')) returns contents of Channel as a double


% --- Executes during object creation, after setting all properties.
function Channel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Capture_Offset_Callback(hObject, eventdata, handles)
% hObject    handle to Capture_Offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Capture_Offset as text
%        str2double(get(hObject,'String')) returns contents of Capture_Offset as a double


% --- Executes during object creation, after setting all properties.
function Capture_Offset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Capture_Offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --------------------------------------------------------------------
function uipanel6_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to uipanel6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(hObject,'Tag')
    case 'TxradioA'
        set(handles.TxSelect1, 'String' ,'0')
    case 'TxradioB'
        set(handles.TxSelect1, 'String' ,'1')
    case 'TxradioBoth'
        set(handles.TxSelect1, 'String' ,'2')
    otherwise
        display kobe
end

% --------------------------------------------------------------------
function uipanel5_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to uipanel5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(hObject,'Tag')
    case 'RxradioA'
        set(handles.RxSelect1, 'String' ,'0')
    case 'RxradioB'
        set(handles.RxSelect1, 'String' ,'1')
    case 'RxradioBoth'
        set(handles.RxSelect1, 'String' ,'2')
    otherwise
        display kobe
end

set(handles.text31, 'String', '10');
%Define the options vector; the order of opitons is set by the FPGA's code
function updateOptions(hObject, eventdata, handles)
global warplab_mimo_2x2_GUI;
warplab_mimo_2x2_GUIdefines;
warplab_mimo_2x2_GUI.TxA_BB = eval(get(handles.TxA_BB, 'String'));
warplab_mimo_2x2_GUI.TxB_BB = eval(get(handles.TxB_BB, 'String'));
warplab_mimo_2x2_GUI.TxA_RF = eval(get(handles.TxA_RF, 'String'));
warplab_mimo_2x2_GUI.TxB_RF = eval(get(handles.TxB_RF, 'String'));
warplab_mimo_2x2_GUI.RxA_BB = eval(get(handles.RxA_BB, 'String'));
warplab_mimo_2x2_GUI.RxB_BB = eval(get(handles.RxB_BB, 'String'));
warplab_mimo_2x2_GUI.RxA_RF = eval(get(handles.RxA_RF, 'String'));
warplab_mimo_2x2_GUI.RxB_RF = eval(get(handles.RxB_RF, 'String'));
% warplab_mimo_2x2_GUI.CaptOffset = eval(get(handles.Capture_Offset, 'String'));
warplab_mimo_2x2_GUI.TxDelay = eval(get(handles.Capture_Offset, 'String'));
warplab_mimo_2x2_GUI.CarrierChannel = eval(get(handles.Channel, 'String'));
warplab_mimo_2x2_GUI.TxSelect = eval(get(handles.TxSelect1, 'String'));
warplab_mimo_2x2_GUI.RxSelect = eval(get(handles.RxSelect1, 'String'));
warplab_mimo_2x2_GUI.TxMode = 0;

% warplab_writeRegister(warplab_mimo_2x2_GUI.udp_node2,warplab_mimo_2x2_GUI.CAPT_OFFSET, warplab_mimo_2x2_GUI.CaptOffset);
warplab_writeRegister(warplab_mimo_2x2_GUI.udp_node1,warplab_mimo_2x2_GUI.TX_DELAY, warplab_mimo_2x2_GUI.TxDelay);
warplab_writeRegister(warplab_mimo_2x2_GUI.udp_node1,warplab_mimo_2x2_GUI.TX_LENGTH, warplab_mimo_2x2_GUI.TxLength);
warplab_writeRegister(warplab_mimo_2x2_GUI.udp_node1,warplab_mimo_2x2_GUI.TX_MODE, warplab_mimo_2x2_GUI.TxMode);
warplab_setRadioParameter(warplab_mimo_2x2_GUI.udp_node1,warplab_mimo_2x2_GUI.CARRIER_CHANNEL,warplab_mimo_2x2_GUI.CarrierChannel);
warplab_setRadioParameter(warplab_mimo_2x2_GUI.udp_node2,warplab_mimo_2x2_GUI.CARRIER_CHANNEL,warplab_mimo_2x2_GUI.CarrierChannel);
warplab_setRadioParameter(warplab_mimo_2x2_GUI.udp_node1,warplab_mimo_2x2_GUI.RADIO2_TXGAINS,(warplab_mimo_2x2_GUI.TxA_RF + warplab_mimo_2x2_GUI.TxA_BB*2^16));
warplab_setRadioParameter(warplab_mimo_2x2_GUI.udp_node1,warplab_mimo_2x2_GUI.RADIO3_TXGAINS,(warplab_mimo_2x2_GUI.TxB_RF + warplab_mimo_2x2_GUI.TxB_BB*2^16));
warplab_setRadioParameter(warplab_mimo_2x2_GUI.udp_node2,warplab_mimo_2x2_GUI.RADIO2_RXGAINS,(warplab_mimo_2x2_GUI.RxA_BB + warplab_mimo_2x2_GUI.RxA_RF*2^16));
warplab_setRadioParameter(warplab_mimo_2x2_GUI.udp_node2,warplab_mimo_2x2_GUI.RADIO3_RXGAINS,(warplab_mimo_2x2_GUI.RxB_BB + warplab_mimo_2x2_GUI.RxB_RF*2^16));
set(handles.text31, 'String', '11');


    % --- Executes during object creation, after setting all properties.
function axes_RAI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_RAI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes_RAI


axis(gca, [-1 2^14 -1 1]);
grid on;
%plot with grid on

% --- Executes during object creation, after setting all properties.
function axes_RAQ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_RAQ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes_RAQ

axis(gca, [-1 2^14 -1 1]);
grid on;
%plot with grid on

% --- Executes during object creation, after setting all properties.
function axes_RASpectrum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_RASpectrum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes_RASpectrum


axis(gca, [-1 2^14 -1 1]);
grid on;
%plot with grid on

% --- Executes during object creation, after setting all properties.
function axes_RBI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_RBI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes_RBI


axis(gca, [-1 2^14 -1 1]);
grid on;
%plot with grid on

% --- Executes during object creation, after setting all properties.
function axes_RBQ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_RBQ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes_RBQ


axis(gca, [-1 2^14 -1 1]);
grid on;
%plot with grid on

% --- Executes during object creation, after setting all properties.
function axes_RBSpectrum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_RBSpectrum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes_RBSpectrum

axis(gca, [-1 2^14 -1 1]);
grid on;
%plot with grid on
