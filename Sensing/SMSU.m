classdef (Abstract) SMSU<DataHandler
    %SMSU Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        RangeV;
            RangeL;
        Temp;
        Pressure;

    end
    
    methods
        
        function obj =Update(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            obj=obj.Sensing();
        end
        function obj =Sensing(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            mask=obj.RangeL();
            temp=obj.EnvDataTemp();
            obj.Temp=temp(mask);
        end
    end
end

