% analytical_model_of_meca

% Modelization of the generic blood vessel's (~thick cylinder)

d_cell=0.01; % physical dimension of cells

Area=sum(sum(lumen_hole)); % area of the lumen hole
r1=sqrt(Area/pi)*d_cell; % internal radius

Area=Nx*Ny-sum(sum(external_support)); % external area of the graft
r2=sqrt(Area/pi)*d_cell; % external radius

Number_of_cell=(r2-r1)/d_cell; % nummber of cell present in the graft wall

% Pressures
p1=P_internal; p2=P_external; % should be invariant in fact

% constant for the stress distribution in the wall
cA=p1*r1^2/(r2^2-r1^2);
cB=p2*r2^2/(r2^2-r1^2);
% constant for the displacement assuming no dilatation in longitudinal direction:
C1=(cA-cB)/(lambda+mu);
C2=(p1-p2)/(r2^2-r1^2)*r1^2*r2^2/(2*mu);

clear tau sigma_r sigma_a Tension

% Shear stress distribution assumed to be uniform as the cylinder
for j=1:Number_of_cell,
    r(j)=r1+(j-1)/(Number_of_cell); % unloaded position
    sigma_r(j)=abs(cA*(1-r2^2/r(j)^2)-cB*(1-r1^2/r(j)^2));
    sigma_a(j)=cA*(1+r2^2/r(j)^2)-cB*(1+r1^2/r(j)^2);
    Tension(j)=sqrt(sigma_r(j)^2+sigma_a(j)^2);
    u(j)=C1/2*r(j)+C2/r(j); % displacement;
end
clear p1 p2 C1 C2 Tension

% Average stress calculation to be used in smc migration rules
sigma_r_avg=mean(sigma_r); 

% Shear stress at the wall (supposed as uniform)
tau_wall=2*nu*U_max/(r1+u(1));

% Initial shear stress/tension --> affected by percentile dumping parameter
if hour == 0,
    tau_wall0 = tau_wall + tau_wall*epsilon;
    sigma_r_t=sigma_r_avg-sigma_r_avg*xsi;
end
  
