clear
cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography/ForZhibin/processed_data
load('scale250_Connectome.mat', 'parcels')
unique(parcels)
figure;
for i=20:2:160
    imagesc(squeeze(parcels(i,:,:)));colorbar()
    pause(0.1)
end

for i=20:2:160
    imagesc(squeeze(parcels(:,:,i)));colorbar()
    pause(0.1)
end

for i=20:2:200
    imagesc(squeeze(parcels(:,i,:)));colorbar()
    pause(0.1)
end

imagesc(squeeze(parcels(:,100,:)));colorbar()
imagesc(rot90(squeeze(parcels(:,96,:))));colorbar()
imagesc(rot90(squeeze(parcels(:,117,:))));colorbar()

[X,Y,Z] = ndgrid(1:size(parcels,1), 1:size(parcels,2), 1:size(parcels,3));
pointsize = 30;

ind=find(parcels~=0);
scatter3(X(ind), Y(ind), Z(ind), pointsize, parcels(ind));colorbar()
xlabel('x');ylabel('y');zlabel('z')
view(0,90); %top view
view(90,0); %right view
%% https://www.youtube.com/watch?v=joWN32nZRqE (work!)
close all;
jj=1; % jj  is the frame number
for i=20:2:160
    figure(1);
    imagesc(squeeze(parcels(i,:,:)));colorbar()
    [im{jj},map]=frame2im(getframe);
    jj=jj+1;
    pause(0.1);
end
for i=20:2:160
    imagesc(squeeze(parcels(:,:,i)));colorbar()
    [im{jj},map]=frame2im(getframe);
    jj=jj+1;
    pause(0.1);
end
for i=20:2:200
    imagesc(squeeze(parcels(:,i,:)));colorbar()
    [im{jj},map]=frame2im(getframe);
    jj=jj+1;
    title(num2str(i));
    pause(0.1);
end

clear gifim
for ii=1:jj-1
    gifim(:,:,1,ii)=rgb2ind(im{ii}(1:337,1:183,:),map);
end

imwrite(gifim,map,'filename.gif');