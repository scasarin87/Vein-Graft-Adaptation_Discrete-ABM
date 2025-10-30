% SMC_minimum_path_motion
clear chemin dist6

% level of noise added to the distance function used to compute the shortest path
bruit=0.1;

% IF the current site had recorded an activity, access the function
if change_cell(j,k)~=0 && type_cell(j,k)==1,
    
    % Checkpoint: (j,k) cannot be part of lumen or external support
    if lamina(j,k)<=0,
        if lumen_hole(j,k)~=0,
            display('bug in SMC_minimum_path line 13: piece of lumen recorded where not supposed to'); pause;
        end
    else
        if external_support(j,k)~=0,
            display('bug in SMC_minimum_path line 17: piece of ext support recorded where not supposed to'); pause;
        end
    end
    % Take care of those cells that have at least one empty neighbors
    SMC_more_empties;
    
    % We need to know which layer the cell belongs to. To do it, we
    % calculate the distance from the lumen of the current site
    
    %% IF there are no empty spaces close to (j,k)...
    if cell_at_wall==0,
        
        % if SMC undergoes mitosis, it places the new cell in one neighbor
        % and shifts all the grid toward lumen or external support
        % according to minimum path motion. If it goes to apoptosis, the
        % graft collapse of one site toward the cell
        
        % INSIDE INTIMA, we go toward the lumen
        distance_lumen = Nx+Ny;
        if lamina(j,k)<=0,
            for jk=1:Nlw, % explore every point of lumen border (Nlw points)
                
                % get the distance between (j,k) and the lumen border
                da=sqrt((X(j,k)-Xlw(jk))^2+(Y(j,k)-Ylw(jk))^2);
                if da<distance_lumen,
                    
                    % Minimize the distance between (j,k) and the lumen
                    % border. jk0 is the index of the closest point on the
                    % lumen border and distance_lumen is the minimized
                    % distance
                    jk0=jk; distance_lumen=da;
                end
                clear da;
            end
            
            % matrix da --> contains the distance between every single
            % point belonging to the lumen and the point jk0 on the lumen
            % border. It is not considered outside the lumen obviously
            for j1=1:Nx,
                for k1=1:Ny,
                    if lumen_hole(j1,k1)==1,
                        da(j1,k1)=sqrt((Xlw(jk0)-X(j1,k1))^2+(Ylw(jk0)-Y(j1,k1))^2);
                    else
                        da(j1,k1)=Nx*Ny;
                    end
                end
            end
            
            
            % between all the sites in the lumen, I only want the one
            % closest to the point jk0 individuated before. Need to
            % minimize the matrix accounting for all the distances from
            % inside lumen and point jk0
            distance_lumen=min(min(da));
            for j1=1:Nx,
                for k1=1:Ny,
                    
                    % current site (j1,k1) is the site we are looking for only if
                    % its distance to jk0 is actually distance_lumen AND if
                    % (j1,k1) is an empty site!!!!!
                    
                    %if da(j1,k1)==distance_lumen,
                    if da(j1,k1) == distance_lumen && type_cell(j1,k1) == 0,
                        
                        % (j30,k30) are the coordinates of the arrival
                        % point IN THE LUMEN for the minimum path motion
                        % algorithm. This means that in case of mitosis,
                        % (j30,k30) will turn to be a cell. In case of
                        % apoptosis, (j30,k30) will invade the graft and
                        % will turn the second last cell of the path in
                        % lumen itslef
                        j30=j1; k30=k1;
                        distance_lumen = da(j30,k30);
                    end
                end
            end
            clear da;
            vide=lumen_hole; % cell is inside intima
        end
        
        
        if lamina(j,k)>0, % inside media we will move toward the outside of the graft,
            % so we can start minimizing the distance between
            % current site (j,k) and the external support.
            % Procedure is the same of the one applied inside
            % intima.
            distance_external=Nx+Ny;
            for jk=1:Nes,
                da=sqrt((X(j,k)-Xes(jk))^2+(Y(j,k)-Yes(jk))^2);
                if da<distance_external,
                    jk0=jk; distance_external=da;
                end
                clear da;
            end
            
            for j1=1:Nx,
                for k1=1:Ny,
                    if external_support(j1,k1)==1,
                        da(j1,k1)=sqrt((Xes(jk0)-X(j1,k1))^2+(Yes(jk0)-Y(j1,k1))^2);
                    else
                        da(j1,k1)=Nx*Ny;
                    end
                end
            end
            distance_external=min(min(da));
            for j1=1:Nx,
                for k1=1:Ny,
                    
                    % Again ... (j1,k1) is the site we are looking for if
                    % its distance is distance_external and if (j1,k1) is
                    % an empty site!!!!!
                    if da(j1,k1) == distance_external && type_cell(j1,k1) == 0,
                        
                        % (j30,k30) are the coordinates of the arrival
                        % point for the minimum path motion algorithm.The
                        % cell will be placed in here!
                        j30=j1; k30=k1;
                        distance_external=da(j30,k30);
                    end
                end
            end
            clear da
            
            vide=external_support; % cell is inside media
        end
        
        % Check point: before placing the cell site (j30,k30) has to be an empty space or we cannot
        % place the new cell in there. He should not as we have taken care
        % of that adding the && statement to the cycle
        if type_cell(j30,k30)~=0 || lumen_hole(j30,k30)+external_support(j30,k30)==0,
            display('BUG in SMC_minimum_path_motion line 133: you are trying to place a cell in an OCCUPIED SITE or in a site that is not external support or lumen hole!');
            pause;
        end
        
        
        % After the check point we have the starting point (j,k) and the
        % arrival point (j30,k30) of the minimum path motion algorithm.
        % (j30,k30) is either in the lumen or in the external support.
        
        j2=j; k2=k;
        step_chemin=0; % Initialize the steps counter
        
        % The following cycle determines how long we will need to travel
        % along the grid in order to find an empty space where to place the
        % daughter cell of site (j,k)
        while vide(j2,k2)==0,
            step_chemin=step_chemin+1; % update steps counter
            if mod(k2,2)==0,
                j_k=2;
            else
                j_k=1;
            end
            
            % explore all the possible directions for the algorithm
            for n=1:6,
                j3=j2+directionx(n,j_k);
                k3=k2+directiony(n);
                
                % dist6 is a vector virtually containing all the neighbors
                % of current site (j,k). In dist6 we will place the
                % distance of each neighbor to the arrival point (j30,k30).
                dist6(n)=sqrt((X(j3,k3)-X(j30,k30))^2+(Y(j3,k3)-Y(j30,k30))^2)+bruit*rand(1);
            end
            
            % get the neighbor of (j,k) with minimum distance to (j30,k30)
            [~,nI]=min(dist6); % nI is the index of the neighbor closest to (j30,k30)
            
            % (j3,k3) --> coordinates of the closest neighbor to (j30,k30)
            j3=j2+directionx(nI,j_k);
            k3=k2+directiony(nI);
            
            % chemin is a <#steps,2> matrix. In each row the coordinates of
            % the sites touched by the algorithm are recorded. It keeps
            % track of the path that the algorithm will follow to carry the
            % cell in its spot. ATTENTION: THE CHEMIN IS COMPREHENSIVE OF
            % THE ARRIVAL POINT TOO!!!!!!! SO THE LAST ROW CONTAINS THE
            % COORDINATE OF THE SITE (j30,k30) WHICH IS AN EMPTY SITE!!!!!
            chemin(step_chemin,1) = j3;
            chemin(step_chemin,2) = k3;
            
            % Update the current site position and restart to look for an
            % empty space from there!
            j2=j3; k2=k3;
            
            %             if step_chemin>Nx+Ny,
            %                 display('bug'); pause
            %             end
        end
        
        % total length of the path for the current site
        length_path = step_chemin;
    end
end


%% If current site (j,k) underwent mitosis...
if change_cell(j,k)==1,
    if cell_at_wall==0, % just to be sure that we have to apply the minimum path motion algorithm
        
        % update tissue along the path after mitosis:
        
        % Starting from the end of the path, make room for the new cell
        % that will be placed in one of the neighbor of (j,k) (that was
        % already occupied)! Copy in n cell what is in (n-1)
        for kpath=1:length_path-1,
            newstep=length_path-kpath+1;
            
            % (j1,k1) --> coordinates of the cell where to copy what's contained
            % in (j2,k2)
            j1=chemin(newstep,1);
            k1=chemin(newstep,2);
            
            % (j2,k2) --> coordinates of the site that will be copied in (j1,k1)
            j2=chemin(newstep-1,1);
            k2=chemin(newstep-1,2);
            
            % Update the state matrices
            type_cell(j1,k1)=type_cell(j2,k2); % copy the SMC/ECM contained
            internal_clock(j1,k1)=internal_clock(j2,k2); % copy the clock
            change_cell(j1,k1)=change_cell(j2,k2); % copy the change status
            % Checkpoint not to leave empty sites
            if lamina(j1,k1)<=0 && type_cell(j1,k1)==0, % in intima
                display('bug in SMC minimum_path line 239: HOLE IN THE GRAFT!');
                pause;
            end
            if lamina(j1,k1)>0 && type_cell(j1,k1)==0, % in media
                display('bug in SMC minimum_path line 243: HOLE IN THE GRAFT!');
                pause;
            end
        end
        
        % Place the new born cell in (j1,k1), the neighbor of (j,k) that
        % corresponds to the very first site of the chemin
        j1=chemin(1,1);
        k1=chemin(1,2);
        
        type_cell(j1,k1)=type_cell(j,k); % copy the cell
        internal_clock(j1,k1)=0; % reset the clock
        change_cell(j1,k1)=0; % copy the change cell status
        % checkpoint: current (j1,k1) MUST not be empty
        if lamina(j1,k1)<=0 && type_cell(j1,k1)==0, % in intima
            display('bug in SMC minimum_path line 272: HOLE IN THE GRAFT!');
            pause;
        end
        if lamina(j1,k1)>0 && type_cell(j1,k1)==0, % in media
            display('bug in SMC minimum_path line 276: HOLE IN THE GRAFT!');
            pause;
        end
        
        % Update site (j,k)
        type_cell(j,k)=1; % it has an SMC
        internal_clock(j,k)=0; % reset the clock after mitosis
        change_cell(j,k)=0; % reset the change cell status
        % checkpoint: current (j,k) MUST not be empty
        if lamina(j,k)<=0 && type_cell(j,k)==0, % in intima
            display('bug in SMC minimum_path line 286: HOLE IN THE GRAFT!');
            pause;
        end
        if lamina(j,k)>0 && type_cell(j,k)==0, % in media
            display('bug in SMC minimum_path line 290: HOLE IN TEH GRAFT!');
            pause;
        end
        
        
        % Checkpoint : in case of mitosis, the last site of the path
        % (j30,k30) has been invaded from the graft itself, so it is NOT
        % lumen or external support anymore!!!
        
        % (j1,k1) --> coordinates of the last site of the path
        j1=chemin(length_path,1);
        k1=chemin(length_path,2);
        % Update state matrices accordingly
        if lamina(j1,k1) <= 0, % inside intima
            lumen_hole(j1,k1) = 0;
        end
        if lamina(j1,k1) > 0 % inside media
            external_support(j1,k1) = 0;
        end
    end
end


%% If current site (j,k) underwent apoptosis...
if change_cell(j,k)==-1,
    if cell_at_wall==0,
        
        % update tissue along the path after apoptosis:
        j1=chemin(1,1);
        k1=chemin(1,2);
        
        % First of all copy whatever is contained on the closest neighbor
        % of (j,k) in site (j,k) itself.
        type_cell(j,k)=type_cell(j1,k1);
        internal_clock(j,k)=0;
        change_cell(j,k)=0;
        % checkpoint not to leave holes in the graft
        if lamina(j,k)<=0 && type_cell(j,k)==0,
            display('bug in SMC minimum_path line 314: HOLE IN THE GRAFT!');
            pause;
        end
        if lamina(j,k)>0 && type_cell(j,k)==0, % in media
            display('bug in SMC minimum_path line 318: HOLE IN THE GRAFT!');
            pause;
        end
        
        % Now update the tissue along all the path
        for kpath=1:length_path-2,
            
            j1=chemin(kpath,1);
            k1=chemin(kpath,2);
            
            j2=chemin(kpath+1,1);
            k2=chemin(kpath+1,2);
            
            type_cell(j1,k1)=type_cell(j2,k2);
            internal_clock(j1,k1)=internal_clock(j2,k2);
            change_cell(j1,k1)=change_cell(j2,k2);
            % checkpoint not to leave holes in the graft
            if lamina(j1,k1)<=0 && type_cell(j1,k1)==0,
                display('bug in SMC minimum_path line 336: HOLE IN THE GRAFT!');
                pause;
            end
            if lamina(j1,k1)>0 && type_cell(j1,k1)==0, % in media
                display('bug in SMC minimum_path line 340: HOLE IN THE GRAFT!');
                pause;
            end
        end
        
        % Update state matrices of second last site of the path
        % (j1,k1) --> coordinates of second last site of the path
        j1=chemin(length_path-1,1);
        k1=chemin(length_path-1,2);
        
        type_cell(j1,k1)=0;
        internal_clock(j1,k1)=0;
        change_cell(j1,k1)=0;
        % Checkpoint : the secondlast site of the path is now SURELY empty, so
        % update lumen_hole and external_support matrices accordingly
        if lamina(j1,k1)<=0, % in intima ...
            lumen_hole(j1,k1) = 1; % lumen has invaded the graft
        end
        if lamina(j1,k1)>0, % in media ...
            external_support(j1,k1) = 1; % ext support has invaded the graft
        end
    end
end

clear vide chemin
