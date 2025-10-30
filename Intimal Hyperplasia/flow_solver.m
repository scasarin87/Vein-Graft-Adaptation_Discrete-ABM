% preprocessing:

temps_initial = tic;
% we get first the velocity:
nsa=zeros(Nx,Ny); newnsa=nsa;

if hour>0,
    load oldvelocity;
    % quick restart from previous time step
    % needs to get zero velocity in the new wall.
    i=1;
    for j=1:Nx,
        for k=1:Ny,
            if lumen_hole(j,k)==0,
                nsa(j,k)=0.;
            end
            %A(i)=nsa(j,k);
            %i=i+1;
        end
    end
end

clear v_ns

%Poisson

residus=1; ks=0;
while residus>10^-3,
    ks=ks+1;
    for j=2:Nx-1,
        for k=2:Ny-1,
            if lumen_hole(j,k)==1,
                if mod(k,2)==0,
                    j_k=2;
                else
                    j_k=1;
                end
                delta=0;
                for n=1:6,
                    j1=j+directionx(n,j_k); k1=k+directiony(n);
                    % j1=j+directionx(n); k1=k+directiony(n,j_k);
                    delta=delta+nsa(j1,k1);
                end
                delta=delta-6*nsa(j,k)+1;
                newnsa(j,k)=(0.99*delta/6+nsa(j,k));
            end
        end
    end
    residus=max(max(abs(nsa-newnsa)));
    nsa(2:Nx-1,2:Ny-1)=newnsa(2:Nx-1,2:Ny-1);
    %if mod(ks,1000)==0,
     %   ks
    %end
end

%toc(temps_initial)

residus
ks

%Poisson
%nsa=u;

%figure(1)
%mesh(nsa)
%title('mesh of nsa');


%mean(nsa(:))
v_ns=1./max(max(nsa)).*nsa;
%mean(v_ns(:))



save oldvelocity nsa; % helpfull to restart the flow calculation quickly at next iterate.
save oldvns v_ns;
%clear nsa newnsa

% we impose conservation of flux for all time.
if hour==0,
    flux0=sum(sum(v_ns));
else
    flux1=sum(sum(v_ns));
    v_ns=flux0/flux1.*v_ns;
end
%clear nsa newnsa

% new we computer the normal direction at the wound edge using
% a level set technic:
wa=zeros(Nx,Ny); % wounded area
wa=lumen_hole; tau=wa;

for ks=1:round(max(Nx,Ny)),
    for j=2:Nx-1,
        for k=2:Ny-1,
            if mod(k,2)==0,
                j_k=2;
            else
                j_k=1;
            end
            delta=0;
            for n=1:6,
                j1=j+directionx(n,j_k); k1=k+directiony(n);
                % j1=j+directionx(n); k1=k+directiony(n,j_k);
                delta=delta+wa(j1,k1);
            end
            newwa(j,k)=(0.5*delta/6+0.5*wa(j,k));
        end
    end
    wa(2:Nx-1,2:Ny-1)=newwa(2:Nx-1,2:Ny-1);
end
clear newwa

% get normal direction and gradient of flow:
for j=2:Nx-1,
    for k=2:Ny-1,
        wax=wa(j+1,k)-wa(j-1,k);
        way=wa(j,k+1)-wa(j,k-1);
        delta=sqrt(wax^2+way^2);
        if delta>0,
            wax=wax/delta; way=way/delta;
        end
        v_nsx=v_ns(j+1,k)-v_ns(j-1,k);
        v_nsy=v_ns(j,k+1)-v_ns(j,k-1);
        tau(j,k)=wax*v_nsx+way*v_nsy;
    end
end
clear ks
tau=tau.*lumen_hole;



% computation of shear stress effect inside the wall:
% new we computer the normal direction at the wound edge using
% a level set technic:
newtau=tau;

for ks=1:tau_depth,
    for j=2:Nx-1,
        for k=2:Ny-1,
            if lumen_hole(j,k)==0,
                if mod(k,2)==0,
                    j_k=2;
                else
                    j_k=1;
                end
                delta=0;
                for n=1:6,
                    j1=j+directionx(n,j_k); k1=k+directiony(n);
                    % j1=j+directionx(n); k1=k+directiony(n,j_k);
                    delta=delta+tau(j1,k1);
                end
                newtau(j,k)=(0.5*delta/6+0.5*tau(j,k));
            end
        end
    end
    tau(2:Nx-1,2:Ny-1)=newtau(2:Nx-1,2:Ny-1);
end
Tau_wall=tau.*lumen_hole;
Tau=(tau.*(1-lumen_hole)); % get the shear stree influence inside the wall.
clear newtau
denom=sum(sum(lumen_hole));
display('mean Tau');
%mean(Tau(:))
%std(Tau(:))
%display('mean Tau at wall');
nom=sum(sum(Tau_wall));
t_wall=nom/denom
%mean(Tau_wall(:))
%std(Tau_wall(:))

%if hour>=1,
    %figure(1)
    %mesh(nsa)
    %title('mesh of velocity using sor')
    
    %figure(2)
    %contour(nsa)
    %title('contour of velocity using sor')
    %pause(3)
%end
%pause(1)

%close all
%toc(temps_initial)
%mean(Tau(:))
         
%nom=sum(sum(Tau));
%t=nom/denom
%std(Tau(:))
% Remark: the spacial scaling is the cell dimension.
% this is for the fixed geometry.



        
        