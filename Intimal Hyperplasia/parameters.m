%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              parameters                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Vector alpha

% ------------------------------------------------------------- %
% Basic solution parameters

% 1) Baseline for SMC division/apoptosis and ECM production/degradation
A(1) = 0.05; % Pdivision = A(1) > 0
A(2) = 0.008; % Pproduction = A(2) > 0

% 2) Macrophage activity --> A(t) = exp((hour-A(3))^2/A(4))
A(3) = 24*14;
A(4) = 24*60;

% ------------------------------------------------------------- %
% Perturbation of the system

% 3) Morphological changes are driven by local forces. Deviation from the
% baseline drives the biological response.


% 4) Production of grow factors post harbest and implantation leads to
% activation of quiescent SMCs

% ... in intimal layer
% Pdivision = A(1)*A(t)*[1+A(6)*DeltaTau(y)/TAU]/[1+A(7)*DeltaTau_wall/TAU]
A(6) = 0;
A(7) = 0;
% ... where DeltaTau(y) = DeltaTau_wall * exp{-(y-Rlumen)/A(8)*dSMC}
A(8) = 20; % rate of decay of shear stress effect inside the wall

% ... in medial layer (no effect of shear stress)
% Pdivision = A(1)*A(t)


% 5) Grow factors  promote SMCs migration through their concentration
% gradient --> SMC motility from media to intima crossing the IEL

% Pthrough = A(5)*A(t)*[1+A(13)DeltaTau(y)/TAU]*[1+A(14)DeltaSigma(y)/SIGMA]
A(5) = 0;
A(12) = 0;
A(14) = 0;


% 6) Surgey injury induces cells apoptosis, promoted by tension

% ... in medial layer
% Papoptosis = A(1)A(t)*[(1+A(9)*DeltaSigma(y))/SIGMA]
A(9) = 0;

% ... in intimal layer
% Papoptosis = A(1)A(t) indipendent from shear stress


% 7) ECM production/degradation is respectively regulated in intima and
% media by shear and tensile forces

% ... in intimal layer
% Pproduction = A(2)A(t) and Pdegradation = A(2)A(t)*[(1+A(10)*DeltaTau(y))/TAU]
A(10) = 0;

% ... in medial layer
% Pproduction = A(2)A(t) and Pdegradation = A(2)A(t)*[(1+A(11)*DeltaSigma(y))/SIGMA]
A(11) = 0;


A(15) = 0; % IEL update associated with shear stress



