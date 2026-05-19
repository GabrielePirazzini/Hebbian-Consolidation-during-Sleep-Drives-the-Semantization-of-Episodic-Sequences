%% training
tic

clc
clear
close all

iter=60;
dt=0.4;
t=[0:iter]*dt;
L=length(t);
Npop = 149;
Nobj = 34;

tau = 3;               % costante di tempo
phix_s=0.55;       %0.55     % offset della sigmoide nell'unità eccitatoria
phix_l=3.5;        %0.55
T=0.01;                % pendenza della sigmoide

x_s=zeros(Npop,L);           % M colonna relativa ad un oscillatore-proprietà
x_l=zeros(Nobj,L);

load sinapsi_prova1000
load sinapsi_lexical_prova400.mat
load All_features

scelta = 35; % 3 TABLE; 10 FISH DISH; 27 DAUGHTER, 35 CAT



%% List of features

% ----------------------------------
% MOBILES
% shared features
it_is_in_the_house = 1;
it_is_built_by_the_factory = 2;

% shared features of 4 leg furnitures
it_has_four_legs = 3;
it_is_all_wood = 4;

% salient features of the TABLE
it_has_a_plan = 5;
you_put_objects_on_it = 6;
it_has_the_shape_of_a_table = 7;
you_eat_on_it = 8;

% salient features of the CHAIR
it_is_used_for_sitting = 9;
it_has_a_backrest = 10;
it_has_the_shape_of_a_chair = 11;
it_is_around_the_table = 12;

% shared features of RESTING FURNITURE
it_is_for_resting = 13;
it_is_comfortable = 14;
it_has_pillows = 15;

% salient features of the SOFA
it_is_soft = 16;
it_is_elongated = 17;
it_is_in_the_living_room = 18;

% salient features of the BED
it_is_for_sleeping = 19;
it_has_a_blanket = 20;
it_is_in_the_bedroom = 21;

% ---------------------------------
% FOOD

% shared features 
it_is_tasty = 22;
it_smells_good = 23;
it_is_eaten = 24;

% salient features of the CAKE
it_is_sweet = 25;
it_is_round = 26;
it_is_sliced = 27;
it_contains_sugar = 28;

% salient features of the FISH DISH
it_has_scales = 29;
it_has_bones = 30;
it_smells_like_fish = 31;

% salient features of the SAUSAGE
it_is_fat = 32;
it_is_tapered = 33;
it_smells_like_sausage = 34;

% ----------------------------------------------------
% GAME

% shared features
it_is_fun = 35;
you_can_play_it = 36;
children_like_it = 37;

% salient features of the BALL
it_is_round = 26;
it_bounces = 38;
it_rolls = 39;
it_is_spherical = 40;

% salient features of the DOLL
it_has_human_appearance = 41;
it_has_hair = 42;
it_is_held_in_the_arms = 43;
it_is_cuddled = 44;

% salient features of the LEGO
it_is_used_to_build = 45;
it_has_many_pieces = 46;
it_requires_attention = 47;

% ---------------------------------------------------
% GARDEN

% shared features
it_is_a_place_of_quiet = 48;
it_is_full_of_plants = 49;

% shared features of GARDEN ELEMENT
it_is_in_the_garden = 50;
it_is_outdoors = 51;

% salient features of COFFEE TABLE
it_is_portable = 52;
it_is_foldable = 53;
we_have_picnics_there = 54;
you_eat_on_it = 8;

% salient features of GARDEN CHAIR
it_is_used_for_sitting = 9;
it_is_made_of_wicker = 55;
it_is_around_the_coffee_table = 56;
it_is_light = 57;


% shared features of VEGETABLE
it_needs_water = 58;
it_dries_in_winter = 59;

%_salient features of GRASS
it_is_green = 60;
it_covers_the_ground = 61;
it_smells_of_grass = 62;

% salient features of TREE
it_has_a_trunk = 63;
it_has_leaves = 64;
it_has_branches = 65;
it_has_roots = 66;

% salient features of FLOWER
it_has_the_corolla = 67;
it_has_leaves = 64;
it_has_a_scent = 68;
it_has_the_petals = 69;

%-----------------------------------------------------
% CHILD

% shared features
it_is_small = 70;
it_is_a_little_old = 71;
it_is_fragile = 72;

% shared features of MY SON
he_looks_like_me = 73;
I_feel_affection = 74;

%_salient features of MALE CHILD
he_has_short_hair = 75;
he_plays_soccer = 76;
he_studies_little = 77;

%_salient features of DAUGHTER
she_has_braids = 78;
she_does_gymnastics = 79;
she_is_good_at_school = 80;

% shared features of STRANGER
I_do_not_know_him_very_well = 81;
he_does_not_look_like_me = 82;

%_salient features of_FRIEND
he_hangs_out_with_my_kids = 83;
he_comes_to_my_house = 84;
he_studies_with_my_daughter = 85;

% salient features of UNKNOWN
he_does_not_hang_out_with_us = 86;
I_do_not_know_him_at_all = 87;
he_lives_everywhere = 88;

% -----------------------------------------------------
% ANIMAL

% shared features
it_eats = 89;
it_drinks = 90;
it_sleeps = 91;

% shared features of MAMMAL
it_has_fur = 92;
it_breastfeeds = 93;

% shared features of DOMESTIC
it_is_affectionate = 94;
it_is_cuddled = 44;

% salient features of DOG
it_barks = 95;
it_wags_its_tail = 96;
it_is_faithful = 97;

% salient features of CAT
it_meows = 98;
it_purrs = 99;
it_has_whiskers = 100;
it_jumps = 101;

% shared features of HERBIVORE
it_eats_grass = 102;
it_breeds = 103;

% salinet features of RABBIT
it_has_long_ears = 104;
it_is_fearful = 105;
it_nibbles = 106;
it_jumps = 101;

% salient features of COW
it_produces_milk = 107;
it_moos = 108;
it_has_horns = 109;

% salient features of SHEEP
it_produces_wool = 110;
it_bleats = 111;
it_lives_in_flocks = 112;

% shared features of BIRD
it_has_two_legs = 113;
it_has_feathers = 114;

% salient fetures of ROOSTER
it_has_wattles = 115;
it_sings = 116;
it_lives_in_the_henhouse = 117;

% salient features of PIGEON
it_coos = 118;
it_eats_crumbs = 119;
it_lives_in_the_squares = 120;

% salient features of PARROT
it_repeats_words = 121;
it_has_a_big_beak = 122;
it_is_of_various_colours = 123;


% -------------------------------------
% FEELING

% shared features
he_feels_joy = 124;
he_is_affectionate = 125;
he_is_tender = 126;

% salient features of LAUGHTER
he_opens_the_mouth = 127;
he_has_the_sounds_of_laughter = 128;
he_moves_the_head = 129;

% salient features of SMILE
he_stretches_lips = 130;
he_halfcloses_eyes = 131;
he_arouses_sympathy = 132;

% salient features of CARESS
he_moves_the_hand = 133;
he_has_tactile_perception = 134;
it_touches_the_skin = 135;

% -----------------------------------
% ACTION

% shared features
it_does_something = 136;
it_changes_its_state = 137;

% salient deaturs of IT IS EATING
it_opens_the_mouth = 127;
it_chews = 138;
it_tastes = 139;
he_uses_cutlery = 140;

% salient features of IT IS JUMPING
it_is_moving_vertically = 141;
it_is_rising_in_the_air = 142;
he_gives_himself_a_push = 143;

% salient features of IT IS RUNNING
it_is_moving_quickly = 144;
it_is_changing_position_along_the_ground = 145;
he_lifts_his_knees = 146;

% salient features of IT IS RESTING
it_lies_down = 147;
it_relaxes = 148;
it_closes_his_eyes = 149;


%% parameters
m = zeros(Npop,1);

% parameters network
dt = 0.0001;
tend = 0.1;             % final value for the time
t_finestimolo = 0.03;
t = (0:dt:tend);
N = length(t);          % length of the temporal vector
G = [5.17 4.45 57.1];   % synaptic gains
% parametri sigmoide
e0 = 2.5;               % sturation for the sigmoid
r = 0.56;               % slope of the sigmoid (1/mV) 
s0 = 12;                % center of the sigmoid
flag = 0;               % parameter to set the position in the sigmoid

tau = 0.003;            % costante di tempo in s
phix=0.55;              % offset della sigmoide nell'unità eccitatoria
T=0.01;                 % pendenza della sigmoide

tau_d = 0.04;  % 10 ms
alpha_d = 1/tau_d;
beta_d = 5*alpha_d;


%% Connectivity constants

C = zeros(Npop,8);
C(:,1) = 54.;   % Cep
C(:,2) = 54.;   % Cpe
C(:,3) = 54.;   % Csp
C(:,4) = 67.5;  % Cps
C(:,5) = 27.;   % Cfs
C(:,6) = 108.;  % Cfp
C(:,7) = 300.;  % Cpf
C(:,8) = 10.;   % Cff
a = ones(Npop,1)*[125 30 400]; % reciproco delle costanti di tempo (omega)


%%
switch scelta
    case 1 % MOBILE
        % shared features of MOBILES
        m(it_is_in_the_house) = 0;
        m(it_is_built_by_the_factory) = 0;

    case 2 % 4 leg furniture
        % shared features of 4 leg furnitures
        m(it_has_four_legs) = 0;
        m(it_is_all_wood) = 0;

    case 3 % TABLE
        % salient features of the TABLE
        m(it_has_a_plan) = 800;
        m(you_put_objects_on_it) = 0;
        m(it_has_the_shape_of_a_table) = 0;
        m(you_eat_on_it) = 0;

    case 4 % CHAIR
        % salient features of the CHAIR
        m(it_is_used_for_sitting) = 0;
        m(it_has_a_backrest) = 0;
        m(it_has_the_shape_of_a_chair) = 0;
        m(it_is_around_the_table) = 0;

    case 5 % resting furniture
        % shared features of resting furnitures
        m(it_is_for_resting) = 0;
        m(it_is_comfortable) = 0;
        m(it_has_pillows) = 0;

    case 6 % SOFA
        % salient features of the SOFA
        m(it_is_soft) = 0;
        m(it_is_elongated) = 0;
        m(it_is_in_the_living_room) = 0;

    case 7 % BED
        % shared features of the BED
        m(it_is_for_sleeping) = 0;
        m(it_has_a_blanket) = 0;
        m(it_is_in_the_bedroom) = 0;

        % -----------------------------------------------
    case 8 % FOOD
        % shared features of FOOD
        m(it_is_tasty) = 0;
        m(it_smells_good) = 0;
        m(it_is_eaten) = 0;

    case 9 % CAKE
        % salient features of the CAKE
        m(it_is_sweet) = 0;
        m(it_is_round) = 0;
        m(it_is_sliced) = 0;
        m(it_contains_sugar) = 0;

    case 10 % FISH DISH
        % salient features of the FISH DISH
        m(it_has_scales) = 800;
        m(it_has_bones) = 0;
        m(it_smells_like_fish) = 0;

    case 11 % SAUSAGE
        % salient features of the SAUSAGE
        m(it_is_fat) = 0;
        m(it_is_tapered) = 0;
        m(it_smells_like_sausage) = 0;

        % ----------------------------------------------
    case 12 % GAME
        % shared features of GAME
        m(it_is_fun) = 0;
        m(you_can_play_it) = 0;
        m(children_like_it) = 0;

    case 13 % BALL
        % salient features of the BALL
        m(it_is_round) = 0;
        m(it_bounces) = 0;
        m(it_rolls) = 0;
        m(it_is_spherical) = 0;

    case 14 % DOLL
        % salient features of the DOLL
        m(it_has_human_appearance) = 0;
        m(it_has_hair) = 0;
        m(it_is_held_in_the_arms) = 0;
        m(it_is_cuddled) = 0;

    case 15  % LEGO
        % salient features of the LEGO
        m(it_is_used_to_build) = 0;
        m(it_has_many_pieces) = 0;
        m(it_requires_attention) = 0;
        
        % --------------------------------------------------
    case 16 % GARDEN
        % shared features of GARDEN
        m(it_is_a_place_of_quiet) = 0;
        m(it_is_full_of_plants) = 0;

    case 17 % GARDEN ELEMENT
        % shared features of GARDEN ELEMENT
        m(it_is_in_the_garden) = 0;
        m(it_is_outdoors) = 0;

    case 18 % COFFEE TABLE
        % salient features of COFFEE TABLE
        m(it_is_portable) = 0;
        m(it_is_foldable) = 0;
        m(we_have_picnics_there) = 0;
        m(you_eat_on_it) = 0;

    case 19 % GARDEN CHAIR
        % salient features of GARDEN CHAIR
        m(it_is_used_for_sitting) = 0;
        m(it_is_made_of_wicker) = 0;
        m(it_is_around_the_coffee_table) = 0;
        m(it_is_light) = 0;

    case 20 % VEGETABLE
        % shared features of VEGETABLE
        m(it_needs_water) = 0;
        m(it_dries_in_winter) = 0;

    case 21 % GRASS
        %_salient features of GRASS
        m(it_is_green) = 0;
        m(it_covers_the_ground) = 0;
        m(it_smells_of_grass) = 0;

    case 22 % TREE
        % salient features of TREE
        m(it_has_a_trunk) = 0;
        m(it_has_leaves) = 0;
        m(it_has_branches) = 0;
        m(it_has_roots) = 0;

    case 23 % FLOWER
        % salient features of FLOWER
        m(it_has_the_corolla) = 0;
        m(it_has_leaves) = 0;
        m(it_has_a_scent) = 0;
        m(it_has_the_petals) = 0;

        % -----------------------------------------------------------
    case 24 % CHILD
        % shared features 0f CHILD
        m(it_is_small) = 0;
        m(it_is_a_little_old) = 0;
        m(it_is_fragile) = 0;

    case 25 % MY SON
        % shared features of MY SON
        m(he_looks_like_me) = 0;
        m(I_feel_affection) = 0;

    case 26 % MALE CHILD
        %_salient features of MALE CHILD
        m(he_has_short_hair) = 0;
        m(he_plays_soccer) = 0;
        m(he_studies_little) = 0;

    case 27 % DAUGHTER
        %_salient features of DAUGHTER
        m(she_has_braids) = 800;
        m(she_does_gymnastics) = 0;
        m(she_is_good_at_school) = 0;

    case 28 % STRANGER
        % shared features of STRANGER
        m(I_do_not_know_him_very_well) = 0;
        m(he_does_not_look_like_me) = 0;

    case 29 % FRIEND
        %_salient features of_FRIEND
        m(he_hangs_out_with_my_kids) = 0;
        m(he_comes_to_my_house) = 0;
        m(he_studies_with_my_daughter) = 0;

    case 30 %  UNKNOWN
        % salient features of UNKNOWN
        m(he_does_not_hang_out_with_us) = 0;
        m(I_do_not_know_him_at_all) = 0;
        m(he_lives_everywhere) = 0;

        % --------------------------------------------------
    case 31 % ANIMAL
        % shared features of ANIMAL
        m(it_eats) = 0;
        m(it_drinks) = 0;
        m(it_sleeps) = 0;

    case 32 % MAMMAL
        % shared features of MAMMAL
        m(it_has_fur)= 0;
        m(it_breastfeeds)= 0;

    case 33 % DOMESTIC
        % shared features of DOMESTIC
        m(it_is_affectionate)= 0;
        m(it_is_cuddled)= 0;

    case 34 % DOG
        % salient features of DOG
        m(it_barks)= 0;
        m(it_wags_its_tail)= 0;
        m(it_is_faithful)= 0;

    case 35 % CAT
        % salient features of CAT
        m(it_meows)= 800;
        m(it_purrs)= 0;
        m(it_has_whiskers)= 0;
        m(it_jumps)= 0;

    case 36 % HARBIVORE
        % shared features of HERBIVORE
        m(it_eats_grass)= 0;
        m(it_breeds)= 0;

    case 37 % RABBITT
        % salient features of RABBIT
        m(it_has_long_ears)= 0;
        m(it_is_fearful)= 0;
        m(it_nibbles)= 0;
        m(it_jumps)= 0;

    case 38 % COW
        % salient features of COW
        m(it_produces_milk)= 0;
        m(it_moos)= 0;
        m(it_has_horns)= 0;

    case 39 % SHEEP
        % salient features of SHEEP
        m(it_produces_wool)= 0;
        m(it_bleats)= 0;
        m(it_lives_in_flocks)= 0;

    case 40 % BIRD
        % shared features of BIRD
        m(it_has_two_legs)= 0;
        m(it_has_feathers)= 0;

    case 41 % ROOSTER
        % salient fetures of ROOSTER
        m(it_has_wattles)= 0;
        m(it_sings)= 0;
        m(it_lives_in_the_henhouse)= 0;

    case 42 % PIGEON
        % salient features of PIGEON
        m(it_coos)= 0;
        m(it_eats_crumbs)= 0;
        m(it_lives_in_the_squares) = 0;

    case 43 % PARROTT
        % salient fetures of PARROTT
        m(it_repeats_words)= 0;
        m(it_has_a_big_beak)= 0;
        m(it_is_of_various_colours)= 0;

        % -------------------------------------------
    case 44 % FEELING
        % shared features of FEELING
        m(he_feels_joy)= 0;
        m(he_is_affectionate)= 0;
        m(he_is_tender)= 0;

    case 45 % LAUGHTER
        % salient features of LAUGHTER
        m(he_opens_the_mouth)= 0;
        m(he_has_the_sounds_of_laughter)= 0;
        m(he_moves_the_head ) = 0;

    case 46 % SMILE
        % salient features of SMILE
        m(he_stretches_lips)= 0;
        m(he_halfcloses_eyes)= 0;
        m(he_arouses_sympathy) = 0;

    case 47 %CARESS
        % salient features of CARESS
        m(he_moves_the_hand)= 0;
        m(he_has_tactile_perception)= 0;
        m(it_touches_the_skin) = 0;

        % ------------------------------------------------------
    case 48 %ACTION
        % shared features of ACTION
        m(it_does_something)= 0;
        m(it_changes_its_state)= 0;

    case 49 %IT IS EATING
        % salient features of IT IS EATING
        m(it_opens_the_mouth)= 0;
        m(it_chews)= 0;
        m(it_tastes)= 0;
        m(he_uses_cutlery ) = 0;

    case 50 %IT IS JUMPING
        % salient features of IT IS JUMPING
        m(it_is_moving_vertically)= 0;
        m(it_is_rising_in_the_air)= 0;
        m(he_gives_himself_a_push) = 0;

    case 51 % IT IS RUNNING
        % salient features of IT IS RUNNING
        m(it_is_moving_quickly)= 0;
        m(it_is_changing_position_along_the_ground)= 0;
        m(he_lifts_his_knees) = 0;

    case 52 % IT IS RESTING
        % salient features of IT IS RESTING
        m(it_lies_down )= 0;
        m(it_relaxes)= 0;
        m(it_closes_his_eyes)= 0;
end

% defining equations of a single ROI
% neuroni piramidali
yp = zeros(Npop,N);
xp = zeros(Npop,N);
vp = zeros(Npop,1);
zp = zeros(Npop,N);
% interneuroni eccitatori
ye = zeros(Npop,N);
xe = zeros(Npop,N);
ve = zeros(Npop,1);
ze = zeros(Npop,N);
% interneuroni lenti inibitori
ys = zeros(Npop,N);
xs = zeros(Npop,N);
vs = zeros(Npop,1);
zs = zeros(Npop,N);
% interneuroni veloci inibitori
yf = zeros(Npop,N);
xf = zeros(Npop,N);
zf = zeros(Npop,N);
vf = zeros(Npop,1);
xl = zeros(Npop,N);
yl = zeros(Npop,N);
x=zeros(Npop,N);     
Depletion = ones(Npop,N);


%% Gaussian white noise generation
% mean value of the input noise to each ROI (through excitatory interneurons)
sigma_p = sqrt(5/dt); % deviazione standard del rumore bianco in IN ai neuroni eccitatori
sigma_f = sqrt(5/dt); % deviazione standard del rumore bianco in IN ai neuroni inibitori
np = randn(Npop,N)*sigma_p; % creo il rumore in IN ai neuroni eccitatori
nf = randn(Npop,N)*sigma_f; % creo in rumore in IN ai neuroni inibitori
        
for k = 1:N-1 % ciclo sul tempo

    if k > round(t_finestimolo/dt)
       m = 0;
    end

    up = np(:,k)+m;
    uf = nf(:,k);

    % post-synaptic membrane potentials
    vp(:)=C(:,2).*ye(:,k)-C(:,4).*ys(:,k)-C(:,7).*yf(:,k); % 2.15
    ve(:)=C(:,1).*yp(:,k); % 2.19
    vs(:)=C(:,3).*yp(:,k); % 2.23
    vf(:)=C(:,6).*yp(:,k)-C(:,5).*ys(:,k)-C(:,8).*yf(:,k)+yl(:,k); % 2.29

    % average spike density
    zp(:,k)=2*e0./(1+exp(-r*(vp(:)-s0)))-flag*e0; % 2.14
    ze(:,k)=2*e0./(1+exp(-r*(ve(:)-s0)))-flag*e0; % 2.18
    zs(:,k)=2*e0./(1+exp(-r*(vs(:)-s0)))-flag*e0; % 2.22
    zf(:,k)=2*e0./(1+exp(-r*(vf(:)-s0)))-flag*e0; % 2.28

    % post synaptic potential for pyramidal neurons
    xp(:,k+1)=xp(:,k)+(G(1)*a(:,1).*zp(:,k)-2*a(:,1).*xp(:,k)-a(:,1).*a(:,1).*yp(:,k))*dt; % 2.13
    yp(:,k+1)=yp(:,k)+xp(:,k)*dt; % 2.12

    % post synaptic potential for excitatory interneurons
    xe(:,k+1)=xe(:,k)+(G(1)*a(:,1).*(ze(:,k)+up(:)./C(:,2))-2*a(:,1).*xe(:,k)-a(:,1).*a(:,1).*ye(:,k))*dt; % 2.17
    ye(:,k+1)=ye(:,k)+xe(:,k)*dt; % 2.16

    % post synaptic potential for slow inhibitory interneurons
    xs(:,k+1)=xs(:,k)+(G(2)*a(:,2).*zs(:,k)-2*a(:,2).*xs(:,k)-a(:,2).*a(:,2).*ys(:,k))*dt; % 2.21
    ys(:,k+1)=ys(:,k)+xs(:,k)*dt; % 2.20

    % post synaptic potential for fast inhibitory interneurons
    xl(:,k+1)=xl(:,k)+(G(1)*a(:,1).*uf(:)-2*a(:,1).*xl(:,k)-a(:,1).*a(:,1).*yl(:,k))*dt; % 2.27
    yl(:,k+1)=yl(:,k)+xl(:,k)*dt; % 2.26
    xf(:,k+1)=xf(:,k)+(G(3)*a(:,3).*zf(:,k)-2*a(:,3).*xf(:,k)-a(:,3).*a(:,3).*yf(:,k))*dt; % 2.25
    yf(:,k+1)=yf(:,k)+xf(:,k)*dt; % 2.24

    % From here I simulate the semantic network
    I = zp(:,k);
    W_depleted = W.*(ones(Npop,1)*Depletion(:,k)'); % ogni colonna è moltiplicata dalla stessa variabile
    Se=(W_depleted*x_s(:,k));   %tutte le sinapsi che entrano nel neurone j dell'area S da tutti i neuroni dell'area S all'istante k
    der_depl = alpha_d*(1 - Depletion(:,k) ) - beta_d*x_s(:,k).*Depletion(:,k); 
    Depletion(:,k+1) = Depletion(:,k) + der_depl*dt;

    Sl=(W_LEXSEM*x_s(:,k));

    x_s(:,k+1)=x_s(:,k)+dt/tau*(-x_s(:,k)+1./(1+exp(-(I + Se-phix_s)/T)));
    x_l(:,k+1)=x_l(:,k)+dt/tau*(-x_l(:,k)+1./(1+exp(-(0 + Sl-phix_l)/T))); %l'ingresso alla rete linguistica è nullo, l'unico input arriva dalla semantica

end


%% Visualizzazione
        
passoin = 1;  %(tend-1.9)/dt;
passofin = tend/dt;

figure
sgtitle('cat','FontSize',20);
plot(t(passoin:passofin),x_s(89:91,passoin:passofin),'-.b','LineWidth',2) % animal
hold on
plot(t(passoin:passofin),x_s([92 93],passoin:passofin),'-.k','LineWidth',2) % mammal
plot(t(passoin:passofin),x_s([44 94],passoin:passofin),'-.g','LineWidth',2) % domestic
plot(t(passoin:passofin),x_s(98:101,passoin:passofin),'-.r','LineWidth',2) % cat
no_stimulated = [(1:43) (45:88) (95:97) (102:149)];
plot(t(passoin:passofin),x_s(no_stimulated,passoin:passofin),':c','LineWidth',2) % no stimulated
set(gca,'fontsize',18)
xlabel('time (s)')
axis([0 0.1 0 1.1])
ylabel('semantic network activity')
legend('it eats','it drinks','it sleeps','it has fur','it breastfeeds',...
'it is affectionate','it is cuddled','it meows','it purrs','it has whiskers','it jumps',...
'other features','Location','south')
axes('position',[0.65 0.6 0.25 0.25])
plot(t(passoin:passofin),zp(98,passoin:passofin)/5,'-.r','LineWidth',2)
hold on
plot(t(passoin:passofin),zp([1:97 99:149],passoin:passofin)/5,'-.c','LineWidth',2)
legend('It meows','Other features')
set(gca,'fontsize',14)
xlabel('time (s)')
ylabel('cortical network activity')
axes('position',[0.65 0.2 0.25 0.25])
plot(t(passoin:passofin),x_l(21,passoin:passofin),'-.m','LineWidth',2)
hold on
plot(t(passoin:passofin),x_l([1:20 22:34],passoin:passofin),'-.c','LineWidth',2)
set(gca,'fontsize',14)
xlabel('time (s)')
ylabel('lexical network activity')
legend('Cat','Other words')

