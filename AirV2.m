classdef AirV2
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        Loc % Location
        Temp % Temperature
        K % Cooling Constant
        time=1;
    end

    methods
        function obj = AirV2(Loc,K)
            %   Detailed explanation goes here
            obj.Loc = Loc;
            obj.K=-0.018;
        end

        function obj = update(obj)
            temp=Location.Temp();
           %  temp1=Location.Fire();
           % if temp1(obj.Loc(1),obj.Loc(2))==1
           %     return;
           % end
         
            if mean(temp,'all')>25
                %obj.time=obj.time;
                obj.Cooling();
            else
                return;
            end
        end
        function obj = Cooling(obj)
            temp1=Location.Temp();
            grid_size=size(temp1);
            T_amb = repmat(25,grid_size(1),grid_size(2));
            temp1= T_amb+((temp1- T_amb)*exp(obj.K));
            % obj.Temp=25+((obj.Temp-25)*exp(obj.K*obj.time));
            %  %  obj.Temp=obj.Temp+(obj.K*obj.time);
            %  if obj.Temp<25
            %      obj.Temp=25;
            %  end
            % temp1(obj.Loc(1),obj.Loc(2))=obj.Temp;
            Location.Temp(temp1);
        end
    end
end