clear all
close all

%% Load Maximus file
[filename,pathname]=uigetfile('Go get your Maximus output file');
data = importdata([pathname,filename]);


%% Constant
nsignal= 27;

mySegments = {'Hand','Forearm','Arm','Scapula','Thorax', 'Sync'};
SegmentsOrder = [8,6,5,3,10,2];

mySignals = {'AccelX','AccelY','AccelZ',...
    'GyroX','GyroY','GyroZ'...
    ,'q11','q21','q31','q12','q22','q23','q13','q23','q33'};

SignalOrder = [19,20,21, ...
    25,26,27,...
    1,2,3,4,5,6,7,8,9];



for isegment=1:length(mySegments)
    for isignal = 1:length(mySignals)
        Maximus.(mySegments{isegment}).(mySignals{isignal}).rawdata = ...
            data.data(:,(SegmentsOrder(isegment)-1)*nsignal+1+SignalOrder(isignal));
    end
end

save([pathname,filename, 'Maximus.mat'],'Maximus');