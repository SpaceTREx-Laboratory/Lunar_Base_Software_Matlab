classdef ExternalRobot<Robots
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        Property1
    end

    methods
        function obj = ExternalRobot(Tag,Loc)
          obj.ID=obj.TrackObject()+1;
            obj.TrackObject(obj.ID);
            obj.Type="MobileObject";
            obj.SubType="InternalRobot";
          obj.Tag=Tag;
          obj.Loc=Loc; 
          obj.Create(obj);
        end
        function obj=Create(obj)
        Create@Robots(obj);
        end

%         function outputArg = method1(obj,inputArg)
%             %METHOD1 Summary of this method goes here
%             %   Detailed explanation goes here
%             outputArg = obj.Property1 + inputArg;
%         end
    end
end