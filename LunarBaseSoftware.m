classdef LunarBaseSoftware
%% Discription of the software
    % This is the main class of the entire Lunarbase Software
    % It can delete/configure the any classes/object of the LunarBase Software
    % 
    properties(Access=private)
     ConfiguratorObj; % configurator object
     DestructorObj;   % Destructor object
    end

    methods
        function obj = LunarBaseSoftware() % LunarBaseSoftware
                 
        end

        function obj= Setup(obj)
        
         

        end
        function obj=Close(obj)

            rectangle('Position',[obj.PhysicalAttributes.Center(1) obj.PhysicalAttributes.Center(2) obj.PhysicalAttributes.Radius+40    obj.PhysicalAttributes.Radius+40]*1/0.4008,EdgeColor="blue",LineWidth=200,Parent=obj.ax1);
            %             for i=1:2160
            %              y_l1=3*(1+ceil((3839*(i-1)/2159)));
            %              y_l2=3*(1+ceil((3839*(i-1)/2159)));
            %              h=findobj(obj.Window1,'Tag','Robot');
            %              I_e=uint8(zeros(2160,3840,3));
            %              I_e(i:i+99,y_l:y_l+99,:)=obj.ricon;
            %              I_e(i:i+99,y_l:y_l+99,:)=obj.ricon;
            %              set(h,'CData',I_e);
            %              pause(00000.1)
            %             end

        end
        
    end
     
end

