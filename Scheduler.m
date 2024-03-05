classdef Scheduler<DataHandler
% This class control the overall scheduling process of the simulation
     properties
         Responce;
         ResponceAction="No";
         Mission;
     end

    
    methods
        function obj=Scheduler(R,M)
            obj.Responce=R;
            obj.Mission=M;
            obj.Complete([]);
        end
        function obj=Update(obj)

           switch obj.Mission
               case 'FireFighting'
                obj=obj.FireFightingCheck();                           
               case 'AssetManagement'
               obj=obj.FireFightingCheck();
               case 'Replace'
                obj=obj.ReplaceCheck();
           end
           obj=obj.CheckCompletion();
                          
        end
        function obj=Assign(obj,InR,NofR,idx,R_Path)
                               for i=1:NofR
                              InR(i).Target=R_Path(idx+((1-i)*20),:);
                              InR(i).Status='Occupied';
                              InR(i).TaskList='FireFighting';
                              InR(i).Task='FireFighting';
                              InR(i).TaskType="High";
                              InR(i)=InR(i).Start();
                               end
                               obj.InternalRobotData(InR);
                               obj.ResponceAction="Yes";
        end
        function obj=CheckCompletion(obj)
            R=obj.InternalRobotData();
             L=arrayfun(@(x) strcmp(x.Mode,"Idle"),R);
           if sum(L)==length(R) && strcmp(obj.ResponceAction,"Yes")
            switch obj.Mission
                case 'FireFighting'
                         EnM=obj.FRData();
                          if  max(Location.Temp(),[],'all')<25 && EnM(1)==0
                              obj.Complete("Yes");
                          end
                   
                case 'AssetManagement'
                   
                case 'Replace'
            end     
            end
             
        end

        function obj=FireFightingCheck(obj)
                          EnvM=obj.FRData();
                          if strcmp(obj.ResponceAction,"No")
                          if  max(Location.Temp(),[],'all')>27 && EnvM(1)>0
                            if strcmp(obj.Responce,'Intial')
                               NofR=1;
                            elseif strcmp(obj.Responce,'Overwhamling')
                               NofR=4;
                            else
                               NofR=2;
                            end
                              InR=obj.InternalRobotData();
                              SA=obj.InternalRobotTarget();
                              R_Path=obj.InternalRobotPath();
                              [~,idx]=min(pdist2(R_Path, SA(7,:)));
                           obj=obj.Assign(InR,NofR,idx,R_Path);
                          else
                             return;
                          end
                          end
        end
    end
end