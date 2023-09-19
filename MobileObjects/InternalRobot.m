classdef InternalRobot<Robots
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here

    properties
      SubType;
    
    end

    methods
        function obj = InternalRobot(Tag)
            obj.ID=obj.TrackObject()+1;
            obj.TrackObject(obj.ID);
            obj.Type="MobileObject";
            obj.SubType="InternalRobot";
          obj.Tag=Tag;
          obj.Track=obj.InternalRobotPath();
          obj.Loc=[obj.Track(1,1) obj.Track(1,2)];    
        obj=obj.CreateGraphicsobj();
        end
       

        function obj=CreateGraphicsobj(obj)
          obj=CreateGraphicsobj@MobileObjects(obj);
        end
        function obj=Start(obj)
               r =10000;
                obj.Target=obj.Track(r,:);
        end
        function obj=Move(obj)
%                planner=plannerAStarGrid(I);
%                 rng('default');
%                 obj.UpdateGraphicobj();
              %  robot_Path=planner.plan(flip(obj.Loc),flip(obj.Target));
            f=find(double(ismember(obj.Track,obj.Loc,"rows"))==1);
              obj.Loc=obj.Track(f+1,:);
               obj=obj.UpdateGraphicsobj();
        end
           function obj=UpdateGraphicsobj(obj)
              obj=UpdateGraphicsobj@MobileObjects(obj);
        end
    end
end