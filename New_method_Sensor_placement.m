% OGDC Algorithm to Determine the Optimal Number of Sensors
clc;
clear;
load("PRAREA.mat");
env_map=imresize(Player,0.2);
load("sensor_locaion.mat");
[r,c]=find(temp);
sum(sum(temp))
Sensor_Loc=[c r];
% Load the binary image (environment)
binaryImage = env_map; % Ensure the image is binary

% Parameters
sensorRadius = 10; % Radius of each sensor's coverage area
maxIterations = 100; % Maximum number of iterations for optimization
coverageThreshold = 0.95; % Desired coverage threshold (e.g., 95%)
initialNumSensors = 100; % Start with 1 sensor

% Find the valid positions (areas where sensors can be placed)
[rows, cols] = find(temp);

% Initialize the number of sensors
numSensors = initialNumSensors;
sufficientCoverageAchieved = false;

% Create meshgrid for coverage calculations
[x, y] = meshgrid(1:size(binaryImage, 2), 1:size(binaryImage, 1));

while ~sufficientCoverageAchieved
    % Initialize sensor positions randomly within the valid areas
    initialIndices = randperm(length(rows), numSensors);
    sensorPositions = [cols(initialIndices), rows(initialIndices)]; % Initial sensor positions
    
    % Optimization loop
    for iter = 1:maxIterations
        % Calculate the current coverage
        coverageMatrix = calculateTotalCoverageMatrix(sensorPositions, binaryImage, sensorRadius);
        totalCoverage = sum(coverageMatrix(:)) / sum(binaryImage(:));
        
        % Check for sufficient coverage
        if totalCoverage >= coverageThreshold
            disp(['Sufficient coverage achieved with ', num2str(numSensors), ' sensors.']);
            sufficientCoverageAchieved = true;
            break;
        end
        
        % Optimize all sensors' positions together
        bestPositions = sensorPositions;
        bestCoverage = totalCoverage;

        % Consider moving all sensors to all combinations of valid positions
        for newIndices = nchoosek(1:length(rows), 2)'
            % Generate new candidate positions for all sensors
            candidatePositions = [cols(newIndices), rows(newIndices)];
            
            % Calculate total coverage for this new configuration
            tempCoverageMatrix = calculateTotalCoverageMatrix(candidatePositions, binaryImage, sensorRadius);
            tempTotalCoverage = sum(tempCoverageMatrix(:)) / numel(binaryImage);
            
            % Update the best positions if this configuration is better
            if tempTotalCoverage > bestCoverage
                bestCoverage = tempTotalCoverage;
                bestPositions = candidatePositions;
            end
        end
        
        % Update sensor positions to the best found configuration
        sensorPositions = bestPositions;
    end
    
    % If coverage is not sufficient, increase the number of sensors
    if ~sufficientCoverageAchieved
        numSensors = numSensors + 10;
    end
end

% Plot the final sensor positions
imshow(binaryImage);
hold on;
plot(sensorPositions(:,1), sensorPositions(:,2), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
title(['Optimal Sensor Placement with ', num2str(numSensors), ' Sensors']);
hold off;

% Helper function to calculate coverage matrix for all sensors
