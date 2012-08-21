function varargout = WARPLab_Demo(varargin)
% WARPLAB_DEMO M-file for WARPLab_Demo.fig
%      WARPLAB_DEMO, by itself, creates a new WARPLAB_DEMO or raises the existing
%      singleton*.
%
%      H = WARPLAB_DEMO returns the handle to a new WARPLAB_DEMO or the handle to
%      the existing singleton*.
%
%      WARPLAB_DEMO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WARPLAB_DEMO.M with the given input arguments.
%
%      WARPLAB_DEMO('Property','Value',...) creates a new WARPLAB_DEMO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before WARPLab_Demo_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to WARPLab_Demo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help WARPLab_Demo

% Last Modified by GUIDE v2.5 14-Oct-2008 14:50:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @WARPLab_Demo_OpeningFcn, ...
                   'gui_OutputFcn',  @WARPLab_Demo_OutputFcn, ...
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
global SchemeSelect; % 0 2x1 Beamforming 2 feedback bits
                     % 1 2x1 Alamouti
global ConstellationSize;
global TxPowerRF_Radio2;
global TxPowerRF_Radio3;
global TxPowerBB_Radio2;
global TxPowerBB_Radio3;


% --- Executes just before WARPLab_Demo is made visible.
function WARPLab_Demo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to WARPLab_Demo (see VARARGIN)

% Choose default command line output for WARPLab_Demo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes WARPLab_Demo wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global SchemeSelect; % 0 2x1 Beamforming 2 feedback bits
                     % 1 2x1 Alamouti
SchemeSelect = 1;                                              
global ConstellationSize;
ConstellationSize = 4;
global TxPowerRF_Radio2;
global TxPowerRF_Radio3;
TxPowerRF_Radio2 = 1; % Tx RF Gain. In [0:63]
TxPowerRF_Radio3 = 1; % Tx RF Gain. In [0:63]
global TxPowerBB_Radio2;
global TxPowerBB_Radio3;
TxPowerBB_Radio2 = 1; %Tx Baseband Gain. In [0:3]
TxPowerBB_Radio3 = 1; %Tx Baseband Gain. In [0:3]


% --- Outputs from this function are returned to the command line.
function varargout = WARPLab_Demo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function uipanel1_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SchemeSelect;
switch get(hObject,'Tag')
    case 'Alamouti'
        SchemeSelect = 1;
    case 'Beamforming'
        SchemeSelect = 0;
    case 'Sphere'
        SchemeSelect = 2;
    otherwise
        errordlg('Invalid Scheme!');
end


function Tx_BB_Callback(hObject, eventdata, handles)
% hObject    handle to Tx_BB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tx_BB as text
%        str2double(get(hObject,'String')) returns contents of Tx_BB as a double


% --- Executes during object creation, after setting all properties.
function Tx_BB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tx_BB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Tx_RF_Callback(hObject, eventdata, handles)
% hObject    handle to Tx_RF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tx_RF as text
%        str2double(get(hObject,'String')) returns contents of Tx_RF as a double


% --- Executes during object creation, after setting all properties.
function Tx_RF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tx_RF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Constellation_Callback(hObject, eventdata, handles)
% hObject    handle to Constellation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Constellation as text
%        str2double(get(hObject,'String')) returns contents of Constellation as a double


% --- Executes during object creation, after setting all properties.
function Constellation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Constellation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in StartPushbutton.
function StartPushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to StartPushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global SchemeSelect; % 0 2x1 Beamforming 2 feedback bits
                     % 1 2x1 Alamouti
global ConstellationSize;
global TxPowerRF_Radio2;
global TxPowerRF_Radio3;
global TxPowerBB_Radio2;
global TxPowerBB_Radio3;

% set(hObject, 'Enable', 'Off');


TxPowerRF_Radio2_Temp = eval(get(handles.Tx_RF, 'String'));
TxPowerRF_Radio3_Temp = eval(get(handles.Tx_RF, 'String'));
TxPowerBB_Radio2_Temp = eval(get(handles.Tx_BB, 'String'));
TxPowerBB_Radio3_Temp = eval(get(handles.Tx_BB, 'String'));
ConstellationSize_Temp = eval(get(handles.Constellation, 'String'));

% Reset Error Flag 
Error_Flag = 0;
% Tst user inputs are valid before assignment to global variables
if((0>TxPowerBB_Radio2_Temp) || (3<TxPowerBB_Radio2_Temp))
    Error_Flag = 1;
    errordlg('Invalid Tx BB Power!');
end
if((0>TxPowerBB_Radio3_Temp) || (3<TxPowerBB_Radio3_Temp))
    Error_Flag = 1;
    errordlg('Invalid Tx BB Power!');
end
if((0>TxPowerRF_Radio2_Temp) || (63<TxPowerRF_Radio2_Temp))
    Error_Flag = 1;
    errordlg('Invalid Tx RF Power!');
end
if((0>TxPowerRF_Radio3_Temp) || (63<TxPowerRF_Radio3_Temp))
    Error_Flag = 1;
    errordlg('Invalid Tx RF Power!');
end
% Possible_Constellations = 2.^([1:1:11]);
Possible_Constellations = 2.^([1:1:6]);
IsValidConstellation = length(find(Possible_Constellations==ConstellationSize_Temp));
if(0==IsValidConstellation)
    Error_Flag = 1;
    errordlg('Invalid constellation size! Constellation size must be a power of 2 between 2 and 64.');
end

if(1 == Error_Flag)
    set(handles.StartPushbutton,'UserData',0);
    guidata(hObject, handles);
%     set(hObject, 'Enable', 'On');
else
set(handles.StartPushbutton,'UserData',1); 
set(handles.Alamouti, 'Enable', 'Off');
set(handles.Beamforming, 'Enable', 'Off');
set(handles.Sphere, 'Enable', 'Off');
set(handles.Tx_RF, 'Enable', 'Off');
set(handles.Tx_BB, 'Enable', 'Off');
set(handles.Constellation, 'Enable', 'Off');
set(handles.StopPushbutton, 'Enable', 'On');
set(handles.StartPushbutton, 'Enable', 'Off');
TxPowerRF_Radio2 = TxPowerRF_Radio2_Temp;
TxPowerRF_Radio3 = TxPowerRF_Radio3_Temp;
TxPowerBB_Radio2 = TxPowerRF_Radio2_Temp;
TxPowerBB_Radio3 = TxPowerRF_Radio3_Temp;
ConstellationSize = ConstellationSize_Temp;

if((0==SchemeSelect) || (1==SchemeSelect))
Tx2Rx1_BFvsAlm_Demo_v01
end

if(2==SchemeSelect)
    Total_Errors_SD = 0;
    Total_Bits_SD = 0;

    while (get(handles.StartPushbutton,'UserData') ==1)
        warplab_4x4_detection_sd_demo
        %"flushes the event queue" and updates the figure window
        %since Matlab is a single thread process, this command is requierd
        drawnow
    end
end

set(handles.Alamouti, 'Enable', 'On');
set(handles.Beamforming, 'Enable', 'On');
set(handles.Sphere, 'Enable', 'On');
set(handles.Tx_RF, 'Enable', 'On');
set(handles.Tx_BB, 'Enable', 'On');
set(handles.Constellation, 'Enable', 'On');
set(handles.StartPushbutton, 'Enable', 'On');

% 
% if(0==SchemeSelect)
% 
% % %Plot of received and transmitted constellation points
% % axes(handles.axes_BeamformingConstellation); 
% % cla; 
% % plot(real(yrx_bb_mf_ds_mrc_norm),imag(yrx_bb_mf_ds_mrc_norm),'g.');
% % hold on;
% % plot(real(ytx_mod_norm),imag(ytx_mod_norm),'k*');
% % %title('Constellations Beamforming');
% % %legend('Received','Transmitted');
% % axis([-2 2 -2 2]); % Set axis ranges.
% % hold off;
% % 
% % % Frequency content
% % freq_axis = 40e6*(0:2^14-1)/2^14;
% % freq_axis_shift = fftshift(freq_axis);
% % freq_ticks=[freq_axis_shift(1:2^13)-freq_axis_shift(2^13),freq_axis_shift(2^13+1:2^14)];
% % 
% % spectrum=10*log10(abs(fftshift(fft(RxData_2_BF,2^14))));
% % % freqaxismin = find(-5e6==freq_ticks);
% % % freqaxismax = find(5e6==freq_ticks);
% % axes(handles.axes_BeamformingSpectrum); 
% % cla;
% % % plot(freq_ticks(6965:9420),spectrum(6965:9420));
% % plot(freq_ticks,spectrum);
% % xlim([-2.5e6 2.5e6]) 
% % grid on;
% % 
% % set(handles.Error_Beamforming, 'String', num2str(Result_Total_Errors_Vec_BF_AllChannels));
% % set(handles.Total_Beamforming, 'String', num2str(Result_Total_Bits_Vec_BF_AllChannels));
% % set(handles.BER_Beamforming, 'String', num2str(Result_BER_BF_AllChannels));
% 
% end
% 
% if(1==SchemeSelect)
%     
% % % Plot of received and transmitted constellation points
% % axes(handles.axes_AlamoutiConstellation); 
% % cla; 
% % plot(real(yrx_bb_mf_ds_alm_norm),imag(yrx_bb_mf_ds_alm_norm),'g.');
% % hold on;
% % plot(real(ytx_mod_norm),imag(ytx_mod_norm),'k*');
% % %title('Constellations Alamouti');
% % %legend('Received','Transmitted');
% % axis([-2 2 -2 2]); % Set axis ranges.
% % hold off;
% % 
% % % Frequency content
% % freq_axis = 40e6*(0:2^14-1)/2^14;
% % freq_axis_shift = fftshift(freq_axis);
% % freq_ticks=[freq_axis_shift(1:2^13)-freq_axis_shift(2^13),freq_axis_shift(2^13+1:2^14)];
% % 
% % spectrum=10*log10(abs(fftshift(fft(RxData_2,2^14))));
% % % freqaxismin = find(-5e6==freq_ticks);
% % % freqaxismax = find(5e6==freq_ticks);
% % axes(handles.axes_AlamoutiSpectrum); %cla; c = axis(gca);
% % plot(freq_ticks,spectrum);
% % xlim([-2.5e6 2.5e6]) 
% % grid on;
% % 
% % set(handles.Error_Alamouti, 'String', num2str(Result_Total_Errors_Vec_Alm));
% % set(handles.Total_Alamouti, 'String', num2str(Result_Total_Bits_Vec_Alm));
% % set(handles.BER_Alamouti, 'String', num2str(Result_BER_Alm));
% end

% set(hObject, 'Enable', 'On');
guidata(hObject, handles);
end







% --- Executes on button press in StopPushbutton.
function StopPushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to StopPushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.StartPushbutton,'UserData',0);
set(handles.StopPushbutton, 'Enable', 'Off');
guidata(hObject, handles);

