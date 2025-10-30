% All_the_plots
figure(3)

% a) SMC In Intimal Layer
subplot(2,2,1)
plot(Time,SMCintima,'ro-','linewidth',3);
xlabel('Time [days]');
ylabel('#SMC []');
title('SMC in Intimal Layer vs. Time');

% a) SMC In Medial Layer
subplot(2,2,2)
plot(Time,SMCmedia,'bo-','linewidth',3);
xlabel('Time [days]');
ylabel('#SMC []');
title('SMC in Medial Layer vs. Time');

% c) Intimal Area
subplot(2,2,3)
plot(Time,Int_area,'ro--','linewidth',3);
xlabel('Time [days]');
ylabel('Intimal Area [#smc+#ecm]');
title('Intimal Area vs. Time');

% c) Medial Area
subplot(2,2,4)
plot(Time,Med_area,'bo--','linewidth',3);
xlabel('Time [days]');
ylabel('Medial Area [#smc+#ecm]');
title('Medial Area vs. Time');

