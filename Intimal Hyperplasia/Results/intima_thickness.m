% intima_thickness
clear variables
close all
clc

% load the output of the ABM
load data9

% Initialize the matrix 
intima = zeros(Nx,Ny);

temp1 = zeros(Nx,Ny); % 1 if occupied(SMC or ECM), 0 if not 
for ii=1:Nx,
    for jj=1:Ny,
        
        if type_cell(ii,jj) ~= 0,
            temp1(ii,jj) = 1;
        end
        
    end
end
clear ii jj

% Cut the media
for ii=1:Nx,
    for jj=1:Ny,
        
        if lamina(ii,jj) > 0,
            temp1(ii,jj) = 0;
        end
        
    end
end
clear ii jj

% Invert the color
for ii=1:Nx,
    for jj=1:Ny,
        
        if temp1(ii,jj) == 1,
            intima(ii,jj) = 0;
        else
            intima(ii,jj) = 1;
        end
        
    end
end
clear ii jj

figure(1)
imagesc(intima)
colormap(bone)
            
