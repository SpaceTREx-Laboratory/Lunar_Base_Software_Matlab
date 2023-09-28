classdef LightSmartModule < SmartModule
    properties
    end

    methods
        function obj = LightSmartModule()
            
        end

        % Methods %
        function light = controlLight(obj, distance, temperature)
            % tempSensor takes temperature & sends to processor
            % proxSensor takes distance & sends to processor
            % processor takes temp data & sends signal to lightActuator
            % processor takes distance data & sends signal to lightActuator
            
            % if lightActuator.state == on
            %   turn on the light
            % else 
            %   do nothing
        end
    end
end