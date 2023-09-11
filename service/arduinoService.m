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
        
        function arduinoMatControl(arduinoSerialObject, option, value)

            switch(option)
                case 'stop'
                    fwrite(arduinoSerialObject.SerialObject,'s');
                    pause(5);
                case 'run'
                    fwrite(arduinoSerialObject.SerialObject,'r');
                case 'clockwise'
                    fwrite(arduinoSerialObject.SerialObject,'h');
                    fwrite(arduinoSerialObject.SerialObject,'h');
                    pause(5);
                case 'anticlockwise'
                    fwrite(arduinoSerialObject.SerialObject,'a');
                    fwrite(arduinoSerialObject.SerialObject,'a');
                    pause(5);
                case 'set_Speed'
                    fwrite(arduinoSerialObject.SerialObject,'v,'+ string(value));
                case 'set_pwmControlReason'
                    fwrite(arduinoSerialObject.SerialObject,'c,'+ string(value));
                    pause(5);
                case 'set_matMaxRPM'
                    fwrite(arduinoSerialObject.SerialObject,'m,'+ string(value));
                otherwise
                  disp("Invalid Option on arduinoMatControl");
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
        
        function setMatSpeedByPreSelectedOption(arduinoService, option)
            
            switch(option)
                case 1
                    arduinoService.arduinoMatControl(arduinoService, 'set_Speed', 51);
                case 2
                    arduinoService.arduinoMatControl(arduinoService, 'set_Speed', 102);
                case 3
                    arduinoService.arduinoMatControl(arduinoService, 'set_Speed', 153);
                case 4
                    arduinoService.arduinoMatControl(arduinoService, 'set_Speed', 204);
                case 5
                    arduinoService.arduinoMatControl(arduinoService, 'set_Speed', 255);
                otherwise
                  disp("Invalid Option on setMatSpeedByPreSelectedOption");
            end
            
        end

    end
end






