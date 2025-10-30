% Postprocessing

clear variables
close all
clc

%% Initialize all matrices
number_of_run=15;
follow_up_points=9;

SMC_MEDIA = zeros(number_of_run,follow_up_points);
GRAFT_AREA = SMC_MEDIA;
WALL_AREA = SMC_MEDIA;
MEDIA_AREA = SMC_MEDIA;
INT_AREA = SMC_MEDIA;

TIME=(0:1:6);

%% Fill the matrices run by run
load data1
SMC_MEDIA(1,:)=SMCmedia;
GRAFT_AREA(1,:)=Graft_AREA;
WALL_AREA(1,:)=Wall_area;
MEDIA_AREA(1,:)=Med_area;
INT_AREA(1,:)=Wall_area-Med_area;

load data2
SMC_MEDIA(2,:)=SMCmedia;
GRAFT_AREA(2,:)=Graft_AREA;
WALL_AREA(2,:)=Wall_area;
MEDIA_AREA(2,:)=Med_area;
INT_AREA(2,:)=Wall_area-Med_area;

load data3
SMC_MEDIA(3,:)=SMCmedia;
GRAFT_AREA(3,:)=Graft_AREA;
WALL_AREA(3,:)=Wall_area;
MEDIA_AREA(3,:)=Med_area;
INT_AREA(3,:)=Wall_area-Med_area;

load data4
SMC_MEDIA(4,:)=SMCmedia;
GRAFT_AREA(4,:)=Graft_AREA;
WALL_AREA(4,:)=Wall_area;
MEDIA_AREA(4,:)=Med_area;
INT_AREA(4,:)=Wall_area-Med_area;

load data5
SMC_MEDIA(5,:)=SMCmedia;
GRAFT_AREA(5,:)=Graft_AREA;
WALL_AREA(5,:)=Wall_area;
MEDIA_AREA(5,:)=Med_area;
INT_AREA(5,:)=Wall_area-Med_area;

load data6
SMC_MEDIA(6,:)=SMCmedia;
GRAFT_AREA(6,:)=Graft_AREA;
WALL_AREA(6,:)=Wall_area;
MEDIA_AREA(6,:)=Med_area;
INT_AREA(6,:)=Wall_area-Med_area;

load data7
SMC_MEDIA(7,:)=SMCmedia;
GRAFT_AREA(7,:)=Graft_AREA;
WALL_AREA(7,:)=Wall_area;
MEDIA_AREA(7,:)=Med_area;
INT_AREA(7,:)=Wall_area-Med_area;

load data8
SMC_MEDIA(8,:)=SMCmedia;
GRAFT_AREA(8,:)=Graft_AREA;
WALL_AREA(8,:)=Wall_area;
MEDIA_AREA(8,:)=Med_area;
INT_AREA(8,:)=Wall_area-Med_area;

load data9
SMC_MEDIA(9,:)=SMCmedia;
GRAFT_AREA(9,:)=Graft_AREA;
WALL_AREA(9,:)=Wall_area;
MEDIA_AREA(9,:)=Med_area;
INT_AREA(9,:)=Wall_area-Med_area;

load data10
SMC_MEDIA(10,:)=SMCmedia;
GRAFT_AREA(10,:)=Graft_AREA;
WALL_AREA(10,:)=Wall_area;
MEDIA_AREA(10,:)=Med_area;
INT_AREA(10,:)=Wall_area-Med_area;

load data11
SMC_MEDIA(11,:)=SMCmedia;
GRAFT_AREA(11,:)=Graft_AREA;
WALL_AREA(11,:)=Wall_area;
MEDIA_AREA(11,:)=Med_area;
INT_AREA(11,:)=Wall_area-Med_area;

load data12
SMC_MEDIA(12,:)=SMCmedia;
GRAFT_AREA(12,:)=Graft_AREA;
WALL_AREA(12,:)=Wall_area;
MEDIA_AREA(12,:)=Med_area;
INT_AREA(12,:)=Wall_area-Med_area;

load data13
SMC_MEDIA(13,:)=SMCmedia;
GRAFT_AREA(13,:)=Graft_AREA;
WALL_AREA(13,:)=Wall_area;
MEDIA_AREA(13,:)=Med_area;
INT_AREA(13,:)=Wall_area-Med_area;

load data14
SMC_MEDIA(14,:)=SMCmedia;
GRAFT_AREA(14,:)=Graft_AREA;
WALL_AREA(14,:)=Wall_area;
MEDIA_AREA(14,:)=Med_area;
INT_AREA(14,:)=Wall_area-Med_area;

load data15
SMC_MEDIA(15,:)=SMCmedia;
GRAFT_AREA(15,:)=Graft_AREA;
WALL_AREA(15,:)=Wall_area;
MEDIA_AREA(15,:)=Med_area;
INT_AREA(15,:)=Wall_area-Med_area;



%% Take only the follow up time
INT_AREA(:,1:2) = [];
MEDIA_AREA(:,1:2) = [];
GRAFT_AREA(:,1:2) = [];

%% Normalize the trend to the initial value
for jj=1:size(INT_AREA,1)
    
    INT_AREA(jj,:) = INT_AREA(jj,:)./INT_AREA(jj,1);
    GRAFT_AREA(jj,:) = GRAFT_AREA(jj,:)./GRAFT_AREA(jj,1);
    MEDIA_AREA(jj,:) = MEDIA_AREA(jj,:)./MEDIA_AREA(jj,1);
    
end


%% Mean trends
INT_AREA_MEAN = mean(INT_AREA,1);
GRAFT_AREA_MEAN = mean(GRAFT_AREA,1);
MED_AREA_MEAN = mean(MEDIA_AREA,1);


%% Plots
TIME = 30.*TIME;

figure(1)
plot(TIME,MEDIA_AREA,'-','linewidth',1);
hold on
plot(TIME,MED_AREA_MEAN,'k-','linewidth',4);

xlabel('Time [days]')
ylabel('Medial area (normalized)')
title('Medial Area vs. Time')


