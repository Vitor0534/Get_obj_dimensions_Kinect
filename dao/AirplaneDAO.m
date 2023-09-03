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
                             {airplaneOBJ.bulk_basement_Capacity},    ...
                             {airplaneOBJ.is_Selected}                ...
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
        
        function airplaneSelectedOBJ = getSelectedAirplane(airplaneDAO)
            
            try
                
                airplaneTable = airplaneDAO.read(airplaneDAO);

                airplaneSelectedTable = 0;

                for i=1:size(airplaneTable,1)

                    if(airplaneTable(i,:).Is_Selected == 1)
                        airplaneSelectedTable = airplaneTable(i,:);
                    end

                end

                if(~istable(airplaneSelectedTable))
                    airplaneSelectedOBJ = 0;
                    return
                end
                
                
                airplaneSelectedOBJ = Airplane;
                airplaneSelectedOBJ = airplaneSelectedOBJ.constructor(  ...
                                                                        airplaneSelectedTable(1,1).Model,                     ...
                                                                        airplaneSelectedTable(1,2).Passenger_Capacity,        ...
                                                                        airplaneSelectedTable(1,3).Hand_Luggage_Capacity,     ...
                                                                        airplaneSelectedTable(1,4).Forward_basement_Capacity, ...
                                                                        airplaneSelectedTable(1,5).Backward_basement_Capacity,...
                                                                        airplaneSelectedTable(1,6).Bulk_basement_Capacity,    ...
                                                                        airplaneSelectedTable(1,7).Is_Selected                ...
                                                                     );
            catch exception
                throw(exception) 
            end
        end
        
        
        function selectAnAirplane(airplaneDAO, airplaneOBJ)
            %todo
        end
        
        
        
    end
end

