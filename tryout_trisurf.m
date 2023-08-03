clear

[x,y] = meshgrid(1:15,1:15);
tri = delaunay(x,y);
z = peaks(15);
trisurf(tri,x,y,z)
xlabel('x');ylabel('y');zlabel('z');

tr = triangulation(tri, x(:), y(:), z(:));
trisurf(tr)


%%   try out delaunay to produce tri

% Example 1:
close
clear
x = [-0.5 -0.5 0.5 0.5]';
y = [-0.5 0.5 0.5 -0.5]';
plot(x,y,'r.')
tri = delaunay(x,y);
triplot(tri,x,y);

% Highlight the first triangle in red
tri1 = tri(1, [1:end 1]);
hold on
plot(x(tri1), y(tri1), 'r')

% Example 2:
close
clear
X = rand(15,3);
tri = delaunay(X);
tetramesh(tri,X);
xlabel('x');ylabel('y');zlabel('z');

%%
clear
close
cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography
load('baseData.mat')

Points=BrainTri.Points;
ConnectivityList=BrainTri.ConnectivityList;

figure('units','normalized','outerposition',[0 0 0.3 0.8]);
% subplot(121)
% h2 = trisurf(BrainTri,'FaceColor',[0 1 0],'EdgeColor',[1 0 0],'DisplayName', 'Convex Hull');
% h2 = trisurf(BrainTri,'EdgeColor',[1 0 0]);
trisurf(BrainTri,'EdgeColor',[0.5 0.5 0.5],'EdgeAlpha',0.5);
xlabel('x');ylabel('y');zlabel('z');
title('baseData')
view(90,0)
ylim([-125,125]); zlim([-125,125]); xlim([-125,125]);
% plot(Points(:,1),Points(:,3),'r.')

%%
clear
close
% cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography
cd /home/zhibinz2/Documents/GitHub/brain_network_python/mne_test/
load('rh_pial.mat')
% Points=rr_mm;
% ConnectivityList=tris;
% BrainTri.Points=rr_mm;
% BrainTri.ConnectivityList=tris;
% subplot(122)

figure('units','normalized','outerposition',[0 0 0.3 0.8]);
tri=round(double(tris)+1);
tr = triangulation(tri, rr_mm(:,1), rr_mm(:,2), rr_mm(:,3));
% trisurf(tr,'EdgeColor',[1 0 0]);
trisurf(tr,'EdgeColor',[0.5 0.5 0.5],'EdgeAlpha',0.5);
xlabel('x');ylabel('y');zlabel('z');
title('mne-data/MNE-sample-data/subjects/fsaverage/surf/rh.pial')
view(90,0)
ylim([-125,125]); zlim([-125,125]); xlim([-125,125]);
% plot(Points(:,3),Points(:,2),'r.')

%% XPS17
cd C:\Users\zhouz\GitHub\brain_network_python\mne_test
load('rh_pial.mat')

figure('units','normalized','outerposition',[0 0 0.3 0.8]);
tri=round(double(tris)+1);
tr = triangulation(tri, rr_mm(:,1), rr_mm(:,2), rr_mm(:,3));
% trisurf(tr,'EdgeColor',[1 0 0]);
trisurf(tr,'EdgeColor',[0.5 0.5 0.5],'EdgeAlpha',0.5);
xlabel('x');ylabel('y');zlabel('z');
title('mne-data/MNE-sample-data/subjects/fsaverage/surf/rh.pial')
view(90,0)
ylim([-125,125]); zlim([-125,125]); xlim([-125,125]);

%% XPS17
cd C:\Users\zhouz\GitHub\Virtual-Tractography
cd C:\Users\zhouz\GitHub\CAMCAN_MEG_100
load('Lausanne2008_fsaverageDSsurf_60_125_250.mat')

addpath C:\Users\zhouz\GitHub\matlab\3Dtools
drawmesh(Brain)

% select the surface
BrainTri=Brain;

Vertex=BrainTri.Vertex;
Face=BrainTri.Face;

tr = triangulation(Face, Vertex(:,1), Vertex(:,2), Vertex(:,3));

trisurf(tr,'EdgeColor',[0.01 0.01 0.01],'EdgeAlpha',0.1);
alpha 0.5

% plot3(Vertex(:,1), Vertex(:,2), Vertex(:,3),'color',[0.2 0.2 0.2 0.1])
xlabel('x');ylabel('y');zlabel('z');
title('Lausanne2008-fsaverageDSsurf-60-125-250-Brain')
view(90,0)

cd C:\Users\zhouz\Downloads\zhibin_source_localization
load('leadfield_nn_rr.mat')
hold on 
plot3(source_rr(:,1) * 1e3 + 2.5,source_rr(:,2) * 1e3 -30,source_rr(:,3) * 1e3 -42,'r.')
% plot3(source_vox(:,1),source_vox(:,2),source_vox(:,3),'r.')
% plot3(source_mri(:,1),source_mri(:,2),source_mri(:,3),'r.')
% plot3(source_test(:,1),source_test(:,2),source_test(:,3),'r.')
% plot3(dip_pos(:,1)* 1e3,dip_pos(:,2)* 1e3,dip_pos(:,3)* 1e3,'r.')
% plot3(dip_ori(:,1),dip_ori(:,2),dip_ori(:,3),'r.') % sphere
% use_tris=double(use_tris);
% plot3(use_tris(:,1),use_tris(:,2),use_tris(:,3),'r.') 
view(90,0)
ylim([-125,125]); zlim([-125,125]); xlim([-125,125]);
grid on
title('source-rr from forward solution (shifted by 1e3+2.5,1e3-30,1e3-42)')
% plot3(source_nn(:,1),source_nn(:,2),source_nn(:,3),'b.') % sphere

