function varargout = LTEDemo(varargin)
% LTEDEMO M-file for LTEDemo.fig
%      LTEDEMO, by itself, creates a new LTEDEMO or raises the existing
%      singleton*.
%
%      H = LTEDEMO returns the handle to a new LTEDEMO or the handle to
%      the existing singleton*.
%
%      LTEDEMO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LTEDEMO.M with the given input arguments.
%
%      LTEDEMO('Property','Value',...) creates a new LTEDEMO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LTEDemo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LTEDemo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LTEDemo

% Last Modified by GUIDE v2.5 11-Oct-2009 23:15:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @LTEDemo_OpeningFcn, ...
    'gui_OutputFcn',  @LTEDemo_OutputFcn, ...
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

% My initialization
global bRunning;
bRunning = 1;


% --- Executes just before LTEDemo is made visible.
function LTEDemo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LTEDemo (see VARARGIN)

% Choose default command line output for LTEDemo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LTEDemo wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = LTEDemo_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_start.
function pushbutton_start_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global bRunning;
bRunning = 1;
global TxGain1;
global TxGain2;

% parameters
% total number of images
number_of_image = 5;
% set the initial of the image index
image_index = -1;
% set the delay between two succesive simulations
sim_delay = 0.1;
pic_delay = 2;
error_weight1 = 20;
error_weight2 = 50;

% start simulation
while(bRunning)
    set(handles.text4,'String','Transmitting');
    set(handles.text6,'String','Transmitting');

    % the block size of the subblock to be transmitted
    % if you want to choose the block size from the list control
    % you need to modify the property of the list control
    % and modify the callbank function of the list control.
    block_size = 8;
    % configue the line width of the box used to indicate the transmitted 
    % subblock.
    box_width = 2;

    % load the image
    % please modify here, if you use different name of the image.
    image_index = mod(image_index+1, number_of_image);
    imagename = ['img1_' num2str(image_index) '.bmp'];
    A1 = imread(imagename);
    imagename = ['img2_' num2str(image_index) '.bmp'];
    A2 = imread(imagename);

    imshow(A1,'Parent', handles.axes1);
    imshow(A2,'Parent', handles.axes6);
    [width height color] = size(A1);
    %     [width height color] = size(A2);

    % initialize the receive image
    B1 = uint8(255.*ones(width, height, color));
    B2 = uint8(255.*ones(width, height, color));

    %reset the residual error figure
    C1 = ones(width, height, color).*255;
    C2 = ones(width, height, color).*255;
%     imshow(C1,'Parent', handles.axes3);
%     imshow(C2,'Parent', handles.axes8);

    try
        for (j = 1:height/block_size)
            for (i = 1:width/block_size )

                if(strcmp(get(handles.text4,'String'),'Stopped'))
                    bRunning = 0;
                    break;
                end

                str_edit_block = sprintf ('%d/%d', height/block_size*(j-1)+i, width*height/block_size/block_size);
                set(handles.edit2,'String', str_edit_block);

                top1 = block_size*(i-1)+1;
                bottom1 = block_size*i;
                left1 = block_size*(j-1)+1;
                right1 = block_size*j;

                T1 = A1(left1:right1, top1:bottom1, :);
                T2 = A2(left1:right1, top1:bottom1, :);

                box = uint8(zeros(width, height, color));
              
                box(left1:left1+box_width , top1:bottom1, :) = 255;
                box(right1-box_width:right1 , top1:bottom1, :) = 255;
                box(left1:right1, top1:top1+box_width, :) = 255;
                box(left1:right1, bottom1-box_width:bottom1,:) = 255;

                A_box1 = A1 + box;
                A_box2 = A2 + box;

                imshow(A_box1,'Parent', handles.axes1);
                imshow(A_box2,'Parent', handles.axes6);

                B_box1 = B1;
                B_box2 = B2;
                
                B_box1(left1:left1+box_width , top1:bottom1, :) = 0;
                B_box1(right1-box_width:right1 , top1:bottom1, :) = 0;
                B_box1(left1:right1, top1:top1+box_width, :) = 0;
                B_box1(left1:right1, bottom1-box_width:bottom1,:) = 0;
                
                B_box2(left1:left1+box_width , top1:bottom1, :) = 0;
                B_box2(right1-box_width:right1 , top1:bottom1, :) = 0;
                B_box2(left1:right1, top1:top1+box_width, :) = 0;
                B_box2(left1:right1, bottom1-box_width:bottom1,:) = 0;
                
                imshow(B_box1,'Parent', handles.axes2);
                imshow(B_box2,'Parent', handles.axes7);               

                % channel emulator for user1
                T = double(T1);
                T = de2bi( T,'left-msb',8);
                T_stream = reshape(T', 1, 512);
                T_stream1 = [T_stream zeros(1, 64)];
                
                T2 = double(T2);
                T = de2bi( T2,'left-msb',8);
                T_stream = reshape(T', 1,512);
                T_stream2 = [T_stream zeros(1, 64)];
                
                % start transmit
                % TxGain1 and TxGain2 can be set by using the slides
                 [T_out1, T_out2] = demo_transmit4x2(T_stream1, T_stream2, TxGain1, TxGain2);

                % end transmit
                T_out = T_out1(1:512);
                T = reshape(T_out, 8,64);
                T = bi2de(T','left-msb');
                T = reshape(T, 8,8);
                T1= uint8(T);
                B1(block_size*(j-1)+1:block_size*j, block_size*(i-1)+1:block_size*i, :) = T1;
                % end channel emulator user1

                T_out = T_out2(1:512);
                T = reshape(T_out, 8,64);
                T = bi2de(T','left-msb');
                T = reshape(T, 8,8);
                T2= uint8(T);
                B2(block_size*(j-1)+1:block_size*j, block_size*(i-1)+1:block_size*i, :) = T2;
                % end channel emulator user2

%                 imshow(B1,'Parent', handles.axes2);
%                 imshow(B2,'Parent', handles.axes7);
            end
        end

        if(strcmp(get(handles.text4,'String'),'Transmitting'))
            imshow(B1,'Parent', handles.axes3);
            imshow(B2,'Parent', handles.axes8);
            
            R2 = 255^2*color;
            
            % calculate the PSNR for two images
            C1 = (B1-A1).^2;
            C2 = (B2-A2).^2;
            C1_float = double(C1);
            MSE1 = sum(sum(sum(C1_float)))/width/height;
            PSNR1 = 10*log10(R2/MSE1);
            
            C2_float = double(C2);
            MSE2 = sum(sum(sum(C2_float)))/width/height;
            PSNR2 = 10*log10(R2/MSE2);
            
            str_edit_psnr = sprintf ('%f',PSNR1);
            set(handles.edit3,'String', str_edit_psnr);
            str_edit_psnr = sprintf ('%f',PSNR2);
            set(handles.edit4,'String', str_edit_psnr);
        end
        
        if(strcmp(get(handles.text4,'String'),'Stopped'))
            bRunning = 0;
            break;
        end
    catch
        rethrow(lasterror);
    end

    imshow(A1,'Parent', handles.axes1);
    imshow(A2,'Parent', handles.axes6);
    imshow(B1,'Parent', handles.axes2);
    imshow(B2,'Parent', handles.axes7);
    set(handles.text6,'String','Transmission finished');
    pause(pic_delay);
end


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes on button press in pushbutton_load.
function pushbutton_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A1=imread('img1_0.bmp');
imshow(A1,'Parent', handles.axes1);

A2=imread('img2_0.bmp');
imshow(A2,'Parent', handles.axes6);


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editblock_Callback(hObject, eventdata, handles)
% hObject    handle to editblock (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editblock as text
%        str2double(get(hObject,'String')) returns contents of editblock as a double


% --- Executes during object creation, after setting all properties.
function editblock_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editblock (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text4,'String','Stopped');
set(handles.text6,'String','Stopped');


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global TxGain1;
TxGain1 = floor(get(hObject,'Value'));
set(handles.text19,'String',['TxGain1: ' num2str(TxGain1)]);


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
 set(hObject,'Min', 0);
 set(hObject, 'Max', 40);
 set(hObject, 'Value', 40 );


% --- Executes during object deletion, before destroying properties.
function slider1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global TxGain2;
TxGain2 = floor(get(hObject,'Value'));
set(handles.text20,'String',['TxGain2: ' num2str(TxGain2)]);

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
 set(hObject,'Min', 0);
 set(hObject, 'Max', 40);
 set(hObject, 'Value', 40 );
