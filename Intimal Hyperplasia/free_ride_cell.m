% free_ride_cell used for the brownian motion

%% Check point: prior to move any cell from (j,k), it is good practice to
% check if lumen_hole and external_support matrices are well updated for
% that site. In this case, (j,k) surely contains an SMC, or at least it is
% occupied, so lumen_hole(j,k) and external_support(j,k) MUST be 0

if lamina(j,k)>0 && external_support(j,k)==1, % in media...
    display('BUG in free_ride_cell line 8: external_support is not 0 where it is supposed to be'); 
    pause;
end

% in intima though...
if lamina(j,k)<=0 && lumen_hole(j,k)==1,
    display('BUG in free ride cell line 15: lumen_hole is not 0 where it supposed to be');
    pause;
end


%% COMPACT THE GRID

% (j3,k3) is the empty neighbor of (j,k) with the less number of empties on
% its surrounding
j3=j+directionx(n3,j_k);
k3=k+directiony(n3);

% move cell from (j,k) to (j3,k3)
type_cell(j3,k3) = type_cell(j,k); % move the cell (j,k) --> (j3,k3)
internal_clock(j3,k3) = internal_clock(j,k); % copy the clock info

% copy change tracker information
if flag == 1,
    change_cell(j3,k3) = change_cell(j,k);
else
    change_matrix(j3,k3) = change_matrix(j,k);
end

% Update state matrices of lumen and ext support 
if lamina(j3,k3) > 0, % in media,
    external_support(j3,k3)=0;
end
if lamina(j3,k3)<=0, % in intima,
    lumen_hole(j3,k3)=0;
end

type_cell(j,k)=0; % remove the cell from (j,k)
internal_clock(j,k)=0; % reset the clock

% copy change tracker information
if flag == 1,
    change_cell(j,k) = 0;
else
    change_matrix(j,k) = 0;
end


% Update state matrices of lumen and ext support 
if lamina(j,k)>0, % in media,
    external_support(j,k)=1;
end
if lamina(j,k)<=0, % in intima,
    lumen_hole(j,k)=1;
end


%% FINAL checkpoint
if type_cell(j3,k3) == 0, % first of all, verify if (j3,k3) has the cell or not
    display('BUG in free ride cell line 63: (j3,k3) does NOT contain a cell when it is supposed to'); pause;
end

% Check if lumen_hole and external_support have been updated correctly for
% (j3,k3) (they both MUST be 0)
if lamina(j3,k3)>0 && external_support(j3,k3)==1,
    display('BUG in free ride cell line 69: external_support(j3,k3) MUST be 0 here'); pause;
end
if lamina(j3,k3)<=0 && lumen_hole(j3,k3)==1,
    display('BUG in free ride cell line 72: lumen_hole(j3,k3) MUST be 0 here'); pause;
end

% Check if lumen_hole and external_support have been updated correctly for
% (j,k) (they both MUST be 1)
if lamina(j,k)>0 && external_support(j,k)==0,
    display('BUG in free ride cell line 78: external_support(j,k) MUST be 1 here'); pause;
end
if lamina(j,k)<=0 && lumen_hole(j,k)==0,
    display('BUG in free ride cell line 81: lumen_hole(j,k) MUST be 1 here'); pause;
end
