% SMC motility

% Probability of cell motility is driven both by shear stress and wall
% tension. First of all we need to determine Delta_tau and Delta_tension
j3=j;k3=k; % CA cell number that might evolved.

%% Graft Morphology

% distance from the site to the lumen:
distance_lumen=(Nx+Ny)^2;

% Minimize the distance to the lumen
for jk=1:Nlw,
    da=sqrt((X(j,k)-Xlw(jk))^2+(Y(j,k)-Ylw(jk))^2);
    if da<distance_lumen,
        jk0=jk; distance_lumen=da;
    end
    clear da;
end

% Minimize the distance to the external support
distance_external=Nx+Ny;
for jk=1:Nes,
    da=sqrt((X(j,k)-Xes(jk))^2+(Y(j,k)-Yes(jk))^2);
    if da<distance_external,
        jk0=jk; distance_external=da;
    end
    clear da;
end


%% Wall Tension

% Sigma_wall drives the motility
local_diameter=distance_lumen+distance_external;
r_local=(r1+(r2-r1)*distance_lumen/local_diameter);

% Wall Tension: kept negative to be able to saturate the delta_sigma
sigma_wall_r_local=cA*(1-r2^2/r_local^2)-cB*(1-r1^2/r_local^2);
sigma_wall_c_local=cA*(1+r2^2/r_local^2)-cB*(1+r1^2/r_local^2);
sigma_wall_local = sqrt(sigma_wall_c_local^2 + sigma_wall_r_local^2);
clear sigma_wall_r_local sigma_wall_c_local

sigma_norm_motility=4e1;
if sigma_wall_local <= sigma_wall0
    Delta_sigma_wall=abs(sigma_wall_local-sigma_wall0)/sigma_wall0*sigma_norm_motility;
else
    Delta_sigma_wall=0;
end


%% Shear Stress
tau_norm_motility=4^-1;
if tau_wall <= tau_wall0
    Delta_tau_wall_local = abs(tau_wall - tau_wall0)/(tau_wall0*tau_norm_motility); % ~ DeltaTauWall
else
    Delta_tau_wall_local = 0;
end
Delta_tau_wall = Delta_tau_wall_local * exp(-distance_lumen/tau_depth); % ~DeltaTau(y)


%% Probability of Motility
% nvide --> how many suitable sites for the switching have
% been found
nvide=sum(liste(:,1));

% test is the reference probability value
test=rand(1);
% This density of probability needs to be updated
probability_migration = A(5)*activity*(1+A(14)*Delta_sigma_wall)*(1+A(13)*Delta_tau_wall);

% Switch the SMC in media with an ECM in intima IF the
% probability of motility is higher than the reference
% value AND if you have found the suitable site!!!!
if test<probability_migration && nvide>0,
    
    % keep trach of the number of migration
    number_of_migration=number_of_migration+1;% Cell Motility
    
    % if there is more than one suitable site, pick one
    % randomly!!!!
    n3=ceil(rand(1)*nvide);
    n=newliste(n3);
    
    % (j3,k3) --> coordinates of the site suitable for the
    % SMCmedia/ECMintima switch
    j3=j+directionx(n,j_k);
    k3=k+directiony(n);
    
    % Operate the permute!!!!
    type_cell(j3,k3)=1; % an SMC has moved in intima
    type_cell(j,k)=2; % an ECM has moved in intima
    
    % Switch the internal clock too
    temporaire=internal_clock(j3,k3);
    internal_clock(j3,k3)=internal_clock(j,k);
    internal_clock(j,k)=temporaire;
    
end



