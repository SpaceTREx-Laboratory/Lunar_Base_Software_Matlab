classdef CommunicationCenter<PhysicalInfrastructure
    properties
        Radius
        Center
    end
    methods
        function obj = CommunicationCenter(tag, physAttr, inventory)
             obj.Tag = tag{1};
            obj.ID=obj.TrackObject()+1;
             obj.TrackObject(obj.ID);
            obj.Subtype="CommunicationCenter";
            obj.Center = physAttr.Center;
            obj.Radius=physAttr.Radius;
            obj.InventoryList = inventory;
            obj.Color='g';
            obj.GraphicsObj();
        end
        function stressMap = StressMap(obj)
          
        end
    function GraphicsObj(obj)
       rectangle('Position',[obj.Center(1)-obj.Radius obj.Center(2)-obj.Radius 2*obj.Radius  2*obj.Radius]*1/0.4008,'Tag',obj.Tag,EdgeColor=obj.Color,Curvature=1,LineWidth=5,Parent=obj.Screen1Handle);
      end 
      function Update(obj)
        h=findobj(obj.Screen2Handle,'Tag',obj.Tag);
        set(h,"Position",[obj.Center(1)-obj.Radius obj.Center(2)-obj.Radius 2*obj.Radius  2*obj.Radius]*1/0.4008,EdgeColor='r');
      end
    end
end
