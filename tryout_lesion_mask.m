%% try out finding lesion labels
clear

cd /home/zhibinz2/Documents/GitHub/archive/STROKE/lesion_masks
% tmp = read_avw('sum62.nii.gz');
tmp = read_avw('30_DAON_final_strokemask_MNI_flipped_bin.nii.gz');

unique(reshape(tmp,[],1))

figure;
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

%% examine sum62.nii.gz
tmp=read_avw('sum62.nii.gz'); % 301x370x316
unique(tmp) % 0-28
bar(reshape(tmp,[],1)) % no idea what it is

%% read mask files
clear
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
%% extract the biggest lesion label
les_sites=cell(62,1);
for i=1:62
    tmp=read_avw(FileNames{i});
    lesion_values=tmp(find(tmp));
    unique_values=unique(lesion_values);
    max_value=max(unique_values);

    lesion_labels=(parcels(find(tmp)));
    unique_labels = unique(lesion_labels);
    n  = histc(lesion_labels,unique_labels);
    [counts,inds]=sort(n,"descend");
    
    if unique_labels(inds(1))~=0
        ind=unique_labels(inds(1));
        les_sites{i}=roiNames_250(ind);
    elseif unique_labels(inds(1))==0 & length(inds)==1 % if label is 0 only
        les_sites{i}=[];
    else
        ind=unique_labels(inds(2));
        les_sites{i}=roiNames_250(ind);
    end
end


%% extract all lesion ROIs and organized in 62 subjects and sorted them from big to small
clear
cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography/ForZhibin/processed_data
load('scale250_Connectome.mat', 'roiNames_250')

cd /home/zhibinz2/Documents/GitHub/archive/STROKE/lesion_masks
% les_all_sites=cell(62,1);
p62_les_labels=cell(62,1);
for i=1:62
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
end

% examine why i= 45 46 are empty
i=45
tmp=read_avw(FileNames{i});
lesion_labels=(parcels(find(tmp)));
unique_labels = unique(lesion_labels);
n  = histc(lesion_labels,unique_labels);
[counts,inds]=sort(n,"descend");

les_sort_labels=unique_labels(inds);
% remove zero entry
les_sort_labels(les_sort_labels==0)=[];

%% get lesion size from les mask
cd /home/zhibinz2/Documents/GitHub/archive/STROKE/lesion_masks
les_size_p62=nan(62,1);
for i=1:62
    tmp=read_avw(FileNames{i});
    les_size_p62(i)=sum(find(tmp));
end

%% 3d plot the lesion value
[x,y,z,v]=ind2sub(size(tmp),find(tmp));
v=tmp(find(tmp));
scatter3(x,y,z,50,v,'filled');colorbar;

%% lesion SC
