%Este arquivo contem os códigos referentes ao controle da esteira via
%Arduino. Os comandos são mandados pela porta Serial do Arduino

classdef ArduinoService
    properties
        PORT = '';
        SerialObject = '';
        baldRate     = 9600;
    end
    
    methods(Static)
        
        function arduinoServiceObj = constructor(PORT, baldRate, arduinoService)
           arduinoService.PORT = PORT;
           arduinoService.baldRate = baldRate;
           arduinoServiceObj = arduinoService;
        end
        
        function arduinoMatControl(option,arduinoSerialObject,speed)

            switch(option)
                case 'stop'
                    fwrite(arduinoSerialObject.SerialObject,'s');
                case 'run'
                    fwrite(arduinoSerialObject.SerialObject,'r');
                case 'clockwise'
                    fwrite(arduinoSerialObject.SerialObject,'h');
                case 'anticlockwise'
                    fwrite(arduinoSerialObject.SerialObject,'a');
                case 'set_Speed'
                    fwrite(arduinoSerialObject.SerialObject,'v,'+ string(speed));
                otherwise
                  disp("Invalid Option");
            end

        end
        
        function [arduinoSerialObj] = setup(option,arduinoSerialObject)
            switch(option)
                case 'connect'
                    arduinoSerialObj = arduinoSerialObject.setupArduinoConection(arduinoSerialObject);
                    fopen(arduinoSerialObj.SerialObject);
                case 'disconnect'
                    fclose(arduinoSerialObject.SerialObject);
                    delete(arduinoSerialObject.SerialObject);
            end
        end
        
        function [arduinoSerialPort] = arduinoSetup(PORT,option,arduinoSerialObject)
            switch(option)
                case 'connect'
                    arduinoSerialPort = setupArduinoConection(PORT);
                    fopen(arduinoSerialPort);
                case 'disconnect'
                    fclose(arduinoSerialObject);
                    delete(arduinoSerialObject);
            end
        end


        function arduinoSerialObj = setupArduinoConection(arduinoSerialObject)
            delete(instrfind({'Port'},{arduinoSerialObject.PORT}));
            arduinoSerialObject.SerialObject = serial(arduinoSerialObject.PORT);
            arduinoSerialObj = arduinoSerialObject;
        end

    end
end







