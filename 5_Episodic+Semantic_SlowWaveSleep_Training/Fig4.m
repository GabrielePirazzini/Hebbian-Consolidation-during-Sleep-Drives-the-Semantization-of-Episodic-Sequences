clear all
close all
clc

load Wp_CORTEXSEM
load semantica_vettori
subplot(211)
hold on
stem(FIGLIA_FEMMINA,Wp_CORTEXSEM(138,FIGLIA_FEMMINA),'r','LineWidth',1)
stem(PIATTO_DI_PESCE,Wp_CORTEXSEM(138,PIATTO_DI_PESCE),'b','LineWidth',1)
stem(ERBA, Wp_CORTEXSEM(138,ERBA),'g','LineWidth',1)
feature_presenti = [FIGLIA_FEMMINA ERBA PIATTO_DI_PESCE];
altre_feature = setdiff([1:146],feature_presenti);
stem(altre_feature,Wp_CORTEXSEM(138,altre_feature),'k','LineWidth',1)
axis([0 150 0 40])
legend('Daughter',...
'Fish dish',...
'Grass','Other features')
set(gca,'fontsize',12)
title('It chews','FontSize',18)
ylabel('Synaptic weight','FontSize',18')

subplot(212)
hold on
stem(GATTO,Wp_CORTEXSEM(60,GATTO),'r','LineWidth',1)
stem(SEDIA_DA_GIARDINO,Wp_CORTEXSEM(60,SEDIA_DA_GIARDINO),'b','LineWidth',1)
stem(STA_SALTANDO, Wp_CORTEXSEM(60,STA_SALTANDO),'g','LineWidth',1)
stem(AMICO,Wp_CORTEXSEM(60,AMICO),'r--','LineWidth',1)
stem(FIGLIO_MASCHIO,Wp_CORTEXSEM(60,FIGLIO_MASCHIO),'b--','LineWidth',1)
stem(PALLA, Wp_CORTEXSEM(60,PALLA),'g--','LineWidth',1)
feature_presenti = [GATTO SEDIA_DA_GIARDINO STA_SALTANDO AMICO FIGLIO_MASCHIO PALLA];
altre_feature = setdiff([1:146],feature_presenti);
stem(altre_feature,Wp_CORTEXSEM(60,altre_feature),'k','LineWidth',1)
axis([0 150 0 40])
legend('Cat',...
'Garden chair',...
'It is jumping',...
'A friend','Son','Ball','Other features')
set(gca,'fontsize',12)
title('It is green','FontSize',18)
xlabel('Semantic feature','FontSize',18')
ylabel('Synaptic weight','FontSize',18')
