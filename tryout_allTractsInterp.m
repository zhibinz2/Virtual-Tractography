cd C:\Users\zhouz\GitHub\Virtual-Tractography
load('streamlines.mat')

i=1;
figure
for i=1:100:size(allTractsInterp,3)
    plot3(squeeze(allTractsInterp(:,1,i)),squeeze(allTractsInterp(:,2,i)), ...
    squeeze(allTractsInterp(:,3,i)),'.','Color',rand(1,3));
    hold on
end
%%

load('baseData.mat')
figure
h2 = trisurf(BrainTri);
colorbar
set(h2,'FaceAlpha', .3, 'EdgeAlpha', .03, 'FaceColor', 'blue');
disp('Lesion mask is in yellow in center')

hold on 
for i=1:100:size(allTractsInterp,3)
    plot3(squeeze(allTractsInterp(:,1,i)),squeeze(allTractsInterp(:,2,i)), ...
    squeeze(allTractsInterp(:,3,i)),'.','Color',rand(1,3));
end
hold off

view(0,90)

%% plot in MNI152
clear

cd C:\Users\zhouz\GitHub\Virtual-Tractography
load('streamlines.mat')

cd C:\Users\zhouz\GitHub\brain_network_python\mne_test

load('rh_pial.mat')
figure('units','normalized','outerposition',[0 0 0.3 0.8]);
tri=round(double(tris)+1);
tr = triangulation(tri, rr_mm(:,1), rr_mm(:,2), rr_mm(:,3));
trisurf(tr,'FaceAlpha', .3, 'EdgeAlpha', .03, 'FaceColor', 'blue');
xlabel('x');ylabel('y');zlabel('z');
title('cvs-avg35-inMNI152')
ylim([-125,125]); zlim([-125,125]); xlim([-125,125]);

hold on

load('lh_pial.mat')
tri=round(double(tris)+1);
tr = triangulation(tri, rr_mm(:,1), rr_mm(:,2), rr_mm(:,3));
trisurf(tr,'FaceAlpha', .3, 'EdgeAlpha', .03, 'FaceColor', 'blue');

for i=1:150:size(allTractsInterp,3)
    plot3(squeeze(allTractsInterp(:,1,i)),squeeze(allTractsInterp(:,2,i)), ...
    squeeze(allTractsInterp(:,3,i)),'.','Color',rand(1,3));
end
hold off

%% PLOT in fsaverage
cd C:\Users\zhouz\GitHub\MEG_EEG_Source_Localization

load('./Lausanne2008_fsaverageDSsurf_60_125_250.mat')
Vertex=Brain.Vertex; %fsaverage

cd C:\Users\zhouz\GitHub\MEG_EEG_Source_Localization\EEG_spacing_ESCH
scale=0.05; depth=0.8;ico='4';subject_ID='ESCH'; 
filename=[subject_ID '_ico_' ico '_scale_' num2str(scale) '_depth_' num2str(depth) '.mat']
load(filename);

% x_shift=(max(Vertex(:,1))-max(source_rr(:,1))*1e3)/2+(min(Vertex(:,1))-min(source_rr(:,1))*1e3)/2;
% y_shift=(max(Vertex(:,2))-max(source_rr(:,2))*1e3)/2+(min(Vertex(:,2))-min(source_rr(:,2))*1e3)/2;
% z_shift=(max(Vertex(:,3))-max(source_rr(:,3))*1e3)/2+(min(Vertex(:,3))-min(source_rr(:,3))*1e3)/2;
% source_x=source_rr(:,1) * 1e3 + x_shift;
% source_y=source_rr(:,2) * 1e3 + y_shift;
% source_z=source_rr(:,3) * 1e3 + z_shift;
% source_xyz=[source_x source_y source_z];
% num_source=size(source_xyz,1);
% source_fsaverage = source_xyz+127.5; % 127.5 is based
x=source_fsaverage(:,1); y=source_fsaverage(:,2); z=source_fsaverage(:,3);

figure
clf
scatter3(x,y,z,'g.') % Source in fsaverage
hold on;

% plot the streamlines (in MNI152)

hold on;
for i=1:150:size(allTractsInterp,3)
    % plot3(squeeze(allTractsInterp(:,1,i))+127.5,squeeze(allTractsInterp(:,2,i))+127.5, ...
    % squeeze(allTractsInterp(:,3,i))+127.5,'.','Color',rand(1,3));
    stream_color=rand(1,3);
    plot3(squeeze(allTractsInterp(1,1,i))+127.5,squeeze(allTractsInterp(1,2,i))+127.5, ...
    squeeze(allTractsInterp(1,3,i))+127.5,'.','Color',stream_color);
    plot3(squeeze(allTractsInterp(100,1,i))+127.5,squeeze(allTractsInterp(100,2,i))+127.5, ...
    squeeze(allTractsInterp(100,3,i))+127.5,'.','Color',stream_color);
end



%%  Plot in fsaverage, Left view
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

%% shift alltractInterp (MNI152) inside fsaverage brain
cd C:\Users\zhouz\GitHub\Virtual-Tractography
load('streamlines.mat')

x_shift=(max(allTractsInterp(:,1,:),[],"all")-max(x))/2+(min(allTractsInterp(:,1,:),[],"all")-min(x))/2;
y_shift=(max(allTractsInterp(:,2,:),[],"all")-max(y))/2+(min(allTractsInterp(:,2,:),[],"all")-min(y))/2;
z_shift=median(allTractsInterp(:,3,:),"all")-median(z); % +(min(allTractsInterp(:,3,:),[],"all")-min(z))/2;
allTractsInterp(:,1,:)=allTractsInterp(:,1,:)-x_shift;
allTractsInterp(:,2,:)=allTractsInterp(:,2,:)-y_shift;
allTractsInterp(:,3,:)=allTractsInterp(:,3,:)-z_shift;

for i=1:150:size(allTractsInterp,3)
    plot3(squeeze(allTractsInterp(:,1,i)),squeeze(allTractsInterp(:,2,i)), ...
    squeeze(allTractsInterp(:,3,i)),'.','Color',rand(1,3));
    % stream_color=rand(1,3);
    % plot3(squeeze(allTractsInterp(1,1,i))+127.5,squeeze(allTractsInterp(1,2,i))+127.5, ...
    % squeeze(allTractsInterp(1,3,i))+127.5,'.','Color',stream_color);
    % plot3(squeeze(allTractsInterp(100,1,i))+127.5,squeeze(allTractsInterp(100,2,i))+127.5, ...
    % squeeze(allTractsInterp(100,3,i))+127.5,'.','Color',stream_color);
end

grid off
xlabel('x');ylabel('y');zlabel('z');
xlim([0 260]);ylim([-40 260]);zlim([0 280]);

%% Plot in MNI152, Left view
cd C:\Users\zhouz\GitHub\brain_network_python\mne_test
figure;

clf;
load('rh_pial.mat')
tri=round(double(tris)+1);
tr = triangulation(tri, rr_mm(:,1), rr_mm(:,2), rr_mm(:,3));
Brainmesh=trimesh(tr,'EdgeColor',[0.01 0.01 0.01],'EdgeAlpha',0.01);
colormap('gray');
alpha(Brainmesh, 0.01);
xlabel('x');ylabel('y');zlabel('z');
title('cvs-avg35-inMNI152')
ylim([-125,125]); zlim([-125,125]); xlim([-125,125]);

hold on

load('lh_pial.mat')
tri=round(double(tris)+1);
tr = triangulation(tri, rr_mm(:,1), rr_mm(:,2), rr_mm(:,3));
Brainmesh=trimesh(tr,'EdgeColor',[0.01 0.01 0.01],'EdgeAlpha',0.01);
colormap('gray');
alpha(Brainmesh, 0.01);


view([-1,0,0]) % left side view
% view([0 1 0]) % Front view
% view([0 0 1]) % top view
hold on

for i=1:150:size(allTractsInterp,3)
    plot3(squeeze(allTractsInterp(:,1,i)),squeeze(allTractsInterp(:,2,i)), ...
    squeeze(allTractsInterp(:,3,i)),'.','Color',rand(1,3));
end
hold off

%% PLOT alltractInterp (MNI152) 
cd C:\Users\zhouz\GitHub\Virtual-Tractography
load('streamlines.mat')

% x_shift=(max(allTractsInterp(:,1,:),[],"all")-max(x))/2+(min(allTractsInterp(:,1,:),[],"all")-min(x))/2;
% y_shift=(max(allTractsInterp(:,2,:),[],"all")-max(y))/2+(min(allTractsInterp(:,2,:),[],"all")-min(y))/2;
% z_shift=median(allTractsInterp(:,3,:),"all")-median(z); % +(min(allTractsInterp(:,3,:),[],"all")-min(z))/2;
% allTractsInterp(:,1,:)=allTractsInterp(:,1,:)-x_shift;
% allTractsInterp(:,2,:)=allTractsInterp(:,2,:)-y_shift;
% allTractsInterp(:,3,:)=allTractsInterp(:,3,:)-z_shift;

for i=1:150:size(allTractsInterp,3)
    plot3(squeeze(allTractsInterp(:,1,i)),squeeze(allTractsInterp(:,2,i)), ...
    squeeze(allTractsInterp(:,3,i)),'.','Color',rand(1,3));
    % stream_color=rand(1,3);
    % plot3(squeeze(allTractsInterp(1,1,i))+127.5,squeeze(allTractsInterp(1,2,i))+127.5, ...
    % squeeze(allTractsInterp(1,3,i))+127.5,'.','Color',stream_color);
    % plot3(squeeze(allTractsInterp(100,1,i))+127.5,squeeze(allTractsInterp(100,2,i))+127.5, ...
    % squeeze(allTractsInterp(100,3,i))+127.5,'.','Color',stream_color);
end

grid off
xlabel('x');ylabel('y');zlabel('z');
xlim([0 260]);ylim([-40 260]);zlim([0 280]);