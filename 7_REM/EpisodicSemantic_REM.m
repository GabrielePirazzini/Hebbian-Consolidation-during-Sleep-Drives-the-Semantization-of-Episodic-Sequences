%% Network SIMULATION

% p = "pyramidal"
% e = "eccitatory"
% f = "fast inhibitory"
% s = "slow inihbitory"


% Noise standard deviation
sigma = sqrt(noise_powdens/dt);

% Subscript 0 = "mPFC"
np0 = randn(Npop_EP,T)*sigma;
nf0 = randn(Npop_EP,T)*sigma;

% Subscript 1 = "CA3"
np1 = randn(Npop_EP,T)*sigma;
nt1 = randn(Npop_EP,T)*sigma;
nf1 = randn(Npop_EP,T)*sigma;

% Subscript 2 = "CA1"
np2 = randn(Npop_EP,T)*sigma;
nf2 = randn(Npop_EP,T)*sigma;

% Subscrip t = "MSDB"
npt = randn(1,T)*sigma;
nft = randn(1,T)*sigma;
nct = randn(1,T)*sigma;

% Subscrip c = "CORTEX"
npc = randn(Npop_SEM,T)*sigma;
nfc = randn(Npop_SEM,T)*sigma;
      

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

% parameters depletion
tau_d = 0.03; %0.036 
alpha_d = 1/tau_d;
beta_d = 6*alpha_d; %4.8

%% Lexical
phix_l=3.5; 


%% All variables initialised

% EC
yEC1 = zeros(Npop_EP,T); % inputs from EC
yEC2 = zeros(Npop_EP,T);


% mPFC:
yp0=zeros(Npop_EP,T);
xp0=zeros(Npop_EP,T);
vp0=zeros(Npop_EP,T); 
zp0=zeros(Npop_EP,T);

ye0=zeros(Npop_EP,T);
xe0=zeros(Npop_EP,T);
ve0=zeros(Npop_EP,T);
ze0=zeros(Npop_EP,T);

ys0=zeros(Npop_EP,T);
xs0=zeros(Npop_EP,T);
vs0=zeros(Npop_EP,T);
zs0=zeros(Npop_EP,T);

yf0=zeros(Npop_EP,T);
xf0=zeros(Npop_EP,T);
zf0=zeros(Npop_EP,T);
vf0=zeros(Npop_EP,T);

xl0=zeros(Npop_EP,T);
yl0=zeros(Npop_EP,T);

mf0=zeros(Npop_EP,1);  % noise mean


% CA3:
yp1=zeros(Npop_EP,T);
xp1=zeros(Npop_EP,T);
vp1=zeros(Npop_EP,T); 
zp1=zeros(Npop_EP,T);

ye1=zeros(Npop_EP,T);
xe1=zeros(Npop_EP,T);
ve1=zeros(Npop_EP,T);
ze1=zeros(Npop_EP,T);

ys1=zeros(Npop_EP,T);
xs1=zeros(Npop_EP,T);
vs1=zeros(Npop_EP,T);
zs1=zeros(Npop_EP,T);

yf1=zeros(Npop_EP,T);
xf1=zeros(Npop_EP,T);
zf1=zeros(Npop_EP,T);
vf1=zeros(Npop_EP,T);

xl1=zeros(Npop_EP,T);
yl1=zeros(Npop_EP,T);

mf1=zeros(Npop_EP,T);
mp1=zeros(Npop_EP,T);


% CA1:
yp2=zeros(Npop_EP,T);
xp2=zeros(Npop_EP,T);
vp2=zeros(Npop_EP,T); 
zp2=zeros(Npop_EP,T);

ye2=zeros(Npop_EP,T);
xe2=zeros(Npop_EP,T);
ve2=zeros(Npop_EP,T);
ze2=zeros(Npop_EP,T);

ys2=zeros(Npop_EP,T);
xs2=zeros(Npop_EP,T);
vs2=zeros(Npop_EP,T);
zs2=zeros(Npop_EP,T);

yf2=zeros(Npop_EP,T);
xf2=zeros(Npop_EP,T);
zf2=zeros(Npop_EP,T);
vf2=zeros(Npop_EP,T);

xl2=zeros(Npop_EP,T);
yl2=zeros(Npop_EP,T);

mf2=zeros(Npop_EP,T);
mp2=zeros(Npop_EP,T);


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


% CORTEX:

ypc = zeros(Npop_SEM,T);
xpc = zeros(Npop_SEM,T);
vpc = zeros(Npop_SEM,1);
zpc = zeros(Npop_SEM,T);

yec = zeros(Npop_SEM,T);
xec = zeros(Npop_SEM,T);
vec = zeros(Npop_SEM,1);
zec = zeros(Npop_SEM,T);

ysc = zeros(Npop_SEM,T);
xsc = zeros(Npop_SEM,T);
vsc = zeros(Npop_SEM,1);
zsc = zeros(Npop_SEM,T);

yfc = zeros(Npop_SEM,T);
xfc = zeros(Npop_SEM,T);
zfc = zeros(Npop_SEM,T);
vfc = zeros(Npop_SEM,1);

xlc = zeros(Npop_SEM,T);
ylc = zeros(Npop_SEM,T);

mpc=zeros(Npop_SEM,T);


% SEMANTIC:

xs=zeros(Npop_SEM,T);     
Depletion=ones(Npop_SEM,T);
I = zeros(Npop_SEM,1);

%LEXICAL
% LINGUISTIC
N_obj=34;
xl=zeros(N_obj,T);
Sl = zeros(N_obj,1);

%% Network simulation:

Wp_mPFCmPFC = zeros(Npop_EP);
inhib1 = zeros(1,Npop_EP);
% inhibc = zeros(1,Npop_SEM);
disinhibt = zeros(1,Npop_EP);

for k=2:T-1
    
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

        Wp_mPFCmPFC=zeros(Npop_EP); % I follow the input

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

  
    upc = npc(:,k)+mpc(:,k)+mediaIN(:,k);
    ufc = nfc(:,k);

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

            upc(j)=upc(j)+Wp_CORTEXCA3(j,:)*zp2(:,k-D_CORTEXCA3); % sparse connectivity CA3-->Cortex
            upc(j) = upc(j) + 4*disinhibt(j);
        
        end

        if k>D_CORTEXCORTEX && j<=Npop_SEM
                 
        inhibc(j)=1*Af_CORTEXCORTEX(j,:)*zpc(:,k-D_CORTEXCORTEX); % RAGIONARE SE FARLO?
        
        end

        if k>D_CORTEXSEM && j<=Npop_SEM % Semantic-Cortex interactions
    
            upc(j)=upc(j)+Wp_CORTEXSEM(j,:)*xs(:,k-D_CORTEXCA3); % hetero-associative network in the cortex
             
        end

    end

    upc_ep1(:,k-1) = upc(ep1);
    upc_ep2(:,k-1) = upc(ep2);
    upc_ep3(:,k-1) = upc(ep3);
    upc_ep4(:,k-1) = upc(ep4);

    
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
    vp1(:,k)=Cc(:,2).*ye1(:,k)-Cc(:,4).*ys1(:,k)-Cc(:,7).*yf1(:,k);
    ve1(:,k)=Cc(:,1).*yp1(:,k);
    vs1(:,k)=Cc(:,3).*yp1(:,k);
    vf1(:,k)=Cc(:,6).*yp1(:,k)-Cc(:,5).*ys1(:,k)-Cc(:,8).*yf1(:,k)+yl1(:,k)+inhib1'; % "inhib1" has a much faster dynamic than other synapses
    % CA3 average spike density:
    zp1(:,k)=2*e0./(1+exp(-r*(vp1(:,k)-s0))); 
    ze1(:,k)=2*e0./(1+exp(-r*(ve1(:,k)-s0)));
    zs1(:,k)=2*e0./(1+exp(-r*(vs1(:,k)-s0)));
    zf1(:,k)=2*e0./(1+exp(-r*(vf1(:,k)-s0)));
    % CA3 post synaptic potential change for PYRAMIDAL neurons:
    xp1(:,k+1)=xp1(:,k)+(G(1)*a(:,1).*zp1(:,k)-2*a(:,1).*xp1(:,k)-a(:,1).*a(:,1).*yp1(:,k))*dt;
    yp1(:,k+1)=yp1(:,k)+xp1(:,k)*dt; 
    % CA3 post synaptic potential change for EXCITATORY interneurons:
    xe1(:,k+1)=xe1(:,k)+(G(1)*a(:,1).*(ze1(:,k)+up1(:)./Cc(:,2))-2*a(:,1).*xe1(:,k)-a(:,1).*a(:,1).*ye1(:,k))*dt;
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
    vp2(:,k)=Cc(:,2).*ye2(:,k)-Cc(:,4).*ys2(:,k)-Cc(:,7).*yf2(:,k);
    ve2(:,k)=Cc(:,1).*yp2(:,k);
    vs2(:,k)=Cc(:,3).*yp2(:,k);
    vf2(:,k)=Cc(:,6).*yp2(:,k)-Cc(:,5).*ys2(:,k)-Cc(:,8).*yf2(:,k)+yl2(:,k);
    % CA1 average spike density:
    zp2(:,k)=2*e0./(1+exp(-r*(vp2(:,k)-s0))); 
    ze2(:,k)=2*e0./(1+exp(-r*(ve2(:,k)-s0)));
    zs2(:,k)=2*e0./(1+exp(-r*(vs2(:,k)-s0)));
    zf2(:,k)=2*e0./(1+exp(-r*(vf2(:,k)-s0)));
    % CA1 post synaptic potential change for PYRAMIDAL neurons:
    xp2(:,k+1)=xp2(:,k)+(G(1)*a(:,1).*zp2(:,k)-2*a(:,1).*xp2(:,k)-a(:,1).*a(:,1).*yp2(:,k))*dt;
    yp2(:,k+1)=yp2(:,k)+xp2(:,k)*dt; 
    % CA1 post synaptic potential change for EXCITATORY interneurons:
    xe2(:,k+1)=xe2(:,k)+(G(1)*a(:,1).*(ze2(:,k)+up2(:)./Cc(:,2))-2*a(:,1).*xe2(:,k)-a(:,1).*a(:,1).*ye2(:,k))*dt;
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

    % MSDB-mediated ACh synthesis:
    yACht(:,k+1)=yACht(:,k)+(at(4).*(-yACht(:,k)+zct(:,k)))*dt; % 1st order dynamics

    % CORTEX post-synaptic membrane potentials:
    vpc(:)=C(:,2).*yec(:,k)-C(:,4).*ysc(:,k)-C(:,7).*yfc(:,k);
    vec(:)=C(:,1).*ypc(:,k);
    vsc(:)=C(:,3).*ypc(:,k);
    vfc(:)=C(:,6).*ypc(:,k)-C(:,5).*ysc(:,k)-C(:,8).*yfc(:,k)+ylc(:,k)+inhibc';
    % CORTEX average spike density:
    zpc(:,k)=2*e0./(1+exp(-1*r*(vpc(:)-s0)));
    zec(:,k)=2*e0./(1+exp(-1*r*(vec(:)-s0)));
    zsc(:,k)=2*e0./(1+exp(-1*r*(vsc(:)-s0)));
    zfc(:,k)=2*e0./(1+exp(-1*r*(vfc(:)-s0)));
    % CORTEX post synaptic potential change for PYRAMIDAL neurons:
    xpc(:,k+1)=xpc(:,k)+(G(1)*ac(:,1).*zpc(:,k)-2*ac(:,1).*xpc(:,k)-ac(:,1).*ac(:,1).*ypc(:,k))*dt;
    ypc(:,k+1)=ypc(:,k)+xpc(:,k)*dt;
    % CORTEX post synaptic potential change for EXCITATORY neurons:
    xec(:,k+1)=xec(:,k)+(G(1)*ac(:,1).*(zec(:,k)+upc(:)./C(:,2))-2*ac(:,1).*xec(:,k)-ac(:,1).*ac(:,1).*yec(:,k))*dt;
    yec(:,k+1)=yec(:,k)+xec(:,k)*dt;
    % CORTEX post synaptic potential change for SLOW INHIBITORY neurons:
    xsc(:,k+1)=xsc(:,k)+(G(2)*ac(:,2).*zsc(:,k)-2*ac(:,2).*xsc(:,k)-ac(:,2).*ac(:,2).*ysc(:,k))*dt;
    ysc(:,k+1)=ysc(:,k)+xsc(:,k)*dt;
    % CORTEX post synaptic potential change for FAST INHIBITORY neurons:
    xlc(:,k+1)=xlc(:,k)+(G(1)*ac(:,1).*ufc(:)-2*ac(:,1).*xlc(:,k)-ac(:,1).*ac(:,1).*ylc(:,k))*dt;
    ylc(:,k+1)=ylc(:,k)+xlc(:,k)*dt;
    xfc(:,k+1)=xfc(:,k)+(G(3)*ac(:,3).*zfc(:,k)-2*ac(:,3).*xfc(:,k)-ac(:,3).*ac(:,3).*yfc(:,k))*dt;
    yfc(:,k+1)=yfc(:,k)+xfc(:,k)*dt;

    % SEMANTIC layer:
    if k > D_SEMCORTEX
    I = zpc(:,k-D_SEMCORTEX)./(Wp_SEMCORTEX); %1.5
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



    % Synaptic training

    if k>30  % ...from step 31 'cause synaptic traing

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


    % Semantic 

    % new params
    thresh_low_Wp_CORTEXSEM = 0.95;
    Wp_CORTEXSEM_max = 55;
    gammaWp_CORTEXSEM = 0.05;
    MAXSUM_Wp_CORTEXSEM = 700; % BEFORE 300

      % Wp_CORTEXSEM % IN QUESTA MODALITA' NON ADDESTRIAMO, BISOGNA CAPIRE COME MOTIVARLO

%     mean_zpc = mean(zpc(:,k-30:k-1),2);
%     mean_xs = mean(xs(:,k-30:k-1),2);
%     ATT_PRE=(xs(:,k) - thresh_low_Wp_CORTEXSEM)';
%     ATT_PRE(ATT_PRE<0)=0;
%     ATT_POST=(zpc(:,k)/(2*e0)-thresh_low_Wp_CORTEXSEM);
%     ATT_POST(ATT_POST<0)=0;
%     WEIGHT=(Wp_CORTEXSEM_max - Wp_CORTEXSEM).*(ones(Npop_SEM,Npop_SEM)-eye(Npop_SEM));
%     Wp_CORTEXSEM = Wp_CORTEXSEM + gammaWp_CORTEXSEM.*(ATT_POST*ATT_PRE).*WEIGHT; % ACETILCOLINA?


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


%     % Cortex
%     
%     for i=1:Npop_SEM
%         S=sum(Wp_CORTEXSEM(i,:),2);
%         if S>MAXSUM_Wp_CORTEXSEM
%             Wp_CORTEXSEM(i,:)=Wp_CORTEXSEM(i,:).*(MAXSUM_Wp_CORTEXSEM/S);
%         end
%     end


    end

end


