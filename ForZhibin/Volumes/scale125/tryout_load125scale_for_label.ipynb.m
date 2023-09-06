clear
cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography/ForZhibin/Volumes/scale250
tmp = read_avw('ROIv4_HR_th.nii.gz');

clear
cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography/ForZhibin/Volumes/scale125
tmp = read_avw('ROIv4_HR_th.nii.gz');
tmp = read_avw('ROIv2_HR_th.nii.gz');

tmp = permute(tmp, [1 3 2]);
tmp = tmp(256:-1:1,:, 256:-1:1);
parcels = tmp;

file='ROIv4_HR_th.nii.gz';


figure;
bar(reshape(parcels,[],1))

figure;
bar(unique(reshape(parcels,[],1)))

cd /home/zhibinz2/Documents/GitHub/MEG_EEG_Source_Localization
% cd C:\Users\zhouz\Downloads\zhibin_source_localization
load('leadfield_nn_rr.mat')

lowDimVert = source_rr;

for i = 1:length(lowDimVert)
    vox = ceil(lowDimVert(i,:));
    inds                = sub2ind([size(parcels,1),size(parcels,2), size(parcels,3)], vox(:,1), vox(:,2), vox(:,3));
    scalars             = parcels(inds); %what is the label?
    vertsLabels(i) = scalars;
end

