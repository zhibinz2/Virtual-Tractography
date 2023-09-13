%%  Left view
figure('units','inch','position',[0,0,10,8]);
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
Sources.Color=[0 1 0 0.5]


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

title('Left view');

text(60,60,100,'Sources','color',[0 0.8 0],'FontSize',15);
text(60,60,90,'EEG sensors','color',[1 0.8 0.2],'FontSize',15);
%% ********************************************************
%% Front view
figure('units','inch','position',[0,0,10,8]);
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

% view([-1,0,0]) % left side view
view([0 1 0]) % Front view
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
Sources.Color=[0 1 0 0.5]


% Motor
% [~,picked_ind_tmp]=ismember(precentral_L,source_labels);
for i=1:length(precentral_L)
        picked_ind_tmp=[];
        picked_ind_tmp=find(source_labels==(precentral_L(i)));
        if ~isempty(picked_ind_tmp)
            plot3(x(picked_ind_tmp),y(picked_ind_tmp),z(picked_ind_tmp),'r.',MarkerSize=20);
        end
end
text(55,110,160,'Motor','color','red','FontSize',15);

% Premotor
% [~,picked_ind_tmp]=ismember(caudalmiddlefrontal_L,source_labels);
for i=1:length(caudalmiddlefrontal_L)
        picked_ind_tmp=[];
        picked_ind_tmp=find(source_labels==(caudalmiddlefrontal_L(i)));
        if ~isempty(picked_ind_tmp)
            plot3(x(picked_ind_tmp),y(picked_ind_tmp),z(picked_ind_tmp),'b.',MarkerSize=20);
        end
end
text(130,170,155,'Premotor','color','blue','FontSize',15);

% SMA
% [~,picked_ind_tmp]=ismember(superiorfrontal_L,source_labels);
for i=10:17
        picked_ind_tmp=[];
        picked_ind_tmp=find(source_labels==(superiorfrontal_L(i)));
        if ~isempty(picked_ind_tmp)
            plot3(x(picked_ind_tmp),y(picked_ind_tmp),z(picked_ind_tmp),'m.',MarkerSize=20);
        end
end
text(140,140,185,'SMA','color','magenta','FontSize',15);


%% plot EEG sensors on top of the sources 
cd C:/Users/zhouz\GitHub\Virtual-Tractography\ForZhibin/processed_data/
cd ../../../MEG_EEG_Source_Localization/EEG_spacing_DAON/
load('egi_xyz.mat')
EEGsensors=plot3(x+127.5,y+127.5,z+127.5,'y.',MarkerSize=10);
EEGsensors.Color=[1 0.8 0.2 0.1]
grid off

title('Front view');


text(80,60,100,'Sources','color',[0 0.8 0],'FontSize',15);
text(80,60,90,'EEG sensors','color',[1 0.8 0.2],'FontSize',15);

%% ********************************************************
%% Top view
figure('units','inch','position',[0,0,10,8]);
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

% view([-1,0,0]) % left side view
% view([0 1 0]) % Front view
view([0 0 1]) % top view
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
Sources.Color=[0 1 0 0.5]


% Motor
% [~,picked_ind_tmp]=ismember(precentral_L,source_labels);
for i=1:length(precentral_L)
        picked_ind_tmp=[];
        picked_ind_tmp=find(source_labels==(precentral_L(i)));
        if ~isempty(picked_ind_tmp)
            plot3(x(picked_ind_tmp),y(picked_ind_tmp),z(picked_ind_tmp),'r.',MarkerSize=20);
        end
end
text(55,110,160,'Motor','color','red','FontSize',15);

% Premotor
% [~,picked_ind_tmp]=ismember(caudalmiddlefrontal_L,source_labels);
for i=1:length(caudalmiddlefrontal_L)
        picked_ind_tmp=[];
        picked_ind_tmp=find(source_labels==(caudalmiddlefrontal_L(i)));
        if ~isempty(picked_ind_tmp)
            plot3(x(picked_ind_tmp),y(picked_ind_tmp),z(picked_ind_tmp),'b.',MarkerSize=20);
        end
end
text(60,150,155,'Premotor','color','blue','FontSize',15);

% SMA
% [~,picked_ind_tmp]=ismember(superiorfrontal_L,source_labels);
for i=10:17
        picked_ind_tmp=[];
        picked_ind_tmp=find(source_labels==(superiorfrontal_L(i)));
        if ~isempty(picked_ind_tmp)
            plot3(x(picked_ind_tmp),y(picked_ind_tmp),z(picked_ind_tmp),'m.',MarkerSize=20);
        end
end
text(125,140,185,'SMA','color','magenta','FontSize',15);


%% plot EEG sensors on top of the sources 
cd C:/Users/zhouz\GitHub\Virtual-Tractography\ForZhibin/processed_data/
cd ../../../MEG_EEG_Source_Localization/EEG_spacing_DAON/
load('egi_xyz.mat')
EEGsensors=plot3(x+127.5,y+127.5,z+127.5,'y.',MarkerSize=10);
EEGsensors.Color=[1 0.8 0.2 0.1]
grid off

title('Front view');


text(175,60,100,'Sources','color',[0 0.8 0],'FontSize',15);
text(175,50,90,'EEG sensors','color',[1 0.8 0.2],'FontSize',15);
