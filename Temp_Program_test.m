% Define arrays A and B
A = [ ... % Define your nx2 array here
    % Example:
    1.2, 3.4;
    2.1, 4.5;
    3.3, 2.2;
    4.0, 5.1;
 
];

B = [ ... % Define your nx2 array here
    % Example:
    3.2, 1.1;
   
];

% Calculate pairwise Euclidean distances between points in B and A
distances =pdist2(B, A);

% Find the minimum distance for each point in B and its corresponding index
[sortedDistances, sortedIndices] = sort(distances);

% Display the sorted distances and corresponding indices
disp('Sorted distances:');
disp(sortedDistances);

disp('Sorted indices:');
disp(sortedIndices);
% Display the sorted B array and corresponding indices