%% This code is used to synchronise data from Maximus (IMU) and Delsys (EMG) systems using accelerometers from both systems placed on a common rigid body
clear all
%% Load data
% Load previously assemble Maximus data file
[filename,pathname]= uigetfile('Go get Delsys.mat file');
load([pathname,filename])

myswitch = {'Switchs'};

% Minimal  duration between contacts (in seconds)
MinimalGap = .2;

%% Définir les seuils pour  switchs
Threshold(1)=2.2; %Proximal
Threshold(3)=3.5; % Ipsilateral
Threshold(2)=3; % Contralateral

%% Nettoyer les canaux Switch
% Amenez toutes les valeurs plus petites que le plus petit seuil à 0
Delsys.(myswitch{1}).cleandata = Delsys.(myswitch{1}).rawdata;
Delsys.(myswitch{1}).cleandata(Delsys.(myswitch{1}).cleandata<min(Threshold))=0;

%trouver les switchs et leur attribuer la valeur moyenne
% Trouvez tous les instants durant lesquels une switch est activée;
% ensuite, trouvez les switchs séparés par au moins le Minimal Gap: Cela
% représente une nouvelle switch. L'index = la fin d'une switch
tempswitch = find(Delsys.(myswitch{1}).cleandata>0); 
switchend = tempswitch(diff(tempswitch)>MinimalGap*Delsys.(myswitch{1}).Fs);
switchend=[switchend,tempswitch(end)]; % La fin de la dernière switch est le dernier instant avec une switch identifiée

% Pour les switchs 2 jusqu'à la dernière, le début des switchs représente
% la première switch après la fin de la switch précédente.
for iswitch = 2:length(switchend)
    switchbegin(iswitch) = tempswitch(find(tempswitch>switchend(iswitch-1),1,'first'));
    
    % Pour chaque switch, le voltage renvoyé est la moyenne obtenue des
    % valeurs > 0 lorsque la switch est activée (permet d'éviter les
    % moments ou le voltage est trop élevé (souvent au début) et les trous
    % dans la switch.  
    nonzeroswitch = Delsys.(myswitch{1}).cleandata(switchbegin(iswitch):switchend(iswitch));
    nonzeroswitch = nonzeroswitch(nonzeroswitch>0);
    switchlevel(iswitch)=mean(nonzeroswitch);
    
    % Je reconstruis un signal de switch clean, pour visualisation
    Delsys.(myswitch{1}).cleandata(switchbegin(iswitch):switchend(iswitch)) = switchlevel(iswitch);
    
end

% Le début de la première switch est le premier instant avec une switch
% détectée
switchbegin(1)=tempswitch(1);


nonzeroswitch = Delsys.(myswitch{1}).cleandata(switchbegin(1):switchend(1));
nonzeroswitch = nonzeroswitch(nonzeroswitch>0);
switchlevel(1)=mean(nonzeroswitch);
Delsys.(myswitch{1}).cleandata(switchbegin(1):switchend(1)) =switchlevel(1);

% On considère le timing d'une switch comme étant le milieu du contact avec
% la switch
SwitchTiming = mean([switchbegin;switchend])/Delsys.(myswitch{1}).Fs;

% En fonction du voltage renvoyé par la switch et des seuils définis, on
% peut connaître quelle switch est enfoncée.
SwitchName(switchlevel<Threshold(2))={'Proximal'};
SwitchName(switchlevel>Threshold(3))={'Ipsilateral'};
SwitchName(switchlevel<Threshold(3)&switchlevel>Threshold(2))={'Contralateral'};



%% Build SyncData Table
% On construit un fichier Sync Data contenant pour chaque mouvement:
% L'instant de la switch de départ et de la switch d'arrivée. Le voltage de
% la switch de départ et de la switch d'arrivée. Le nom de la switch de
% départ et de la switch d'arrivée. Le nom du mouvement (To Ipsi, To
% Contra, From Ipsi, From Contra)
SyncData=table(SwitchTiming(1:end-1)',SwitchTiming(2:end)',switchlevel(1:end-1)',switchlevel(2:end)',SwitchName(1:end-1)',SwitchName(2:end)');


SyncData(strcmp(SyncData{:,5},'Proximal') & strcmp(SyncData{:,6},'Ipsilateral'),7)={'ToIpsi'};
SyncData(strcmp(SyncData{:,5},'Proximal') & strcmp(SyncData{:,6},'Contralateral'),7)={'ToContra'};
SyncData(strcmp(SyncData{:,5},'Ipsilateral') & strcmp(SyncData{:,6},'Proximal'),7)={'FromIpsi'};
SyncData(strcmp(SyncData{:,5},'Contralateral') & strcmp(SyncData{:,6},'Proximal'),7)={'FromContra'};

%Si la séquence des switchs ne correspond pas aux 4 mouvements attendus,
%c'est une erreur
SyncData(not(strcmp(SyncData{:,7},'ToIpsi')| strcmp(SyncData{:,7},'ToContra')| strcmp(SyncData{:,7},'FromIpsi')| strcmp(SyncData{:,7},'FromContra')),7)={'error'};

%% Écrire le nom des variables de la table SyncData
SyncData.Properties.VariableNames={'BeginTiming','EndTiming','BeginTargetVoltage','EndTargetVoltage','BeginTargetName','EndTargetName','MovementName'};

save([pathname,filename], 'Delsys');
save([pathname, 'SyncData.mat'],'SyncData');
writetable(SyncData,'SyncData.xlsx','Sheet',1);
