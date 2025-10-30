clear variables
close all
clc

load data8

% Isolate the graft from lumen/external support
for ii=1:121
    for jj=1:121
        
        if type_cell(ii,jj)~=0,
            type_cell(ii,jj) = 1;
        end
        
    end
end
clear ii jj

% Initialize the medial layer
intima_temp = type_cell+lamina; % intimal chucnk = 0
intima = zeros(121,121);

for ii=1:121,
    for jj=1:121,
        
        if intima_temp(ii,jj) == 0,
            intima(ii,jj) = 0;
        else
            intima(ii,jj) = 1;
        end
        
    end
end
clear ii jj

figure(1)
pcolor(intima)
colormap(gray(2))
title('intimal thickness t = 8 months')



