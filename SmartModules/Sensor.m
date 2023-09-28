classdef Sensor
    % Superclass: Sensor Type class that all sensors will inherit from

    properties
        Data;
    end

    methods
        function obj = Sensor()
        end

        function readingOutput = sendData(obj)
            readingOutput = obj.Data;
        end

        function obj = set.Data(obj, input)
            obj.Data = input;
        end
    end
end