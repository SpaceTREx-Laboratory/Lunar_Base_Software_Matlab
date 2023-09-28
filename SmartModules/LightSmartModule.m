classdef LightSmartModule < SmartModule
    properties
        state;                  % State of the light
        minTemp;
        minDIst;                % Inclufe the distance threshold and temperature threshold?
    end

    methods
        % Constructor
        function obj = LightSmartModule()
        end

        % Methods %
        function cycle = cycleThroughSensors(obj)
            for sensorNum = 1:length(obj.sensors)
                if(processSignal(obj.sensors(sensorNum)))
                    obj.state = 1;      % On
                    return
                end
            end
            obj.state = 0;              % No motion/temp detected
        end
        function smartLight = processSignal(obj, dataType, dataVal)
            % tempSensor takes temperature & sends to processor
            % proxSensor takes distance & sends to processor
            % processor takes temp data & sends signal to lightActuator
            % processor takes distance data & sends signal to lightActuator
            if(strcmp(dataType, "Temperature") && dataVal >= obj.minTemp)
                smartLight = 1;
            elseif(strcmp(dataType, "Proximity") && dataVal <= obj.minDIst)
                %Compare to distance
                smartLight = 1;
            else
                smartLight = 0;
            end
        end

        function illumination = UpdateGraphicsobj(obj)
            % Update graphics
        end
    end
end