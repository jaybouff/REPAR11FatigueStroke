%% This code is used to synchronise data from Maximus (IMU) and Delsys (EMG) systems using accelerometers from both systems placed on a common rigid body
clear all
%% Load data
% Load previously assemble Maximus data file
[filename,pathname]= uigetfile('Go get Maximus.mat file');
load([pathname,filename])

myswitch = {'Switchs'};

% Minimal  duration between contacts
MinimalGap = .2;

Fc=15;
Ordre =2;

[b,a]=butter(Ordre,Fc/Delsys.(myswitch{1}).Fs*2);

%% Définir les seuils pour  switchs
Threshold(1)=2.2; %Proximal
Threshold(2)=3.4; % Ipsilateral
Threshold(3)=3.65; % Controlateral

%% Trouver les moments oè chaque switch sont touchées
[Height,Contact]=findpeaks(Delsys.(myswitch{1}).rawdata,'MinPeakHeight',min(Threshold));

newtarget = find(diff(Contact)>MinimalGap*Delsys.(myswitch{1}).Fs)+1 ;
TargetTime(1,:) = [Contact(1),Contact(newtarget)];
TargetTime(2,:) =[Contact(newtarget-1),Contact(end)];

TargetHeight(1) = mean(Height(1:newtarget(1)-1));
for itarget=2:size(TargetTime,2)-1
    TargetHeight(itarget) = mean(Height(newtarget(itarget-1):newtarget(itarget)-1));
end

TargetHeight(size(TargetTime,2))  = mean(Height(newtarget(end):end));
