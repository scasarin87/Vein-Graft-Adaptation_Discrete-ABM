%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               main code              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Ring version of the vein graft CA response

clear variables
close all
clc

% Start the CPU timer
temps_initial = tic;

% Time conversion constants
months_days = 30;
days_hours = 24;

% Shear Stress/Tension percentile variation
epsilon = 0.5; % percentile variation of shear stress respect to shear(t=0)
xsi = 0.2; % percentile variation of tension respect to tension(t=0)

% Vector alpha parameters
parameters

% Grid dimension
Nx=121; Ny=Nx;

% Initialize the status of the system
hour = 0;
initialization

% Initialize the external support count
ext_count = sum(sum(external_support));

% Vector for Debugging
kbug=1; bug_report(kbug)=0;

% Initialize the stenosis checkpoint
severe_stenosis = 0;

% basic solution/follow up time
basic_sol = 2 * months_days*days_hours; % 2 months of basic sol generation
simulation_time = 6 * months_days*days_hours; % 8 months of follow up

% SMC/ECM vectors initialization
display('Initial pattern:');
follow_up; % run a first follow up and get the initial SMC/ECM distribution

% Initialize the vectors that store SMC/ECM in intima/media
vectors_initialization;

%% Main cycle
for hour = 1401:(basic_sol+simulation_time)
        
    % If basic solution has been generated, activate parameters leading the
    % cellular events
    if hour > basic_sol
        A(6) = 0.2;
    end
  
    % Access the cycle if and only if there is no severe stenosis occurring
    if severe_stenosis==0,
        
        % Macrophage activity (so far not considered)
        activity = 1; % Set macrophage activity to be 1
        
        % The internal clock for each site is updated at each step
        for j=1:Nx,
            for k=1:Ny,
                
                if type_cell(j,k)==1 
                    if internal_clock(j,k)<T_cell_division,
                        internal_clock(j,k)=internal_clock(j,k)+1;
                    else
                        internal_clock(j,k)=1;
                    end
                end
            
                if type_cell(j,k)==2,
                    % clock for ECM dynamic is updated negatively to
                    % distinguish it from SMC dynamic
                    internal_clock(j,k)=internal_clock(j,k)-1;
                end
                
            end
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%                         SMC Dynamic                           %%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        preprocessing % retrieve a smooth interfaces 
        %pause(0.01)
        
        %% 1) Get the local mechanical conditions:
        analytical_model_of_meca;
               
        %% 2) Define which sites have SMC dynamic activity
        
        % Scan randomly ALL the grid accessing all the sites one-by-one.
        % Here we have to define which cell has an activity or not, so we
        % need to go over ALL the sites
        nouvel_ordre=rand(Nx*Ny,1);
        [~, newK]=sort(nouvel_ordre); clear nouvel_ordre ordre
        
        % Matrix change_cell keeps track of which site has activity somehow
        change_cell=zeros(Nx,Ny);
        
        % Access every site of the grid
        for kcell=1:Nx*Ny,
            
            % coordinates of the current site (j,k)
            j=ceil(newK(kcell)/Nx);
            k=newK(kcell)-(j-1)*Nx;
            
            if type_cell(j,k) == 1, % the site contains an SMC
                if internal_clock(j,k) == T_cell_division, % and the cell is ready to divide
                    
                    SMC_division % site regulated from Pdivision
                    
                end
            end
        end   
        % Out of the cycle... matrix change_cell is updated such as: 
        % if (j,k) undergoes mitosis --> change_cell(j,k) = 1
        % if (j,k) undergoes apoptosis --> change_cell(j,k) = -1
        % if nothing happened --> change_cell(j,k) = 0
        clear tau_wall
        
        
        %% 3) Re organize the grid after SMC dynamic:
        
        % As general aim, the SMC in (j,k) that underwent mitosis, places
        % the daughter cell in (j,k) and flip into an empty neighbor (if
        % already exsisted).
        % If (j,k) doesn't have an empty neighbor, the grid will shift 
        % according to minimum path motion to make room.
        % Same story if (j,k) undergoes apoptosis. If it has an empty
        % neighbor, nothing happens, otherwise the gird shift of one
        % positon toward the hole left by SMC apoptosis in order not to
        % leave any hole in the graft
        
        % Total number of update to do.
        number_of_change = sum(sum(abs(change_cell))); 
        % <Xchange , Ychange> keeps track of exact position of the sites
        % that underwent some sort of change_cell ~= 0
        [Xchange, Ychange] = find(change_cell ~= 0);
            
        % Scan only the sites of grid that underwent some change!
        nouvel_ordre=rand(number_of_change,1);
        [~, newK]=sort(nouvel_ordre); clear nouvel_ordre ordre
        
        for kchange = 1:number_of_change,
            
            % (j,k) --> coordinate of the current site
            j = Xchange(newK(kchange));
            k = Ychange(newK(kchange));
            
            % here (j,k) must be coordinates of a site that has undergone
            % some sort of change_cell ~= 0
            
            % Place the new cell in the neighborood applying the minimum
            % path motion law to the current site
            SMC_minimum_path_motion;
            
        end % End of SMC dymanic
        clear Xchange Ychange
        
 
        % Check point 1) check if there are empty spots inside the graft
        for j=1:Nx,
            for k=1:Ny, % scan all the grid
                
                if type_cell(j,k)~=0, % if the site is occupied
                    if lumen_hole(j,k)+external_support(j,k)~=0,
                        % no lumen or ext support should be recorded
                        bug_report(kbug)=118; kbug=kbug+1; 
                    end
                else % if the site is empty
                    if lumen_hole(j,k)+external_support(j,k)==0,
                        % we should record at least lumen or ext support
                        bug_report(kbug)=122; kbug=kbug+1;
                    end
                end
                
            end
        end


        %% 4) Increase contact and regularize the interfaces post SMC dynamics
        flag = 1; % smc dynamic
        number_of_brownian = 3; 
        for ii=1:number_of_brownian,
            brownian_motion1; 
        end
        clear ii
        
        for ii=1:number_of_brownian,
            brownian_motion2;
        end
        clear ii flag
        
                
        % Check point 2) check if there are empty spots inside the graft
        for j=1:Nx,
            for k=1:Ny, % scan all the grid
                
                if type_cell(j,k)~=0, % if the site is occupied
                    if lumen_hole(j,k)+external_support(j,k)~=0,
                        % no lumen or ext support should be recorded
                        bug_report(kbug)=134; kbug=kbug+1; 
                    end
                else % if the site is empty
                    if lumen_hole(j,k)+external_support(j,k)==0,
                        % we should record at least lumen or ext support
                        bug_report(kbug)=138; kbug=kbug+1;
                    end
                end
                
            end
        end
        

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%                       ECM Dynamic                             %%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % This second part of code follows the same principles applied to
        % the SMC dynamic, but applying them to deposition/degradation of
        % ECM
        
        clear Xlw Ylw Nlw Xes Yes Nes External_wall Lumen_wall
        preprocessing % retrieve smooth interfaces to get the distance right.
        
        %% 1) Get the local mecanical condition:
        analytical_model_of_meca

        %% 2) Define which sites have ECM dynamic activity
        
        % Access randomly every site one-by-one. Again here we define which
        % sites has an ECM activity of some kind and which don't. We have
        % to go over all the sites!
        nouvel_ordre=rand(Nx*Ny,1);
        [~, newK]=sort(nouvel_ordre); clear nouvel_ordre ordre
        
        % Initialize change_matrix:
        % If (j,k) produces an ECM --> change_matrix(j,k) = 1
        % If (j,k) degradates an ECM --> change_matrix(j,k) = -1
        % Otherwise(no activity) --> change_matrix(j,k) = 0
        change_matrix=zeros(Nx,Ny);               

        % exhaust all the sites
        for kcell=1:Nx*Ny, 
            
            % coordinates of (j,k)
            j=ceil(newK(kcell)/Nx); 
            k=newK(kcell)-(j-1)*Nx; 
            
            % if (j,k) contains an SMC that can potentially generate an
            % ECM, OR if it contains an ECM that can be degradated...
            if type_cell(j,k)~=0, % process an SMC or ECM cell, 
                if mod(internal_clock(j,k),T_matrix_dynamic)==0, % and if the site is timely ready...

                    ECM_dynamic; % the site is regulated by ECM_dynamic
                    
                end
            end
        end
        
        %% 3) Reorganize the grid after ECM_dynamic
     
        % Scan the grid as many time as the number of ECM variations
        % recorded
        number_of_change=sum(sum(abs(change_matrix)));
        
        % <Xchange , Ychange> keeps track of exact position of the sites
        % that underwent some sort of change_matrix ~= 0
        [Xchange, Ychange] = find(change_matrix ~= 0);
        
        % Scan only the sites of grid that underwent some change! We don't
        % need to go over all the sites! We just consider the ones where
        % some ECM change happened
        nouvel_ordre=rand(number_of_change,1);
        [~, newK]=sort(nouvel_ordre); clear nouvel_ordre ordre
        
        for kchange=1:number_of_change,
            
            % (j,k) --> coordinates of the current site
            j = Xchange(newK(kchange));
            k = Ychange(newK(kchange));
            
            % Apply the minimum path motion law to site (j,k)
            ECM_minimum_path_motion;
            
        end
        
        
        % Check point 1) check if there are empty spots inside the graft
        for j=1:Nx,
            for k=1:Ny, % scan all the grid
                
                if type_cell(j,k)~=0, % if the site is occupied
                    if lumen_hole(j,k)+external_support(j,k)~=0,
                        % no lumen or ext support should be recorded
                        bug_report(kbug)=228; kbug=kbug+1; 
                    end
                else % if the site is empty
                    if lumen_hole(j,k)+external_support(j,k)==0,
                        % we should record at least lumen or ext support
                        bug_report(kbug)=232; kbug=kbug+1;
                    end
                end
                
            end
        end
        clear Xchange Ychange
        
        %% 4) Increase contact and regularize the interfaces post SMC dynamics
        flag = 2; % ecm dynamic
        for ii=1:number_of_brownian
            brownian_motion1;  
        end
        clear ii
        
        for ii=1:number_of_brownian
            brownian_motion2;
        end
        clear ii
        
        %Check point 2) check if there are empty spots inside the graft
        for j=1:Nx,
            for k=1:Ny, % scan all the grid
                
                if type_cell(j,k)~=0, % if the site is occupied
                    if lumen_hole(j,k)+external_support(j,k)~=0,
                        % no lumen or ext support should be recorded
                        bug_report(kbug)=228; kbug=kbug+1; 
                    end
                else % if the site is empty
                    if lumen_hole(j,k)+external_support(j,k)==0,
                        % we should record at least lumen or ext support
                        bug_report(kbug)=232; kbug=kbug+1;
                    end
                end
                
            end
        end
        
        % reset change_matrix
        clear change_cell change_matrix
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%                  Migration Media --> Intima                   %%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % NB: it is currently inactive due to A(5) = 0;    
        
        % Scan all the grid and access singularly all sites at once
        nouvel_ordre=rand(Nx*Ny,1);
        [ordre, newK]=sort(nouvel_ordre); clear nouvel_ordre ordre
        
        % Initialize a counter for the number of cells that has migrated
        % from media to intima
        %number_of_migration = 0;
        
        for kcell=1:Nx*Ny,
            
            % (j,k) --> coordinates of the current site (j,k)
            j=ceil(newK(kcell)/Nx); 
            k=newK(kcell)-(j-1)*Nx; 
            
            % (j,k) has to contain an SMC that may go through lamina.
            % Attention: the SMC has to be already ready to go thorugh.
            % This means that it has to stand on the lamina!!!
            if type_cell(j,k)==1 && lamina(j,k)==0,  
                
                if mod(k,2)==0,
                    j_k=2;
                else
                    j_k=1;
                 end
                
                % liste --> vector keeping score of (j,k) neighbors
                liste=zeros(6,1); clear newliste;
                n2=0;
                
                % look for ECM neighbor sites beyond the intima toward the
                % lumen radius. The aim of SMC motility will be to switch
                % position between the SMC in media and an ECM found in
                % intima
                for n=1:6, 
                    
                    % (j3,k3) --> coordinates of temporary (j,k) neighbor
                    j3=j+directionx(n,j_k); 
                    k3=k+directiony(n);
                    
                    % liste = 1 if (j3,k3) has an ECM and it is in intima
                    % liste = 0 if (j3,k3) has not ECM or is not in intima
                    if type_cell(j3,k3)==2 && lamina(j3,k3)<=0,
                        liste(n,1)=1; 
                        
                        % newliste keeps only the indexes of neighbors of
                        % (j,k) that are in the intima and that contain an
                        % ECM
                        n2=n2+1; 
                        newliste(n2)=n;
                    end
                end
                
                % nvide --> how many suitable sites for the switching have
                % been found
                nvide=sum(liste(:,1));
                
                % test is the reference probability value
                test=rand(1);
                % This density of probability needs to be updated
                probability_migration=A(5)*activity; % *(1+A(12)*tau(IEL))*(1+A(13)*sigma_r(IEL));
                
                % Switch the SMC in media with an ECM in intima IF the
                % probability of motility is higher than the reference
                % value AND if you have found the suitable site!!!!
                if test<probability_migration && nvide>0,
                    
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
                    
                    % keep trach of the number of migration
                    % number_of_migration=number_of_migration+1;
                end
            end
        end
        


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%                 Inward/Outward IEL Remodeling                 %%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        number_of_otward_remodeling = 0;
        for ii=1:number_of_otward_remodeling
            IEL_outward;
        end

        % Regularization of the lamina if it has evolved significantly
        nlamina = 0; % nlamina --> number of sites belonging to lamina
        radius_lamina = 0; % radius of the lamina
        
        % Scan all the grid ...
        for j=1:Nx,
            for k=1:Ny,
                if lamina(j,k)==0, % if (j,k) is on the updated lamina
                    nlamina=nlamina+1; % we have one more site on the lamina, so update the counter
                    % get the radius of the current lamina
                    radius_lamina=radius_lamina+sqrt((X(j,k)-Cx)^2+(Y(j,k)-Cy)^2);
                end
            end
        end
        
        % NEW RADIUS OF THE LAMINA
        newIEL_radius=radius_lamina/nlamina; 
        
        % Compare the old radius with the new radius...
        if abs(newIEL_radius-IEL_radius)>0.5, % if lamina evolved more than twice the previous thickness...
            
            IEL_radius=newIEL_radius; % update the new IEL radius
            
            % ... and update the state matrix of lamina...
            for j=1:Nx,
                for k=1:Ny,
                    distance=sqrt((X(j,k)-Cx)^2+(Y(j,k)-Cy)^2); 
                    if distance<IEL_radius,
                        lamina(j,k)=-1;
                    end
                    if distance>IEL_radius,
                        lamina(j,k)=1;
                    end
                    if round(distance-IEL_radius)==0,
                        lamina(j,k)=0;
                    end
                end
            end
        end
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%                    Stenosis check point                       %%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        hole_limit = 800;
        if sum(sum(lumen_hole)) < hole_limit,
            display('severe stenosis occurs');
            severe_stenosis = 1; % turn the stenosis flag to be 1. This will prevent the simulation to proceed further
        end
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%                          FOLLOW UP                            %%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        display('Current hour:')
        hour
        
        clear Xlw Ylw Nlw Xes Yes Nes External_wall Lumen_wall
        
        % Call the code that counts SMC/ECM in intima and media
        follow_up
        
        % Fill the vectors at each month sharp
        if (mod(hour,1*months_days*days_hours) == 0)
            
            % time vector in days
            Time(ind1) = Time(ind1-1)+30;
            
            % SMC/ECM in intima/media
            SMCintima(ind1) = number_SMC_intima;
            ind1 = ind1+1;
            
            Lum_area(ind2) = lumen_area;
            ind2 = ind2+1;
            
            Int_area(ind3) = intimal_area;
            ind3 = ind3+1;
            
            Wall_area(ind4) = wall_area;
            ind4 = ind4+1;
            
        end
            
        
  
    end % end of sever stenosis if statement     
    
end % end of the main cycle

% Stop the cpu timer
toc(temps_initial)

% Cross section of the graph
preprocessing;
figure(1)
plot(Xlw,Ylw,'r',Xes,Yes,'b');
graph

% Plot SMC/ECM in intima/media
all_the_plots

