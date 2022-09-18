classdef Results
    properties
        Height = 0;
        Width = 0;
        Depth = 0;
        
        tempo_amostragem = 0;
        tempo_tratamento_ptCloud = 0;
        tempo_medida = 0;
        quantidade_de_amostras = 0;
    end
    
    methods(Static)
        
        function [volume] = get_volume()
           volume = Height*Width*Depth;
        end
        
    end
end
