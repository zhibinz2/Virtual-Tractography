%% Basedata Brain, MNI152 ? not shifted?
cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography/ForZhibin/processed_data

clear

load('scale250_Connectome.mat')

parcels(92,:,92)

imagesc(fc(25:50,25:50));colorbar;


% select the surface
BrainTri=Brain;
Vertex=BrainTri.Vertex;
Face=BrainTri.Face;
tr = triangulation(Face, Vertex(:,1), Vertex(:,2), Vertex(:,3));
trisurf(tr,'EdgeColor',[0.01 0.01 0.01],'EdgeAlpha',0.1);
alpha 0.5
xlabel('x');ylabel('y');zlabel('z');
title('scale250-Connectome-Brain')
view(90,0)
% ylim([-125,125]); zlim([-125,125]); xlim([-125,125]);

cd /home/zhibinz2/Documents/GitHub/MEG_EEG_Source_Localization
load('leadfield_nn_rr.mat')
hold on 
plot3(source_rr(:,1) * 1e3,source_rr(:,2) * 1e3,source_rr(:,3) * 1e3,'r.')
view(90,0)
% ylim([-125,125]); zlim([-125,125]); xlim([-125,125]);
grid on
title('source-rr from forward solution (not shifted by 1e3+2.5,1e3-30,1e3-42)')


%%
cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography/ForZhibin/processed_data
% cd /home/zhibinz2/Documents/GitHub/CAMCAN_MEG_100
clear
load('Lausanne2008_fsaverageDSsurf_60_125_250.mat')
% select the surface
BrainTri=Brain;
Vertex=BrainTri.Vertex;
Face=BrainTri.Face;
tr = triangulation(Face, Vertex(:,1), Vertex(:,2), Vertex(:,3));
trisurf(tr,'EdgeColor',[0.01 0.01 0.01],'EdgeAlpha',0.1);
alpha 0.5
xlabel('x');ylabel('y');zlabel('z');
title('Lausanne2008-fsaverageDSsurf-60-125-250.mat')
view(90,0)
ylim([-125,125]); zlim([-125,125]); xlim([-125,125]);

cd /home/zhibinz2/Documents/GitHub/MEG_EEG_Source_Localization
% cd C:\Users\zhouz\Downloads\zhibin_source_localization
load('leadfield_nn_rr.mat')
hold on 
plot3(source_rr(:,1) * 1e3 + 2.5,source_rr(:,2) * 1e3 -30,source_rr(:,3) * 1e3 -42,'r.')
view(90,0)
% ylim([-125,125]); zlim([-125,125]); xlim([-125,125]);
grid on
title('source-rr from forward solution (shifted by 1e3+2.5,1e3-30,1e3-42)')

view([1 0 0]) % right view
view([-1 0 0]) % left view
view([0 0 1]) % Top view?
view([0 0 -1]) % bottom view
view([0 1 0]) % Front view
view([0 -1 0]) % Back view

view(0,90) % bottom view?
view(0,0) % back view
view(90,90) % top view


%% source labelling: Minmum distance
source_x=source_rr(:,1) * 1e3 + 2.5;
source_y=source_rr(:,2) * 1e3 -30;
source_z=source_rr(:,3) * 1e3 -42;
source_xyz=[source_x source_y source_z];

num_source=size(source_xyz,1);
num_vertex=size(Vertex,1);
source_labels=zeros(num_source,1);
tic
for sr=1:num_source
    tic
    all_dis=zeros(num_vertex,1);
    for vr =1:num_vertex
        all_dis(vr)=norm(Vertex(vr,:)-source_xyz(sr,:));
    end
    [M,I]=min(all_dis);
    source_labels(sr)=scale250_Labels(I);
end
toc
% Elapsed time is 0.129726 seconds.
bar(source_labels)

%% Anni's labeling
cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography/ForZhibin/Volumes/scale250
tmp = read_avw('ROIv4_HR_th.nii.gz');
tmp = permute(tmp, [1 3 2]);
tmp = tmp(256:-1:1,:, 256:-1:1);
parcels = tmp;

lowDimVert = source_xyz+127.5; % 127.5 is based on the fsaverage volume being 256 x 256 x 256
plot3(lowDimVert(:,1), lowDimVert(:,2), lowDimVert(:,3),'r.')
lowDimVert_labels=zeros(num_source,1);
for i = 1:length(lowDimVert)
    vox = ceil(lowDimVert(i,:));
    inds              = sub2ind([size(parcels)], vox(:,1), vox(:,2), vox(:,3));
    label             = parcels(inds); %what is the label?
    lowDimVert_labels(i) = label;
end


% covert parcels to linear index organization
linear_parcels=reshape(tmp,[],1);
parcel_labels=zeros(length(linear_parcels),1);
parcel_coordinates=zeros(length(linear_parcels))
tic
for l=1:length(linear_parcels)
    if linear_parcels(l)~=0
        parcel_cordinates(l,:)=ind2sub(size(parcels),l)
        parcel_labels=[parcel_labels;linear_parcels(l)];
    end
end
% remove zeor entry
bool_parcel=ones(length(linear_parcels),1);
for l=1:length(linear_parcel)
    if linear_parcels(l)==0
        bool_parcel(l)=0
    end
end
parcel_coordinates=parcel_coordinates(bool_parcel,:);
parcel_labels=parcel_labels(bool_parcel);
toc

% reorganize parcels to a list of non-zeros
tic
parcel_cordinates=[];
parcel_labels=[];
for x=1:size(parcels,1)
    for y=1:size(parcels,2)
        for z=1:size(parcels,3)
            if parcels(x,y,z)~=0
                parcel_cordinates=[parcel_cordinates; x, y, z];
                parcel_labels=[parcel_labels;parcels(x,y,z)];
            end
        end
    end
end
toc
% it took along time

%% validation: My minimum distance method
figure('Position', [10 10 1800 650])
subplot(121)
scatter3(Vertex(:,1), Vertex(:,2), Vertex(:,3),40,scale250_Labels,"filled", 'MarkerFaceAlpha',.2)
xlabel('x'); ylabel('y');zlabel('z')
cb = colorbar(); 
title(cb, 'labels')
title('scale250-Labels')
view([1 0 0]) % right view
% view([-1 0 0]) % left view
ylim([-125,125]); zlim([-125,125]); xlim([-125,125]);
subplot(122)
scatter3(source_rr(:,1) * 1e3 + 2.5,source_rr(:,2) * 1e3 -30,source_rr(:,3) * 1e3 -42,...
    40, source_labels, 'filled')
xlabel('x'); ylabel('y');zlabel('z')
cb = colorbar(); 
title(cb, 'labels')
title('Minimum distance method')
view([1 0 0]) % right view
% view([-1 0 0]) % left view
ylim([-125,125]); zlim([-125,125]); xlim([-125,125]);
% set(gcf,'Position',[10 10 1800 650])


%% validation: Ani's method
figure('Position', [10 10 1800 650])
subplot(121)
scatter3(parcel_cordinates(:,1), parcel_cordinates(:,2), parcel_cordinates(:,3),...
    40,parcel_labels,"filled", 'MarkerFaceAlpha',.2)
xlabel('x'); ylabel('y');zlabel('z')
cb = colorbar(); 
title(cb, 'labels')
title('ROIv4-HR-th.nii.gz')
% view([1 0 0]) % right view
view([-1 0 0]) % left view
ylim([-125,125]); zlim([-125,125]); xlim([-125,125]);
subplot(122)
scatter3(lowDimVert(:,1), lowDimVert(:,2), lowDimVert(:,3),...
    40, lowDimVert_labels, 'filled')
xlabel('x'); ylabel('y');zlabel('z')
cb = colorbar(); 
title(cb, 'labels')
title('Ani gettingLausanne method')
% view([1 0 0]) % right view
view([-1 0 0]) % left view
ylim([-125,125]); zlim([-125,125]); xlim([-125,125]);
