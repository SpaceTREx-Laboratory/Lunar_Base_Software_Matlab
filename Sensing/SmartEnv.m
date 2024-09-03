classdef SmartEnv<SMSU
    %SMARTENV Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Property1
    end
    
    methods
        function obj = SmartEnv(Loc,Ran)
            %SMARTENV Construct an instance of this class
            %   Detailed explanation goes here
            obj.Loc=Loc;
            obj.RangeV=Ran;
            gridSize=size(obj.EnvDatalogic());
            [x, y] = meshgrid(1:gridSize(1), 1:gridSize(2));

% Calculate distance from the source point to all other points in the grid
            distances = sqrt((x - obj.Loc(1) ).^2 + (y - obj.Loc(2)).^2)';
            obj.RangeL=distances<obj.RangeV;
            obj.RangeL=obj.RangeL & obj.EnvDatalogic();
            %% Elemanting connected region

            CC = bwconncomp(obj.RangeL);

% Calculate the centroid of each connected component
centroids = regionprops(CC, 'Centroid');
centroids = cat(1, centroids.Centroid);  % Convert from struct to an array

% Calculate the Euclidean distance from the specified point to each centroid
distances = sqrt((centroids(:,1) - obj.Loc(1)).^2 + (centroids(:,2) - obj.Loc(2)).^2);

% Find the index of the nearest connected component
[~, nearestIdx] = min(distances);

% Create a new binary image that contains only the nearest connected component
C_nearest = false(size(obj.RangeL));
C_nearest(CC.PixelIdxList{nearestIdx}) = true;
obj.RangeL=C_nearest;
%imshow(C_nearest);
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

