classdef Airplane
    %AERONAVE é a model que representa a aeronave permitindo que seja
    %configurpavel
    %   passenger_Capacity         = capacidade total de passageiros (n)
    %   hand_Luggage_Capacity      = capacidade de bagagens de mão (KG)
    %   Forward_basement_Capacity  = capacidade da parte da frente do porão (KG)
    %   Backward_basement_Capacity = capacidade da parte da trás do porão (KG)
    %   Bulk_basement_Capacity     = capacidade do Bulk (KG)
    
    properties
        Model                        = "A320"
        passenger_Capacity           = 150
        hand_Luggage_Capacity        = 2600
        Forward_basement_Capacity    = 3402
        Backward_basement_Capacity   = 4536
        Bulk_basement_Capacity       = 1497
        
    end
    
    methods
        function airplaneNew = Airplane(Model,passenger_Capacity, hand_Luggage_Capacity, Forward_basement_Capacity, Backward_basement_Capacity, Bulk_basement_Capacity)
            airplaneNew.Model                      = Model;
            airplaneNew.passenger_Capacity         = passenger_Capacity;
            airplaneNew.hand_Luggage_Capacity      = hand_Luggage_Capacity;
            airplaneNew.Forward_basement_Capacity  = Forward_basement_Capacity;
            airplaneNew.Backward_basement_Capacity = Backward_basement_Capacity;
            airplaneNew.Bulk_basement_Capacity     = Bulk_basement_Capacity;
        end 
    end
end
