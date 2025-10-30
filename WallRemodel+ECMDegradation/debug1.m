clc

count1 = 0;
for ii=1:121,
    for jj=1:121,
        
        if type_cell(ii,jj)==1 && lamina(ii,jj)>0 && internal_clock(ii,jj)==12,
            count1 = count1+1;
        end
        
    end
end
count1

count2 = 0;
for ii=1:121,
    for jj=1:121,
        
        if type_cell(ii,jj)==1 && lamina(ii,jj)==0,
            count2=count2+1;
        end
        
    end
end
count2

