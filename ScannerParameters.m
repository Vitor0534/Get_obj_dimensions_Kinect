classdef ScannerParameters
    %ScannerParameters: são os parametros definidos previamente para coleta das dimensões do objeto. 
    %   background_Distance      = distância entre o kinect e a base da esteira
    %   cut_value                = distância para segmentar a mala do fundo
    %   step                     = passo de amostragem
    %   sample_rate              = taxa de amostragem,
    %   ROI                      = região da ptCloud para captura do objeto
    %   mensureMethod            = método de medida (MBB | AABB | 3D MBB)
    %   objectDetectionPrecision = valor utilzado para a sensibilidade a presença de um objeto na frente do kinect, quanti maio, menor a sensibilidade 
    
    properties  
        background_Distance      = 1.08;
        cut_value                = 0.05;            
        step                     = 0.065;                
        sample_rate              = 20; 
        ROI                      = [-0.275, 0.205, -0.0375, 0.0275, 0, inf];
        scanningMethod
        mensureMethod            = 'MBB';
        objectDetectionPrecision = 10;
        arduinoController       
        
    end
    
    methods(Static)
    end
end

