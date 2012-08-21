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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The MIMO LTE Uplink simulation based on Warplab
% Composed by: Guohui Wang
% Date: October 2009
% Configuration: GUI control
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Last Modified by GUIDE v2.5 13-Oct-2009 23:32:55

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

% bRunning is the flag that shows whether the program is running.
global bRunning;
bRunning = 1;
% set the total number of images to transmit.
number_of_image = 5;
% set the initial index of the images
image_index = -1;

while(bRunning)
    set(handles.text4,'String','Transmitting');
    set(handles.text6,'String','Transmitting');

    index=get(handles.popupmenu1,'Value');

    T = [];
    % sub-block size which is transmitted each time.
    block_size = 12;
    % the white block used to indicate the current transmitted subblock.
    box_width = 2;
    
    % load the image and display it.
    image_index = mod(image_index+1, number_of_image);
    imagename = ['img_user1_' num2str(image_index) '.bmp'];
    A = imread(imagename);
    imshow(A,'Parent', handles.axes1);
    [width height color] = size(A);
    
    % initialize the receive image
    B = uint8(255.*ones(width, height, color)); 

    %reset the residual error figure
    C = ones(width, height, color).*255;
    imshow(C,'Parent', handles.axes4);

    block_index = 0;
    MSE_total = 0;
    
    try
        for (j = 1:height/block_size)
            for (i = 1:width/block_size )
                
                % start the transmission
                if(strcmp(get(handles.text4,'String'),'Stopped'))
                    bRunning = 0;
                    break;
                end

                block_index = block_index + 1;
                str_edit_block = sprintf ('%d/%d', 252/block_size*(j-1)+i, 252*252/block_size/block_size);
                set(handles.edit2,'String', str_edit_block);
                
                % get the subblock data
                top1 = block_size*(i-1)+1;
                bottom1 = block_size*i;
                left1 = block_size*(j-1)+1;
                right1 = block_size*j;
                T_original = A(left1:right1, top1:bottom1, :);
                
                % draw the block frame in the transmitted image
                A_box = A;
                A_box(left1:left1+box_width , top1:bottom1, :) = 255;
                A_box(right1-box_width:right1 , top1:bottom1, :) = 255;
                A_box(left1:right1, top1:top1+box_width, :) = 255;
                A_box(left1:right1, bottom1-box_width:bottom1,:) = 255;
                imshow(A_box,'Parent', handles.axes1);

                % draw the block frame in the received image
                B_box = B;
                B_box(left1:left1+box_width , top1:bottom1, :) = 0;
                B_box(right1-box_width:right1 , top1:bottom1, :) = 0;
                B_box(left1:right1, top1:top1+box_width, :) = 0;
                B_box(left1:right1, bottom1-box_width:bottom1,:) = 0;
                imshow(B_box, 'parent', handles.axes2);

                % reshape the data block to a data stream
                T = double(T_original);
                T = de2bi( floor(T),'left-msb',8);
                T_stream = reshape(T', 1,1152);

                % transmit the data by the function 'demo_transmit_1user_mimo'
                T_out = demo_transmit_1user_mimo(T_stream);

                T = reshape(T_out, 8,144);
                T = bi2de(T','left-msb');
                T = reshape(T, 12,12);
                T= uint8(T);
                B(block_size*(j-1)+1:block_size*j, block_size*(i-1)+1:block_size*i, :) = T;

                % draw the residual image
                C_box = (T-T_original).^2;
                C(block_size*(j-1)+1:block_size*j, block_size*(i-1)+1:block_size*i, :) = C_box;
                imshow(C,'Parent', handles.axes4);
                
                MSE_box = sum(sum(sum(double(C_box))))/block_size/block_size;
                
                % calculate the PSNR of the image
                MSE_total = (MSE_box + MSE_total*(block_index-1))/block_index;
                R2 = 255^2*color;
                PSNR = 10*log10(R2/MSE_total);
                str_edit_psnr = sprintf ('%f',PSNR);
                set(handles.edit3,'String', str_edit_psnr);
            end
        end

        % during the transmission.
        if(strcmp(get(handles.text4,'String'),'Transmitting'))
            C = (B-A).^2;
            imshow(C,'Parent', handles.axes4);
            
            C_float = double(C);
            
            % calculate the PSNR of current received image
            MSE = sum(sum(sum(C_float)))/width/height;
            R2 = 255^2*color;
            PSNR = 10*log10(R2/MSE);
            str_edit_psnr = sprintf ('%f',PSNR);
            set(handles.edit3,'String', str_edit_psnr);
            
            % save the result image to local hard drive
            clock1 = clock;
            imageB_name = sprintf('demo_image_out_%4d%02d%02d%02d%02d.bmp', clock1(1), clock1(2), clock1(3), clock1(4), clock1(5));
            imwrite(B, imageB_name);
        end
        
        if(strcmp(get(handles.text4,'String'),'Stopped'))
            break;
        end
    catch
        rethrow(lasterror);
    end

    imshow(A,'Parent', handles.axes1);
    imshow(B, 'Parent', handles.axes2);
    set(handles.text6,'String','Transmission finished');
    pause(1.5);
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
A=imread('img_user1_0.bmp');
imshow(A,'Parent', handles.axes1);


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


% % --- Executes during object creation, after setting all properties.
% function text12_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to text12 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% % a=imread('arrow.jpg');
% % set(hObject,'CData',a) 


% --- Executes during object creation, after setting all properties.
function axes16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes16
a=imread('channel1.bmp');
imshow('channel1.bmp');

