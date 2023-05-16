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

%%

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

