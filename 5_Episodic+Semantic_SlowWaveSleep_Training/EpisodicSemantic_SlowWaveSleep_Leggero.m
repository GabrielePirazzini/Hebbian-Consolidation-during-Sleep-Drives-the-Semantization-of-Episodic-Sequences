%% Network SIMULATION

% p = "pyramidal"
% e = "eccitatory"
% f = "fast inhibitory"
% s = "slow inihbitory"


% Noise standard deviation
sigma = sqrt(noise_powdens/dt);

% Subscript 0 = "mPFC"
np0 = randn(Npop_EP,1)*sigma;
nf0 = randn(Npop_EP,1)*sigma;

% Subscript 1 = "CA3"
np1 = randn(Npop_EP,1)*sigma;
nt1 = randn(Npop_EP,1)*sigma;
nf1 = randn(Npop_EP,1)*sigma;

% Subscript 2 = "CA1"
np2 = randn(Npop_EP,1)*sigma;
nf2 = randn(Npop_EP,1)*sigma;

% Subscrip t = "MSDB"
npt = randn(1,1)*sigma;
nft = randn(1,1)*sigma;
nct = randn(1,1)*sigma;

% Subscrip c = "CORTEX"
npc = randn(Npop_SEM,1)*sigma;
nfc = randn(Npop_SEM,1)*sigma;
      

%% Medial prefrontal cortex:

% Sigmoidal relationship (also applies to other Units)
e0 = 2.5; % saturation value
r = 0.56; % sigmoid slope (1/mv)
s0 = 12;  % center
                
a0 = ones(Npop_EP,1)*[125 30 300]; % reciprocal of synaptic time constants (w: omega)

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

a = ones(Npop_EP,1)*[125 30 300*1]; % Reciprocal of synaptic time constants (w: omega) 

% Synaptic contacts between populations:
Cc(:,1) = 54.;   % Cep
Cc(:,2) = 54.;   % Cpe
Cc(:,3) = 54.;   % Csp
Cc(:,4) = 67.5;  % Cps   
Cc(:,5) = 27.;   % Cfs
Cc(:,6) = 108.;  % Cfp
Cc(:,7) = 300.;  % Cpf
Cc(:,8) = 10.;   % Cff


%% Cortex:

ac = ones(Npop_SEM,1)*[125 30 300]; % Reciprocal of synaptic time constants (w: omega) 

% Synaptic contacts between populations:
C = zeros(Npop_SEM,8);
C(:,1) = 54.;   % Cep
C(:,2) = 54.;   % Cpe
C(:,3) = 54.;   % Csp
C(:,4) = 67.5;  % Cps
C(:,5) = 27.;   % Cfs
C(:,6) = 108.;  % Cfp
C(:,7) = 300.;  % Cpf
C(:,8) = 10.;   % Cff


%% Semantic:

tau = 0.001;    % time constants (1 ms)
phix=0.55;      % offset
Ts=0.01;         % sigmoid slope
I = zeros(Npop_SEM,1);
N_obj = 34;
Sl = zeros(N_obj,1);

tau_d = 0.03; %0.036
alpha_d = 1/tau_d;
beta_d = 6*alpha_d; % 4.8 ORIGINAL

%% Linguistic
phix_l=3.5; 

%% All variables initialised

% EC
yEC1 = zeros(Npop_EP,T); % inputs from EC
yEC2 = zeros(Npop_EP,T);


% mPFC:
yp0=zeros(Npop_EP,1);
xp0=zeros(Npop_EP,1);
vp0=zeros(Npop_EP,1); 
zp0=zeros(Npop_EP,T);

ye0=zeros(Npop_EP,1);
xe0=zeros(Npop_EP,1);
ve0=zeros(Npop_EP,1);
ze0=zeros(Npop_EP,T);

ys0=zeros(Npop_EP,1);
xs0=zeros(Npop_EP,1);
vs0=zeros(Npop_EP,1);
zs0=zeros(Npop_EP,T);

yf0=zeros(Npop_EP,1);
xf0=zeros(Npop_EP,1);
zf0=zeros(Npop_EP,T);
vf0=zeros(Npop_EP,1);

xl0=zeros(Npop_EP,1);
yl0=zeros(Npop_EP,1);

mf0=zeros(Npop_EP,1);  % noise mean


% CA3:
yp1=zeros(Npop_EP,1);
xp1=zeros(Npop_EP,1);
vp1=zeros(Npop_EP,1); 
zp1=zeros(Npop_EP,T);

ye1=zeros(Npop_EP,1);
xe1=zeros(Npop_EP,1);
ve1=zeros(Npop_EP,1);
ze1=zeros(Npop_EP,T);

ys1=zeros(Npop_EP,1);
xs1=zeros(Npop_EP,1);
vs1=zeros(Npop_EP,1);
zs1=zeros(Npop_EP,T);

yf1=zeros(Npop_EP,1);
xf1=zeros(Npop_EP,1);
zf1=zeros(Npop_EP,T);
vf1=zeros(Npop_EP,1);

xl1=zeros(Npop_EP,1);
yl1=zeros(Npop_EP,1);

mf1=zeros(Npop_EP,T);
mp1=zeros(Npop_EP,T);


% CA1:
yp2=zeros(Npop_EP,1);
xp2=zeros(Npop_EP,1);
vp2=zeros(Npop_EP,1); 
zp2=zeros(Npop_EP,T);

ye2=zeros(Npop_EP,1);
xe2=zeros(Npop_EP,1);
ve2=zeros(Npop_EP,1);
ze2=zeros(Npop_EP,T);

ys2=zeros(Npop_EP,1);
xs2=zeros(Npop_EP,1);
vs2=zeros(Npop_EP,1);
zs2=zeros(Npop_EP,T);

yf2=zeros(Npop_EP,1);
xf2=zeros(Npop_EP,1);
zf2=zeros(Npop_EP,T);
vf2=zeros(Npop_EP,1);

xl2=zeros(Npop_EP,1);
yl2=zeros(Npop_EP,1);

mf2=zeros(Npop_EP,T);
mp2=zeros(Npop_EP,T);


% MSDB:
ypt=zeros(1,1);
xpt=zeros(1,1);
vpt=zeros(1,1); 
zpt=zeros(1,T);

yet=zeros(1,1);
xet=zeros(1,1);
vet=zeros(1,1);
zet=zeros(1,T);

yst=zeros(1,1);
xst=zeros(1,1);
vst=zeros(1,1);
zst=zeros(1,T);

yft=zeros(1,1);
xft=zeros(1,1);
vft=zeros(1,1);
zft=zeros(1,T);

yACht=zeros(1,T);
xct=zeros(1,1);
vct=zeros(1,1);
zct=zeros(1,1);

xlt=zeros(1,1);
ylt=zeros(1,1);

ACh=zeros(1,T);

xct=zeros(1,1);
yct=zeros(1,1); 

mpt=500;
mft=0;
mct=500;


% CORTEX:

ypc = zeros(Npop_SEM,1);
xpc = zeros(Npop_SEM,1);
vpc = zeros(Npop_SEM,1);
zpc = zeros(Npop_SEM,T);

yec = zeros(Npop_SEM,1);
xec = zeros(Npop_SEM,1);
vec = zeros(Npop_SEM,1);
zec = zeros(Npop_SEM,T);

ysc = zeros(Npop_SEM,1);
xsc = zeros(Npop_SEM,1);
vsc = zeros(Npop_SEM,1);
zsc = zeros(Npop_SEM,T);

yfc = zeros(Npop_SEM,1);
xfc = zeros(Npop_SEM,1);
zfc = zeros(Npop_SEM,T);
vfc = zeros(Npop_SEM,1);

xlc = zeros(Npop_SEM,1);
ylc = zeros(Npop_SEM,1);

mpc=zeros(Npop_SEM,T);


% SEMANTIC:

xs=zeros(Npop_SEM,T);     
Depletion=ones(Npop_SEM,T);

% LINGUISTIC:
N_obj=34;
xl=zeros(N_obj,T);

%% Network simulation:

Wp_mPFCmPFC = zeros(Npop_EP);
inhib1 = zeros(1,Npop_EP);
disinhibt = zeros(1,Npop_EP);

for k=2:T-1
    if k/1000==round(k/1000)
        disp(k/1000*0.1)
    end
    
    % ACh binding
    ACh(k)=(yACht(:,k)^nc)./((kd^nc)+(yACht(:,k)^nc));
  
    mp1(:,k)=yEC1(:,k)*ACh(k)*2000+mediaIN(:,k);
    mf1(:,k)=yEC1(:,k)*ACh(k)*200;

    mp2(:,k)=yEC2(:,k)*ACh(k)*2000; 
    mf2(:,k)=yEC2(:,k)*ACh(k)*200;

    mp0=INPUT_mPFC(:,k)*5000;  

    if (sum(mp0)==0 && sum(INPUT_mPFC(:,k-1))>0) % if I stop receiving input...

        Wp_mPFCmPFC=diag(INPUT_mPFC(:,k-1))*w_mPFCmPFC; % I keep the last input 

    elseif  sum(mp0)~=0 % if the input is nonzero...

        Wp_mPFCmPFC=zeros(Npop_EP); % I follow the input

    end

    up0=np0+mp0;
    uf0=nf0+mf0;

    up1=np1+mp1(:,k);
    uf1=nf1+mf1(:,k);
    
    up2=np2+mp2(:,k);
    uf2=nf2+mf2(:,k);

    upt=npt+mpt;
    uft=nft+mft; 
    uct=nct+mct;

    upc = npc+mpc(:,k);
    ufc = nfc;


    for j = 1:Npop_EP

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

            disinhibt(j)=(1-ACh(k))*gain_theta*(zpt(k-D_MSDBCA3)-5); % disinhibition from MSDB
            up1(j)=up1(j)+disinhibt(j);
                
        end
        
        if k>D_CA1CA3 % CA1-CA3 interactions

            up1(j)=up1(j)+(1-ACh(k))*Wp_CA3CA1(j,:)*zp2(:,k-D_CA3CA1); % hetero-associative network
            up2(j)=up2(j)+(1-ACh(k))*Wp_CA1CA3(j,:)*zp1(:,k-D_CA1CA3); % feedforward scheme

        end

        if k>D_CORTEXCA3 && j<=Npop_SEM % CA3-Cortex interactions

            upc(j)=upc(j)+Wp_CORTEXCA3(j,:)*zp2(:,k-D_CORTEXCA3); % sparse connectivity CA3-->Cortex (ACh modulation here?)

        end

        if k>D_CORTEXSEM % Semantic-Cortex interactions

        end

    end
    
    % mPFC average post-synaptic membrane potentials:
    vp0=C0(:,2).*ye0-C0(:,4).*ys0-C0(:,7).*yf0;
    ve0=C0(:,1).*yp0;
    vs0=C0(:,3).*yp0;
    vf0=C0(:,6).*yp0-C0(:,5).*ys0-C0(:,8).*yf0+yl0;
    % mPFC average spike density:
    zp0(:,k)=2*e0./(1+exp(-r*(vp0-s0))); 
    ze0(:,k)=2*e0./(1+exp(-r*(ve0-s0)));
    zs0(:,k)=2*e0./(1+exp(-r*(vs0-s0)));
    zf0(:,k)=2*e0./(1+exp(-r*(vf0-s0)));
    % mPFC post synaptic potential change for PYRAMIDAL neurons:
    xp0_k=xp0;
    yp0_k=yp0;
    xp0=xp0_k+(G(1)*a0(:,1).*zp0(:,k)-2*a0(:,1).*xp0_k-a0(:,1).*a0(1).*yp0_k)*dt;
    yp0=yp0_k+xp0_k*dt;
    % mPFC post synaptic potential change for EXCITATORY interneurons:
    xe0_k=xe0;
    ye0_k=ye0;
    xe0=xe0_k+(G(1)*a0(:,1).*(ze0(:,k)+up0(:)./C0(:,2))-2*a0(:,1).*xe0_k-a0(:,1).*a0(:,1).*ye0_k)*dt;
    ye0=ye0_k+xe0_k*dt;
    % mPFC post synaptic potential change for SLOW INHIBITORY interneurons:
    xs0_k=xs0;
    ys0_k=ys0;
    xs0=xs0_k+(G(2)*a0(:,2).*zs0(:,k)-2*a0(:,2).*xs0_k-a0(2).*a0(:,2).*ys0_k)*dt;
    ys0=ys0_k+xs0_k*dt;
    % mPFC post synaptic potential change for FAST INHIBITORY interneurons:
    xl0_k=xl0;
    yl0_k=yl0;
    xf0_k=xf0;
    yf0_k=yf0;
    xl0=xl0_k+(G(1)*a0(:,1).*uf0(:)-2*a0(:,1).*xl0_k-a0(:,1).*a0(:,1).*yl0_k)*dt;
    yl0=yl0_k+xl0_k*dt;
    xf0=xf0_k+(G(3)*a0(:,3).*zf0(:,k)-2*a0(:,3).*xf0_k-a0(:,3).*a0(:,3).*yf0_k)*dt;
    yf0=yf0_k+xf0_k*dt; 

    % CA3 average post-synaptic membrane potentials:
    vp1=Cc(:,2).*ye1-Cc(:,4).*ys1-Cc(:,7).*yf1;
    ve1=Cc(:,1).*yp1;
    vs1=Cc(:,3).*yp1;
    vf1=Cc(:,6).*yp1-Cc(:,5).*ys1-Cc(:,8).*yf1+yl1+inhib1'; % "inhib1" has a much faster dynamic than other synapses
    % CA3 average spike density:
    zp1(:,k)=2*e0./(1+exp(-r*(vp1-s0))); 
    ze1(:,k)=2*e0./(1+exp(-r*(ve1-s0)));
    zs1(:,k)=2*e0./(1+exp(-r*(vs1-s0)));
    zf1(:,k)=2*e0./(1+exp(-r*(vf1-s0)));
    % CA3 post synaptic potential change for PYRAMIDAL neurons:
    xp1_k=xp1;
    yp1_k=yp1;
    xe1_k=xe1;
    ye1_k=ye1;
    xs1_k=xs1;
    ys1_k=ys1;
    xl1_k=xl1;
    yl1_k=yl1;
    xf1_k=xf1;
    yf1_k=yf1;
    xp1=xp1_k+(G(1)*a(:,1).*zp1(:,k)-2*a(:,1).*xp1_k-a(:,1).*a(:,1).*yp1_k)*dt;
    yp1=yp1_k+xp1_k*dt; 
    % CA3 post synaptic potential change for EXCITATORY interneurons:
    xe1=xe1_k+(G(1)*a(:,1).*(ze1(:,k)+up1(:)./Cc(:,2))-2*a(:,1).*xe1_k-a(:,1).*a(:,1).*ye1_k)*dt;
    ye1=ye1_k+xe1_k*dt; 
    % CA3 post synaptic potential change for SLOW INHIBITORY interneurons:
    xs1=xs1_k+(G(2)*a(:,2).*zs1(:,k)-2*a(:,2).*xs1_k-a(:,2).*a(:,2).*ys1_k)*dt;
    ys1=ys1_k+xs1_k*dt; 
    % CA3 post synaptic potential change for FAST INHIBITORY interneurons:
    xl1=xl1_k+(G(1)*a(:,1).*uf1(:)-2*a(:,1).*xl1_k-a(:,1).*a(:,1).*yl1_k)*dt;
    yl1=yl1_k+xl1_k*dt; 
    xf1=xf1_k+(G(3)*a(:,3).*zf1(:,k)-2*a(:,3).*xf1_k-a(:,3).*a(:,3).*yf1_k)*dt;  
    yf1=yf1_k+xf1_k*dt; 

    % CA1 average post-synaptic membrane potentials:
    vp2=Cc(:,2).*ye2-Cc(:,4).*ys2-Cc(:,7).*yf2;
    ve2=Cc(:,1).*yp2;
    vs2=Cc(:,3).*yp2;
    vf2=Cc(:,6).*yp2-Cc(:,5).*ys2-Cc(:,8).*yf2+yl2;
    % CA1 average spike density:
    zp2(:,k)=2*e0./(1+exp(-r*(vp2-s0))); 
    ze2(:,k)=2*e0./(1+exp(-r*(ve2-s0)));
    zs2(:,k)=2*e0./(1+exp(-r*(vs2-s0)));
    zf2(:,k)=2*e0./(1+exp(-r*(vf2-s0)));
    % CA1 post synaptic potential change for PYRAMIDAL neurons:
    xp2_k=xp2;
    yp2_k=yp2;
    xe2_k=xe2;
    ye2_k=ye2;
    xs2_k=xs2;
    ys2_k=ys2;
    xl2_k=xl2;
    yl2_k=yl2;
    xf2_k=xf2;
    yf2_k=yf2;
    xp2=xp2_k+(G(1)*a(:,1).*zp2(:,k)-2*a(:,1).*xp2_k-a(:,1).*a(:,1).*yp2_k)*dt;
    yp2=yp2_k+xp2_k*dt; 
    % CA1 post synaptic potential change for EXCITATORY interneurons:
    xe2=xe2_k+(G(1)*a(:,1).*(ze2(:,k)+up2(:)./Cc(:,2))-2*a(:,1).*xe2_k-a(:,1).*a(:,1).*ye2_k)*dt;
    ye2=ye2_k+xe2_k*dt; 
    % CA1 post synaptic potential change for SLOW INHIBITORY interneurons:
    xs2=xs2_k+(G(2)*a(:,2).*zs2(:,k)-2*a(:,2).*xs2_k-a(:,2).*a(:,2).*ys2_k)*dt;
    ys2=ys2_k+xs2_k*dt; 
    % CA1 post synaptic potential change for FAST INHIBITORY interneurons:
    xl2=xl2_k+(G(1)*a(:,1).*uf2(:)-2*a(:,1).*xl2_k-a(:,1).*a(:,1).*yl2_k)*dt; 
    yl2=yl2_k+xl2_k*dt; 
    xf2=xf2_k+(G(3)*a(:,3).*zf2(:,k)-2*a(:,3).*xf2_k-a(:,3).*a(:,3).*yf2_k)*dt;
    yf2=yf2_k+xf2_k*dt; 
    
    % MSDB average post-synaptic membrane potentials:
    vpt=Ct(:,2).*yet-Ct(:,4).*yst-Ct(:,7).*yft;
    vet=Ct(:,1).*ypt;
    vst=Ct(:,3).*ypt;
    vct=yct-Ct(:,9).*yft;
    vft=Ct(:,6).*ypt-Ct(:,5).*yst-Ct(:,8).*yft+ylt;
    % MSDB average spike density:
    zpt(:,k)=2*e0./(1+exp(-r*(vpt-s0)));
    zct(:,k)=2*e0./(1+exp(-r*(vct-s0)));
    zet(:,k)=2*e0./(1+exp(-r*(vet-s0)));
    zst(:,k)=2*e0./(1+exp(-r*(vst-s0)));
    zft(:,k)=2*e0./(1+exp(-r*(vft-s0)));
    % MSDB post synaptic potential change for PYRAMIDAL neurons:
    xpt_k=xpt;
    ypt_k=ypt;
    xet_k=xet;
    yet_k=yet;
    xst_k=xst;
    yst_k=yst;
    xlt_k=xlt;
    ylt_k=ylt;
    xft_k=xft;
    yft_k=yft;
    xct_k=xct;
    yct_k=yct;
    xpt=xpt_k+(G(1)*at(1).*zpt(:,k)-2*at(1).*xpt_k-at(1).*at(1).*ypt_k)*dt;
    ypt=ypt_k+xpt_k*dt;
    % MSDB post synaptic potential change for EXCITATORY interneurons:
    xet=xet_k+(G(1)*at(1).*(zet(:,k)+upt(:)./Ct(2))-2*at(1).*xet_k-at(1).*at(1).*yet_k)*dt;
    yet=yet_k+xet_k*dt; 
    % MSDB post synaptic potential change for SLOW INHIBITORY interneurons:
    xst=xst_k+(G(2)*at(2).*zst(:,k)-2*at(2).*xst_k-at(2).*at(2).*yst_k)*dt;
    yst=yst_k+xst_k*dt;
    % MSDB post synaptic potential change for FAST INHIBITORY interneurons:
    xlt=xlt_k+(G(1)*at(1).*uft(:)-2*at(1).*xlt_k-at(1).*at(1).*ylt_k)*dt; 
    ylt=ylt_k+xlt_k*dt; 
    xft=xft_k+(G(3)*at(3).*zft(:,k)-2*at(3).*xft_k-at(3).*at(3).*yft_k)*dt;  
    yft=yft_k+xft_k*dt;
    % MSDB post synaptic potential change for CHOLINERGIC neurons:
    xct=xct_k+(G(1)*at(:,1).*uct(:)-2*at(:,1).*xct_k-at(:,1).*at(:,1).*yct_k)*dt; % "IN"put coming from the external
    yct=yct_k+xct_k*dt; 

    % MSDB-mediated ACh synthesis:
    yACht(:,k+1)=yACht(:,k)+(at(4).*(-yACht(:,k)+zct(:,k)))*dt; % 1st order dynamics

    % CORTEX post-synaptic membrane potentials:
    vpc=C(:,2).*yec-C(:,4).*ysc-C(:,7).*yfc;
    vec=C(:,1).*ypc;
    vsc=C(:,3).*ypc;
    vfc=C(:,6).*ypc-C(:,5).*ysc-C(:,8).*yfc+ylc;
    % CORTEX average spike density:
    zpc(:,k)=2*e0./(1+exp(-r*(vpc-s0)));
    zec(:,k)=2*e0./(1+exp(-r*(vec-s0)));
    zsc(:,k)=2*e0./(1+exp(-r*(vsc-s0)));
    zfc(:,k)=2*e0./(1+exp(-r*(vfc-s0)));
    % CORTEX post synaptic potential change for PYRAMIDAL neurons:
    xpc_k=xpc;
    ypc_k=ypc;
    xec_k=xec;
    yec_k=yec;
    xsc_k=xsc;
    ysc_k=ysc;
    xlc_k=xlc;
    ylc_k=ylc;
    xfc_k=xfc;
    yfc_k=yfc;
    xpc=xpc_k+(G(1)*ac(:,1).*zpc(:,k)-2*ac(:,1).*xpc_k-ac(:,1).*ac(:,1).*ypc_k)*dt;
    ypc=ypc_k+xpc_k*dt;
    % CORTEX post synaptic potential change for EXCITATORY neurons:
    xec=xec_k+(G(1)*ac(:,1).*(zec(:,k)+upc(:)./C(:,2))-2*ac(:,1).*xec_k-ac(:,1).*ac(:,1).*yec_k)*dt;
    yec=yec_k+xec_k*dt;
    % CORTEX post synaptic potential change for SLOW INHIBITORY neurons:
    xsc=xsc_k+(G(2)*ac(:,2).*zsc(:,k)-2*ac(:,2).*xsc_k-ac(:,2).*ac(:,2).*ysc_k)*dt;
    ysc=ysc_k+xsc_k*dt;
    % CORTEX post synaptic potential change for FAST INHIBITORY neurons:
    xlc=xlc_k+(G(1)*ac(:,1).*ufc(:)-2*ac(:,1).*xlc_k-ac(:,1).*ac(:,1).*ylc_k)*dt;
    ylc=ylc_k+xlc_k*dt;
    xfc=xfc_k+(G(3)*ac(:,3).*zfc(:,k)-2*ac(:,3).*xfc_k-ac(:,3).*ac(:,3).*yfc_k)*dt;
    yfc=yfc_k+xfc_k*dt;

    % SEMANTIC layer:
    if k>D_SEMCORTEX
    I = zpc(:,k-D_SEMCORTEX)./3; % QUESTO PARAMETRO QUI!!
    end
    W_depleted = Wp_SEMSEM.*(ones(Npop_SEM,1)*Depletion(:,k)'); % ogni colonna è moltiplicata dalla stessa variabile
    Se=(W_depleted*xs(:,k));   %tutte le sinapsi che entrano nel neurone j dell'area S da tutti i neuroni dell'area S all'istante k
    der_depl = alpha_d*(1 - Depletion(:,k) ) - beta_d*xs(:,k).*Depletion(:,k); 
    Depletion(:,k+1) = Depletion(:,k) + der_depl*dt;
    xs(:,k+1)=xs(:,k)+dt/tau*(-xs(:,k)+1./(1+exp(-(I + Se-phix)/Ts)));

    % LINGUISTIC layer
    if k > D_LEXSEM
    Sl=(W_LEXSEM*xs(:,k-D_LEXSEM));
    end
    xl(:,k+1)=xl(:,k)+dt/tau*(-xl(:,k)+1./(1+exp(-(Sl-phix_l)/Ts)));


    % Synapse training

    if k>D_CORTEXSEM

    % Hippocampus

    % Wp_CA3CA3
    mean_zp1 = mean(zp1(:,k-30:k-1),2); % mean over the previous 30 ms
    ATT_PREw=(mean_zp1/(2*e0)-thresh_low_Wp_CA3CA3)';
    ATT_PREw(ATT_PREw<0)=0;
    ATT_POSTw=(mean_zp1/(2*e0)-thresh_low_Wp_CA3CA3);
    ATT_POSTw(ATT_POSTw<0)=0;
    WEIGHT_w=(Wp_CA3CA3_max - Wp_CA3CA3).*(ones(Npop_EP,Npop_EP)-eye(Npop_EP));
    Wp_CA3CA3 = Wp_CA3CA3 + (ACh(k)-0)*gammaWp_CA3CA3.*(ATT_POSTw * ATT_PREw) .* WEIGHT_w;

    % Wf_CA3CA3
    mean_zf1 = mean(zf1(:,k-30:k-1),2);
    ATT_PREk=(mean_zp1/(2*e0) - thresh_low_Wf)';
    ATT_PREk(ATT_PREk<0)=0;
    ATT_POSTk=(mean_zf1/(2*e0)-thresh_low_Wf);
    ATT_POSTk(ATT_POSTk<0)=0;
    WEIGHT_k=(Wf_CA3CA3_max - Wf_CA3CA3).*(ones(Npop_EP, Npop_EP)-eye(Npop_EP));
    Wf_CA3CA3 = Wf_CA3CA3 + (ACh(k)-0)*gammaWf.*(ATT_POSTk * ATT_PREk) .* WEIGHT_k;
    
    % Af_CA3CA3
    ATT_PREk=(mean_zp1/(2*e0) - thresh_low_Wf)';
    ATT_PREk(ATT_PREk<0)=0;
    ATT_POSTa=(thresh_up-mean_zf1/(2*e0));
    ATT_POSTa(ATT_POSTa<0)=0;
    WEIGHT_a=(Af_CA3CA3_max - Af_CA3CA3).*(ones(Npop_EP, Npop_EP)-eye(Npop_EP));
    Af_CA3CA3 = Af_CA3CA3 + (ACh(k)-0)*gammaAf.*(ATT_POSTa * ATT_PREk) .* WEIGHT_a;

    % Wp_CA3CA1
    mean_zp2 = mean(zp2(:,k-30:k-1),2);
    ATT_PRE=(mean_zp2/(2*e0) - thresh_low_Wp_CA3CA1)';
    ATT_PRE(ATT_PRE<0)=0;
    ATT_POST=(mean_zp1/(2*e0)-thresh_low_Wp_CA3CA1);
    ATT_POST(ATT_POST<0)=0;
    WEIGHT=(Wp_CA3CA1_max - Wp_CA3CA1).*(ones(Npop_EP,Npop_EP)-eye(Npop_EP));
    Wp_CA3CA1 = Wp_CA3CA1 + (ACh(k)-0)*gammaWp_CA3CA1.*(ATT_POST*ATT_PRE).*WEIGHT;


    % SINAPSI DA SEMANTICA A CORTECCIA

    % new params for the synapses from SEMANTIC TO CORTEX
    thresh_low_Wp_CORTEXSEM = 0.95; % 0.95
    Wp_CORTEXSEM_max =35;  % 45
    gammaWp_CORTEXSEM = 0.20; %0.10 %0.05 
    MAXSUM_Wp_CORTEXSEM = 2000; % 950

    
    % Wp_CORTEXSEM
    ATT_PRE=(xs(:,k-D_CORTEXSEM) - thresh_low_Wp_CORTEXSEM)';
    ATT_PRE(ATT_PRE<0)=0;
    ATT_POST=(zpc(:,k)/(2*e0)-thresh_low_Wp_CORTEXSEM);
    ATT_POST(ATT_POST<0)=0;
    WEIGHT=(Wp_CORTEXSEM_max - Wp_CORTEXSEM).*(ones(Npop_SEM,Npop_SEM)-eye(Npop_SEM));
    Wp_CORTEXSEM = Wp_CORTEXSEM + gammaWp_CORTEXSEM.*(ATT_POST*ATT_PRE).*WEIGHT; % ACh here? % INTRODURLE GIA' DURANTE L'ADDESTRAMENTO?


    % Cortex

%     % new params for the desynchronizing synapses within CORTEX
%     Af_CORTEXCORTEX_max = 2.5;
%     gammaAf_CORTEXCORTEX = 0.5;
%     MAXSUM_Af_CORTEXCORTEX = 215;
%     
    % Af_CORTEXCORTEX
%     mean_zpc = mean(zpc(:,k-30:k-1),2);
%     mean_zfc = mean(zfc(:,k-30:k-1),2);
%     ATT_PREkc=(mean_zpc/(2*e0) - 0.98)';
%     ATT_PREkc(ATT_PREkc<0)=0;
%     ATT_POSTac=(0.02-mean_zfc/(2*e0));
%     ATT_POSTac(ATT_POSTac<0)=0;
%     WEIGHT_ac=(Af_CORTEXCORTEX_max - Af_CORTEXCORTEX).*(ones(Npop_EP, Npop_EP)-eye(Npop_EP));
%     Af_CORTEXCORTEX = Af_CORTEXCORTEX + gammaAf_CORTEXCORTEX.*(ATT_POSTac * ATT_PREkc) .* WEIGHT_ac;


    % Synapse normalisation

    % Hippocampus

    for i=1:Npop_EP
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


    % Cortex
    %addestra più a lungo
    %moltiplica la sinapsi prima di normalizzare
    
    for i=1:Npop_SEM
        S=sum(Wp_CORTEXSEM(i,:),2);
        if S>MAXSUM_Wp_CORTEXSEM
            Wp_CORTEXSEM(i,:)=Wp_CORTEXSEM(i,:).*(MAXSUM_Wp_CORTEXSEM/S);
        end

%         S=sum(Af_CORTEXCORTEX(i,:),2);
%         if S>MAXSUM_Af_CORTEXCORTEX
%             Af_CORTEXCORTEX(i,:)=Af_CORTEXCORTEX(i,:).*(MAXSUM_Af_CORTEXCORTEX/S);
%         end
    end


    end

    % Noise standard deviation
    sigma = sqrt(noise_powdens/dt);
    
    % Subscript 0 = "mPFC"
    np0 = randn(Npop_EP,1)*sigma;
    nf0 = randn(Npop_EP,1)*sigma;
    
    % Subscript 1 = "CA3"
    np1 = randn(Npop_EP,1)*sigma;
    nt1 = randn(Npop_EP,1)*sigma;
    nf1 = randn(Npop_EP,1)*sigma;
    
    % Subscript 2 = "CA1"
    np2 = randn(Npop_EP,1)*sigma;
    nf2 = randn(Npop_EP,1)*sigma;
    
    % Subscrip t = "MSDB"
    npt = randn(1,1)*sigma;
    nft = randn(1,1)*sigma;
    nct = randn(1,1)*sigma;
    
    % Subscrip c = "CORTEX"
    npc = randn(Npop_SEM,1)*sigma;
    nfc = randn(Npop_SEM,1)*sigma;

end