classdef (Abstract) PhysicalInfrastructure<DataHandler
    % This object contains all PhysicalInfrastructue
    %   Detailed explanation goes here
    properties
    Dimension;
    Pressure_Loc;
    Temperature_Loc;
    Pressurized;
    InventoryList;  
    Color;
    
    end
     
    methods
    
%         function obj=Display(obj)
% 
%           h=findobj(obj.Screen2Handle,'Tag',obj.Tag);
%           set(h,"Position",[obj.Center(1)-obj.Radius obj.Center(2)-obj.Radius 2*obj.Radius  2*obj.Radius]*2/0.4008);
% 
%         end
    end




end