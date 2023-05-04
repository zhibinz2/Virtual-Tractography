close;
clear;

cd /home/zhibinz2/Documents/GitHub/AdaptiveGraphicalLassoforParCoh/headmodel
load('FSavg_surfaces.mat')
% select the surface
BrainTri=Brain;

Vertex=BrainTri.Vertex;
Face=BrainTri.Face;

tr = triangulation(Face, Vertex(:,1), Vertex(:,2), Vertex(:,3));
trisurf(tr);
xlabel('x');ylabel('y');zlabel('z');
title('FSavg-surfaces-Brain')
view(90,0)