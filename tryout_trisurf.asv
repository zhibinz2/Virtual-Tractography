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
load('baseData.mat')

Points=BrainTri.Points;
ConnectivityList=BrainTri.ConnectivityList;

% h2 = trisurf(BrainTri,'FaceColor',[0 1 0],'EdgeColor',[1 0 0],'DisplayName', 'Convex Hull');
h2 = trisurf(BrainTri,'EdgeColor',[1 0 0]);
xlabel('x');ylabel('y');zlabel('z');

plot(Points(:,1),Points(:,3),'r.')

%%
clear
cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography
load('rh_pial.mat')
% Points=rr_mm;
% ConnectivityList=tris;
% BrainTri.Points=rr_mm;
% BrainTri.ConnectivityList=tris;

tri=round(double(tris)+1);
tr = triangulation(tri, rr_mm(:,1), rr_mm(:,2), rr_mm(:,3));
trisurf(tr,'EdgeColor',[1 0 0]);


% h2 = trisurf(BrainTri,'FaceColor',[0 1 0],'EdgeColor',[1 0 0],'DisplayName', 'Convex Hull');
h2 = trisurf(BrainTri,'EdgeColor',[1 0 0]);
xlabel('x');ylabel('y');zlabel('z');

plot(Points(:,3),Points(:,2),'r.')