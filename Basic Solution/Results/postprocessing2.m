% postprocessing1

clear variables
close all
clc

% Initialize the matrices
number_of_runs = 15;
number_of_time_points = 3;

% SMC = zeros(number_of_runs,number_of_time_points);
% ECM = zeros(number_of_runs,number_of_time_points);


TIME = (0:1:2);

% Load the ABM results and fill the matrices up

for aa=1:15
    
    filename = ['data',num2str(aa)];
    load(filename);
    
    SMCi(aa,:) = SMCintima;
    ECMi(aa,:) = ECMintima;
    
    SMCm(aa,:) = SMCmedia;
    ECMm(aa,:) = ECMmedia;
    
end
clear ii



% Mean trends
SMCi_MEAN = mean(SMCi,1); SMCm_MEAN = mean(SMCm,1);
ECMi_MEAN = mean(ECMi,1); ECMm_MEAN = mean(ECMm,1);

%% Plots

% SMC vs. Time
subplot(2,2,1)
plot(Time,SMCi_MEAN,'ko-','linewidth',3);
xlabel('Time [months]')
ylabel('Number of SMC')

subplot(2,2,2)
plot(Time,ECMi_MEAN,'ko-','linewidth',3);
xlabel('Time [months]')
ylabel('Number of ECM')

subplot(2,2,3)
plot(Time,SMCm_MEAN,'ko-','linewidth',3);
xlabel('Time [months]')
ylabel('Number of SMC')

subplot(2,2,4)
plot(Time,ECMm_MEAN,'ko-','linewidth',3);
xlabel('Time [months]')
ylabel('Number of ECM')

figure(2)
plot(Time,SMCm_MEAN+ECMm_MEAN)






