%% Network MAIN

clear all
close all
clc

% All params are stored in a separate file
load paramsEpisodicSemantic
load synapses2Seq_Hippocampus_rng80
load sinapsi_prova1000   %synapsesAllConcepts_Semantic
Wp_SEMSEM = 1.0*W;
load sinapsi_lexical_prova400

% 12 features for the 1st Seq
Npop_EP=150;
% 149 features for 52 concepts
Npop_SEM = 149;


%% Episodes and features list

load 1stSeq_episodes
load 2ndSeq_episodes
load All_features
load semantica_vettori


%% (further) Params

% Time
t_sim=1; % simulation time 20     % NOTA BENE da 15s a 25s max max
dt=0.0001; % integration steps
t=0:dt:(t_sim); % time vector
T=length(t);

% Fixed synapses between layers:
Wp_CA3mPFC=eye(Npop_EP)*0; % synapses from mPFC to CA3
Wp_CA1CA3=eye(Npop_EP)*250; % synapses from CA1 to CA1
Wp_CORTEXCA3=eye(Npop_SEM, Npop_EP)*250; % synapses from CA3 to CORTEX
Wp_CORTEXCA3(60,150)=250;

% Hetero-associative synapses from Semantic to Cortex to be trained during the SWS simulation 
Wp_CORTEXSEM = zeros(Npop_SEM,Npop_SEM);
Af_CORTEXCORTEX = zeros(Npop_SEM,Npop_SEM);
% Delay Cortex layer --> Semantic layer
D_SEMCORTEX = 120;   %75; % 7.5 ms
D_LEXSEM = 120;
D_CORTEXCA3 = 50;
% Delay Cortex layer --> Semantic layer : 7.5 ms
D_CORTEXSEM = 120;  %; % set to zero 'cause it is not relevant at this point

w_at=0.9;
Kcps = 0.5; % for no theta and low ACh levels

%% SIMULATION

INPUT_mPFC=zeros(Npop_EP,T);
% 1st input from mPFC: 1/6 of the features of ep1 (first ep of 1st Seq)
buff=zeros(Npop_EP,round(0.05/dt));
pos1=[78];
buff(pos1,:)=0;
INPUT_mPFC(:,0.03/dt+51:0.03/dt+550)=buff;

rng(120)
mediaIN=150+250*rand([Npop_EP,length(t)]); %50 %350

%mediaIN=50+350*rand([Npop_EP,length(t)]); % giocare su questi due valori (medio + randomico)
EpisodicSemantic_SlowWaveSleep_Leggero; % run the entire network simulation


%% FIGURES
xmin = 0.1;
xmax = 0.3;

% HIPPOCAMPUS + CORTEX + SEMANTIC
figure(1)

subplot(411), title('Hippocampal layer, CA1 nucleus: pyramidal average density of spikes'), hold on, 
plot(t,(zp2(ep1(1:end),:)),'b','LineWidth',2)
plot(t,(zp2(ep2(1:end),:)),'Color',[255 128 0]/255,'LineWidth',2)
plot(t,(zp2(ep3(1:end),:)),'g','LineWidth',2)
plot(t,(zp2(ep4(1:end),:)),'r','LineWidth',2)

plot(t,(zp2(ep5(1:end),:)),'b:','LineWidth',2)
plot(t,(zp2(ep6(1:end),:)),':','Color',[255 128 0]/255,'LineWidth',2)
plot(t,(zp2(ep7(1:end),:)),'g:','LineWidth',2)
plot(t,(zp2(ep8(1:end),:)),'r:','LineWidth',2)

yticks([0 5])
yticklabels({'0','5'})
ylim([0 5.2])
xlim([xmin xmax])
legend('Ep1','','','Ep2','','','Ep3','','','Ep4','','','Ep5','','','Ep6','','','Ep7','','','Ep8','','')


passoin = 1;
passofin = t_sim/dt;


subplot(412)
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
ylim([0 5.2])
yticks([0 5])
yticklabels({'0','5'})
xlim([xmin xmax])

subplot(413)
title('Semantic layer: pyramidal average density of spikes'), hold on, 
ylabel('Pyramidal neuron activity','FontSize',14),
% funzione per attivazione percentuale nel tempo
hold on
plot(t(passoin:passofin), xs(:,passoin:passofin), 'LineWidth', 2) % 
% yline(0.95)
ylim([0 1.04])
yticks([0 1]) 
yticklabels({'0','100'})
xlim([xmin xmax])

subplot(414)
title('Lexical layer: pyramidal average density of spikes'), hold on

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

yticks([0 1])
yticklabels({'0','1'})
ylim([0 1.04])
xlim([xmin xmax])
xlabel('time (s)','FontSize',14)
legend('daughter', ...
    'fish dish', ...
    'garden table', ...
    'cat', ...
    'it is jumping', ...
    'garden chair', ...
    'grass', ...
    'it is eating', ...
    'happiness', ...
    'dog', ...
    'it is resting', ...
    'tree', ...
    'friend', ...
    'son', ...
    'ball', ...
    'it is running', ...
    'laugh', ...
    'other words',...
    'Location','southeastoutside')

