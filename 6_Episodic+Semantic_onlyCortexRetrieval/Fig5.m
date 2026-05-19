%% Network MAIN

clear all
close all
clc

% All params are stored in a separate file
load paramsEpisodicSemantic
load synapses2Seq_Hippocampus_rng80
load sinapsi_prova1000 %synapsesAllConcepts_Semantic
load semantica_vettori.mat
load sinapsi_lexical_prova400

Wp_SEMSEM = W;

% 12 features for the 1st Seq
Npop_EP = 150;
% 149 features for 52 concepts
Npop_SEM = 149;



%% Episodes and features list

load 1stSeq_episodes
load 2ndSeq_episodes
load All_features

Af_CORTEXCORTEX = zeros(Npop_SEM,Npop_SEM);

episodes = {ep1, ep2, ep3, ep4, ep5, ep6, ep7, ep8};

episodes_sem = {ep1, ep2, ep3, ep4, ep5, ep6, [96 144 60], ep8};

for i = 1:numel(episodes_sem)
    cols = episodes_sem{i};
    for c = cols
        rows = setdiff(1:Npop_SEM, c);
        Af_CORTEXCORTEX(rows, c) = 0.75; %0.75
    end
end


%% (further) Params

% Time
t_sim=.35; % simulation time
dt=0.0001; % integration steps
t=0:dt:(t_sim); % time vector
T=length(t);

% Fixed synapses between layers:
Wp_CA3mPFC=eye(Npop_EP)*125; % synapses from mPFC to CA3
Wp_CA1CA3=eye(Npop_EP)*250; % synapses from CA3 to CA1

% DISCONNECTING CORTEX FROM HIPPOCAMPUS?
Wp_CORTEXCA3=eye(Npop_SEM, Npop_EP)*250; % synapses from CA3 to CORTEX 
Wp_CORTEXCA3(60,150)=250; 


% Hetero-associative synapses from Semantic to Cortex trained during the SWS simulation 
load Wp_CORTEXSEM
Wp_CORTEXSEM =Wp_CORTEXSEM;

%% Wp_CORTEXSEM_MAX e MAXSUM_Wp_CORTEXSEM (poi andranno tolti perchè dovrebbe essere sufficente l'addestramento)

% Wp_CORTEXSEM(Wp_CORTEXSEM>=4)=35; %35
% 
%  
% MAXSUM_Wp_CORTEXSEM=1000;
% for i=1:Npop_SEM
%         S=sum(Wp_CORTEXSEM(i,:),2);
%         if S>MAXSUM_Wp_CORTEXSEM
%             Wp_CORTEXSEM(i,:)=Wp_CORTEXSEM(i,:).*(MAXSUM_Wp_CORTEXSEM/S);
%         end
% end

%%

% Delay intra Cortex layer
D_CORTEXCORTEX = 1;
% Delay Cortex layer --> Semantic layer
D_SEMCORTEX = 120; % 15 ms
D_LEXSEM = 120;
% Delay Semantic layer --> Cortex layer
D_CORTEXSEM = 120; % the same in the other sense?

w_at=0.9;


%% SIMULATION

% nothing from the mPFC - Hippocampus

INPUT_mPFC=zeros(Npop_EP,T);
buff=zeros(Npop_EP,round(0.05/dt));
pos1=[78];
buff(pos1,:)=0;
INPUT_mPFC(:,0.002/dt+51:0.002/dt+550)=buff;


% input directly to Cortex layer

mediaIN = zeros(Npop_SEM,round(t_sim/dt));
durata_ingresso = 100;
% in ingresso 3 features differenti da quelle specifiche dell'Ep1, ma
% appertenenti agli stessi concetti
pos1 = [79]; %Ep1 (first ep of 1st Seq): 78 daughter; 31 fish dish; 54 garden table
pos2 = [29];
pos3 = [53];

% mediaIN([ep1 ep2 ep3 ep4 ep5 ep6 ep7 ep8], 1:(durata_ingresso)) = repmat(250 + 1000 * (2*rand(1, durata_ingresso) - 1), 24, 1);
mediaIN(pos1,100:100+durata_ingresso) = 1000;
mediaIN(pos2,100:100+durata_ingresso) = 1000;
mediaIN(pos3,100:100+durata_ingresso) = 1000;


% e 3 features differenti da quelle specifiche dell'Ep4, ma
% appertenenti agli stessi concetti
pos4 = [95]; %Ep4 (first ep of 2nd Seq): 97 dog; 147 is resting; 63 tree
pos5 = [148];
pos6 = [65];

mediaIN(pos4,2000:2000+durata_ingresso) = 1000; 
mediaIN(pos5,2000:2000+durata_ingresso) = 1000;
mediaIN(pos6,2000:2000+durata_ingresso) = 1000;


rng(1900)
EpisodicSemantic_CortexRetrieval; % run the entire network simulation





%% FIGURES

% CORTEX

passoin = 1;
passofin = round(t_sim/dt);

figure()

% Input

% Cortex:
subplot(311)
title('Cortex layer: pyramidal average density of spikes'), hold on, 
plot(t,(zpc([pos1 pos2 pos3],:)),'c','LineWidth',2)
plot(t,(zpc(ep2(1:end),:)),'Color',[255 128 0]/255,'LineWidth',2)
plot(t,(zpc(ep3(1:end),:)),'g','LineWidth',2)
plot(t,(zpc(ep4(1:end),:)),'r','LineWidth',2)

plot(t,(zpc([pos4 pos5 pos6],:)),'m:','LineWidth',2)
plot(t,(zpc(ep6(1:end),:)),':','Color',[255 128 0]/255,'LineWidth',2)
ep7(3) = 60;  % the grass has only one neuron in the cortex
plot(t,(zpc(ep7(1:end),:)),'g:','LineWidth',2)
plot(t,(zpc(ep8(1:end),:)),'r:','LineWidth',2)

ylim([0 5.2])
yticks([0 5])
yticklabels({'0','5'})
xlim([0 .35])
ylim([0 5])
legend('Ep1new','','','Ep2','','','Ep3','','','Ep4','','','Ep5new','','','Ep6','','','Ep7','','','Ep8','','')
set(gca,'fontsize',10)
%%
subplot(312)
title('Semantic layer: mean pyramidal average density of spikes'), hold on, 

% funzione per attivazione percentuale nel tempo
hold on
plot(t(passoin:passofin), xs(:,passoin:passofin), 'LineWidth', 2) % 
% yline(0.95)
ylim([0 1.04])
yticks([0 1]) 
xlim([0 .35])
set(gca,'fontsize',10)
ylabel('Pyramidal neuron activity','fontsize',14),

subplot(313)
title('Lexical layer: mean pyramidal average density of spikes'), hold on
plot(t(passoin:passofin), xl(17,passoin:passofin), 'k', 'LineWidth', 2) 
plot(t(passoin:passofin), xl(6,passoin:passofin), 'b', 'LineWidth', 2) 
plot(t(passoin:passofin), xl(11,passoin:passofin), 'r', 'LineWidth', 2)
plot(t(passoin:passofin), xl(21,passoin:passofin), 'g', 'LineWidth', 2) 
plot(t(passoin:passofin), xl(32,passoin:passofin), 'c', 'LineWidth', 2)
plot(t(passoin:passofin), xl(12,passoin:passofin), 'm', 'LineWidth', 2) 
plot(t(passoin:passofin), xl(13,passoin:passofin), 'y', 'LineWidth', 2) 
plot(t(passoin:passofin), xl(31,passoin:passofin), 'Color', [0.5, 0.5, 0.5], 'LineWidth', 2) 
plot(t(passoin:passofin), xl(29,passoin:passofin), 'Color', [1, 0.5, 0.5], 'LineWidth', 2) %inteso come è felice

% tratteggiati (azioni o varianti)
plot(t(passoin:passofin), xl(20,passoin:passofin), ':b', 'LineWidth', 2)
plot(t(passoin:passofin), xl(34,passoin:passofin), ':r', 'LineWidth', 2)
plot(t(passoin:passofin), xl(14,passoin:passofin), ':g', 'LineWidth', 2)
plot(t(passoin:passofin), xl(18,passoin:passofin), ':c', 'LineWidth', 2)
plot(t(passoin:passofin), xl(16,passoin:passofin), ':m', 'LineWidth', 2)
plot(t(passoin:passofin), xl(8,passoin:passofin), ':y', 'LineWidth', 2)
plot(t(passoin:passofin), xl(33,passoin:passofin), ':', 'Color', [1.0, 0.5, 0.2], 'LineWidth', 2)
plot(t(passoin:passofin), xl(28,passoin:passofin), ':', 'Color', [0.2, 0.7, 0.4], 'LineWidth', 2)

plot(t(passoin:passofin), xl([1:5,7,9,10,15,19,22:27,30] ,passoin:passofin), ':k', 'LineWidth', 2)

legend('daughter', ...
    'fish dish', ...
    'garden table', ...
    'cat', ...
    'it is jumping', ...
    'garden chair', ...
    'grass',...
    'it is eating', ...
    'happiness', ...
    'dog',...
    'it is resting', ...
    'tree', ...
    'friend', ...
    'son', ...
    'ball', ...
    'it is running', ...
    'laugh', ...
    'other features',...
    'Location','southeastoutside')


set(gca,'fontsize',10)
xlabel('time (s)','FontSize',14)
xlim([0 .35])