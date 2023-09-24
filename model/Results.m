classdef Results
    properties
        Height = 0;
        Width = 0;
        Depth = 0;
        
        tempo_amostragem = 0;
        tempo_tratamento_ptCloud = 0;
        tempo_medida = 0;
        quantidade_de_amostras = 0;
        
        pointCloudCapturadaSemTratamento
        pointCloudCapturadaTratada
        
        convHull_K2_triangulation
        convHull_Av2_Volume
    end
    
    methods(Static)
        
        function [volume] = get_volume_bounding_box()
           volume = Height*Width*Depth;
        end
        
    end
end
