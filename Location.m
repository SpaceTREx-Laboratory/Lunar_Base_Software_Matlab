classdef (Abstract) Location<DataHandler
    methods (Static)
        function out = Temp(data)
            persistent Data;
            if nargin
                Data=data;
            end
            out=Data;
        end
        function out = Fire(data)
            persistent Data;
            if nargin
                Data=data;
            end
            out=Data;
        end
    end
end