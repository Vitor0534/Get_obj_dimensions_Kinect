%Infos: para executar esse programa, � necess�rio instalar as depend�ncias:
%       1 - image aquisition toolbox;
%       2 - kinect for matlab package;

% Executando o software:
%       1 - o ponto de entrada � o arquivo UserGui.m que � uma view
%       2 - antes de execut�-lo sertifique-se de adicionar todas as pastas
%       do diretorio raiz ao search path do matlab:
%             a. Basta abrir o diret�rio com o m�tlab, selecionar a pasta
%             na arvore de diret�rios, clicar com o bot�o direito e
%             adicionar tudo, inclusive as subpastas

%Dependendo do m�todo utilizado para medida, os dois seguintes packages devem ser
%adicionados
%       3 - Minimal Bounding Box    (https://www.mathworks.com/matlabcentral/fileexchange/18264-minimal-bounding-box)
%       4 - 2D minimal bounding box (https://www.mathworks.com/matlabcentral/fileexchange/31126-2d-minimal-bounding-box)



classdef LugaggeScanner
    properties  
        scannerParameters = ScannerParameters();
        scannerResults    = Results();
            
        
    end
    
    methods(Static)
        
        %Paso 0: chamada de fun��es
        function [result] = getLuggageDimensionsWithScannerAproach(luggageScannerObj)
            luggageScannerObj.scannerResults = getLuggageDimensionsWithScannerAproach(luggageScannerObj);
            result = luggageScannerObj.scannerResults;
        end
        
        function plotConvexHullOfPtCloud(pointCloud, convHull_K2_triangulation)
                [x,y,z] = format_Data(pointCloud);
                show_convexhull(convHull_K2_triangulation,x,y,z,'FaceColor','cyan'); 
        end
        
    end
end


%TestAllMesureMethods();
%testingROIVideoInput();

%testa os m�todos de m�dida em sequ�ncia
function TestAllMesureMethods()
%disp("resultados AABB:")
%test_AABB();
%disp("resultados OMBB:")
%test_MBB();
disp("resultados OMBB 3D:")
test_OMBB_3D();
end



%a presente fun��o � baseada no m�todo AABB
%----retorno: largura, comprimento e profundidade do objeto
%passos: 1) tratamento da point cloud, 2) adapta��o dos dados para 2D, 3) aplica��o
%do m�todo
function [height,width,depth] = test_AABB()
%pegando o vari�vel do workspace
   ptCloud = evalin('base','ptCloudB');
   background_Distance = 1.1;
   cut_value = 0.07;
    
   plotPointCloud_Static(ptCloud);
   
   ptCloud = ptCloud_processing(ptCloud, background_Distance, cut_value);
   
   [height, width, depth] = get_boundingBox_AABB(ptCloud, background_Distance) %AABB 3D
   
   mensurements = sort([(height(2)-height(1))*100 (width(2)-width(1))*100 (depth(2)-depth(1))*100]);
   Hight_AABB = mensurements(3)
   Width_AABB = mensurements(2)
   Depth_AABB = mensurements(1)
   
end



%a presente fun��o � baseada no m�todo Minimum_Bounding_Box(ptCloud) (OMBB 2D)
%----retorno: largura, comprimento e profundidade do objeto
%passos: 1) tratamento da point cloud, 2) adapta��o dos dados para 2D, 3) aplica��o
%do m�todo
function [height,width,depth] = test_MBB()
%pegando o vari�vel do workspace
   ptCloud = evalin('base','ptCloudB');
   background_Distance = 1.1;
   cut_value = 0.07;
   
   plotPointCloud_Static(ptCloud);
   
   ptCloud = ptCloud_processing(ptCloud, background_Distance, cut_value);
   
   [bBox,minDepth] = Minimum_Bounding_Box(ptCloud); %OMBB 2D
   
   height_OMBB = sqrt((bBox(1,2) - bBox(1,3))^2 + (bBox(2,2) - bBox(2,3))^2)*100
   width_OMBB = sqrt((bBox(1,1) - bBox(1,2))^2 + (bBox(2,1) - bBox(2,2))^2)*100
   depth_OMBB = (background_Distance - minDepth)*100
   volume_OMBB = (height_OMBB*width_OMBB*depth_OMBB)/(100^3)
   
   convexhull_ptCloud_matriz_coluna(ptCloud,background_Distance);
   
end


%a presente fun��o � baseada no m�todo minboundbox() (OMBB 3D)
%----retorno: largura, comprimento e profundidade do objeto
%passos: 1) tratamento da point cloud, 2) adapta��o dos dados, 3) aplica��o
%do m�todo
function [height,width,depth] = test_OMBB_3D()
%pegando o vari�vel do workspace
   ptCloud = evalin('base','ptCloudB');
   background_Distance = 1.1;
   cut_value = 0.07;
    
   plotPointCloud_Static(ptCloud);
   
   ptCloud = ptCloud_processing(ptCloud, background_Distance, cut_value);
   
   %OMBB 3D
   [rotmat,cornerpoints,volume_OMBB3D,surface] = minboundbox(double(ptCloud(:,1)),double(ptCloud(:,2)),double(ptCloud(:,3)),'v',1); 
   
   plot3(double(ptCloud(:,1)),double(ptCloud(:,2)),double(ptCloud(:,3)),'b.');
   hold on;
   plotminbox(cornerpoints,'r');
   
   
   Mensurement1 = sqrt(((cornerpoints(1,1)-cornerpoints(2,1))^2+(cornerpoints(1,2)-cornerpoints(2,2))^2+(cornerpoints(1,3)-cornerpoints(2,3))^2))*100;
   Mensurement2 = sqrt(((cornerpoints(2,1)-cornerpoints(3,1))^2+(cornerpoints(2,2)-cornerpoints(3,2))^2+(cornerpoints(2,3)-cornerpoints(3,3))^2))*100;
   Mensurement3 = sqrt(((cornerpoints(1,1)-cornerpoints(5,1))^2+(cornerpoints(1,2)-cornerpoints(5,2))^2+(cornerpoints(1,3)-cornerpoints(5,3))^2))*100;
    
   mensurements = sort([ Mensurement1 Mensurement2 Mensurement3]);
   height_OMBB3D = mensurements(3)
   width_OMBB3D = mensurements(2)
   depth_OMBB3D = mensurements(1)
    
   volume_OMBB3D
   %volume2 = (height*width*depth)/(100^3)
   
   convexhull_ptCloud_matriz_coluna(ptCloud,background_Distance);
    
    
   
end


function [results] = getLuggageDimensionsWithScannerAproach(luggageScannerObj)

   try
       
    %Pt1: mostrando algumas informa��es dos sensores 
        disp("\ninforma��o dos adaptadores instalados\n");
        imaqhwinfo
        disp("\n*************************************");
        imaqhwinfo('kinect')
        imaq.VideoDevice('kinect',1)

    %****************************************************
    %comentei umas partes para usar a workspace, descomente para voltar a tempo real

    %PT2: Criando instancia dos objetos de cor e profundidade do kinect*********
        colorDevice = imaq.VideoDevice('kinect',1);
        depthDevice = imaq.VideoDevice('kinect',2);
    %************************************************************
    
    %PT3: inicializa o sensor kinect:
        colorDevice();
        depthDevice();
    %********************************
    
    %PT3.5:configurando arduino
         arduinoObj = ArduinoService;
         arduinoObj = arduinoObj.constructor('COM3',9600, arduinoObj);
         arduinoObj = arduinoObj.setup('connect',arduinoObj);
    %*********************************

   
    %PT4: captura 1 frame do kinect para inicializar
        colorImage = colorDevice();
        depthImage = depthDevice();
    %********************************

    %Pt5: extrai a point cloud
    %essa � uma instancia da class pointCloud, gerada com os dados xyzPoints 
    %contruidos na pcfromkinect. ele contem diversos parametros
    %o parametro location � a matriz m-by-n-by-3 que s�o os pontos

    %ptCloud = pcfromkinect(depthDevice, depthImage,colorImage);
    %ptCloud = pcfromkinect(depthDevice, depthImage);




    %definindo uma regi�o de interesse para evitar coletar outliers dos cantos
    
    %Rois para amostragem est�tica
    
    %roi = [-0.2645, 0.2125, -0.285, 0.35, 0, inf]
    %roi = [-0.3, 0.2, -0.3, 0.3, 0, inf]
    %roi = [-0.3, 0.1, -0.3, 0.3, 0, inf]           %--> �rea adequada (original - sem esteira)
    %roi = [-0.28, 0.08, -0.2, 0.2, 0, inf]         %--> �rea adequada (original - com esteira)
    %roi = [-0.2, 0.0, -0.103, 0.12, 0, inf]
    %roi = [-0.25, 0.18, -0.08, 0.07, 0, inf]       %--> teste para limitar scanneamento (slice - com esteira)
    
    
    %Rois para amostragem m�vel
 
    %roi= [-0.25, 0.18, -0.01, 0, 0, inf]           %--> teste para limitar scanneamento (slice - com esteira) comprimento = 0.01,largura = 0,43 (resultado bons)
    %roi= [-0.275, 0.205, -0.01, 0, 0, inf]         %--> teste para limitar scanneamento (slice - com esteira) comprimento = 0.01,largura = 0,48
    %roi = [-0.25, 0.18, -0.03, 0.02, 0, inf]       %--> teste para limitar scanneamento (slice - com esteira) comprimento = 0.05,largura = 0,43
    
    %roi = [-0.25, 0.18, -0.035, 0.025, 0, inf]     %--> teste para limitar scanneamento (slice - com esteira) comprimento = 0.06,largura = 0,43 
    roi = [-0.275, 0.205, -0.0375, 0.0275, 0, inf]  %--> teste para limitar scanneamento (slice - com esteira) comprimento = 0.065,largura = 0,48(resultado bons) <-
    %roi = [-0.285, 0.215, -0.0375, 0.0275, 0, inf] %--> teste para limitar scanneamento (slice - com esteira) comprimento = 0.065,largura = 0,50(resultado bons)
    %roi = [-0.25, 0.18, -0.04, 0.03, 0, inf]       %--> teste para limitar scanneamento (slice - com esteira) comprimento = 0.07,largura = 0,43
    
    %roi = [-0.285, 0.215, -0.02, 0.01, 0, inf]     %--> teste para limitar scanneamento (slice - com esteira) comprimento = 0.03,largura = 0,50
    %roi = [-0.285, 0.215, -0.03, 0.02, 0, inf]     %--> teste para limitar scanneamento (slice - com esteira) comprimento = 0.05,largura = 0,50
    %roi = [-0.285, 0.215, -0.035, 0.025, 0, inf]   %--> teste para limitar scanneamento (slice - com esteira) comprimento = 0.06, largura = 0,50 (resultado bons)
    %roi = [-0.335, 0.265, -0.035, 0.025, 0, inf]   %--> teste para limitar scanneamento (slice - com esteira) comprimento = 0.06, largura = 0,70

    
    scannerParameters = luggageScannerObj.scannerParameters;
    
    scannerParameters.background_Distance           = 1.13;
    scannerParameters.cut_value                     = 0.05;            %dist�ncia para segmentar a mala do fundo
    scannerParameters.step                          = 0.065;           %passo de amostragem
    scannerParameters.sample_rate                   = 25;               %hz
    scannerParameters.ROI                           = roi;             %[xmin xmax ymin ymax zmin zmax]
    scannerParameters.scanningMethod                = "Static";
    scannerParameters.objectDetectionPrecision      = 10;
    scannerParameters.arduinoService                = arduinoObj;
    
    scannerParameters.arduinoService.setMatSpeedByPreSelectedOption(scannerParameters.arduinoService, scannerParameters.matSpeed);
    scannerParameters.arduinoService.arduinoMatControl(scannerParameters.arduinoService, scannerParameters.matDirection);
    scannerParameters.arduinoService.arduinoMatControl(scannerParameters.arduinoService, 'set_pwmControlReason', scannerParameters.matPwmControlReason);
    
%     background_Distance = 1.1;
%     cut_value = 0.05;            %dist�ncia para segmentar a mala do fundo
%     step = 0.065;                %passo de amostragem
%     sample_rate = 30;            %hz
    
    %background_Distance = 1.27;
    %cut_value = 0.07;
    %step = 0.065;
    %sample_rate = 20; %hz
    
    

%     background_Distance = 1.47;
%     step = 0.062;
%     cut_value = 0.05;
%     sample_rate = 5; %hz
    
    %PT6: plotando a point cloud para visualiza��o
        plotPointCloud(colorDevice,depthDevice,0,roi);



    %PT 7: extraindo as dimens�es do objeto pela point cloud
     %ROI ajustado: [-0.3, 0.1, -0.2, 0.2, 0, inf]
     %[hight, width, depth,ptCloudB] = pc_Object_Dimension_Extract_OP2(ptCloud,background_Distance,roi);
     
     [results] = pc_Object_Dimension_scanner(depthDevice,colorDevice,scannerParameters);
    
     
     %plotando convexhull da point cloud obtida
%      [x,y,z] = format_Data(results.pointCloudCapturadaTratada);
%      show_convexhull(results.convHull_K2_triangulation,x,y,z,'FaceColor','cyan');
           

        
     %plotando point cloud est�tica
%      plotPointCloud_Static(results.pointCloudCapturadaSemTratamento);
%      plotPointCloud_Static(results.pointCloudCapturadaTratada);

     %Mostrando resultados:
      print_result_datas(results)
      
      
      
      %PT8:
      %para que n�o ocorra um erro em uma nova execu��o tem que para a
      %aquisi��o de frames uma forma de fazer isso � deletando os objetos de
      %aquisi��o instanciados
      delete(colorDevice);
      delete(depthDevice);
        
      arduinoObj.setup('disconnect',arduinoObj);
        
        
    catch error
        disp("Erro na fun��o: getLuggageDimensionsWithScannerAproach");
        disp(error);
        delete(colorDevice);
        delete(depthDevice);
        
        arduinoObj.setup('disconnect',arduinoObj);
    end
 
end
 
 

%*********************************************************************
 
 
 function method_2_environment_variables()
 
    %pegando o vari�vel do workspace
    ptCloud = evalin('base','ptCloud');

    %teste para verificar os pontos
    x="matriz de pontos"
    xyzPoints = ptCloud.Location(1:50,1:50,:);
    xyzPoints = ~isnan(xyzPoints(:,:,:)); %retorna uma matriz com valores l�gicos

    %definindo uma regi�o de interesse para evitar coletar outliers dos cantos
    %roi= [-0.3, 0.2, -0.3, 0.3, 0, inf]
    %roi= [-0.3, 0.1, -0.2, 0.2, 0, inf] --> original
    roi= [-0.2, 0.0, -0.103, 0.12, 0, inf]
    %roi= [-0.2, 0.0, -0.99, 0.0, 0, inf] %--> teste para limitar scanneamento

    %plotando point cloud est�tiva
        plotPointCloud_Static(ptCloud);


     %ROI ajustado: [-0.3, 0.1, -0.2, 0.2, 0, inf]
     [hight, width, depth,ptCloudB] = pc_Object_Dimension_Extract_OP2(ptCloud,1.1,roi)

     %%calculando altura, largura, profundidade e volume

     Hight_b_cm = (hight(2)-hight(1))*100
     Width_b_cm = (width(2)-width(1))*100
     Depth_b_cm = (depth(2)-depth(1))*100
     Volume_m3 = (Hight_b_cm/100) * (Width_b_cm/100) * (Depth_b_cm/100)


     %visualizando imagem de profundidade
    %     title('imagem RGB')
    %     imshow(colorImage);
    %     figure();
    %     imshow(255*(depthImage>255))
    %     title('imagem de profundidade')


      %plotando point cloud est�tica
        plotPointCloud_Static(ptCloudB);

      %aplicando convex hull na ptCloud
       %[k2,av2] = convexhull_ptCloud(ptCloud,1.1,roi)
        [k2,av2]=convexhull_ptCloud_matriz_coluna(ptCloudB,1.1,roi);
        av2
 end
  
 
%fun��o para visualizar a point cloud em tempo real
function plotPointCloud(colorDevice,depthDevice, color,roi)
    try
        %captura 1 framde do kinect
        colorImage = colorDevice();
        depthImage = depthDevice();
        %********************************

        % Initialize a player to visualize 3-D point cloud data. The axis is
        % set appropriately to visualize the point cloud from Kinect.
          ptCloud = pcfromkinect(depthDevice, depthImage, colorImage);

          player = pcplayer(ptCloud.XLimits, ptCloud.YLimits, ptCloud.ZLimits,...
                      'VerticalAxis', 'y', 'VerticalAxisDir', 'down');

          xlabel(player.Axes, 'X (m)');
          ylabel(player.Axes, 'Y (m)');
          zlabel(player.Axes, 'Z (m)');

          roiTime = 0;

          %%Acquire and view Kinect point cloud data.
          while (isOpen(player))

             depthImage = depthDevice();

             if(color)
                colorImage = colorDevice();
                ptCloud = pcfromkinect(depthDevice, depthImage, colorImage);
             else
                ptCloud = pcfromkinect(depthDevice, depthImage);
             end

             if(size(roi,1)~=0)
                 tic
                 indices = findPointsInROI(ptCloud,roi);
                 ptCloudB = select(ptCloud, indices);
                 view(player, ptCloudB);
                 roiTime = toc;
             else
                 view(player, ptCloud);
             end
          end
          roiTime
     catch error
            disp("Erro na fun��o: plotPointCloud(colorDevice,depthDevice, color,roi)");
            disp(error);
            delete(colorDevice);
            delete(depthDevice);
     end
end
 
function plotPointCloud_Static(ptCloud)

  if(isobject(ptCloud))
        player = pcplayer(ptCloud.XLimits, ptCloud.YLimits, ptCloud.ZLimits,...
              'VerticalAxis', 'y', 'VerticalAxisDir', 'down');
  else
        player = pcplayer([min(ptCloud(:,1)) max(ptCloud(:,1))], [min(ptCloud(:,2)) max(ptCloud(:,2))], [min(ptCloud(:,3)) max(ptCloud(:,3))],...
              'VerticalAxis', 'y', 'VerticalAxisDir', 'down');
  end

  
  xlabel(player.Axes, 'X (m)');
  ylabel(player.Axes, 'Y (m)');
  zlabel(player.Axes, 'Z (m)');
  while (isOpen(player))
    view(player, ptCloud);
  end
end


%*************************************
% fun��o que rastreia a matriz de pontos linha por linha
% background_Distance: � utilizado para verificar qualquer saliencia 
%                      no eixo Z, que significa a presen�a de um objeto
%hight (Y): � a altura do objeto, tem um valor min e max, que s�o os pontos da
%        extremidade do objeto
%width (X): largura do objeto, tem um valor min e max, que s�o os pontos das
%       extremidados orizontais do objeto;
%depth: � o Profundidade, o maior valor encontrado no objeto para o
%        eixo z

%matriz MxNxK
function [hight, width, depth] = get_Object_Dimension_With_AABB(ptCloud,background_Distance,roi)
    
    %coletando a matriz de pontos
    indices = findPointsInROI(ptCloud, roi);
    ptCloudB = select(ptCloud, indices);
    
    xyzPoints = ptCloudB.Location;
    
    %limpando a matriz de pontos (tirar valores invalidos)
    %xyzPoints = ~isnan(xyzPoints(:,:,:));
    
    width=[0,0];  %x
    hight=[0,0];  %y
    depth=[0,background_Distance]; %z
    
    for i=1:size(xyzPoints,1)
        for j=1:size(xyzPoints,2)
            %xyzPoints(i,j,3)
           if(xyzPoints(i,j,3)<background_Distance)
               
               %Rastreia o comprimento
               if(xyzPoints(i,j,3)<depth(1) || depth(1)==0)
                   depth(1)=xyzPoints(i,j,3);
               end
               
               %Rastreia a largura
               if(width(1)==0)
                   width(1)=xyzPoints(i,j,1);
               elseif(xyzPoints(i,j,1)>width(2))
                   width(2)=xyzPoints(i,j,1);
               end
               
               %Rastreia a altura
               if(hight(1)==0)
                   hight(1)=xyzPoints(i,j,2);
               elseif(xyzPoints(i,j,2)>hight(2))
                   hight(2)=xyzPoints(i,j,2);
               end
           end
        end
    end


end
  

%Matix Mx3
function [hight, width, depth,ptCloudB] = get_Object_Dimension_With_AABB_OP2(ptCloud,background_Distance,roi)
    
    %coletando a matriz de pontos
    indices = findPointsInROI(ptCloud, roi);
    ptCloudB = select(ptCloud, indices);
    
    xyzPoints = ptCloudB.Location;
    
    %limpando a matriz de pontos (tirar valores invalidos)
    %xyzPoints = ~isnan(xyzPoints(:,:,:));
    
    width=[0,0];  %x
    hight=[0,0];  %y
    depth=[0,background_Distance]; %z
    
    for i=1:size(xyzPoints,1)

           if(xyzPoints(i,3)<background_Distance)
               
               %Rastreia a profundidade 
               if(xyzPoints(i,3)<depth(1) || depth(1)==0)
                   depth(1)=xyzPoints(i,3);
               end
               
               %Rastreia a largura
               if(width(1)==0)
                   width(1)=xyzPoints(i,1);
               elseif(xyzPoints(i,1)>width(2));
                   width(2)=xyzPoints(i,1);
               end
               
               %Rastreia a altura
               if(hight(1)==0)
                   hight(1)=xyzPoints(i,2);
               elseif(xyzPoints(i,2)>hight(2));
                   hight(2)=xyzPoints(i,2);
               end
           end
        
    end


end



%fun��o para coletar dados de dimens�es em tempo real, na esteira
% A ideia � utilizar a mesma l�gica da fun��o est�tica, por�m coletando
% frames de point cloud de acordo com uma taxa de amostragem. Alguns 
% requisitos s�o os seguinte:
%   * Definir um roi que seja curto e tenha uma boa largura, para coletar
%     slices da point cloud;
%   * O objeto est� em movimento na esteira, � necess�rio coletar
%     informa��es de X,Y e Z, para cada slice identificar quando o objeto
%     passou por completo pela area de a��o definida com o roi
%           - Pode-se utilizar a taxa de amostragem para fazer essa
%           verifica��o, por exemplo:
%              .EX: if(Numero_Amostras==3 && Objeto_N�o_Presente) -->
%              assume que o objeto passou pelo "scanner" --> retorna dados
%   * � preciso definir uma taxa de amostagem global e utilizar um delay
%     para simular fun��o: pause(n), n � em segundos
%   * Obs: a forma de obter hight � diferente nesse caso. � necess�rio
%   levar em conta que a �rea de scanner � fixa e o objeto que se move,
%   logo, as seguintes 3 situa��es ocorrem:
%            - Situa��o 1: o Z se obtem como da forma anterior;
%            - Situa��o 2: o X se obtem como da forma anterior;
%            - Situa��o 3: o Y, deve ser obtido somando os passos (steps) da
%                          amostragem enquanto existir objeto na �rea do
%                          scanner.
%
%Para o convexhull: 
% estrat�gia 1: para aplic�-lo � necess�rio coletar os slices e iterativamente 
%               concatenar a matrix para forma uma point cloud total do obj
% estrat�gia 2: aplicar o convex, slice por slice, e somar o volume de
%               todos eles para objeter o volume final do objeto


%To REFACTOR: confira se � poss�vel retirar o dimensions_Check


function [results] = pc_Object_Dimension_scanner(depthDevice,colorDevice, scannerParameters)
    
    background_Distance      = scannerParameters.background_Distance;
    step                     = scannerParameters.step;
    cut_value                = scannerParameters.cut_value;
    sample_rate              = scannerParameters.sample_rate;
    method                   = scannerParameters.scanningMethod;
    roi_Slice                = scannerParameters.ROI;
    objectDetectionPrecision = scannerParameters.objectDetectionPrecision;
    arduinoService               = scannerParameters.arduinoService;

    width=[0,0];                                     %x
    height=[0,0];                                    %y
    depth=[background_Distance,background_Distance]; %z
    
    dimensions_Check=0;
    break_flag=0;
    
    
    xyzPoints = aply_roi_PtCloud(get_Pt_Cloud_Frame(depthDevice,colorDevice,0),roi_Slice).Location;
    
    %A matrix resultante � inicializada com 30 vezes o tamanho de uma
    %amostra. � uma estrat�gia para reduzir tempo de armazenamento de dados
    %no matlab
    ptCloud_of_the_object_interated = NaN(size(xyzPoints,1)*30,size(xyzPoints,2));
    
    number_of_Obj_samples = 0;
    startTimeSample       = tic;
    
    try
        
        disp("Iniciando Medida da Bagagem...");
        
        
        arduinoService.arduinoMatControl(arduinoService, 'run');
        
        samplePosition  = 1;
        while(break_flag<=10)

            %coletando frames da matriz de pontos
            ptCloudB = aply_roi_PtCloud(get_Pt_Cloud_Frame(depthDevice,colorDevice,0),roi_Slice);
            xyzPoints = ptCloudB.Location;


            is_there_Object = check_for_object(xyzPoints, objectDetectionPrecision, background_Distance, cut_value);
    
            if(is_there_Object)
                
                if(number_of_Obj_samples==0)
                    startTimeSample = tic;
                end
                
                dimensions_Check = 0;
                break_flag = 0;

               
                %Se a point cloud � adquirida no sentido hor�rio colocar (-) se n�o colocar (+)
                ptCloud_of_the_object_interated(samplePosition:1:(samplePosition-1) + size(xyzPoints,1), 1:1:size(xyzPoints,2)) = (xyzPoints(:,:) - [0 (step*(number_of_Obj_samples+1)) 0]);
                samplePosition = samplePosition + size(xyzPoints,1);

                number_of_Obj_samples = number_of_Obj_samples +1;
            
            
            elseif(dimensions_Check>=3)

                break_flag = break_flag + 1
                
            else
                dimensions_Check=dimensions_Check+1;
            end
           
           pause(1/sample_rate); 

        end
        
        tempo_amostragem = toc(startTimeSample);
        
        
        arduinoService.arduinoMatControl(arduinoService, 'stop');
        
        
        ptCloud_of_the_object_interated = ptCloud_of_the_object_interated(~isnan(ptCloud_of_the_object_interated(:,1)),~isnan(ptCloud_of_the_object_interated(1,:)));
        
        
        
    
        
        inicio_tempo_tratamento_ptCloud = tic;
        
        ptCloudProcessed = ptCloud_processing(ptCloud_of_the_object_interated, background_Distance, cut_value);
        
        tempo_tratamento_ptCloud = toc(inicio_tempo_tratamento_ptCloud);

        
       
        
        %M�todo AABB - testado
        
        inicio_tempo_medida_AABB = tic;
        [height, width, depth] = get_boundingBox_AABB(ptCloudProcessed, background_Distance);
        tempo_medida_AABB = toc(inicio_tempo_medida_AABB);

        mensurements = sort([(height(2)-height(1))*100 (width(2)-width(1))*100 (depth(2)-depth(1))*100]);
        Hight_AABB = mensurements(3);
        Width_AABB = mensurements(2);
        Depth_AABB = mensurements(1);
        
        
      
        
        %M�todo MBB - testado
        
        
        inicio_tempo_medida_OMBB = tic;
        
        [heightMBB, widthMBB, depthMBB,volume] = get_Object_dimensions_to_ptC_with_MBB(ptCloudProcessed, background_Distance);
        
        tempo_medida_OMBB = toc(inicio_tempo_medida_OMBB);
        
        heightMBB = heightMBB*100;
        widthMBB = widthMBB*100;
        depthMBB= depthMBB*100;
        volume_MBB = volume*100^3;
        
        
        %M�todo OMBB 3D - testado
        
        inicio_tempo_medida_OMBB3D = tic;
        [height_OMBB3D, width_OMBB3D, depth_OMBB3D, volume_OMBB3D] = get_dimensions_with_OMBB_3D(ptCloudProcessed, 'v', 1);
        
        tempo_medida_OMBB3D = toc(inicio_tempo_medida_OMBB3D);


%         disp("As dimens�es para cada m�todo s�o [largura X altura X profundidade]]:");
%         
%         disp("mensurement_AABB:")
%         disp(" ")
%         volume_AABB = (Width_AABB*Hight_AABB*Depth_AABB)/100^3;
%         disp(Width_AABB + " X " + Hight_AABB + " X " + Depth_AABB + " | " + volume_AABB);
%         
%         disp(" ")
%         disp("mensurement_OMBB:")
%         disp(" ")
%         disp(widthMBB + " X " +  heightMBB + " X " + depthMBB + " | " + volume_MBB/100^3);
%         
%         disp(" ")
%         disp("mensurement_OMBB_3D:")
%         disp(" ")
%         disp(width_OMBB3D + " X " + height_OMBB3D + " X " + depth_OMBB3D + " | " + volume_OMBB3D);
%         disp(" ")
%         
%         tempo_de_flag = 6;
%         
%         disp("O tempo de amostragem foi: " + (tempo_amostragem-tempo_de_flag) + "s"); % a contagem de flag demora 6 segundos
%         disp("O tempo de tratamento da ptCloud foi: " + tempo_tratamento_ptCloud + "s");
%         disp("O tempo de medida com AABB foi: " + (tempo_medida_AABB + (tempo_amostragem-tempo_de_flag) + tempo_tratamento_ptCloud) + "s");
%         disp("O tempo de medida com OMBB foi: " + (tempo_medida_OMBB + (tempo_amostragem-tempo_de_flag) + tempo_tratamento_ptCloud)+ "s");
%         disp("O tempo de medida com OMBB 3D foi: " + (tempo_medida_OMBB3D + (tempo_amostragem-tempo_de_flag) + tempo_tratamento_ptCloud) + "s");
%         disp("A quantidade de amostras foi: " + number_of_Obj_samples);
%         
        results = Results;
        
        results.Height                            = heightMBB;
        results.Width                             = widthMBB;
        results.Depth                             = depthMBB;
        results.tempo_amostragem                  = tempo_amostragem;
        results.tempo_tratamento_ptCloud          = tempo_tratamento_ptCloud;
        results.tempo_medida                      = tempo_medida_OMBB;
        results.quantidade_de_amostras            = number_of_Obj_samples;
        results.pointCloudCapturadaSemTratamento  = ptCloud_of_the_object_interated;
        results.pointCloudCapturadaTratada        = ptCloudProcessed;
        [k2,av2]                                  = get_convexhull_K_Trinagulation(ptCloudProcessed);
        results.convHull_K2_triangulation         = k2;
        results.convHull_Av2_Volume               = av2;
        
        
        
       
        %para que n�o ocorra um erro em uma nova execu��o tem que parar a
        %aquisi��o de frames. Uma forma de fazer isso � deletando os objetos de
        %aquisi��o instanciados
        delete(colorDevice);
        delete(depthDevice);
      
    catch error
        disp("Erro na fun��o: pc_Object_Dimension_scanner");
        disp(error);
        delete(colorDevice);
        delete(depthDevice);
    end
end



function print_result_datas(results)
        disp("Bagagem medida com sucesso...");
        disp("As dimens�es s�o [altura X largura X profundidade]:");
        
        disp(results.Height + " X " + results.Width + " X " + results.Depth);

        tempo_de_flag = 6;
        
        disp(" ");
        disp("O tempo de amostragem foi: " + (results.tempo_amostragem-tempo_de_flag) + "s"); % a contagem de flag demora 6 segundos
        disp("O tempo de tratamento da ptCloud foi: " + results.tempo_tratamento_ptCloud + "s");
        disp("O tempo de extra��o das dimens�es foi: " + results.tempo_medida + "s");
        disp("O tempo de medida total foi: " + (results.tempo_medida + (results.tempo_amostragem-tempo_de_flag) + results.tempo_tratamento_ptCloud)+ "s");
        disp("A quantidade de amostras foi: " + results.quantidade_de_amostras);
end


function [number] = meters_to_centimeters(number)
    number=number*100;
end


function [k2,av2] = get_convexhull_K_Trinagulation(ptCloud_of_the_object_interated)
    if(~isnan(ptCloud_of_the_object_interated(1,:)))
         [k2,av2] = convexhull_ptCloud_matriz_coluna(ptCloud_of_the_object_interated);
    end
end


function [height, width, depth,is_there_Object] = get_Object_dimensions_to_ptc_column(xyzPoints, height, width, depth, method,step,Obj_detect_precision)
     
     is_there_Object = 0;
     did_it_get_a_step = 0;

     for i=1:size(xyzPoints,1)
               %is_there_Object = check_for_object(xyzPoints(i,:),Obj_detect_precision,depth(2),0);
               %if(is_there_Object)
                   
                   %Rastreia a profundidade 
                   if(xyzPoints(i,3)<depth(1))
                       depth(1)=xyzPoints(i,3);
                   end

                   %Rastreia a largura
                   if(xyzPoints(i,1) < width(1))
                       width(1)= xyzPoints(i,1);
                   elseif(xyzPoints(i,1)>width(2))
                       width(2)=xyzPoints(i,1);
                   end

                   %Rastreia a altura
                   if(method=="scanner" && ~did_it_get_a_step)
                       height(2)= height(2) + step;
                       did_it_get_a_step=1;
                   else
                       height = get_height(xyzPoints, height, i);
                   end
               %end
     end
     
end

function [is_there_Object] = check_for_object(xyzPoints, precision, background_Distance, cut_value)
    is_there_Object = sum(sum((xyzPoints(1:precision:size(xyzPoints,1),3) < (background_Distance-cut_value))));
end

function [height] = get_height(xyzPoints, height, i)
     if(xyzPoints(i,2) < height(1))
        height(1)=xyzPoints(i,2);
     elseif(xyzPoints(i,2)>height(2))
        height(2)=xyzPoints(i,2);
     end
end


function [height, width, depth] = get_boundingBox_AABB(xyzPoints, background_Distance)
    height =  [min(xyzPoints(:,2)),max(xyzPoints(:,2))];
    width  =  [min(xyzPoints(:,1)),max(xyzPoints(:,1))];
    depth  =  [min(xyzPoints(:,3)),background_Distance];
end


function [ptCloudB] = aply_roi_PtCloud(ptCloud,roi)
    indices = findPointsInROI(ptCloud, roi);
    ptCloudB = select(ptCloud, indices);
end


function [k2,av2] = convexhull_ptCloud_MxN(ptCloud)

xyzPoints = ptCloud.Location;
x(1:size(xyzPoints,1)*size(xyzPoints,2))=0;
y(1:size(xyzPoints,1)*size(xyzPoints,2))=0;
z(1:size(xyzPoints,1)*size(xyzPoints,2))=0;

indice_vetor=1;
for i=1:size(xyzPoints,1)
    for j=1:size(xyzPoints,2)
        if(~isnan(xyzPoints(i,j,:)))
        x(indice_vetor)=xyzPoints(i,j,1);
        y(indice_vetor)=xyzPoints(i,j,2);
        z(indice_vetor)=xyzPoints(i,j,3);
        indice_vetor = indice_vetor+1;
        end
    end
end

[k2,av2] = convhull(x,y,z,'Simplify',true);
trisurf(k2,x,y,z,'FaceColor','cyan')
axis equal

end

function [k2,av2] = convexhull_ptCloud_matriz_coluna(ptCloud)

[x,y,z] = format_Data(ptCloud);
[k2,av2] = convhull(x,y,z,'Simplify',true);
%[k2,av2] = convhull(xyzPoints(:,1),xyzPoints(:,2),xyzPoints(:,3),'Simplify',true);
end


function [x,y,z] = format_Data(ptCloud)
    
    xyzPoints = get_ptCloud_matrix(ptCloud);

    %x(1:size(xyzPoints,1))=0;
    %y(1:size(xyzPoints,1))=0;
    %z(1:size(xyzPoints,1))=0;
    
    x = double(xyzPoints(:,1));
    y = double(xyzPoints(:,2));
    z = double(xyzPoints(:,3));
    

%     indice_vetor=1;
%     for i=1:size(xyzPoints,1)
%         if(~isnan(xyzPoints(i,:)))
%             x(indice_vetor)=xyzPoints(i,1);
%             y(indice_vetor)=xyzPoints(i,2);
%             z(indice_vetor)=xyzPoints(i,3);
%             indice_vetor = indice_vetor+1;
%         end
%     end
end


function [xyzPoints] = get_ptCloud_matrix(ptCloud)
    if(isobject(ptCloud))
        xyzPoints = ptCloud.Location;
    else
        xyzPoints = ptCloud;
    end
end 

function show_convexhull(k2,x,y,z,FaceColor,color)
    trisurf(k2,x,y,z,FaceColor,color);
    figure();
    axis equal;
end

function [ptCloud] = get_Pt_Cloud_Frame(depthDevice,colorDevice, color)
     if(color)
        depthImage = depthDevice();
        colorImage = colorDevice();
        ptCloud = pcfromkinect(depthDevice, depthImage, colorImage);
     else
        depthImage = depthDevice();
        ptCloud = pcfromkinect(depthDevice, depthImage);
     end
end



%o processo � feito em dois passos:
%   1- corta o fundo usando a medida conhecida background_Distance
%   2- pega o ponto da matriz obtida na amostragem e reflete na base (cria um ponto 
%      no mesmo xy so que z == background_distance).
%      isso vai gerar uma superf�cie para a base e auxiliar o convexhull 
%      a obter o volume total do objeto
function [xyzPoints_result] = ptCloud_processing(ptCloud, background_Distance, cut_value)
    
    xyzPoints = get_ptCloud_matrix(ptCloud);
    xyzPoints_result = [0 0 0];
    
    xyzPoints_Amount_rows = size(xyzPoints,1);
    
%     plotPtCloud(xyzPoints, 'Point cloud de entrada');
%     x=1
    
    
    %Segmentando e adiciponando base na point cloud
    for i=1:xyzPoints_Amount_rows
            if((xyzPoints(i,3) <= (background_Distance - cut_value)))
                xyzPoints_result = [xyzPoints_result; xyzPoints(i,:); [xyzPoints(i,1) xyzPoints(i,2)  background_Distance]];
            end
    end
    
    if(xyzPoints_Amount_rows>=2)
        xyzPoints_result(1,:) = xyzPoints_result(2,:);
    end
   
%     ptCloud_segmented = xyzPoints_result;
%     plotPtCloud(xyzPoints_result, 'PtCloud segmentada');
%     x=1
    
    
   %Subamostrando a point cloud
   xyzPoints_result = pcdownsample(pointCloud(xyzPoints_result),'gridAverage',0.01);
   
%    plotPtCloud(xyzPoints_result, 'PtCloud subamostrada');
%    x=1
   
   
   %Retirando ruidos sutis da point cloud
   xyzPoints_result = pcdenoise(xyzPoints_result);
   xyzPoints_result = pcdenoise(xyzPoints_result);
   xyzPoints_result = pcdenoise(xyzPoints_result);
   xyzPoints_result = pcdenoise(xyzPoints_result);

   xyzPoints_result = pcdenoise(xyzPoints_result, "Threshold",1,"NumNeighbors",3).Location;
 
%    plotPtCloud(xyzPoints_result, 'Point cloud Filtrada');
%    plotPtCloud(xyzPoints_result, 'Point cloud Filtrada');
%    x=1
   
   
%    [x,y,z] = format_Data(xyzPoints_result);
%    [k2,~] = convhull(x,y,z,'Simplify',true);
%    %plotPtCloud(xyzPoints_result([k2(:,1) k2(:,2) k2(:,3)]), 'Pontos de convex hull');
%    show_convexhull(k2,x,y,z,'FaceColor','cyan')
%    x= 1
%     
%    
%    %ComparePtCloud(pointCloud(xyzPoints_result), pointCloud(ptCloud_segmented));
%    
end

function plotPtCloud(ptCloud, tt)
   figure;
   hold off, pcshow(ptCloud);
   title(tt);
end


function ComparePtCloud(pc1, pc2)

figure;
pcshowpair(pc1,pc2,'VerticalAxis','Y','VerticalAxisDir','Down')
title('Difference Between Two Point Clouds')
xlabel('X(m)')
ylabel('Y(m)')
zlabel('Z(m)')

end



function [height, width, depth, volume] = get_Object_dimensions_to_ptC_with_MBB(ptCloud, background_Distance)

   [bBox, minDepth] = Minimum_Bounding_Box(ptCloud);
   
   width  = sqrt((bBox(1,2) - bBox(1,3))^2 + (bBox(2,2) - bBox(2,3))^2);
   height = sqrt((bBox(1,1) - bBox(1,2))^2 + (bBox(2,1) - bBox(2,2))^2);
   depth  = (background_Distance - minDepth);
   volume = (height*width*depth);
   
   mensurements = sort([width height depth]);
   depth = mensurements(1);
   width = mensurements(2);
   height = mensurements(3);
   
end

function [bBox,minDepth] = Minimum_Bounding_Box(ptCloud)
  
  ptCloud_2D = double([ptCloud(:,1), ptCloud(:,2)]');
  minDepth = min(ptCloud(:,3));
  
  %tic
  bBox = minBoundingBox(ptCloud_2D);
  %toc
 
  %show_boundingBox_on_2D_ptCloud(ptCloud_2D,bBox);

end

function show_boundingBox_on_2D_ptCloud(ptCloud_2D,bBox)
  figure(42);
  hold off,  plot(ptCloud_2D(1,:),ptCloud_2D(2,:),'.')
  hold on,   plot(bBox(1,[1:end 1]),bBox(2,[1:end 1]),'r')
  axis equal
end



%a presente fun��o � baseada no m�todo minboundbox() (OMBB 3D)
%----Entrada: 
%   ptCloud
%   metric: use of minimal volume (v), surface (s) or sum of edges (e) as the metric to be minimized
%   Level: level of reliability of the resulting minimal bounding box (1, 2, 3 ou 4)
%----retorno: largura, comprimento e profundidade
%passos: 
% 1) entrada deve ser um ptCloud tratada, 
% 2) adapta��o dos dados, 
% 3) aplica��o do m�todo
function [height,width,depth,volume, rotmat,cornerpoints,surface] = get_dimensions_with_OMBB_3D(ptCloud, metric, level)

   ptCloud = get_ptCloud_matrix(ptCloud);   

   %OMBB 3D
   [rotmat,cornerpoints,volume,surface] = minboundbox(double(ptCloud(:,1)),double(ptCloud(:,2)),double(ptCloud(:,3)),metric,level); 

   %plot_OMBB_3D_on_ptCloud(ptCloud,cornerpoints);
   
   [height,width,depth] = compute_dimentions_OMBB3D(cornerpoints);
   
end


function [height,width,depth] = compute_dimentions_OMBB3D(cornerpoints)

    Mensurement1 = sqrt(((cornerpoints(1,1)-cornerpoints(2,1))^2+(cornerpoints(1,2)-cornerpoints(2,2))^2+(cornerpoints(1,3)-cornerpoints(2,3))^2))*100;
    Mensurement2 = sqrt(((cornerpoints(2,1)-cornerpoints(3,1))^2+(cornerpoints(2,2)-cornerpoints(3,2))^2+(cornerpoints(2,3)-cornerpoints(3,3))^2))*100;
    Mensurement3 = sqrt(((cornerpoints(1,1)-cornerpoints(5,1))^2+(cornerpoints(1,2)-cornerpoints(5,2))^2+(cornerpoints(1,3)-cornerpoints(5,3))^2))*100;
    
    mensurements = sort([ Mensurement1 Mensurement2 Mensurement3]);
    
    height = mensurements(3);
    width  = mensurements(2);
    depth  = mensurements(1);
    
end


function plot_OMBB_3D_on_ptCloud(ptCloud,cornerpoints)
   plot3(double(ptCloud(:,1)),double(ptCloud(:,2)),double(ptCloud(:,3)),'b.');
   hold on;
   plotminbox(cornerpoints,'r');
end
  