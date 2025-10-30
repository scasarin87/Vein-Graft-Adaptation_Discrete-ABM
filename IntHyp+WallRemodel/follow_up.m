% follow up: track variables fo interest

%% 1) Graft area
graft_area = Area_graft;

%% 2) SMC/ECM in intimal/medial layer
number_SMC_intima=0; number_ECM_intima=0;
number_SMC_media=0;  number_ECM_media=0;


for j=1:Nx,
    for k=1:Ny,
        
        % Get the position of the current site
        distance=sqrt((X(j,k)-Cx)^2+(Y(j,k)-Cy)^2);
        
        if(distance <= IEL_radius) % if site is in the intima...
            
            if type_cell(j,k)==1, % ... and the site contains an SMC
                number_SMC_intima=number_SMC_intima+1;
            end
            
            if type_cell(j,k)==2, % ... else if the site contains an ECM
                number_ECM_intima=number_ECM_intima+1;
            end
            
        else % ... otherwise, if the site is beyond the IEL
            
            if type_cell(j,k)==1, % and if the site contains an SMC
                number_SMC_media=number_SMC_media+1;
            end
            
            if type_cell(j,k)==2, % or if the site contains an ECM
                number_ECM_media=number_ECM_media+1;
            end
        end        
        
    end
end

%% 3) Medial area [#smc+#ecm]
medial_area = number_SMC_media+number_ECM_media;

%% 4) Wall area [#smc+#ecm]
intimal_area = number_SMC_intima+number_ECM_intima;
wall_area = intimal_area+medial_area;

%% Display variables
% Display the variables
number_SMC_media
graft_area
medial_area
wall_area


