%% map lesion with parcels
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
[fullConnectome,redConnectome,noEndStreamlines,eachROIstreamlines, lesMaskStreamlines, ROI2ROI] ...
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

cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography/ForZhibin/processed_data
load('scale250_Connectome.mat') % scale 250 (MNI space)
% SC=logical(fc);
SC=fc;

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

%% collect all lesion sites with getLesionMaskConnectome
clear
cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography
load('streamlines.mat')
tract_interp = allTractsInterp;

cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography/ForZhibin/processed_data
load('scale250_Connectome.mat', 'parcels')

cd /home/zhibinz2/Documents/GitHub/archive/STROKE/lesion_masks
FileNames=cell(62,1);
FileDirs=cell(62,1);
for i=1:62
    clear FileList
    FileList = dir(fullfile(pwd,[num2str(i) '_' '*.gz']) );
    FileNames{i}= FileList(1).name;
    FileDirs{i}= fullfile(pwd, FileList(1).name);
end

addpath /home/zhibinz2/Documents/GitHub/Virtual-Tractography

fc62=nan(62,463,463);
red62=nan(62,463,463);
les62=nan(62,463,463);
p62_noEnd_strs=nan(62,133815);
p62_roi463_str=cell(1,62);
p62_les_strs=nan(62,133815);
p62_roi2roi=nan(62,133815,2);

for i=1:62
    tic
    lesMask = read_avw(FileNames{i});
    [fullConnectome,redConnectome,noEndStreamlines,eachROIstreamlines, lesMaskStreamlines, ROI2ROI] ...
        = getLesionMaskConnectome(tract_interp, parcels, lesMask);
    fc62(i,:,:)=fullConnectome;
    red62(i,:,:)=redConnectome;
    les62(i,:,:)=logical(fullConnectome)-logical(redConnectome);
    p62_noEnd_strs(i,:)=noEndStreamlines;
    p62_roi463_str{i}=eachROIstreamlines;
    p62_les_strs(i,:)=lesMaskStreamlines;
    p62_roi2roi(i,:,:)=ROI2ROI;
    toc
end
% 15 min
sum(lesMaskStreamlines) % number of streamlines intersected by the lesion


p62_les_labels=cell(62,1);
for i=1:62
    tic
    tmp=read_avw(FileNames{i});
    lesion_labels=(parcels(find(tmp)));
    unique_labels = unique(lesion_labels);
    n  = histc(lesion_labels,unique_labels);
    [counts,inds]=sort(n,"descend");
    
    les_sort_labels=unique_labels(inds);
    % remove zero entry
    les_sort_labels(les_sort_labels==0)=[];
    % les_all_sites{i}=roiNames_250(les_sort_labels);
    p62_les_labels{i}=les_sort_labels;
    toc
end
% < 1 min
tic
save('p62_getLesionMaskConnectome.mat','FileNames','fc62','red62','les62','p62_noEnd_strs', ...
    'p62_roi463_str','p62_les_strs','p62_roi2roi','p62_les_labels','-v7.3');
toc