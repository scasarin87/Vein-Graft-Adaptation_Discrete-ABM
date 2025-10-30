% postprocessing1

clear variables
close all
clc

% Initialize the matrices
number_of_runs = 15;
number_of_time_points = 9;

%SMC_INTIMA = zeros(number_of_runs,number_of_time_points);
INT_AREA = zeros(number_of_runs,number_of_time_points);
LUM_AREA = zeros(number_of_runs,number_of_time_points);
WALL_AREA = zeros(number_of_runs,number_of_time_points);

TIME = (0:1:6);

% Load the ABM results and fill the matrices up
load data1
%SMC_INTIMA(1,:) = SMCintima;
INT_AREA(1,:) = Int_area;
LUM_AREA(1,:) = Lum_area;
WALL_AREA(1,:) = Wall_area;
MED_AREA(1,:) = Wall_area - Int_area;

load data2
%SMC_INTIMA(2,:) = SMCintima;
INT_AREA(2,:) = Int_area;
LUM_AREA(2,:) = Lum_area;
WALL_AREA(2,:) = Wall_area;
MED_AREA(2,:) = Wall_area - Int_area;

load data3
%SMC_INTIMA(3,:) = SMCintima;
INT_AREA(3,:) = Int_area;
LUM_AREA(3,:) = Lum_area;
WALL_AREA(3,:) = Wall_area;
MED_AREA(3,:) = Wall_area - Int_area;

load data4
%SMC_INTIMA(4,:) = SMCintima;
INT_AREA(4,:) = Int_area;
LUM_AREA(4,:) = Lum_area;
WALL_AREA(4,:) = Wall_area;
MED_AREA(4,:) = Wall_area - Int_area;

load data5
%SMC_INTIMA(5,:) = SMCintima;
INT_AREA(5,:) = Int_area;
LUM_AREA(5,:) = Lum_area;
WALL_AREA(5,:) = Wall_area;
MED_AREA(5,:) = Wall_area - Int_area;

load data6
%SMC_INTIMA(6,:) = SMCintima;
INT_AREA(6,:) = Int_area;
LUM_AREA(6,:) = Lum_area;
WALL_AREA(6,:) = Wall_area;
MED_AREA(6,:) = Wall_area - Int_area;

load data7
%SMC_INTIMA(7,:) = SMCintima;
INT_AREA(7,:) = Int_area;
LUM_AREA(7,:) = Lum_area;
WALL_AREA(7,:) = Wall_area;
MED_AREA(7,:) = Wall_area - Int_area;

load data8
%SMC_INTIMA(8,:) = SMCintima;
INT_AREA(8,:) = Int_area;
LUM_AREA(8,:) = Lum_area;
WALL_AREA(8,:) = Wall_area;
MED_AREA(8,:) = Wall_area - Int_area;

load data9
%SMC_INTIMA(9,:) = SMCintima;
INT_AREA(9,:) = Int_area;
LUM_AREA(9,:) = Lum_area;
WALL_AREA(9,:) = Wall_area;
MED_AREA(9,:) = Wall_area - Int_area;

load data10
%SMC_INTIMA(10,:) = SMCintima;
INT_AREA(10,:) = Int_area;
LUM_AREA(10,:) = Lum_area;
WALL_AREA(10,:) = Wall_area;
MED_AREA(10,:) = Wall_area - Int_area;

load data11
%SMC_INTIMA(11,:) = SMCintima;
INT_AREA(11,:) = Int_area;
LUM_AREA(11,:) = Lum_area;
WALL_AREA(11,:) = Wall_area;
MED_AREA(11,:) = Wall_area - Int_area;

load data12
%SMC_INTIMA(12,:) = SMCintima;
INT_AREA(12,:) = Int_area;
LUM_AREA(12,:) = Lum_area;
WALL_AREA(12,:) = Wall_area;
MED_AREA(12,:) = Wall_area - Int_area;

load data13
%SMC_INTIMA(13,:) = SMCintima;
INT_AREA(13,:) = Int_area;
LUM_AREA(13,:) = Lum_area;
WALL_AREA(13,:) = Wall_area;
MED_AREA(13,:) = Wall_area - Int_area;

load data14
%SMC_INTIMA(14,:) = SMCintima;
INT_AREA(14,:) = Int_area;
LUM_AREA(14,:) = Lum_area;
WALL_AREA(14,:) = Wall_area;
MED_AREA(14,:) = Wall_area - Int_area;

load data15
%SMC_INTIMA(15,:) = SMCintima;
INT_AREA(15,:) = Int_area;
LUM_AREA(15,:) = Lum_area;
WALL_AREA(15,:) = Wall_area;
MED_AREA(15,:) = Wall_area - Int_area;


%% Take only the follow up time
INT_AREA(:,1:2) = [];
LUM_AREA(:,1:2) = [];
WALL_AREA(:,1:2) = [];
MED_AREA(:,1:2) = [];

%% Normalize the trend to the initial value
for jj=1:size(INT_AREA,1)
    
    INT_AREA(jj,:) = INT_AREA(jj,:)./INT_AREA(jj,1);
    LUM_AREA(jj,:) = LUM_AREA(jj,:)./LUM_AREA(jj,1);
    WALL_AREA(jj,:) = WALL_AREA(jj,:)./WALL_AREA(jj,1);
    MED_AREA(jj,:) = MED_AREA(jj,:)./MED_AREA(jj,1);
    
end


%% Mean trends
INT_AREA_MEAN = mean(INT_AREA,1);
LUM_AREA_MEAN = mean(LUM_AREA,1);
WALL_AREA_MEAN = mean(WALL_AREA,1);
MED_AREA_MEAN = mean(MED_AREA,1);


%% Plots
figure(1)
plot(TIME,LUM_AREA,'-','linewidth',1);
hold on
plot(TIME,LUM_AREA_MEAN,'k*-','linewidth',3,'MarkerSize',6);

xlabel('Time [months]')
ylabel('Lumen area (normalized)')


figure(2)
plot(TIME,INT_AREA,'-','linewidth',1);
hold on
plot(TIME,INT_AREA_MEAN,'k*-','linewidth',3,'MarkerSize',6);

xlabel('Time [months]')
ylabel('Intimal area (normalized)')


figure(3)
plot(TIME,MED_AREA,'-','linewidth',1);
hold on
plot(TIME,MED_AREA_MEAN,'k*-','linewidth',3,'MarkerSize',6);

xlabel('Time [months]')
ylabel('Medial area (normalized)')












 
