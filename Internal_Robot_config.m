 function InR=Internal_Robot_config()

Num=2;
Tag="IR"+num2str((1:1:Num)');
for i=1:Num
% Robotpath_Start=Path(x(i),:);
max_speed=2;
min_speed=1;
robottype="Modular";
roving_energy_max=0.2;
roving_energy_min=0.1;
% I(Path(x(i),2):Path(x(i),2)+1,Path(x(i),1):Path(x(i),1)+1)=1;
InR(i)=InternalRobot(Tag(i),max_speed,min_speed,robottype,roving_energy_max,roving_energy_min);
end
end