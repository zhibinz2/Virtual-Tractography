clear
cd /home/zhibinz2/Documents/GitHub/archive/STROKE/lesion_masks
% tmp = read_avw('sum62.nii.gz');
tmp = read_avw('30_DAON_final_strokemask_MNI_flipped_bin.nii.gz');

figure;
bar(unique(reshape(tmp,[],1)))

plot(1:length(reshape(tmp,[],1)),reshape(tmp,[],1),'r.')

hist(reshape(tmp,[],1),35)

sum(reshape(tmp,[],1))

cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography
load('baseData.mat', 'parcels') % scale 60
load('baseData.mat', 'lesMaskDemo')

cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography/ForZhibin/processed_data
load('scale250_Connectome.mat') % scale 250 (MNI space)


figure;
bar(unique(reshape(parcels,[],1))) 


plot(1:length(reshape(lesMaskDemo,[],1)),reshape(lesMaskDemo,[],1),'r.')
sum(reshape(lesMaskDemo,[],1))

plot(1:length(reshape(lesMaskDemo,[],1)),reshape(lesMaskDemo,[],1),'r.')
sum(reshape(lesMaskDemo,[],1))

lesion_labels=(parcels(find(tmp)));
hist(lesion_labels,length(unique(parcels)))
unique(lesion_labels)

unique_labels = unique(lesion_labels);
n  = histc(lesion_labels,unique_labels);

[counts,inds]=sort(n,"descend")

ind=unique_labels(inds(2:4)) % second most label
roiNames_250(ind)

%%
cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography/ForZhibin/processed_data
load('scale250_Connectome.mat') % scale 250 (MNI space)

cd /home/zhibinz2/Documents/GitHub/archive/STROKE/lesion_masks
FileNames=cell(62,1);
FileDirs=cell(62,1);
for i=1:62
    clear FileList
    FileList = dir(fullfile(pwd,[num2str(i) '_' '*.gz']) );
    FileNames{i}= FileList(1).name;
    FileDirs{i}= fullfile(pwd, FileList(1).name);
end

les_sites=cell(62,1);
for i=1:62
    tmp=read_avw(FileNames{i});
    lesion_labels=(parcels(find(tmp)));
    unique_labels = unique(lesion_labels);
    n  = histc(lesion_labels,unique_labels);
    [counts,inds]=sort(n,"descend");
    if unique_labels(inds(1))~=0
        ind=unique_labels(inds(1)); 
    elseif unique_labels(inds(1))==0 & length(inds)==1
        les_sites{i}={[]};
    else
        ind=unique_labels(inds(2)); 
    end
    les_sites{i}=roiNames_250(ind);
end
