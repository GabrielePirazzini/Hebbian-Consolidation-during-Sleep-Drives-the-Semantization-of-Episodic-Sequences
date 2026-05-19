clc, clear, close all

% NOMI DELLE VARIABILI: 
% 34 elementi finali in maiuscolo
% categorie in minuscolo
% al posto degli spazi trattino basso

mobile=[1,2];
quattro_gambe=[mobile,3,4];
TAVOLO=[1:8];
SEDIA=[1:4,9:12];
riposo=[mobile,13:15];
DIVANO=[1,2,13:18];
LETTO=[1,2,13:15,19:21];

cibo=22:24;
TORTA=22:28;
PIATTO_DI_PESCE=[cibo, 29:31];
SALSICCIA=[cibo,32:34];

gioco=35:37;
PALLA=[gioco, 26, 38:40];
BAMBOLA=[gioco, 42:44];
LEGO=[gioco, 45:47];

giardino=48:49;
elemento_di_giardino=48:51;
TAVOLINO=[48:54, 8];
SEDIA_DA_GIARDINO=[elemento_di_giardino,9,55:57];
vegetale=[giardino,58,59];
ERBA=[48,49,58:62];
ALBERO=[vegetale,63:66];
FIORE=[vegetale,67,64,68,69];

bimbo=70:72;
figlio=70:74;
FIGLIO_MASCHIO=70:77;
FIGLIA_FEMMINA=[figlio,78:80];
estraneo=[bimbo,81,82];
AMICO=[70:72,81:85];
SCONOSCIUTO=[70:72,81,82,86:88];

animale=89:91;
mammifero=[animale, 92,93];
domestico=[mammifero, 94,44];
CANE=[domestico, 95:97];
GATTO=[domestico, 98:101];
erbivoro=[mammifero,102,103];
CONIGLIO=[domestico,102,103,104:106,101];
MUCCA=[erbivoro,107,109];
PECORA=[erbivoro, 110:112];
uccello=[animale,113,114];
GALLO=[uccello,115:117];
PICCIONE=[uccello,118:120];
PAPPAGALLO=[uccello,121:123];

sentimento=124:126;
RISATA=[sentimento,127:129];
SORRISO=[sentimento, 130:132];
CAREZZA=[sentimento,133:135];

azione=[136,137];
STA_MANGIANDO=[azione, 127, 138:140];
STA_SALTANDO=[azione, 141:143];
STA_CORRENDO=[azione, 144:146];
STA_RIPOSANDO=[azione, 147:149];

save('semantica_vettori')
