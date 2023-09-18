classdef Superadobe<PhysicalInfrastructure
    properties 
        Radius
        Center
        Height
        Material
        Temperature_Loc
        Pressure_Loc
    end
    methods
        % Configurator
       function obj = Superadobe(tag, ID, physAttr, inventory)
            obj.Color='cyan';
            obj.Tag = tag{1};
            obj.ID=ID;
            obj.Type="Superadobe";
            obj.Center = physAttr.Center;
            obj.Radius=physAttr.Radius;
            obj.InventoryList = inventory;
      end
      function Display(obj)
       [to,~]= regexp(obj.Tag, '[a-zA-Z]+|\d+', 'match', 'split');
       tag = str2double(to{2});
       if tag>6
           rectangle('Position',[obj.Center(1) obj.Center(2) obj.Radius  obj.Radius]*1/0.4008,EdgeColor=[104 99 99]/255,LineWidth=5,Parent=obj.Screen1Handle,Tag=obj.Tag);
       else
       
            rectangle('Position',[obj.Center(1) obj.Center(2) obj.Radius    obj.Radius]*1/0.4008,EdgeColor="blue",LineWidth=200,Parent=obj.Screen1Handle,Tag=obj.Tag);
       end
      end
      
    end
end
