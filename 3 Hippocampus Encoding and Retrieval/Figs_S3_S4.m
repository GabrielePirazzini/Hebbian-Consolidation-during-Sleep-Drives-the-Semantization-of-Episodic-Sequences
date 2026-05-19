%% Network MAIN
%rng

clear all
close all
clc

% All params are stored in a separate file
load paramsEpisodic

Npop=150; % equal to semantic Units


%% Episodes list

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


%% (further) Params

% Time
t_sim=4.125; % simulation time 
dt=0.0001; % integration steps
t=0:dt:(t_sim); % time vector
T=length(t);

% Fixed synapses between layers:
Wp_CA3mPFC=eye(Npop)*125; % synapses from mPFC to CA3
Wp_CA1CA3=eye(Npop)*250; % synapses from CA1 to CA1

w_at=0.9;


%% SIMULATION

INPUT_mPFC=zeros(Npop,T);
% 1st input from mPFC: 1/3 of the features of Ep1 (first ep of 1st Seq)
buff=zeros(Npop,round(0.05/dt));
pos1=[78];
buff(pos1,:)=1;
INPUT_mPFC(:,2.65/dt+51:2.65/dt+550)=buff;

% 1st input from mPFC: 1/3 of the features of Ep1 (first ep of 1st Seq)
buff=zeros(Npop,round(0.05/dt));
pos2=[97];
buff(pos2,:)=1;
INPUT_mPFC(:,3.25/dt+51:3.25/dt+550)=buff;

Trand=round(-200+(200+200)*rand)*dt; % inputs from EC could vary randomly inside a 200ms interval

rng(80)

Episodic_EncodingRetrieval; % run the entire network simulation


%% FIGURE

% ENCODING

figure(1)

subplot(511), title('Medial prefrontal cortex: pyramidal average density of spikes'), hold on, ylabel('Zp (Hz)'),
plot(t,(zp0(78,:)),'b','LineWidth',0.75)
hold on 
plot(t,(zp0(97,:)),'b:','LineWidth',0.75)
plot(t,(zp0([1:77 79:96 98:150],:)),'k','LineWidth',0.75)
legend('Partial input from Ep1', 'Partial input from Ep5')
yticks([0 5])
yticklabels({'0','5'})
ylim([0 5.2])
xlim([0.1 2.5])

subplot(512), title('Medial septum-vertical limb of the diagonal band of Broca: pyramidal average density of spikes'), hold on, ylabel('Zp (Hz)')
plot(t,zpt,'k','LineWidth',0.75)
yticks([0 5])
yticklabels({'0','5'})
ylim([0 5.2])
xlim([0.1 2.5])

subplot(513), title('Fraction of hippocampal receptor sites occupied by ACh'), hold on, ylabel('F')
plot(t,ACh,'k','LineWidth',0.75)
yticks([0 0.5 1])
yticklabels({'0','0.5','1'})
ylim([0 1.04])
xlim([0.1 2.5])

subplot(514), title('CA3 nucleus: pyramidal average density of spikes'), hold on, ylabel('Zp (Hz)')%, xlabel('time (s)')
plot(t,(zp1(ep1(1:end),:)),'b','LineWidth',1)
plot(t,(zp1(ep2(1:end),:)),'Color',[255 128 0]/255,'LineWidth',1)
plot(t,(zp1(ep3(1:end),:)),'g','LineWidth',1)
plot(t,(zp1(ep4(1:end),:)),'r','LineWidth',1)

plot(t,(zp1(ep5(1:end),:)),'b:','LineWidth',1)
plot(t,(zp1(ep6(1:end),:)),':','Color',[255 128 0]/255,'LineWidth',1)
plot(t,(zp1(ep7(1:end),:)),'g:','LineWidth',1)
plot(t,(zp1(ep8(1:end),:)),'r:','LineWidth',1)

yticks([0 5])
yticklabels({'0','5'})
ylim([0 5.2])
xlim([0.1 2.5])

subplot(515), title('CA1 nucleus: pyramidal average density of spikes'), hold on, ylabel('Zp (Hz)'), xlabel('time (s)')
plot(t,(zp2(ep1(1:end),:)),'b','LineWidth',1)
plot(t,(zp2(ep2(1:end),:)),'Color',[255 128 0]/255,'LineWidth',1)
plot(t,(zp2(ep3(1:end),:)),'g','LineWidth',1)
plot(t,(zp2(ep4(1:end),:)),'r','LineWidth',1)

plot(t,(zp1(ep5(1:end),:)),'b:','LineWidth',1)
plot(t,(zp1(ep6(1:end),:)), ':', 'Color',[255 128 0]/255,'LineWidth',1)
plot(t,(zp1(ep7(1:end),:)),'g:','LineWidth',1)
plot(t,(zp1(ep8(1:end),:)),'r:','LineWidth',1)

yticks([0 5])
yticklabels({'0','5'})
ylim([0 5.2])
xlim([0.1 2.5])
legend('Ep1','','','Ep2','','','Ep3','','','Ep4','','','Ep5','','','Ep6','','','Ep7','','','Ep8','','')

sgtitle('ENCODING OF THE TWO SEQUENCES')


% RETRIEVAL

figure(2)

subplot(411), title('Medial prefrontal cortex: pyramidal average density of spikes'), hold on, ylabel('Zp (Hz)'),
plot(t,(zp0(78,:)),'b','LineWidth',0.75)
hold on 
plot(t,(zp0(97,:)),'b:','LineWidth',0.75)
plot(t,(zp0([1:77 79:96 98:150],:)),'k','LineWidth',0.75)
legend('Partial input from Ep1', 'Partial input from Ep5')
yticks([0 5])
yticklabels({'0','5'})
ylim([0 5.2])
xlim([2.675 4.06])

subplot(412), title('Medial septum-vertical limb of the diagonal band of Broca: pyramidal average density of spikes'), hold on, ylabel('Zp (Hz)')
plot(t,zpt,'k','LineWidth',0.75)
yticks([0 5])
yticklabels({'0','5'})
ylim([0 5.2])
xlim([2.675 4.06])

subplot(413), title('Fraction of hippocampal receptor sites occupied by ACh'), hold on, ylabel('F')
plot(t,ACh,'k','LineWidth',0.75)
yticks([0 0.5 1])
yticklabels({'0','0.5','1'})
ylim([0 1.04])
xlim([2.675 4.06])

% subplot(514), title('CA3 nucleus: pyramidal average density of spikes'), hold on, ylabel('Zp (Hz)')%, xlabel('time (s)')
% plot(t,(zp1(ep1(1:end),:)),'b','LineWidth',1)
% plot(t,(zp1(ep2(1:end),:)),'Color',[255 128 0]/255,'LineWidth',1)
% plot(t,(zp1(ep3(1:end),:)),'g','LineWidth',1)
% plot(t,(zp1(ep4(1:end),:)),'r','LineWidth',1)
% 
% plot(t,(zp2(ep5(1:end),:)),'b:','LineWidth',1)
% plot(t,(zp2(ep6(1:end),:)), ':', 'Color',[255 128 0]/255,'LineWidth',1)
% plot(t,(zp2(ep7(1:end),:)),'g:','LineWidth',1)
% plot(t,(zp2(ep8(1:end),:)),'r:','LineWidth',1)
% 
% yticks([0 5])
% yticklabels({'0','5'})
% ylim([0 5.2])
% xlim([2.675 4.06])

subplot(414), title('CA1 nucleus: pyramidal average density of spikes'), hold on, ylabel('Zp (Hz)'), xlabel('time (s)')
plot(t,(zp2(ep1(1:end),:)),'b','LineWidth',1)
plot(t,(zp2(ep2(1:end),:)),'Color',[255 128 0]/255,'LineWidth',1)
plot(t,(zp2(ep3(1:end),:)),'g','LineWidth',1)
plot(t,(zp2(ep4(1:end),:)),'r','LineWidth',1)

plot(t,(zp2(ep5(1:end),:)),'b:','LineWidth',1)
plot(t,(zp2(ep6(1:end),:)), ':', 'Color',[255 128 0]/255,'LineWidth',1)
plot(t,(zp2(ep7(1:end),:)),'g:','LineWidth',1)
plot(t,(zp2(ep8(1:end),:)),'r:','LineWidth',1)

yticks([0 5])
yticklabels({'0','5'})
ylim([0 5.2]) 
xlim([2.675 4.06])
legend('Ep1','','','Ep2','','','Ep3','','','Ep4','','','Ep5','','','Ep6','','','Ep7','','','Ep8','','')

sgtitle('Hippocampal layer: retrieval of two previously memorized sequences')

%% save Af_CA3CA3, Wf_CA3CA3, Wp_CA3CA1, Wp_CA3CA3
save('synapses2Seq_Hippocampus.mat', 'Af_CA3CA3', 'Wf_CA3CA3', 'Wp_CA3CA1', 'Wp_CA3CA3');

