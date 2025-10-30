clear variables
close all
clc

load data1

for ii=1:121,
    for jj=1:121,
        
        if lumen_hole(ii,jj) == 0,
            lumen(ii,jj) = 1;
        else
            lumen(ii,jj) = 0;
        end
        
    end
end
clear ii jj

figure(1);
pcolor(lumen);
colormap(gray(2))