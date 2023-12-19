
clear

cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography
load('streamlines.mat')
tract_interp = allTractsInterp;

% cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography/ForZhibin/processed_data
cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography/ForZhibin/Volumes/scale60
tmp = read_avw('ROIv4_HR_th.nii.gz');
tmp = permute(tmp, [1 3 2]);
tmp = tmp(182:-1:1,218:-1:1,182:-1:1);
parcels = tmp;

clear
cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography/ForZhibin/processed_data
load('scale250_Connectome.mat') % scale 250 (MNI space) % GET parcels


cd /home/zhibinz2/Documents/GitHub/archive/STROKE/lesion_masks
lesMask = read_avw('1_sxsGUTR_strokemask_MNI_thresh043_bin.nii.gz');
% lesMask = read_avw('2_sxsWILB_strokemask_MNI_thresh05_bin_Flip.nii.gz');
% lesMask = permute(lesMask, [2 1 3]);
figure
h1 = slice([-91:90], [-109:108], [-91:90], permute(lesMask, [2 1 3]),0,0,0, 'nearest');
% h1 = slice([-91:90], [-109:108], [-91:90], lesMask,0,0,0, 'nearest');
xlabel('x');ylabel('y');zlabel('z');
shading flat;    
% set properties for all 19 objects at once using the "set" function
% set(h1,'EdgeColor','none',...
%     'FaceColor','interp',...
%     'FaceAlpha','interp');
% set transparency to correlate to the data values.
alpha('color');
colormap(jet);colorbar;

hold on
cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography
load('baseData.mat')
h2 = trisurf(BrainTri);
colorbar
set(h2,'FaceAlpha', .3, 'EdgeAlpha', .5, 'FaceColor', 'blue');
disp('Lesion mask is in yellow in center')

%% get lesion connectone
[fullConnectome,redConnectome,noEndStreamlines,eachROIstreamlines, lesMaskStreamlines,ROI2ROI] ...
    = getLesionMaskConnectome(tract_interp, parcels, lesMask);

figure;subplot(131)
imagesc(logical(fullConnectome));colorbar
subplot(132)
imagesc(logical(redConnectome));colorbar
subplot(133)
imagesc(logical(fullConnectome)-logical(redConnectome));colorbar

% remove the diagonal values
fullConnectome = fullConnectome .* double(~eye(length(fullConnectome))); % diagonal contains degrees for each node right now, removing that
redConnectome = redConnectome .* double(~eye(length(fullConnectome)));

% Ahead: removing non-homotopic connections - optional; 
% SC matrix used here needs to be recreated for the parcellation applied.
% Use with caution.
fullsc = fullConnectome.* (SC>0);
redConn = redConnectome.*(SC>0); 


% plot
disp('Binary SC and Virtual SC')
figure
subplot(121)
imagesc(fullsc>0)
axis square
title('Binary SC','Fontsize', 18)
subplot(122)
imagesc(redConn>0)
axis square
title('Binary Virtual SC', 'Fontsize', 18)

disp('Weighted SC and Virtual SC')
figure
subplot(121)
imagesc(log(fullsc+eps))
axis square
caxis([-5,5])
colorbar
title('Weighted SC', 'Fontsize', 18)
subplot(122)
imagesc(log(redConn+eps))
axis square
caxis([-5,5])
title('Weighted Virtual SC', 'Fontsize', 18)
colorbar