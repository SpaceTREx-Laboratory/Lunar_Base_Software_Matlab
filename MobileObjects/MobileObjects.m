classdef (Abstract) MobileObjects<DataHandler
    %This class contains the all mobile objects in the LunarConstruction
    properties
        
        InRIcon=imresize(imread("Robot3.png"),[35 35]);
    end

    methods
        function obj=CreateGraphicsobj(obj)
            %% Create graphics object
          icon=obj.InRIcon;
          temp_Loc=obj.Loc*5;
         obj.GraphicsHandle=imagesc('XData',(temp_Loc(1):temp_Loc(1)+size(icon,1))-(size(icon,1)/2),'YData',(temp_Loc(2):temp_Loc(2)+size(icon,2))-(size(icon,2)/2),'CData',icon,Parent=obj.Screen1Handle,Tag=obj.Tag);
 %imagesc('CData',icon,Parent=obj.Screen1Handle,Tag=obj.Tag)
  
        end
        function obj=UpdateGraphicsobj(obj)
              %% Update graphics object
          icon=obj.InRIcon;
                 temp_Loc=obj.Loc*5;
          set(obj.GraphicsHandle,'XData',(   temp_Loc(1):   temp_Loc(1)+size(icon,1))-(size(icon,1)/2),'YData',(   temp_Loc(2):   temp_Loc(2)+size(icon,2))-(size(icon,2)/2),'CData',icon);
        end
    end
end