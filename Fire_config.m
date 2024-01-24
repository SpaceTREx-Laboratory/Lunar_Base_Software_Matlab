function [Single_fire, Env, tend] = Fire_config
grid_size = 15;
c = zeros(grid_size);
T_amb = repmat(25,grid_size,grid_size);
Location.Temp(T_amb);
Location.Fire(c);
% t0=0;
% t1MW=150; % or kW
%  tl0=170;
%  td=670;
% tend=2000;
% tg=150;
t0=80;
%t1MW=linspace(150,95,10); % or kW
t1MW=85;
tl0=180;
% tl0=[180;188;190;192;186;180;188;190;192;186];
td=190;
 %td=[190;200;230;205;237;198;201;207;225;204];
tend=460;
 %tend=[460;500;470;480;600;700;800;560;499;766];
 % tg=[30;34;32;29;10;15;47;57;37;33];
tg=30;
 L=[1 3;12 6;10 7;5 7;7 9;11 12;12 10;1 5;4 5;3 2];
 Ti=[50;40;70;54;55;45;38;52;30;55];
 In=[7;3;2.5;6;5;7;3;2.5;6;5];
K=[100;39;20;51;76;100;39;20;51;76]/1000000;
for i=1:size(In)
Single_fire(i)=Fire(t0,t1MW,tl0,td,tend,tg,L(i,:),Ti(i),In(i),K(i));
end
   [Cc,Rc]=find(Location.Temp()>0);
for i=1:length(Rc)
    Env(i)=AirCooling([Cc(i) Rc(i)],-35);
end
   Ll=ismember([Cc Rc],L,"rows");
Locat=arrayfun(@(x) x.Loc,Single_fire,'UniformOutput',false);
for i=1:length(Single_fire)
LocFire=Locat{1,i};
c(LocFire(1,1),LocFire(1,2))=1;
end
Location.Fire(c);
end

