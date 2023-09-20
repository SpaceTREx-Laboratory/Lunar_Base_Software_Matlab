classdef (Abstract) DataHandler<LunarBaseSoftware
    %% This class handles all the data of the software
    % Every static function stores data of an array of objects;

    properties
        Tag;
        ID;
        Type;
        Loc;
        GraphicsHandle;
        SubType;
        PixTom=0.13;   % Assuming the total length of the LunarBase is 500 m
    end
    methods (Static)
        %% All objects DATA
        function out = AllDATA(data)
            persistent Data;
            if nargin
                Data=data;
            end
            out=Data;
        end


        %% Physical Infrastructure DATA

        function out = PhyDATA(data)
            persistent Data;
            if nargin
                Data=data;
            end
            out=Data;
        end
        %% Simulation Windows handles

        function out = Screen1Handle(data)
            persistent Data;
            if nargin
                Data=data;
            end
            out=Data;
        end
        function out = Screen2Handle(data)
            persistent Data;
            if nargin
                Data=data;
            end
            out=Data;
        end

        %% Tracking Total Number of Objects

        function out = TrackObject(data)
            persistent Data;
            if nargin
                Data=data;
            end
            out=Data;
        end

        %% InternalRobotMap

        function out = InternalRobotMap(data)
            persistent Data;
            if nargin
                Data=data;
            end
            out=Data;
        end
        %% InternalRobotPath;
        function out = InternalRobotPath(data)
            persistent Data;
            if nargin
                Data=data;
            end
            out=Data;
        end

        %%     InternalRobotData
        function out = InternalRobotData(data)
            persistent Data;
            if nargin
                Data=data;
            end
            out=Data;
        end

    end
end

