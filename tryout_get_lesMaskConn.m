

cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography
load('streamlines.mat')
tract_interp = allTractsInterp;
% cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography/ForZhibin/processed_data
cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography/ForZhibin/Volumes/scale60
tmp = read_avw('ROIv4_HR_th.nii.gz');
tmp = permute(tmp, [1 3 2]);
tmp = tmp(182:-1:1,218:-1:1,182:-1:1);
parcels = tmp;
cd /home/zhibinz2/Documents/GitHub/archieve/STROKE/lesion_masks
% lesMask = read_avw('1_sxsGUTR_strokemask_MNI_thresh043_bin.nii.gz');
lesMask = read_avw('2_sxsWILB_strokemask_MNI_thresh05_bin_Flip.nii.gz');
lesMask = permute(lesMask, [2 1 3]);
figure
h1 = slice([-91:90], [-109:108], [-91:90],permute(lesMask, [2 1 3]),0,0,0, 'nearest');
xlabel('x');ylabel('y');zlabel('z');
shading flat;    
% set properties for all 19 objects at once using the "set" function
set(h1,'EdgeColor','none',...
    'FaceColor','interp',...
    'FaceAlpha','interp');
% set transparency to correlate to the data values.
alpha('color');
colormap(jet);

hold on
h2 = trisurf(BrainTri);
colorbar
set(h2,'FaceAlpha', .3, 'EdgeAlpha', .5, 'FaceColor', 'blue');
disp('Lesion mask is in yellow in center')


[fullConnectome,redConnectome,noEndStreamlines,eachROIstreamlines, lesMaskStreamlines,ROI2ROI] ...
    = getLesionMaskConnectome(tract_interp, parcels, lesMask);