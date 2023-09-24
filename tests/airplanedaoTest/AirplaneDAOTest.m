classdef AirplaneDAOTest < matlab.unittest.TestCase
   
    methods (Test)
        
        function lerTodasAsAeronavesDoDataSetTest()
            %Given
            airplaneDAO = AirplaneDAO;
         
            %When
            airplaneList = airplaneDAO.read(airplaneDAO);
            
            %Then
            airplaneList;
            
        end
        
    end
end
