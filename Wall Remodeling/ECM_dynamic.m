% ECM_dynamic:

% Starting status of change_matrix(j,k) is 0
change_matrix(j,k)=0;

% (j0,k0) --> coordinates of the current site that might evolve
j0=j;k0=k; 

% Minimize the distance between site (j,k) and lumen
distance_lumen=Nx+Ny;
for jk=1:Nlw,
    da=sqrt((X(j,k)-Xlw(jk))^2+(Y(j,k)-Ylw(jk))^2);
    if da<distance_lumen,
        
       % jk0 --> index of the closest point on the lumen to (j,k)
       % distance_lumen --> minimized distance
       jk0=jk; distance_lumen=da; 
    end
    clear da;
end

% Minimize the distance between site (j,k) and external support
distance_external=Nx+Ny;
for jk=1:Nes,
    da=sqrt((X(j,k)-Xes(jk))^2+(Y(j,k)-Yes(jk))^2);
    if da<distance_external,
       
       % jk0 --> index of the closest point on the exteranl support to (j,k)
       % distance_external --> minimized distance 
       jk0=jk; distance_external=da; 
    end
    clear da;
end
 

% probability_ECM computed as function of shear and tension
local_diameter=distance_lumen+distance_external;
r_local=(r1+(r2-r1)*distance_lumen/local_diameter);

%% THIS TWO MUST BE UPDATED WHEN WE WILL USE PARAMETER ALPHA(9)
sigma_r_local=abs(cA*(1-r2^2/r_local^2)-cB*(1-r1^2/r_local^2));
tau_local=tau_wall*exp(-distance_lumen/tau_depth);

% Probability laws
p_deposition=probability_SMC_ECM*activity;
if lamina(j,k)<=0, %inside the intima 
    p_degeneration=probability_ECM*activity*(1+A(10)*tau_local);
else
     p_degeneration=probability_ECM*activity*(1+A(11)*sigma_r_local);
end

% if (j,k) contains an SMC, the cell may produce an ECM
if type_cell(j,k)==1, 
    
    % Generate a random comparison number. It will be needed to endure the
    % stochasticity of the simulation
    test=rand(1);
    
    % If probability of depositon is bigger than reference random number,
    % so the cell deposites an ECM
    if test<p_deposition,
        change_matrix(j,k)=1; % update change_matrix indeed
    end
end

% if (j,k) contains an ECM, what might happen is that ECM is
% degradated from an SMC between the neighbors of ECM in (j,k)
if type_cell(j,k)==2, 
    
    % We look around (j,k) for a neighbor that contains an SMC
    if mod(k,2)==0, 
        j_k=2;
    else
        j_k=1;
    end
    
    % liste --> virtually contains the list of neighbors of (j,k)
    % if (j3,k3) has an SMC --> liste(j3,k3) = 1
    % if (j3,k3) has NOT an SMC --> liste(j3,k3) = 0
    liste=zeros(6,1);
    for n=1:6,
        
        % (j3,k3) --> coordinates of the current neighbor
        j3=j+directionx(n,j_k); 
        k3=k+directiony(n);
        
        % if the neighbor is an SMC, place 1 in liste
        if type_cell(j3,k3)==1,
            liste(n)=1;
        end
    end

    % nSMC --> how many SMC are neighbor of (j,k) that contains an ECM?
    nSMC=sum(liste);
    
    if nSMC<5, % limit on the degradation of ECM to keep buffer between cells!
        for k5=1:nSMC, % the more SMC in the neighbor, the more chanche to degenerate.
            
            % random value generated as done for production before
            test=rand(1);
            
            % if probability of degeneration is higher than the reference
            % number number AND if we are not trying to degradate the IEL,
            if test<p_degeneration && lamina(j,k)~=0,
                
                change_matrix(j,k)=-1; % ECM in (j,k) is degradated
                break % once you found one SMC that degradates the ECM, you can exit the for loop
                
            end
        end
    end
        
end

