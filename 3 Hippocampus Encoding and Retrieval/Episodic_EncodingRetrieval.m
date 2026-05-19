%% Network SIMULATION

% p = "pyramidal"
% e = "eccitatory"
% f = "fast inhibitory"
% s = "slow inihbitory"

% Noise standard deviation
sigma = sqrt(noise_powdens/dt);

% Subscript 0 = "mPFC"
np0 = randn(Npop,T)*sigma;
nf0 = randn(Npop,T)*sigma;

% Subscript 1 = "CA3"
np1 = randn(Npop,T)*sigma;
nt1 = randn(Npop,T)*sigma;
nf1 = randn(Npop,T)*sigma;

% Subscript 2 = "CA1"
np2 = randn(Npop,T)*sigma;
nf2 = randn(Npop,T)*sigma;

% Subscrip t = "MSDB"
npt = randn(1,T)*sigma;
nft = randn(1,T)*sigma;
nct = randn(1,T)*sigma;


%% Medial prefrontal cortex:

% Sigmoidal relationship (also applies to other Units)
e0 = 2.5; % saturation value
r = 0.56; % sigmoid slope (1/mv)
s0 = 12;  % center
                
a0 = ones(Npop,1)*[125 30 400]; % reciprocal of synaptic time constants (w: omega)

G = [5.17 4.45 57.1]; % synaptic gains

% Synaptic contacts between populations:
C0(:,1) = 54.;   % Cep
C0(:,2) = 54.;   % Cpe
C0(:,3) = 54.;   % Csp
C0(:,4) = 67.5;  % Cps   
C0(:,5) = 27.;   % Cfs
C0(:,6) = 108.;  % Cfp
C0(:,7) = 300.;  % Cpf
C0(:,8) = 10.;   % Cff


%% Medial Septum - vertical limb of the diagonal band of Broca:

at(1,:)=[90 25 300 atc]*w_at; % reciprocal of synaptic time constants (w)

% Synaptic contacts between populations:
Ct(1,1) = 54.*Kcep;    % Cep
Ct(1,2) = 54.*Kcpe;    % Cpe
Ct(1,3) = 54.*Kcsp;    % Csp
Ct(1,4) = 67.5*Kcps;   % Cps
Ct(1,5) = 15.*Kcfs;    % Cfs
Ct(1,6) = 81.*Kcfp;    % Cfp
Ct(1,7) = 300*Kcpf;    % Cpf
Ct(1,8) = 10.*Kcff;    % Cff
Ct(1,9) = 67.5*Kccf;   % Ccf

gain_theta = 100; % theta disinhibition gain on CA3


%% CA3 & CA1

a = ones(Npop,1)*[125 30 400*1]; % Reciprocal of synaptic time constants (w: omega) 

% Synaptic contacts between populations:
C(:,1) = 54.;   % Cep
C(:,2) = 54.;   % Cpe
C(:,3) = 54.;   % Csp
C(:,4) = 67.5;  % Cps   
C(:,5) = 27.;   % Cfs
C(:,6) = 108.;  % Cfp
C(:,7) = 300.;  % Cpf
C(:,8) = 10.;   % Cff


%% All variables initialised

% EC
yEC1 = zeros(Npop,T); % inputs from EC
yEC2 = zeros(Npop,T);

% Synapses
Wp_CA3CA3=zeros(Npop,Npop);
Wf_CA3CA3=zeros(Npop,Npop); 
Af_CA3CA3=zeros(Npop,Npop);
Wp_CA3CA1=zeros(Npop,Npop);

% mPFC:
yp0=zeros(Npop,T);
xp0=zeros(Npop,T);
vp0=zeros(Npop,T); 
zp0=zeros(Npop,T);

ye0=zeros(Npop,T);
xe0=zeros(Npop,T);
ve0=zeros(Npop,T);
ze0=zeros(Npop,T);

ys0=zeros(Npop,T);
xs0=zeros(Npop,T);
vs0=zeros(Npop,T);
zs0=zeros(Npop,T);

yf0=zeros(Npop,T);
xf0=zeros(Npop,T);
zf0=zeros(Npop,T);
vf0=zeros(Npop,T);

xl0=zeros(Npop,T);
yl0=zeros(Npop,T);

mf0=zeros(Npop,1);  % noise mean


% CA3:
yp1=zeros(Npop,T);
xp1=zeros(Npop,T);
vp1=zeros(Npop,T); 
zp1=zeros(Npop,T);

ye1=zeros(Npop,T);
xe1=zeros(Npop,T);
ve1=zeros(Npop,T);
ze1=zeros(Npop,T);

ys1=zeros(Npop,T);
xs1=zeros(Npop,T);
vs1=zeros(Npop,T);
zs1=zeros(Npop,T);

yf1=zeros(Npop,T);
xf1=zeros(Npop,T);
zf1=zeros(Npop,T);
vf1=zeros(Npop,T);

xl1=zeros(Npop,T);
yl1=zeros(Npop,T);

mf1=zeros(Npop,T);
mp1=zeros(Npop,T);


% CA1:
yp2=zeros(Npop,T);
xp2=zeros(Npop,T);
vp2=zeros(Npop,T); 
zp2=zeros(Npop,T);

ye2=zeros(Npop,T);
xe2=zeros(Npop,T);
ve2=zeros(Npop,T);
ze2=zeros(Npop,T);

ys2=zeros(Npop,T);
xs2=zeros(Npop,T);
vs2=zeros(Npop,T);
zs2=zeros(Npop,T);

yf2=zeros(Npop,T);
xf2=zeros(Npop,T);
zf2=zeros(Npop,T);
vf2=zeros(Npop,T);

xl2=zeros(Npop,T);
yl2=zeros(Npop,T);

mf2=zeros(Npop,T);
mp2=zeros(Npop,T);


% MSDB:
ypt=zeros(1,T);
xpt=zeros(1,T);
vpt=zeros(1,T); 
zpt=zeros(1,T);

yet=zeros(1,T);
xet=zeros(1,T);
vet=zeros(1,T);
zet=zeros(1,T);

yst=zeros(1,T);
xst=zeros(1,T);
vst=zeros(1,T);
zst=zeros(1,T);

yft=zeros(1,T);
xft=zeros(1,T);
vft=zeros(1,T);
zft=zeros(1,T);

yACht=zeros(1,T);
xct=zeros(1,T);
vct=zeros(1,T);
zct=zeros(1,T);

xlt=zeros(1,T);
ylt=zeros(1,T);

ACh=zeros(1,T);

xct=zeros(1,T);
yct=zeros(1,T); 

mpt=500;
mft=0;
mct=500;


%% Network simulation:

Wp_mPFCmPFC = zeros(Npop);
inhib1 = zeros(1,Npop);
disinhibt = zeros(1,Npop);

buff = 300; % buffer between episodes (30ms)


% 1st Seq

    % buffer for CA3
    INPUT_CA3=zeros(Npop,T);
    buff1=zeros(Npop,round(0.25/dt)); % 1st input for 250ms
    buff1(ep1,:)=1;
    INPUT_CA3(:,1500+round(Trand/dt)+1:4000+round(Trand/dt))=buff1;
    buff1=zeros(Npop,round(0.25/dt)); % 2nd input for 250ms
    buff1(ep2,:)=1;
    INPUT_CA3(:,4000+buff+round(Trand/dt)+1:6500+buff+round(Trand/dt))=buff1;
    buff1=zeros(Npop,round(0.25/dt)); % 3rd input for 250ms
    buff1(ep3,:)=1;
    INPUT_CA3(:,6500+2*buff+round(Trand/dt)+1:9000+2*buff+round(Trand/dt))=buff1;
    buff1=zeros(Npop,round(0.25/dt)); % 4th input for 250ms
    buff1(ep4,:)=1;
    INPUT_CA3(:,9000+3*buff+round(Trand/dt)+1:11500+3*buff+round(Trand/dt))=buff1;

    % buffer for CA1
    INPUT_CA1=zeros(Npop,T);
    buff2=zeros(Npop,round(0.25/dt)); % 1st input for 250ms
    buff2([],:)=1;
    INPUT_CA1(:,1500+round(Trand/dt)+1:4000+round(Trand/dt))=buff2;
    buff2=zeros(Npop,round(0.25/dt)); % 2nd input for 250ms
    buff2(ep1,:)=1;
    INPUT_CA1(:,4000+buff+round(Trand/dt)+1:6500+buff+round(Trand/dt))=buff2;
    buff2=zeros(Npop,round(0.25/dt)); % 3rd input for 250ms
    buff2(ep2,:)=1;
    INPUT_CA1(:,6500+2*buff+round(Trand/dt)+1:9000+2*buff+round(Trand/dt))=buff2;
    buff2=zeros(Npop,round(0.25/dt)); % 4th input for 250ms
    buff2(ep3,:)=1;
    INPUT_CA1(:,9000+3*buff+round(Trand/dt)+1:11500+3*buff+round(Trand/dt))=buff2;


% 2nd Seq

    % buffer for CA3
    buff1=zeros(Npop,round(0.25/dt)); % 1st input for 250ms
    buff1(ep5,:)=1;
    INPUT_CA3(:,12000+1500+round(Trand/dt)+1:12000+4000+round(Trand/dt))=buff1;
    buff1=zeros(Npop,round(0.25/dt)); % 2nd input for 250ms
    buff1(ep6,:)=1;
    INPUT_CA3(:,12000+4000+buff+round(Trand/dt)+1:12000+6500+buff+round(Trand/dt))=buff1;
    buff1=zeros(Npop,round(0.25/dt)); % 3rd input for 250ms
    buff1(ep7,:)=1;
    INPUT_CA3(:,12000+6500+2*buff+round(Trand/dt)+1:12000+9000+2*buff+round(Trand/dt))=buff1;
    buff1=zeros(Npop,round(0.25/dt)); % 4th input for 250ms
    buff1(ep8,:)=1;
    INPUT_CA3(:,12000+9000+3*buff+round(Trand/dt)+1:12000+11500+3*buff+round(Trand/dt))=buff1;

    % buffer for CA1
    buff2=zeros(Npop,round(0.25/dt)); % 1st input for 250ms
    buff2([],:)=1;
    INPUT_CA1(:,12000+1500+round(Trand/dt)+1:12000+4000+round(Trand/dt))=buff2;
    buff2=zeros(Npop,round(0.25/dt)); % 2nd input for 250ms
    buff2(ep5,:)=1;
    INPUT_CA1(:,12000+4000+buff+round(Trand/dt)+1:12000+6500+buff+round(Trand/dt))=buff2;
    buff2=zeros(Npop,round(0.25/dt)); % 3rd input for 250ms
    buff2(ep6,:)=1;
    INPUT_CA1(:,12000+6500+2*buff+round(Trand/dt)+1:12000+9000+2*buff+round(Trand/dt))=buff2;
    buff2=zeros(Npop,round(0.25/dt)); % 4th input for 250ms
    buff2(ep7,:)=1;
    INPUT_CA1(:,12000+9000+3*buff+round(Trand/dt)+1:12000+11500+3*buff+round(Trand/dt))=buff2;


% Input from EC (imposed in gamma rhythm-like oscillations at 40Hz)
sinusoidal = 2.5+2.5*sin(2*pi*f_enc*t);
sinusoidal = repmat(sinusoidal, Npop, 1);
yEC1(INPUT_CA3==1) = sinusoidal(INPUT_CA3==1);
yEC2(INPUT_CA1==1) = sinusoidal(INPUT_CA1==1);


for k=31:T-1 % ...from step 31 'cause synaptic traing

%     if k>25000

%     end
    
    % ACh binding
    ACh(k)=(yACht(:,k)^nc)./((kd^nc)+(yACht(:,k)^nc));
  
    mp1(:,k)=yEC1(:,k)*ACh(k)*2000;
    mf1(:,k)=yEC1(:,k)*ACh(k)*200;

    mp2(:,k)=yEC2(:,k)*ACh(k)*2000; 
    mf2(:,k)=yEC2(:,k)*ACh(k)*200;

    mp0=INPUT_mPFC(:,k)*5000;  

    if (sum(mp0)==0 && sum(INPUT_mPFC(:,k-1))>0) % if I stop receiving input...

        Wp_mPFCmPFC=diag(INPUT_mPFC(:,k-1))*w_mPFCmPFC; % I keep the last input 

    elseif  sum(mp0)~=0 % if the input is nonzero...

        Wp_mPFCmPFC=zeros(Npop); % I follow the input

    end

    up0=np0(:,k)+mp0;
    uf0=nf0(:,k)+mf0;

    up1=np1(:,k)+mp1(:,k);
    uf1=nf1(:,k)+mf1(:,k);
    
    up2=np2(:,k)+mp2(:,k);
    uf2=nf2(:,k)+mf2(:,k);

    upt=npt(1,k)+mpt;
    uft=nft(1,k)+mft; 
    uct=nct(1,k)+mct;


    for j = 1:Npop

        if k>D_mPFCCA3 % mPFC-CA3 interactions

            up1(j)=up1(j)+(1-ACh(k))*Wp_CA3mPFC(j,:)*zp0(:,k-D_mPFCCA3); % feedforward scheme

        end

        if k>D_intramPFC % mPFC-mPFC interactions

            up0(j)=up0(j)+Wp_mPFCmPFC(j,:)*zp0(:,k-D_intramPFC);
        
        end

        if k>D_intraCA3 % CA3-CA3 interactions
       
            up1(j)=up1(j)+(1-ACh(k))*Wp_CA3CA3(j,:)*zp1(:,k-D_intraCA3); % auto-associative network 
            uf1(j)=uf1(j)+(1-ACh(k))*Wf_CA3CA3(j,:)*zp1(:,k-D_intraCA3); 
            inhib1(j)=(1-ACh(k))*Af_CA3CA3(j,:)*zp1(:,k-D_intraCA3);

        end

        if k>D_MSDBCA3 % MSDB-CA3 interactions

            disinhibt(j)=(1-ACh(k))*gain_theta*(zpt (k-D_MSDBCA3)-5); % disinhibition from MSDB
            up1(j)=up1(j)+disinhibt(j);
                
        end
        
        if k>D_CA1CA3 % CA1-CA3 interactions

            up1(j)=up1(j)+(1-ACh(k))*Wp_CA3CA1(j,:)*zp2(:,k-D_CA3CA1); % hetero-associative network
            up2(j)=up2(j)+(1-ACh(k))*Wp_CA1CA3(j,:)*zp1(:,k-D_CA1CA3); % feedforward scheme

        end
        
    end
    
    % mPFC average post-synaptic membrane potentials:
    vp0(:,k)=C0(:,2).*ye0(:,k)-C0(:,4).*ys0(:,k)-C0(:,7).*yf0(:,k);
    ve0(:,k)=C0(:,1).*yp0(:,k);
    vs0(:,k)=C0(:,3).*yp0(:,k);
    vf0(:,k)=C0(:,6).*yp0(:,k)-C0(:,5).*ys0(:,k)-C0(:,8).*yf0(:,k)+yl0(:,k);
    % mPFC average spike density:
    zp0(:,k)=2*e0./(1+exp(-r*(vp0(:,k)-s0))); 
    ze0(:,k)=2*e0./(1+exp(-r*(ve0(:,k)-s0)));
    zs0(:,k)=2*e0./(1+exp(-r*(vs0(:,k)-s0)));
    zf0(:,k)=2*e0./(1+exp(-r*(vf0(:,k)-s0)));
    % mPFC post synaptic potential change for PYRAMIDAL neurons:
    xp0(:,k+1)=xp0(:,k)+(G(1)*a0(:,1).*zp0(:,k)-2*a0(:,1).*xp0(:,k)-a0(:,1).*a0(1).*yp0(:,k))*dt;
    yp0(:,k+1)=yp0(:,k)+xp0(:,k)*dt;
    % mPFC post synaptic potential change for EXCITATORY interneurons:
    xe0(:,k+1)=xe0(:,k)+(G(1)*a0(:,1).*(ze0(:,k)+up0(:)./C0(:,2))-2*a0(:,1).*xe0(:,k)-a0(:,1).*a0(:,1).*ye0(:,k))*dt;
    ye0(:,k+1)=ye0(:,k)+xe0(:,k)*dt;
    % mPFC post synaptic potential change for SLOW INHIBITORY interneurons:
    xs0(:,k+1)=xs0(:,k)+(G(2)*a0(:,2).*zs0(:,k)-2*a0(:,2).*xs0(:,k)-a0(2).*a0(:,2).*ys0(:,k))*dt;
    ys0(:,k+1)=ys0(:,k)+xs0(:,k)*dt;
    % mPFC post synaptic potential change for FAST INHIBITORY interneurons:
    xl0(:,k+1)=xl0(:,k)+(G(1)*a0(:,1).*uf0(:)-2*a0(:,1).*xl0(:,k)-a0(:,1).*a0(:,1).*yl0(:,k))*dt;
    yl0(:,k+1)=yl0(:,k)+xl0(:,k)*dt;
    xf0(:,k+1)=xf0(:,k)+(G(3)*a0(:,3).*zf0(:,k)-2*a0(:,3).*xf0(:,k)-a0(:,3).*a0(:,3).*yf0(:,k))*dt;
    yf0(:,k+1)=yf0(:,k)+xf0(:,k)*dt; 

    % CA3 average post-synaptic membrane potentials:
    vp1(:,k)=C(:,2).*ye1(:,k)-C(:,4).*ys1(:,k)-C(:,7).*yf1(:,k);
    ve1(:,k)=C(:,1).*yp1(:,k);
    vs1(:,k)=C(:,3).*yp1(:,k);
    vf1(:,k)=C(:,6).*yp1(:,k)-C(:,5).*ys1(:,k)-C(:,8).*yf1(:,k)+yl1(:,k)+inhib1'; % "inhib1" has a much faster dynamic than other synapses
    % CA3 average spike density:
    zp1(:,k)=2*e0./(1+exp(-r*(vp1(:,k)-s0))); 
    ze1(:,k)=2*e0./(1+exp(-r*(ve1(:,k)-s0)));
    zs1(:,k)=2*e0./(1+exp(-r*(vs1(:,k)-s0)));
    zf1(:,k)=2*e0./(1+exp(-r*(vf1(:,k)-s0)));
    % CA3 post synaptic potential change for PYRAMIDAL neurons:
    xp1(:,k+1)=xp1(:,k)+(G(1)*a(:,1).*zp1(:,k)-2*a(:,1).*xp1(:,k)-a(:,1).*a(:,1).*yp1(:,k))*dt;
    yp1(:,k+1)=yp1(:,k)+xp1(:,k)*dt; 
    % CA3 post synaptic potential change for EXCITATORY interneurons:
    xe1(:,k+1)=xe1(:,k)+(G(1)*a(:,1).*(ze1(:,k)+up1(:)./C(:,2))-2*a(:,1).*xe1(:,k)-a(:,1).*a(:,1).*ye1(:,k))*dt;
    ye1(:,k+1)=ye1(:,k)+xe1(:,k)*dt; 
    % CA3 post synaptic potential change for SLOW INHIBITORY interneurons:
    xs1(:,k+1)=xs1(:,k)+(G(2)*a(:,2).*zs1(:,k)-2*a(:,2).*xs1(:,k)-a(:,2).*a(:,2).*ys1(:,k))*dt;
    ys1(:,k+1)=ys1(:,k)+xs1(:,k)*dt; 
    % CA3 post synaptic potential change for FAST INHIBITORY interneurons:
    xl1(:,k+1)=xl1(:,k)+(G(1)*a(:,1).*uf1(:)-2*a(:,1).*xl1(:,k)-a(:,1).*a(:,1).*yl1(:,k))*dt;
    yl1(:,k+1)=yl1(:,k)+xl1(:,k)*dt; 
    xf1(:,k+1)=xf1(:,k)+(G(3)*a(:,3).*zf1(:,k)-2*a(:,3).*xf1(:,k)-a(:,3).*a(:,3).*yf1(:,k))*dt;  
    yf1(:,k+1)=yf1(:,k)+xf1(:,k)*dt; 

    % CA1 average post-synaptic membrane potentials:
    vp2(:,k)=C(:,2).*ye2(:,k)-C(:,4).*ys2(:,k)-C(:,7).*yf2(:,k);
    ve2(:,k)=C(:,1).*yp2(:,k);
    vs2(:,k)=C(:,3).*yp2(:,k);
    vf2(:,k)=C(:,6).*yp2(:,k)-C(:,5).*ys2(:,k)-C(:,8).*yf2(:,k)+yl2(:,k);
    % CA1 average spike density:
    zp2(:,k)=2*e0./(1+exp(-r*(vp2(:,k)-s0))); 
    ze2(:,k)=2*e0./(1+exp(-r*(ve2(:,k)-s0)));
    zs2(:,k)=2*e0./(1+exp(-r*(vs2(:,k)-s0)));
    zf2(:,k)=2*e0./(1+exp(-r*(vf2(:,k)-s0)));
    % CA1 post synaptic potential change for PYRAMIDAL neurons:
    xp2(:,k+1)=xp2(:,k)+(G(1)*a(:,1).*zp2(:,k)-2*a(:,1).*xp2(:,k)-a(:,1).*a(:,1).*yp2(:,k))*dt;
    yp2(:,k+1)=yp2(:,k)+xp2(:,k)*dt; 
    % CA1 post synaptic potential change for EXCITATORY interneurons:
    xe2(:,k+1)=xe2(:,k)+(G(1)*a(:,1).*(ze2(:,k)+up2(:)./C(:,2))-2*a(:,1).*xe2(:,k)-a(:,1).*a(:,1).*ye2(:,k))*dt;
    ye2(:,k+1)=ye2(:,k)+xe2(:,k)*dt; 
    % CA1 post synaptic potential change for SLOW INHIBITORY interneurons:
    xs2(:,k+1)=xs2(:,k)+(G(2)*a(:,2).*zs2(:,k)-2*a(:,2).*xs2(:,k)-a(:,2).*a(:,2).*ys2(:,k))*dt;
    ys2(:,k+1)=ys2(:,k)+xs2(:,k)*dt; 
    % CA1 post synaptic potential change for FAST INHIBITORY interneurons:
    xl2(:,k+1)=xl2(:,k)+(G(1)*a(:,1).*uf2(:)-2*a(:,1).*xl2(:,k)-a(:,1).*a(:,1).*yl2(:,k))*dt; 
    yl2(:,k+1)=yl2(:,k)+xl2(:,k)*dt; 
    xf2(:,k+1)=xf2(:,k)+(G(3)*a(:,3).*zf2(:,k)-2*a(:,3).*xf2(:,k)-a(:,3).*a(:,3).*yf2(:,k))*dt;
    yf2(:,k+1)=yf2(:,k)+xf2(:,k)*dt; 
    
    % MSDB average post-synaptic membrane potentials:
    vpt(:,k)=Ct(:,2).*yet(:,k)-Ct(:,4).*yst(:,k)-Ct(:,7).*yft(:,k);
    vet(:,k)=Ct(:,1).*ypt(:,k);
    vst(:,k)=Ct(:,3).*ypt(:,k);
    vct(:,k)=yct(:,k)-Ct(:,9).*yft(:,k);
    vft(:,k)=Ct(:,6).*ypt(:,k)-Ct(:,5).*yst(:,k)-Ct(:,8).*yft(:,k)+ylt(:,k);
    % MSDB average spike density:
    zpt(:,k)=2*e0./(1+exp(-r*(vpt(:,k)-s0)));
    zct(:,k)=2*e0./(1+exp(-r*(vct(:,k)-s0)));
    zet(:,k)=2*e0./(1+exp(-r*(vet(:,k)-s0)));
    zst(:,k)=2*e0./(1+exp(-r*(vst(:,k)-s0)));
    zft(:,k)=2*e0./(1+exp(-r*(vft(:,k)-s0)));
    % MSDB post synaptic potential change for PYRAMIDAL neurons:
    xpt(:,k+1)=xpt(:,k)+(G(1)*at(1).*zpt(:,k)-2*at(1).*xpt(:,k)-at(1).*at(1).*ypt(:,k))*dt;
    ypt(:,k+1)=ypt(:,k)+xpt(:,k)*dt;
    % MSDB post synaptic potential change for EXCITATORY interneurons:
    xet(:,k+1)=xet(:,k)+(G(1)*at(1).*(zet(:,k)+upt(:)./Ct(2))-2*at(1).*xet(:,k)-at(1).*at(1).*yet(:,k))*dt;
    yet(:,k+1)=yet(:,k)+xet(:,k)*dt; 
    % MSDB post synaptic potential change for SLOW INHIBITORY interneurons:
    xst(:,k+1)=xst(:,k)+(G(2)*at(2).*zst(:,k)-2*at(2).*xst(:,k)-at(2).*at(2).*yst(:,k))*dt;
    yst(:,k+1)=yst(:,k)+xst(:,k)*dt;
    % MSDB post synaptic potential change for FAST INHIBITORY interneurons:
    xlt(:,k+1)=xlt(:,k)+(G(1)*at(1).*uft(:)-2*at(1).*xlt(:,k)-at(1).*at(1).*ylt(:,k))*dt; 
    ylt(:,k+1)=ylt(:,k)+xlt(:,k)*dt; 
    xft(:,k+1)=xft(:,k)+(G(3)*at(3).*zft(:,k)-2*at(3).*xft(:,k)-at(3).*at(3).*yft(:,k))*dt;  
    yft(:,k+1)=yft(:,k)+xft(:,k)*dt;
    % MSDB post synaptic potential change for CHOLINERGIC neurons:
    xct(:,k+1)=xct(:,k)+(G(1)*at(:,1).*uct(:)-2*at(:,1).*xct(:,k)-at(:,1).*at(:,1).*yct(:,k))*dt; % "IN"put coming from the external
    yct(:,k+1)=yct(:,k)+xct(:,k)*dt; 

    % MSDB-mediated ACh synthesis
    yACht(:,k+1)=yACht(:,k)+(at(4).*(-yACht(:,k)+zct(:,k)))*dt; % 1st order dynamics

    
    % Synaptic training

    % Wp_CA3CA3
    mean_zp1 = mean(zp1(:,k-30:k-1),2); % mean over the previous 30 ms
    ATT_PREw=(mean_zp1/(2*e0)-thresh_low_Wp_CA3CA3)';
    ATT_PREw(ATT_PREw<0)=0;
    ATT_POSTw=(mean_zp1/(2*e0)-thresh_low_Wp_CA3CA3);
    ATT_POSTw(ATT_POSTw<0)=0;
    WEIGHT_w=(Wp_CA3CA3_max - Wp_CA3CA3).*(ones(Npop,Npop)-eye(Npop));
    Wp_CA3CA3 = Wp_CA3CA3 + (ACh(k)-0)*gammaWp_CA3CA3.*(ATT_POSTw * ATT_PREw) .* WEIGHT_w;

    % Wf_CA3CA3
    mean_zf1 = mean(zf1(:,k-30:k-1),2);
    ATT_PREk=(mean_zp1/(2*e0) - thresh_low_Wf)';
    ATT_PREk(ATT_PREk<0)=0;
    ATT_POSTk=(mean_zf1/(2*e0)-thresh_low_Wf);
    ATT_POSTk(ATT_POSTk<0)=0;
    WEIGHT_k=(Wf_CA3CA3_max - Wf_CA3CA3).*(ones(Npop, Npop)-eye(Npop));
    Wf_CA3CA3 = Wf_CA3CA3 + (ACh(k)-0)*gammaWf.*(ATT_POSTk * ATT_PREk) .* WEIGHT_k;
    
    % Af_CA3CA3
    ATT_PREk=(mean_zp1/(2*e0) - thresh_low_Wf)';
    ATT_PREk(ATT_PREk<0)=0;
    ATT_POSTa=(thresh_up-mean_zf1/(2*e0));
    ATT_POSTa(ATT_POSTa<0)=0;
    WEIGHT_a=(Af_CA3CA3_max - Af_CA3CA3).*(ones(Npop, Npop)-eye(Npop));
    Af_CA3CA3 = Af_CA3CA3 + (ACh(k)-0)*gammaAf.*(ATT_POSTa * ATT_PREk) .* WEIGHT_a;

    % Wp_CA3CA1
    mean_zp2 = mean(zp2(:,k-30:k-1),2);
    ATT_PRE=(mean_zp2/(2*e0) - thresh_low_Wp_CA3CA1)';
    ATT_PRE(ATT_PRE<0)=0;
    ATT_POST=(mean_zp1/(2*e0)-thresh_low_Wp_CA3CA1);
    ATT_POST(ATT_POST<0)=0;
    WEIGHT=(Wp_CA3CA1_max - Wp_CA3CA1).*(ones(Npop,Npop)-eye(Npop));
    Wp_CA3CA1 = Wp_CA3CA1 + (ACh(k)-0)*gammaWp_CA3CA1.*(ATT_POST*ATT_PRE).*WEIGHT;


    % Synapse normalisation
    for i=1:Npop
        S=sum(Wf_CA3CA3(i,:),2);
        if S>MAXSUM_Wf_CA3CA3
            Wf_CA3CA3(i,:)=Wf_CA3CA3(i,:).*(MAXSUM_Wf_CA3CA3/S);
        end
        S=sum(Af_CA3CA3(i,:),2);
        if S>MAXSUM_Af_CA3CA3
            Af_CA3CA3(i,:)=Af_CA3CA3(i,:).*(MAXSUM_Af_CA3CA3/S);
        end
        S=sum(Wp_CA3CA3(i,:),2);
        if S>MAXSUM_Wp_CA3CA3
            Wp_CA3CA3(i,:)=Wp_CA3CA3(i,:).*(MAXSUM_Wp_CA3CA3/S);
        end
        S=sum(Wp_CA3CA1(i,:),2);
        if S>MAXSUM_Wp_CA3CA1
            Wp_CA3CA1(i,:)=Wp_CA3CA1(i,:).*(MAXSUM_Wp_CA3CA1/S);
        end
    end


end

