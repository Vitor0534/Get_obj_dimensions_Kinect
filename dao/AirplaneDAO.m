classdef AirplaneDAO
    %AIRPLANEDAO Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        airplaneFileName   = '../dataSet/Airplane.csv';
    end
    
    methods
        function airplaneDAO = AirplaneDAO(airplaneFileName)
            %AIRPLANEDAO Construct an instance of this class
            %   Detailed explanation goes here
            airplaneDAO.airplaneFileName = airplaneFileName;
        end
        
        function result = create(airplaneDAO, airplane)
            
            airplaneList = read(airplaneDAO);
            
            airplaneList = [airplaneList;{airplane.model, airplane.passenger_Capacity, airplane.hand_Luggage_Capacity, %adicione o resto dos parametros 
            
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

