clear all
close all

%% Load Delsys file
[filename,pathname]=uigetfile('Go get your EMG file');

data=load([pathname,filename]);

%% Switches
isswitch =1;
issyncXsens = 1;

%% Constantes
mymuscles={'DeltA','DeltM','UT','BB','TB'};
mysyncs = {'SyncAccelX','SyncAccelY','SyncAccelZ'};
myswitch = {'Switchs'};

% ParamètreEMG
% Channel EMG
chanEMG=[1,11,21,31,41];

% Paramètre filtre EMG
Fc=[20,450];
Ordre= 2;

% PAramètre lissage
lissagems=30;

% Channel to Sync with XSens
chanSync=52:54;

% PAramètre filtre Sync
FcSync=[0.2,4];
OrdreSync= 2;

% Channel Switch
chanSwitch = 62;

%% Processing EMG

for imuscle = 1:length(chanEMG)
    %raw data
    Delsys.(mymuscles{imuscle}).rawdata = data.Data(chanEMG(imuscle),:);
    
    %Fréquence d'échantillon
    Delsys.(mymuscles{imuscle}).Fs = data.Fs(chanEMG(imuscle));
    
    % bande passante
    [b,a]=butter(Ordre,Fc/Delsys.(mymuscles{imuscle}).Fs*2);
    Delsys.(mymuscles{imuscle}).fdata = filtfilt(b,a,Delsys.(mymuscles{imuscle}).rawdata);
    
    % rectifier
    Delsys.(mymuscles{imuscle}).absdata = abs(Delsys.(mymuscles{imuscle}).fdata);
    
    % lissage moyenne mobile
    longueur=length(Delsys.(mymuscles{imuscle}).absdata);
    fenetre=round(lissagems/1000*Delsys.(mymuscles{imuscle}).Fs);
    
    for i=1:longueur-fenetre
    Delsys.(mymuscles{imuscle}).smoothdata(i)=mean(Delsys.(mymuscles{imuscle}).absdata(i:i+fenetre-1));
    end
    
end

%% Extracting signal to sync with XSens
if issyncXsens
    for isync = 1:length(chanSync)
        %raw data
        Delsys.(mysyncs{isync}).rawdata = data.Data(chanSync(isync),:);
        
        %Fréquence d'échantillon
        Delsys.(mysyncs{isync}).Fs = data.Fs(chanSync(isync));
        
        % bande passante
        [b,a]=butter(OrdreSync,FcSync/Delsys.(mysyncs{isync}).Fs*2);
        Delsys.(mysyncs{isync}).fdata = filtfilt(b,a,Delsys.(mysyncs{isync}).rawdata);
        
    end
end

%% Extracting signal from the buttons
if isswitch
    
    Delsys.(myswitch{1}).rawdata = data.Data(chanSwitch,:);
    Delsys.(myswitch{1}).Fs = data.Fs(chanSwitch);
   
end

save([pathname,'Processed',filename],'Delsys');
    
