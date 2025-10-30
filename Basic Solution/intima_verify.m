figure(2)

for ii=1:size(lamina,1)
for jj=1:size(lamina,2)
if lamina(ii,jj)~=-1
lamina(ii,jj) = 0;
end
end
end
pcolor(lamina)
intima = lamina + lumen_hole;
close
pcolor(intima)