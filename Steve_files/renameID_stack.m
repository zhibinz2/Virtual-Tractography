function renameID_stack( studyList,studyDirectory )
% rename_stack( rawdata,cleandata );
% Generates new subject ID, renames files, saves to LOCAL SERVER
% for stack of subjects

% studyList: rawdata,cleandata,SHpath,group,newSubject,dateStamp,timeStamp,newID
% studyDirectory


cd(studyDirectory)
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
    cd(strcat(SHpath,':\Private\EEG library\study lists'));
    fileID = fopen('ALL_SUBJECTS.txt', 'a');
    fmt='\n%s';
    fprintf(fileID,fmt,newID);
    fclose(fileID);
    
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
save(strcat(newID,'_',dateStamp,'_',timeStamp,'.mat'),'Data');
clear Data

% save unflipped clean data
Data = cleandata;
save(strcat(newID,'_',dateStamp,'_noflip.mat'),'Data');
clear Data

if group == 1 || group == 2 || group == 3;
    for i = 1:size(cleandata,1);
        for j = 1:1000;
            Data(i,j,:)=Flip_RL(squeeze(cleandata(i,j,:)));
        end
    end
end
save(strcat(newID,'_',dateStamp,'_flip.mat'),'Data');
clear Data


fprintf(strcat('Data saved to server for  ',newID,'  .'))
cd(studyDirectory)

end

