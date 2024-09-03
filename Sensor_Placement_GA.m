clc;
clear;
load("one_SA.mat")
env_map=M;
 load("Snloc_SA.mat");
 Sensor_Loc=[MN(1:end-1,2) MN(1:end-1,1)];
% load("PRAREA.mat");
% env_map = imresize(Player, 0.2);
% load("sensor_locaion.mat");
% [r, c] = find(temp);
% Sensor_Loc = [c r];
sensor_radius = 20; % Sensor coverage radius for isotropic sensors
comm_radius = 40; % Communication radius for network connectivity
prob_sensor=false;
% Desired Coverage Threshold
coverageThreshold = 0.95; % Desired coverage (95%)
% Get dimensions of the environment
[rows, cols] = size(env_map);
% Initialize sensor positions
allowed_positions = Sensor_Loc;
num_allowed_positions = size(allowed_positions, 1);

% Genetic Algorithm Parameters
population_size = 40;
max_generations = 20;
mutation_rate = 0.01;
initial_num_sensors = 3; % Start with 50 sensors
max_num_sensors = 1000; % Maximum number of sensors to test

% Iteratively increase the number of sensors
for num_sensors = initial_num_sensors:1:max_num_sensors

    % Generate initial population
    initial_population = randi([1, num_allowed_positions], population_size, num_sensors);

    % Set up bounds for indices
    lb = ones(1, num_sensors); % Lower bound: index 1
    ub = num_allowed_positions * ones(1, num_sensors); % Upper bound: max index of allowed positions

    % Genetic Algorithm Optimization (Modified)
    options = optimoptions('ga', 'PopulationSize', population_size, 'MaxGenerations', max_generations, ...
        'MutationFcn', @(parents, options, nvars, FitnessFcn, state, thisScore, thisPopulation) ...
        mutationCustom(parents, options, nvars, FitnessFcn, state, thisScore, thisPopulation, num_allowed_positions), ...
        'Display', 'iter', 'InitialPopulationMatrix', initial_population);

    [optimized_indices, fval] = ga(@(indices) coverage_objective(round(indices), allowed_positions, env_map, sensor_radius, comm_radius, prob_sensor), ...
        num_sensors, [], [], [], [], lb, ub, [], options);

    % Convert optimized indices to positions
    optimized_positions = allowed_positions(round(optimized_indices), :);
     coverage = coverage_area_fx(optimized_positions,env_map,num_sensors,sensor_radius);
    % Calculate final coverage score
    final_coverage = coverage / sum(env_map(:));
  disp('final_coverage');
    % Check if desired coverage is achieved
    if final_coverage >= coverageThreshold
        disp(['Desired coverage of ', num2str(coverageThreshold*100), '% achieved with ', num2str(num_sensors), ' sensors.']);
        break;
    else
        disp(['Coverage with ', num2str(num_sensors), ' sensors is ', num2str(final_coverage*100), '%. Increasing sensor count.']);
    end
    figure(1);
imshow(env_map);
hold on;
plot(optimized_positions(:,1), optimized_positions(:,2), 'go');
title(['Optimized Sensor Placement with ', num2str(num_sensors), ' Sensors']);
end

% Plot results
figure;
imshow(env_map);
hold on;
plot(optimized_positions(:,1), optimized_positions(:,2), 'go');
title(['Optimized Sensor Placement with ', num2str(num_sensors), ' Sensors']);
hold off;

% Display final coverage score
disp(['Final combined score: ', num2str(final_coverage)]);

% Coverage Objective Function
function score = coverage_objective(indices, allowed_positions, env_map, sensor_radius, comm_radius, prob_sensor)
    % Convert indices to actual sensor positions
    indices = round(indices);
    sensor_positions = allowed_positions(indices, :);
    num_sensors = size(sensor_positions, 1);
    
    % Add penalty if there are duplicate indices
    if length(unique(indices)) < num_sensors
        duplicate_penalty = 1000; % Large penalty for duplicates
    else
        duplicate_penalty = 0;
    end
    
    % Calculate coverage map using vectorized operations
    [rows, cols] = size(env_map);
    [X, Y] = meshgrid(1:cols, 1:rows);
    
    if prob_sensor
        % Probabilistic sensor model (Gaussian distribution)
        sigma = sensor_radius / 3;
        coverage_map = zeros(rows, cols);
        
        for i = 1:num_sensors
            dx = X - sensor_positions(i,1);
            dy = Y - sensor_positions(i,2);
            coverage_map = coverage_map + exp(-(dx.^2 + dy.^2) / (2 * sigma^2));
        end
    else
        % Isotropic sensor model (uniform coverage)
      covered_area=coverage_area_fx(sensor_positions,env_map,num_sensors,sensor_radius);
    end
    
    % Compute coverage score
   % covered_area = sum(sum(coverage_map > 0 & env_map == 1));
    total_free_area = sum(env_map(:));
    coverage_score = covered_area / total_free_area;

    % Network Connectivity and Latency
    % Network Connectivity and Latency
    dist_matrix = pdist2(sensor_positions, sensor_positions);
    connectivity_matrix = dist_matrix <= comm_radius & dist_matrix > 0;
    
    G = graph(connectivity_matrix);
    is_connected = all(conncomp(G) == 1);
    
    latency_sum = sum(dist_matrix(connectivity_matrix));
    max_latency = max(dist_matrix(connectivity_matrix));
    
    avg_latency = latency_sum / (num_sensors * (num_sensors - 1) / 2);
    normalized_max_latency = max_latency / comm_radius;

    connectivity_penalty = 0;
    if ~is_connected
        connectivity_penalty = 1; % Maximum penalty if the network is not connected
    end
    
    alpha = 0.5; % Weight for coverage
    beta = 0.25; % Weight for connectivity penalty
    gamma = 0.25; % Weight for latency minimization
    delta = 0.1; % Additional weight for avoiding redundancy

     min_dist = min(dist_matrix(dist_matrix > 0));  % Minimum distance between any two sensors
    redundancy_penalty = 0;
    if min_dist < sensor_radius
        redundancy_penalty = (sensor_radius - min_dist) / sensor_radius;
    end
 
    if isempty(max_latency)
    normalized_max_latency=avg_latency;
    end
    offset = 1;
    %score = 1 / (alpha * coverage_score - beta * connectivity_penalty - gamma * (normalized_max_latency + avg_latency) + offset) + duplicate_penalty ;
    score = 1 / (alpha * coverage_score - beta * connectivity_penalty+offset- gamma *redundancy_penalty)+duplicate_penalty;
    %score = 1 / ( coverage_score)+duplicate_penalty;

    if isempty(score)
       disp('uu') 
    end
figure(1);
imshow(env_map);
hold on;
plot(sensor_positions(:,1), sensor_positions(:,2), 'go');
title(['Optimized Sensor Placement with ', num2str(num_sensors), ' Sensors','Total Coverage: ',num2str(coverage_score)]);
   %score=  1/coverage_score;
%score=  1/(coverage_score)+ duplicate_penalty;
end

% Custom Mutation Function to Ensure Integer Indices
function mutationChildren = mutationCustom(parents, options, nvars, FitnessFcn, state, thisScore, thisPopulation, num_allowed_positions)
    mutationChildren = round(mutationgaussian(parents, options, nvars, FitnessFcn, state, thisScore, thisPopulation));
    mutationChildren = max(min(mutationChildren, num_allowed_positions), 1); % Keep indices within bounds
end

function covered_area=coverage_area_fx(sensor_positions,env_map,num_sensors,sensor_radius)
[rows, cols] = size(env_map);
    [X, Y] = meshgrid(1:cols, 1:rows);
 coverage_map = zeros(size(env_map));
        for i = 1:num_sensors
            dist = sqrt((X - sensor_positions(i,1)).^2 + (Y - sensor_positions(i,2)).^2);
            coverage_map(dist <= sensor_radius) = 1;
        end
        covered_area = sum(sum(coverage_map > 0 & env_map == 1));
end