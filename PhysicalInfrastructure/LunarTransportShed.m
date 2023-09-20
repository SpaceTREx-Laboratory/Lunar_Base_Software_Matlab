classdef LunarTransportShed<PhysicalInfrastructure

     properties
        Length
        Corner
        Width
        Center
     end
    
    methods
          %% configurator
        function obj =LunarTransportShed(tag, physAttr, inventory)
           obj.Tag = tag{1};
            obj.ID=obj.TrackObject()+1;
            obj.TrackObject(obj.ID);
            obj.SubType="LunarTransportShed";
            obj.Corner = physAttr.Corner;
            obj.Width=physAttr.Width;
             obj.Length=physAttr.Length;
            obj.InventoryList = inventory;
            obj.Color='b';
            obj.GraphicsObj();
        end
        function stressMap = StressMap(obj)


        end
      function GraphicsObj(obj)
        rectangle('Position',[obj.Corner(1) obj.Corner(2) obj.Length  obj.Width]*1/0.4008,'Tag',obj.Tag,EdgeColor=obj.Color,LineWidth=5,Parent=obj.Screen1Handle);
      end 
      function Update(obj)
        h=findobj(obj.Screen2Handle,'Tag',obj.Tag);
        set(h,"Position",[obj.Corner(1) obj.Corner(2) obj.Length  obj.Width]*1/0.4008,EdgeColor='r');
      end
    end
end
