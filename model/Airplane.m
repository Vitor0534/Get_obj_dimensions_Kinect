classdef Airplane
    %AERONAVE é a model que representa a aeronave permitindo que seja
    %configuravel
    %   passenger_Capacity         = capacidade total de passageiros (n)
    %   hand_Luggage_Capacity      = capacidade de bagagens de mão (KG)
    %   Forward_basement_Capacity  = capacidade da parte da frente do porão (KG)
    %   Backward_basement_Capacity = capacidade da parte de trás do porão (KG)
    %   Bulk_basement_Capacity     = capacidade do Bulk (KG)
    %   is_Selected                = indica se a aeronave está selecionada como parametro de carregamento no menu principal
    
    properties
        model                        = "A320";
        passenger_Capacity           = 150;
        hand_Luggage_Capacity        = 2600;
        forward_basement_Capacity    = 3402;
        backward_basement_Capacity   = 4536;
        bulk_basement_Capacity       = 1497;
        is_Selected                  = 0;
        
    end
    
    methods(Static)
        function airplaneNew = constructor(Model,passenger_Capacity, hand_Luggage_Capacity, Forward_basement_Capacity, Backward_basement_Capacity, Bulk_basement_Capacity, is_Selected)
            airplaneNew                            = Airplane;
            airplaneNew.model                      = Model;
            airplaneNew.passenger_Capacity         = passenger_Capacity;
            airplaneNew.hand_Luggage_Capacity      = hand_Luggage_Capacity;
            airplaneNew.forward_basement_Capacity  = Forward_basement_Capacity;
            airplaneNew.backward_basement_Capacity = Backward_basement_Capacity;
            airplaneNew.bulk_basement_Capacity     = Bulk_basement_Capacity;
            airplaneNew.is_Selected                = is_Selected;
        end 
    end
end
