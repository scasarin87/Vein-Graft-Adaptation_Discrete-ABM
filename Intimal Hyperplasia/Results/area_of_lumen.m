% lumen_area: plot the area of the lumen as a matrix of 1 and 0

%% Starting lumen area
clear variables
close all
clc

% Load the output of the ABM
load basic_solution % t=0 days

% lumen_hole already suited for our pourpose: just invert it for colormap
% purposes
temp=zeros(Nx,Ny);
for ii=1:Nx,
    for jj=1:Ny,
        
        if lumen_hole(ii,jj) == 0,
            temp(ii,jj) = 1;
        end
        
    end
end
clear ii jj
lumen_hole2 = temp; clear temp

% Show the area of the lumen
figure(1)
imagesc(lumen_hole2)
colormap(bone)
title('Starting Lumen area')


%% Lumen area at t=8 months
clear variables
% Load the output after the whole follow up
load data9

temp=zeros(Nx,Ny);
for ii=1:Nx,
    for jj=1:Ny,
        
        if lumen_hole(ii,jj) == 0,
            temp(ii,jj) = 1;
        end
        
    end
end
clear ii jj
lumen_hole2 = temp; clear temp

% Plot the lumen area
figure(2)
imagesc(lumen_hole2)
colormap(bone)
title('Lumen area at t=8 months')

