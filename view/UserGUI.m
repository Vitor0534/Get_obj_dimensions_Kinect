function varargout = UserGUI(varargin)
% USERGUI MATLAB code for UserGUI.fig
%      type >> guide on the comand window to edit this interface
%      USERGUI, by itself, creates a new USERGUI or raises the existing
%      singleton*.
%
%      H = USERGUI returns the handle to a new USERGUI or the handle to
%      the existing singleton*.
%
%      USERGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in USERGUI.M with the given input arguments.
%
%      USERGUI('Property','Value',...) creates a new USERGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before UserGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to UserGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help UserGUI

% Last Modified by GUIDE v2.5 07-Sep-2023 18:18:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @UserGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @UserGUI_OutputFcn, ...
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


% --- Executes just before UserGUI is made visible.
function UserGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to UserGUI (see VARARGIN)

% Choose default command line output for UserGUI
handles.output = hObject;
setupGraphicallElments(handles);
% Update handles structure
guidata(hObject, handles);

function setupGraphicallElments(handles)
    axes(handles.axes3)
    imshow(imread('icons/plane2.png'))
   

% UIWAIT makes UserGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = UserGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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

% --- Executes on button press in start_pushbutton.
function start_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to start_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%0 - Setupt Services
airplaneObj = Airplane;
airplaneDAO = AirplaneDAO;
airplaneService = AirplaneService(airplaneObj,airplaneDAO);

airplaneObj = airplaneService.getSelectedAirplane(airplaneService); 
airplaneService.airplane = airplaneObj;



%1 - Setup Parameters 
lugaggeScanner = LugaggeScanner();

scannerParameters = ScannerParameters();
scannerParameters.matSpeed = get(handles.speedPopupMenu, 'UserData');
lugaggeScanner.scannerParameters = scannerParameters;


handLuggageDimentionLimits    = [ 
                                  get(handles.handLuggageLenghtLimit,'UserData')    
                                  get(handles.handLuggageWidthLimit,'UserData')   
                                  get(handles.handLuggageDepthLimit,'UserData')
                                 ];
                             
checkedLuggageDimentionLimits = [
                                  get(handles.checkedBaggageLenghtLimit,'UserData')
                                  get(handles.checkedBaggageWidthLimit,'UserData')
                                  get(handles.checkedBaggageDepthLimit,'UserData')
                                ];

                           
airplaneService.handLuggageMaxDimentionLimits    = handLuggageDimentionLimits;
airplaneService.checkedLuggageMaxDimentionLimits = checkedLuggageDimentionLimits;
airplaneService.handLuggageMaxWeight             = 10;
airplaneService.despachedLuggageMaxWeight        = 23;


maxVolumeHandLuggage      = airplaneService.get_Max_Volume_Hand_Luggage(airplaneService, prod(handLuggageDimentionLimits), airplaneService.handLuggageMaxWeight);
maxVolumeDespachedLuggage = airplaneService.get_Max_Volume_despached_Luggage(airplaneService, prod(checkedLuggageDimentionLimits), airplaneService.despachedLuggageMaxWeight);

set(handles.volumeRestanteBagageiroText, 'String',    cm3ToM3(maxVolumeHandLuggage));
set(handles.volumeRestantePoraoText,     'String',    cm3ToM3(maxVolumeDespachedLuggage));
set(handles.volumeRestanteBagageiroText, 'UserData',  cm3ToM3(maxVolumeHandLuggage));
set(handles.volumeRestantePoraoText,     'UserData',  cm3ToM3(maxVolumeDespachedLuggage));


%2 - execute scanner
[results] = lugaggeScanner.getLuggageDimensionsWithScannerAproach(lugaggeScanner);



%3 - Show Results
axes(handles.axes1)
pcshow(results.pointCloudCapturadaSemTratamento);

axes(handles.axes2)
lugaggeScanner.plotConvexHullOfPtCloud(results.pointCloudCapturadaTratada, results.convHull_K2_triangulation);

set(handles.heighResult,'String',results.Height);
set(handles.widthResult,'String',results.Width);
set(handles.dephResult,'String',results.Depth);
                                
luggageDimensionsMensured     = [
                                 results.Height
                                 results.Width
                                 results.Depth
                                 ];

showDimentionsDifferece(handles, handLuggageDimentionLimits, checkedLuggageDimentionLimits, luggageDimensionsMensured)

[approbationMensage,luggageAprovation, luggageType] = getLuggageAprobationMensage(handLuggageDimentionLimits, checkedLuggageDimentionLimits, luggageDimensionsMensured);
 
countAprovedLuggages(handles,luggageAprovation);

if(luggageType == 1)
    updateCurrentStatusOfBaggageStorage(handles.volumeRestanteBagageiroText, handles.porcentagemPreenchidaBagageirotext, maxVolumeHandLuggage, luggageDimensionsMensured, luggageAprovation);
elseif(luggageType == 2)
    updateCurrentStatusOfBaggageStorage(handles.volumeRestantePoraoText, handles.porcentagemPreenchidaPoraotext, maxVolumeDespachedLuggage, luggageDimensionsMensured, luggageAprovation);
end
    
 
set(handles.luggageApprobation,'String',approbationMensage);




function [mensage, aprovation, luggageType] = getLuggageAprobationMensage(handLuggageDimentionLimits, checkedLuggageDimentionLimits, luggageDimensionsMensured)
    mensage    = false;
    aprovation = 0;
    luggageType = 0;
    if(validadeLuggageDimensions(handLuggageDimentionLimits, luggageDimensionsMensured))
        mensage = 'Bagagem aprovada como de mão';
        aprovation = 1;
        luggageType = 1;
    elseif(~mensage && validadeLuggageDimensions(checkedLuggageDimentionLimits, luggageDimensionsMensured))
        mensage = 'Bagagem aprovada como despacho';
        aprovation = 1;
        luggageType = 2;
    else
        mensage = 'Bagagem fora dos limites permitidos';
    end
        



function [result] = validadeLuggageDimensions(LuggageDimentionLimits, luggageDimensionsMensured)
    veryArray = luggageDimensionsMensured <= LuggageDimentionLimits;    
    if(veryArray(:) ~= 0)
        result = true;
    else
        result = false;
    end

function showDimentionsDifferece(handles, handLuggageDimentionLimits, checkedLuggageDimentionLimits, luggageDimensionsMensured)
    set(handles.heighDifferenceHL,'String',handLuggageDimentionLimits(1) - luggageDimensionsMensured(1));
    set(handles.widthDifferenceHL,'String',handLuggageDimentionLimits(2) - luggageDimensionsMensured(2));
    set(handles.depthDifferenceHL,'String',handLuggageDimentionLimits(3) - luggageDimensionsMensured(3));
    
    set(handles.heighDifferenceCB,'String',checkedLuggageDimentionLimits(1) - luggageDimensionsMensured(1));
    set(handles.widthDifferenceCB,'String',checkedLuggageDimentionLimits(2) - luggageDimensionsMensured(2));
    set(handles.depthDifferenceCB,'String',checkedLuggageDimentionLimits(3) - luggageDimensionsMensured(3));

function countAprovedLuggages(handles,aprovation)

    quantidadeDeBagagemMedidaEAprovada = get(handles.quantidadeBagagensMedidasAprovadasTex,'UserData');
    set(handles.quantidadeBagagensMedidasAprovadasTex,'String',quantidadeDeBagagemMedidaEAprovada + aprovation);
    set(handles.quantidadeBagagensMedidasAprovadasTex,'UserData',quantidadeDeBagagemMedidaEAprovada + aprovation);
    

    
function updateCurrentStatusOfBaggageStorage(airplaneVolumeStorageTextHObject, airplanePercentageStorageTextHObject, maxVolumeBaggageStorage, luggageDimensionsMensured, luggageAprovation)

    if(luggageAprovation)
        volumeDisponivelBagagem = get(airplaneVolumeStorageTextHObject,'UserData') - cm3ToM3(prod(luggageDimensionsMensured));
        
        set(airplaneVolumeStorageTextHObject, 'String',     volumeDisponivelBagagem);
        set(airplaneVolumeStorageTextHObject, 'UserData',   volumeDisponivelBagagem);
        
        currentStoragePercentage = (100 * volumeDisponivelBagagem / cm3ToM3(maxVolumeBaggageStorage)) - 100;
        
        set(airplanePercentageStorageTextHObject, 'String', abs(currentStoragePercentage));
       
      
    end

function result = cm3ToM3(value)
    result = value/1000000;

        
function checkedBaggageLenghtLimit_Callback(hObject, eventdata, handles)
% hObject    handle to checkedBaggageLenghtLimit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of checkedBaggageLenghtLimit as text
%        str2double(get(hObject,'String')) returns contents of checkedBaggageLenghtLimit as a double
value = str2double(get(hObject,'String')); 
set(hObject,'UserData',value)


% --- Executes during object creation, after setting all properties.
function checkedBaggageLenghtLimit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to checkedBaggageLenghtLimit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function checkedBaggageWidthLimit_Callback(hObject, eventdata, handles)
% hObject    handle to checkedBaggageWidthLimit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of checkedBaggageWidthLimit as text
%        str2double(get(hObject,'String')) returns contents of checkedBaggageWidthLimit as a double
value = str2double(get(hObject,'String')); 
set(hObject,'UserData',value)


% --- Executes during object creation, after setting all properties.
function checkedBaggageWidthLimit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to checkedBaggageWidthLimit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function checkedBaggageDepthLimit_Callback(hObject, eventdata, handles)
% hObject    handle to checkedBaggageDepthLimit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of checkedBaggageDepthLimit as text
%        str2double(get(hObject,'String')) returns contents of checkedBaggageDepthLimit as a double
value = str2double(get(hObject,'String')); 
set(hObject,'UserData',value)


% --- Executes during object creation, after setting all properties.
function checkedBaggageDepthLimit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to checkedBaggageDepthLimit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function handLuggageLenghtLimit_Callback(hObject, eventdata, handles)
% hObject    handle to handLuggageLenghtLimit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of handLuggageLenghtLimit as text
%        str2double(get(hObject,'String')) returns contents of handLuggageLenghtLimit as a double
value = str2double(get(hObject,'String')); 
set(hObject,'UserData',value)


% --- Executes during object creation, after setting all properties.
function handLuggageLenghtLimit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to handLuggageLenghtLimit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function handLuggageWidthLimit_Callback(hObject, eventdata, handles)
% hObject    handle to handLuggageWidthLimit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of handLuggageWidthLimit as text
%        str2double(get(hObject,'String')) returns contents of handLuggageWidthLimit as a double
value = str2double(get(hObject,'String')); 
set(hObject,'UserData',value)


% --- Executes during object creation, after setting all properties.
function handLuggageWidthLimit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to handLuggageWidthLimit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function handLuggageDepthLimit_Callback(hObject, eventdata, handles)
% hObject    handle to handLuggageDepthLimit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of handLuggageDepthLimit as text
%        str2double(get(hObject,'String')) returns contents of handLuggageDepthLimit as a double
value = str2double(get(hObject,'String')); 
set(hObject,'UserData',value)


% --- Executes during object creation, after setting all properties.
function handLuggageDepthLimit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to handLuggageDepthLimit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function heighResult_Callback(hObject, eventdata, handles)
% hObject    handle to heighResult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value = str2double(get(hObject,'String'))  
set(hObject,'UserData',value)

% Hints: get(hObject,'String') returns contents of heighResult as text
%        str2double(get(hObject,'String')) returns contents of heighResult as a double


% --- Executes during object creation, after setting all properties.
function heighResult_CreateFcn(hObject, eventdata, handles)
% hObject    handle to heighResult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function widthResult_Callback(hObject, eventdata, handles)
% hObject    handle to widthResult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value = str2double(get(hObject,'String'))  
set(hObject,'UserData',value)

% Hints: get(hObject,'String') returns contents of widthResult as text
%        str2double(get(hObject,'String')) returns contents of widthResult as a double


% --- Executes during object creation, after setting all properties.
function widthResult_CreateFcn(hObject, eventdata, handles)
% hObject    handle to widthResult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dephResult_Callback(hObject, eventdata, handles)
% hObject    handle to dephResult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dephResult as text
%        str2double(get(hObject,'String')) returns contents of dephResult as a double


% --- Executes during object creation, after setting all properties.
function dephResult_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dephResult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function luggageApprobation_Callback(hObject, eventdata, handles)
% hObject    handle to luggageApprobation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of luggageApprobation as text
%        str2double(get(hObject,'String')) returns contents of luggageApprobation as a double


% --- Executes during object creation, after setting all properties.
function luggageApprobation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to luggageApprobation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over axes background.
function axes2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function heighDifferenceHL_Callback(hObject, eventdata, handles)
% hObject    handle to heighDifferenceHL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of heighDifferenceHL as text
%        str2double(get(hObject,'String')) returns contents of heighDifferenceHL as a double


% --- Executes during object creation, after setting all properties.
function heighDifferenceHL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to heighDifferenceHL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function widthDifferenceHL_Callback(hObject, eventdata, handles)
% hObject    handle to widthDifferenceHL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of widthDifferenceHL as text
%        str2double(get(hObject,'String')) returns contents of widthDifferenceHL as a double


% --- Executes during object creation, after setting all properties.
function widthDifferenceHL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to widthDifferenceHL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function depthDifferenceHL_Callback(hObject, eventdata, handles)
% hObject    handle to depthDifferenceHL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of depthDifferenceHL as text
%        str2double(get(hObject,'String')) returns contents of depthDifferenceHL as a double


% --- Executes during object creation, after setting all properties.
function depthDifferenceHL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to depthDifferenceHL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function widthDifferenceCB_Callback(hObject, eventdata, handles)
% hObject    handle to widthDifferenceCB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of widthDifferenceCB as text
%        str2double(get(hObject,'String')) returns contents of widthDifferenceCB as a double


% --- Executes during object creation, after setting all properties.
function widthDifferenceCB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to widthDifferenceCB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function depthDifferenceCB_Callback(hObject, eventdata, handles)
% hObject    handle to depthDifferenceCB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of depthDifferenceCB as text
%        str2double(get(hObject,'String')) returns contents of depthDifferenceCB as a double


% --- Executes during object creation, after setting all properties.
function depthDifferenceCB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to depthDifferenceCB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function heighDifferenceCB_Callback(hObject, eventdata, handles)
% hObject    handle to heighDifferenceCB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of heighDifferenceCB as text
%        str2double(get(hObject,'String')) returns contents of heighDifferenceCB as a double


% --- Executes during object creation, after setting all properties.
function heighDifferenceCB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to heighDifferenceCB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in speedPopupMenu.
function speedPopupMenu_Callback(hObject, eventdata, handles)
% hObject    handle to speedPopupMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns speedPopupMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from speedPopupMenu

value = get(hObject,'value') -1;
set(hObject,'UserData',value);


% --- Executes during object creation, after setting all properties.
function speedPopupMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to speedPopupMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
set(hObject,'string',{'Set Speed', 1, 2, 3, 4, 5});
set(hObject,'UserData',3);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    
end


% --- Executes on button press in editarAeronavePushbutton.
function editarAeronavePushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to editarAeronavePushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function airplaneModelText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to airplaneModelText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
airplaneService = AirplaneService(Airplane,AirplaneDAO);
airplaneSelected = airplaneService.getSelectedAirplane(airplaneService);
set(hObject,'string',airplaneSelected.model);
set(hObject,'UserData',airplaneSelected.model);



% --- Executes during object creation, after setting all properties.
function volumeRestanteBagageiroText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to volumeRestanteBagageiroText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'string',"0");
set(hObject,'UserData',0);


% --- Executes during object creation, after setting all properties.
function porcentagemPreenchidaPoraotext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to porcentagemPreenchidaPoraotext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'string',"0");
set(hObject,'UserData',0);


% --- Executes during object deletion, before destroying properties.
function quantidadeBagagensMedidasAprovadasTex_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to quantidadeBagagensMedidasAprovadasTex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object deletion, before destroying properties.
function qtdBagagenstext_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to qtdBagagenstext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function porcentagemPreenchidaBagageirotext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to porcentagemPreenchidaBagageirotext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
