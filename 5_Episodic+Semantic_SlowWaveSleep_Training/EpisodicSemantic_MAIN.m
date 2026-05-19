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
t_sim=25; % simulation time 20     % NOTA BENE da 15s a 25s max max
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
D_SEMCORTEX = 140;   %75; % 7.5 ms
D_LEXSEM = 140;
D_CORTEXCA3 = 50;
% Delay Cortex layer --> Semantic layer : 7.5 ms
D_CORTEXSEM = 140;  %; % set to zero 'cause it is not relevant at this point

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

% HIPPOCAMPUS
figure(1)
subplot(311), title('CA1 nucleus: pyramidal average density of spikes'), hold on, ylabel('Zp (Hz)'), xlabel('time (s)')
plot(t,(zp2(ep1(1:end),:)),'b','LineWidth',1)
plot(t,(zp2(ep2(1:end),:)),'Color',[255 128 0]/255,'LineWidth',1)
plot(t,(zp2(ep3(1:end),:)),'g','LineWidth',1)
plot(t,(zp2(ep4(1:end),:)),'r','LineWidth',1)
plot(t,(zp2(ep5(1:end),:)),'b:','LineWidth',1)
plot(t,(zp2(ep6(1:end),:)),':','Color',[255 128 0]/255,'LineWidth',1)
plot(t,(zp2(ep7(1:end),:)),'g:','LineWidth',1)
plot(t,(zp2(ep8(1:end),:)),'r:','LineWidth',1)
yticks([0 5])
yticklabels({'0','5'})
ylim([0 5.2])
xlim([1.8 2.8])
legend('Ep1','','','Ep2','','','Ep3','','','Ep4','','','Ep5','','','Ep6','','','Ep7','','','Ep8','','')

subplot(312), 
plot(t,zpt,'b','LineWidth',1)
yticks([0 5])
yticklabels({'0','5'})
ylim([0 5.2])
xlim([1.8 2.8])

subplot(313)
plot(t,ACh,'b','LineWidth',1)
yticks([0 5])
yticklabels({'0','5'})
ylim([0 5.2])
xlim([1.8 2.8])



% HIPPOCAMPUS + CORTEX + SEMANTIC
figure(2)

subplot(411), title('Hippocampal layer, CA1 nucleus: pyramidal average density of spikes'), hold on, ylabel('Zp (Hz)'),
plot(t,(zp2(ep1(3),:)),'k','LineWidth',1)
plot(t,(zp2(ep1(1),:)),'b','LineWidth',1)
plot(t,(zp2(ep1(2),:)),'r','LineWidth',1)

plot(t,(zp2(ep2(1),:)),'r','LineWidth',1)
plot(t,(zp2(ep2(2),:)),'g','LineWidth',1)
plot(t,(zp2(ep2(3),:)),'c','LineWidth',1)

plot(t,(zp2(ep3(1),:)),'m','LineWidth',1)
plot(t,(zp2(ep3(2),:)),'k','LineWidth',1)
plot(t,(zp2(ep3(3),:)),'y','LineWidth',1)

plot(t,(zp2(ep4(1),:)),'m','LineWidth',1)
plot(t,(zp2(ep4(2),:)),'c','LineWidth',1)
plot(t,(zp2(ep4(3),:)),'Color', [0.5, 0.5, 0.5],'LineWidth',1)

plot(t,(zp2(ep5(1),:)),'b:','LineWidth',1)
plot(t,(zp2(ep5(2),:)),'r:','LineWidth',1)
plot(t,(zp2(ep5(3),:)),'g:','LineWidth',1)

plot(t,(zp2(ep6(1),:)),':c','LineWidth',1)
plot(t,(zp2(ep6(2),:)),'m:','LineWidth',1)
plot(t,(zp2(ep6(3),:)),'g:','LineWidth',1)

plot(t,(zp2(ep7(1),:)),':', 'Color', [1.0, 0.5, 0.2],'LineWidth',1)
plot(t,(zp2(ep7(2),:)),':', 'Color', [0.5, 0.2, 0.7],'LineWidth',1)
plot(t,(zp2(ep7(3),:)),'y:','LineWidth',1)

plot(t,(zp2(ep8(1),:)),'m:','LineWidth',1)
plot(t,(zp2(ep8(2),:)),'b:','LineWidth',1)
plot(t,(zp2(ep8(3),:)),'g','LineWidth',1)

yticks([0 5])
yticklabels({'0','5'})
ylim([0 5.2])
xlim([2.18 2.32])
legend('Ep1','','','Ep2','','','Ep3','','','Ep4','','','Ep5','','','Ep6','','','Ep7','','','Ep8','','')


passoin = 1;
passofin = t_sim/dt;

subplot(412)
title('Cortex layer: pyramidal average density of spikes'), hold on, ylabel('Zp (Hz)'),
plot(t(passoin:passofin),zpc(FIGLIA_FEMMINA,passoin:passofin),'k','LineWidth',2) %
plot(t(passoin:passofin),zpc(PIATTO_DI_PESCE,passoin:passofin),'b','LineWidth',2) %
plot(t(passoin:passofin),zpc(TAVOLINO,passoin:passofin),'r','LineWidth',2) %
plot(t(passoin:passofin),zpc(GATTO,passoin:passofin),'g','LineWidth',2) %
plot(t(passoin:passofin),zpc(STA_SALTANDO,passoin:passofin),'c','LineWidth',2) %
plot(t(passoin:passofin),zpc(SEDIA_DA_GIARDINO,passoin:passofin),'m','LineWidth',2) %
plot(t(passoin:passofin),zpc(ERBA,passoin:passofin),'y','LineWidth',2) %
plot(t(passoin:passofin),zpc(STA_MANGIANDO,passoin:passofin),'Color', [0.5, 0.5, 0.5], 'LineWidth',2) %
plot(t(passoin:passofin),zpc(SORRISO,passoin:passofin),'Color',[1.0, 0.5, 0.2],'LineWidth',2) %INTESO COME è FELICE
% hold on 
plot(t(passoin:passofin),zpc(CANE,passoin:passofin),':r','LineWidth',2) %
plot(t(passoin:passofin),zpc(STA_RIPOSANDO,passoin:passofin),':g','LineWidth',2) %
plot(t(passoin:passofin),zpc(ALBERO,passoin:passofin),':c','LineWidth',2) %
plot(t(passoin:passofin),zpc(AMICO,passoin:passofin),':m','LineWidth',2) %
plot(t(passoin:passofin),zpc(FIGLIO_MASCHIO,passoin:passofin),':y','LineWidth',2) %
plot(t(passoin:passofin),zpc(PALLA,passoin:passofin),':','Color', [1.0, 0.5, 0.2], 'LineWidth',2) %
plot(t(passoin:passofin),zpc(STA_CORRENDO,passoin:passofin),':','Color', [0.2, 0.7, 0.4], 'LineWidth',2) %
plot(t(passoin:passofin),zpc(RISATA,passoin:passofin),':','Color', [0.5, 0.2, 0.7], 'LineWidth',2) %xlim([3.22 3.36])
yline(0.95*5)
ylim([0 5.2])
yticks([0 5])
yticklabels({'0','5'})
xlim([2.18 2.32])

subplot(413)
title('Semantic layer: mean pyramidal average density of spikes'), hold on, ylabel('Features recovered (%)'),
% funzione per attivazione percentuale nel tempo
act_percent = @(idxs) sum(xs(idxs, passoin:passofin), 1) / length(idxs) * 100;
hold on
plot(t(passoin:passofin), act_percent(FIGLIA_FEMMINA), 'k', 'LineWidth', 2) % 
plot(t(passoin:passofin), act_percent(PIATTO_DI_PESCE), 'b', 'LineWidth', 2) % 
plot(t(passoin:passofin), act_percent(TAVOLINO), 'r', 'LineWidth', 2) % 
plot(t(passoin:passofin), act_percent(GATTO), 'g', 'LineWidth', 2) % 
plot(t(passoin:passofin), act_percent(STA_SALTANDO), 'c', 'LineWidth', 2) % 
plot(t(passoin:passofin), act_percent(SEDIA_DA_GIARDINO), 'm', 'LineWidth', 2) % 
plot(t(passoin:passofin), act_percent(ERBA), 'y', 'LineWidth', 2) 
plot(t(passoin:passofin), act_percent(STA_MANGIANDO), 'Color', [0.5, 0.5, 0.5], 'LineWidth', 2) 
plot(t(passoin:passofin), act_percent(SORRISO),'Color',[1.0, 0.5, 0.2],'LineWidth',2) %INTESO COME è FELICE

% tratteggiati (azioni o varianti)
plot(t(passoin:passofin), act_percent(CANE), ':r', 'LineWidth', 2) %
plot(t(passoin:passofin), act_percent(STA_RIPOSANDO), ':g', 'LineWidth', 2) % 
plot(t(passoin:passofin), act_percent(ALBERO), ':c', 'LineWidth', 2) % 
plot(t(passoin:passofin), act_percent(AMICO), ':m', 'LineWidth', 2) % 
plot(t(passoin:passofin), act_percent(FIGLIO_MASCHIO), ':y', 'LineWidth', 2) %
plot(t(passoin:passofin), act_percent(PALLA), ':', 'Color', [1.0, 0.5, 0.2], 'LineWidth', 2) % 
plot(t(passoin:passofin), act_percent(STA_CORRENDO), ':', 'Color', [0.2, 0.7, 0.4], 'LineWidth', 2) % 
plot(t(passoin:passofin), act_percent(RISATA), ':', 'Color', [0.5, 0.2, 0.7], 'LineWidth', 2) % 
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
    'Location','southeastoutside')
% yline(0.95)
ylim([0 104])
yticks([0 100]) 
yticklabels({'0','100'})
xlim([2.18 2.32])
xlabel('time (s)')

subplot(414)
title('Lexical layer'), hold on

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
xlim([2.18 2.32])
ylabel('object recovered')
xlim([0.03 t_sim])
xlabel('time (s)')



% SEMANTIC SUBDIVIDED
figure(3)

sgtitle('Semantic layer: mean pyramidal average density of spikes'),
% funzione per attivazione percentuale nel tempo
act_percent = @(idxs) sum(xs(idxs, passoin:passofin), 1) / length(idxs) * 100;

subplot(221)
plot(t(passoin:passofin), act_percent(FIGLIA_FEMMINA), 'k', 'LineWidth', 2) % table
hold on
plot(t(passoin:passofin), act_percent(PIATTO_DI_PESCE), 'b', 'LineWidth', 2) % fish dish
plot(t(passoin:passofin), act_percent(TAVOLINO), 'r', 'LineWidth', 2) % daughter
xlim([2.18 2.32])
ylim([0 104])
ylabel('Features recovered (%)')
xlabel('time (s)')
legend('daughter',...
    'fish', ...
    'garden table', ...
    'Location','southwest')

subplot(222)
plot(t(passoin:passofin), act_percent(GATTO), 'm', 'LineWidth', 2) % daughter
hold on 
plot(t(passoin:passofin), act_percent(STA_SALTANDO), 'g', 'LineWidth', 2) % smile
plot(t(passoin:passofin), act_percent(SEDIA_DA_GIARDINO), 'c', 'LineWidth', 2) % cake
xlim([2.18 2.32])
ylim([0 104])
ylabel('Features recovered (%)')
xlabel('time (s)')

legend('cat', ...
    'it is jumping', ...
    'garden chair', ...
    'Location','southwest')

subplot(223)
plot(t(passoin:passofin), act_percent(FIGLIA_FEMMINA), 'k', 'LineWidth', 2) % cat
hold on
plot(t(passoin:passofin), act_percent(PIATTO_DI_PESCE), 'b', 'LineWidth', 2) % table
plot(t(passoin:passofin), act_percent(ERBA), 'y', 'LineWidth', 2) % it is jumping
xlim([2.18 2.32])
ylim([0 104])
ylabel('Features recovered (%)')
xlabel('time (s)')

legend('daughter', ...
    'fish', ...
    'grass', ...
    'Location','southwest')

subplot(224)
plot(t(passoin:passofin), act_percent(GATTO), 'm', 'LineWidth', 2) % cat
hold on 
plot(t(passoin:passofin), act_percent(STA_MANGIANDO), 'Color', [1, 0.5, 0.5] , 'LineWidth', 2) % cake
plot(t(passoin:passofin), act_percent(SORRISO), 'Color', [0.5, 0.5, 0.5], 'LineWidth', 2) % it is eaten
xlim([2.18 2.32])
ylim([0 104])
ylabel('Features recovered (%)')
xlabel('time (s)')

legend('cat', ...
    'it is eating', ...
    'happiness', ...
    'Location','southwest')

%%
% SEMANTIC SUBDIVIDED
figure(4)

sgtitle('Semantic layer: mean pyramidal average density of spikes'),
% funzione per attivazione percentuale nel tempo
act_percent = @(idxs) sum(xs(idxs, passoin:passofin), 1) / length(idxs) * 100;

subplot(221)
plot(t(passoin:passofin), act_percent(CANE), ':k', 'LineWidth', 2) % table
hold on
plot(t(passoin:passofin), act_percent(STA_RIPOSANDO), ':b', 'LineWidth', 2) % fish dish
plot(t(passoin:passofin), act_percent(ALBERO), ':r', 'LineWidth', 2) % daughter
xlim([2.18 2.32])
ylim([0 104])
ylabel('Features recovered (%)')
xlabel('time (s)')
legend('dog',...
    'it is resting', ...
    'tree', ...
    'Location','southwest')

subplot(222)
plot(t(passoin:passofin), act_percent(AMICO), ':m', 'LineWidth', 2) % daughter
hold on 
plot(t(passoin:passofin), act_percent(FIGLIO_MASCHIO), ':g', 'LineWidth', 2) % smile
plot(t(passoin:passofin), act_percent(PALLA), ':c', 'LineWidth', 2) % cake
xlim([2.18 2.32])
ylim([0 104])
ylabel('Features recovered (%)')
xlabel('time (s)')

legend('friend', ...
    'son', ...
    'ball', ...
    'Location','southwest')

subplot(223)
plot(t(passoin:passofin), act_percent(CANE), ':k', 'LineWidth', 2) % cat
hold on
plot(t(passoin:passofin), act_percent(STA_CORRENDO), ':', 'Color', [0.2, 1, 1] , 'LineWidth', 2) % table
plot(t(passoin:passofin), act_percent(ERBA), ':y', 'LineWidth', 2) % it is jumping
xlim([2.18 2.32])
ylim([0 104])
ylabel('Features recovered (%)')
xlabel('time (s)')

legend('dog', ...
    'it is running', ...
    'grass', ...
    'Location','southwest')

subplot(224)
plot(t(passoin:passofin), act_percent(FIGLIO_MASCHIO), ':m', 'LineWidth', 2) % cat
hold on 
plot(t(passoin:passofin), act_percent(AMICO), ':g', 'LineWidth', 2) % cake
plot(t(passoin:passofin), act_percent(RISATA), ':' ,'Color', [0.5, 0.5, 0.5], 'LineWidth', 2) % it is eaten
xlim([2.18 2.32])
ylim([0 104])
ylabel('Features recovered (%)')
xlabel('time (s)')

legend('son', ...
    'friend', ...
    'lugh', ...
    'Location','southwest')
%%  
save('Wp_CORTEXSEM140','Wp_CORTEXSEM')
