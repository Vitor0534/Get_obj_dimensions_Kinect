%Infos: para executar esse programa, � necess�rio instalar as depend�ncias:
%       1 - image aquisition toolbox;
%       2 - kinect for matlab package;

%27/02/2022 - foi implementado a constru��o da pt a partir dos slices.
%             ERROr: existe um erro na entrada de dados enviada ao convexhull que impede o
%                    programa de continuar.
%                    resolvido: era um valor invalido de nan

%Paso 0: chamada de fun��es
method_1_frame_by_frame();



function method_1_frame_by_frame()
    %Pt1: mostrando algumas informa��es dos sensores 
        x = "\ninforma��o dos adaptadores instalados\n"
        imaqhwinfo
        x = "\n*************************************"
        imaqhwinfo('kinect')
        imaq.VideoDevice('kinect',1)

    %****************************************************
    %comentei umas partes para usar a workspace, descomente para voltar a tempo
    %real

    %PT2: Criando instancia dos objetos de cor e profundidade do kinect*********
        colorDevice = imaq.VideoDevice('kinect',1);
        depthDevice = imaq.VideoDevice('kinect',2);
    %************************************************************

    %PT3: inicializa a camera:
        colorDevice();
        depthDevice();
    %********************************

    %PT4: captura 1 frame do kinect para inicializar
        colorImage = colorDevice();
        depthImage = depthDevice();
    %********************************

    %Pt5: extrai a point cloud
    %essa � uma instancia da class pointCloud, gerada com os dados xyzPoints 
    %contruidos na pcfromkinect. ele contem diversos parametros
    %o parametro location � a matriz m-by-n-by-3 que s�o os pontos

        %ptCloud = pcfromkinect(depthDevice, depthImage,colorImage);
        ptCloud = pcfromkinect(depthDevice, depthImage);


    %teste para verificar os pontos
%     x="matriz de pontos"
%     xyzPoints = ptCloud.Location(1:50,1:50,:);
%     xyzPoints = ~isnan(xyzPoints(:,:,:)); %retorna uma matriz com valores l�gicos

    %definindo uma regi�o de interesse para evitar coletar outliers dos cantos
    %roi= [-0.3, 0.2, -0.3, 0.3, 0, inf]
    %roi= [-0.3, 0.1, -0.3, 0.3, 0, inf] %--> �rea adequada (original - sem esteira)
    %roi= [-0.28, 0.08, -0.2, 0.2, 0, inf] %--> �rea adequada (original - com esteira)
    %roi= [-0.2, 0.0, -0.103, 0.12, 0, inf]
    %roi= [-0.3, 0.2, -0.01, 0, 0, inf] %--> teste para limitar scanneamento (slice - sem esteira)
    roi= [-0.25, 0.18, -0.01, 0, 0, inf] %--> teste para limitar scanneamento (slice - com esteira)
    
    background_Distance = 1.1;
    
    
    %PT6: plotando a point cloud para visualiza��o
        plotPointCloud(colorDevice,depthDevice,0,roi);



    %PT 7: extraindo as dimens�es do objeto pela point cloud
     %ROI ajustado: [-0.3, 0.1, -0.2, 0.2, 0, inf]
     %[hight, width, depth,ptCloudB] = pc_Object_Dimension_Extract_OP2(ptCloud,background_Distance,roi);
     
     [hight, width, depth,ptCloudB,number_of_Obj_samples] = pc_Object_Dimension_scanner(background_Distance,roi,depthDevice,colorDevice,"Static",5/100);
     
     hight
     width
     depth
    
     %%calculando altura, largura, profundidade e volume

     roi
     Hight_b_cm = (hight(2)-hight(1))*100
     Width_b_cm = (width(2)-width(1))*100
     Depth_b_cm = (depth(2)-depth(1))*100
     Volume_m3 = (Hight_b_cm/100) * (Width_b_cm/100) * (Depth_b_cm/100)

     
     number_of_Obj_samples
     
     %visualizando imagem de profundidade
        title('imagem RGB')
        imshow(colorImage);
        figure();
        
        title('imagem de profundidade')
        imshow(255*(depthImage>255))
        
        
        



      %PT8:
      %para que n�o ocorra um erro em uma nova execu��o tem que para a
      %aquisi��o de frames uma forma de fazer isso � deletando os objetos de
      %aquisi��o instanciados
        delete(colorDevice);
        delete(depthDevice);


      %plotando point cloud est�tiva
        plotPointCloud_Static(ptCloudB);

      %aplicando convex hull na ptCloud
       %[k2,av2] = convexhull_ptCloud(ptCloud,1.1,roi)
        %[k2,av2]=convexhull_ptCloud_matriz_coluna(ptCloudB,1.1,roi);
        %av2

 
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
  
  %%Acquire and view Kinect point cloud data.
  while (isOpen(player))
     colorImage = colorDevice();
     depthImage = depthDevice();

     if(color)
        ptCloud = pcfromkinect(depthDevice, depthImage, colorImage);
     else
        ptCloud = pcfromkinect(depthDevice, depthImage);
     end
     
     if(size(roi,1)~=0)
        %ROI ajustado: [-0.3, 0.2, -0.3, 0.3, 0, inf]
         indices = findPointsInROI(ptCloud,roi);
         ptCloudB = select(ptCloud, indices);
         view(player, ptCloudB);
     else
        %imprime o valor de um ponto no centro da depthImage para aferir a
        %distancia
        %ptCloud.Location(212,256,:)
         view(player, ptCloud);
     end
  end
end
 
function plotPointCloud_Static(ptCloud)

  player = pcplayer(ptCloud.XLimits, ptCloud.YLimits, ptCloud.ZLimits,...
              'VerticalAxis', 'y', 'VerticalAxisDir', 'down');

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
function [hight, width, depth] = pc_Object_Dimension_Extract(ptCloud,background_Distance,roi)
    
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
function [hight, width, depth,ptCloudB] = pc_Object_Dimension_Extract_OP2(ptCloud,background_Distance,roi)
    
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


function [height, width, depth,ptCloudB,number_of_Obj_samples] = pc_Object_Dimension_scanner(background_Distance,roi_Slice,depthDevice,colorDevice, method,step)
    
    sample_rate = 30; %HZ
    step=0.05; %m/s
    %step = step/sample_rate; 
    width=[0,0];  %x
    height=[0,0];  %y
    depth=[0,background_Distance]; %z
    
    dimensions_Check=0;
    break_flag=0;
    
    ptCloud_of_the_object_interated=[nan nan nan];
    
    number_of_steps = 1;
    number_of_Obj_samples = 0;
    
    try
    
        while(break_flag<=10)

            %coletando frames da matriz de pontos
            ptCloudB = aply_roi_PtCloud(get_Pt_Cloud_Frame(depthDevice,colorDevice,0),roi_Slice);
            xyzPoints = ptCloudB.Location;

            %[height, width, depth,is_there_Object] = get_Object_dimensions_to_ptc_column(xyzPoints, height, width, depth,method,step);

            is_there_Object = check_for_object(xyzPoints, 10, background_Distance);

            if(is_there_Object)
                dimensions_Check=0;
                break_flag=0;

                ptCloud_of_the_object_interated(1,:) = xyzPoints(1,:);
                ptCloud_of_the_object_interated = [ptCloud_of_the_object_interated;
                                                  (xyzPoints(:,:) + [0 (step*number_of_steps) 0])];

                number_of_steps = number_of_steps + 1;
                number_of_Obj_samples = number_of_Obj_samples +1;

            elseif(dimensions_Check>=3)

                %show_Dimentions_and_convexhull(width, height, depth, ptCloud_of_the_object_interated, background_Distance)
                %ptCloud_of_the_object_interated=[nan nan nan];

                break_flag = break_flag + 1
                %number_of_steps=0;

            else
                dimensions_Check=dimensions_Check+1;
            end

            pause(1/sample_rate); %amostragem

        end

        %ptCloud_of_the_object_interated = add_Steps_to_the_ptCloud(ptCloud_of_the_object_interated,number_of_Obj_samples+1,step);

        [height, width, depth,~] = get_Object_dimensions_to_ptc_column(ptCloud_of_the_object_interated, height, width, depth,method,step, 10);

        show_Dimentions_and_convexhull(width, height, depth, ptCloud_of_the_object_interated, background_Distance)

        ptCloud_of_the_object_interated=[nan nan nan];

        %para que n�o ocorra um erro em uma nova execu��o tem que parar a
        %aquisi��o de frames. uma forma de fazer isso � deletando os objetos de
        %aquisi��o instanciados
          delete(colorDevice);
          delete(depthDevice);
      
    catch error
        disp("Erro na fun��o: pc_Object_Dimension_scanner");
        error
        delete(colorDevice);
        delete(depthDevice);
    end
end

function [number] = meters_to_centimeters(number)
    number=number*100;
end

function show_Dimentions_and_convexhull(width, height, depth, ptCloud_of_the_object_interated, background_Distance)
    disp("As Dimens�es do objeto s�o: ");
    Hight_b_cm = meters_to_centimeters((height(2)-height(1)))
    Width_b_cm = meters_to_centimeters((width(2)-width(1)))
    Depth_b_cm = meters_to_centimeters((depth(2)-depth(1)))
    Volume_m3 = (Hight_b_cm/100) * (Width_b_cm/100) * (Depth_b_cm/100)
            
    if(~isnan(ptCloud_of_the_object_interated(1,:)))
         [k2,av2] = convexhull_ptCloud_matriz_coluna(ptCloud_of_the_object_interated, background_Distance, depth);
         av2
    end
end

function [xyzPoints] = add_Steps_to_the_ptCloud(xyzPoints,number_of_steps,step)

    for i=1:(i<=size(xyzPoints,1) && i <=number_of_steps)
        xyzPoints(i,3) = xyzPoints(i,3) + (step*i);
    end
    
end

function [height, width, depth,is_there_Object] = get_Object_dimensions_to_ptc_column(xyzPoints, height, width, depth, method,step,Obj_detect_precision)
     
     is_there_Object = 0;
     did_it_get_a_step = 0;
     for i=1:size(xyzPoints,1)
               is_there_Object = check_for_object(xyzPoints(i,:),Obj_detect_precision,depth(2));
               if(is_there_Object)
                   
                   %Rastreia a profundidade 
                   if(xyzPoints(i,3)<depth(1) || depth(1)==0)
                       depth(1)=xyzPoints(i,3);
                   end

                   %Rastreia a largura
                   if(xyzPoints(i,1) < width(1) || width(1)==0)
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
               end
     end
     
end

function [is_there_Object] = check_for_object(xyzPoints, precision,background_Distance)
    is_there_Object=0;
    is_there_Object = is_there_Object + sum(sum((xyzPoints(1:precision:size(xyzPoints,1),3)<background_Distance),'native'),'native');
    if(is_there_Object)
        is_there_Object=1
    end
end

function [height] = get_height(xyzPoints, height, i)
     if(xyzPoints(i,2) < height(1) || height(1)==0)
        height(1)=xyzPoints(i,2);
     elseif(xyzPoints(i,2)>height(2))
        height(2)=xyzPoints(i,2);
     end
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

function [k2,av2] = convexhull_ptCloud_matriz_coluna(ptCloud,background_Distance,depth)

 ptCloud = ptCloud_processing(ptCloud, background_Distance, 0.01, depth);

[x,y,z] = format_Data(ptCloud);
[k2,av2] = convhull(x,y,z,'Simplify',true);

%[k2,av2] = convhull(xyzPoints(:,1),xyzPoints(:,2),xyzPoints(:,3),'Simplify',true);

show_convexhull(k2,x,y,z,'FaceColor','cyan')

end


function [x,y,z] = format_Data(ptCloud)
    
   xyzPoints = get_ptCloud_matrix(ptCloud);

    x(1:size(xyzPoints,1))=0;
    y(1:size(xyzPoints,1))=0;
    z(1:size(xyzPoints,1))=0;

    indice_vetor=1;
    for i=1:size(xyzPoints,1)
        if(~isnan(xyzPoints(i,:)))
            x(indice_vetor)=xyzPoints(i,1);
            y(indice_vetor)=xyzPoints(i,2);
            z(indice_vetor)=xyzPoints(i,3);
            indice_vetor = indice_vetor+1;
        end
    end
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
%   2- pega o ponto da matriz obtida na amostragem e reflete cria um ponto 
%      no mesmo xy so que z == background_distance.
%      isso vai gerar uma superf�cie para a base e permitir que o convexhull 
%      obtenha volume total do objeto
function [xyzPoints_result] = ptCloud_processing(ptCloud, background_Distance, cut_value, depth)
    
    xyzPoints = get_ptCloud_matrix(ptCloud);
    xyzPoints_result = [0 0 0];
    
    xyzPoints_Amount_rows = size(xyzPoints,1);
    
    for i=1:xyzPoints_Amount_rows
        if(~isnan(xyzPoints(i,:)))
            if((xyzPoints(i,3) <= (background_Distance - cut_value)))
                %xyzPoints_result = [xyzPoints_result; xyzPoints(i,:); (xyzPoints(i,:)+[0 0 depth(1)])];
                xyzPoints_result = [xyzPoints_result; xyzPoints(i,:); [xyzPoints(i,1) xyzPoints(i,2)  background_Distance]];
            end
        end
    end
    
    if(xyzPoints_Amount_rows>=2)
        xyzPoints_result(1,:) = xyzPoints_result(2,:);
    end
end

 %   Example : Find points within a given cuboid
            %   -------------------------------------------
            %   % Create a point cloud object with randomly generated points
            %   ptCloudA = pointCloud(100*rand(1000, 3, 'single'));
            %
            %   % Define a cuboid
            %   roi = [0, 50, 0, inf, 0, inf];
            %
            %   % Get all the points within the cuboid
            %   indices = findPointsInROI(ptCloudA, roi);
            %   ptCloudB = select(ptCloudA, indices);
            %
            %   pcshow(ptCloudA.Location, 'r');
            %   hold on;
            %   pcshow(ptCloudB.Location, 'g');
            %   hold off;
  