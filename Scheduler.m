classdef Scheduler<SimulationHandler
% This class control the overall scheduling process of the simulation
  

    
    methods
        function obj=Scheduler()
     
            
            
        end
        function obj=Update(obj)
         


            
       
        end


        function obj=Display(obj)
                %% Setting up the Moiniter
        Phy=obj.PhyDATA();
        arrayfun(@(x) x.Display(),Phy,'UniformOutput',false);
        end
    end
end