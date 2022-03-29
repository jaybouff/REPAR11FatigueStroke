%% This code is used to synchronise data from Maximus (IMU) and Delsys (EMG) systems using accelerometers from both systems placed on a common rigid body
clear all
%% Load data
% Load previously assemble Maximus data file
[filename,pathname]= uigetfile('Go get Maximus.mat file');
load([pathname,filename])

% Load previously assemble Delsys data file
[filename,pathname]= uigetfile('Go get Delsys.mat file');
load([pathname,filename])

%% Constants
% Sampling frequency from all signals
FzMaximus=60;
FzDelsysSync=round(Delsys.SyncAccelX.Fs);
FzDelsysEMG=round(Delsys.DeltA.Fs);

% Frequence of resampled signals
FzResample =100;

% Filter parameters for the accelerometer signals 
Fc = [0.2, 4];
Ordre = 2;

% Determine signals from MAximus to integrate into the Syncdata structure
mySegments = {'Hand','Forearm','Arm','Scapula','Thorax', 'Sync'};
mySignals = {'AccelX','AccelY','AccelZ',...
    'GyroX','GyroY','GyroZ'...
    ,'q11','q21','q31','q12','q22','q23','q13','q23','q33'};

% Find the end of the Accelerometer within Delsys database (padded with
% zero because of different sampling frequency between Delsys EMG and
% accelerometer
FinDelsysSync = length(Delsys.DeltA.rawdata)/FzDelsysEMG*FzDelsysSync;

%Generate time vector for the different signals
timeMaximus = 0:1/FzMaximus:(length(Maximus.Sync.AccelX.rawdata)-1)/FzMaximus;
timeDelsysSync = 0:1/FzDelsysSync:(FinDelsysSync-1)/FzDelsysSync;
timeDelsysEMG = 0:1/FzDelsysEMG:(length(Delsys.DeltA.rawdata)-1)/FzDelsysEMG;

% Filter sync accelerometers from both signals with common parameters defined above
[b,a]=butter(Ordre,Fc/FzMaximus*2);

Maximus.Sync.AccelX.fdata=filtfilt(b,a,Maximus.Sync.AccelX.rawdata);
Maximus.Sync.AccelY.fdata=filtfilt(b,a,Maximus.Sync.AccelY.rawdata);
Maximus.Sync.AccelZ.fdata=filtfilt(b,a,Maximus.Sync.AccelZ.rawdata);

% calcule Accélération linéaire du sync avec MAximus et Delsys
accellineaireMaximus = sqrt(Maximus.Sync.AccelX.fdata.^2+Maximus.Sync.AccelY.fdata.^2+Maximus.Sync.AccelZ.fdata.^2);
accellineaireDelsys = sqrt(Delsys.SyncAccelX.fdata.^2+Delsys.SyncAccelY.fdata.^2+Delsys.SyncAccelZ.fdata.^2);

% Resample signals to prepare cross correlation
MaximusAccelResamp=resample(accellineaireMaximus,FzResample,FzMaximus);
DelsysAccelResamp=resample(accellineaireDelsys,FzResample,FzDelsysSync);

% Cross correlation between 2 sync signals to find optimal delay
ResampDelsysend = FinDelsysSync * FzResample / FzDelsysSync;
[c,lags]=xcorr(DelsysAccelResamp(1:ResampDelsysend),MaximusAccelResamp(1:ResampDelsysend),'normalized');
optimlags = abs(lags(c==max(c)));

%% Create Synchronized structure
% integrate Delsys data in Sync structure
Syncdata.Delsys = Delsys;
Syncdata.Delsys.TimeAccel = timeDelsysSync;
Syncdata.Delsys.TimeEMG = timeDelsysEMG;

Syncdata.Maximus.Fs = FzMaximus;
Syncdata.Maximus.Time = 0:1/FzMaximus:(length(Maximus.Sync.AccelX.rawdata)-optimlags/FzResample*FzMaximus)/FzMaximus;

for isegment=1:length(mySegments)
    for isignal = 1:length(mySignals)
        Syncdata.Maximus.(mySegments{isegment}).(mySignals{isignal}).rawdata = ...
            Maximus.(mySegments{isegment}).(mySignals{isignal}).rawdata(optimlags/FzResample*FzMaximus:end);
    end
end

save('Syncdata','Syncdata');