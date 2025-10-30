% Postprocessing

clear variables
close all
clc

%% Initialize all matrices
number_of_run=15;
follow_up_points=9;

SMC_INTIMA = zeros(number_of_run,follow_up_points);
SMC_MEDIA = zeros(number_of_run,follow_up_points);

GRAFT_AREA = SMC_MEDIA;
LUMEN_AREA = SMC_MEDIA;
INTIMAL_AREA = SMC_MEDIA;
MEDIA_AREA = SMC_MEDIA;

TIME=[0 1 2 3 4 5 6 7 8];

%% Fill the matrices run by run
load data1
SMC_INTIMA(1,:)=SMCintima;
SMC_MEDIA(1,:)=SMCmedia;

GRAFT_AREA(1,:)=Graft_AREA;
LUMEN_AREA(1,:)=Lum_area;
INTIMAL_AREA(1,:)=Int_area;
MEDIA_AREA(1,:)=Med_area;


load data2
SMC_INTIMA(2,:)=SMCintima;
SMC_MEDIA(2,:)=SMCmedia;

GRAFT_AREA(2,:)=Graft_AREA;
LUMEN_AREA(2,:)=Lum_area;
INTIMAL_AREA(2,:)=Int_area;
MEDIA_AREA(2,:)=Med_area;


load data3
SMC_INTIMA(3,:)=SMCintima;
SMC_MEDIA(3,:)=SMCmedia;

GRAFT_AREA(3,:)=Graft_AREA;
LUMEN_AREA(3,:)=Lum_area;
INTIMAL_AREA(3,:)=Int_area;
MEDIA_AREA(3,:)=Med_area;


load data4
SMC_INTIMA(4,:)=SMCintima;
SMC_MEDIA(4,:)=SMCmedia;

GRAFT_AREA(4,:)=Graft_AREA;
LUMEN_AREA(4,:)=Lum_area;
INTIMAL_AREA(4,:)=Int_area;
MEDIA_AREA(4,:)=Med_area;


load data5
SMC_INTIMA(5,:)=SMCintima;
SMC_MEDIA(5,:)=SMCmedia;

GRAFT_AREA(5,:)=Graft_AREA;
LUMEN_AREA(5,:)=Lum_area;
INTIMAL_AREA(5,:)=Int_area;
MEDIA_AREA(5,:)=Med_area;


load data6
SMC_INTIMA(6,:)=SMCintima;
SMC_MEDIA(6,:)=SMCmedia;

GRAFT_AREA(6,:)=Graft_AREA;
LUMEN_AREA(6,:)=Lum_area;
INTIMAL_AREA(6,:)=Int_area;
MEDIA_AREA(6,:)=Med_area;


load data7
SMC_INTIMA(7,:)=SMCintima;
SMC_MEDIA(7,:)=SMCmedia;

GRAFT_AREA(7,:)=Graft_AREA;
LUMEN_AREA(7,:)=Lum_area;
INTIMAL_AREA(7,:)=Int_area;
MEDIA_AREA(7,:)=Med_area;


load data8
SMC_INTIMA(8,:)=SMCintima;
SMC_MEDIA(8,:)=SMCmedia;

GRAFT_AREA(8,:)=Graft_AREA;
LUMEN_AREA(8,:)=Lum_area;
INTIMAL_AREA(8,:)=Int_area;
MEDIA_AREA(8,:)=Med_area;


load data9
SMC_INTIMA(9,:)=SMCintima;
SMC_MEDIA(9,:)=SMCmedia;

GRAFT_AREA(9,:)=Graft_AREA;
LUMEN_AREA(9,:)=Lum_area;
INTIMAL_AREA(9,:)=Int_area;
MEDIA_AREA(9,:)=Med_area;


load data10
SMC_INTIMA(10,:)=SMCintima;
SMC_MEDIA(10,:)=SMCmedia;

GRAFT_AREA(10,:)=Graft_AREA;
LUMEN_AREA(10,:)=Lum_area;
INTIMAL_AREA(10,:)=Int_area;
MEDIA_AREA(10,:)=Med_area;


load data11
SMC_INTIMA(11,:)=SMCintima;
SMC_MEDIA(11,:)=SMCmedia;

GRAFT_AREA(11,:)=Graft_AREA;
LUMEN_AREA(11,:)=Lum_area;
INTIMAL_AREA(11,:)=Int_area;
MEDIA_AREA(11,:)=Med_area;


load data12
SMC_INTIMA(12,:)=SMCintima;
SMC_MEDIA(12,:)=SMCmedia;

GRAFT_AREA(12,:)=Graft_AREA;
LUMEN_AREA(12,:)=Lum_area;
INTIMAL_AREA(12,:)=Int_area;
MEDIA_AREA(12,:)=Med_area;


load data13
SMC_INTIMA(13,:)=SMCintima;
SMC_MEDIA(13,:)=SMCmedia;

GRAFT_AREA(13,:)=Graft_AREA;
LUMEN_AREA(13,:)=Lum_area;
INTIMAL_AREA(13,:)=Int_area;
MEDIA_AREA(13,:)=Med_area;


load data14
SMC_INTIMA(14,:)=SMCintima;
SMC_MEDIA(14,:)=SMCmedia;

GRAFT_AREA(14,:)=Graft_AREA;
LUMEN_AREA(14,:)=Lum_area;
INTIMAL_AREA(14,:)=Int_area;
MEDIA_AREA(14,:)=Med_area;


load data15
SMC_INTIMA(15,:)=SMCintima;
SMC_MEDIA(15,:)=SMCmedia;

GRAFT_AREA(15,:)=Graft_AREA;
LUMEN_AREA(15,:)=Lum_area;
INTIMAL_AREA(15,:)=Int_area;
MEDIA_AREA(15,:)=Med_area;

% Mean trends
SMC_INTIMA_MEAN=mean(SMC_INTIMA,1);
SMC_MEDIA_MEAN=mean(SMC_MEDIA,1);

GRAFT_AREA_MEAN=mean(GRAFT_AREA,1);
LUMEN_AREA_MEAN=mean(LUMEN_AREA,1);
INTIMAL_AREA_MEAN=mean(INTIMAL_AREA,1);
MEDIAL_AREA_MEAN=mean(MEDIA_AREA,1);


%% Plot the trends of interest
figure(1) % #SMC in intimal layer
plot(TIME,SMC_INTIMA,'linewidth',1);
hold on; plot(TIME,SMC_INTIMA_MEAN,'k*-','linewidth',3); hold off

xlabel('Time[months]')
ylabel('#SMC')

title('#SMC in intimal layer vs. Time')
legend('1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','mean')

figure(2) % #SMC in medial layer
plot(TIME,SMC_MEDIA,'linewidth',1);
hold on; plot(TIME,SMC_MEDIA_MEAN,'k*-','linewidth',3); hold off

xlabel('Time[months]')
ylabel('#SMC')

title('#SMC in medial layer vs. Time')
legend('1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','mean')


figure(3) % Graft area
plot(TIME,GRAFT_AREA,'linewidth',1);
hold on; plot(TIME,GRAFT_AREA_MEAN,'k*-','linewidth',3); hold off

xlabel('Time[months]')
ylabel('#SMC+#ECM')

title('Graft Area vs. Time')
legend('1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','mean')

figure(4) % Lumen Area
plot(TIME,LUMEN_AREA,'linewidth',1);
hold on; plot(TIME,LUMEN_AREA_MEAN,'k*-','linewidth',3); hold off

xlabel('Time[months]')
ylabel('#SMC+#ECM')

title('Lumen Area vs. Time')
legend('1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','mean')



figure(5) % Intimal Area
plot(TIME,INTIMAL_AREA,'linewidth',1);
hold on; plot(TIME,INTIMAL_AREA_MEAN,'k*-','linewidth',3); hold off

xlabel('Time[months]')
ylabel('#SMC+#ECM')

title('Intimal Area vs. Time')
legend('1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','mean')

figure(6) % Medial Area
plot(TIME,MEDIA_AREA,'linewidth',1);
hold on; plot(TIME,MEDIAL_AREA_MEAN,'k*-','linewidth',3); hold off

xlabel('Time[months]')
ylabel('#SMC+#ECM')

title('Medial Area vs. Time')
legend('1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','mean')



% figure(7) % SMC intima vs. SMC media
% % a) SMC In Intimal layer
% subplot(1,2,1)
% plot(Time,SMC_INTIMA_MEAN./SMC_INTIMA_MEAN(1),'r*-','linewidth',3);
% xlabel('Time [days]');
% ylabel('#SMC []');
% title('SMC in Intimal Layer vs. Time');
% 
% % b) SMC in Medial Layer
% subplot(1,2,2)
% plot(Time,SMC_MEDIA_MEAN./SMC_MEDIA_MEAN(1),'b*-','linewidth',3);
% xlabel('Time [days]');
% ylabel('#SMC []');
% title('SMC in Medial Layer vs. Time');

figure(7) % SMCintima vs. SMCmedia
plot(Time,SMC_INTIMA_MEAN./SMC_INTIMA_MEAN(1),'r*-','linewidth',3);
hold on
plot(Time,SMC_MEDIA_MEAN./SMC_MEDIA_MEAN(1),'b*-','linewidth',3);
hold off
xlabel('time[days]')
ylabel('#SMC (normalized)')
title('SMC proliferation intima vs. media')
legend('Intima','Media')


%figure(8) % Lumen vs. Graft area
% % a) Lumen Area
% subplot(1,2,1)
% plot(Time,mean(LUMEN_AREA,1),'r*-','linewidth',3);
% xlabel('Time [days]');
% ylabel('Lumen Area [#smc+#ecm]');
% title('Lumen Area vs. Time');
% 
% % b) Graft Area
% subplot(1,2,2)
% plot(Time,mean(GRAFT_AREA,1),'b*-','linewidth',3);
% xlabel('Time [days]');
% ylabel('Graft Area [#smc+#ecm]');
% title('Graft Area vs. Time');

figure(8) % Lumen area vs. Graft area
plot(Time,LUMEN_AREA_MEAN./LUMEN_AREA_MEAN(1),'r*-','linewidth',3);
hold on
plot(Time,GRAFT_AREA_MEAN./GRAFT_AREA_MEAN(1),'b*-','linewidth',3);
hold off
xlabel('time[days]')
ylabel('#SMC + #ECM (normalized)')
title('Lumen area vs. Graft area')
legend('Lumen area','Graft area')


% figure(9) % Intimal vs. Medial area
% % a) Intimal Area
% subplot(1,2,1)
% plot(Time,mean(INTIMAL_AREA,1),'r*-','linewidth',3);
% xlabel('Time [days]');
% ylabel('Intimal Area [#smc+#ecm]');
% title('Intimal Area vs. Time');
% 
% % b) Medial Area
% wall = Graft_AREA-Lum_area; % wall thickness
% Med_area = wall-Int_area; % medial thickness
% 
% subplot(1,2,2) 
% plot(Time,mean(MEDIA_AREA,1),'b*-','linewidth',3);
% xlabel('Time [days]');
% ylabel('Medial Area [#smc+#ecm]');
% title('Medial Area vs. Time');

figure(9)
wall = Graft_AREA-Lum_area; % wall thickness
Med_area = wall-Int_area; % medial thickness

plot(Time,INTIMAL_AREA_MEAN./INTIMAL_AREA_MEAN(1),'r*-','linewidth',3);
hold on
plot(Time,MEDIAL_AREA_MEAN./MEDIAL_AREA_MEAN(1),'b*-','linewidth',3);
hold off
xlabel('time[days]')
ylabel('#SMC + #ECM (normalized)')
title('Intimal area vs. Medial area')
legend('Intimal area','Medial area')






