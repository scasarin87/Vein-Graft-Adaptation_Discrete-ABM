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


% Reference random value for Pdivison and Papoptosis
test=rand(1);

% Wall diameter
local_diameter=distance_lumen+distance_external;
r_local=(r1+(r2-r1)*distance_lumen/local_diameter);

% Wall Tension (to be updated....)
sigma_r_local=abs(cA*(1-r2^2/r_local^2)-cB*(1-r1^2/r_local^2));

% Wall Shear Stress
Delta_tau_wall_local = tau_wall - tau_wall0; % ~ DeltaTauWall
Delta_tau_wall = Delta_tau_wall_local * exp(-distance_lumen/tau_depth); % ~DeltaTau(y)


% Papoptosis
if lamina(j,k)<=0, %inside the intima
    p_apoptosis=probability_SMC(1)*activity;
else
    p_apoptosis=probability_SMC(1)*activity;
end

% Pdivision
if lamina(j,k)<=0, %inside the intima
    p_division=probability_SMC(2)*activity*(1+A(6)*Delta_tau_wall);  
else % in the media
    p_division=probability_SMC(2)*activity*(1+A(9)*abs(sigma_r_local-sigma_r_t)/sigma_r_t);
end


% Stochasticity of the simulation
if test<p_apoptosis,
    change_cell(j0,k0)=-1;
else
    if (1-test)<p_division;
        change_cell(j0,k0)=1;
    end
end
