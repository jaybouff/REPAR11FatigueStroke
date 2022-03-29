clear all
close all

%%switches
visualisation=0;

%% Constantes
myconditions={'nocomp','comp20','comp60','comp80','comp100'};
mymuscles={'DeltA','DeltM','DeltP','BB','TB'};

% Paramètre filtre EMG
Frequence=[20,450];
Ordre= 2;

% Channel EMG
chanEMG=[1,5,9,13,17];

% Channel Sync
chanSync=18:20;

% PAramètre filtre Sync
FrequenceSync=[0.2,4];
OrdreSync= 2;

% PAramètre lissage
lissagems=30;
fenetre=round(lissagems/1000*Fz);

Data.nocomp=load('nocompensation.mat');
Data.comp80=load('comp80.mat');
Data.comp60=load('comp60.mat');
Data.comp40=load('comp40.mat');
Data.comp20=load('comp20.mat');
Data.comp100=load('comp100.mat');

FrequenceEMG=[b,a]=butter(4,Frequence/Fz*2);

%% Boucle 
for itrial= 1:length(myconditions)
    
    for ichan=1:length(chanEMG)
        %bande passante 20-450Hz
    Data.(myconditions{itrial}).fdata(ichan,:)=filtfilt(b,a,Data.(myconditions{itrial}).Data(chanEMG(ichan),:));
        %rectifier
    Data.(myconditions{itrial}).absdata(ichan,:)=abs(Data.(myconditions{itrial}).fdata(ichan,:));
    end
    
    %lissage moyenne mobile
    longueur=length(Data.(myconditions{itrial}).absdata(1,:));

for i=1:longueur-fenetre
    Data.(myconditions{itrial}).smoothdata(:,i)=mean(Data.(myconditions{itrial}).absdata(:,i:i+fenetre-1),2);
end

clf
plot(Data.(myconditions{itrial}).smoothdata')

%Cible les essais
hold on
title('Cible le début et la fin des essais')
[Data.(myconditions{itrial}).debut,~]=ginput(1);
[Data.(myconditions{itrial}).fin,~]=ginput(1);

%déterminer début et fin en secondes
Data.(myconditions{itrial}).debutSec=Data.(myconditions{itrial}).debut/Data.(myconditions{itrial}).Fs(chanEMG(1));
Data.(myconditions{itrial}).finSec=Data.(myconditions{itrial}).fin/Data.(myconditions{itrial}).Fs(chanEMG(1));

%moyenne intensite emg 
Data.(myconditions{itrial}).meandata=mean(Data.(myconditions{itrial}).absdata(:,Data.(myconditions{itrial}).debut:Data.(myconditions{itrial}).fin),2);

%duree en seconde
Data.(myconditions{itrial}).duree=(Data.(myconditions{itrial}).fin-Data.(myconditions{itrial}).debut)/Fz;
    
end
% 
% %% Visualization
% couleur=({'bo','co','go','ro','mo','ko','yo'});
% if visualisation ==1
%     figure(1)
%     clf
%     for i=1:length(myconditions)
%         
%         plot(Data.(myconditions{i}).meandata,'o')
%         hold on
%     end
%     legend(myconditions)
% end

%% Couper les mouvements
debutSync = Data.(myconditions{itrial}).debutSec * Data.(myconditions{itrial}).Fs(chanSync(1));
finSync  = Data.(myconditions{itrial}).finSec * Data.(myconditions{itrial}).Fs(chanSync(1));


[b,a]=butter(4,FrequenceSync/Data.(myconditions{itrial}).Fs(chanSync(1))*2);

clf

%Filtrer le canal de synchrnisation
for ichan =1:length(chanSync)
    
    filtSync(ichan,:)=filtfilt(b,a,Data.(myconditions{itrial}).Data(chanSync(ichan),:));
    
end


accelVect = sqrt(filtSync(1,:).^2+filtSync(2,:).^2+filtSync(3,:).^2);

plot(Data.(myconditions{itrial}).debut/Data.(myconditions{itrial}).Fs(chanEMG(1)):Data.(myconditions{itrial}).fin/Data.(myconditions{itrial}).Fs(chanEMG(1)),Data.(myconditions{itrial}).smoothdata(Data.(myconditions{itrial}).debut:Data.(myconditions{itrial}).fin,:)')

%plot(accelVect(debutSync:finSync))



