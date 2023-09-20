classdef Superadobe<PhysicalInfrastructure
    
   properties
    Center
    Radius
   end

    methods
        %% Configurator
       function obj = Superadobe(tag, physAttr, inventory)
            obj.Color='cyan';
            obj.Tag = tag{1};
            obj.ID=obj.TrackObject()+1;
             obj.TrackObject(obj.ID);
            obj.SubType="Superadobe";
            obj.Center = physAttr.Center;
            obj.Radius=physAttr.Radius;
            obj.InventoryList = inventory;
            obj.GraphicsObj();
      end
      function GraphicsObj(obj)
       [to,~]= regexp(obj.Tag, '[a-zA-Z]+|\d+', 'match', 'split');
       tag = str2double(to{2});
       if tag>6
           rectangle('Position',[obj.Center(1)-obj.Radius obj.Center(2)-obj.Radius 2*obj.Radius  2*obj.Radius]*1/0.4008,EdgeColor=[104 99 99]/255,Curvature=1,LineWidth=1,Parent=obj.Screen1Handle,Tag=obj.Tag);
       else
       
           rectangle('Position',[obj.Center(1)-obj.Radius obj.Center(2)-obj.Radius 2*obj.Radius  2*obj.Radius]*1/0.4008,EdgeColor="blue",Curvature=1,LineWidth=5,Parent=obj.Screen1Handle,Tag=obj.Tag);
       end
      end
       function Update(obj)
        h=findobj(obj.Screen2Handle,'Tag',obj.Tag);
        set(h,'Position',[obj.Center(1)-obj.Radius obj.Center(2)-obj.Radius 2*obj.Radius  2*obj.Radius]*2/0.4008);
      end
      
    end
end
