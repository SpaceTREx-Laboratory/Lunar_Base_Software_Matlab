classdef SimulationHandler<DataHandler
    % This class handles the graphics of lunarbase software
    %Detailed explanation goes here

    properties
        Screen1Handle;
        Screen2Handle;
    end
    methods
        function obj = SimulationHandler()
           %% Setting up the Moiniter
            MP = get(0, 'MonitorPositions');
            screen_width1 =  MP(1,3);
            screen_height1 =  MP(1,4);
            screen_width2 =  MP(2,3);
            screen_height2 =  MP(2,4);
            Window1=figure('Position', [0, 0, screen_width1, screen_height1], ...
                'MenuBar', 'none', 'NumberTitle', 'off', 'Resize', 'off', ...
                'WindowStyle', 'normal','CloseRequestFcn','','WindowState','fullscreen','Toolbar', 'none','ToolBar','none');
            obj.Screen1Handle = axes('Parent',   Window1,'Position', [0, 0, 1, 1]);
            xlim( obj.Screen1Handle, [0 screen_width1]);
            ylim( obj.Screen1Handle, [0 screen_height1]);
           Window2=figure('Position', [MP(2,1), MP(2,2), screen_width2, screen_height2], ...
                'MenuBar', 'none', 'NumberTitle', 'off', 'Resize', 'off', ...
                'WindowStyle', 'normal','Toolbar', 'none','ToolBar','none','CloseRequestFcn','','WindowState','fullscreen');
            obj.Screen2Handle = axes('Parent',   Window2,'Position', [0, 0, 1, 1]);
            xlim( obj.Screen2Handle, [MP(2,1) screen_width2]);
            ylim( obj.Screen2Handle, [MP(2,2) screen_height2]);
            %% Ploting
            I_e=uint8(zeros(2160,3840,3)); % Black image
            image(I_e,'Parent', obj.Screen2Handle,'Tag','Screen1');% Background color of the Screen1
            image(I_e,'Parent', obj.Screen1Handle,'Tag','Screen2');% Background color of the Screen2
            obj.Screen1(obj.Screen1Handle);
            obj.Screen2(obj.Screen2Handle);
        end

        function obj=Display(obj)


        end
    end
end