[filename,pathname]=uigetfile('Go get your Processed EMG file');
cd(pathname);


load([pathname,filename]);
load([pathname,'SyncData.mat']);


mymuscles={'DeltA','DeltM','UT','BB','TB'};
myprocess = {'smoothdata','fdata'};

FromContra=find(strcmp(SyncData{:,'MovementName'},'FromContra'));
FromIpsi=find(strcmp(SyncData{:,'MovementName'},'FromIpsi'));
ToContra=find(strcmp(SyncData{:,'MovementName'},'ToContra'));
ToIpsi=find(strcmp(SyncData{:,'MovementName'},'ToIpsi'));


for icycle=1:length(FromContra)
    for imuscle=1:length(mymuscles)
        for iprocess = 1:length(myprocess)
            index = round(SyncData{FromContra(icycle),1}*Delsys.(mymuscles{imuscle}).Fs):round(SyncData{FromContra(icycle),2}*Delsys.(mymuscles{imuscle}).Fs);
            Table.FromContra.(mymuscles{imuscle}).(myprocess{iprocess}).notempnorm{icycle} = Delsys.(mymuscles{imuscle}).(myprocess{iprocess})(index);
            Table.FromContra.(mymuscles{imuscle}).(myprocess{iprocess}).tempnorm(:,icycle) = interp1(1:length(index),Delsys.(mymuscles{imuscle}).(myprocess{iprocess})(index),1:(length(index)-1)/999:length(index));
        end
    end
end

for icycle=1:length(FromIpsi)
    for imuscle=1:length(mymuscles)
        for iprocess = 1:length(myprocess)
            index = round(SyncData{FromIpsi(icycle),1}*Delsys.(mymuscles{imuscle}).Fs):round(SyncData{FromIpsi(icycle),2}*Delsys.(mymuscles{imuscle}).Fs);
            Table.FromIpsi.(mymuscles{imuscle}).(myprocess{iprocess}).notempnorm{icycle} = Delsys.(mymuscles{imuscle}).(myprocess{iprocess})(index);
            Table.FromIpsi.(mymuscles{imuscle}).(myprocess{iprocess}).tempnorm(:,icycle) = interp1(1:length(index),Delsys.(mymuscles{imuscle}).(myprocess{iprocess})(index),1:(length(index)-1)/999:length(index));
        end
    end
end

for icycle=1:length(ToContra)
    for imuscle=1:length(mymuscles)
        for iprocess = 1:length(myprocess)
            index = round(SyncData{ToContra(icycle),1}*Delsys.(mymuscles{imuscle}).Fs):round(SyncData{ToContra(icycle),2}*Delsys.(mymuscles{imuscle}).Fs);
            Table.ToContra.(mymuscles{imuscle}).(myprocess{iprocess}).notempnorm{icycle} = Delsys.(mymuscles{imuscle}).(myprocess{iprocess})(index);
            Table.ToContra.(mymuscles{imuscle}).(myprocess{iprocess}).tempnorm(:,icycle) = interp1(1:length(index),Delsys.(mymuscles{imuscle}).(myprocess{iprocess})(index),1:(length(index)-1)/999:length(index));
        end
    end
end

for icycle=1:length(ToIpsi)
    for imuscle=1:length(mymuscles)
        for iprocess = 1:length(myprocess)
            index = round(SyncData{ToIpsi(icycle),1}*Delsys.(mymuscles{imuscle}).Fs):round(SyncData{ToIpsi(icycle),2}*Delsys.(mymuscles{imuscle}).Fs);
            Table.ToIpsi.(mymuscles{imuscle}).(myprocess{iprocess}).notempnorm{icycle} = Delsys.(mymuscles{imuscle}).(myprocess{iprocess})(index);
            Table.ToIpsi.(mymuscles{imuscle}).(myprocess{iprocess}).tempnorm(:,icycle) = interp1(1:length(index),Delsys.(mymuscles{imuscle}).(myprocess{iprocess})(index),1:(length(index)-1)/999:length(index));
        end
    end
end


save('TableData.mat','Table','-mat');
