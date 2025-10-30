% ECM_unique_empty: place a piece of ECM in the unique empty neigh of (j,k)

% access the code IF AND ONLY IF (j,k) has produced an ECM
if change_matrix(j,k) == 1, 
    
    % Checkpoint: (j,k) cannot be part of lumen or external support
    if lamina(j,k)<=0,
        if lumen_hole(j,k)~=0,
            display('bug in ECM_unique_empty line 13: piece of lumen recorded where not supposed to'); pause;
        end
    else
        if external_support(j,k)~=0,
            display('bug in SECM_unique_empty line 17: piece of ext support recorded where not supposed to'); pause;
        end
    end
                       
    % check state of neighbors and look for empty sites:
    if mod(k,2)==0,
        j_k=2;
    else
        j_k=1;
    end
    
    % liste --> virtual neighbors vector 
    % if neighbor is empty --> liste(neighbor) = 1
    % if neighbor is occupied --> liste(neighbor) = 0
    liste=zeros(6,1);
    n2=0;
    for n=1:6, % look for empty neighbor sites.
        
        % (j3,k3) --> temporary coordinates of the neighbor
        j3=j+directionx(n,j_k); 
        k3=k+directiony(n);
        
        % neighbor must be empty and belong to lumen or ext support
        if type_cell(j3,k3)==0 && lumen_hole(j3,k3)+external_support(j3,k3)~=0,
            liste(n,1)=1; 
            
            % newliste contains only the indexes of the neighbors that are
            % actually empty
            n2=n2+1; 
            newliste(n2)=n;
        end
    end
    
    % NB: outside of this cycle we have liste and newliste that have this
    % form:
    % liste --> |1|1|0|0|0|0|
    % newliste --> |1|2|
    
    % nvide --> how many neighbors of (j,k) are empty
    nvide=sum(liste(:,1));
    
    % IF THERE IS ONLY ONE EMPTY NEIGHBOR AND ONE ONLY.....
    if nvide == 1,
        
        % n is the right index of the only empty neighbor
        n=newliste(n2);
        
        % (j1,k1) --> coordinates of the only empty neighbor where SMC will
        % deposit the ECM piece
        j1=j+directionx(n,j_k); 
        k1=k+directiony(n);
        
        % SMC deposits ECM in (j1,k1) 
        type_cell(j1,k1) = 2; % place ECM in (j1,k1)
        internal_clock(j1,k1) = 1; % reset the clock for (j1,k1)
        change_matrix(j1,k1) = 0; % reset change_matrix
        % Update state matrices
        if lamina(j1,k1)<=0,
            lumen_hole(j1,k1)=0;
        end
        if lamina(j1,k1)>0,
            external_support(j1,k1)=0;
        end
        
        % There's no need to update (j,k), except by being sure to reset
        % the change_matrix tracker
        change_matrix(j,k) = 0;
        
    end
    clear newliste
    
end

    