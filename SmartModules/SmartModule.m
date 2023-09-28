classdef (Abstract) SmartModule < DataHandler
    properties
        sensors;                                                    % Array of sensors
        actuator;                                                   % Single actuator
        processor;                                                  % Single processor
        MIcon = imresize(imread("sensor.png"), [35 35]);            % Icon for the smart module
    end

    % Abstract Methods %
    methods (Abstract)
        signal = processSignal(obj)
    end

    methods
        % Constructor %
        function obj = SmartLight(obj, sensors, actuator, processor)
            obj.sensors = sensors;
            obj.actuator = actuator;
            obj.processor = processor;
            icon = obj.MIcon;
            obj.GraphicsHandle=imagesc('XData',(obj.Loc(1):obj.Loc(1)+size(icon,1))-(size(icon,1)/2),'YData',(obj.Loc(2):obj.Loc(2)+size(icon,2))-(size(icon,2)/2),'CData',icon,Parent=obj.Screen1Handle,Tag=obj.Tag);
        end
        % Methods %
        function obj = UpdateGraphicsobj(obj)
          icon=obj.InRIcon;
          set(obj.GraphicsHandle,'XData',(obj.Loc(1):obj.Loc(1)+size(icon,1))-(size(icon,1)/2),'YData',(obj.Loc(2):obj.Loc(2)+size(icon,2))-(size(icon,2)/2),'CData',icon);
        end

        fu
         
    end
end