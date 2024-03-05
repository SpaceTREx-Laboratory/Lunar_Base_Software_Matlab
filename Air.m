classdef Air
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        Loc % Location
        Temp % Temperature
        K % Cooling Constant
        time=1;
    end

    methods
        function obj = Air(Loc,K)
            %   Detailed explanation goes here
            obj.Loc = Loc;
            obj.K=-0.013;
        end

        function obj = update(obj)
            temp=Location.Temp();
            temp1=Location.Fire();
           if temp1(obj.Loc(1),obj.Loc(2))==1
               return;
           end
            obj.Temp=temp(obj.Loc(1),obj.Loc(2));
            if obj.Temp>mean(temp,'all')
                obj.time=obj.time;
              obj.Cooling();
            else
                return;
            end
        end
        function obj = Cooling(obj)
            temp1=Location.Temp();
            obj.Temp=35+((obj.Temp-35)*exp(obj.K*obj.time));
             %  obj.Temp=obj.Temp+(obj.K*obj.time);
            temp1(obj.Loc(1),obj.Loc(2))=obj.Temp;
            Location.Temp(temp1);
        end
    end
end