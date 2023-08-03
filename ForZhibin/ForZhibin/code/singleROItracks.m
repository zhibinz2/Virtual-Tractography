function [reducedTracks, parcelTracks] = singleROItracks(tract_interp, parcels, lesMask)
% This function takes a nifti file with a single ROI labeled and the lesion
% mask and returns two vectors, organized in same order as the tract_interp
% that tells us both whether the lesion and ROI have intersected that
% streamline and also, which streamlines intersect the ROI.
% -- Ani Wodeyar
voxel_size  =1; %1mm cubes 

disp('assuming tracts are centered at zeros and correcting that so that we can extract volume values')
pause(2)
tract_interp(:,1,:) = tract_interp(:,1,:) + 90.5;
tract_interp(:,2,:) = tract_interp(:,2,:) + 108.5;
tract_interp(:,3,:) = tract_interp(:,3,:) + 90.5;

numROIs = length(nonzeros(unique(parcels(:))));
if numROIs>1
    disp('error: expecting a 3D matrix with only a single ROI labeled')
    return
end

reducedTracks = zeros(length(tract_interp),1);
parcelTracks = zeros(size(tract_interp,3),1);

for iTrk=1:size(tract_interp,3)
    
    % Translate continuous vertex coordinates into discrete voxel coordinates
    vox = ceil(squeeze(tract_interp(:,1:3,iTrk)) ./ repmat(voxel_size, size(tract_interp,1),3)); %could multiple tracks wind up with the same voxel coordinate?
    
    % Index into volume to extract scalar values
    inds                = sub2ind([size(parcels,1),size(parcels,2), size(parcels,3)], vox(:,1), vox(:,2), vox(:,3));
    scalars             = parcels(inds);
    lesMaskIntersect    = lesMask(inds); % checking for intersections of lesion mask with this streamline anywhere along its path
    
    if sum(scalars) > 0
        if sum(lesMaskIntersect) >0
            reducedTracks(iTrk) = 1;
        end
        parcelTracks(iTrk) = 1;
    end
  
end