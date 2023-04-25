clear
load('scale60_lesMaskConn.mat')

Face=Brain.Face;
Vertex=Brain.Vertex;

plot3(Face(:,1),Face(:,2),Face(:,3),'r.')

plot3(Vertex(:,1),Vertex(:,2),Vertex(:,3),'r.')

plot(scale60_Labels,'r.')
plot(scale60_subcortROIs,'r.')


slice([-91:90], [-109:108], [-91:90],permute(parcels, [2 1 3]),0,0, 0, 'nearest')