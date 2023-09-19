classdef Graphics_cleaner<DataHandler
    
    methods
        function obj=Graphics_cleaner(Corner,length,width)
            obj.rect(Corner,length,width);
        end
        function cicle(obj,Center,Radius)
            rectangle('Position',[Center(1)-Radius Center(2)-Radius 2*Radius  2*Radius]*1/0.4008,FaceColor='k',Curvature=1,Parent=obj.Screen1Handle);
        end
        function rect(obj,Corner,length,width)
            rectangle('Position',[Corner(1) Corner(2) length width]*1/0.4008,FaceColor='k',EdgeColor='k',Parent=obj.Screen1Handle);
        end
    end
end

