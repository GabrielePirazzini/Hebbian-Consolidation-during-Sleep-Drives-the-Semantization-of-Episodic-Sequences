%% Network MAIN

clear all
% close all
clc

% All params are stored in a separate file
load 1stSeq_episodes
load 2ndSeq_episodes
load paramsEpisodicSemantic
load synapses2Seq_Hippocampus_rng80
load semantica_vettori

Npop_EP=150;
Npop_SEM = 149;

load sinapsi_lexical_prova400
load sinapsi_prova1000
Wp_SEMSEM=W;
Wp_SEMSEM = 1.*Wp_SEMSEM;      %%1         % agire qui per modificare le sinapsi della SEMANTICA

load Wp_CORTEXSEM;      
Wp_CORTEXSEM = 1.2*Wp_CORTEXSEM; %%%1.3 %%1.2       % agire qui per modificare le sinapsi FEEDBACK dalla semantica alla corteccia 

Af_CORTEXCORTEX = zeros(149,149);             
episodes = {ep1, ep2, ep3, ep4, ep5, ep6, [96,144,60], ep8};
for i = 1:numel(episodes)
    cols = episodes{i};
    for c = cols
        rows = setdiff(1:149, c);
        Af_CORTEXCORTEX(rows, c) = 1.*0.75;  
    end
end

Wp_SEMCORTEX = 3; 
Wp_SEMCORTEX = (0.8)*Wp_SEMCORTEX; %%%0.7 %%0.8         % agire qui per modificare le sinapsi FEEDFORWARD dalla corteccia alla semantica 


MEDIA = 200; %%%300 %%250 %150
RUMORE = 250; %%250


%% Episodes and features list

load 1stSeq_episodes
load 2ndSeq_episodes
load All_features


%% (further) Params

% Time
t_sim=1; % simulation time
dt=0.0001; % integration steps
t=0:dt:(t_sim); % time vector
T=length(t);

% Fixed synapses between layers:
Wp_CA3mPFC=eye(Npop_EP)*125; % synapses from mPFC to CA3
Wp_CA1CA3=eye(Npop_EP)*250; % synapses from CA3 to CA1

% DISCONNECTING CORTEX FROM HIPPOCAMPUS
Wp_CORTEXCA3=eye(Npop_EP)*0; % synapses from CA3 to CORTEX
Wp_CORTEXCA3(60,150)=0; 


% Delay intra Cortex layer
D_CORTEXCORTEX = 1;
% Delay Cortex layer --> Semantic layer
D_SEMCORTEX = 120; % 12 ms
% Delay Semantic layer --> Cortex layer
D_CORTEXSEM = 120; % the same in the other sense?

w_at=0.9;


%% SIMULATION

% nothing from the mPFC - Hippocampus

INPUT_mPFC=zeros(Npop_EP,T);
buff=zeros(Npop_EP,round(0.05/dt));
pos1=[5];
buff(pos1,:)=0;
INPUT_mPFC(:,0.002/dt+51:0.002/dt+550)=buff;

rng(300)
% input directly to Cortex layer as noise
mediaIN=MEDIA+RUMORE.*rand([Npop_SEM,length(t)]); 


EpisodicSemantic_REM; % run the entire network simulation


%% FIGURES

% CORTEX

passoin = 1;
passofin = t_sim/dt;

figure()
sgtitle('CORTEX AND SEMANTIC')

% Input

% Cortex:
subplot(311)
plot(t(passoin:passofin),zpc(FIGLIA_FEMMINA,passoin:passofin),'k','LineWidth',2) %
hold on
plot(t(passoin:passofin),zpc(PIATTO_DI_PESCE,passoin:passofin),'b','LineWidth',2) %
plot(t(passoin:passofin),zpc(TAVOLINO,passoin:passofin),'r','LineWidth',2) %

plot(t(passoin:passofin),zpc(GATTO,passoin:passofin),'g','LineWidth',2) %
plot(t(passoin:passofin),zpc(STA_SALTANDO,passoin:passofin),'c','LineWidth',2) %
plot(t(passoin:passofin),zpc(SEDIA_DA_GIARDINO,passoin:passofin),'m','LineWidth',2) %
plot(t(passoin:passofin),zpc(ERBA,passoin:passofin),'y','LineWidth',2) %
plot(t(passoin:passofin),zpc(STA_MANGIANDO,passoin:passofin),'Color', [0.5, 0.5, 0.5], 'LineWidth',2) %
plot(t(passoin:passofin),zpc(SORRISO,passoin:passofin),'Color', [1, 0.5, 0.5], 'LineWidth',2) %DA CAMBIARE IN FELICE

plot(t(passoin:passofin),zpc(CANE,passoin:passofin),':b','LineWidth',2) %
plot(t(passoin:passofin),zpc(STA_RIPOSANDO,passoin:passofin),':r','LineWidth',2) %
plot(t(passoin:passofin),zpc(ALBERO,passoin:passofin),':g','LineWidth',2) %

plot(t(passoin:passofin),zpc(AMICO,passoin:passofin),':c','LineWidth',2) %
plot(t(passoin:passofin),zpc(FIGLIO_MASCHIO,passoin:passofin),':m','LineWidth',2) %
plot(t(passoin:passofin),zpc(PALLA,passoin:passofin),':y','LineWidth',2) %

plot(t(passoin:passofin),zpc(STA_CORRENDO,passoin:passofin),':','Color', [1.0, 0.5, 0.2], 'LineWidth',2) %
plot(t(passoin:passofin),zpc(RISATA,passoin:passofin),':','Color', [0.2, 0.7, 0.4], 'LineWidth',2) %
xlim([0.15 1])
ylim([0 5])
title('Cortex')

% Semantic:
subplot(312)
act_percent = @(idxs) sum(xs(idxs, passoin:passofin), 1) / length(idxs) * 100;

hold on

plot(t(passoin:passofin), act_percent(FIGLIA_FEMMINA), 'k', 'LineWidth', 2) 
plot(t(passoin:passofin), act_percent(PIATTO_DI_PESCE), 'b', 'LineWidth', 2) 
plot(t(passoin:passofin), act_percent(TAVOLINO), 'r', 'LineWidth', 2)
plot(t(passoin:passofin), act_percent(GATTO), 'g', 'LineWidth', 2) 
plot(t(passoin:passofin), act_percent(STA_SALTANDO), 'c', 'LineWidth', 2)
plot(t(passoin:passofin), act_percent(SEDIA_DA_GIARDINO), 'm', 'LineWidth', 2) 
plot(t(passoin:passofin), act_percent(ERBA), 'y', 'LineWidth', 2) 
plot(t(passoin:passofin), act_percent(STA_MANGIANDO), 'Color', [0.5, 0.5, 0.5], 'LineWidth', 2) 
plot(t(passoin:passofin), act_percent(SORRISO), 'Color', [1, 0.5, 0.5], 'LineWidth', 2) %inteso come è felice

% tratteggiati (azioni o varianti)
plot(t(passoin:passofin), act_percent(CANE), ':b', 'LineWidth', 2)
plot(t(passoin:passofin), act_percent(STA_RIPOSANDO), ':r', 'LineWidth', 2)
plot(t(passoin:passofin), act_percent(ALBERO), ':g', 'LineWidth', 2)
plot(t(passoin:passofin), act_percent(AMICO), ':c', 'LineWidth', 2)
plot(t(passoin:passofin), act_percent(FIGLIO_MASCHIO), ':m', 'LineWidth', 2)
plot(t(passoin:passofin), act_percent(PALLA), ':y', 'LineWidth', 2)
plot(t(passoin:passofin), act_percent(STA_CORRENDO), ':', 'Color', [1.0, 0.5, 0.2], 'LineWidth', 2)
plot(t(passoin:passofin), act_percent(RISATA), ':', 'Color', [0.2, 0.7, 0.4], 'LineWidth', 2)

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
    'Location','southeastoutside')
title('Semantic')
xlim([0.15 1])

subplot(313)
hold on

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


title('Lexical')
yticks([0 1])
yticklabels({'0','1'})
ylim([0 1.04])
ylabel('object recovered')
xlim([0.15 1])
xlabel('time (s)')

% plot(t(passoin:passofin), sum(zpc(ep1,passoin:passofin))/3*20, 'k', 'LineWidth', 2) 
% plot(t(passoin:passofin), sum(zpc(ep2,passoin:passofin))/3*20, 'b', 'LineWidth', 2) 
% plot(t(passoin:passofin), sum(zpc(ep3,passoin:passofin))/3*20, 'r', 'LineWidth', 2) 
% plot(t(passoin:passofin), sum(zpc(ep4,passoin:passofin))/3*20, 'g', 'LineWidth', 2) 
% plot(t(passoin:passofin), sum(zpc(ep5,passoin:passofin))/3*20, 'c', 'LineWidth', 2) 
% plot(t(passoin:passofin), sum(zpc(ep6,passoin:passofin))/3*20, 'm', 'LineWidth', 2) 
% plot(t(passoin:passofin), sum(zpc([96,144,60],passoin:passofin))/3*20, 'y', 'LineWidth', 2) 
% plot(t(passoin:passofin), sum(zpc(ep8,passoin:passofin))/3*20, 'Color', [0.5, 0.5, 0.5], 'LineWidth', 2) 
% xlim([0.15 0.2])
% ylim([0 100])
% 
% legend('ep1','ep2','ep3','ep4','ep5','ep6','ep7','ep8')
