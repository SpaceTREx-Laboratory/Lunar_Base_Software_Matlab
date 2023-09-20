classdef SimulationHandler<DataHandler
    % This class handles the graphics of lunarbase software
    %Detailed explanation goes here
 
    methods
        function obj = SimulationHandler()
            MP = get(0, 'MonitorPositions');
            screen_width1 =  MP(1,3);
            screen_height1 =  MP(1,4);
            screen_width2 =  MP(2,3);
            screen_height2 =  MP(2,4);
            Window1=figure('Position', [0, 0, screen_width1, screen_height1], ...
                'MenuBar', 'none', 'NumberTitle', 'off', 'Resize', 'off', ...
                'WindowStyle', 'normal','CloseRequestFcn','','WindowState','fullscreen','Toolbar', 'none','ToolBar','none');
            Screen1Handle = axes('Parent',   Window1,'Position', [0, 0, 1, 1]);
            xlim(Screen1Handle, [0 screen_width1]);
            ylim(Screen1Handle, [0 screen_height1]);
           Window2=figure('Position', [MP(2,1), MP(2,2), screen_width2, screen_height2], ...
                'MenuBar', 'none', 'NumberTitle', 'off', 'Resize', 'off', ...
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
        end
        
        function obj=Main(obj)
             InR=obj.InternalRobotData();
             InR(1).Start();
             InR(1).Status='Occupied';
             InR(3).Start();
             InR(4).Status='Occupied';
            for i=1:6000
        
                InR=arrayfun(@(x) x.Move(),InR,'UniformOutput',true);

                obj.InternalRobotData(InR);
                %arrayfun(@(x) x.Update,obj.PhyDATA(),'UniformOutput',false);
                obj.Display();
            end


        end
        function obj=Display(obj)           
              %Phy=obj.PhyDATA();
               InR=obj.InternalRobotData();
              arrayfun(@(x) x.UpdateGraphicsobj(),InR,'UniformOutput',false);
             % arrayfun(@(x) x.Update(),Phy,'UniformOutput',false);
             pause(0.001)
        end
    
    end
end