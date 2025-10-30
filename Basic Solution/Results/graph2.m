% new graph

% lumen --> 0
% SMCintima --> 1
% ECMintima --> 2
% SMCmedia --> 3
% ECMmedia --> 4
% external support --> 5
clear variables
close all
clc

load data3

graph = zeros(121,121);

% SMCintima --> 1 && ECMintima --> 2
for ii=1:121
    for jj=1:121,
        
        if lamina(ii,jj)<=0
            if type_cell(ii,jj) == 1, % smc intima
                graph(ii,jj)=1;
            end
            if type_cell(ii,jj) == 2, % ecm intima
                graph(ii,jj)=2;
            end
            
        else
            if type_cell(ii,jj) == 1, % smc media
                graph(ii,jj)=3;
            end
            if type_cell(ii,jj) == 2, % ecm media
                graph(ii,jj)=4;
            end
            
        end
        
    end
end
clear ii jj

% lumen --> 0
for ii=1:121,
    for jj=1:121,
        
        if lumen_hole(ii,jj) == 1,
            graph(ii,jj) = 0;
        end
        
    end
end
clear ii jj

% external support --> 5
for ii=1:121,
    for jj=1:121,
        
        if external_support(ii,jj) == 1,
            graph(ii,jj) = 5;
        end
        
    end
end
clear ii jj

figure(1)
imagesc(graph)
title('transverse view')

% figure(2)
% surf(graph)
% title('frontal view')

            
                
            