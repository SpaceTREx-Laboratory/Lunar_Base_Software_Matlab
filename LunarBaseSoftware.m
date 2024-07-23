classdef LunarBaseSoftware <matlab.mixin.Heterogeneous
%% Discription of the software
    % This is the main class of the entire Lunarbase Software
    % It can delete/configure the any classes/object of the LunarBase Software
    properties(Access=private)
     ConfiguratorObj; % Configurator object
     DestructorObj;   % Destructor object
     SimulationHandlerObj; % Simulator object
    
    end

    methods
        function obj = LunarBaseSoftware() % LunarBaseSoftware

      
                 
        end
    end
    methods(Access=public)
        %% Lunar Base Setup

        function obj= Setup(obj)
            obj.SimulationHandlerObj=SimulationHandler();  % Simulation Handler
           obj.ConfiguratorObj=Configurator(); % Configurator
           obj.DestructorObj=Destructor();
        end
         function obj= Update(obj)
              obj.SimulationHandlerObj.Main(); % Main simulation Parameter
          %   obj.SimulationHandlerObj.Display(); % Simulation Graphics updater
          %   obj.Close();
        end
    end
    methods(Access=private)
    function obj=Close(obj)
        obj=obj.DestructorObj.Close(obj.SimulationHandlerObj);
    end
        
    end
     
end

