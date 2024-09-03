classdef SimulationHandler<DataHandler
    % This class handles the graphics of lunarbase software
    % Detailed explanation goes here
    properties
        SchedulerObj; 
        FireVisualizerObj;
        TextHandle;
    end
    methods
        function obj = SimulationHandler()
            MP = get(0, 'MonitorPositions');
            screen_width1 =  MP(1,3);
            screen_height1 =  MP(1,4);
            screen_width2 =  MP(2,3);
            screen_height2 =  MP(2,4);
            Window1=figure('Position', [0, 0, screen_width1, screen_height1], ...
                'MenuBar', 'none', 'NumberTitle', 'off', 'Resize', 'on', ...
                'WindowStyle', 'normal','Toolbar', 'none','ToolBar','none','CloseRequestFcn','','WindowState','fullscreen');
            
            Screen1Handle = axes('Parent',   Window1,'Position', [0, 0, 1, 1]);
            xlim(Screen1Handle, [0 screen_width1]);
            ylim(Screen1Handle, [0 screen_height1]);
           Window2=figure('Position', [MP(2,1), MP(2,2), screen_width2, screen_height2], ...
                'MenuBar', 'none', 'NumberTitle', 'off', 'Resize', 'on', ...
                'WindowStyle', 'normal','Toolbar', 'none','ToolBar','none','CloseRequestFcn','','WindowState','fullscreen');
            Screen2Handle = axes('Parent',   Window2,'Position', [0, 0, 1, 1]);
            xlim(Screen2Handle, [MP(2,1) screen_width2]);
            ylim(Screen2Handle, [MP(2,2) screen_height2]);
            %% Ploting
            I_e=uint8(zeros(2160,3840,3)); % Black image
            image(I_e,'Parent', Screen2Handle,'Tag','Screen1');% Background color of the Screen1
            image(I_e,'Parent', Screen1Handle,'Tag','Screen2');% Background color of the Screen2
            obj.Screen1Handle(Screen1Handle);
            obj.Screen2Handle(Screen2Handle);
            obj.TrackObject(0);
           %obj.SchedulerObj=Scheduler('Intial','FireFighting');
           obj.SchedulerObj=Scheduler('Overwhamling','FireFighting');
         %'Overwhamling
        end
        
        function obj=Main(obj)
            %% Updating robots
            [Single_fire,Env,tend]=Fire_config();
            temp=Location.Temp();
            rng("shuffle");
            Lo=Single_fire(randi(10,1)).Loc();
            temp(Lo(1),Lo(2))=60+randi(20,1);
            Location.Temp(temp);
            Fire_loc=7+randi(21,1);
            obj.Fire_Location(Fire_loc);
            obj.FireVisualizerObj=FireVisualizer();
            obj.FireVisualizerObj= obj.FireVisualizerObj.CreateGraphicsObj(temp);
            %% Fire

            SA=obj.InternalRobotTarget();
            Locat=arrayfun(@(x) x.Loc,Single_fire,'UniformOutput',false);
            c=Location.Fire();
            for j=1:length(Single_fire)
                LocFire=Locat{1,j};
                c(LocFire(1,1),LocFire(1,2))=1;
            end
            Location.Fire(c);
            q_n=0;
            SMT=2000;
            S_f=randi(10,1);
            Single_fire(S_f).Status="on";
            str="Maximum HRR : "+num2str(q_n/1000)+ " (kW)";
            obj.TextHandle=text(obj.Screen1Handle,0,200,str,'Color','w','FontSize',18,'BackgroundColor','blue');
            F3=figure('Tag','HRR','MenuBar', 'none', 'NumberTitle', 'off','ToolBar','none','Position',[100 100 700 500]);
            Screen3Handle = axes('Parent',   F3);
            xlabel('time (s) ')
            ylabel('HRR (kW) ')
            h = animatedline('LineWidth',5);
            axis([0 1500 0 2100])
            set(gca,'FontSize',16);
            box on;
            title('Heat Realase Rate')
            F4=figure('MenuBar', 'none', 'NumberTitle', 'off','ToolBar','none','Position',[1000 100 700 500]);
            Screen4Handle = axes('Parent',   F4);
            Single_fire_m=arrayfun(@(x) x.m_r,Single_fire);
            x = {'M1';'M2';'M3';'M4';'M5';'M6';'M7';'M8';'M9';'M10'};
            hb=bar(Single_fire_m);
            xticklabels(x);
            hb.FaceColor = 'flat';
            title('Burning material mass');
            set(Screen4Handle,"FontSize",16);
            ylabel(" % of mass remaining")
            xlabel("Materials")
            ylim([0 100]);
            for i=1:SMT
                InR=obj.InternalRobotData();
                Single_fire=arrayfun(@(x) x.update(),Single_fire);
                Single_fire_m=arrayfun(@(x) x.m_r,Single_fire);
                hb.YData=Single_fire_m;
                arrayfun(@(x) x.update(),Env,'UniformOutput',false);
                FS=cell2mat(arrayfun(@(x) x.q==0,Single_fire,'UniformOutput',false));
                L_fire=logical(cell2mat(arrayfun(@(x) (x.Status=="on" && x.q>0),Single_fire,'UniformOutput',false)));
                
                if sum(double(L_fire))>0 
                    
                    hb.CData(L_fire,:)=repmat([1 0 0],sum(double(L_fire)),1);
                    LL=find(L_fire);
                    for jj=1:length(LL)
                        x{LL(jj)}= "M"+num2str(LL(jj))+" on Fire";

                    end
                    set(Screen4Handle,'XTickLabel',x);

                    Ls=arrayfun(@(x) pdist2(x.Loc,SA(obj.Fire_Location(),:))<50,InR);

                    if sum(Ls)>=1 && q_n~=0

                       Single_fire(L_fire)=arrayfun(@(x) x.FireKilling(sum(Ls),"1"),Single_fire(L_fire),'UniformOutput',true);
                   
                    end
                end

                q_n=sum(arrayfun(@(x) x.q,Single_fire));
                q_mean(i)=q_n;
                temp=Location.Temp();
                MeanTemp(i)=mean(temp,"all");
                obj.FRData([q_n MeanTemp(i)]);
                InR=arrayfun(@(x) x.Update(),InR,'UniformOutput',true);
                obj.InternalRobotData(InR);
             
                str="Maximum HRR : "+num2str(q_n/1000)+ " (kW)";
                obj.TextHandle.String=str;
                obj.SchedulerObj=obj.SchedulerObj.Update();
  
                addpoints(h,i,q_n/1000);
                obj.FireVisualizerObj=obj.FireVisualizerObj.UpdateGraphicsObj(temp);
                FSL=find(FS);
                for jj=1:length(FSL)
                    x{FSL(jj)}= "M"+num2str(FSL(jj));
                    hb.CData(FSL(jj),:)=[0 0.4470 0.7410];
                end
                set(Screen4Handle,'XTickLabel',x);
                pause(0.001)
                if i>200 && MeanTemp(i)<25.01
                if sum(q_mean(i-200:i))==0
                    Single_fire(S_f).Status='off';
                    close(figure(3));
                    close(figure(4));
                    
                    obj.FireVisualizerObj=obj.FireVisualizerObj.DeleteGraphicsObj();
             
                   
                    break;   
                end
                end
            end
                   close(figure(3));
                    close(figure(4));
                    
                    obj.FireVisualizerObj=obj.FireVisualizerObj.DeleteGraphicsObj();
            end
        function obj=Display(obj)           
               %Phy=obj.PhyDATA();
               InR=obj.InternalRobotData();
               %obj.FireVisualizerObj.UpdateGraphicsObj(temp);
              arrayfun(@(x) x.UpdateGraphicsobj(),InR,'UniformOutput',false);
              % arrayfun(@(x) x.Update(),Phy,'UniformOutput',false);
             pause(0.001)
        end
    
    end
end