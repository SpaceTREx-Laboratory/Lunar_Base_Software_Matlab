function SM=SmartSensorConfig(temp)
[r,c]=find(temp);
nofS=1000;
Loc=[c r];
te=randi(length(r),[nofS 1]);
figure(5)
imshow(temp)
hold on;
sumz=zeros(size(temp));
for i=1:nofS
SM(i)=SmartEnv([Loc(te(i),2) Loc(te(i),1)],10);
plot(Loc(te(i),1),Loc(te(i),2),'*r');
hold on
sumz=sumz+SM(i).RangeL;
%plot(Loc(te(i),:),'*r');
end
hold on;
imshow(sumz);
end