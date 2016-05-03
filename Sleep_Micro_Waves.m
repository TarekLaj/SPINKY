function varargout = Sleep_Micro_Waves(varargin)
% SLEEP_MICRO_WAVES MATLAB code for Sleep_Micro_Waves.fig
%      SLEEP_MICRO_WAVES, by itself, creates a new SLEEP_MICRO_WAVES or raises the existing
%      singleton*.
%
%      H = SLEEP_MICRO_WAVES returns the handle to a new SLEEP_MICRO_WAVES or the handle to
%      the existing singleton*.
%
%      SLEEP_MICRO_WAVES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SLEEP_MICRO_WAVES.M with the given input arguments.
%
%      SLEEP_MICRO_WAVES('Property','Value',...) creates a new SLEEP_MICRO_WAVES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Sleep_Micro_Waves_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Sleep_Micro_Waves_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Sleep_Micro_Waves

% Last Modified by GUIDE v2.5 27-Apr-2016 15:48:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Sleep_Micro_Waves_OpeningFcn, ...
                   'gui_OutputFcn',  @Sleep_Micro_Waves_OutputFcn, ...
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


% --- Executes just before Sleep_Micro_Waves is made visible.
function Sleep_Micro_Waves_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Sleep_Micro_Waves (see VARARGIN)

% Choose default command line output for Sleep_Micro_Waves
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
addpath(genpath(pwd))


% UIWAIT makes Sleep_Micro_Waves wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Sleep_Micro_Waves_OutputFcn(hObject, eventdata, handles) 
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
