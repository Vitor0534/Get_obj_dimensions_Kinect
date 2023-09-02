classdef AirplaneDAO
    %AIRPLANEDAO Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        airplaneFileName   = './dataSet/Airplane.csv';
    end
    
    methods(Static)
        
        function airplaneDAONew = constructor(airplaneDAO, airplaneFileName)
            
            airplaneDAO.airplaneFileName = airplaneFileName;
            
            airplaneDAONew = airplaneDAO;
            
        end
       
        
        function create(airplaneDAO, airplaneOBJ)
            
            airplaneTable = table(                                    ...
                             {airplaneOBJ.model},                     ...
                             {airplaneOBJ.passenger_Capacity},        ...
                             {airplaneOBJ.hand_Luggage_Capacity},     ...
                             {airplaneOBJ.forward_basement_Capacity}, ...
                             {airplaneOBJ.backward_basement_Capacity},...
                             {airplaneOBJ.bulk_basement_Capacity}     ...
                            );
            
            writetable(airplaneTable, airplaneDAO.airplaneFileName, ...
                       'WriteMode','Append',                        ...
                       'WriteVariableNames',false,                  ...
                       'WriteRowNames',true);
        end
        
     
        function airplaneTable = read(airplaneDAO)
            
            airplaneTable = readtable(airplaneDAO.airplaneFileName);
            
        end
        
        function delete(airplaneDAO, airplaneOBJ)
            
            airplaneTable = airplaneDAO.read(airplaneDAO);
            airplaneTable.Properties.RowNames = airplaneTable.Model;
            
            airplaneTable(airplaneOBJ.model,:) = [];
            
            writetable(airplaneTable,airplaneDAO.airplaneFileName);
            
        end
        
        function update(airplaneDAO, model, airplaneOBJ)
            
            oldeAirplaneData.model = model;
            
            airplaneDAO.delete(airplaneDAO, oldeAirplaneData);
            
            airplaneDAO.create(airplaneDAO, airplaneOBJ)
            
        end
        
    end
end

