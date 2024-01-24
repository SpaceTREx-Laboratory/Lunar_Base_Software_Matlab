classdef FireVisualizer<EmergencyScenario
    %FIREVISULAZE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Img=uint8(zeros(3840,2160));
        TextHandle;
        ColorbarHandle;
        h;
        hmap;
    end
    
    methods
        function obj=FireVisualizer()
            temp=obj.InternalRobotTarget();
            obj.Loc=temp(7,:);
            obj.Tag="FV1";
        end
        function   obj=CreateGraphicsObj(obj,temp)
           resizedGrid = imresize(temp', [199, 199]);  
        
         SE=strel('disk',ceil(40/0.4008),8);
    
          
            resizedGrid(~SE.Neighborhood)=0;
            
        obj.GraphicsHandle =imagesc('XData',(obj.Loc(1):obj.Loc(1)+size(resizedGrid,1))-(size(resizedGrid,1)/2),'YData',(obj.Loc(2):obj.Loc(2)+size(resizedGrid,2))-(size(resizedGrid,2)/2),'CData',resizedGrid,Tag=obj.Tag,Parent=obj.Screen1Handle);
        
obj.ColorbarHandle=colorbar('peer', obj.Screen1Handle);
 obj.ColorbarHandle.Color = 'w';
 obj.ColorbarHandle.Label.String = 'Temp (deg)';
 obj.ColorbarHandle.Label.Color = 'w';
  obj.ColorbarHandle.Label.FontSize= 16;
    obj.ColorbarHandle.FontSize= 16;
 MeanTemp=max(temp,[],"all");  
  clim([0  MeanTemp]);
 obj.ColorbarHandle.Position=[0.15 0.58 0.01 0.3];
 obj.ColorbarHandle.Limits=[0  400];
  obj.ColorbarHandle.Ticks=0:35: 400;
% Set color of the tick labels to white
     colormap(obj.Screen1Handle, jet);
        alpha(obj.GraphicsHandle,0.4);
              MeanTemp=max(temp,[],"all");
             str="Maximum Room Temp: "+num2str(MeanTemp)+ " (deg)";
             obj.TextHandle=text(obj.Screen1Handle,0,90,str,'Color','w','FontSize',18,'BackgroundColor','blue');
             
        end
        function  obj=UpdateGraphicsObj(obj,temp)
              resizedGrid = imresize(temp', [199, 199]);    
                 SE=strel('disk',ceil(40/0.4008),8);
    
          
            resizedGrid(~SE.Neighborhood)=0;
            
              set(obj.GraphicsHandle,'XData',(obj.Loc(1):obj.Loc(1)+size(resizedGrid,1))-(size(resizedGrid,1)/2),'YData',(obj.Loc(2):obj.Loc(2)+size(resizedGrid,2))-(size(resizedGrid,2)/2),'CData',resizedGrid);
                 
%                 set(obj.ColorbarHandle.Parent, 'CLim',[0,150]);
         MeanTemp=max(temp,[],"all");  
       %  obj.ColorbarHandle.Limits=[0  MeanTemp];
       clim([0  MeanTemp]);
        %obj.ColorbarHandle.Ticks=0:25: MeanTemp;
              alpha(obj.GraphicsHandle,0.4);
         
             str="Maximum Room Temp: "+num2str(MeanTemp)+ " (deg)";
            obj.TextHandle.String=str;
        end
    end
end

