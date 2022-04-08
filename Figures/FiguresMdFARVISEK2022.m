clear all
[filename,pathname]=uigetfile('Go get your AnalyseBefore');
load([pathname,filename]);
AnalyseBefore = Analyse;
clear Analyse

[filename,pathname]=uigetfile('Go get your AnalyseAfter');
load([pathname,filename]);
AnalyseAfter = Analyse;
clear Analyse

mymuscles={'DeltA','DeltM','UT','BB','TB'};
mymovements = {'FromContra','ToContra','FromIpsi','ToIpsi'};

close all
figure(1)
%% To Ipsi
subplot(2,2,1)
plot(repmat(1,1,length(AnalyseAfter.DeltA.ToIpsi.MdF)),AnalyseAfter.DeltA.ToIpsi.MdF,'ro')
hold on
plot(repmat(1,1,length(AnalyseBefore.DeltA.ToIpsi.MdF)),AnalyseBefore.DeltA.ToIpsi.MdF,'bo')
plot(repmat(2,1,length(AnalyseAfter.DeltM.ToIpsi.MdF)),AnalyseAfter.DeltM.ToIpsi.MdF,'ro')
plot(repmat(2,1,length(AnalyseBefore.DeltM.ToIpsi.MdF)),AnalyseBefore.DeltM.ToIpsi.MdF,'bo')

plot(repmat(3,1,length(AnalyseAfter.UT.ToIpsi.MdF)),AnalyseAfter.UT.ToIpsi.MdF,'ro')
plot(repmat(3,1,length(AnalyseBefore.UT.ToIpsi.MdF)),AnalyseBefore.UT.ToIpsi.MdF,'bo')

plot(repmat(4,1,length(AnalyseAfter.BB.ToIpsi.MdF)),AnalyseAfter.BB.ToIpsi.MdF,'ro')
plot(repmat(4,1,length(AnalyseBefore.BB.ToIpsi.MdF)),AnalyseBefore.BB.ToIpsi.MdF,'bo')

plot(repmat(5,1,length(AnalyseAfter.TB.ToIpsi.MdF)),AnalyseAfter.TB.ToIpsi.MdF,'ro')
plot(repmat(5,1,length(AnalyseBefore.TB.ToIpsi.MdF)),AnalyseBefore.TB.ToIpsi.MdF,'bo')
title('To Ipsi')
ylabel('Median Frequency')
xticklabels({'DeltA','DeltM','UT','BB','TB'})
legend('After','Before')

%% To Contra
subplot(2,2,2)
plot(repmat(1,1,length(AnalyseAfter.DeltA.ToContra.MdF)),AnalyseAfter.DeltA.ToContra.MdF,'ro')
hold on
plot(repmat(1,1,length(AnalyseBefore.DeltA.ToContra.MdF)),AnalyseBefore.DeltA.ToContra.MdF,'bo')
plot(repmat(2,1,length(AnalyseAfter.DeltM.ToContra.MdF)),AnalyseAfter.DeltM.ToContra.MdF,'ro')
plot(repmat(2,1,length(AnalyseBefore.DeltM.ToContra.MdF)),AnalyseBefore.DeltM.ToContra.MdF,'bo')

plot(repmat(3,1,length(AnalyseAfter.UT.ToContra.MdF)),AnalyseAfter.UT.ToContra.MdF,'ro')
plot(repmat(3,1,length(AnalyseBefore.UT.ToContra.MdF)),AnalyseBefore.UT.ToContra.MdF,'bo')

plot(repmat(4,1,length(AnalyseAfter.BB.ToContra.MdF)),AnalyseAfter.BB.ToContra.MdF,'ro')
plot(repmat(4,1,length(AnalyseBefore.BB.ToContra.MdF)),AnalyseBefore.BB.ToContra.MdF,'bo')

plot(repmat(5,1,length(AnalyseAfter.TB.ToContra.MdF)),AnalyseAfter.TB.ToContra.MdF,'ro')
plot(repmat(5,1,length(AnalyseBefore.TB.ToContra.MdF)),AnalyseBefore.TB.ToContra.MdF,'bo')
title('To Contra')
ylabel('Median Frequency')
xticklabels({'DeltA','DeltM','UT','BB','TB'})

%% From Ipsi
subplot(2,2,3)
plot(repmat(1,1,length(AnalyseAfter.DeltA.FromIpsi.MdF)),AnalyseAfter.DeltA.FromIpsi.MdF,'ro')
hold on
plot(repmat(1,1,length(AnalyseBefore.DeltA.FromIpsi.MdF)),AnalyseBefore.DeltA.FromIpsi.MdF,'bo')
plot(repmat(2,1,length(AnalyseAfter.DeltM.FromIpsi.MdF)),AnalyseAfter.DeltM.FromIpsi.MdF,'ro')
plot(repmat(2,1,length(AnalyseBefore.DeltM.FromIpsi.MdF)),AnalyseBefore.DeltM.FromIpsi.MdF,'bo')

plot(repmat(3,1,length(AnalyseAfter.UT.FromIpsi.MdF)),AnalyseAfter.UT.FromIpsi.MdF,'ro')
plot(repmat(3,1,length(AnalyseBefore.UT.FromIpsi.MdF)),AnalyseBefore.UT.FromIpsi.MdF,'bo')

plot(repmat(4,1,length(AnalyseAfter.BB.FromIpsi.MdF)),AnalyseAfter.BB.FromIpsi.MdF,'ro')
plot(repmat(4,1,length(AnalyseBefore.BB.FromIpsi.MdF)),AnalyseBefore.BB.FromIpsi.MdF,'bo')

plot(repmat(5,1,length(AnalyseAfter.TB.FromIpsi.MdF)),AnalyseAfter.TB.FromIpsi.MdF,'ro')
plot(repmat(5,1,length(AnalyseBefore.TB.FromIpsi.MdF)),AnalyseBefore.TB.FromIpsi.MdF,'bo')
title('From Ipsi')
ylabel('Median Frequency')
xticklabels({'DeltA','DeltM','UT','BB','TB'})

%% From Contra
subplot(2,2,4)
plot(repmat(1,1,length(AnalyseAfter.DeltA.FromContra.MdF)),AnalyseAfter.DeltA.FromContra.MdF,'ro')
hold on
plot(repmat(1,1,length(AnalyseBefore.DeltA.FromContra.MdF)),AnalyseBefore.DeltA.FromContra.MdF,'bo')
plot(repmat(2,1,length(AnalyseAfter.DeltM.FromContra.MdF)),AnalyseAfter.DeltM.FromContra.MdF,'ro')
plot(repmat(2,1,length(AnalyseBefore.DeltM.FromContra.MdF)),AnalyseBefore.DeltM.FromContra.MdF,'bo')

plot(repmat(3,1,length(AnalyseAfter.UT.FromContra.MdF)),AnalyseAfter.UT.FromContra.MdF,'ro')
plot(repmat(3,1,length(AnalyseBefore.UT.FromContra.MdF)),AnalyseBefore.UT.FromContra.MdF,'bo')

plot(repmat(4,1,length(AnalyseAfter.BB.FromContra.MdF)),AnalyseAfter.BB.FromContra.MdF,'ro')
plot(repmat(4,1,length(AnalyseBefore.BB.FromContra.MdF)),AnalyseBefore.BB.FromContra.MdF,'bo')

plot(repmat(5,1,length(AnalyseAfter.TB.FromContra.MdF)),AnalyseAfter.TB.FromContra.MdF,'ro')
plot(repmat(5,1,length(AnalyseBefore.TB.FromContra.MdF)),AnalyseBefore.TB.FromContra.MdF,'bo')
title('From Contra')
ylabel('Median Frequency')
xticklabels({'DeltA','DeltM','UT','BB','TB'})




%% ARV
figure(2)
%% To Ipsi
subplot(2,2,1)
plot(repmat(1,1,length(AnalyseAfter.DeltA.ToIpsi.ARV)),AnalyseAfter.DeltA.ToIpsi.ARV,'ro')
hold on
plot(repmat(1,1,length(AnalyseBefore.DeltA.ToIpsi.ARV)),AnalyseBefore.DeltA.ToIpsi.ARV,'bo')
plot(repmat(2,1,length(AnalyseAfter.DeltM.ToIpsi.ARV)),AnalyseAfter.DeltM.ToIpsi.ARV,'ro')
plot(repmat(2,1,length(AnalyseBefore.DeltM.ToIpsi.ARV)),AnalyseBefore.DeltM.ToIpsi.ARV,'bo')

plot(repmat(3,1,length(AnalyseAfter.UT.ToIpsi.ARV)),AnalyseAfter.UT.ToIpsi.ARV,'ro')
plot(repmat(3,1,length(AnalyseBefore.UT.ToIpsi.ARV)),AnalyseBefore.UT.ToIpsi.ARV,'bo')

plot(repmat(4,1,length(AnalyseAfter.BB.ToIpsi.ARV)),AnalyseAfter.BB.ToIpsi.ARV,'ro')
plot(repmat(4,1,length(AnalyseBefore.BB.ToIpsi.ARV)),AnalyseBefore.BB.ToIpsi.ARV,'bo')

plot(repmat(5,1,length(AnalyseAfter.TB.ToIpsi.ARV)),AnalyseAfter.TB.ToIpsi.ARV,'ro')
plot(repmat(5,1,length(AnalyseBefore.TB.ToIpsi.ARV)),AnalyseBefore.TB.ToIpsi.ARV,'bo')
title('To Ipsi')
ylabel('Average rectified value ')
xticklabels({'DeltA','DeltM','UT','BB','TB'})
legend('After','Before')

%% To Contra
subplot(2,2,2)
plot(repmat(1,1,length(AnalyseAfter.DeltA.ToContra.ARV)),AnalyseAfter.DeltA.ToContra.ARV,'ro')
hold on
plot(repmat(1,1,length(AnalyseBefore.DeltA.ToContra.ARV)),AnalyseBefore.DeltA.ToContra.ARV,'bo')
plot(repmat(2,1,length(AnalyseAfter.DeltM.ToContra.ARV)),AnalyseAfter.DeltM.ToContra.ARV,'ro')
plot(repmat(2,1,length(AnalyseBefore.DeltM.ToContra.ARV)),AnalyseBefore.DeltM.ToContra.ARV,'bo')

plot(repmat(3,1,length(AnalyseAfter.UT.ToContra.ARV)),AnalyseAfter.UT.ToContra.ARV,'ro')
plot(repmat(3,1,length(AnalyseBefore.UT.ToContra.ARV)),AnalyseBefore.UT.ToContra.ARV,'bo')

plot(repmat(4,1,length(AnalyseAfter.BB.ToContra.ARV)),AnalyseAfter.BB.ToContra.ARV,'ro')
plot(repmat(4,1,length(AnalyseBefore.BB.ToContra.ARV)),AnalyseBefore.BB.ToContra.ARV,'bo')

plot(repmat(5,1,length(AnalyseAfter.TB.ToContra.ARV)),AnalyseAfter.TB.ToContra.ARV,'ro')
plot(repmat(5,1,length(AnalyseBefore.TB.ToContra.ARV)),AnalyseBefore.TB.ToContra.ARV,'bo')
title('To Contra')
ylabel('Average rectified value ')
xticklabels({'DeltA','DeltM','UT','BB','TB'})

%% From Ipsi
subplot(2,2,3)
plot(repmat(1,1,length(AnalyseAfter.DeltA.FromIpsi.ARV)),AnalyseAfter.DeltA.FromIpsi.ARV,'ro')
hold on
plot(repmat(1,1,length(AnalyseBefore.DeltA.FromIpsi.ARV)),AnalyseBefore.DeltA.FromIpsi.ARV,'bo')
plot(repmat(2,1,length(AnalyseAfter.DeltM.FromIpsi.ARV)),AnalyseAfter.DeltM.FromIpsi.ARV,'ro')
plot(repmat(2,1,length(AnalyseBefore.DeltM.FromIpsi.ARV)),AnalyseBefore.DeltM.FromIpsi.ARV,'bo')

plot(repmat(3,1,length(AnalyseAfter.UT.FromIpsi.ARV)),AnalyseAfter.UT.FromIpsi.ARV,'ro')
plot(repmat(3,1,length(AnalyseBefore.UT.FromIpsi.ARV)),AnalyseBefore.UT.FromIpsi.ARV,'bo')

plot(repmat(4,1,length(AnalyseAfter.BB.FromIpsi.ARV)),AnalyseAfter.BB.FromIpsi.ARV,'ro')
plot(repmat(4,1,length(AnalyseBefore.BB.FromIpsi.ARV)),AnalyseBefore.BB.FromIpsi.ARV,'bo')

plot(repmat(5,1,length(AnalyseAfter.TB.FromIpsi.ARV)),AnalyseAfter.TB.FromIpsi.ARV,'ro')
plot(repmat(5,1,length(AnalyseBefore.TB.FromIpsi.ARV)),AnalyseBefore.TB.FromIpsi.ARV,'bo')
title('From Ipsi')
ylabel('Average rectified value')
xticklabels({'DeltA','DeltM','UT','BB','TB'})

%% From Contra
subplot(2,2,4)
plot(repmat(1,1,length(AnalyseAfter.DeltA.FromContra.ARV)),AnalyseAfter.DeltA.FromContra.ARV,'ro')
hold on
plot(repmat(1,1,length(AnalyseBefore.DeltA.FromContra.ARV)),AnalyseBefore.DeltA.FromContra.ARV,'bo')
plot(repmat(2,1,length(AnalyseAfter.DeltM.FromContra.ARV)),AnalyseAfter.DeltM.FromContra.ARV,'ro')
plot(repmat(2,1,length(AnalyseBefore.DeltM.FromContra.ARV)),AnalyseBefore.DeltM.FromContra.ARV,'bo')

plot(repmat(3,1,length(AnalyseAfter.UT.FromContra.ARV)),AnalyseAfter.UT.FromContra.ARV,'ro')
plot(repmat(3,1,length(AnalyseBefore.UT.FromContra.ARV)),AnalyseBefore.UT.FromContra.ARV,'bo')

plot(repmat(4,1,length(AnalyseAfter.BB.FromContra.ARV)),AnalyseAfter.BB.FromContra.ARV,'ro')
plot(repmat(4,1,length(AnalyseBefore.BB.FromContra.ARV)),AnalyseBefore.BB.FromContra.ARV,'bo')

plot(repmat(5,1,length(AnalyseAfter.TB.FromContra.ARV)),AnalyseAfter.TB.FromContra.ARV,'ro')
plot(repmat(5,1,length(AnalyseBefore.TB.FromContra.ARV)),AnalyseBefore.TB.FromContra.ARV,'bo')
title('From Contra')
ylabel('Average rectified value')
xticklabels({'DeltA','DeltM','UT','BB','TB'})