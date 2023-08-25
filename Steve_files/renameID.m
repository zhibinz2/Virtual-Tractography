function renameID( rawdata,cleandata )
% rename( rawdata,cleandata );
% Generates new subject ID, renames files, saves to LOCAL SERVER
% directory

newSubject = input('Is this a new subject for the data repository? Y/N: ','s');
if newSubject == 'Y'
    % Generate new subject ID
    newID = subjectID;

    % Check newID against subject ID database
    fid = fopen('ALL_SUBJECTS.txt');
    AllSubj = textscan(fid,'%s');
    AllSubj = AllSubj{1};

    for k=1:length(AllSubj);
        while strcmp(AllSubj{k},newID)==1;
            clear newID
            newID = subjectID;
        end
    end
    
    % add new subject ID to database
    SHpath = input('Network location for SHAWARMA (ie, D): ','s');
    cd(strcat(SHpath,':\Private\EEG library\study lists'));
    fileID = fopen('ALL_SUBJECTS.txt', 'a');
    fmt='\n%s';
    fprintf(fileID,fmt,newID);
    fclose(fileID);
    
    group = input('Study group: 0 = CONTROL, 1 = acute STROKE, 2 = subacute STROKE, 3 = chronic STROKE, 4 = non STROKE: ');
    if group == 0;
        cd(strcat(SHpath,':\Private\EEG Data Repository\CTRL\'));
    elseif group == 1;
        cd(strcat(SHpath,':\Private\EEG Data Repository\acute STROKE\'));
    elseif group == 2;
        cd(strcat(SHpath,':\Private\EEG Data Repository\subacute STROKE\'));
    elseif group == 3;
        cd(strcat(SHpath,':\Private\EEG Data Repository\chronic STROKE\'));
    elseif group ==4;
        cd(strcat(SHpath,':\Private\EEG Data Repository\non STROKE\'));
    end
    
    % Create new directory
    mkdir(newID);
    cd(newID);
    mkdir('EEG')
    cd('EEG')
    
else
    newID = input('New subject ID: ','s');
    
    SHpath = input('Network location for SHAWARMA (ie, D): ','s');
    group = input('Study group: 0 = CONTROL, 1 = acute STROKE, 2 = subacute STROKE, 3 = chronic STROKE, 4 = non STROKE: ');
    if group == 0;
        cd(strcat(SHpath,':\Private\EEG Data Repository\CTRL\'));
    elseif group == 1;
        cd(strcat(SHpath,':\Private\EEG Data Repository\acute STROKE\'));
    elseif group == 2;
        cd(strcat(SHpath,':\Private\EEG Data Repository\subacute STROKE\'));
    elseif group == 3;
        cd(strcat(SHpath,':\Private\EEG Data Repository\chronic STROKE\'));
    elseif group ==4;
        cd(strcat(SHpath,':\Private\EEG Data Repository\non STROKE\'));
    end
    
    cd(strcat(newID,'/EEG/'))
end

% save raw data
Data = rawdata;
dateStamp = input('EEG acquisition date stamp (YYYYMMDD): ','s');
timeStamp = input('EEG acquisition time stamp (HHMM): ','s');
save(strcat(newID,'_',dateStamp,'_',timeStamp,'.mat'),'Data');
clear Data

% save unflipped clean data
Data = cleandata;
save(strcat(newID,'_',dateStamp,'_noflip.mat'),'Data');
clear Data

if group == 1 || group == 2 || group == 3;
    infarctSide = input('Infarct side (L/R): ','s');
    if infarctSide == 'R';
        for i = 1:size(cleandata,1);
            for j = 1:1000;
                Data(i,j,:)=Flip_RL(squeeze(cleandata(i,j,:)));
            end
        end
    save(strcat(newID,'_',dateStamp,'_flip.mat'),'Data');
    clear Data
    end
end



fprintf(strcat('Data saved to server for:  ',newID,'  .'))
fprintf('~~ Remember to upload data to HNL/DATA 10/CRAMER_REPOSITORY ~~')

end

