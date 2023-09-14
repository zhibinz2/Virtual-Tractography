clear
[Lesion_mask_files, Lesion_Label, Subject_ID, EEG_codename,...
    StrokeFolder, Cortical_Subcortical, Age,Fugl_Meyer_Score, ...
    Time_post_stroke_days, lesion_volume_mm3] = ...
    readvars('demography.xlsx');
whos Lesion_mask_files Lesion_Label Subject_ID EEG_codename...
    StrokeFolder Cortical_Subcortical Age Fugl_Meyer_Score ...
    Time_post_stroke_days lesion_volume_mm3
figure;
clf;
hold on;
for i=1:62
    if Time_post_stroke_days(i) < 30
        plot(log(lesion_volume_mm3(i)),Fugl_Meyer_Score(i),'r.', MarkerSize=15);
    end
    if Time_post_stroke_days(i) > 30
        plot(log(lesion_volume_mm3(i)),Fugl_Meyer_Score(i),'b.', MarkerSize=15);
    end
end
ylabel('Fugl Meyer Score', 'FontSize',12); 
xlabel('log of lesion volume (mm^3)', 'FontSize',12); 
% text(5,11e4,'Time post stroke < 30 days','color','red','FontSize',12);
% text(5,10e4,'Time post stroke > 30 days','color','blue','FontSize',12);
text(3.5,10,'Time post stroke < 30 days','color','red','FontSize',12);
text(3.5,5,'Time post stroke > 30 days','color','blue','FontSize',12);
% title('Patient demographics');
% xlim([-0.5e4 12e4]);ylim([0 70]);
set(gcf,'color','w');