% postprocessing
clear variables
close all
clc

% Initialization fo the matrices
number_of_run = 15;
number_of_time_points = 17;

SMC_MEDIA = zeros(number_of_run,number_of_time_points);
ECM_MEDIA = zeros(number_of_run,number_of_time_points);
MED_AREA = zeros(number_of_run,number_of_time_points);
GRAFT_AREA = zeros(number_of_run,number_of_time_points);

TIME = (0:0.5:8);

% Load ABM results and fill the matrices
load data1
SMC_MEDIA(1,:) = SMCmedia;
ECM_MEDIA(1,:) = ECMmedia;
MED_AREA(1,:) = Med_area;
GRAFT_AREA(1,:) = Graft_area;

load data2
SMC_MEDIA(2,:) = SMCmedia;
ECM_MEDIA(2,:) = ECMmedia;
MED_AREA(2,:) = Med_area;
GRAFT_AREA(2,:) = Graft_area;

load data3
SMC_MEDIA(3,:) = SMCmedia;
ECM_MEDIA(3,:) = ECMmedia;
MED_AREA(3,:) = Med_area;
GRAFT_AREA(3,:) = Graft_area;

load data4
SMC_MEDIA(4,:) = SMCmedia;
ECM_MEDIA(4,:) = ECMmedia;
MED_AREA(4,:) = Med_area;
GRAFT_AREA(4,:) = Graft_area;

load data5
SMC_MEDIA(5,:) = SMCmedia;
ECM_MEDIA(5,:) = ECMmedia;
MED_AREA(5,:) = Med_area;
GRAFT_AREA(5,:) = Graft_area;

load data6
SMC_MEDIA(6,:) = SMCmedia;
ECM_MEDIA(6,:) = ECMmedia;
MED_AREA(6,:) = Med_area;
GRAFT_AREA(6,:) = Graft_area;

load data7
SMC_MEDIA(7,:) = SMCmedia;
ECM_MEDIA(7,:) = ECMmedia;
MED_AREA(7,:) = Med_area;
GRAFT_AREA(7,:) = Graft_area;

load data8
SMC_MEDIA(8,:) = SMCmedia;
ECM_MEDIA(8,:) = ECMmedia;
MED_AREA(8,:) = Med_area;
GRAFT_AREA(8,:) = Graft_area;

load data9
SMC_MEDIA(9,:) = SMCmedia;
ECM_MEDIA(9,:) = ECMmedia;
MED_AREA(9,:) = Med_area;
GRAFT_AREA(9,:) = Graft_area;

load data10
SMC_MEDIA(10,:) = SMCmedia;
ECM_MEDIA(10,:) = ECMmedia;
MED_AREA(10,:) = Med_area;
GRAFT_AREA(10,:) = Graft_area;

load data11
SMC_MEDIA(11,:) = SMCmedia;
ECM_MEDIA(11,:) = ECMmedia;
MED_AREA(11,:) = Med_area;
GRAFT_AREA(11,:) = Graft_area;

load data12
SMC_MEDIA(12,:) = SMCmedia;
ECM_MEDIA(12,:) = ECMmedia;
MED_AREA(12,:) = Med_area;
GRAFT_AREA(12,:) = Graft_area;

load data13
SMC_MEDIA(13,:) = SMCmedia;
ECM_MEDIA(13,:) = ECMmedia;
MED_AREA(13,:) = Med_area;
GRAFT_AREA(13,:) = Graft_area;

load data14
SMC_MEDIA(14,:) = SMCmedia;
ECM_MEDIA(14,:) = ECMmedia;
MED_AREA(14,:) = Med_area;
GRAFT_AREA(14,:) = Graft_area;

load data15
SMC_MEDIA(15,:) = SMCmedia;
ECM_MEDIA(15,:) = ECMmedia;
MED_AREA(15,:) = Med_area;
GRAFT_AREA(15,:) = Graft_area;

% Mean 
SMC_MEDIA_MEAN = mean(SMC_MEDIA,1);
ECM_MEDIA_MEAN = mean(ECM_MEDIA,1);
MED_AREA_MEAN = mean(MED_AREA,1);
GRAFT_AREA_MEAN = mean(GRAFT_AREA,1);


% Plots
figure(1) % SMC in medial layer
plot(TIME,SMC_MEDIA,'-','linewidth',1);
hold on
plot(TIME,SMC_MEDIA_MEAN,'k*-','linewidth',3);
xlabel('Time[months]')
ylabel('# SMC')
title('SMC in medial layer vs. Time')
legend('1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','mean',...
    'location','best');

figure(2) % ECM in medial layer
plot(TIME,ECM_MEDIA,'-','linewidth',1);
hold on
plot(TIME,ECM_MEDIA_MEAN,'k*-','linewidth',3);
xlabel('Time[months]')
ylabel('# ECM')
title('ECM in medial layer vs. Time')
legend('1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','mean',...
    'location','best');

figure(3) % Medial area
plot(TIME,MED_AREA,'-','linewidth',1);
hold on
plot(TIME,MED_AREA_MEAN,'k*-','linewidth',3);
xlabel('Time[months]')
ylabel('#SMC + #ECM')
title('Medial layer area vs. Time')
legend('1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','mean',...
    'location','best')

figure(4) % Graft area
plot(TIME,GRAFT_AREA,'-','linewidth',1);
hold on
plot(TIME,GRAFT_AREA_MEAN,'k*-','linewidth',3);
xlabel('Time[months]')
ylabel('#SMC + #ECM')
title('Graft layer area vs. Time')
legend('1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','mean',...
    'location','best')


figure(5) % All the mean trends
subplot(2,2,1)
plot(TIME,SMC_MEDIA_MEAN,'*-','linewidth',3)
xlabel('Time[months]')
ylabel('# SMC')
title('SMC in medial layer vs. Time')

subplot(2,2,2)
plot(TIME,ECM_MEDIA_MEAN,'*-','linewidth',3);
xlabel('Time[months]')
ylabel('# ECM')
title('ECM in medial layer vs. Time')

subplot(2,2,3)
plot(TIME,MED_AREA_MEAN,'*-','linewidth',3);
xlabel('Time[months]')
ylabel('#SMC + #ECM')
title('Medial layer area vs. Time')

subplot(2,2,4)
plot(TIME,GRAFT_AREA_MEAN,'*-','linewidth',3);
xlabel('Time[months]')
ylabel('#SMC + #ECM')
title('Graft layer area vs. Time')

% Competitive cellular events
SMC_MEDIA_MEAN_NORM = SMC_MEDIA_MEAN(5:end)./SMC_MEDIA_MEAN(5);
ECM_MEDIA_MEAN_NORM = ECM_MEDIA_MEAN(5:end)./ECM_MEDIA_MEAN(5);
TIME2=(0:0.5:6);

figure(6)
plot(TIME2,SMC_MEDIA_MEAN_NORM,'r*-','linewidth',3);
hold on
plot(TIME2,ECM_MEDIA_MEAN_NORM,'b*-','linewidth',3);

xlabel('Follow up Time [months]')
ylabel('#cells (normalized)')
title('SMC mitosis vs. ECM degradation in medial layer')
legend('SMC mitosis','ECM degradation','location','best');









