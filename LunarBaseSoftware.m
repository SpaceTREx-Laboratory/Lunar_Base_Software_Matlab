classdef LunarBaseSoftware <matlab.mixin.Heterogeneous
%% Discription of the software
    % This is the main class of the entire Lunarbase Software
    % It can delete/configure the any classes/object of the LunarBase Software
    % 
    properties(Access=private)
     ConfiguratorObj; % configurator object
     DestructorObj;   % Destructor object
     SimulationHandlerObj;
    end

    methods
        function obj = LunarBaseSoftware() % LunarBaseSoftware

      
                 
        end
    end
    methods(Access=public)
        function obj= Setup(obj)
            obj.SimulationHandlerObj=SimulationHandler();
         obj.ConfiguratorObj=Configurator();
      

        end
         function obj= Update(obj)
             obj.SimulationHandlerObj.Main(); % Main simulation Parameter
             obj.SimulationHandlerObj.Display();
        end
    end
    methods(Access=private)
    function obj=Close(obj)

    end
        
    end
     
end

