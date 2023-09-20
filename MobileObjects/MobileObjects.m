classdef (Abstract) MobileObjects<DataHandler
    %This class contains the all mobile objects in the LunarBase software
    properties
        
        InRIcon=imresize(imread("Robot3.png"),[35 35]);
    end

    methods
        function obj=CreateGraphicsobj(obj)
          icon=obj.InRIcon;
          obj.GraphicsHandle=imagesc('XData',(obj.Loc(1):obj.Loc(1)+size(icon,1))-(size(icon,1)/2),'YData',(obj.Loc(2):obj.Loc(2)+size(icon,2))-(size(icon,2)/2),'CData',icon,Parent=obj.Screen1Handle,Tag=obj.Tag);
   
        end
        function obj=UpdateGraphicsobj(obj)
          icon=obj.InRIcon;
          set(obj.GraphicsHandle,'XData',(obj.Loc(1):obj.Loc(1)+size(icon,1))-(size(icon,1)/2),'YData',(obj.Loc(2):obj.Loc(2)+size(icon,2))-(size(icon,2)/2),'CData',icon);
        end
    end
end