% All_the_plots
figure(2)

% a) SMC In Intimal Layer
subplot(2,2,1)
plot(Time,SMCintima,'ro-','linewidth',3);
xlabel('Time [days]');
ylabel('#SMC []');
title('SMC in Intimal Layer vs. Time');

% b) Lumen Radius
subplot(2,2,2)
plot(Time,Lum_area,'mo-','linewidth',3);
xlabel('Time [days]');
ylabel('Lumen area [#cells]');
title('Lumen area vs. Time');

% c) SMC Media
subplot(2,2,3)
plot(Time,Int_area,'bo-','linewidth',3);
xlabel('Time [days]');
ylabel('Intimal Area [#cells]');
title('Intimal Area vs. Time');

% d) ECM Media
subplot(2,2,4)
plot(Time,Wall_area,'co-','linewidth',3);
xlabel('Time [days]');
ylabel('Wall Area [#cells]');
title('Wall area vs. Time');

