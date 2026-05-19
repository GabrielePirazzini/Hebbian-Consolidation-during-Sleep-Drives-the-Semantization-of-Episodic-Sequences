%% MAIN

clear
%close all
clc

Npop=149;

load sinapsi_prova1000
% load('synapsesAllConcepts_Semantic.mat')
% W = Wp_SEMSEM;
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
it_smells_good = 22;
it_is_eaten = 24;

% salient features of the CAKE
it_is_sweet = 25;
it_is_round = 26;
it_is_sliced = 27
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

% salient features of it IS JUMPING
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

 
scelta = input('What feature? (from 1 to 149, 0 to finish) ');
while (scelta >= 1) && (scelta <=149)
figure
stem(W(scelta,:),'k');
title(['W property ' num2str(scelta)])
scelta = input('What feature? (from 1 to 149, 0 to finish) ');
end
