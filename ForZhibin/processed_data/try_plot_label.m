clear
cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography/ForZhibin/Volumes/scale250
load('parcel_reorganized_by_xyz.mat') % volumetric parcels
% load('parcel_coor_labels.mat')

cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography/ForZhibin/processed_data

% Note: The source coordinates go from left hemisphere to the right hemisphere. 
% But the labeled parcels go from the right to the left
superiorfrontal_R=[37:53];
caudalmiddlefrontal_R=[54:58];
precentral_R=[59:74];

superiorfrontal_L=[265:282];
caudalmiddlefrontal_L=[283:288];
precentral_L=[289:309];

x=parcel_cordinates(:,1); y=parcel_cordinates(:,2); z=parcel_cordinates(:,3);

picked_label=caudalmiddlefrontal_L;
picked_ind=[];
for i=1:length(picked_label)
        picked_ind_tmp=find(parcel_labels==(picked_label(i)));
        picked_ind=[picked_ind;picked_ind_tmp];
end
% picked_ind=int64(picked_ind);
figure
scatter3(x,y,z,'g.')
clear alpha
alpha(.1)
hold on;
scatter3(x(picked_ind),y(picked_ind),z(picked_ind),'r')
xlabel('x'); ylabel('y');zlabel('z')
view([-1,0,0]) % left side view
% view([1,0,0]) % right side view
view([0 1 0]) % Front view
view([0 -1 0]) % Back view
view([0 0 1]) % top view

%% surface sources
cd /home/zhibinz2/Documents/GitHub/MEG_EEG_Source_Localization/EEG_spacing_DAON
load('DAON_ico_3_scale_0.05_depth_0.8.mat')
x=source_fsaverage(:,1); y=source_fsaverage(:,2); z=source_fsaverage(:,3);
% picked_label=precentral_R;
% picked_label=superiorfrontal_R;
picked_label=caudalmiddlefrontal_R;
picked_ind=[];
for i=1:length(picked_label)
        picked_ind_tmp=find(source_labels==(picked_label(i)));
        picked_ind=[picked_ind;picked_ind_tmp];
end
figure
clf
scatter3(x,y,z,'g')
clear alpha
alpha(.5)
hold on;
scatter3(x(picked_ind),y(picked_ind),z(picked_ind),'r.')
xlabel('x'); ylabel('y');zlabel('z')
% view([-1,0,0]) % left side view
view([1,0,0]) % right side view
% view([0 1 0]) % Front view
% view([0 -1 0]) % Back view
% view([0 0 1]) % top view
title('precentral-R (Right view)');
title('superiorfrontal-R (Right view)');
title('caudalmiddlefrontal-R (Right view)');
sgtitle('source-fsaverage');

%% hand area
precentral_R=[59:74];
cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography/ForZhibin/processed_data
load('scale250_Connectome.mat')

picked_label=precentral_R;
figure
clf
scatter3(x,y,z,...
    50,zeros(length(source_fsaverage),1),"filled", 'MarkerFaceAlpha',.1);
clear alpha
alpha(.5)
hold on;
for i=1:length(precentral_R)
        picked_ind_tmp=[];
        picked_ind_tmp=find(source_labels==(picked_label(i)));
        if ~isempty(picked_ind_tmp)
            scatter3(x(picked_ind_tmp),y(picked_ind_tmp),z(picked_ind_tmp),...
                50,i*ones(length(picked_ind_tmp),1),"filled", 'MarkerFaceAlpha',.9);
            text(x(picked_ind_tmp),y(picked_ind_tmp),z(picked_ind_tmp),...
                num2str(i));
        end
end
cb = colorbar(); 
colormap('jet');
clim([-1*length(picked_label) length(picked_label)])
title(cb, 'label: precentral#')

xlabel('x'); ylabel('y');zlabel('z')
% view([-1,0,0]) % left side view
view([1,0,0]) % right side view
% view([0 1 0]) % Front view
% view([0 -1 0]) % Back view
% view([0 0 1]) % top view
title([ 'source-fsaverage: ' 'precentral-R (Right view)']);
title([ 'source-fsaverage: ' 'precentral-R (Top view)']);


