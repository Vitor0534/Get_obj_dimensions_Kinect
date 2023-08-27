classdef AirplaneService
    %AirplaneService retorna informações com base na classe AirplaneOBJ
    
    
    %Cada modelo de aeronave e empresa aérea tem suas próprias normas,
    %por padrão será considerado o seguinte:
    %   Quantidade de Kg máximo para bagagem de mão por passageiro   = 10kg
    %   Quantidade de Kg máximo para bagagem de porão por passageiro = 23kg
    %   Dimensões para bagagem de mão (cm)     : 55  x 25 x 35
    %   Dimensões para bagagem de despacho (cm): 55  x 80 x 28
    
    properties
        airplane
    end
    
    methods
        function airplaneServiceNew = AirplaneService(airplaneObj)
            airplaneServiceNew.airplane = airplaneObj;
        end
    end
    
    methods(Static)
        
        function result = get_Max_Number_Hand_Luggage(airplaneService,kg_Max_Per_Luggage)
            result = airplaneService.airplane.hand_Luggage_Capacity/kg_Max_Per_Luggage;
        end
        
        function result = get_Max_Number_despached_Luggage(airplaneService,kgMaxPerLuggage)
            result = (airplaneService.airplane.Forward_basement_Capacity + airplaneService.airplane.Backward_basement_Capacity)/kgMaxPerLuggage;
        end
        
        function result = get_Max_Volume_Hand_Luggage(airplaneService,volumeMaxPerLuggage)
            result = airplaneService.get_Max_Number_Hand_Luggage * volumeMaxPerLuggage;
        end
        
        function result = get_Max_Volume_despached_Luggage(airplaneService,volumeMaxPerLuggage)
            result = airplaneService.get_Max_Number_despached_Luggag * volumeMaxPerLuggage;
        end
        
    end
    
end
