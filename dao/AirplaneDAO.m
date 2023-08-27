classdef AirplaneDAO
    %AIRPLANEDAO Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        airplaneFileName   = 'Airplane.csv';
    end
    
    methods(Static)
        
        function airplaneDAONew = constructor(airplaneDAO, airplaneFileName)
            
            airplaneDAO.airplaneFileName = airplaneFileName;
            
            airplaneDAONew = airplaneDAO;
            
        end
        
        function create(airplaneDAO, airplane)
            
            airplaneList = read(airplaneDAO);
            
            airplaneList = [airplaneList;
                            {
                             airplane.model,                     ...
                             airplane.passenger_Capacity,        ...
                             airplane.hand_Luggage_Capacity,     ...
                             airplane.forward_basement_Capacity, ...
                             airplane.backward_basement_Capacity,...
                             airplane.bulk_basement_Capacity
                             }
                            ];
            
            writetable(airplaneList,airplaneDAO.airplaneFileName);
            
        end
     
        function airplaneList = read(airplaneDAO)
            
            airplaneList = readtable(airplaneDAO.airplaneFileName);
            
        end
        
        function outputArg = delete(airplane)
            
            %todo
            
        end
        
        function outputArg = update(airplane)
            
            %todo
            
        end
        
    end
end

