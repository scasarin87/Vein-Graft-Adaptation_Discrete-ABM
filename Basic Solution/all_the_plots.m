% All_the_plots

figure(3)
% 2) Show the trend for SMC/ECM in intimal/medial layers

% a) SMC Intima
subplot(2,2,1)
plot(Time,SMCintima,'ro-','linewidth',3);
xlabel('Time [days]');
ylabel('#SMC []');
title('SMC in Intimal layer');

% b) ECM Intima
subplot(2,2,2)
plot(Time,ECMintima,'mo-','linewidth',3);
xlabel('Time [days]');
ylabel('#ECM []');
title('ECM in Intimal layer');

% c) SMC Media
subplot(2,2,3)
plot(Time,SMCmedia,'bo-','linewidth',3);
xlabel('Time [days]');
ylabel('#SMC []');
title('SMC in Medial layer');

% d) ECM Media
subplot(2,2,4)
plot(Time,ECMmedia,'co-','linewidth',3);
xlabel('Time [days]');
ylabel('#ECM []');
title('ECM in Medial layer');

figure(4)
subplot(1,2,1)
plot(Time,SMCintima+SMCmedia,'linewidth',2)
title('SMC')

subplot(1,2,2)
plot(Time,ECMintima+ECMmedia);
title('ECM')

% figure(3)
% % 3) Show the lumen radius trend
% plot(Time,Lumen_radius,'o-','linewidth',3)
% xlabel('Time [days]');
% ylabel('Lumen radius')
% title('Lumen radius VS time')
% 
% figure(4)
% % 4) Show the wall thickness trend
% plot(Time,Wall_thickness,'o-','linewidth',3)
% xlabel('Time [days]');
% ylabel('Wall Thickness')
% title('Wall Thickness VS time')
% 
% figure(5)
% % 5) Show the shear stress trend
% plot(Time,Shear_Stress,'o-','linewidth',3)
% xlabel('Time [days]');
% ylabel('Shear Stress')
% title('Shear Stress VS time')