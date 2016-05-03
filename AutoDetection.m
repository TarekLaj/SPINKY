function varargout = AutoDetection(varargin)
% AUTODETECTION MATLAB code for AutoDetection.fig
%      AUTODETECTION, by itself, creates a new AUTODETECTION or raises the existing
%      singleton*.
%
%      H = AUTODETECTION returns the handle to a new AUTODETECTION or the handle to
%      the existing singleton*.
%
%      AUTODETECTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AUTODETECTION.M with the given input arguments.
%
%      AUTODETECTION('Property','Value',...) creates a new AUTODETECTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AutoDetection_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AutoDetection_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AutoDetection

% Last Modified by GUIDE v2.5 27-Apr-2016 14:16:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AutoDetection_OpeningFcn, ...
                   'gui_OutputFcn',  @AutoDetection_OutputFcn, ...
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


% --- Executes just before AutoDetection is made visible.
function AutoDetection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AutoDetection (see VARARGIN)

% Choose default command line output for AutoDetection
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

setappdata(gcf,'valeur_de_n',1);

setappdata(gcf,'mode',0);
setappdata(gcf,'scalo_etat',1);
% UIWAIT makes AutoDetection wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AutoDetection_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function load_data_menu_Callback(hObject, eventdata, handles)
% hObject    handle to load_data_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=load(uigetfile('*.mat','select the M-file'));
X=fieldnames(data);
raw_data=data.(X{1});
%N=30000;fs=1000;
if size(raw_data,1)>1
prompt = {'Select channel index','Enter sampling frequency(Hz):', 'Enter segment length (sec):','Enter subject name:'};
title = 'Configuration';

answer = inputdlg(prompt, title);

elect=str2double(answer{1});
fs= str2double(answer{2});
subj_name= answer{3};
N=str2double(answer{3})*fs;
setappdata(gcf,'fs',fs);
setappdata(gcf,'N',N);
xdata=data_epoching(raw_data(elect,:),N);


else
prompt = {'Enter sampling frequency(Hz):', 'Enter segment length (sec):','Enter subject name'};
title = 'Configuration';
answer = inputdlg(prompt, title);
fs= str2double(answer{1});
N=str2double(answer{2})*fs;
subj_name= answer{3};

setappdata(gcf,'fs',fs);
setappdata(gcf,'N',N);
xdata=data_epoching(raw_data,N);

end


axes(handles.axes1);
set(handles.axes1,'visible','on');
cla(handles.axes1);
t=(0:N-1)/fs;
wn=[1 45];
n=getappdata(gcbf,'valeur_de_n');
yfilt=filter_fir(xdata{n},wn,80,fs);
plot(t,yfilt,'b');grid on;axis([0 N/fs -250 250]);
setappdata(gcf,'signal',xdata);

setappdata(gcf,'subj',subj_name);

set(handles.next_previous_panel,'visible','on');
% set(handles.goto_bt,'visible','on');
% set(handles.next_bt,'visible','on');
% set(handles.previous_bt,'visible','on');
% set(handles.nseg,'visible','on');
% set(handles.nseg_text,'visible','on');
set(handles.nseg,'string',int2str(n));

 set(handles.auto_panel,'visible','on','position',[0.8175750834260289 0.6543209876543209 0.17741935483870974 0.279835390946502]);
set(handles.detection_mode,'visible','on');
set(handles.scalo_bt,'visible','on');

% --------------------------------------------------------------------
function exit_menu_Callback(hObject, eventdata, handles)
% hObject    handle to exit_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in detection_mode.
function detection_mode_Callback(hObject, eventdata, handles)
% hObject    handle to detection_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns detection_mode contents as cell array
%        contents{get(hObject,'Value')} returns selected item from detection_mode
val=get(handles.detection_mode,'Value'); %automatic detection modes
set(handles.spindle_chbx,'Value',0);
set(handles.kcomplex_chbx,'Value',0);
switch val
    case 2 %compute thresholds
        set(handles.spindle_chbx,'visible','on');
        set(handles.kcomplex_chbx,'visible','on');
%       set(handles.path_edit,'visible','on');
        set(handles.event_select,'visible','on');
       
        setappdata(gcf,'mode',1);
        set(handles.thr_kp,'visible','off');
        set(handles.thr_sp,'visible','off');
        set(handles.run_bt,'visible','off');        set(handles.cancel_bt,'visible','off');

        set(handles.auto_panel,'position',[0.8175750834260289 0.6543209876543209 0.17741935483870974 0.279835390946502]);
        
    case 3 %thresholds computed 
        
        set(handles.data_path,'visible','off');
        set(handles.data_browse,'visible','off');
        
        set(handles.sp_browse,'visible','off');
        set(handles.kp_browse,'visible','off');
       
        set(handles.sp_path,'visible','off');
        set(handles.kp_path,'visible','off');
       
        set(handles.loading_tr_data,'visible','off','position',[0.8203559510567296 0.44855967078189296 0.17352614015572854 0.18106995884773658]);
        
        set(handles.spindle_chbx,'visible','on');
        set(handles.kcomplex_chbx,'visible','on');
        
        set(handles.thr_kp,'visible','on');
        set(handles.thr_sp,'visible','on');
        
        set(handles.event_select,'visible','on');
       
        setappdata(gcf,'mode',2);
        set(handles.run_bt,'visible','on','Units','normalized','position',[0.957174638487208 0.5871056241426611 0.03170189098998888 0.0384087791495199]);
        set(handles.cancel_bt,'visible','on','Units','normalized','position',[0.9226918798665183 0.5871056241426611 0.03170189098998888 0.0384087791495199]);
        set(handles.auto_panel,'position',[0.8175750834260289 0.6543209876543209 0.17741935483870974 0.279835390946502]);
    
    otherwise
    errordlg('Please select detection mode','Selection error');
    
end
% --- Executes during object creation, after setting all properties.
function detection_mode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to detection_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mode=getappdata(gcbf,'mode');
xdata=getappdata(gcbf,'signal');
n=str2double(get(handles.nseg,'string'));

set(handles.nseg,'string',num2str(n))
fs=getappdata(gcbf,'fs');
N=getappdata(gcbf,'N');
axes(handles.axes1);
cla;
wn=[1 45];
t=(0:N-1)/fs;
yfilt=filtrage_fir(xdata{n},wn,80,fs);
plot(t,yfilt);grid on;axis([0 N/fs -250 250]);
setappdata(gcf,'valeur_de_n',n);
sp_selected=getappdata(gcbf,'sp_detection'); %spindles detection avctivated =1 
kp_selected=getappdata(gcbf,'kp_detection'); %kcomplex detection activated =1

sp_select=get(handles.axes3,'visible'); %spindles detection avctivated
kp_select=get(handles.axes2,'visible'); %kcomplex detection activated


pos_sp=getappdata(gcbf,'pos_sp'); 
pos_kp=getappdata(gcbf,'pos_kp'); 
nbr_sp=getappdata(gcbf,'nbr_sp'); 
nbr_kp=getappdata(gcbf,'nbr_kp'); 
scalo_mode=getappdata(gcbf,'scalo_etat');

 if scalo_mode==0
                
                axes(handles.axes4);cla;
                set(handles.axes4,'visible','off');
                set(handles.scalo_bt,'String','Show scalogram');
                setappdata(gcf,'scalo_etat',1);
end
            
if strcmp(sp_select,'on') && strcmp(kp_select,'off') 
           
            set(handles.next_previous_panel,'Units','normalized','position',[0.3275862068965517 0.3635116598079561 0.19521690767519473 0.07407407407407407]);
            set(handles.spindles_text,'visible','on','units','normalized','Position',[0.027808676307007785 0.5679012345679012 0.04338153503893215 0.023319615912208547]);
            
            set(handles.sp_edit,'visible','on','Units','normalized','position',[ 0.09343715239154617 0.5596707818930041 0.01835372636262514 0.0384087791495199]);
           
            set(handles.sp_edit,'string',num2str(nbr_sp(n)));
           
            axes(handles.axes2); 
            set(handles.axes2,'visible','off');cla;
            
            axes(handles.axes3); 
            set(handles.axes3,'visible','on','units','normalized','Position',[0.02725250278086763 0.4622770919067215 0.778642936596218 0.09190672153635115]);cla;
            imagesc(pos_sp{n});colormap(parula);freezeColors;set(gca, 'XTick', []);set(gca, 'YTick', []);set(gca,'color',[0.200000002980232 0 0.600000023841858]);
           
           
    elseif strcmp(sp_select,'off') && strcmp(kp_select,'on')  
            
            set(handles.next_previous_panel,'Units','normalized','position',[0.3275862068965517 0.3635116598079561 0.19521690767519473 0.07407407407407407]);
            
            set(handles.kp_edit,'visible','on');
           
            set(handles.kp_edit,'string',num2str(nbr_kp(n)));
            set(handles.komplex_text,'visible','on','units','normalized','position',[0.027808676307007785 0.5679012345679012 0.04338153503893215 0.023319615912208547]);
            
            axes(handles.axes2);
            set(handles.axes2,'visible','on','units','normalized','position',[0.02725250278086763 0.4622770919067215 0.778642936596218 0.09190672153635115]);
            cla;
            jj=0.5*ones(1,N);
            plot(pos_kp{n},jj(pos_kp{n}*fs),'k^','markerfacecolor','y','markersize',13);axis([0 30 0 1]);set(gca, 'XTick', []);set(gca, 'YTick', []);set(gca,'color',[0.200000002980232 0 0.600000023841858]);
           
    elseif  strcmp(sp_select,'on') && strcmp(kp_select,'on') 
        
            set(handles.next_previous_panel,'Units','normalized','Position',[0.3325917686318131 0.19753086419753085 0.19521690767519467 0.07407407407407407] );
           
            set(handles.kp_edit,'visible','on','units','normalized','position',[0.09343715239154617 0.5596707818930041 0.01835372636262514 0.0384087791495199]);
     
            set(handles.kp_edit,'string',num2str(nbr_kp(n)));
            set(handles.komplex_text,'visible','on','units','normalized','position',[0.027808676307007785 0.5679012345679012 0.04338153503893215 0.023319615912208547]);

            axes(handles.axes2);
            set(handles.axes2,'visible','on','units','normalized','position',[0.02725250278086763 0.4622770919067215 0.778642936596218 0.09190672153635115]);
            cla;
            jj=0.5*ones(1,N);
            plot(pos_kp{n},jj(pos_kp{n}*fs),'k^','markerfacecolor','y','markersize',13);axis([0 30 0 1]);set(gca, 'XTick', []);set(gca, 'YTick', []);set(gca,'color',[0.200000002980232 0 0.600000023841858]);
            
            set(handles.spindles_text,'visible','on','units','normalized','position',[0.02836484983314794 0.41700960219478733 0.041156840934371525 0.02331961591220849]);
            
            set(handles.sp_edit,'visible','on','units','normalized','position',[0.09121245828698554 0.4115226337448559 0.01835372636262514 0.0384087791495199]);
            set(handles.sp_edit,'string',num2str(nbr_sp(n)));
            
            axes(handles.axes3); 
           
            set(handles.axes3,'visible','on','units','normalized','position',[0.026696329254727473 0.3100137174211248 0.7791991101223582 0.09190672153635115]);cla;
            imagesc(pos_sp{n});colormap(parula);freezeColors;set(gca, 'XTick', []);set(gca, 'YTick', []);set(gca,'color',[0.200000002980232 0 0.600000023841858]);
          
         
    
    elseif strcmp(sp_select,'off') && strcmp(kp_select,'off') 
     set(handles.next_previous_panel,'position',[0.3275862068965517 0.5102880658436214 0.19521690767519473 0.07407407407407407]);
           
    
end


function nseg_Callback(hObject, eventdata, handles)
% hObject    handle to nseg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nseg as text
%        str2double(get(hObject,'String')) returns contents of nseg as a double


% --- Executes during object creation, after setting all properties.
function nseg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nseg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mode=getappdata(gcbf,'mode');
xdata=getappdata(gcbf,'signal');
n=str2double(get(handles.nseg,'string'));
n=n-1;
set(handles.nseg,'string',num2str(n))
fs=getappdata(gcbf,'fs');
N=getappdata(gcbf,'N');
axes(handles.axes1);
cla;
wn=[1 45];
t=(0:N-1)/fs;
yfilt=filtrage_fir(xdata{n},wn,80,fs);
plot(t,yfilt);grid on;axis([0 N/fs -250 250]);
setappdata(gcf,'valeur_de_n',n);
sp_selected=getappdata(gcbf,'sp_detection'); %spindles detection avctivated =1 
kp_selected=getappdata(gcbf,'kp_detection'); %kcomplex detection activated =1

sp_select=get(handles.axes3,'visible'); %spindles detection avctivated
kp_select=get(handles.axes2,'visible'); %kcomplex detection activated


pos_sp=getappdata(gcbf,'pos_sp'); 
pos_kp=getappdata(gcbf,'pos_kp'); 
nbr_sp=getappdata(gcbf,'nbr_sp'); 
nbr_kp=getappdata(gcbf,'nbr_kp'); 
scalo_mode=getappdata(gcbf,'scalo_etat');

 if scalo_mode==0
                
                axes(handles.axes4);cla;
                set(handles.axes4,'visible','off');
                set(handles.scalo_bt,'String','Show scalogram');
                setappdata(gcf,'scalo_etat',1);
end
            
if strcmp(sp_select,'on') && strcmp(kp_select,'off') 
           
            set(handles.next_previous_panel,'Units','normalized','position',[0.3275862068965517 0.3635116598079561 0.19521690767519473 0.07407407407407407]);
            set(handles.spindles_text,'visible','on','units','normalized','Position',[0.027808676307007785 0.5679012345679012 0.04338153503893215 0.023319615912208547]);
            
            set(handles.sp_edit,'visible','on','Units','normalized','position',[ 0.09343715239154617 0.5596707818930041 0.01835372636262514 0.0384087791495199]);
           
            set(handles.sp_edit,'string',num2str(nbr_sp(n)));
           
            axes(handles.axes2); 
            set(handles.axes2,'visible','off');cla;
            
            axes(handles.axes3); 
            set(handles.axes3,'visible','on','units','normalized','Position',[0.02725250278086763 0.4622770919067215 0.778642936596218 0.09190672153635115]);cla;
            imagesc(pos_sp{n});colormap(parula);freezeColors;set(gca, 'XTick', []);set(gca, 'YTick', []);set(gca,'color',[0.200000002980232 0 0.600000023841858]);
           
           
    elseif strcmp(sp_select,'off') && strcmp(kp_select,'on')  
            
            set(handles.next_previous_panel,'Units','normalized','position',[0.3275862068965517 0.3635116598079561 0.19521690767519473 0.07407407407407407]);
            
            set(handles.kp_edit,'visible','on');
           
            set(handles.kp_edit,'string',num2str(nbr_kp(n)));
            set(handles.komplex_text,'visible','on','units','normalized','position',[0.027808676307007785 0.5679012345679012 0.04338153503893215 0.023319615912208547]);
            
            axes(handles.axes2);
            set(handles.axes2,'visible','on','units','normalized','position',[0.02725250278086763 0.4622770919067215 0.778642936596218 0.09190672153635115]);
            cla;
            jj=0.5*ones(1,N);
            plot(pos_kp{n},jj(pos_kp{n}*fs),'k^','markerfacecolor','y','markersize',13);axis([0 30 0 1]);set(gca, 'XTick', []);set(gca, 'YTick', []);set(gca,'color',[0.200000002980232 0 0.600000023841858]);
           
    elseif  strcmp(sp_select,'on') && strcmp(kp_select,'on') 
        
            set(handles.next_previous_panel,'Units','normalized','Position',[0.3325917686318131 0.19753086419753085 0.19521690767519467 0.07407407407407407] );
           
            set(handles.kp_edit,'visible','on','units','normalized','position',[0.09343715239154617 0.5596707818930041 0.01835372636262514 0.0384087791495199]);
     
            set(handles.kp_edit,'string',num2str(nbr_kp(n)));
            set(handles.komplex_text,'visible','on','units','normalized','position',[0.027808676307007785 0.5679012345679012 0.04338153503893215 0.023319615912208547]);

            axes(handles.axes2);
            set(handles.axes2,'visible','on','units','normalized','position',[0.02725250278086763 0.4622770919067215 0.778642936596218 0.09190672153635115]);
            cla;
            jj=0.5*ones(1,N);
            plot(pos_kp{n},jj(pos_kp{n}*fs),'k^','markerfacecolor','y','markersize',13);axis([0 30 0 1]);set(gca, 'XTick', []);set(gca, 'YTick', []);set(gca,'color',[0.200000002980232 0 0.600000023841858]);
            
            set(handles.spindles_text,'visible','on','units','normalized','position',[0.02836484983314794 0.41700960219478733 0.041156840934371525 0.02331961591220849]);
            
            set(handles.sp_edit,'visible','on','units','normalized','position',[0.09121245828698554 0.4115226337448559 0.01835372636262514 0.0384087791495199]);
            set(handles.sp_edit,'string',num2str(nbr_sp(n)));
            
            axes(handles.axes3); 
           
            set(handles.axes3,'visible','on','units','normalized','position',[0.026696329254727473 0.3100137174211248 0.7791991101223582 0.09190672153635115]);cla;
            imagesc(pos_sp{n});colormap(parula);freezeColors;set(gca, 'XTick', []);set(gca, 'YTick', []);set(gca,'color',[0.200000002980232 0 0.600000023841858]);
          
         
    
    elseif strcmp(sp_select,'off') && strcmp(kp_select,'off') 
     set(handles.next_previous_panel,'position',[0.3275862068965517 0.5102880658436214 0.19521690767519473 0.07407407407407407]);
           
    
end

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mode=getappdata(gcbf,'mode');
xdata=getappdata(gcbf,'signal');
n=str2double(get(handles.nseg,'string'));
n=n+1;
set(handles.nseg,'string',num2str(n))
fs=getappdata(gcbf,'fs');
N=getappdata(gcbf,'N');
axes(handles.axes1);
cla;
wn=[1 45];
t=(0:N-1)/fs;
yfilt=filtrage_fir(xdata{n},wn,80,fs);
plot(t,yfilt);grid on;axis([0 N/fs -250 250]);
setappdata(gcf,'valeur_de_n',n);
sp_selected=getappdata(gcbf,'sp_detection'); %spindles detection avctivated =1 
kp_selected=getappdata(gcbf,'kp_detection'); %kcomplex detection activated =1

sp_select=get(handles.axes3,'visible'); %spindles detection avctivated
kp_select=get(handles.axes2,'visible'); %kcomplex detection activated


pos_sp=getappdata(gcbf,'pos_sp'); 
pos_kp=getappdata(gcbf,'pos_kp'); 
nbr_sp=getappdata(gcbf,'nbr_sp'); 
nbr_kp=getappdata(gcbf,'nbr_kp'); 
scalo_mode=getappdata(gcbf,'scalo_etat');

 if scalo_mode==0
                
                axes(handles.axes4);cla;
                set(handles.axes4,'visible','off');
                set(handles.scalo_bt,'String','Show scalogram');
                setappdata(gcf,'scalo_etat',1);
end
            
if strcmp(sp_select,'on') && strcmp(kp_select,'off') 
           
            set(handles.next_previous_panel,'Units','normalized','position',[0.3275862068965517 0.3635116598079561 0.19521690767519473 0.07407407407407407]);
            set(handles.spindles_text,'visible','on','units','normalized','Position',[0.027808676307007785 0.5679012345679012 0.04338153503893215 0.023319615912208547]);
            
            set(handles.sp_edit,'visible','on','Units','normalized','position',[ 0.09343715239154617 0.5596707818930041 0.01835372636262514 0.0384087791495199]);
           
            set(handles.sp_edit,'string',num2str(nbr_sp(n)));
           
            axes(handles.axes2); 
            set(handles.axes2,'visible','off');cla;
            
            axes(handles.axes3); 
            set(handles.axes3,'visible','on','units','normalized','Position',[0.02725250278086763 0.4622770919067215 0.778642936596218 0.09190672153635115]);cla;
            imagesc(pos_sp{n});colormap(parula);freezeColors;set(gca, 'XTick', []);set(gca, 'YTick', []);set(gca,'color',[0.200000002980232 0 0.600000023841858]);
           
           
    elseif strcmp(sp_select,'off') && strcmp(kp_select,'on')  
            
            set(handles.next_previous_panel,'Units','normalized','position',[0.3275862068965517 0.3635116598079561 0.19521690767519473 0.07407407407407407]);
            
            set(handles.kp_edit,'visible','on');
           
            set(handles.kp_edit,'string',num2str(nbr_kp(n)));
            set(handles.komplex_text,'visible','on','units','normalized','position',[0.027808676307007785 0.5679012345679012 0.04338153503893215 0.023319615912208547]);
            
            axes(handles.axes2);
            set(handles.axes2,'visible','on','units','normalized','position',[0.02725250278086763 0.4622770919067215 0.778642936596218 0.09190672153635115]);
            cla;
            jj=0.5*ones(1,N);
            plot(pos_kp{n},jj(pos_kp{n}*fs),'k^','markerfacecolor','y','markersize',13);axis([0 30 0 1]);set(gca, 'XTick', []);set(gca, 'YTick', []);set(gca,'color',[0.200000002980232 0 0.600000023841858]);
           
    elseif  strcmp(sp_select,'on') && strcmp(kp_select,'on') 
        
            set(handles.next_previous_panel,'Units','normalized','Position',[0.3325917686318131 0.19753086419753085 0.19521690767519467 0.07407407407407407] );
           
            set(handles.kp_edit,'visible','on','units','normalized','position',[0.09343715239154617 0.5596707818930041 0.01835372636262514 0.0384087791495199]);
     
            set(handles.kp_edit,'string',num2str(nbr_kp(n)));
            set(handles.komplex_text,'visible','on','units','normalized','position',[0.027808676307007785 0.5679012345679012 0.04338153503893215 0.023319615912208547]);

            axes(handles.axes2);
            set(handles.axes2,'visible','on','units','normalized','position',[0.02725250278086763 0.4622770919067215 0.778642936596218 0.09190672153635115]);
            cla;
            jj=0.5*ones(1,N);
            plot(pos_kp{n},jj(pos_kp{n}*fs),'k^','markerfacecolor','y','markersize',13);axis([0 30 0 1]);set(gca, 'XTick', []);set(gca, 'YTick', []);set(gca,'color',[0.200000002980232 0 0.600000023841858]);
            
            set(handles.spindles_text,'visible','on','units','normalized','position',[0.02836484983314794 0.41700960219478733 0.041156840934371525 0.02331961591220849]);
            
            set(handles.sp_edit,'visible','on','units','normalized','position',[0.09121245828698554 0.4115226337448559 0.01835372636262514 0.0384087791495199]);
            set(handles.sp_edit,'string',num2str(nbr_sp(n)));
            
            axes(handles.axes3); 
           
            set(handles.axes3,'visible','on','units','normalized','position',[0.026696329254727473 0.3100137174211248 0.7791991101223582 0.09190672153635115]);cla;
            imagesc(pos_sp{n});colormap(parula);freezeColors;set(gca, 'XTick', []);set(gca, 'YTick', []);set(gca,'color',[0.200000002980232 0 0.600000023841858]);
          
         
    
    elseif strcmp(sp_select,'off') && strcmp(kp_select,'off') 
     set(handles.next_previous_panel,'position',[0.3275862068965517 0.5102880658436214 0.19521690767519473 0.07407407407407407]);
           
    
end


% --- Executes on button press in scalo_bt.
function scalo_bt_Callback(hObject, eventdata, handles)
% hObject    handle to scalo_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x=getappdata(gcbf,'signal');
n=getappdata(gcbf,'valeur_de_n');
fs=getappdata(gcbf,'fs'); N=getappdata(gcbf,'N');
scalo=getappdata(gcbf,'scalo_etat');

sp_select=get(handles.axes3,'visible'); %spindles detection avctivated
kp_select=get(handles.axes2,'visible'); %kcomplex detection activated

if scalo==1
     setappdata(gcf,'scalo_etat',0);  set(handles.scalo_bt,'String','Hide scalogram');  
     set(handles.axes4,'visible','on');
     axes(handles.axes4);cla;

    t=(0:N-1)/fs;
    sc=1./((10.5:0.15:16.5)/fs); %selon AASM sleep spindles dans la bande [11 16]
    wname='fbsp 20-0.5-1';  %;% 'cmor2-1.114''shan 0.5-1'
    W=cwt(x{n},sc,wname);

    freq= scal2frq(sc,wname,1/fs);
            % wscalogram('image',W,'scales',freq);colormap(jet)
    imagesc(t,freq,abs(W));colormap(jet);freezeColors; set(gca, 'XTick', []);  

    if strcmp(sp_select,'off') && strcmp(kp_select,'off')
        set(handles.next_previous_panel,'position',[0.3275862068965517 0.37585733882030176 0.19521690767519473 0.07407407407407407]);

        elseif strcmp(sp_select,'on') && strcmp(kp_select,'off')
            
            set(handles.next_previous_panel,'position',[0.3275862068965517 0.1755829903978052 0.19521690767519473 0.07407407407407407]);
            set(handles.axes3,'position',[0.02725250278086763 0.30315500685871055 0.778642936596218 0.09190672153635115]);
            set(handles.sp_edit,'position',[0.09343715239154617 0.4005486968449931 0.01835372636262514 0.0384087791495199]);
            set(handles.spindles_text,'position',[0.027808676307007785 0.40877914951989025 0.04338153503893215 0.023319615912208547]);
            
           
        elseif strcmp(sp_select,'off') && strcmp(kp_select,'on')
            
            set(handles.next_previous_panel,'position',[0.3275862068965517 0.1755829903978052 0.19521690767519473 0.07407407407407407]);
            set(handles.axes2,'position',[0.02725250278086763 0.30315500685871055 0.778642936596218 0.09190672153635115]);
            set(handles.kp_edit,'position',[0.09343715239154617 0.4005486968449931 0.01835372636262514 0.0384087791495199]);
            set(handles.komplex_text,'position',[0.027808676307007785 0.40877914951989025 0.04338153503893215 0.023319615912208547]);

        elseif strcmp(sp_select,'on') && strcmp(kp_select,'on')   
           
            set(handles.next_previous_panel,'position',[0.3325917686318131 0.050754458161865565  0.19521690767519467 0.07407407407407407]);
           
            set(handles.axes3,'position',[0.026696329254727473 0.15089163237311384 0.7791991101223582 0.09190672153635115]);
            set(handles.sp_edit,'position',[0.09121245828698554 0.252400548696845 0.01835372636262514 0.0384087791495199]);
            set(handles.spindles_text,'position',[0.02836484983314794 0.2578875171467764 0.041156840934371525 0.02331961591220849]);
            
            set(handles.axes2,'position',[0.02725250278086763 0.30315500685871055 0.778642936596218 0.09190672153635115]);
            set(handles.komplex_text,'position',[0.027808676307007785 0.40877914951989025 0.04338153503893215 0.02331961591220849]);
            set(handles.kp_edit,'position',[0.09343715239154617 0.4005486968449931 0.01835372636262514 0.0384087791495199]);
    end
else
    
     axes(handles.axes4);cla;
     set(handles.axes4,'visible','off');
     set(handles.scalo_bt,'String','Show scalogram');  setappdata(gcf,'scalo_etat',1); 
      if strcmp(sp_select,'off') && strcmp(kp_select,'off')
          
          set(handles.next_previous_panel,'position',[0.3275862068965517 0.5102880658436214 0.19521690767519473 0.07407407407407407]);
      
      elseif strcmp(sp_select,'on') && strcmp(kp_select,'off')
            
            set(handles.next_previous_panel,'position',[0.3275862068965517 0.3635116598079561 0.19521690767519473 0.07407407407407407]);
            set(handles.axes3,'position',[0.02725250278086763 0.4622770919067215 0.778642936596218 0.09190672153635115]);
            set(handles.sp_edit,'position',[0.09343715239154617 0.5596707818930041 0.01835372636262514 0.0384087791495199]);
            set(handles.spindles_text,'position',[0.027808676307007785 0.5679012345679012 0.04338153503893215 0.023319615912208547]);
            
           
        elseif strcmp(sp_select,'off') && strcmp(kp_select,'on')
            
            set(handles.next_previous_panel,'position',[0.3275862068965517 0.3635116598079561 0.19521690767519473 0.07407407407407407]);
            set(handles.axes2,'position',[0.02725250278086763 0.4622770919067215 0.778642936596218 0.09190672153635115]);
            set(handles.kp_edit,'position',[0.09343715239154617 0.5596707818930041 0.01835372636262514 0.0384087791495199]);
            set(handles.komplex_text,'position',[0.027808676307007785 0.5679012345679012 0.04338153503893215 0.023319615912208547]);

        elseif strcmp(sp_select,'on') && strcmp(kp_select,'on')   
           
            set(handles.next_previous_panel,'position',[0.3325917686318131 0.19753086419753085 0.19521690767519467 0.07407407407407407]);
           
            set(handles.axes3,'position',[0.026696329254727473 0.3100137174211248 0.7791991101223582 0.09190672153635115]);
            set(handles.sp_edit,'position',[0.09121245828698554 0.4115226337448559 0.01835372636262514 0.0384087791495199]);
            set(handles.spindles_text,'position',[0.02836484983314794 0.41700960219478733 0.041156840934371525 0.02331961591220849]);
            
            set(handles.axes2,'position',[0.02725250278086763 0.4622770919067215 0.778642936596218 0.09190672153635115]);
            set(handles.komplex_text,'position',[0.027808676307007785 0.5679012345679012 0.04338153503893215 0.023319615912208547]);
            set(handles.kp_edit,'position',[0.09343715239154617 0.5596707818930041 0.01835372636262514 0.0384087791495199]);
          
      end
     
end

% --- Executes on button press in checkbox9.
function checkbox9_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox9


% --- Executes on button press in checkbox10.
function checkbox10_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox10



function data_path_Callback(hObject, eventdata, handles)
% hObject    handle to data_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data_path as text
%        str2double(get(hObject,'String')) returns contents of data_path as a double


% --- Executes during object creation, after setting all properties.
function data_path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sp_path_Callback(hObject, eventdata, handles)
% hObject    handle to sp_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sp_path as text
%        str2double(get(hObject,'String')) returns contents of sp_path as a double


% --- Executes during object creation, after setting all properties.
function sp_path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sp_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in detection_mode.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to detection_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns detection_mode contents as cell array
%        contents{get(hObject,'Value')} returns selected item from detection_mode


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to detection_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function kp_path_Callback(hObject, eventdata, handles)
% hObject    handle to kp_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kp_path as text
%        str2double(get(hObject,'String')) returns contents of kp_path as a double


% --- Executes during object creation, after setting all properties.
function kp_path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kp_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in data_browse.
function data_browse_Callback(hObject, eventdata, handles)
% hObject    handle to data_browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
N=getappdata(gcbf,'N');
[filename,path]=uigetfile('*.mat','select the M-file');

train_data=load(filename);
X=fieldnames(train_data);
data=train_data.(X{1});
training_seg=data_epoching(data,N);
set(handles.data_path,'string',path);
setappdata(gcf,'tr_data',training_seg);

% --- Executes on button press in kp_browse.
function kp_browse_Callback(hObject, eventdata, handles)
% hObject    handle to kp_browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename,path]=uigetfile('*.txt','select the M-file');
train_data=load(filename);

kp=train_data(:,1);
tr=getappdata(gcbf,'tr_data');
kp_score=zeros(1,length(tr));


[uV,aa] = unique(kp(:,1));
 
[~,iV] = sort(aa);
 
nV = histc(kp(:,1),uV);
 
kp_score(uV(iV))=nV(iV);


set(handles.kp_path,'string',path);
setappdata(gcf,'tr_sc_kp',kp_score);

% --- Executes on button press in sp_browse.
function sp_browse_Callback(hObject, eventdata, handles)
% hObject    handle to sp_browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename,path]=uigetfile('*.txt','select the M-file');
train_data=load(filename);

sp=train_data(:,1);
tr=getappdata(gcbf,'tr_data');
sp_score=zeros(1,length(tr));


[uV,aa] = unique(sp(:,1));
 
[~,iV] = sort(aa);
 
nV = histc(sp(:,1),uV);
 
sp_score(uV(iV))=nV(iV);


set(handles.sp_path,'string',path);
setappdata(gcf,'tr_sc_sp',sp_score);

% --- Executes on button press in run_bt.
function run_bt_Callback(hObject, eventdata, handles)
% hObject    handle to run_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mode=getappdata(gcbf,'mode');
fs=getappdata(gcbf,'fs');
N=getappdata(gcbf,'N');
%n=getappdata(gcbf,'valeur_de_n');
n=str2double(get(handles.nseg,'string'));
sp_selected=getappdata(gcbf,'sp_detection'); %spindles detection avctivated
kp_selected=getappdata(gcbf,'kp_detection'); %kcomplex detection activated
sig_train=getappdata(gcbf,'tr_data');
%assignin('base', 'var', sig)
subj_name=getappdata(gcbf,'subj');
xdata=getappdata(gcbf,'signal');scalo=getappdata(gcbf,'scalo_etat');


switch mode
    case 1 %compute thresholds
        if sp_selected==1 && kp_selected==0  %find spindles threshold
            
            sp_expert_score=getappdata(gcbf,'tr_sc_sp'); 
            [sp_thresh] =sp_thresholds_ranges(sig_train,fs);
            [op_thr_sp] = training_process(sig_train,fs,'spindles',sp_thresh,sp_expert_score,'On');
            
            set(handles.thr_sp,'visible','on');
            set(handles.thr_sp,'string',int2str(op_thr_sp));
            
            [nbr_sp,pos_sp]=test_process(xdata,fs,subj_name,'spindles',op_thr_sp);
          
            if scalo==0
             
                kp_axes=[0.02725250278086763 0.30315500685871055 0.778642936596218 0.09190672153635115];
                next_pos=[0.3275862068965517 0.1755829903978052 0.19521690767519473 0.07407407407407407];
                text_pos=[0.027808676307007785 0.40877914951989025 0.04338153503893215 0.023319615912208547];
                edit_pos=[0.09343715239154617 0.4005486968449931 0.01835372636262514 0.0384087791495199];
            else
                kp_axes=[0.02725250278086763 0.4622770919067215 0.778642936596218 0.09190672153635115];
                next_pos=[0.3275862068965517 0.3635116598079561 0.19521690767519473 0.07407407407407407];
                text_pos=[0.027808676307007785 0.5679012345679012 0.04338153503893215 0.023319615912208547];
                edit_pos=[0.09343715239154617 0.5596707818930041 0.01835372636262514 0.0384087791495199];
            end
            
            set(handles.next_previous_panel,'Units','normalized','position',next_pos);
            set(handles.spindles_text,'visible','on','units','normalized','Position',text_pos);
            
            
            set(handles.sp_edit,'visible','on','Units','normalized','position',edit_pos);
            set(handles.sp_edit,'string',num2str(nbr_sp(n)));
            
            axes(handles.axes2); 
            set(handles.axes2,'visible','off');cla;
            
            axes(handles.axes3); 
            set(handles.axes3,'visible','on','units','normalized','Position',kp_axes);cla;
            imagesc(pos_sp{n});colormap(parula);set(gca, 'XTick', []);set(gca, 'YTick', []);set(gca,'color',[0.200000002980232 0 0.600000023841858]);freezeColors
            setappdata(gcf,'pos_sp',pos_sp);
            setappdata(gcf,'nbr_sp',nbr_sp);
            
            
        elseif  sp_selected==0 && kp_selected==1 %find kcomplex threshold 
            
            

            kp_expert_score=getappdata(gcbf,'tr_sc_kp');
            [kp_thresh] =kp_thresholds_ranges(sig_train);
            [op_thr_kp] = training_process(sig_train,fs,'kcomplex',kp_thresh,kp_expert_score,'On');
            
             set(handles.thr_kp,'visible','on');
            set(handles.thr_kp,'string',int2str(op_thr_kp));
         
            [nbr_kc,pos_kc]=test_process(xdata,fs,subj_name,'kcomplex',op_thr_kp);
            
             if scalo==0
              
                kp_axes=[0.02725250278086763 0.30315500685871055 0.778642936596218 0.09190672153635115];
                next_pos=[0.3275862068965517 0.1755829903978052 0.19521690767519473 0.07407407407407407];
                text_pos=[0.027808676307007785 0.40877914951989025 0.04338153503893215 0.023319615912208547];
                edit_pos=[0.09343715239154617 0.4005486968449931 0.01835372636262514 0.0384087791495199];
            else
                kp_axes=[0.02725250278086763 0.4622770919067215 0.778642936596218 0.09190672153635115];
                next_pos=[0.3275862068965517 0.3635116598079561 0.19521690767519473 0.07407407407407407];
                text_pos=[0.027808676307007785 0.5679012345679012 0.04338153503893215 0.023319615912208547];
                edit_pos=[0.09343715239154617 0.5596707818930041 0.01835372636262514 0.0384087791495199];
            end
            
            
            
            set(handles.next_previous_panel,'Units','normalized','position',next_pos);
            
            
            set(handles.kp_edit,'visible','on','position',edit_pos);
            set(handles.kp_edit,'string',num2str(nbr_kc(n)));
            
            set(handles.komplex_text,'visible','on','units','normalized','position',text_pos);
           
           axes(handles.axes3); 
            set(handles.axes3,'visible','off');cla;
            
            axes(handles.axes2);
            set(handles.axes2,'visible','on','units','normalized','position',kp_axes);
            cla;
            jj=0.5*ones(1,N);
            plot(pos_kc{n},jj(pos_kc{n}*fs),'k^','markerfacecolor','y','markersize',13);axis([0 30 0 1]);set(gca, 'XTick', []);set(gca, 'YTick', []);set(gca,'color',[0.200000002980232 0 0.600000023841858]);
            setappdata(gcf,'pos_kp',pos_kc);           
            setappdata(gcf,'nbr_kp',nbr_kc);
                
           
        elseif sp_selected==1 && kp_selected==1 %find spindles & kcomplex thresholds
             
           
            
            sp_expert_score=getappdata(gcbf,'tr_sc_sp');
            [sp_thresh] =sp_thresholds_ranges(sig_train,fs);
            kp_expert_score=getappdata(gcbf,'tr_sc_kp');
            [kp_thresh] =kp_thresholds_ranges(sig_train);
           
            [op_thr_sp,op_thr_kp] = training_process(sig_train,fs,'both',sp_thresh,sp_expert_score,kp_thresh,kp_expert_score,'On');
            

             
             
            set(handles.thr_sp,'visible','on');
             set(handles.thr_kp,'visible','on');
            set(handles.thr_sp,'string',int2str(op_thr_sp));
            set(handles.thr_kp,'string',int2str(op_thr_kp));
            
          
            [nbr_sp,pos_sp,nbr_kc,pos_kc]=test_process(xdata,fs,subj_name,'both',op_thr_sp,op_thr_kp);
        
            if scalo==1
              
                sp_axes=[0.026696329254727473 0.3100137174211248 0.7791991101223582 0.09190672153635115];
                sp_text_pos=[0.02836484983314794 0.41700960219478733 0.041156840934371525 0.02331961591220849];
                sp_edit_pos=[0.09121245828698554 0.4115226337448559 0.01835372636262514 0.0384087791495199 ];
               
                next_pos=[0.3325917686318131 0.19753086419753085 0.19521690767519467 0.07407407407407407];
                
                kp_axes=[0.02725250278086763 0.4622770919067215 0.778642936596218 0.09190672153635115];
                text_pos=[0.027808676307007785 0.5679012345679012 0.04338153503893215 0.023319615912208547];
                edit_pos=[0.09343715239154617 0.5596707818930041 0.01835372636262514 0.0384087791495199];
            else
                
                sp_axes=[0.026696329254727473 0.15089163237311384 0.7791991101223582 0.09190672153635115];
                sp_text_pos=[0.02836484983314794 0.2578875171467764 0.041156840934371525 0.02331961591220849];
                sp_edit_pos=[0.09343715239154617 0.252400548696845 0.01835372636262514 0.034293552812071304];
               
                next_pos=[0.3325917686318131 0.050754458161865565  0.19521690767519467 0.07407407407407407];
                
                kp_axes=[0.02725250278086763 0.30315500685871055 0.778642936596218 0.09190672153635115];
                text_pos=[0.027808676307007785 0.40877914951989025 0.04338153503893215 0.02331961591220849];
                edit_pos=[0.09343715239154617 0.4005486968449931 0.01835372636262514 0.0384087791495199];
            end
            
            set(handles.next_previous_panel,'Units','normalized','position',next_pos);
            
            
            set(handles.kp_edit,'visible','on','position',edit_pos);
            set(handles.kp_edit,'string',num2str(nbr_kc(n)));
            
            set(handles.komplex_text,'visible','on','units','normalized','position',text_pos);
           
          
            axes(handles.axes2);
            set(handles.axes2,'visible','on','units','normalized','position',kp_axes);
            cla;
            jj=0.5*ones(1,N);
            plot(pos_kc{n},jj(pos_kc{n}*fs),'k^','markerfacecolor','y','markersize',13);axis([0 30 0 1]);set(gca, 'XTick', []);set(gca, 'YTick', []);set(gca,'color',[0.200000002980232 0 0.600000023841858]);
            setappdata(gcf,'pos_kp',pos_kc);           
            setappdata(gcf,'nbr_kp',nbr_kc);
            
            
            set(handles.spindles_text,'visible','on','units','normalized','Position',sp_text_pos);
            
            
            set(handles.sp_edit,'visible','on','Units','normalized','position',sp_edit_pos);
            set(handles.sp_edit,'string',num2str(nbr_sp(n)));
            
            
            
            axes(handles.axes3); 
            set(handles.axes3,'visible','on','units','normalized','Position',sp_axes);cla;
            imagesc(pos_sp{n});colormap(parula);set(gca, 'XTick', []);set(gca, 'YTick', []);set(gca,'color',[0.200000002980232 0 0.600000023841858]);freezeColors
            setappdata(gcf,'pos_sp',pos_sp);
            setappdata(gcf,'nbr_sp',nbr_sp);
            
            
        end
        
    case 2
         if sp_selected==1 && kp_selected==0  
            thr_kc=str2double(get(handles.thr_sp,'string'));
            if thr_kc>0
             [nbr_sp,pos_sp]=test_process(xdata,fs,subj_name,'spindles',thr_kc);
            
            if scalo==0
             
                kp_axes=[0.02725250278086763 0.30315500685871055 0.778642936596218 0.09190672153635115];
                next_pos=[0.3275862068965517 0.1755829903978052 0.19521690767519473 0.07407407407407407];
                text_pos=[0.027808676307007785 0.40877914951989025 0.04338153503893215 0.023319615912208547];
                edit_pos=[0.09343715239154617 0.4005486968449931 0.01835372636262514 0.0384087791495199];
            else
                kp_axes=[0.02725250278086763 0.4622770919067215 0.778642936596218 0.09190672153635115];
                next_pos=[0.3275862068965517 0.3635116598079561 0.19521690767519473 0.07407407407407407];
                text_pos=[0.027808676307007785 0.5679012345679012 0.04338153503893215 0.023319615912208547];
                edit_pos=[0.09343715239154617 0.5596707818930041 0.01835372636262514 0.0384087791495199];
            end
            
            set(handles.next_previous_panel,'Units','normalized','position',next_pos);
            set(handles.spindles_text,'visible','on','units','normalized','Position',text_pos);
            
            
            set(handles.sp_edit,'visible','on','Units','normalized','position',edit_pos);
            set(handles.sp_edit,'string',num2str(nbr_sp(n)));
            
            axes(handles.axes2); 
            set(handles.axes2,'visible','off');cla;
            
            axes(handles.axes3); 
            set(handles.axes3,'visible','on','units','normalized','Position',kp_axes);cla;
            imagesc(pos_sp{n});colormap(parula);set(gca, 'XTick', []);set(gca, 'YTick', []);set(gca,'color',[0.200000002980232 0 0.600000023841858]);freezeColors
            setappdata(gcf,'pos_sp',pos_sp);
            setappdata(gcf,'nbr_sp',nbr_sp);
            
            else
                errordlg('Threshold for spindles selection must be positif ','Threshold error');
            end
          
        elseif sp_selected==0 && kp_selected==1
            thr_kc=str2double(get(handles.thr_kp,'string'));
            if thr_kc<0
            [nbr_kc,pos_kc]=test_process(xdata,fs,subj_name,'kcomplex',thr_kc);
           
             if scalo==0
              
                kp_axes=[0.02725250278086763 0.30315500685871055 0.778642936596218 0.09190672153635115];
                next_pos=[0.3275862068965517 0.1755829903978052 0.19521690767519473 0.07407407407407407];
                text_pos=[0.027808676307007785 0.40877914951989025 0.04338153503893215 0.023319615912208547];
                edit_pos=[0.09343715239154617 0.4005486968449931 0.01835372636262514 0.0384087791495199];
            else
                kp_axes=[0.02725250278086763 0.4622770919067215 0.778642936596218 0.09190672153635115];
                next_pos=[0.3275862068965517 0.3635116598079561 0.19521690767519473 0.07407407407407407];
                text_pos=[0.027808676307007785 0.5679012345679012 0.04338153503893215 0.023319615912208547];
                edit_pos=[0.09343715239154617 0.5596707818930041 0.01835372636262514 0.0384087791495199];
            end
            
            
            
            set(handles.next_previous_panel,'Units','normalized','position',next_pos);
            
            
            set(handles.kp_edit,'visible','on','position',edit_pos);
            set(handles.kp_edit,'string',num2str(nbr_kc(n)));
            
            set(handles.komplex_text,'visible','on','units','normalized','position',text_pos);
           
           axes(handles.axes3); 
            set(handles.axes3,'visible','off');cla;
            
            axes(handles.axes2);
            set(handles.axes2,'visible','on','units','normalized','position',kp_axes);
            cla;
            jj=0.5*ones(1,N);
            plot(pos_kc{n},jj(pos_kc{n}*fs),'k^','markerfacecolor','y','markersize',13);axis([0 30 0 1]);set(gca, 'XTick', []);set(gca, 'YTick', []);set(gca,'color',[0.200000002980232 0 0.600000023841858]);
            setappdata(gcf,'pos_kp',pos_kc);           
            setappdata(gcf,'nbr_kp',nbr_kc);
                
            
            
            else
                errordlg('Threshold for kcomplex detection must be negatif ','Threshold error');
            end
        elseif sp_selected==1 && kp_selected==1  
            thr_sp=str2double(get(handles.thr_sp,'string'));
            thr_kc=str2double(get(handles.thr_kp,'string'));
            if thr_kc<0 || thr_sp>0
            [nbr_sp,pos_sp,nbr_kc,pos_kc]=test_process(xdata,fs,subj_name,'both',thr_sp, thr_kc);
            if scalo==1
              
                sp_axes=[0.026696329254727473 0.3100137174211248 0.7791991101223582 0.09190672153635115];
                sp_text_pos=[0.02836484983314794 0.41700960219478733 0.041156840934371525 0.02331961591220849];
                sp_edit_pos=[0.09121245828698554 0.4115226337448559 0.01835372636262514 0.0384087791495199 ];
               
                next_pos=[0.3325917686318131 0.19753086419753085 0.19521690767519467 0.07407407407407407];
                
                kp_axes=[0.02725250278086763 0.4622770919067215 0.778642936596218 0.09190672153635115];
                text_pos=[0.027808676307007785 0.5679012345679012 0.04338153503893215 0.023319615912208547];
                edit_pos=[0.09343715239154617 0.5596707818930041 0.01835372636262514 0.0384087791495199];
            else
                
                sp_axes=[0.026696329254727473 0.15089163237311384 0.7791991101223582 0.09190672153635115];
                sp_text_pos=[0.02836484983314794 0.2578875171467764 0.041156840934371525 0.02331961591220849];
                sp_edit_pos=[0.09121245828698554 0.252400548696845 0.01835372636262514 0.0384087791495199 ];
               
                next_pos=[0.3325917686318131 0.050754458161865565  0.19521690767519467 0.07407407407407407];
                         kp_axes=[0.02725250278086763 0.30315500685871055 0.778642936596218 0.09190672153635115];
                text_pos=[0.027808676307007785 0.40877914951989025 0.04338153503893215 0.02331961591220849];
                edit_pos=[0.09343715239154617 0.4005486968449931 0.01835372636262514 0.0384087791495199];
                
            end
            
            set(handles.next_previous_panel,'Units','normalized','position',next_pos);
            
            
            set(handles.kp_edit,'visible','on','position',edit_pos);
            set(handles.kp_edit,'string',num2str(nbr_kc(n)));
            
            set(handles.komplex_text,'visible','on','units','normalized','position',text_pos);
           
          
            axes(handles.axes2);
            set(handles.axes2,'visible','on','units','normalized','position',kp_axes);
            cla;
            jj=0.5*ones(1,N);
            plot(pos_kc{n},jj(pos_kc{n}*fs),'k^','markerfacecolor','y','markersize',13);axis([0 30 0 1]);set(gca, 'XTick', []);set(gca, 'YTick', []);set(gca,'color',[0.200000002980232 0 0.600000023841858]);
            setappdata(gcf,'pos_kp',pos_kc);           
            setappdata(gcf,'nbr_kp',nbr_kc);
            
            
            set(handles.spindles_text,'visible','on','units','normalized','Position',sp_text_pos);
            
            
            set(handles.sp_edit,'visible','on','Units','normalized','position',sp_edit_pos);
            set(handles.sp_edit,'string',num2str(nbr_sp(n)));
            
            
            
            axes(handles.axes3); 
            set(handles.axes3,'visible','on','units','normalized','Position',sp_axes);cla;
            imagesc(pos_sp{n});colormap(parula);set(gca, 'XTick', []);set(gca, 'YTick', []);set(gca,'color',[0.200000002980232 0 0.600000023841858]);freezeColors
            setappdata(gcf,'pos_sp',pos_sp);
            setappdata(gcf,'nbr_sp',nbr_sp);
           
            elseif  thr_sp<0 
                errordlg('Threshold for spindles detection must be positif ','Threshold error');
            elseif thr_kc>0
                errordlg('Threshold for kcomplex detection must be negatif ','Threshold error');
            end
        end
 end


function thr_kp_Callback(hObject, eventdata, handles)
% hObject    handle to thr_kp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thr_kp as text
%        str2double(get(hObject,'String')) returns contents of thr_kp as a double


% --- Executes during object creation, after setting all properties.
function thr_kp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thr_kp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function thr_sp_Callback(hObject, eventdata, handles)
% hObject    handle to thr_sp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thr_sp as text
%        str2double(get(hObject,'String')) returns contents of thr_sp as a double


% --- Executes during object creation, after setting all properties.
function thr_sp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thr_sp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in kcomplex_chbx.
function kcomplex_chbx_Callback(hObject, eventdata, handles)
% hObject    handle to kcomplex_chbx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of kcomplex_chbx
kp=get(hObject,'Value');
sp=get(handles.spindle_chbx,'Value');

mode=getappdata(gcbf,'mode');

if mode==1 %mode threshold computing
 if sp==1 && kp==1
    set(handles.data_path,'visible','on');
    set(handles.data_browse,'visible','on');
    
    set(handles.kp_browse,'visible','on','position',[0.9493882091212458 0.4005486968449931 0.03170189098998888 0.0384087791495199]);
    set(handles.kp_path,'visible','on','position',[0.8314794215795328 0.401920438957476 0.11401557285873187 0.03566529492455417]);
    
    set(handles.run_bt,'visible','on','position',[0.9599555061179088 0.3127572016460905 0.03170189098998888 0.0384087791495199]);
    set(handles.loading_tr_data,'visible','on','position',[0.8203559510567296 0.3799725651577503 0.17352614015572854 0.24965706447187924]);
    
    set(handles.cancel_bt,'visible','on','position',[0.9221357063403782 0.3127572016460905 0.03170189098998888 0.0384087791495199]);
   
    setappdata(gcf,'kp_detection',1);
    setappdata(gcf,'sp_detection',sp);
    
 elseif sp==0 && kp==1
      
    set(handles.data_path,'visible','on');
    set(handles.data_browse,'visible','on');
    
    set(handles.kp_browse,'visible','on','position',[0.949944382647386 0.4773662551440329 0.03170189098998888 0.038408779149519845]);
    set(handles.kp_path,'visible','on','position',[0.8314794215795328 0.4801097393689986 0.11345939933259175 0.03429355281207136]);
    
    set(handles.run_bt,'visible','on','position',[0.9582869855394883 0.4005486968449931 0.03170189098998888 0.0384087791495199]);
    set(handles.loading_tr_data,'visible','on','position',[0.8203559510567296 0.44855967078189296 0.17352614015572854 0.18106995884773658]);
    
    set(handles.cancel_bt,'visible','on','position',[0.9204671857619577 0.4005486968449931 0.03170189098998888 0.0384087791495199]);
    
    setappdata(gcf,'kp_detection',1);
    setappdata(gcf,'sp_detection',sp);
  elseif sp==0 && kp==0
    
    set(handles.kp_browse,'visible','off','position',[0.949944382647386 0.4773662551440329 0.03170189098998888 0.038408779149519845]);
    set(handles.kp_path,'visible','off','position',[0.8314794215795328 0.4801097393689986 0.11345939933259175 0.03429355281207136]);
    
    set(handles.run_bt,'visible','off','position',[0.9582869855394883 0.4005486968449931 0.03170189098998888 0.0384087791495199]);
    set(handles.loading_tr_data,'visible','on','position',[0.8203559510567296 0.5349794238683128 0.17352614015572854 0.09465020576131689]);
    
    set(handles.cancel_bt,'visible','off','position',[0.9204671857619577 0.4005486968449931 0.03170189098998888 0.0384087791495199]);
    
    setappdata(gcf,'kp_detection',0);
    setappdata(gcf,'sp_detection',sp);
    elseif sp==1 && kp==0
    
    set(handles.kp_browse,'visible','off','position',[0.949944382647386 0.4773662551440329 0.03170189098998888 0.038408779149519845]);
    set(handles.kp_path,'visible','off','position',[0.8314794215795328 0.4801097393689986 0.11345939933259175 0.03429355281207136]);
    
    set(handles.run_bt,'visible','on','position',[0.9582869855394883 0.4005486968449931 0.03170189098998888 0.0384087791495199]);
    set(handles.loading_tr_data,'visible','on','position',[0.8203559510567296 0.44855967078189296 0.17352614015572854 0.18106995884773658]);
    
    set(handles.cancel_bt,'visible','on','position',[0.9204671857619577 0.4005486968449931 0.03170189098998888 0.0384087791495199]);
    
    setappdata(gcf,'kp_detection',0);
    setappdata(gcf,'sp_detection',sp); 
 end

 
    
elseif mode==2 
  
    set(handles.data_path,'visible','off');
    set(handles.data_browse,'visible','off');
    
    set(handles.loading_tr_data,'visible','off');
    
    set(handles.kp_browse,'visible','off');
    set(handles.kp_path,'visible','off');
    
    kp_detection=1;
    setappdata(gcf,'kp_detection',kp_detection);
    setappdata(gcf,'sp_detection',sp);
    
elseif mode==2 && kp==0
    set(handles.data_path,'visible','off');
    set(handles.data_browse,'visible','off');
     
    set(handles.loading_tr_data,'visible','off');
    
    set(handles.kp_browse,'visible','off');
    set(handles.kp_path,'visible','off');
    
    kp_detection=0;
    setappdata(gcf,'kp_detection',kp_detection);
    setappdata(gcf,'sp_detection',sp);
end

% --- Executes on button press in spindle_chbx.
function spindle_chbx_Callback(hObject, eventdata, handles)
% hObject    handle to spindle_chbx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of spindle_chbx
sp=get(hObject,'Value');
kp=get(handles.kcomplex_chbx,'Value');

mode=getappdata(gcbf,'mode');

if mode==1 %mode threshold computing
 if kp==1 && sp==1
    set(handles.data_path,'visible','on');
    set(handles.data_browse,'visible','on');
    
    set(handles.sp_browse,'visible','on','position',[0.9493882091212458 0.4005486968449931 0.03170189098998888 0.0384087791495199]);
    set(handles.sp_path,'visible','on','position',[0.8314794215795328 0.401920438957476 0.11401557285873187 0.03566529492455417]);
    
    set(handles.run_bt,'visible','on','position',[0.9599555061179088 0.3127572016460905 0.03170189098998888 0.0384087791495199]);
    set(handles.loading_tr_data,'visible','on','position',[0.8203559510567296 0.3799725651577503 0.17352614015572854 0.24965706447187924]);
    
    set(handles.cancel_bt,'visible','on','position',[0.9221357063403782 0.3127572016460905 0.03170189098998888 0.0384087791495199]);
   
    setappdata(gcf,'sp_detection',1);
    setappdata(gcf,'kp_detection',kp);
    
 elseif kp==0 && sp==1
      
    set(handles.data_path,'visible','on');
    set(handles.data_browse,'visible','on');
    
    set(handles.sp_browse,'visible','on','position',[0.949944382647386 0.4773662551440329 0.03170189098998888 0.038408779149519845]);
    set(handles.sp_path,'visible','on','position',[0.8314794215795328 0.4801097393689986 0.11345939933259175 0.03429355281207136]);
    
    set(handles.run_bt,'visible','on','position',[0.9582869855394883 0.4005486968449931 0.03170189098998888 0.0384087791495199]);
    set(handles.loading_tr_data,'visible','on','position',[0.8203559510567296 0.44855967078189296 0.17352614015572854 0.18106995884773658]);
    
    set(handles.cancel_bt,'visible','on','position',[0.9204671857619577 0.4005486968449931 0.03170189098998888 0.0384087791495199]);
    
    setappdata(gcf,'sp_detection',1);
    setappdata(gcf,'kp_detection',kp);
  elseif kp==0 && sp==0
    
    set(handles.sp_browse,'visible','off','position',[0.949944382647386 0.4773662551440329 0.03170189098998888 0.038408779149519845]);
    set(handles.sp_path,'visible','off','position',[0.8314794215795328 0.4801097393689986 0.11345939933259175 0.03429355281207136]);
    
    set(handles.run_bt,'visible','off','position',[0.9582869855394883 0.4005486968449931 0.03170189098998888 0.0384087791495199]);
    set(handles.loading_tr_data,'visible','on','position',[0.8203559510567296 0.5349794238683128 0.17352614015572854 0.09465020576131689]);
    
    set(handles.cancel_bt,'visible','off','position',[0.9204671857619577 0.4005486968449931 0.03170189098998888 0.0384087791495199]);
    
    setappdata(gcf,'sp_detection',0);
    setappdata(gcf,'kp_detection',kp);
    elseif kp==1 && sp==0
    
    set(handles.sp_browse,'visible','off','position',[0.949944382647386 0.4773662551440329 0.03170189098998888 0.038408779149519845]);
    set(handles.sp_path,'visible','off','position',[0.8314794215795328 0.4801097393689986 0.11345939933259175 0.03429355281207136]);
    
    set(handles.run_bt,'visible','on','position',[0.9582869855394883 0.4005486968449931 0.03170189098998888 0.0384087791495199]);
    set(handles.loading_tr_data,'visible','on','position',[0.8203559510567296 0.44855967078189296 0.17352614015572854 0.18106995884773658]);
    
    set(handles.cancel_bt,'visible','on','position',[0.9204671857619577 0.4005486968449931 0.03170189098998888 0.0384087791495199]);
    
    setappdata(gcf,'sp_detection',0);
    setappdata(gcf,'kp_detection',kp); 
 end

 
    
elseif mode==2 
    
    set(handles.data_path,'visible','off');
    set(handles.data_browse,'visible','off');
    
    set(handles.loading_tr_data,'visible','off');
    
    set(handles.sp_browse,'visible','off');
    set(handles.sp_path,'visible','off');
    
    sp_detection=1;
    setappdata(gcf,'sp_detection',sp_detection);
    setappdata(gcf,'kp_detection',kp);
    
elseif mode==2 && sp==0
    set(handles.data_path,'visible','off');
    set(handles.data_browse,'visible','off');
    
    set(handles.loading_tr_data,'visible','off');
    
    set(handles.sp_browse,'visible','off');
    set(handles.sp_path,'visible','off');
    
    sp_detection=0;
    setappdata(gcf,'sp_detection',sp_detection);
    setappdata(gcf,'kp_detection',kp);
end

% --- Executes on button press in cancel_bt.
function cancel_bt_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function sp_edit_Callback(hObject, eventdata, handles)
% hObject    handle to sp_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sp_edit as text
%        str2double(get(hObject,'String')) returns contents of sp_edit as a double


% --- Executes during object creation, after setting all properties.
function sp_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sp_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function kp_edit_Callback(hObject, eventdata, handles)
% hObject    handle to kp_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kp_edit as text
%        str2double(get(hObject,'String')) returns contents of kp_edit as a double


% --- Executes during object creation, after setting all properties.
function kp_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kp_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function kp_export_menu_Callback(hObject, eventdata, handles)
% hObject    handle to kp_export_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function sp_export_menu_Callback(hObject, eventdata, handles)
% hObject    handle to sp_export_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function txt_file_sp_Callback(hObject, eventdata, handles)
% hObject    handle to txt_file_sp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
etat_sp=getappdata(gcbf,'sp_detection');fs=getappdata(gcbf,'fs');
sig=getappdata(gcbf,'signal');
subject=getappdata(gcbf,'subj');

if etat_sp ==1
possp=getappdata(gcbf,'pos_sp');

nbrsp=getappdata(gcbf,'nbr_sp');
% assignin('base','pos',possp);
% assignin('base','nbr',nbrsp);
% assignin('base','X',sig);
nbr_tot= sum(nbrsp);


duree_seg=getappdata(gcbf,'N')/fs;duree_sig=length(possp)*duree_seg;

for j=1:length(possp)
   KK= find(possp{j})==1;
   
    if numel(KK)>0
    [onsets,spindle_duration] = pos2onset(possp{j},fs);
    x=sig{j}(possp{j}==1);
    [v_e, v_n]=bf_envhilb(x);
    else
     spindle_duration=0;
     v_e=0;
    end
    M_duration(j)=mean(spindle_duration);
    M_amp(j)=mean(v_e);
end

mean_duration=mean(M_duration(M_duration>0));
mean_amp=mean(M_amp(M_amp>0));

 frq=nbr_tot/duree_sig;

%struct
field {1} = 'Total_number';  value(1) = nbr_tot;
field {2} = 'Density';  value(2) = nbr_tot/length(possp);
field {3} = 'Mean_duration';  value(3) = mean_duration;
field {5} = 'Mean_amptliude';  value(5) = mean_amp;
field {4} = 'Frequency';  value(4) = frq;
 file_name = ['Spindles_detection_results_' subject '.txt'];

fid=fopen(file_name,'a+');
 for kk=1:length(field)
 fprintf(fid,'%s %s \n',field{kk},num2str(value(kk)));
 end
 fclose(fid);

else
     errordlg('Please load Spindles score','Spindles loading Error');
end



% --------------------------------------------------------------------
function mat_file_sp_Callback(hObject, eventdata, handles)
% hObject    handle to mat_file_sp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
etat_sp=getappdata(gcbf,'sp_detection');fs=getappdata(gcbf,'fs');
sig=getappdata(gcbf,'signal');
subject=getappdata(gcbf,'subj');

if etat_sp ==1
possp=getappdata(gcbf,'pos_sp');

nbrsp=getappdata(gcbf,'nbr_sp');
% assignin('base','pos',possp);
% assignin('base','nbr',nbrsp);
% assignin('base','X',sig);
nbr_tot= sum(nbrsp);


duree_seg=getappdata(gcbf,'N')/fs;duree_sig=length(possp)*duree_seg;

for j=1:length(possp)
   KK= find(possp{j})==1;
   
    if numel(KK)>0
    [onsets,spindle_duration] = pos2onset(possp{j},fs);
    x=sig{j}(possp{j}==1);
    [v_e, v_n]=bf_envhilb(x);
    else
     spindle_duration=0;
     v_e=0;
    end
    M_duration(j)=mean(spindle_duration);
    M_amp(j)=mean(v_e);
end

mean_duration=mean(M_duration(M_duration>0));
mean_amp=mean(M_amp(M_amp>0));

 frq=nbr_tot/duree_sig;
field1 = 'Total_number';  value1 = nbr_tot;
field2 = 'Density';  value2 = nbr_tot/length(possp);
 field3 = 'Mean_duration';  value3 = mean_duration;
 field5 = 'Mean_amptliude';  value5 = mean_amp;
 field4 = 'Frequency';  value4 = frq;
Results = struct(field1,value1,field2,value2,field3,value3,field4,value4,field5,value5);
%

 file_name = ['Spindles_detection_results_' subject '.mat'];
save([file_name '.mat'],'Results');
else
     errordlg('Please load Spindles score','Spindles loading Error');
end


% --------------------------------------------------------------------
function txt_menu_kp_Callback(hObject, eventdata, handles)
% hObject    handle to txt_menu_kp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


etat_kp=getappdata(gcbf,'kp_detection');fs=getappdata(gcbf,'fs');
sig=getappdata(gcbf,'signal');
subject=getappdata(gcbf,'subj');

if etat_kp ==1
poskp=getappdata(gcbf,'pos_kp');

nbrkp=getappdata(gcbf,'nbr_kp');
%  assignin('base','pos',poskp);
%  assignin('base','nbr',nbrkp);
% assignin('base','sig',sig);


nbr_tot= sum(nbrkp);
duree_seg=getappdata(gcbf,'N')/fs;duree_sig=length(poskp)*duree_seg;

den=nbr_tot/length(poskp);
freq=nbr_tot/duree_sig;
for j=1:length(poskp)
    if numel(poskp{j})>0
        amp=sig{j}(poskp {j}*fs);
    else
        amp=0;
    end
     M_amp(j)=mean(amp);
end
mean_amp=mean(M_amp(M_amp<0));


field {1} = 'Total_number';  value(1) = nbr_tot;
field {2} = 'Density';  value(2) = den;
field {3} = 'Frequency';  value(3) = freq;
field {4} = 'Mean amplitude';  value(4) = mean_amp;
% 
% %

file_name = ['Kcomplex_detection_results_' subject '.txt'];

 fid=fopen(file_name,'a+');
 for kk=1:length(field)
 fprintf(fid,'%s %s \n',field{kk},num2str(value(kk)));
 end
 fclose(fid);

else
     errordlg('Please load Kcomplex score','Kcomplex loading Error');
end

% --------------------------------------------------------------------
function mat_file_kp_Callback(hObject, eventdata, handles)
% hObject    handle to mat_file_kp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

etat_kp=getappdata(gcbf,'kp_detection');fs=getappdata(gcbf,'fs');
sig=getappdata(gcbf,'signal');
subject=getappdata(gcbf,'subj');

if etat_kp ==1
poskp=getappdata(gcbf,'pos_kp');

nbrkp=getappdata(gcbf,'nbr_kp');
%  assignin('base','pos',poskp);
%  assignin('base','nbr',nbrkp);
% assignin('base','sig',sig);


nbr_tot= sum(nbrkp);
duree_seg=getappdata(gcbf,'N')/fs;duree_sig=length(poskp)*duree_seg;

den=nbr_tot/length(poskp);
freq=nbr_tot/duree_sig;
for j=1:length(poskp)
    if numel(poskp{j})>0
        amp=sig{j}(poskp {j}*fs);
    else
        amp=0;
    end
     M_amp(j)=mean(amp);
end
mean_amp=mean(M_amp(M_amp<0));


field1 = 'Total_number';  value1 = nbr_tot;
field2 = 'Density';  value2 = den;
field3 = 'Frequency';  value3 = freq;
field4 = 'Mean_amplitude';  value4 = mean_amp;
% 
% %

file_name = ['Kcomplex_detection_results_' subject '.mat'];
Results = struct(field1,value1,field2,value2,field3,value3,field4,value4);
save([file_name '.mat'],'Results');
else
     errordlg('Please load Kcomplex score','Kcomplex loading Error');
end
