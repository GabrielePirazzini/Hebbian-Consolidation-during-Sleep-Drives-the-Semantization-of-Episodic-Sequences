clc, clear, close all

% 1st Seq) 12 features
ep1 = [78,31,54];   % DAUGHTER, FISH, TABLE
ep2 = [98,143,57]; % CAT, IT IS JUMPING, GARDEN CHAIR
ep3 = [80,30,60];  % DAUGHTER, FISH, GRASS
ep4 = [99,138,132]; % CAT, IT IS EATING, HAPPY

% 2nd Seq) 12 features
ep5 = [97,147,63];   % DOG, IT IS RESTING, TREE
ep6 = [83,76,38]; % FRIEND, SON, BALL
ep7 = [96,144,150];  % DOG, IT IS RUNNING, GRASS (the grass of friend's garden 150-->60)
ep8 = [77,84,128]; % SON, FRIEND, LAUGH

save('1stSeq_episodes.mat', 'ep1', 'ep2','ep3','ep4');
save('2ndSeq_episodes.mat', 'ep5', 'ep6','ep7','ep8');