function varargout = interface(varargin)
%INTERFACE M-file for interface.fig
%      INTERFACE, by itself, creates a new INTERFACE or raises the existing
%      singleton*.
%
%      H = INTERFACE returns the handle to a new INTERFACE or the handle to
%      the existing singleton*.
%
%      INTERFACE('Property','Value',...) creates a new INTERFACE using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to interface_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      INTERFACE('CALLBACK') and INTERFACE('CALLBACK',hObject,...) call the
%      local function named CALLBACK in INTERFACE.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help interface

% Last Modified by GUIDE v2.5 18-Dec-2014 22:42:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @interface_OpeningFcn, ...
                   'gui_OutputFcn',  @interface_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before interface is made visible.
function interface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for interface
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes interface wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = interface_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function production_Callback(hObject, eventdata, handles)
% hObject    handle to production (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of production as text
%        str2double(get(hObject,'String')) returns contents of production as a double


% --- Executes during object creation, after setting all properties.
function production_CreateFcn(hObject, eventdata, handles)
% hObject    handle to production (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function temperature_Callback(hObject, eventdata, handles)
% hObject    handle to temperature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of temperature as text
%        str2double(get(hObject,'String')) returns contents of temperature as a double


% --- Executes during object creation, after setting all properties.
function temperature_CreateFcn(hObject, eventdata, handles)
% hObject    handle to temperature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushsim.
function pushsim_Callback(hObject, eventdata, handles)
% hObject    handle to pushsim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Prod = str2num(get(handles.production,'String'));
Temp = str2num(get(handles.temperature,'String'));

molarmass = molar_masses()'./1e3;
[pr_in, sr_in, wgs_in, sep_in, sep_out, as_in, as_out, ov_in, ov_out, tc] = manager(Prod,Temp);
pr_in = molarmass.*pr_in;
sr_in = molarmass.*sr_in;
wgs_in = molarmass.*wgs_in;
sep_in = molarmass.*sep_in;
sep_out = molarmass.*sep_out;
as_in = molarmass.*as_in;
as_out = molarmass.*as_out;
ov_in = molarmass.*ov_in;
ov_out = molarmass.*ov_out;

min = 0.001;
MbPr = [pr_in(1:8), zeros(1,4)]; MbPr(MbPr<min) = 0;
MbSr = [sr_in(1:8), zeros(1,4)]; MbSr(MbSr<min) = 0;
MbWGs = [wgs_in(1:8), zeros(1,4)]; MbWGs(MbWGs<min) = 0;
MbS = [sep_in(1:8), sep_out([9 5 7 2])]; MbS(MbS<min) = 0;
MbAs = [as_in(1:8), as_out([9 5 7 2])]; MbAs(MbAs<min) = 0;

MbOv = [ov_in([1 3]), ov_out([2 7])]; MbOv(MbOv<min) = 0;

set(handles.bilan, 'Data', MbOv);
set(handles.bilandemasse, 'Data', [MbPr;MbSr;MbWGs;MbS;MbAs]);
set(handles.tuyaux, 'String', tc);


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
