function Robot_Destination 
   Data=readtable('Internal Robot Destination.xlsx','Sheet','Sheet1','VariableNamingRule','preserve');
   I_designation=uint8(zeros(2160,3840,3));
   mmToPix=3840/1540;
   X=Data.X*mmToPix;
   Y=Data.Y*mmToPix;
  I_designation=insertShape(I_designation,"FilledCircle",[X Y repmat(1.45,length(X),1)],"Color",'red');
  [I_phy_gridlayer,~,I_designation_data_mask]=grid_layers(I_designation);
  Internal_Robot.Designation_datamask(I_designation_data_mask);
  [m,l]=find(I_designation_data_mask);
    Path=Internal_Robot.Path_Data();
    Des=[];
for i=1:length(X)
    [~,idx(i)]=min(pdist2([l(i) m(i)],Path));
    Des=[Des;Path(idx(i),:)];
end
  A.X=Des(:,1);
  A.Y=Des(:,2);
  A.Tag=Data.Tag;
  temp=ismember(Des,Path,'rows');
  Ih=insertText(double(I_designation_data_mask),[l m],A.Tag,"FontSize",15,"TextColor","green","BoxColor","magenta");
  % imshow(Ih);
  Internal_Robot.Designation(A);
end