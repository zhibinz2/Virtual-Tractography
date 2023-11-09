cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography/ForZhibin/processed_data
load('scale250_Connectome.mat');

superiorfrontal_R=[37:53];
caudalmiddlefrontal_R=[54:58];
precentral_R=[59:74];

superiorfrontal_L=[265:282];
caudalmiddlefrontal_L=[283:288];
precentral_L=[289:309];

LR3motors=[superiorfrontal_R caudalmiddlefrontal_R precentral_R superiorfrontal_L caudalmiddlefrontal_L precentral_L];
LR3motors=[superiorfrontal_R superiorfrontal_L];
LR3motors=[caudalmiddlefrontal_R caudalmiddlefrontal_L];
LR3motors=[precentral_R precentral_L];


fc_bool=logical(fc);
% imagesc(fc);
% imagesc(logical(fc));

motor_ones=zeros(size(fc));
% motor_ones(LR3motors,LR3motors)=1;
motor_ones(LR3motors,:)=1;
motor_ones(:,LR3motors)=1;
% imagesc(motor_ones)
% length(find(motor_ones));
non_motor_ones=~motor_ones;
% imagesc(non_motor_ones)
% imagesc(fc_bool)
fc_bool(find(non_motor_ones))=0;
% imagesc(fc_bool)

[r,c,v]=find(fc_bool); % r and c are the index of rows and colums, v is the values of ones

% all connected ROIs labels
connected_rois=unique([r;c]);

% plot all sources connected
[bool_a,ind_b] = ismember(source_labels,connected_rois);

% load source
cd /home/zhibinz2/Documents/GitHub/MEG_EEG_Source_Localization/EEG_32chan_pca
load('source_rr.mat');
%% load source and aligned with fsaverage
cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography/ForZhibin/processed_data
load('Lausanne2008_fsaverageDSsurf_60_125_250.mat')
% label the sources
Vertex=Brain.Vertex;
load('parcels.mat') % This is the labels
% Anni's labeling method
x_shift=(max(Vertex(:,1))-max(source_rr(:,1))*1e3)/2+(min(Vertex(:,1))-min(source_rr(:,1))*1e3)/2;
y_shift=(max(Vertex(:,2))-max(source_rr(:,2))*1e3)/2+(min(Vertex(:,2))-min(source_rr(:,2))*1e3)/2;
z_shift=(max(Vertex(:,3))-max(source_rr(:,3))*1e3)/2+(min(Vertex(:,3))-min(source_rr(:,3))*1e3)/2;
% x_shift=(max(Vertex(:,1))-max(source_rr(:,1))*1e3)/3+(min(Vertex(:,1))-min(source_rr(:,1))*1e3)/3+...
%         (mean(Vertex(:,1))-mean(source_rr(:,1))*1e3)/3;
% y_shift=(max(Vertex(:,2))-max(source_rr(:,2))*1e3)/3+(min(Vertex(:,2))-min(source_rr(:,2))*1e3)/3+...
%         (mean(Vertex(:,2))-mean(source_rr(:,2))*1e3)/3;
% z_shift=(max(Vertex(:,3))-max(source_rr(:,3))*1e3)/3+(min(Vertex(:,3))-min(source_rr(:,3))*1e3)/3+...
%         (mean(Vertex(:,3))-mean(source_rr(:,3))*1e3)/3;
% x_shift=(mean(Vertex(:,1))-mean(source_rr(:,1))*1e3);
% y_shift=(mean(Vertex(:,2))-mean(source_rr(:,2))*1e3);
% z_shift=(mean(Vertex(:,3))-mean(source_rr(:,3))*1e3);
source_x=source_rr(:,1) * 1e3 + x_shift;
source_y=source_rr(:,2) * 1e3 + y_shift;
source_z=source_rr(:,3) * 1e3 + z_shift;
source_xyz=[source_x source_y source_z];
num_source=size(source_xyz,1);
source_fsaverage = source_xyz+127.5; % 127.5 is based on the fsaverage volume being 256 x 256 x 256
source_labels=zeros(num_source,1);
for i = 1:length(source_fsaverage)
    vox = floor(source_fsaverage(i,:)); % change from ceil to floor,now we have 2 subcortical not mapped
    inds              = sub2ind([size(parcels)], vox(1), vox(2), vox(3));
    label             = parcels(inds); 
    source_labels(i) = label;
end

%% aligned with drawmesh
cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography/ForZhibin/processed_data
load('scale250_Connectome.mat')
figure('units','inch','position',[0,0,10,8]);
clf
Face=Brain.Face;
Vertex=Brain.Vertex;
x=source_fsaverage(:,1); y=source_fsaverage(:,2); z=source_fsaverage(:,3);
x_shift=(max(Vertex(:,1))-max(x))/2+(min(Vertex(:,1))-min(x))/2;
y_shift=(max(Vertex(:,2))-max(y))/2+(min(Vertex(:,2))-min(y))/2;
z_shift=(max(Vertex(:,3))-max(z))/2+(min(Vertex(:,3))-min(z))/2;
Vertex(:,1)=Vertex(:,1)-x_shift;
Vertex(:,2)=Vertex(:,2)-y_shift;
Vertex(:,3)=Vertex(:,3)-z_shift;
tr = triangulation(Face, Vertex(:,1), Vertex(:,2), Vertex(:,3));
Brainmesh=trimesh(tr,'EdgeColor',[0.01 0.01 0.01],'EdgeAlpha',0.02);
colormap('gray');
alpha(Brainmesh, 0.01);

view([-1,0,0]) % left side view
hold on;
%% plot

% shift coordinates of the sources to the center
shift_x=mean(source_x)-0;shift_y=mean(source_y)-0;shift_z=mean(source_z)-0;
source_x=source_x-shift_x;source_y=source_y-shift_y;source_z=source_z-shift_z;

% plot all connected areas to the 3 motor areas
% figure('units','normalized','outerposition',[0 0 0.1 0.4]);
figure;
clf;
% subplot(131);
scatter3(source_x,source_y,source_z,'g');
hold on;
scatter3(source_x(bool_a),source_y(bool_a),source_z(bool_a),'r.');
vlim=90;
xlim([-1*vlim vlim]);ylim([-1*vlim vlim]);zlim([-1*vlim vlim]);
grid off;
axis off;
set(gcf,'color','w');
% view([-1,0,0]) % left side view
view([1,0,0]) % right side view
% view([0 1 0]) % Front view
% view([0 -1 0]) % Back view
% view([0 0 1]) % top view
% view([0 0 -1]) % bottom view
% rotate3d on
% rotate3d('on')

% figure('units','normalized','outerposition',[0 0 0.2 0.4]);
figure
scatter3(source_x,source_y,source_z,'g');
hold on;
scatter3(source_x(bool_a),source_y(bool_a),source_z(bool_a),'r.');
vlim=90;
xlim([-1*vlim vlim]);ylim([-1*vlim vlim]);zlim([-1*vlim vlim]);
grid off;
axis off;
set(gcf,'color','w');
view([0 0 1]) % top view
title('top anterior')

figure
scatter3(source_x,source_y,source_z,'g');
hold on;
scatter3(source_x(bool_a),source_y(bool_a),source_z(bool_a),'r.');
vlim=90;
xlim([-1*vlim vlim]);ylim([-1*vlim vlim]);zlim([-1*vlim vlim]);
grid off;
axis off;
set(gcf,'color','w');
view([0 0 -1]) % bottom view
title('bottom posterior')

sgtitle('connected with M1');

sgtitle('connected with PMC');
sgtitle('connected with SMA');
%% Anymate (skip)
% https://www.mathworks.com/matlabcentral/fileexchange/18210-anymate
anymate(@plot,rand(5,5,5), 'Play', true);

[x,y,z]=sphere;
anymate(@surf,{cat(3,x,.2*x+1) cat(3,y,y) cat(3,z,2*z)});
colormap(jet);

%% Create Video of Rotating 3D Plot
% https://www.mathworks.com/matlabcentral/fileexchange/41093-create-video-of-rotating-3d-plot
cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography/ForZhibin/processed_data/video3d_plot/CaptureFigVid/CaptureFigVid



%% git to avi
https://www.mathworks.com/matlabcentral/fileexchange/76198-gif2avi

%% ChatGPT
% Create a figure and specify the filename for the GIF
figure;
filename = 'rotating_3d_plot.gif';

% Set the number of frames and the rotation angles
num_frames = 120;
azimuth_range = linspace(0, 360, num_frames);

for frame = 1:num_frames
    % Create your 3D plot or update your plot here
    % Replace this section with your own plot code
    % Example: Create a simple 3D surface plot
    [X, Y] = meshgrid(linspace(-1, 1, 100), linspace(-1, 1, 100));
    Z = X.^2 + Y.^2;
    surf(X, Y, Z);
    
    % Set the view angle based on the current frame
    view(azimuth_range(frame), 30); % Change 30 to your desired elevation angle
    
    % Capture the frame for the GIF
    frame_data = getframe(gcf);
    
    % Create the GIF or append to it
    if frame == 1
        imwrite(frame_data.cdata, filename, 'gif', 'Loop', Inf, 'DelayTime', 0.1);
    else
        imwrite(frame_data.cdata, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.1);
    end
end

%% https://stackoverflow.com/questions/37276645/rotation-increments-are-off-on-3d-object
clf 
[Z,Y,X] = cylinder(10:-1:0, 50);
xlabel('X axis')
ylabel('Y axis')
zlabel('Z axis')
array_sz_begin=size(X);
W=repmat(1,array_sz_begin); %create ones for w
figure(1), clf;surf(X,Y,Z);axis equal;
%--- z-rotation matrix Rz
for n=1:1:45
    th=n*pi/180; %angle of rotation converted to radians;
    Rz=[cos(th) -sin(th) 0 0;sin(th) cos(th) 0 0;0 0 1 0;0 0 0 1];
    P=[X(:) Y(:) Z(:) W(:)]*Rz; %rotate each point on surface
    X=reshape(P(:,1),array_sz_begin);%transform surface vertices back
    Y=reshape(P(:,2),array_sz_begin);
    Z=reshape(P(:,3),array_sz_begin);
    xlabel('X axis')
    ylabel('Y axis')
    zlabel('Z axis')
    clear P;
    title(['Shift in ',num2str(n),' deg']);
    hold on;surf(X,Y,Z);axis equal;
    pause (.5)
end

%% https://www.mathworks.com/matlabcentral/discussions/highlights/741369-new-in-matlab-r2022a-export-graphics-to-animated-gifs

%% https://www.mathworks.com/help/symbolic/writeanimation.html
syms t x
fanimator(@fplot,cos(x)+t,sin(x)+1,[-pi pi])
axis equal
writeAnimation('wheel.gif')
%% https://www.youtube.com/watch?v=joWN32nZRqE (work!)
clear all; close all;

x=1; y=1;
plot(x,y,'*'); axis([0,10,0,10]); grid;

im={}; jj=1; % jj  is the frame number

[im{jj},map]=frame2im(getframe);

jjend=10; % total 10 frames

for jj=2:jjend
    figure(1)
    clf 

    x=x+1; y=y+1;
    plot(x,y,'*');axis([0,10,0,10]);grid;

    [im{jj},map]=frame2im(getframe);

    jj=jj+1;
end

[temp, map]=rgb2ind(im{1},65536); % maximum is 65536

for jj=1:jjend
    gifim(:,:,1,jj)=rgb2ind(im{jj},map);
end

imwrite(gifim,map,'filename.gif');
%%
r = 1;
xm = 0;
ym = 0;
teta = linspace(0, 2.5*pi, 25);
x = r*cos(teta) + xm;
y = r*sin(teta) + ym;
inclined_angle = 22;
z = ones(1,length(x));

figure
c = plot3(x, y, z);
grid on
xlabel('x')
ylabel('y')
axis('equal')
view(15,20)
rotate(c, [1 1 0], inclined_angle)                      % Inclines In 'x' and 'y' Directions

%% rotation 2.5 pi two ways
cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography/ForZhibin/processed_data/video3d_plot
view([1,0,0]) % right side view
grid off;
axis on;
im={}; 
% jj=1; % jj  is the frame number
% [im{jj},map]=frame2im(getframe);
% figure;imagesc(im{1})
x=0;y=0;y2=1;z=1;
n_onecir=50;
theta = linspace(0, 2.5*pi, n_onecir);
jjend=2*n_onecir-1; % total jjend frames
xs=cos(theta);ys=sin(theta);y2s=cos(theta);zs=-1*sin(theta);
xlim([-120 120]);ylim([-120 120]);zlim([-120 120]);
for jj=1:jjend
    figure(1)
    if jj<n_onecir;
        x=x+1;y=y+1;
        view([xs(x),ys(y),0])
    elseif jj==n_onecir;
        view([xs(x),ys(y),0])
    else jj>n_onecir;
        y2=y2+1;z=z+1;
        view([0,y2s(y2),zs(z)])
    end
    [im{jj},map]=frame2im(getframe);
    jj=jj+1;
    pause(0.5)
end
[temp, map]=rgb2ind(im{1},65536); % maximum is 65536

clear gifim
for jj=1:jjend
    gifim(:,:,1,jj)=rgb2ind(im{jj}(1:380,1:493,:),map);
end

imwrite(gifim,map,'filename.gif');


%% rotation 1/3subplots
cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography/ForZhibin/processed_data/video3d_plot
% subplot(131);
view([1,0,0]) % right side view
grid off;
axis off;
im={}; 
% jj=1; % jj  is the frame number
% [im{jj},map]=frame2im(getframe);
% figure;imagesc(im{1})
x=0;y=0;
n_onecir=40;
theta = linspace(0, 2*pi, n_onecir);
% jjend=n_onecir-1; % total jjend frames
xs=cos(theta);ys=sin(theta);
xlim([-120 120]);ylim([-120 120]);zlim([-120 120]);
for jj=1:n_onecir
    figure(1)
    x=x+1;y=y+1;
    view([xs(x),ys(y),0])

    [im{jj},map]=frame2im(getframe);
    jj=jj+1;
    pause(0.5)
end
[temp, map]=rgb2ind(im{1},65536); % maximum is 65536

clear gifim
for jj=1:n_onecir
    gifim(:,:,1,jj)=rgb2ind(im{jj}(1:343,1:380,:),map);
end

imwrite(gifim,map,'m1.gif');