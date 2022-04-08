clear all

[filename,pathname]=uigetfile('Go get your Processed EMG file');
cd(pathname);


load([pathname,filename]);
load([pathname,'TableData.mat']);

mymuscles={'DeltA','DeltM','UT','BB','TB'};
myprocess = {'smoothdata','fdata'};
mymovements = {'FromContra','ToContra','FromIpsi','ToIpsi'};


    for imuscle=1:length(mymuscles)
            for imovement = 1:length(mymovements)
                
                Analyse.(mymuscles{imuscle}).(mymovements{imovement}).ARV = mean(Table.(mymovements{imovement}).(mymuscles{imuscle}).smoothdata.tempnorm);
                
                Analyse.(mymuscles{imuscle}).(mymovements{imovement}).MdF = ...
                    cellfun(@(x)(medfreq(x,Delsys.(mymuscles{imuscle}).Fs)),Table.(mymovements{imovement}).(mymuscles{imuscle}).fdata.notempnorm);
                
           
            end
        
    end

    
save('AnalyseData.mat','Analyse','-mat');
