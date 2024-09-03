classdef FireV3<handle
    % Fire modelling analytical
   properties
        t0 % time to the onset of ignition
        t1MW % time to reach 1 MW
        tlo  % level-off time
        td   % time at which Q_dot q_max begins
        t_end % time at with Q_dot equals zero
        tg    % growth time t1MW to t0
        q   % Heat release rate Q_dot
        alpha_g % fire_growth coefficient
        alpha_d % fire_decay coefficient
        q_max % maximum heat release
        q_history % Heat release history
        T % Temperature
        Loc % Location
        cp % Specific heat
        m % mass
        m_r % remaining mass
        c_r % consumption rate
        T_i %ingition temperature
        Location_T;
        T_L; % Room temperature
        k% cooling rate
        ambT;
        LocalT;
        Influ;% Influence radius
        Status="off";
        Tm=1;
    end

    methods (Access=public)
        function obj = FireV3(time_onset,time_1MW, time_level_off, time_q_max, time_q_zero,time_q_growth,Loc,Ti,in,k)
            % function obj = Fire_V1(time_onset,time_1MW, time_level_off, time_q_max, time_q_zero,time_q_growth)
            %  Fire Constructor
            obj.t0 = time_onset;
            obj.t1MW = time_1MW;
            obj.tlo=time_level_off;
            obj.td=time_q_max;
            obj.t_end=time_q_zero;
            obj.tg=time_q_growth;
            obj.q_max=1000*((obj.tlo-obj.t0)/(obj.t1MW-obj.t0))^2;
            obj.alpha_d=obj.q_max/(obj.t_end-obj.td)^2;
            obj.alpha_g=1000/(obj.t1MW-obj.t0)^2;
            obj.q_history=[];
            obj.Loc=Loc;
            obj.m=100; % Intial Mass
            obj.cp=1870; % specific heat
            obj.c_r=obj.m/(obj.t_end-obj.t0); % heat realse rate
            obj.T_L=[]; % Location Temperature history 
            obj.T_i=Ti; % Ingnation Temp
            obj.LocalT=0; %Local temperature
            obj.Influ=in;
            obj.k=k;
            obj.m_r=obj.m;
        end

        function obj = update(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
           
            temp=Location.Temp();
            obj.Location_T=temp(obj.Loc(1),obj.Loc(2));

            if (obj.Location_T>obj.T_i) && (obj.m_r>0)
                obj.Status="on";
                obj.LocalT=obj.LocalT+1;
                if obj.LocalT>=0 && obj.LocalT<=obj.t0
                    obj.q=0;
                elseif obj.LocalT>obj.t0 && obj.LocalT<=obj.tlo
                    obj=obj.growth_I(obj.LocalT);
                elseif obj.LocalT>obj.tlo && obj.LocalT<=obj.td
                     obj=obj.growth_II();
                elseif obj.LocalT>obj.td && obj.LocalT<=obj.t_end
                     obj=obj.decay(obj.LocalT);
                else
                    obj.q=0;
                    temp1=Location.Fire();
                    temp1(obj.Loc(1),obj.Loc(2))=0;
                    Location.Fire(temp1);
                end
                if obj.q>0
                temp1=Location.Fire();
                temp1(obj.Loc(1),obj.Loc(2))=1;
                Location.Fire(temp1);
                end
            else
                obj.q=0;
                temp1=Location.Fire();
                temp1(obj.Loc(1),obj.Loc(2))=0;
                Location.Fire(temp1);
            end
            if obj.q>0
            
            obj.Mass_consumption(obj.LocalT);
            end
            obj.Temperature_update(obj.LocalT);
            obj.Surronding_Temperature();
            obj.q_history=[obj.q_history;obj.q];
        end
    end
    %% Methods
    methods (Access=private)
        function obj=growth_I(obj,t)
            obj.q=obj.alpha_g*(t-obj.t0)^2;
        end
        function obj=growth_II(obj)
            obj.q=obj.alpha_g*(obj.tlo-obj.t0)^2;
        end
        function obj=decay(obj,t)
            obj.q=obj.alpha_d*(obj.t_end-t)^2;
        end
        %% Temperature update
        function obj=Temperature_update(obj,t)
            obj.T=0;
            if obj.m_r>0
                obj.T=9.1*(0.7*obj.q/1000)^(2/3)*(mean(Location.Temp(),'all')/(9.81*1.225^2*obj.cp^2))^(1/3);
            else
                obj.T=0;
            end
            if t>=obj.td && obj.Location_T> mean(Location.Temp(),'all')
                obj.Location_T=25+((obj.Location_T-25)*exp(-obj.k*t));  % Newton's law of cooling
                 if obj.Location_T <25
                     obj.Location_T=25;
                 end
                if isnan(obj.Location_T)
                    disp("Erreo");
                end
            else
                if isnan(obj.Location_T)
                    disp("Erreo");
                end
                obj.Location_T=obj.Location_T+obj.T;
           end
            obj.T_L=[obj.T_L;obj.Location_T];
            temp=Location.Temp();
            temp(obj.Loc(1),obj.Loc(2))=obj.Location_T;
            Location.Temp(temp);
        end
        %% Mass consumption
        function obj=Mass_consumption(obj,t)
            
            obj.m_r=obj.m-(obj.c_r*(t-obj.t0));
            obj.Tm= obj.Tm+1;
        end
        %% 
        function obj=Surronding_Temperature(obj)
            [Cc,Rc]=find(Location.Temp()>0);
            Ll=find(((pdist2([Cc Rc],obj.Loc)<obj.Influ))==1);
            temp=Location.Temp();
            if obj.m_r>0
                obj.T=obj.q/(obj.m_r*obj.cp);
            else
                obj.m_r=0;
                obj.T=0;
            end

% Create meshgrid for distance calculation
gridSize=size(temp);
[x, y] = meshgrid(1:gridSize(1), 1:gridSize(2));

% Calculate distance from the source point to all other points in the grid
distances = (x - obj.Loc(1) ).^2 + (y - obj.Loc(2)).^2;
distances(obj.Loc(2),obj.Loc(1))=1;
temp1=temp+(obj.T*0.7./(distances'));
if obj.T>0
temp1(obj.Loc(1),obj.Loc(2))=temp1(obj.Loc(1),obj.Loc(2))+obj.T;
end
% tic
%             for i=1:length(Ll)
%                 d=pdist2([Cc(Ll(i)) Rc(Ll(i))],obj.Loc);
%                 if d>0
% 
% 
%                     temp(Cc(Ll(i)),Rc(Ll(i)))=temp(Cc(Ll(i)),Rc(Ll(i)))+(obj.T*0.7/d^2);
%                     if temp(Cc(Ll(i)),Rc(Ll(i))) < mean(Location.Temp(),'all')
%                         temp(Cc(Ll(i)),Rc(Ll(i)))= 25;
%                     end
%                 end
%             end
%             toc
            Location.Temp(temp1);
        end
     end
    methods
        function obj=FireKilling(obj,n,type)
           obj.Location_T= obj.Location_T-((9.1*(0.7*n*30)^(2/3)*(mean(Location.Temp(),'all')/(9.81*1.225^2*obj.cp^2))^(1/3)));
          if obj.Location_T<obj.T_i
             %obj.Location_T=25;
              obj.Status='off';
             temp1=Location.Fire();
             temp1(obj.Loc(1),obj.Loc(2))=0;
             Location.Fire(temp1);
          end
          obj.q=obj.q-(n*10000);
          if obj.q<0
              obj.q=0;
              temp1=Location.Fire();
              temp1(obj.Loc(1),obj.Loc(2))=0;
              Location.Fire(temp1);
          end
           obj.q_history(end)=obj.q;
          [Cc,Rc]=find(Location.Temp()>0);
            Ll=find(((pdist2([Cc Rc],obj.Loc)<n*3))==1);
            temp=Location.Temp();
          temp(Cc(Ll),Rc(Ll))=temp(Cc(Ll),Rc(Ll))-(9.1*(0.7*n*30)^(2/3)*(mean(Location.Temp(),'all')/(9.81*1.225^2*obj.cp^2))^(1/3));
          t=temp<25;
          temp(t)=25;
           obj.T_L(end)=obj.Location_T;
           Location.Temp(temp);
         end
    end
end