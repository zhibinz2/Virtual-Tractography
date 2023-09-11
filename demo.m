% DEMO CODE
% THis will use the lesMaskDemo volume and remove those streamlines that
% intersect with the pseudo lesion 

clear
load('baseData.mat')

try
    figure
    % slice([-91:90], [-109:108], [-91:90],permute(parcels, [2 1 3]),0,0, 0, 'nearest')
    h1 = slice([-91:90], [-109:108], [-91:90],permute(lesMaskDemo, [2 1 3]),0,0, 0, 'nearest');
    xlabel('x');ylabel('y');zlabel('z');
    shading flat;    
    hold on
    h2 = trisurf(BrainTri);
    colorbar
    set(h2,'FaceAlpha', .3, 'EdgeAlpha', .5, 'FaceColor', 'blue');
    disp('Lesion mask is in yellow in center')
catch
    disp('Unable to display the brain mesh and demo lesion mask')
end

%%
close
% clear
disp('Using the Virtual Structural Connectome code:')
load('streamlines.mat')
% currently parcels is the Lausanne-60 parcellation (I think it is 129?)
[sc_new,rc] = getLesionMaskConnectome(allTractsInterp, parcels,lesMaskDemo);

sc_new = sc_new .* double(~eye(length(sc_new))); % diagonal contains degrees for each node right now, removing that
rc = rc .* double(~eye(length(sc_new)));

% Ahead: removing non-homotopic connections - optional; 
% SC matrix used here needs to be recreated for the parcellation applied.
% Use with caution.
fullsc = sc_new.* (SC>0);
redConn = rc.*(SC>0); 


% plot
disp('Binary SC and Virtual SC')
figure
subplot(121)
imagesc(fullsc>0)
axis square
title('Binary SC','Fontsize', 18)
subplot(122)
imagesc(redConn>0)
axis square
title('Binary Virtual SC', 'Fontsize', 18)

disp('Weighted SC and Virtual SC')
figure
subplot(121)
imagesc(log(fullsc+eps))
axis square
caxis([-5,5])
colorbar
title('Weighted SC', 'Fontsize', 18)
subplot(122)
imagesc(log(redConn+eps))
axis square
caxis([-5,5])
title('Weighted Virtual SC', 'Fontsize', 18)
colorbar