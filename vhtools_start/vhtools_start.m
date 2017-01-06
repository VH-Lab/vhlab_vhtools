function varargout = vhtools_start(varargin)
% VHTOOLS_START A start menu for the vhtools
%
%      VHTOOLS_START creates a new VHTOOLS_START menu that allows the
%      user to select many commonly used functions. 
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vhtools_start

% Last Modified by GUIDE v2.5 27-Apr-2012 01:43:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vhtools_start_OpeningFcn, ...
                   'gui_OutputFcn',  @vhtools_start_OutputFcn, ...
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


% --- Executes just before vhtools_start is made visible.
function vhtools_start_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vhtools_start (see VARARGIN)

% Choose default command line output for vhtools_start
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vhtools_start wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vhtools_start_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%IMPORTANT: Under the Current Folder window in Matlab, the vhtools_start folder 
%must be right-clicked and Add Path to the Selected Folders and Subfolders


% --------------------------------------------------------------------
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% functionality - pull down start menu

% --------------------------------------------------------------------
function documentation_Callback(hObject, eventdata, handles)
% hObject    handle to documentation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% functionality - open http://sites.google.com/site/vhlabtools
web http://sites.google.com/site/vhlabtools -browser

% --------------------------------------------------------------------
function update_Callback(hObject, eventdata, handles)
% hObject    handle to update (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% functionality - run 'vhtools_start_installer'
run vhtools_installer

% --------------------------------------------------------------------
function run_experiment_Callback(hObject, eventdata, handles)
% hObject    handle to run_experiment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% functionality - run 'RunExperiment'
run RunExperiment

% --------------------------------------------------------------------
function init_stims_Callback(hObject, eventdata, handles)
% hObject    handle to init_stims (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% functionality - run 'initstims'
run initstims

% --------------------------------------------------------------------
function bulk_load_Callback(hObject, eventdata, handles)
% hObject    handle to bulk_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% functionality - run 'Two Photon Bulk Load'
run twophotonbulkload
