%expandding the corpus callosum 
function expParcels  = expandROIs(parcels)
% this function expands all the ROIs in parcels by one voxel
    expParcels = parcels;
    for allCCs = setdiff(unique(parcels),0)'
        tmpParcels = double(parcels==allCCs);
        tmpParcels = convn(tmpParcels, ones(3,3,3),'same'); % figuring this step out felt good. 3D convolution!
        allInds = intersect(find(tmpParcels<27), find(parcels==allCCs)); %finds the locations on the edge of parcel.
        locs = [];
        for ind = allInds'
            locs = findNeighbors(ind,size(parcels),double(parcels>0));
            for j = 1:size(locs,1)
                expParcels(locs(j,1),locs(j,2),locs(j,3)) = allCCs;
            end
        end
    end
    
function locs = findNeighbors(ind,parcelSize,parcels)

    [x,y,z] = ind2sub(parcelSize,ind);
    tmp = rand(3,3,3);
    [I,J,K] = ind2sub([3,3,3],find(tmp));
    I = I-2;
    J = J-2;
    K = K-2;
    locs = [];
    cnt = 1;
    for i = 1:length(I)
        tmp = [x+I(i), y+J(i), z+K(i)];
        if tmp(1)<= parcelSize(1) && tmp(2)<= parcelSize(2) && tmp(3)<= parcelSize(3) && parcels(tmp(1),tmp(2), tmp(3)) ~=1
            locs(cnt,1:3) = tmp;
            cnt = cnt + 1;
        end
    end
    
end
end