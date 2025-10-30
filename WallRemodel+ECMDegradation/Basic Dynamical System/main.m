clear variables
close all
clc

T=6*30; % follow up time
%T = 500;

% Target values
tau_objective=50; % reduce shear stress by xx per cent
sigma_objective=50; % reduce strain energy by xx per cent
du=0;

% Integration step
dt=0.1; 
maxT=round(T/dt);

% Vector a --> constant parameters driving cellular events
a=zeros(9,1); 

% Tune the leading parameters up
a(3)=-0.07; % Degradation of ECM
a(4)=0.05; % SMC mitosis in medial layer



% Call the dynamical system integration code
integration_ode

% % Thickness of the compartments
% figure(1)
% plot(T,hist(:,5)-hist(:,6),T,hist(:,5)-hist(:,7),T,hist(:,7)-hist(:,6),'linewidth',3)
% xlabel('time')
% legend('Wall Thickness','Media Thickness','Intima Thickness','Location','Best')
% title('Evolution of thickness')
% 
% % Radius of the compartments
% figure(2)
% plot(T,hist(:,5),T,hist(:,6),T,hist(:,7),'linewidth',3)
% xlabel('time')
% legend('Radius External','Radius Lumen','Radius IEL','Location','Best')
% title('Evolution of Radius')

% Just medial thickness
figure(1)

media_th = hist(:,5)-hist(:,7);
media_th0 = media_th(1);
media_th_norm = media_th./media_th0;

plot(T,media_th_norm,'k-','linewidth',3)

xlabel('Time [days]')
ylabel('Medial Thickness (normalized)')
title('Dynamical System')







