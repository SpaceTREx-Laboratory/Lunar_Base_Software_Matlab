classdef Actuator
    % Superclass: Actuator Class that takes in input and determines what to control

    properties
        state               % boolean that determines on or off
    end

    methods
        function obj = Actuator(inputArg1,inputArg2)
            %UNTITLED4 Construct an instance of this class
            %   Detailed explanation goes here
            obj.Property1 = inputArg1 + inputArg2;
        end

        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end