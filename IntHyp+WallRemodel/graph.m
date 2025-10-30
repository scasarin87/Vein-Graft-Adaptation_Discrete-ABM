hold on
%figure
for j=1:Nx,
    for k=1:Ny,
        distance=sqrt((X(j,k)-Cx)^2+(Y(j,k)-Cy)^2);
        if type_cell(j,k)==2,
             plot(X(j,k),Y(j,k),'c.');
        end
        if type_cell(j,k)==1,
            plot(X(j,k),Y(j,k),'g.');
        end
        if type_cell(j,k)==0,
            plot(X(j,k),Y(j,k),'w.');
        end
        if round(distance-IEL_radius)==0
            plot(X(j,k),Y(j,k),'b.');
        end
        if external_support(j,k)==1,
            plot(X(j,k),Y(j,k),'y.');
        end
        if lumen_hole(j,k)==1,
             lamina_check=0;
             if mod(k,2)==0,
                j_k=2;
             else
                j_k=1;
             end
             liste=zeros(6,2);
             for n=1:6, % look for empty neighbor sites.
                j3=j+directionx(n,j_k); k3=k+directiony(n);
                if(lamina(j3,k3)==0)
                    lamina_check=1;
                end
             end  
             if lamina_check==0
                plot(X(j,k),Y(j,k),'r.')
             else
                plot(X(j,k),Y(j,k),'g.') 
             end
        end
    end
end

title('CA');
xlabel('X_j');
ylabel('Y_k');
axis equal;

hold off




