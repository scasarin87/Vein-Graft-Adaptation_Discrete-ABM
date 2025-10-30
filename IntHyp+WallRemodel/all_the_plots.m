% All_the_plots

figure(2)
% a) SMC In Medial Layer
subplot(3,2,1)
plot(Time,SMCintima,'r*-','linewidth',3);
xlabel('Time [days]');
ylabel('#SMC []');
title('SMC in Intimal Layer vs. Time');

% b) Graft Radius
subplot(3,2,2)
plot(Time,SMCmedia,'b*-','linewidth',3);
xlabel('Time [days]');
ylabel('#SMC []');
title('SMC in Medial Layer vs. Time');


% a) Graft Area
subplot(3,2,3)
plot(Time,Graft_AREA,'g*-','linewidth',3);
xlabel('Time [days]');
ylabel('Graft Area [#smc+#ecm]');
title('Graft Area vs. Time');

% b) Lumen Area
subplot(3,2,4)
plot(Time,Lum_area,'r*-','linewidth',3);
xlabel('Time [days]');
ylabel('Lumen Area [#smc+#ecm]');
title('Lumen Area vs. Time');

% c) Intimal Area
subplot(3,2,5)
plot(Time,Int_area,'m*-','linewidth',3);
xlabel('Time [days]');
ylabel('Intimal Area [#smc+#ecm]');
title('Intimal Area vs. Time');

% d) Medial Area
wall = Graft_AREA-Lum_area; % wall thickness
Med_area = wall-Int_area; % medial thickness

subplot(3,2,6) 
plot(Time,Med_area,'c*-','linewidth',3);
xlabel('Time [days]');
ylabel('Medial Area [#smc+#ecm]');
title('Medial Area vs. Time');

