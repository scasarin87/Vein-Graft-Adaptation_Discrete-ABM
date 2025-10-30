close all
figure(1)

for ii=1:size(lamina,1)
    for jj=1:size(lamina,2)
        if lamina(ii,jj)~=-1
            lamina(ii,jj) = 0;
        end
    end
end

intima = lamina + lumen_hole;
pcolor(intima)
title('Intimal thickness pre hyperplasia')