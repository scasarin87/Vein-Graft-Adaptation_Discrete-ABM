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

TIME=[0 1 2 3 4 5 6 7 8];

%% Fill the matrices run by run
load data1
SMC_MEDIA(1,:)=SMCmedia;
GRAFT_AREA(1,:)=Graft_AREA;
WALL_AREA(1,:)=Wall_area;
MEDIA_AREA(1,:)=Med_area;

load data2
SMC_MEDIA(2,:)=SMCmedia;
GRAFT_AREA(2,:)=Graft_AREA;
WALL_AREA(2,:)=Wall_area;
MEDIA_AREA(2,:)=Med_area;

load data3
SMC_MEDIA(3,:)=SMCmedia;
GRAFT_AREA(3,:)=Graft_AREA;
WALL_AREA(3,:)=Wall_area;
MEDIA_AREA(3,:)=Med_area;

load data4
SMC_MEDIA(4,:)=SMCmedia;
GRAFT_AREA(4,:)=Graft_AREA;
WALL_AREA(4,:)=Wall_area;
MEDIA_AREA(4,:)=Med_area;

load data5
SMC_MEDIA(5,:)=SMCmedia;
GRAFT_AREA(5,:)=Graft_AREA;
WALL_AREA(5,:)=Wall_area;
MEDIA_AREA(5,:)=Med_area;

load data6
SMC_MEDIA(6,:)=SMCmedia;
GRAFT_AREA(6,:)=Graft_AREA;
WALL_AREA(6,:)=Wall_area;
MEDIA_AREA(6,:)=Med_area;

load data7
SMC_MEDIA(7,:)=SMCmedia;
GRAFT_AREA(7,:)=Graft_AREA;
WALL_AREA(7,:)=Wall_area;
MEDIA_AREA(7,:)=Med_area;

load data8
SMC_MEDIA(8,:)=SMCmedia;
GRAFT_AREA(8,:)=Graft_AREA;
WALL_AREA(8,:)=Wall_area;
MEDIA_AREA(8,:)=Med_area;

load data9
SMC_MEDIA(9,:)=SMCmedia;
GRAFT_AREA(9,:)=Graft_AREA;
WALL_AREA(9,:)=Wall_area;
MEDIA_AREA(9,:)=Med_area;

load data10
SMC_MEDIA(10,:)=SMCmedia;
GRAFT_AREA(10,:)=Graft_AREA;
WALL_AREA(10,:)=Wall_area;
MEDIA_AREA(10,:)=Med_area;

load data11
SMC_MEDIA(11,:)=SMCmedia;
GRAFT_AREA(11,:)=Graft_AREA;
WALL_AREA(11,:)=Wall_area;
MEDIA_AREA(11,:)=Med_area;

load data12
SMC_MEDIA(12,:)=SMCmedia;
GRAFT_AREA(12,:)=Graft_AREA;
WALL_AREA(12,:)=Wall_area;
MEDIA_AREA(12,:)=Med_area;

load data13
SMC_MEDIA(13,:)=SMCmedia;
GRAFT_AREA(13,:)=Graft_AREA;
WALL_AREA(13,:)=Wall_area;
MEDIA_AREA(13,:)=Med_area;

load data14
SMC_MEDIA(14,:)=SMCmedia;
GRAFT_AREA(14,:)=Graft_AREA;
WALL_AREA(14,:)=Wall_area;
MEDIA_AREA(14,:)=Med_area;

load data15
SMC_MEDIA(15,:)=SMCmedia;
GRAFT_AREA(15,:)=Graft_AREA;
WALL_AREA(15,:)=Wall_area;
MEDIA_AREA(15,:)=Med_area;

%% Plot the trends of interest
figure(1) % #SMC in medial layer
plot(TIME,SMC_MEDIA,'linewidth',1);
hold on; plot(TIME,mean(SMC_MEDIA,1),'k*-','linewidth',3); hold off

xlabel('Time[months]')
ylabel('#SMC')

title('#SMC in medial layer vs. Time')
legend('1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','mean')


figure(2) % Medial Area
plot(TIME,MEDIA_AREA,'linewidth',1);
hold on; plot(TIME,mean(MEDIA_AREA,1),'k*-','linewidth',3); hold off

xlabel('Time[months]')
ylabel('#SMC+#ECM')

title('Medial Area vs. Time')
legend('1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','mean')


figure(3) % Wall Area
plot(TIME,WALL_AREA,'linewidth',1);
hold on; plot(TIME,mean(WALL_AREA,1),'k*-','linewidth',3); hold off

xlabel('Time[months]')
ylabel('#SMC+#ECM')

title('Wall Area vs. Time')
legend('1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','mean')


figure(4)
plot(TIME,GRAFT_AREA,'linewidth',1);
hold on; plot(TIME,mean(GRAFT_AREA,1),'k*-','linewidth',3); hold off

xlabel('Time[months]')
ylabel('#SMC+#ECM')

title('Graft Area vs. Time')
legend('1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','mean')


figure(5) % All the plots

subplot(2,2,1)
plot(TIME,mean(SMC_MEDIA,1),'r*-','linewidth',3);
xlabel('Time[months]')
ylabel('#SMC')
title('#SMC in media vs. Time')

subplot(2,2,2)
plot(TIME,mean(GRAFT_AREA,1),'b*-','linewidth',3);
xlabel('Time[months]')
ylabel('#SMC + #ECM')
title('Graft area vs. Time')

subplot(2,2,3)
plot(TIME,mean(MEDIA_AREA,1),'c*-','linewidth',3)
xlabel('Time[months]')
ylabel('#SMC + #ECM')
title('Medial area vs. Time')

subplot(2,2,4)
plot(TIME,mean(WALL_AREA,1),'m*-','linewidth',3)
xlabel('Time[months]')
ylabel('#SMC + #ECM')
title('Wall area vs. Time')






