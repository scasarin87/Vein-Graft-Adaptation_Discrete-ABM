% Brownian motion2: viceversa apply contact increase at the adventitia interface and
% pressure relaxation at the lumen interface

% cells at the interface are going to move to increase contact:
nouvel_ordre=rand(Nx*Ny,1);
[~, newK]=sort(nouvel_ordre); clear nouvel_ordre ordre

% Access randomly all the sites one-by-one
for kcell=1:Nx*Ny,
    
    % (j,k) --> current site coordinates
    j=ceil(newK(kcell)/Nx);
    k=newK(kcell)-(j-1)*Nx;
    
    if type_cell(j,k)>0, % process a site occupied by an SMC or ECM
        
        if mod(k,2)==0,
            j_k=2;
        else
            j_k=1;
        end
        
        % liste(:,1) --> neighbors of (j,k) indexes (1 if empty, 0 if occupied)
        % liste(:,2) --> #empty spaces of the corresponding neighbor of (j,k)
        % liste(:,3) --> distance of neighbor of (j,k) from CA's center
        liste=zeros(6,3);
        
        % look for empty neighbors and record their position
        for n=1:6,
            
            % random initilization of the (j3,k3)/center distance
            liste(n,3) = Cx*Cx+Cy*Cy;
            
            % (j3,k3) --> coordinates of the temporary (j,k) neighbor
            j3=j+directionx(n,j_k);
            k3=k+directiony(n);
            
            % if (j3,k3) is empty, record its position placing a 1 in the
            % corresponding place of array liste
            if type_cell(j3,k3)==0 && lumen_hole(j3,k3)+external_support(j3,k3)~=0,
                liste(n,1)=1;
                
                % I want to know how many empty neighbors does have each
                % single neighbor in the (j,k) surrounding
                nvide2=0; % initialize the counter
                
                for n2=1:6,
                    if mod(k3,2)==0,
                        j_k2=2;
                    else
                        j_k2=1;
                    end
                    
                    % (j4,k4) --> coordinates of the neighbor of the empty
                    % neighbor of (j,k)
                    j4=j3+directionx(n2,j_k2);
                    k4=k3+directiony(n2);
                    
                    % if (j4,k4) is empty
                    if type_cell(j4,k4)==0 && lumen_hole(j4,k4)+external_support(j4,k4)~=0,
                        nvide2=nvide2+1; % update the counter
                    end
                end
                
                % second column of liste contains the number of empty
                % spaces that have been founded around each empty neighbors
                % of (j,k)
                liste(n,2)=nvide2;
                
                % get the actual distance between (j3,k3) and the center
                distance = sqrt((X(j3,k3)-Cx)^2 +(Y(j3,k3)-Cy)^2);
                liste(n,3) = distance;
            end
        end
        clear j3 k3
        
        % NB: out of the last cicle, we have a matrix liste that looks like
        % liste = |1|2|d1|
        %         |0|1|d2|
        %         |0|2|d3|
        %         |1|2|d4|
        %         |0|1|d5|
        %         |1|3|d6|
        % where first colum has 1 if the neighbor is empty, 0 otherwise
        % and the second column contains the number of empty spaces for
        % each neighbors AND the third column contains the distance between
        % the neighbor of (j,k) and the center of CA
        
        % I am only interested in empty site neighbors to compact the grid
        for n=1:6,
            if liste(n,1)==0, % remove candidate from the list that have no empty neighbors:
                liste(n,2)=10; % random high number
                liste(n,3)=-Nx*Ny; % random low number
            end
        end
        
        % nvide = #empty neighbors of (j,k)
        nvide=sum(liste(:,1));
        
        % We will need to compact the grid ONLY if (j,k) has more than just
        % one empty neighbor. On the contrary the grid s already compacted
        % enough!!
        if nvide>1,
            
            % nvide3 --> minimum # of neighbor of (j3,k3)
            % n3 --> index of the empty neighbor of (j,k) with least
            % empty neighbors!!!
            [nvide3,n3] = min(liste(:,2));
            if nvide3 < nvide, % only if (j,k) has more empty neighbors than its empty neighbor apply the compactation
                free_ride_cell;
            end
            
        end
        
    end
end








