classdef (Abstract) SmartModule < DataHandler & matlab.mixin.Heterogeneous
    properties
        sensors;                                                    % Array of sensors
        actuator;                                                   % Single actuator
        processor;                                                  % Single processor
        MIcon = imresize(imread("sensor.png"), [35 35]);            % Icon for the smart module
    end

    % Abstract Methods %
    methods (Abstract)
        signal = processSignal(obj, dataType)                                 % Remove redundancy of processor, every module should implement this class for processing
        obj = UpdateGraphicsobj(obj)
    end

    methods
        % Constructor %
        function obj = SmartModule(obj, sensors, actuator, processor)
            obj.sensors = sensors;
            obj.actuator = actuator;
            obj.processor = processor;
            icon = obj.MIcon;
            obj.GraphicsHandle=imagesc('XData',(obj.Loc(1):obj.Loc(1)+size(icon,1))-(size(icon,1)/2),'YData',(obj.Loc(2):obj.Loc(2)+size(icon,2))-(size(icon,2)/2),'CData',icon,Parent=obj.Screen1Handle,Tag=obj.Tag);
        end       
    end
end