function varargout = spinky(varargin)
% SPINKY MATLAB code for SPINKY.fig
%      SPINKY, by itself, creates a new SPINKY or raises the existing
%      singleton*.
%
%      H = SPINKY returns the handle to a new SPINKY or the handle to
%      the existing singleton*.
%
%      SPINKY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPINKY.M with the given input arguments.
%
%      SPINKY('Property','Value',...) creates a new SPINKY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SPINKY_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SPINKY_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SPINKY

% Last Modified by GUIDE v2.5 29-Jul-2016 23:05:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @spinky_OpeningFcn, ...
                   'gui_OutputFcn',  @spinky_OutputFcn, ...
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


% --- Executes just before SPINKY is made visible.
function spinky_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SPINKY (see VARARGIN)

% Choose default command line output for SPINKY
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
imshow('logo.jpg', 'Parent', handles.axes1)

% UIWAIT makes SPINKY wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = spinky_OutputFcn(hObject, eventdata, handles) 
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
h_selectedRadioButton = get(handles.grp_bt,'SelectedObject');
mode = get(h_selectedRadioButton,'Tag');


switch mode % Get Tag of selected object.
    case 'visual_score'
        visual_scoring; delete(AutoDetection);delete(visual_correction);
    case 'auto_detect'
       AutoDetection;delete(visual_scoring);delete(visual_correction);
    case 'vs_correction'
        visual_correction;delete(visual_scoring);delete(AutoDetection);
   
end
