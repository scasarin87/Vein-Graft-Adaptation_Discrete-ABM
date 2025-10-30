clear variables
close all
clc

load data8
%load basic_solution

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
media_temp = type_cell+lamina; % medial chucnk = 2
media = zeros(121,121);

for ii=1:121,
    for jj=1:121,
        
        if media_temp(ii,jj) == 2,
            media(ii,jj) = 0;
        else
            media(ii,jj) = 1;
        end
        
    end
end
clear ii jj

figure(1)
imagesc(media)
colormap(gray(2))




