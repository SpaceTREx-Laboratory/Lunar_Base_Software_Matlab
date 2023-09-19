function InR=Internal_Robot_config()

Num=5;
Tag="IR"+num2str((1:1:Num)');
for i=1:Num
% Robotpath_Start=Path(x(i),:);
% I(Path(x(i),2):Path(x(i),2)+1,Path(x(i),1):Path(x(i),1)+1)=1;
InR(i)=InternalRobot(Tag(i));
end
end