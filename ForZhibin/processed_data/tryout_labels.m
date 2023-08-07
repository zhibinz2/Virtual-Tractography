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


%% source labelling
source_x=source_rr(:,1) * 1e3 + 2.5;
source_y=source_rr(:,2) * 1e3 -30;
source_z=source_rr(:,3) * 1e3 -42;


num_source=size(source_rr,1);


