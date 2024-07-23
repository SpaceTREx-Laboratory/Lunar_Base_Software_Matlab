function InR=Internal_Robot_config(temp,Path)

Num=12;
Tag="IR"+num2str((1:1:Num)');
j=1;
for i=1:Num
% Robotpath_Start=Path(x(i),:);
max_speed=20;
min_speed=6;
robottype="Modular";
roving_energy_max=0.2;
roving_energy_min=0.1;
% I(Path(x(i),2):Path(x(i),2)+1,Path(x(i),1):Path(x(i),1)+1)=1;
temp_L = randi(size(Path,1));
InR(i)=InternalRobot(Tag(i),Path(temp_L ,:),max_speed,min_speed,robottype,roving_energy_max,roving_energy_min);
 % InR(i).Status='Occupied';
 %                              InR(i).TaskList='Patrol';
 %                              InR(i).Task='Patrol';
 %                              InR(i).TaskType="Low";
 %                              InR(i)=InR(i).Start();
 %                              InR(i).Mode='Patrol';
                          
j=fix(i/2); 
if j==0
    j=1;
end
end

end