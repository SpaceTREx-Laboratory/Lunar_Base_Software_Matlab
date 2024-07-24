clc;
clear;
close force all;
load('RoverTrack.mat')
I=I_temp;
[r,c]=find(I==true);
I_image=I;
loc=r(70000);
D1 = bwdistgeodesic(I_image, c(1), r(1), 'quasi-euclidean');
D2 = bwdistgeodesic(I_image, c(loc), r(loc), 'quasi-euclidean');
D = D1 + D2;
D = round(D * 8) / 8;
D(isnan(D)) = inf;
paths = imregionalmin(D);
solution_path = bwmorph(paths, 'thin', inf);
thick_solution_path = imdilate(solution_path, ones(3,3));
[r1,c1]=find(thick_solution_path==true);
size(r1,1)
I_image=I;
P = imoverlay(I_image, thick_solution_path, [1 0 0]);
imshow(P)
hold on
plot(c(1), r(1), 'g*', 'MarkerSize', 15)
plot(c(loc), r(loc), 'g*', 'MarkerSize', 15)
hold off