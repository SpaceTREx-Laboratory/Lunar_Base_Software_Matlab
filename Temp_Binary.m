clc;
clear;
load("SA_LOC.mat");
load('PRAREA.mat');
bIN=imresize(Player,0.2);
sensorRadius=23;

M=calculateTotalCoverageMatrix(SA_Loc(7,:), bIN, sensorRadius);
[r,c]=find(M);
C=bwtraceboundary(M,[r(1) c(1)],"N");
MN=C;
imshow(M);
hold on;
plot(C(:,2), C(:,1), 'go');
