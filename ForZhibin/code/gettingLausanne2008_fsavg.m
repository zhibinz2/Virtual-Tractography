% I have volumes currently for the weird reduced parcellation.
% 
% I can take each vertex, and I have the vertex location inside Brain. I just need to check either the closest point on the larger surface/which volume (this can be directly indexed
% ie the volume can be directly indexed to iedentify where each vertex sits. 
addpath(genpath('/usr/share/fsl/5.0/etc/matlab'))
addpath(genpath('~/Downloads/vol3d/'))
%%
tmp = read_avw('ROIv4_HR_th.nii.gz');
tmp = permute(tmp, [1 3 2]);
tmp = tmp(256:-1:1,:, 256:-1:1);
parcels = tmp;
% when viewed using: 
% vol3d('XData', [min(x), max(x)], 'YData', [min(y), max(y)], 'ZData', [min(z), max(z)], 'CData', permute(tmp, [2,1,3]));
% it looks oriented correctly. Higher valued labels in left hemi as
% expected. Also, note that vol3d and slice need y-axis in first dimension.
% 
%% Option 1
% 
% lowDimVert = Brain.Vertex;
% allDimVert = BrainFull.Vertex;
% for i = 1:length(lowDimVert)
%     
%     tmp = repmat(lowDimVert(i,:), allDimVert,1);
%     dists = sqrt(sum((tmp-allDimVert).^2,2));
%     [~,vertUsed(i)] = min(dists);
% end

%% OPTION 2
% pretend vertex is a voxel
% use a volumetric parcellation (with expanded volumes to make this easier)
% to identify which parcel a vertex sits best in:

lowDimVert = Brain.Vertex+127.5; % 127.5 is based on the fsaverage volume being 256 x 256 x 256
% adding 127.5 brings the Brain into the same positive space as the volume.
% 
for i = 1:length(lowDimVert)
    vox = ceil(lowDimVert(i,:));
    inds                = sub2ind([size(parcels,1),size(parcels,2), size(parcels,3)], vox(:,1), vox(:,2), vox(:,3));
    scalars             = parcels(inds); %what is the label?
    vertsLabels(i) = scalars;
end