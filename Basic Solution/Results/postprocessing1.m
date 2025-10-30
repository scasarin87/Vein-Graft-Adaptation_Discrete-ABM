% postprocessing1

clear variables
close all
clc

% Initialize the matrices
number_of_runs = 15;
number_of_time_points = 3;

SMC = zeros(number_of_runs,number_of_time_points);
ECM = zeros(number_of_runs,number_of_time_points);


TIME = (0:1:2);

% Load the ABM results and fill the matrices up

load data1
SMC(1,:) = SMCintima+SMCmedia;
ECM(1,:) = ECMintima+ECMmedia;

load data2
SMC(2,:) = SMCintima+SMCmedia;
ECM(2,:) = ECMintima+ECMmedia;

load data3
SMC(3,:) = SMCintima+SMCmedia;
ECM(3,:) = ECMintima+ECMmedia;

load data4
SMC(4,:) = SMCintima+SMCmedia;
ECM(4,:) = ECMintima+ECMmedia;

load data5
SMC(5,:) = SMCintima+SMCmedia;
ECM(5,:) = ECMintima+ECMmedia;

load data6
SMC(6,:) = SMCintima+SMCmedia;
ECM(6,:) = ECMintima+ECMmedia;

load data7
SMC(7,:) = SMCintima+SMCmedia;
ECM(7,:) = ECMintima+ECMmedia;

load data8
SMC(8,:) = SMCintima+SMCmedia;
ECM(8,:) = ECMintima+ECMmedia;

load data9
SMC(9,:) = SMCintima+SMCmedia;
ECM(9,:) = ECMintima+ECMmedia;

load data10
SMC(10,:) = SMCintima+SMCmedia;
ECM(10,:) = ECMintima+ECMmedia;

load data11
SMC(11,:) = SMCintima+SMCmedia;
ECM(11,:) = ECMintima+ECMmedia;

load data12
SMC(12,:) = SMCintima+SMCmedia;
ECM(12,:) = ECMintima+ECMmedia;

load data13
SMC(13,:) = SMCintima+SMCmedia;
ECM(13,:) = ECMintima+ECMmedia;

load data14
SMC(14,:) = SMCintima+SMCmedia;
ECM(14,:) = ECMintima+ECMmedia;

load data15
SMC(15,:) = SMCintima+SMCmedia;
ECM(15,:) = ECMintima+ECMmedia;


% Mean trends
SMC_MEAN = mean(SMC,1);
ECM_MEAN = mean(ECM,1);

%% Plots

% SMC vs. Time
figure(1)
plot(Time,SMC,'linewidth',1);
hold on
plot(Time,SMC_MEAN,'ko-','linewidth',3);
xlabel('Time [months]')
ylabel('Number of SMC')
legend('Run1','Run2','Run3','Run4','Run5','Run6','Run7','Run8','Run9','Run10',...
    'Run11','Run12','Run13','Run14','Run15','Mean')

% ECM vs. Time
figure(2)
plot(Time,ECM,'linewidth',1);
hold on
plot(Time,ECM_MEAN,'ko-','linewidth',3)
xlabel('Time [months]')
ylabel('Number of ECM')
legend('Run1','Run2','Run3','Run4','Run5','Run6','Run7','Run8','Run9','Run10',...
    'Run11','Run12','Run13','Run14','Run15','Mean')




