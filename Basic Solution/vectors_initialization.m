% vectors initialization

ind1 = 1;

% Time vector --> one record per month
Time(ind1) = 0;

% SMC/ECM in intimal medial layer
SMCintima(ind1) = number_SMC_intima;
ind1 = ind1+1;

ind2 = 1;
SMCmedia(ind2) = number_SMC_media;
ind2=ind2+1;

ind3 = 1;
ECMintima(ind3) = number_ECM_intima;
ind3=ind3+1;

ind4 = 1;
ECMmedia(ind4) = number_ECM_media;
ind4=ind4+1;

theta2 = (number_SMC_intima+number_SMC_media)/(number_ECM_intima+number_ECM_media);