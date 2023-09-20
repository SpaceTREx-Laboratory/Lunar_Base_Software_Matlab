classdef InternalRobot<Robots
%% This is internal Robot Class
    %  NTITLED3 Summary of this class goes here
    %   Detailed explanation goes here

    properties (Dependent) 
        Current
        Max
        Min
    end
%% Internal Robot's Constructor
    methods
        function obj = InternalRobot(Tag)

            obj.ID=obj.TrackObject()+1;
            obj.TrackObject(obj.ID);
            obj.Type="MobileObject";
            obj.SubType="InternalRobot";
            obj.Tag=Tag;

            %% Robot's Permance Parameters
            obj.Speed.Max=ceil(randperm(5,1)/obj.PixTom);
            obj.Speed.Current=  ceil(obj.Speed.Max*0.70);
            obj.Path=obj.InternalRobotPath();
            obj.HomeLocation=[obj.Path(1,1) obj.Path(1,2)];
            obj.Loc=[obj.Path(1,1) obj.Path(1,2)];
            obj=obj.CreateGraphicsobj();
        end

    end

  methods (Access=public)
      %% This are the elemental tasks and operations that can be accessed from out side

       function obj=Start(obj)
            r =10000;
            obj.Target=obj.Path(r,:);
       end
  end


    methods 
        function obj=CreateGraphicsobj(obj)
            obj=CreateGraphicsobj@MobileObjects(obj);
        end
        function obj=Move(obj)
            %                planner=plannerAStarGrid(I);
            %                 rng('default');
            %                 obj.UpdateGraphicobj();
            %  robot_Path=planner.plan(flip(obj.Loc),flip(obj.Target));

            if strcmp(obj.Status,'Occupied')
            f=find(double(ismember(obj.Path,obj.Loc,"rows"))==1);
            f=f(1);
            if (f+obj.Speed.Current)<size(obj.Path,1)
            obj.Loc=obj.Path(f+obj.Speed.Current,:);
            obj=obj.UpdateGraphicsobj();
            else
            obj.Loc=obj.HomeLocation;
            obj.Status='Idle';
            end
            else
            return;
            end
            
        end
        function obj=UpdateGraphicsobj(obj)
            obj=UpdateGraphicsobj@MobileObjects(obj);
        end
    end
end