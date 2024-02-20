function varargout = graph_timer(varargin)
% GUI_GRAPH MATLAB code for gui_graph.fig
%      GUI_GRAPH, by itself, creates a new GUI_GRAPH or raises the existing
%      singleton*.
%
%      H = GUI_GRAPH returns the handle to a new GUI_GRAPH or the handle to
%      the existing singleton*.
%
%      GUI_GRAPH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_GRAPH.M with the given input arguments.
%
%      GUI_GRAPH('Property','Value',...) creates a new GUI_GRAPH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_graph_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_graph_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_graph

% Last Modified by GUIDE v2.5 20-Feb-2024 13:37:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_graph_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_graph_OutputFcn, ...
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


% --- Executes just before gui_graph is made visible.
function gui_graph_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_graph (see VARARGIN)

% Choose default command line output for gui_graph
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_graph wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_graph_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in load_button.
function load_button_Callback(hObject, eventdata, handles)
% hObject    handle to load_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Use uigetfile to open a dialog for file selection
[filename, filepath] = uigetfile('*.xlsx', 'Select an Excel file');

% Check if the user selected a file
if isequal(filename, 0) || isequal(filepath, 0)
    % User canceled the operation
    return;
end

% Construct the full file path
fullFilePath = fullfile(filepath, filename);

% Read the data from the Excel file
[num_data, txt_data, raw_data] = xlsread(fullFilePath);

% Optionally, you can store the loaded data in the handles structure
handles.loaded_data = num_data;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Initially plot no data
cla(hObject);


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Ensure only two checkboxes are checked
checkbox_states = [get(handles.checkbox1, 'Value'), ...
                    get(handles.checkbox2, 'Value'), ...
                    get(handles.checkbox3, 'Value'), ...
                    get(handles.checkbox4, 'Value')];
if sum(checkbox_states) > 2
    set(hObject, 'Value', 0);
end

% Update the plot based on the selected checkboxes
plot_selected_columns(handles);


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Ensure only two checkboxes are checked
checkbox_states = [get(handles.checkbox1, 'Value'), ...
                    get(handles.checkbox2, 'Value'), ...
                    get(handles.checkbox3, 'Value'), ...
                    get(handles.checkbox4, 'Value')];
if sum(checkbox_states) > 2
    set(hObject, 'Value', 0);
end

% Update the plot based on the selected checkboxes
update_plot(handles);


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Ensure only two checkboxes are checked
checkbox_states = [get(handles.checkbox1, 'Value'), ...
                    get(handles.checkbox2, 'Value'), ...
                    get(handles.checkbox3, 'Value'), ...
                    get(handles.checkbox4, 'Value')];
if sum(checkbox_states) > 2
    set(hObject, 'Value', 0);
end

% Update the plot based on the selected checkboxes
plot_selected_columns(handles);


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Ensure only two checkboxes are checked
checkbox_states = [get(handles.checkbox1, 'Value'), ...
                    get(handles.checkbox2, 'Value'), ...
                    get(handles.checkbox3, 'Value'), ...
                    get(handles.checkbox4, 'Value')];
if sum(checkbox_states) > 2
    set(hObject, 'Value', 0);
end

% Update the plot based on the selected checkboxes
plot_selected_columns(handles);


function plot_selected_columns(handles)
% Plot the values of the selected columns one by one with an interval of 1 second

% Check if the loaded_data is available in handles
if isfield(handles, 'loaded_data')
    % Get the states of the checkboxes
    checkbox1_state = get(handles.checkbox1, 'Value');
    checkbox2_state = get(handles.checkbox2, 'Value');
    checkbox3_state = get(handles.checkbox3, 'Value');
    checkbox4_state = get(handles.checkbox4, 'Value');
    
    % Select the columns to plot based on the selected checkboxes
    selected_columns = [];
    if checkbox1_state
        selected_columns = [selected_columns, 1];
    end
    if checkbox2_state
        selected_columns = [selected_columns, 2];
    end
    if checkbox3_state
        selected_columns = [selected_columns, 3];
    end
    if checkbox4_state
        selected_columns = [selected_columns, 4];
    end
    
    % Plot the selected columns one by one with a 1-second interval
    if ~isempty(selected_columns)
        % Extract the selected columns from the loaded data
        selected_data = handles.loaded_data(:, selected_columns);
        
        % Plot each selected column one by one
        for i = 1:size(selected_data, 2)
            % Clear the axes before plotting the next column
            cla(handles.axes1);
            
            % Plot the current column
            plot(handles.axes1, selected_data(:, i));
            
            % Customize the plot if needed
            xlabel(handles.axes1, 'X-axis label');
            ylabel(handles.axes1, 'Y-axis label');
            title(handles.axes1, ['Plot of Column ' num2str(selected_columns(i))]);
            
            % Pause for 1 second before plotting the next column
            pause(1);
        end
    end
end

