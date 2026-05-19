clc, clear, close all

load Wp_CORTEXSEM_31-10.mat
load 1stSeq_episodes
load 2ndSeq_episodes
load semantica_vettori

% Wp_CORTEXSEM =4*Wp_CORTEXSEM;
% 
% Wp_CORTEXSEM(Wp_CORTEXSEM>=30)=30;

figure(),stem(Wp_CORTEXSEM(128,[CANE, STA_CORRENDO, ERBA]))

%%
ep7(ep7==150)=60;

SEM=[CANE, STA_CORRENDO, ERBA];

%SEM1=[FIGLIA_FEMMINA, PIATTO_DI_PESCE, TAVOLINO]
%SEM2=[GATTO, STA_SALTANDO, SEDIA_DA_GIARDINO]
%SEM3=[FIGLIA_FEMMINA, ERBA, PIATTO_DI_PESCE]
%SEM4=[GATTO, STA_MANGIANDO, SORRISO]

%SEM5=[CANE, STA_RIPOSANDO, ALBERO]
%SEM6=[FIGLIO_MASCHIO, AMICO, PALLA]
%SEM7=[CANE, STA_CORRENDO, ERBA]
%SEM8=[FIGLIO_MASCHIO, AMICO, RISATA]

%N.B quando è max deve essere circa a 1800

from_sem_to_cort(1)=sum(sum(Wp_CORTEXSEM(ep1,SEM)));
from_sem_to_cort(2)=sum(sum(Wp_CORTEXSEM(ep2,SEM)));
from_sem_to_cort(3)=sum(sum(Wp_CORTEXSEM(ep3,SEM)));
from_sem_to_cort(4)=sum(sum(Wp_CORTEXSEM(ep4,SEM)));
from_sem_to_cort(5)=sum(sum(Wp_CORTEXSEM(ep5,SEM)));
from_sem_to_cort(6)=sum(sum(Wp_CORTEXSEM(ep6,SEM)));
from_sem_to_cort(7)=sum(sum(Wp_CORTEXSEM(ep7,SEM)));
from_sem_to_cort(8)=sum(sum(Wp_CORTEXSEM(ep8,SEM)));

f=from_sem_to_cort
max_ep=find(f==max(f))


