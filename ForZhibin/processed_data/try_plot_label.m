%% view all labels
clear
cd ../Volumes/scale250
load('parcel_reorganized_by_xyz.mat') % volumetric parcels
% load('parcel_coor_labels.mat')

cd ../../processed_data

% Note: The source coordinates go from left hemisphere to the right hemisphere. 
% But the labeled parcels go from the right to the left
superiorfrontal_R=[37:53];
caudalmiddlefrontal_R=[54:58];
precentral_R=[59:74];
cuneus_R=[148:151];
cuneus_R1=148;

superiorfrontal_L=[265:282];
caudalmiddlefrontal_L=[283:288];
precentral_L=[289:309];
cuneus_L=[380:382];

x=parcel_cordinates(:,1); y=parcel_cordinates(:,2); z=parcel_cordinates(:,3);

picked_label=cuneus_R;
picked_ind=[];
for i=1:length(picked_label)
        picked_ind_tmp=find(parcel_labels==(picked_label(i)));
        picked_ind=[picked_ind;picked_ind_tmp];
end
% picked_ind=int64(picked_ind);
figure
clf
scatter3(x,y,z,'g.')
clear alpha
alpha(.1)
hold on;
scatter3(x(picked_ind),y(picked_ind),z(picked_ind),'r')
xlabel('x'); ylabel('y');zlabel('z')
view([-1,0,0]) % left side view
% view([1,0,0]) % right side view
% view([0 1 0]) % Front view
% view([0 -1 0]) % Back view
% view([0 0 1]) % top view
rotate3d on
% rotate3d('on')

%% surface sources
cd ../../../MEG_EEG_Source_Localization/EEG_spacing_DAON/
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
% cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography/ForZhibin/processed_data
cd C:\Users\zhouz\GitHub\Virtual-Tractography\ForZhibin\processed_data
cd ../processed_data
load('scale250_Connectome.mat')

figure

picked_label=[59:74]; % precentral_R
picked_label=[1:7];
picked_label=[8:9];
picked_label=[10];
picked_label=[11:15]
picked_label=[16:23]; % parstriangularis https://radiopaedia.org/articles/pars-triangularis
picked_label=[289:309]; % precentral_L

clf
scatter3(x,y,z,...
    50,zeros(length(source_fsaverage),1),"filled", 'MarkerFaceAlpha',.1);
clear alpha
alpha(.5)
hold on;
for i=1:length(picked_label)
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
xlabel('x'); ylabel('y');zlabel('z')
% view([1,0,0]) % right side view
view([-1,0,0]) % left side view
% view([0 1 0]) % Front view
% view([0 -1 0]) % Back view
% view([0 0 1]) % top view
% title([ 'source-fsaverage: ' 'precentral-R (Right view)']);
% title([ 'source-fsaverage: ' 'precentral-R (Top view)']);
title(cb, 'label: precentral#')
% pick precentra_5-15 to cover the hand area
%% superiorfrontal_R
superiorfrontal_R=[37:53];
% cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography/ForZhibin/processed_data
cd ../processed_data
load('scale250_Connectome.mat')

picked_label=superiorfrontal_R;
figure
clf
scatter3(x,y,z,...
    50,zeros(length(source_fsaverage),1),"filled", 'MarkerFaceAlpha',.1);
clear alpha
alpha(.5)
hold on;
for i=1:length(picked_label)
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
title(cb, 'label: superiorfrontal#')

xlabel('x'); ylabel('y');zlabel('z')
% view([-1,0,0]) % left side view
view([1,0,0]) % right side view
% view([0 1 0]) % Front view
% view([0 -1 0]) % Back view
% view([0 0 1]) % top view
title([ 'source-fsaverage: ' 'superiorfrontal-R (Right view)']);

% pick superiorfrontal_10 to 17 as premotor area

%% caudalmiddlefrontal_R
caudalmiddlefrontal_R=[54:58];
% cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography/ForZhibin/processed_data
cd ../processed_data
load('scale250_Connectome.mat')

picked_label=caudalmiddlefrontal_R;
figure
clf
scatter3(x,y,z,...
    50,zeros(length(source_fsaverage),1),"filled", 'MarkerFaceAlpha',.1);
clear alpha
alpha(.5)
hold on;
for i=1:length(picked_label)
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
title(cb, 'label: caudalmiddlefrontal_#')

xlabel('x'); ylabel('y');zlabel('z')
% view([-1,0,0]) % left side view
view([1,0,0]) % right side view
% view([0 1 0]) % Front view
% view([0 -1 0]) % Back view
% view([0 0 1]) % top view
title([ 'source-fsaverage: ' 'caudalmiddlefrontal_R (Right view)']);

% pick caudalmiddlefrontal_1 to 5 as premotor area
%% plot the brain surface
figure('units','inch','position',[0,0,10,8]);
clf;
cd C:/Users/zhouz\GitHub\Virtual-Tractography\ForZhibin/processed_data/
cd ../processed_data
load('scale250_Connectome.mat')
Face=Brain.Face;
Vertex=Brain.Vertex;
cd C:/Users/zhouz\GitHub\Virtual-Tractography\ForZhibin/processed_data/
cd ../../../MEG_EEG_Source_Localization/EEG_spacing_DAON/
load('DAON_ico_3_scale_0.05_depth_0.8.mat')
x=source_fsaverage(:,1); y=source_fsaverage(:,2); z=source_fsaverage(:,3);
x_shift=(max(Vertex(:,1))-max(x))/2+(min(Vertex(:,1))-min(x))/2;
y_shift=(max(Vertex(:,2))-max(y))/2+(min(Vertex(:,2))-min(y))/2;
z_shift=(max(Vertex(:,3))-max(z))/2+(min(Vertex(:,3))-min(z))/2;
Vertex(:,1)=Vertex(:,1)-x_shift;
Vertex(:,2)=Vertex(:,2)-y_shift;
Vertex(:,3)=Vertex(:,3)-z_shift;
tr = triangulation(Face, Vertex(:,1), Vertex(:,2), Vertex(:,3));
Brainmesh=trimesh(tr,'EdgeColor',[0.01 0.01 0.01],'EdgeAlpha',0.01);
colormap('gray');
alpha(Brainmesh, 0.01);

view([-1,0,0]) % left side view
% view([0 1 0]) % Front view
% view([0 0 1]) % top view
hold on
%% plot left motor premotor and SMA
precentral_L=[289:309];
caudalmiddlefrontal_L=[283:288];
superiorfrontal_L=[265:282];

% plot all source in green
cd C:/Users/zhouz\GitHub\Virtual-Tractography\ForZhibin/processed_data/
cd ../../../MEG_EEG_Source_Localization/EEG_spacing_DAON/
load('DAON_ico_3_scale_0.05_depth_0.8.mat')
x=source_fsaverage(:,1); y=source_fsaverage(:,2); z=source_fsaverage(:,3);
Sources=plot3(x,y,z,'g.');xlabel('x'); ylabel('y');zlabel('z');
xlim([0 260]);ylim([-40 260]);zlim([0 280]);
alpha(Sources,0.3);


% Motor
% [~,picked_ind_tmp]=ismember(precentral_L,source_labels);
for i=1:length(precentral_L)
        picked_ind_tmp=[];
        picked_ind_tmp=find(source_labels==(precentral_L(i)));
        if ~isempty(picked_ind_tmp)
            plot3(x(picked_ind_tmp),y(picked_ind_tmp),z(picked_ind_tmp),'r.',MarkerSize=20);
        end
end
text(70,110,160,'Motor','color','red','FontSize',15);

% Premotor
% [~,picked_ind_tmp]=ismember(caudalmiddlefrontal_L,source_labels);
for i=1:length(caudalmiddlefrontal_L)
        picked_ind_tmp=[];
        picked_ind_tmp=find(source_labels==(caudalmiddlefrontal_L(i)));
        if ~isempty(picked_ind_tmp)
            plot3(x(picked_ind_tmp),y(picked_ind_tmp),z(picked_ind_tmp),'b.',MarkerSize=20);
        end
end
text(90,170,150,'Premotor','color','blue','FontSize',15);

% SMA
% [~,picked_ind_tmp]=ismember(superiorfrontal_L,source_labels);
for i=10:17
        picked_ind_tmp=[];
        picked_ind_tmp=find(source_labels==(superiorfrontal_L(i)));
        if ~isempty(picked_ind_tmp)
            plot3(x(picked_ind_tmp),y(picked_ind_tmp),z(picked_ind_tmp),'m.',MarkerSize=20);
        end
end
text(125,140,200,'SMA','color','magenta','FontSize',15);


%% plot EEG sensors on top of the sources 
cd C:/Users/zhouz\GitHub\Virtual-Tractography\ForZhibin/processed_data/
cd ../../../MEG_EEG_Source_Localization/EEG_spacing_DAON/
load('egi_xyz.mat')
EEGsensors=plot3(x+127.5,y+127.5,z+127.5,'y.',MarkerSize=10);
EEGsensors.Color=[1 0.8 0.2 0.1]
grid off
