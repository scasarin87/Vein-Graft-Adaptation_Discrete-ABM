% SMC_unique_empty

% the code processes only mitotic sites,
if change_cell(j,k) == 1, % process an SMC cell that is inside the tissue (precisely at the wall),
    % goes through mitosis and has a UNIQUE empty site neighbor:
    
    % Checkpoint: (j,k) cannot be part of lumen or external support
    if lamina(j,k)<=0,
        if lumen_hole(j,k)~=0,
            display('bug in SMC_unique_empty line 10: piece of lumen recorded where not supposed to'); pause;
        end
    else
        if external_support(j,k)~=0,
            display('bug in SMC_unique_empty line 14: piece of ext support recorded where not supposed to'); pause;
        end
    end
    
    % Check the state of neighbors and look for empty sites:
    if mod(k,2)==0,
        j_k=2;
    else
        j_k=1;
    end
    
    % liste --> vector of the 6 neighbors in an hexagonal grid
    % liste(n) = 1 if n is an empty space
    % liste(n) = 0 if n is a space already occupied
    liste=zeros(6,1);
    n2=0;
    for n=1:6, % look for empty neighbor sites.
        j3=j+directionx(n,j_k);
        k3=k+directiony(n);
        
        % IF you find an empty space, part of lumen or external support,
        if type_cell(j3,k3)==0 && lumen_hole(j3,k3)+external_support(j3,k3)~=0,
            
            % record its position in liste
            liste(n,1)=1;
            n2=n2+1;
            
            % newliste contains only the exact positions with empty spaces, so for
            % example if liste = |1|1|0|0|0|1| --> newliste = |1|2|6|
            newliste(n2)=n;
        end
    end
    
    % nvide --> how many empty spaces around (j,k) site
    nvide=sum(liste(:,1));
    
    % Place automatically the new cell IF AND ONLY IF the empty neighbor is
    % UNIQUE!
    if nvide == 1,
        n=newliste(n2); % n is the index of the unique empty spot!
        
        % (j1,k1) --> coordinates of the unique empty neighbor around (j,k)
        % that has to be found in the lumen OR in the external support
        j1=j+directionx(n,j_k);
        k1=k+directiony(n);
        
        % update the state matrices placing the new cell in its position
        type_cell(j1,k1)=type_cell(j,k); % place an SMC in (j1,k1)
        internal_clock(j1,k1)=internal_clock(j,k); % copy the clock
        change_cell(j1,k1)=change_cell(j,k); % reset the change status matrix
        % Update lumen and ext support state matrices
        if lamina(j1,k1)<=0,
            lumen_hole(j1,k1) = 0;
        end
        if lamina(j1,k1)>0,
            external_support(j1,k1)=0;
        end
        
        % check site (j,k)
        type_cell(j,k)=1;
        internal_clock(j,k)=0; % reset the clock
        change_cell(j,k)=0;
        % Update lumen and ext support state matrices
        if lamina(j,k)<=0,
            lumen_hole(j,k) = 0;
        end
        if lamina(j,k)>0,
            external_support(j,k)=0;
        end
    end
    clear newliste
end


