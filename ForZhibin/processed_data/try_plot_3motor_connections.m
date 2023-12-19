cd /home/zhibinz2/Documents/GitHub/Virtual-Tractography/ForZhibin/processed_data
load('scale250_Connectome.mat'); % load fc
% the boolean of the full connections
% fc_bool=logical(fc);
load('Lausanne2008_fsaverageDSsurf_60_125_250.mat');
Face=Brain.Face;
Vertex=Brain.Vertex+127.5;
[Face,Vertex] = reducepatch(Face, Vertex, 0.5); % downsample to half 
tr = triangulation(Face, Vertex(:,1), Vertex(:,2), Vertex(:,3));


superiorfrontal_R=[37:53];
caudalmiddlefrontal_R=[54:58];
precentral_R=[59:74];

superiorfrontal_L=[265:282];
caudalmiddlefrontal_L=[283:288];
precentral_L=[289:309];

SMA=[superiorfrontal_R superiorfrontal_L];
PMC=[caudalmiddlefrontal_R caudalmiddlefrontal_L];
M1=[precentral_R precentral_L];

% all connected ROIs to these 3 areas (might include subcortical ROIs)
SMA_cnted_rois=getconnection(fc,SMA); % 134
PMC_cnted_rois=getconnection(fc,PMC); % 103
M1_cnted_rois=getconnection(fc,M1); % 181


%% load all cortical sources
cd /ssd/zhibin/Cleaned_sourcedata/cortical_source_data
load('corti_ave_source_coor.mat')
load('corti_ave_source_labl.mat')
corti_ave_source_coor=corti_ave_source_coor{12,2,12};
corti_ave_source_labl=corti_ave_source_labl{12,2,12};
x=corti_ave_source_coor(:,1);
y=corti_ave_source_coor(:,2);
z=corti_ave_source_coor(:,3);

% extract cortical connectome
corti_fc=fc(corti_ave_source_labl,corti_ave_source_labl);
% imagesc(fc);
% imagesc(logical(fc));
% imagesc(corti_fc);
% imagesc(logical(corti_fc));

% updated ROI label to cortical
SMA_c=find(ismember(corti_ave_source_labl,SMA));
PMC_c=find(ismember(corti_ave_source_labl,PMC));
M1_c=find(ismember(corti_ave_source_labl,M1));

% all connected ROIs to these 3 areas (only cortical ROIs)
SMA_c_cnted_rois=getconnection(corti_fc,SMA_c); % 125 (removed 9 subcortial areas)
PMC_c_cnted_rois=getconnection(corti_fc,PMC_c); % 94 (removed 9 subcortial areas)
M1_c_cnted_rois=getconnection(corti_fc,M1_c); % 171 (removed 10 subcortial areas)
%% plot
figure;
clf
freq_select=[2 4 5];
for i=1:3
    subplot(1,3,i)
    hold on;

    Brainmesh=trimesh(tr,'EdgeColor',[0.01 0.01 0.01],'EdgeAlpha',0.01);
    colormap(gca,'gray');
    alpha(Brainmesh, 0.1);

    if i==1; 
        cnted_rois=SMA_c_cnted_rois; title('superiorfrontal','FontSize',20)
    elseif i==2;
        cnted_rois=PMC_c_cnted_rois; title('caudalmiddlefrontal','FontSize',20)
    else i==3;
        cnted_rois=M1_c_cnted_rois; title('precentral','FontSize',20)
    end

    scatter3(x,y,z,'g','filled'); hold on;
    scatter3(x(cnted_rois),y(cnted_rois),z(cnted_rois),'r','filled');
    % text label
%     for j=1:length(cnted_rois)
%         text(x(cnted_rois(j)),y(cnted_rois(j)),z(cnted_rois(j)),roiNames_250{corti_ave_source_labl(cnted_rois(j))},'FontSize',5);
%     end
    view(0,90); %top view
    grid off
    axis off
    hold off
end
set(gcf,'color','w'); 

%%

