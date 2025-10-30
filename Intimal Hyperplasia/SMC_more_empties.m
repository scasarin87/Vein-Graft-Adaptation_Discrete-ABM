% wall_cell_treatment: the code places the daughter cell of site (j,k) in
% one random empty sites close to it.

% This will be needed to scan the neighbors in a hexagonal grid
if mod(k,2)==0, % if k is even ...
    j_k=2;
else % ... else if k is odd
    j_k=1;
end

% liste virtually contains the 6 neighbor spots of the current site (j,k)
% if the neighbor N is empty, liste(N) = 1, otherwise liste(N) = 0.
liste=zeros(6,1);
for n=1:6,
    
    % (j3,k3) temporary coordinates of (j,k) neighbor
    j3=j+directionx(n,j_k); 
    k3=k+directiony(n);
    
    % if (j3,k3) is empty, and part of lumen or external support, place 1
    % in the liste vector
    if type_cell(j3,k3)==0 && lumen_hole(j3,k3)+external_support(j3,k3)~=0,
        liste(n)=1;
    end
end

% Pick randomly an empty neighbor site if it exists:
nvide=sum(liste); % nvide = numbers of empty sposts around current (j,k)
clear newliste

% cell_at_wall = 0 IF there is NO empty spots around (j,k)
% cell_at_wall = 1 IF there is at least one empty spot around (j,k)
cell_at_wall = 0;

% nvide is > 0 if there is at least one empty spot
if nvide>0, 
    cell_at_wall=1; % update cell_at_wall flag. A cell will be placed at the wall of
                    % the current site (j,k) no matter what
    n1=1;
    for n=1:6,
        if liste(n)~=0, % if that is an empty site .... 
            % newliste will contain only the index of neighbors that are empty!
            % example: if liste --> |0|1|1|0|1|0| , newliste --> |2|3|5|
            newliste(n1)=n; n1=n1+1; 
        end
    end
    
    % Now we choose a random empty site between the ones around site (j,k)
    n_empty_site = n1-1; % n_empty_site = how many empty sites around the current (j,k)
    n2 = ceil(n_empty_site*rand(1));
    n=newliste(n2); % n is the index of the random empty site chosen
    
    % the empty site chosen randomly has coordinates (j3,k3) and it stays
    % ncessarily or in the lumen or in the external support
    j3=j+directionx(n,j_k); 
    k3=k+directiony(n);
    
    % Check Point: (j3,k3) MUST be an empty site. If it's not, display a
    % bug and stop the simulation
    if type_cell(j3,k3)~=0 || lumen_hole(j3,k3)+external_support(j3,k3)==0,
        display('BUG in SMC_more_empties line 61: (j3,k3) is NOT an empty site or it is, but it is not part of lumen or ext support!'); 
        pause;
    end
    
    
    % Now, we know where to place the new cell (site (j3,k3)) and we know
    % which site has generated it (site (j,k)). We can update the state
    % matrices differently if we have encountered mitosis or apoptosis
    
    %% If (j,k) underwent mitosis...
    if change_cell(j,k) == 1, 
        
        % Update the 3 state matrices
        type_cell(j3,k3) = type_cell(j,k); % cell placed in the neighbor is of the same type of course (~SMC)
        internal_clock(j3,k3) = 0; % update the clock of the neighbor
        change_cell(j3,k3)=0; % neighbor didn't have a direct activity
        % Check point: if (j3,k3) is in the lumen or in the external
        % support, we need to update the related state matrices
        if lamina(j3,k3) <= 0, % if we are in intima 
            lumen_hole(j3,k3) = 0; % there's no lumen hole in (j3,k3)
        end
        if lamina(j3,k3) > 0, % in media...
            external_support(j3,k3) = 0; % there's no more external support
        end
        
        % Doublecheck site (j,k)
        type_cell(j,k)=1; 
        internal_clock(j,k)=0; % reset the clock of the current (j,k)
        change_cell(j,k)=0; % reset the change_cell matrix after having placed the daughter cell    
        %  Update the state matrices of lumen and ext support
        if lamina(j,k) <= 0, % if we are in intima 
            lumen_hole(j,k) = 0; % there's no lumen hole in (j3,k3)
        end
        if lamina(j,k) > 0, % in media...
            external_support(j,k) = 0; % there's no more external support
        end
        
    end

    
    %% If (j,k) underwent apoptosis...
    if change_cell(j,k) == -1,
        
        % Update the state matrices
        type_cell(j,k)=0; % previous cell in (j,k) disappears
        internal_clock(j,k)=0; % reset the clock
        change_cell(j,k)=0; % reset the cell status change matrix
        
        % Update lumen_hole and external_support accordingly. In case of
        % apoptosis either the lumen or the external support "invade" the
        % graft
        if lamina(j,k)<=0,
            lumen_hole(j,k) = 1;
        end
        if lamina(j,k)>0
            external_support(j,k) = 1;
        end   
    
    end
end
    

