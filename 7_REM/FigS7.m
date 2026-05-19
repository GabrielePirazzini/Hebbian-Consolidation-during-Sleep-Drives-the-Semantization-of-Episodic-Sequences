%% Network MAIN

clear all
close all
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
RUMORE = 300; %%250


%% Episodes and features list

load 1stSeq_episodes
load 2ndSeq_episodes
load All_features


%% (further) Params

% Time
t_sim=2; % simulation time
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
D_LEXSEM = 120;
% Delay Semantic layer --> Cortex layerrng
D_CORTEXSEM = 120; % the same in the other sense?

w_at=0.9;


%% SIMULATION

% nothing from the mPFC - Hippocampus

INPUT_mPFC=zeros(Npop_EP,T);
buff=zeros(Npop_EP,round(0.05/dt));
pos1=[5];
buff(pos1,:)=0;
INPUT_mPFC(:,0.002/dt+51:0.002/dt+550)=buff;

rng(400)
% input directly to Cortex layer as noise
mediaIN=MEDIA+RUMORE.*rand([Npop_SEM,length(t)]); 


EpisodicSemantic_REM; % run the entire network simulation


%% FIGURES

% CORTEX

passoin = 1;
passofin = t_sim/dt;

figure(1)
sgtitle('CORTEX AND SEMANTIC')

% Input

xmin = 0.5;
xmax = 2.0;

% Cortex:
subplot(311)
title('Cortex layer: pyramidal average density of spikes'), hold on, 
plot(t,(zpc(ep1(1:end),:)),'b','LineWidth',2)
plot(t,(zpc(ep2(1:end),:)),'Color',[255 128 0]/255,'LineWidth',2)
plot(t,(zpc(ep3(1:end),:)),'g','LineWidth',2)
plot(t,(zpc(ep4(1:end),:)),'r','LineWidth',2)

plot(t,(zpc(ep5(1:end),:)),'b:','LineWidth',2)
plot(t,(zpc(ep6(1:end),:)),':','Color',[255 128 0]/255,'LineWidth',2)
ep7(3) = 60;  % the grass has only one neuron in the cortex
plot(t,(zpc(ep7(1:end),:)),'g:','LineWidth',2)
plot(t,(zpc(ep8(1:end),:)),'r:','LineWidth',2)
yticks([0 5])
yticklabels({'0','5'})
xlim([xmin xmax])
ylim([0 5])
legend('Ep1','','','Ep2','','','Ep3','','','Ep4','','','Ep5','','','Ep6','','','Ep7','','','Ep8','','')
set(gca,'fontsize',10)

% Semantic:
subplot(312)
title('Semantic layer: mean pyramidal average density of spikes'), hold on, 

% funzione per attivazione percentuale nel tempo
hold on
plot(t(passoin:passofin), xs(:,passoin:passofin), 'LineWidth', 2) % 
% yline(0.95)
xlim([xmin xmax])
ylim([0 1.04])
yticks([0 1]) 
set(gca,'fontsize',10)
ylabel('Pyramidal neuron activity','fontsize',14),


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
legend('daughter', ...
    'fish dish', ...
    'garden table', ...
    'cat', ...
    'it is jumping', ...
    'garden chair', ...
    'grass',...
    'it is eating', ...
    'smile', ...
    'dog',...
    'it is resting', ...
    'tree', ...
    'friend', ...
    'son', ...
    'ball', ...
    'it is running', ...
    'laughter', ...
    'other words',...
    'Location','southeastoutside')

title('Lexical  layer: mean pyramidal average density of spikes')
yticks([0 1])
yticklabels({'0','1'})
ylim([0 1.04])
xlim([xmin xmax])
xlabel('time (s)','FontSize',14)

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
