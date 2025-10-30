% postprocessing reviewer
clear variables
close all
clc

load ECM_MEDIA.mat
ECM_MEDIA(:,1:4)=[];
ECM_MEDIA_MEAN = mean(ECM_MEDIA,1);
TIME2=(0:0.5:6);

plot(TIME2,ECM_MEDIA,'-','linewidth',1);
hold on
plot(TIME2,ECM_MEDIA_MEAN,'k*-','linewidth',3);
xlabel('Time[months]')
ylabel('Number of ECM')
