classdef (Abstract) DataHandler<LunarBaseSoftware
    % This class handles all the data of the software
    % Every static function store the

    properties
        Tag;
        ID;
        Type;
        Loc;
    end
    methods (Static)
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
    end
end

