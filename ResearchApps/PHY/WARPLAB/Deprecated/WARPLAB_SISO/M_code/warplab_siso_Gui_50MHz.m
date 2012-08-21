function varargout = warplab_siso_Gui_50MHz(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @warplab_siso_Gui_50MHz_OpeningFcn, ...
                   'gui_OutputFcn',  @warplab_siso_Gui_50MHz_OutputFcn, ...
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
global warplab_sisoGUI;
warplab_siso_GUIdefines;


% --- Executes just before warplab_siso_Gui_50MHz is made visible.
function warplab_siso_Gui_50MHz_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to warplab_siso_Gui_50MHz (see VARARGIN)
% Choose default command line output for warplab_siso_Gui_50MHz
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

%Close any stale sockets
pnet('closeall');

global warplab_sisoGUI;

%Options
warplab_sisoGUI.CaptOffset = 1000;
warplab_sisoGUI.TxLength = 16384;
warplab_sisoGUI.TxGainBB = 3; %Tx Baseband Gain [0:3]
warplab_sisoGUI.TxGainRF = 40; %Tx RF Gain - [0:63]
warplab_sisoGUI.RxGainBB = 20; %Rx Baseband Gain - [0:31]
warplab_sisoGUI.RxGainRF = 1; %Rx RF Gain - [1:3]
warplab_sisoGUI.CarrierChannel = 11;

% Axes
axes(handles.axes_I); 
xlabel('Rx I');

axes(handles.axes_Q); 
xlabel('Rx Q');

axes(handles.axes_TxIQ); 
xlabel('Tx Spectrum');

axes(handles.axes_RxIQ); 
xlabel('Rx Spectrum');



% --- Outputs from this function are returned to the command line.
function varargout = warplab_siso_Gui_50MHz_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_TxVector_Callback(hObject, eventdata, handles)
% hObject    handle to edit_TxVector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_TxVector as text
%        str2double(get(hObject,'String')) returns contents of edit_TxVector as a double
global warplab_sisoGUI;
warplab_siso_GUIdefines;
evalin('base','t = 0:20e-9:(2^14-1)*20e-9;');
warplab_sisoGUI.radio2TxData = evalin('base',get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function edit_TxVector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_TxVector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global warplab_sisoGUI;
warplab_siso_GUIdefines;
evalin('base','t = 0:20e-9:(2^14-1)*20e-9;');
warplab_sisoGUI.radio2TxData = evalin('base',get(hObject,'String'));

% --- Executes on button press in pushbutton_Go.
function pushbutton_Go_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Go (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Download the samples to be transmitted
global warplab_sisoGUI;
set(handles.text_status, 'String', 'Running...');

set(hObject, 'Enable', 'Off');
% warplab_siso_GUIdefines;

warplab_siso_GUIinitialize;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Start of Code to avoid conflict between users, only needed for the 
% workshop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% if(okToUseBoards == 0)
% 	set(hObject, 'Enable', 'On');
%     set(handles.text_status, 'String', 'Done!');
% 	return;
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End of Code to avoid conflict between users, only needed for the 
% workshop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


updateOptions(hObject, eventdata, handles);

%Download the samples to be transmitted
warplab_writeSMWO(warplab_sisoGUI.udp_Tx, warplab_sisoGUI.radio2TxData, warplab_sisoGUI.RADIO2_TXDATA);

%Enable Tx Radio #2
warplab_sendCmd(warplab_sisoGUI.udp_Tx, warplab_sisoGUI.RADIO2_TXEN, warplab_sisoGUI.pktNoTx);

%Enable Rx Radio #2
warplab_sendCmd(warplab_sisoGUI.udp_RxA, warplab_sisoGUI.RADIO2_RXEN, warplab_sisoGUI.pktNoTx);

%Enable the transmission
warplab_sendCmd(warplab_sisoGUI.udp_Tx, warplab_sisoGUI.TX_START, warplab_sisoGUI.pktNoTx);

%Enable the capture
warplab_sendCmd(warplab_sisoGUI.udp_RxA, warplab_sisoGUI.RX_START, warplab_sisoGUI.pktNoTx);

%Send the SYNC packet
warplab_sendSync(warplab_sisoGUI.udp_Sync);

%Read back the received samples
global rxData rxOTR rxRSSI;

%Read back the received samples
[RawRxData] = warplab_readSMRO(warplab_sisoGUI.udp_RxA, warplab_sisoGUI.RADIO2_RXDATA, warplab_sisoGUI.TxLength);
% Process the received samples to obtain meaningful data
[rxData,rxOTR] = warplab_processRawRxData(RawRxData);
% Read stored RSSI data
[RawRSSIData] = warplab_readSMRO(warplab_sisoGUI.udp_RxA, warplab_sisoGUI.RADIO2_RSSIDATA, warplab_sisoGUI.TxLength/8);
% Procecss Raw RSSI data to obtain meningful RSSI values
[rxRSSI] = warplab_processRawRSSIData(RawRSSIData);

%[rxData rxOTR rxRSSI] = warplab_RxDataRead(warplab_sisoGUI.udp_RxA, 2, warplab_sisoGUI.TxLength);
evalin('base', 'global rxData rxOTR rxRSSI;');

%Reset the receivers
warplab_sendCmd(warplab_sisoGUI.udp_RxA, warplab_sisoGUI.RX_DONEREADING, warplab_sisoGUI.pktNoTx);

%Disable the receiver
warplab_sendCmd(warplab_sisoGUI.udp_RxA, warplab_sisoGUI.RADIO2_RXDIS, warplab_sisoGUI.pktNoTx);

%Disable the transmitter
warplab_sendCmd(warplab_sisoGUI.udp_Tx, warplab_sisoGUI.RADIO2_TXDIS, warplab_sisoGUI.pktNoTx);

% close sockets
pnet('closeall');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Start of Code to avoid conflict between users, only needed for the 
% workshop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% !del c:\boards_lock.txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End of Code to avoid conflict between users, only needed for the 
% workshop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


set(handles.text_status, 'String', 'Done!');

axes(handles.axes_I); cla; c = axis(gca);
plot(real(rxData));
axis(gca, c); grid on;
xlabel('Rx I');

axes(handles.axes_Q); cla; c = axis(gca);
plot(imag(rxData));
axis(gca, c); grid on;
xlabel('Rx Q');

freq_axis = 50e6*(0:2^14)/2^14;
freq_axis_shift = fftshift(freq_axis);
freq_ticks=[freq_axis_shift(1:2^13)-freq_axis_shift(2^13),freq_axis_shift(2^13+1:2^14+1)];

axes(handles.axes_TxIQ); cla; c = axis(gca);
spectrum=10*log10(abs(fftshift(fft(warplab_sisoGUI.radio2TxData))));
plot(freq_ticks(2^12:3*2^12),spectrum(2^12:3*2^12));
% spectrum=10*log10(abs(fftshift(fft(warplab_sisoGUI.radio2TxData))))
% plot(freq_ticks,10*log10(abs(fftshift(fft(warplab_sisoGUI.radio2TxData)))));
%plot(10*log10(abs(fft(warplab_sisoGUI.radio2TxData,2^14))));
%axis tight;
grid on;
xlabel('Tx Spectrum');

axes(handles.axes_RxIQ); cla; c = axis(gca);
spectrum=10*log10(abs(fftshift(fft(rxData(warplab_sisoGUI.CaptOffset:2^14),2^14))));
plot(freq_ticks(2^12:3*2^12),spectrum(2^12:3*2^12));
%plot(10*log10(abs(fftshift(fft(rxData)))));
%plot(10*log10(abs(fft(rxData,2^14))));
%axis tight;
grid on;
xlabel('Rx Spectrum');
set(hObject, 'Enable', 'On');

% --- Executes during object creation, after setting all properties.
function text_status_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called





% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pnet('closeall');

function edit_TxGainBB_Callback(hObject, eventdata, handles)
% hObject    handle to edit_TxGainBB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_TxGainBB as text
%        str2double(get(hObject,'String')) returns contents of edit_TxGainBB as a double


% --- Executes during object creation, after setting all properties.
function edit_TxGainBB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_TxGainBB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global warplab_sisoGUI;
set(hObject, 'String', sprintf('%d', warplab_sisoGUI.TxGainBB));


function edit_TxGainRF_Callback(hObject, eventdata, handles)
% hObject    handle to edit_TxGainRF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_TxGainRF as text
%        str2double(get(hObject,'String')) returns contents of edit_TxGainRF as a double


% --- Executes during object creation, after setting all properties.
function edit_TxGainRF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_TxGainRF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global warplab_sisoGUI;
set(hObject, 'String', sprintf('%d', warplab_sisoGUI.TxGainRF));



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_RxGainRF_Callback(hObject, eventdata, handles)
% hObject    handle to edit_RxGainRF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_RxGainRF as text
%        str2double(get(hObject,'String')) returns contents of edit_RxGainRF as a double


% --- Executes during object creation, after setting all properties.
function edit_RxGainRF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_RxGainRF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global warplab_sisoGUI;
set(hObject, 'String', sprintf('%d', warplab_sisoGUI.RxGainRF));

function edit_RxGainBB_Callback(hObject, eventdata, handles)
% hObject    handle to edit_RxGainBB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_RxGainBB as text
%        str2double(get(hObject,'String')) returns contents of edit_RxGainBB as a double
set(handles.slider_RxGainBB, 'Value', str2double(get(hObject,'String')));


% --- Executes during object creation, after setting all properties.
function edit_RxGainBB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_RxGainBB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global warplab_sisoGUI;
set(hObject, 'String', sprintf('%d', warplab_sisoGUI.RxGainBB));

% --- Executes on slider movement.
function slider_RxGainBB_Callback(hObject, eventdata, handles)
% hObject    handle to slider_RxGainBB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.edit_RxGainBB, 'String', round(get(hObject, 'Value')));

% --- Executes during object creation, after setting all properties.
function slider_RxGainBB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_RxGainBB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
global warplab_sisoGUI;
set(hObject, 'Value', warplab_sisoGUI.RxGainBB);

function edit_CaptureOffset_Callback(hObject, eventdata, handles)
% hObject    handle to edit_CaptureOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_CaptureOffset as text
%        str2double(get(hObject,'String')) returns contents of edit_CaptureOffset as a double


% --- Executes during object creation, after setting all properties.
function edit_CaptureOffset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_CaptureOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_Channel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Channel as text
%        str2double(get(hObject,'String')) returns contents of edit_Channel as a double


% --- Executes during object creation, after setting all properties.
function edit_Channel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function updateOptions(hObject, eventdata, handles)
global warplab_sisoGUI;
warplab_siso_GUIdefines;
warplab_sisoGUI.TxGainBB = eval(get(handles.edit_TxGainBB, 'String'));
warplab_sisoGUI.TxGainRF = eval(get(handles.edit_TxGainRF, 'String'));
warplab_sisoGUI.RxGainBB = eval(get(handles.edit_RxGainBB, 'String'));
warplab_sisoGUI.RxGainRF = eval(get(handles.edit_RxGainRF, 'String'));
warplab_sisoGUI.CaptOffset = eval(get(handles.edit_CaptureOffset, 'String'));
warplab_sisoGUI.CarrierChannel = eval(get(handles.edit_Channel, 'String'));

%Define the options vector; the order of opitons is set by the FPGA's code
warplab_sisoGUI.optionsVector = [warplab_sisoGUI.CaptOffset warplab_sisoGUI.TxLength-1 (warplab_sisoGUI.RxGainBB + warplab_sisoGUI.RxGainRF*2^16) (warplab_sisoGUI.TxGainRF + warplab_sisoGUI.TxGainBB*2^16) warplab_sisoGUI.CarrierChannel];
warplab_setOptions(warplab_sisoGUI.socketHandles,warplab_sisoGUI.optionsVector);


% --- Executes during object creation, after setting all properties.
function axes_RxIQ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_RxIQ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes_RxIQ
axis(gca, [-1 1 -1 1]);
grid on;


% --- Executes during object creation, after setting all properties.
function axes_TxIQ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_RxIQ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes_RxIQ
axis(gca, [-1 1 -1 1]);
grid on;




% --- Executes on slider movement.
function slider_TxGainRF_Callback(hObject, eventdata, handles)
% hObject    handle to slider_TxGainRF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.edit_TxGainRF, 'String', round(get(hObject, 'Value')));

% --- Executes during object creation, after setting all properties.
function slider_TxGainRF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_TxGainRF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
global warplab_sisoGUI;
set(hObject, 'Value', warplab_sisoGUI.TxGainRF);

% --- Executes during object creation, after setting all properties.
function axes_I_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_I (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes_I
axis(gca, [1 2^14 -1 1]);
grid on;

% --- Executes during object creation, after setting all properties.
function axes_Q_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes_Q
xlabel(hObject,'Rx Q');
axis(gca, [1 2^14 -1 1]);
grid on;
%xlabel('Rx Q');
%plot(imag(rxData));
%axis(gca, c); grid on;




