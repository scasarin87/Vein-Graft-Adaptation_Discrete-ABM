% IEL_outward: shift all the graft of one position according with minimum
% path motion law. All the sites are shifted toward the external support
clear chemin dist6 vide

bruit=0.1; % level of noise added to the distance function used to compute the shortest path
            
% We need to get the closest point to the center of the grid that stands on
% the graft external wall or on the lumen border.
angle=pi*rand(1)-pi;

% thetaes --> for each site belonging to the external wall, it keeps record of
% its distance from the center of the graft. NB: the cicle uses the atan2
% function, becuase it calculates the distance with trigonometric laws
thetaes = zeros(Nes);
for jk=1:Nes,
    thetaes(jk)=atan2(Yes(jk)-Cy,Xes(jk)-Cx);
end

% jk --> index of the site on graft border closest to the center of CA!!
[~,jk]=min(abs(thetaes-angle));
clear thetaes

% Now we need the site belonging to the external support closest to jk
distance=Nx+Ny;
for j2=1:Nx,
    for k2=1:Ny,
        if external_support(j2,k2) == 1, % we are looking for a site on the external support
            da=sqrt((X(j2,k2)-Xes(jk)).^2+(Y(j2,k2)-Yes(jk)).^2);
            
            if da<distance,
               
               % (jou,kou) --> coordinates of the site belonging to external support closest to point jk on graft wall 
               jou=j2;
               kou=k2;  
               
               % distance --> minimized distance (jou,kou)/jk
               distance=da; 
            end
            clear da;
        end
    end
end

% Exactly the same but looking for 
% 1) the site on the lumen border closest to the center (jk)
% 2) the site inside lumen closest to jk (jlu,klu)
thetalw = zeros(Nlw);
for jk=1:Nlw, % compute the closest location at the wall.
    thetalw(jk)=atan2(Ylw(jk)-Cy,Xlw(jk)-Cx);
end
[xxx,jk]=min(abs(thetalw-angle));
clear thetalw
distance=Nx+Ny;
for j2=1:Nx,
    for k2=1:Ny,
        if lumen_hole(j2,k2) == 1,
            da=sqrt((X(j2,k2)-Xlw(jk)).^2+(Y(j2,k2)-Ylw(jk)).^2);
            if da<distance,
                
               % (jlu,klu) --> coordinates of site inside the lumen closest to jk 
               jlu=j2;
               klu=k2; 
               
               % minimized distance (jlu,klu)/jk
               distance=da; 
            end
            clear da;
        end
    end
end

% we start to shift the CA toward the outward:
vide = external_support; 

% (j2,k2) takes the coordinates of the site inside the lumen closest to
% that point standing on the lumen border closest to the center of CA.
% This is the strating point of our path
j2=jlu; 
k2=klu;

% Quick checkpoint --> check if (j2,k2) is in the lumen indeed!
if vide(j2,k2)==1,
    display('BUG in IEL_update line 83: piece of external support recorded where not supposed to!'); 
    pause
end

step_chemin=0;
while vide(j2,k2)==0,
    step_chemin=step_chemin+1;
    if mod(k2,2)==0,
        j_k=2;
    else
        j_k=1;
    end
    
    % Build a minimum path motion between (jlu,klu) and (jou,kou) 
    for n=1:6,
        j3=j2+directionx(n,j_k); k3=k2+directiony(n);
        % distance from the site to the lumen + noise
        dist6(n)=sqrt((X(j3,k3)-X(jou,kou)).^2+(Y(j3,k3)-Y(jou,kou)).^2)+bruit*rand(1);
    end
    
    % Every step, get the coordinates of the neighbor closest to (jou,kou)
    [Z,nI]=min(dist6); 
    
    % (j3,k3) --> neighbor of the current site that stands on the path
    j3=j2+directionx(nI,j_k); 
    k3=k2+directiony(nI); clear Z;
    
    % update the path
    chemin(step_chemin,1)= j3; 
    chemin(step_chemin,2)=k3;
    
    % update current site
    j2=j3; k2=k3;
    if step_chemin>Nx+Ny,
        display('bug'); pause
    end
end
length_path=step_chemin;


%% Update the tissue along all the path

% NB: procedure is similar to what we did for the minimum path motion after
% SMC and ECM dynamic, BUT with the difference that NOW we do NOT have any
% new element to be placed. It is a pure SMC/ECM (or whatever contained in the site)
% shifting

% update the tissue starting from the end of the path. At every step shift
% what contained in n-th site inside the (n+1)-th site, where (n+1) is
% toward the external support
for kpath=1:length_path-1,
    newstep=length_path-kpath+1;
    
    % (j1,k1) --> (n+1)-th site coordinates
    j1=chemin(newstep,1); 
    k1=chemin(newstep,2);
    
    % (j2,k2) --> n-th site coordinates
    j2=chemin(newstep-1,1);
    k2=chemin(newstep-1,2);
    
    % Shift the position updating state matrices
    type_cell(j1,k1) = type_cell(j2,k2); % copy the contain of the site 
    internal_clock(j1,k1) = internal_clock(j2,k2); % copy the clock
    lamina(j1,k1) = lamina(j2,k2); % copy info of the lamina
    
    %% Quick checkpoint: cover potential holes in the graft
    if lamina(j1,k1)<=0 && type_cell(j1,k1)==0, % inside intima ...
        lumen_hole(j1,k1)=1;
    end
    
    if lamina(j1,k1)>0 && type_cell(j1,k1)==0, % inside media ... 
        external_support(j1,k1)=1;
    end
end

% Take care now of the very first site of the path that stands on lumen
% border and has coordinates (j1,k1). in paper example is (jA,kA)
j1=chemin(1,1); 
k1=chemin(1,2);

% Shift the contain of (jlu,klu) in (j1,k1)
type_cell(j1,k1)=type_cell(jlu,klu); 
internal_clock(j1,k1)=internal_clock(jlu,klu); 
lamina(j1,k1)=lamina(jlu,klu);

% double check that (jlu,klu) is a piece of lumen
type_cell(jlu,klu)=0; % there's no cell in it
internal_clock(jlu,klu)=0; % clock in the lumen is 0 always
lamina(jlu,klu)=-1; % we are cis IEL
lumen_hole(jlu,klu)=1; % and finally, we are in the lumen that has invaded the intima

% Lastly, take care of the very last site of the path. Just double check
% that has been occupied and so external_support is 0 now in that very
% site.

% (j1,k1) --> coordinates of the last site of the path, that was part of
% external support, but it is about to become part of the graft!!!!
j1=chemin(length_path,1); 
k1=chemin(length_path,2); 
external_support(j1,k1)=0; % last site becomes occupied.
   
% clear distance vide chemin 
    