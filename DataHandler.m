classdef DataHandler<LunarBaseSoftware
    % This class handles all the data of the software
    % Every static function store the 

    properties
        Tag;
        ID;
        Type;
        Data;
        Loc;
        Dimension;
    end

    methods
        function obj = DataHandler(inputArg1,inputArg2)
            %UNTITLED3 Construct an instance of this class
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