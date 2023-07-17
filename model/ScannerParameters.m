classdef ScannerParameters
    %ScannerParameters: são os parametros definidos previamente para coleta das dimensões do objeto. 
    %   background_Distance      = distância entre o kinect e a base da esteira
    %   cut_value                = distância para segmentar a mala do fundo
    %   step                     = passo de amostragem
    %   sample_rate              = taxa de amostragem,
    %   ROI                      = região da ptCloud para captura do objeto (Default: comprimento = 0.065,largura = 0,48)
    %   mensureMethod            = método de medida (MBB | AABB | 3D MBB)
    %   objectDetectionPrecision = valor utilizado para a sensibilidade a presença de um objeto na frente do kinect, quanto maior, menor a sensibilidade
    %   matSpeed                 = velocidade da esteira, atualmente as opções são 1, 2, 3, ou 5

    properties  
        background_Distance      = 1.13;
        cut_value                = 0.08;            
        step                     = 0.065;                
        sample_rate              = 20; 
        ROI                      = [-0.275, 0.205, -0.0375, 0.0275, 0, inf];  
        scanningMethod 
        mensureMethod            = 'MBB';
        objectDetectionPrecision = 10;
        arduinoController      
        matSpeed                 = 3;
        
    end
    
    methods(Static)
    end
end

