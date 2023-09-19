function [I_e,Centriods_path,layer_array]= grid_layers(I_lay)
Env=Environment.Value();
Env_centeriod=Env.center;
I_e=uint8(zeros(2160,3840,1));
mmToPix=3840/1540;
% Load the image with objects
I =I_lay; %value
BW_grids = im2bw(I_e);
% Combine the binary images of the objects and the grids
%BW_combined = BW_objects | BW_grids;
% Fill the grids based on the locations of the objects;
% Get the row and column numbers of the object locations
[rows, cols] = find(im2gray(I)>0);
[BW_filled] = imfill(BW_grids,[rows cols], 4);
BW=BW_filled-BW_grids;
Loc_center = regionprops(logical(BW), 'Centroid');
centroids = round(cat(1,Loc_center.Centroid));
Centriods_path=centroids/mmToPix;
lay_logical= ismember(Env_centeriod,centroids,'rows');
temp=size(Env.Temperature());
layer_array=reshape(lay_logical,[temp(1),temp(2)]);
%layer_array=reshape(lay_logical,216,384);
I_e(repmat(logical(BW),[1,1,2]))=255;
end