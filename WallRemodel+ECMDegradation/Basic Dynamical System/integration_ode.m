% integration ode:
u=1; % basic speed

r=1; % lumen radius
R=1.2; % external radius
re=1.01; % IEL radius
p=1; % inlet pressure

c=0.3; % initial proportion of SMC
K=0.3; % differential of transmural pressure.


% computation of the Lame coefficient:
% material properties:
Young=2000;
Poisson=0.49;
lambda=Young*Poisson/((1+Poisson)*(1-2*Poisson));
mu=Young/(2*(1+Poisson));
% computation of initial displacement:
p1=p; p2=K*p; % should be invariant in fact
r1=r;r2=R;

r0=r; R0=R;

% constant for the stress distribution in the wall
cA=p1*r1^2/(r2^2-r1^2);
cB=p2*r2^2/(r2^2-r1^2);
% constant for the displacement assuming no dilatation in longitudinal direction:
C1=(cA-cB)/(lambda+mu);
C2=(p1-p2)/(r2^2-r1^2)*r1^2*r2^2/(2*mu); 
deltar=C1/2*r+C2/r; % displacement;
% 
sigma_r1=cA*(1-r2^2/r1^2);
sigma_a1=cA*(1+r2^2/r1^2);
sigma_r2=-cB*(1-r1^2/r2^2);
sigma_a2=-cB*(1+r1^2/r2^2);
balance_sigma=1/4*(sigma_r1+sigma_r2+sigma_a1+sigma_a2);
Energy0=sqrt(1/4*(sigma_r1^2+sigma_r2^2+sigma_a1^2+sigma_a2^2));
Energy0=0.5*(sigma_a1+sigma_a2);
A=(p1*r1^2-p2*r2^2)/(r2^2-r1^2); B=(p2-p1)*(r1^2*r2^2)/(r2^2-r1^2);
Energy0=A-B*(1/r1-1/r2)/(r2-r1);
clear r1 r2 A B

% new target is a lower flux by 10*du %:
F0=(r+deltar)^2*(u+du); % initial flux related constant

Asi=c*4*pi*(re^2-r^2);
Asi0=Asi;

Aei=(1-c)*4*pi*(re^2-r^2);
Aei0=Aei;

Asm=c*4*pi*(R^2-re^2);
Asm0=Asm;

Aem=(1-c)*4*pi*(R^2-re^2);
Aem0=Aem;


%%%%%%%%%%%%%%%%%%%%%%%%
%  tau-sigma objectif  %
%%%%%%%%%%%%%%%%%%%%%%%%

tau0=(1+tau_objective/100)*u/r;
sigma0=(1-sigma_objective/100)*Energy0;

arret=0; % stop criteria if one layer disapears.

for kt=1:maxT,
    if arret<1,
        T(kt,1)=kt*dt;
        Macro(kt)=0.01+exp(-((T(kt,1)-a(8))/a(9))^2);
        
        
        p1=p; p2=K*p; % should be invariant in fact
        r1=r;r2=R;

        % constant for the stress distribution in the wall
        cA=p1*r1^2/(r2^2-r1^2);
        cB=p2*r2^2/(r2^2-r1^2);
        % constant for the displacement assuming no dilatation in longitudinal direction:
        C1=(cA-cB)/(lambda+mu);
        C2=(p1-p2)/(r2^2-r1^2)*r1^2*r2^2/(2*mu);  
        deltar=C1/2*r+C2/r; % displacement;
        
        sigma_r1=cA*(1-r2^2/r1^2);
        sigma_a1=cA*(1+r2^2/r1^2);
        sigma_r2=-cB*(1-r1^2/r2^2);
        sigma_a2=-cB*(1+r1^2/r2^2);
        A=(p1*r1^2-p2*r2^2)/(r2^2-r1^2); B=(p2-p1)*(r1^2*r2^2)/(r2^2-r1^2);
        balance_sigma=1/4*(sigma_r1+sigma_r2+sigma_a1+sigma_a2);
        Energy=A-B*(1/r1-1/r2)/(r2-r1);
        clear r1 r2 A B
        
        dtau=(u+du)/(r+deltar)-tau0;
        dsigma=0.5*(Energy-sigma0);

        % dynamical system driven by tissue plasticity:
        dtau_moins=min(dtau,0);

            newAsi=Asi+dt*(-a(1)*Asi-a(5)*2*pi*re*(Asm/(Asm+Aem)))*dtau_moins;
            newAei=Aei+dt*(-a(2)*Asi*dtau);
            newAem=Aem+dt*a(3)*Asm*dsigma;
            newAsm=Asm+dt*(a(4)*Asm*dsigma+a(5)*2*pi*re*dtau_moins*(Asm/(Asm+Aem)));
            newR=R+dt*(a(6)*dtau+a(7)*dsigma);

            if newAsi<0, newAsi=0; end;
            if newAei<0, newAei=0; end;    
            if newAem<0, newAem=0; end;
            if newAsm<0, newAsm=0; end;

        
        newr=sqrt(newR^2-(newAei+newAsi+newAem+newAsm)/(4*pi));
        newre=sqrt(newR^2-(newAem+newAsm)/(4*pi));

        p1=p; p2=K*p; % should be invariant in fact
        r1=newr;r2=newR;

        % constant for the stress distribution in the wall
        cA=p1*r1^2/(r2^2-r1^2);
        cB=p2*r2^2/(r2^2-r1^2);
        % constant for the displacement assuming no dilatation in longitudinal direction:
        C1=(cA-cB)/(lambda+mu);
        C2=(p1-p2)/(r2^2-r1^2)*r1^2*r2^2/(2*mu); clear r1 r2
        newdeltar=C1/2*newr+C2/newr; % displacement;
        newdu=F0/(newr+newdeltar)^2-u;
      
        Asi=newAsi; Aei=newAei; Aem=newAem; Asm=newAsm; R=newR; r=newr; re=newre; du=newdu;

        if r<0.1,
            arret=1;
        end
        if R>5,
            arret=1;
        end
        
        if re>R | re<r,
            arret=2;
        end
        if r>R,
            arret=2;
        end

            hist(kt,1)=Asi; hist(kt,2)=Aei; hist(kt,3)=Aem; hist(kt,4)=Asm;
            hist(kt,5)=R; hist(kt,6)=r; hist(kt,7)=re; hist(kt,8)=du;
        end
    end
