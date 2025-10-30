% preprocessing:

%% 1) we get first the lumen wall:
wa=lumen_hole;
for kt=1:20,
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
Lumen_wall=contour(Y,X,wa,[0.7 0.7]);
Nlw=Lumen_wall(2,1); 

% Coordinates of lumen wall
Xlw=Lumen_wall(1,2:Nlw+1);
Ylw=Lumen_wall(2,2:Nlw+1);

% same but as a discrete subset instead of a level set:
lumen_wall=zeros(Nx,Ny);
for j=2:Nx-1,
    for k=2:Ny-1,
        if lumen_hole(j,k)==1,
            for n=1:6,
                j1=j+directionx(n,j_k); k1=k+directiony(n);
                % j1=j+directionx(n); k1=k+directiony(n,j_k);
                if lumen_hole(j1,k1)==0,
                    lumen_wall(j,k)=1;
                end
            end
        end
    end
end
   

%% 2) Now we get the external support
wa=external_support;
for kt=1:20,
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

External_wall=contour(Y,X,wa,[0.7 0.7]);
Nes=External_wall(2,1); 
Xes=External_wall(1,2:Nes+1);
Yes=External_wall(2,2:Nes+1); 

%% Plot the wall profile
%figure(1)
plot(Xlw,Ylw,'r',Xes,Yes,'b');


        
        