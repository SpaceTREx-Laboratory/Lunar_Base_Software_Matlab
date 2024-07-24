function [d,path]=Robot_path_planning(Start,endp)
load('RoverTrack.mat')
I=I_temp;
 % C=bwtraceboundary(I,[l(1) m(1)],'W');
 % Path_temp=[C(:,2) C(:,1)];
I_image=I;
D1 = bwdistgeodesic(I_image, Start(1,1), Start(1,2), 'quasi-euclidean');
D2 = bwdistgeodesic(I_image, endp(1,1),  endp(1,2), 'quasi-euclidean');
D = D1 + D2;
D = round(D * 8) / 8;
D(isnan(D)) = inf;
paths = imregionalmin(D);
solution_path = bwmorph(paths,'thin',Inf);
% figure(4);
% %imshow(I)
% hold on
if Start(1,1)>endp(1,1)
    dir='E';
    if Start(1,2)>endp(1,2)
        dir='S';
    else
       dir='N';
    end
else
       dir='W';
end
    C=bwtraceboundary(solution_path,[Start(1,2) Start(1,1)],dir);
    Path=[C(:,2) C(:,1)];
  [~,idx]=ismember(endp,Path,'rows');
% plot(Start(1,1), Start(1,2), 'b*', 'MarkerSize', 15)
% hold on
% plot(endp(1,1),  endp(1,2), 'g*', 'MarkerSize', 15)
% hold on
% plot(Path(1:idx,1),  Path(1:idx,2), 'r', 'MarkerSize', 15)
% hold off
%imshow(solution_path)
path=Path(1:idx,:);
d=idx;
end