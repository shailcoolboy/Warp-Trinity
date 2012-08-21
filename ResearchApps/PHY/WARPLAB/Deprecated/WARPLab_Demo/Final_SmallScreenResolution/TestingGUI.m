function varargout = TestingGUI(varargin)
% TESTINGGUI M-file for TestingGUI.fig
%      TESTINGGUI, by itself, creates a new TESTINGGUI or raises the existing
%      singleton*.
%
%      H = TESTINGGUI returns the handle to a new TESTINGGUI or the handle to
%      the existing singleton*.
%
%      TESTINGGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TESTINGGUI.M with the given input arguments.
%
%      TESTINGGUI('Property','Value',...) creates a new TESTINGGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TestingGUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TestingGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TestingGUI

% Last Modified by GUIDE v2.5 08-Oct-2008 21:25:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TestingGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @TestingGUI_OutputFcn, ...
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


% --- Executes just before TestingGUI is made visible.
function TestingGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TestingGUI (see VARARGIN)

% Choose default command line output for TestingGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TestingGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TestingGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%initialize the flag variable
set(handles.pushbutton1,'UserData',1); 
 
%while the flag variable is one, the loop continues
while (get(handles.pushbutton1,'UserData') ==1)
    %increments the counter
    temp = str2num(get(handles.counter_text,'String'));
    temp = temp + 1;
    set(handles.counter_text,'String',num2str(temp));
 
    %"flushes the event queue" and updates the figure window
    %since Matlab is a single thread process, this command is requierd
    drawnow
end
 
guidata(hObject, handles);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%toggle the flag variable so that the other process will stop
set(handles.pushbutton1,'UserData',0);
guidata(hObject, handles);





function counter_text_Callback(hObject, eventdata, handles)
% hObject    handle to counter_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of counter_text as text
%        str2double(get(hObject,'String')) returns contents of counter_text as a double


% --- Executes during object creation, after setting all properties.
function counter_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to counter_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


