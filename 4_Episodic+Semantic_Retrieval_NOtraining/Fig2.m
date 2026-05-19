%% Network MAIN

clear all
close all
clc

% We stored in a separate file all params (for robustness and sensitivity tests)
% Please refers to the manuscript (also "Supplementary Informations")
load paramsEpisodicSemantic
load synapses2Seq_Hippocampus_rng80.mat
load sinapsi_prova1000
load sinapsi_lexical_prova400
Wp_SEMSEM = W;

Wp_SEMSEM = 1.*Wp_SEMSEM;

Npop_Ep=150;
Npop_SEM = 149;


%% Episodes and features list

load 1stSeq_episodes
load 2ndSeq_episodes

load All_features


%% (further) Params

% Time
t_sim=0.45; % simulation time
dt=0.0001; % integration steps
t=0:dt:(t_sim); % time vector
T=length(t);

% Fixed synapses between layers:
Wp_CA3mPFC=eye(Npop_Ep)*125;   % synapses from mPFC to CA3
Wp_CA1CA3=eye(Npop_Ep)*250;    % synapses from CA1 to CA1
Wp_CORTEXCA3=eye(Npop_SEM, Npop_Ep)*250; % synapses from CA3 to CORTEX 
Wp_CORTEXCA3(60,150)=250; 

D_SEMCORTEX = 120; % delay from cortex to semantic
D_LEXSEM = 120;

w_at=0.9;


%% SIMULATION

INPUT_mPFC=zeros(Npop_Ep,T);
% 1st input from mPFC: 1/3 of the features of Ep1 (first ep of 1st Seq)
buff=zeros(Npop_Ep,round(0.05/dt));
pos1=[78];
buff(pos1,:)=1;
INPUT_mPFC(:,0.03/dt+51:0.03/dt+550)=buff;

buff=zeros(Npop_Ep,round(0.05/dt));
pos2=[97];
buff(pos2,:)=1;
INPUT_mPFC(:,0.24/dt+51:0.24/dt+550)=buff;

EpisodicSemantic_Retrieval; % run the entire network simulation


%% FIGURE
load('semantica_vettori.mat');

figure()

% hippocampus
subplot(511), title('Medial septum: pyramidal average density of spikes'), hold on, 
%ylabel('Zp')
plot(t,zpt,'b','LineWidth',2)

yticks([0 5])
yticklabels({'0','5'})
ylim([0 5.2])
xlim([0.03 t_sim])
set(gca,'fontsize',10)

% hippocampus
subplot(512), title('Hippocampal layer, CA1 nucleus: pyramidal average density of spikes'), hold on, 
%ylabel('Zp')
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
xlim([0.03 t_sim])
legend('Ep1','','','Ep2','','','Ep3','','','Ep4','','','Ep5','','','Ep6','','','Ep7','','','Ep8','','')
set(gca,'fontsize',10)

% cortex
passoin = 0.03/dt;
passofin = t_sim/dt;
subplot(513)
hold on 
title('Cortex layer: pyramidal average density of spikes');
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
ylim([0 5.2])
xlim([0.03 t_sim])
ylabel('Pyramidal neuron activity','fontsize',14)
set(gca,'fontsize',10)

% semantic
subplot(514)
hold on
title('Semantic layer: pyramidal average density of spikes');
passoin = 1;
passofin = length(t);

plot(t(passoin:passofin), xs(:,passoin:passofin), ':', 'LineWidth', 2) 
yticks([0 1])
yticklabels({'0','1'})
ylim([0 1.04])
%ylabel('Semantic activity')
xlim([0.03 t_sim])
set(gca,'fontsize',10)

% linguistic
subplot(515)

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


legend('daughter','fish dish','garden table','cat','it is jumping',...
    'garden chair','grass','it is eating','it is happy',...
    'dog','it is resting','tree','friend',...
    'son','ball','it is running','it is laughing', 'other words', ...
    'Location','southeastoutside')

title('Lexical layer: mean pyramidal average density of spikes')
yticks([0 1])
yticklabels({'0','1'})
ylim([0 1.04])
%ylabel('Lexical activity')
xlim([0.03 t_sim])
set(gca,'fontsize',10)
xlabel('time (s)','FontSize',14)



