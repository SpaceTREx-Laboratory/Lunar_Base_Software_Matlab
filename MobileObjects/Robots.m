classdef (Abstract) Robots<MobileObjects
    %ROBOTS, This class contains all the function for doing basic
    % operations 
    %   Detailed explanation goes here
    
    properties
        Mode;
        Status;
        HomeLocation;
        Operation;
        Path;
        Map;
        Target;
        TaskList;
        ToolAttached;
        CurrentToolList;
        Speed;
        PowerConsumption;
        PayloadCapacity;
        Battery_Level;
    end
    properties (Dependent)
        current;
        max;
        min;
    end
    
    methods 
        function Display(obj)
     
        end
        
    end
end

