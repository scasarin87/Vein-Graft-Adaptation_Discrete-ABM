% SMC_division

j0=j;k0=k; % CA cell number that might evolved.

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


% test for Pdiv and Papop
test=rand(1);

% Wall diameter
local_diameter=distance_lumen+distance_external;
r_local=(r1+(r2-r1)*distance_lumen/local_diameter);

% Wall Tension: kept negative to be able to saturate the delta_sigma
sigma_wall_r_local=cA*(1-r2^2/r_local^2)-cB*(1-r1^2/r_local^2);
sigma_wall_c_local=cA*(1+r2^2/r_local^2)-cB*(1+r1^2/r_local^2);
sigma_wall_local = sqrt(sigma_wall_c_local^2 + sigma_wall_r_local^2);
clear sigma_wall_r_local sigma_wall_c_local


sigma_norm=4e1;
if sigma_wall_local <= sigma_wall0
    Delta_sigma_wall=abs(sigma_wall_local-sigma_wall0)/sigma_wall0*sigma_norm;
else
    Delta_sigma_wall=0;
end
    

% Wall Shear Stress
tau_norm=4^-1;
if tau_wall <= tau_wall0
    Delta_tau_wall_local = abs(tau_wall - tau_wall0)/(tau_wall0*tau_norm); % ~ DeltaTauWall
else
    Delta_tau_wall_local = 0;
end
Delta_tau_wall = Delta_tau_wall_local * exp(-distance_lumen/tau_depth); % ~DeltaTau(y)


% Papoptosis
if lamina(j,k)<=0, %inside the intima
    p_apoptosis=probability_SMC(1)*activity;
else % inside media
    p_apoptosis=probability_SMC(1)*activity;
end

% Pdivision
if lamina(j,k)<=0, %inside the intima
    p_division=probability_SMC(2)*activity*(1+A(6)*Delta_tau_wall); 
else % in the media
    p_division=probability_SMC(2)*activity*(1+A(9)*Delta_sigma_wall);
end


% Stochasticity of the simulation
if test<p_apoptosis,
    change_cell(j0,k0)=-1;
else
    if (1-test)<p_division;
        change_cell(j0,k0)=1;
    end
end
