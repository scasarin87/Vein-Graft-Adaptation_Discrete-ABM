% Vector alpha

%% Basic Solution

% 1) Baseline for SMC division/apoptosis and ECM production/degradation
A(1) = 0.05; % Pdivision = A(1) > 0
A(2) = 0.008; % Pproduction = A(2) > 0

% 2) Macrophage activity --> A(t) = exp((hour-A(3))^2/A(4))
A(3) = 24*14;
A(4) = 24*60;

% 3) Shear stress decay
A(8) = 20;


%% Probability laws realted to cellular events

% 1) SMC mitosis
A(6) = 0; % mitosis in Intimal layer
A(9) = 0; % mitosis in Media layer

% 2) SMC motility
A(5) = 0; % macrophage activity modulation
A(13) = 0; % motility enhanced by shear stress
A(14) = 0; % motility enhanced by wall tension

% 3) ECM dynamic
A(10) = 0; % ECM degeneration in Intimal layer
A(11) = 0; % ECM degeneration in Medial layer