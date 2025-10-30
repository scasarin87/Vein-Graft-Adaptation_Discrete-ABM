% All_the_plots

figure(2)
% a) SMC In Medial Layer
subplot(2,2,1)
plot(Time,SMCmedia,'ro-','linewidth',3);
xlabel('Time [days]');
ylabel('#SMC []');
title('SMC in Medial Layer vs. Time');

% b) Graft Radius
subplot(2,2,2)
plot(Time,Graft_AREA,'mo-','linewidth',3);
xlabel('Time [days]');
ylabel('Graft area [#cells]');
title('Graft area vs. Time');

% c) Medial Area
subplot(2,2,3)
plot(Time,Med_area,'bo-','linewidth',3);
xlabel('Time [days]');
ylabel('Medial Area [#smc+#ecm]');
title('Medial Area vs. Time');

% d) Wall Area
subplot(2,2,4)
plot(Time,Wall_area,'co-','linewidth',3);
xlabel('Time [days]');
ylabel('Wall Area [#smc+#ecm]');
title('Wall area vs. Time');