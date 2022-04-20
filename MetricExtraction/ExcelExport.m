clear all

mymuscles={'DeltA','DeltM','UT','BB','TB'};
mymovements = {'FromContra','ToContra','FromIpsi','ToIpsi'};


[filename,pathname]=uigetfile('Go get your Processed Confo Pre AnalyseData file');
cd(pathname);


load([pathname,filename]);





for imuscle=1:length(mymuscles)
    for imovement = 1:length(mymovements)
        
        if exist('temps')
            temps=[temps;repmat({'Pre'},length(Analyse.(mymuscles{imuscle}).(mymovements{imovement}).MdF)*2,1)];
            muscle=[muscle;repmat(mymuscles(imuscle),length(Analyse.(mymuscles{imuscle}).(mymovements{imovement}).MdF)*2,1)];
            movement=[movement;repmat(mymovements(imovement),length(Analyse.(mymuscles{imuscle}).(mymovements{imovement}).MdF)*2,1)];
            variable = [variable;repmat({'MdF'},length(Analyse.(mymuscles{imuscle}).(mymovements{imovement}).MdF),1);...
                repmat({'ARV'},length(Analyse.(mymuscles{imuscle}).(mymovements{imovement}).MdF),1)];
            data = [data;Analyse.(mymuscles{imuscle}).(mymovements{imovement}).MdF';...
                Analyse.(mymuscles{imuscle}).(mymovements{imovement}).ARV'*1000000];
            
        else
            temps=repmat({'Pre'},length(Analyse.(mymuscles{imuscle}).(mymovements{imovement}).MdF)*2,1);
            muscle=repmat(mymuscles(imuscle),length(Analyse.(mymuscles{imuscle}).(mymovements{imovement}).MdF)*2,1);
            movement=repmat(mymovements(imovement),length(Analyse.(mymuscles{imuscle}).(mymovements{imovement}).MdF)*2,1);
            variable = [repmat({'MdF'},length(Analyse.(mymuscles{imuscle}).(mymovements{imovement}).MdF),1);...
                repmat({'ARV'},length(Analyse.(mymuscles{imuscle}).(mymovements{imovement}).MdF),1)];
            data = [Analyse.(mymuscles{imuscle}).(mymovements{imovement}).MdF';...
                Analyse.(mymuscles{imuscle}).(mymovements{imovement}).ARV'*1000000];
        end
        
    end
    
end


clear Analyse
[filename,pathname]=uigetfile('Go get your Processed Confo Post AnalyseData file');
cd(pathname);


load([pathname,filename]);





for imuscle=1:length(mymuscles)
    for imovement = 1:length(mymovements)
        
            temps=[temps;repmat({'Post'},length(Analyse.(mymuscles{imuscle}).(mymovements{imovement}).MdF)*2,1)];
            muscle=[muscle;repmat(mymuscles(imuscle),length(Analyse.(mymuscles{imuscle}).(mymovements{imovement}).MdF)*2,1)];
            movement=[movement;repmat(mymovements(imovement),length(Analyse.(mymuscles{imuscle}).(mymovements{imovement}).MdF)*2,1)];
            variable = [variable;repmat({'MdF'},length(Analyse.(mymuscles{imuscle}).(mymovements{imovement}).MdF),1);...
                repmat({'ARV'},length(Analyse.(mymuscles{imuscle}).(mymovements{imovement}).MdF),1)];
            data = [data;Analyse.(mymuscles{imuscle}).(mymovements{imovement}).MdF';...
                Analyse.(mymuscles{imuscle}).(mymovements{imovement}).ARV'*1000000];
   
        
    end
    
end

AnalyseTable=table(temps,muscle,movement,variable,data,...
    'VariableNames',{'temps','muscle','movement','variable','data'});
pathname=uigetdir(cd,'Select the root folder of the participant');

save([pathname, '\AnalyseTable_confoRPT.mat'],'AnalyseTable');
writetable(AnalyseTable,[pathname, '\AnalyseTable_confoRPT.xlsx']);

