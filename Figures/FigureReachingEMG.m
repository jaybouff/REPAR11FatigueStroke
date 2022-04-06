clf
subplot(4,1,1)
%plot(Table.FromContra.DeltA.smoothdata.tempnorm,'k')
plot(mean(Table.FromContra.DeltM.smoothdata.tempnorm,2),'k','linewidth',2)
hold on
plot(mean(Table.FromContra.BB.smoothdata.tempnorm,2),'r','linewidth',2)
plot(mean(Table.FromContra.TB.smoothdata.tempnorm,2),'m','linewidth',2)
plot(mean(Table.FromContra.DeltA.smoothdata.tempnorm,2),'b','linewidth',2)
title('DeltA FromContra')

subplot(4,1,2)
plot(mean(Table.ToContra.DeltM.smoothdata.tempnorm,2),'k','linewidth',2)
hold on
plot(mean(Table.ToContra.BB.smoothdata.tempnorm,2),'r','linewidth',2)
plot(mean(Table.ToContra.TB.smoothdata.tempnorm,2),'m','linewidth',2)
%plot(Table.ToContra.DeltA.smoothdata.tempnorm,'k')
plot(mean(Table.ToContra.DeltA.smoothdata.tempnorm,2),'b','linewidth',2)
title('DeltA ToContra')

subplot(4,1,3)
%plot(Table.FromIpsi.DeltA.smoothdata.tempnorm,'k')
plot(mean(Table.FromIpsi.DeltM.smoothdata.tempnorm,2),'k','linewidth',2)
hold on
plot(mean(Table.FromIpsi.BB.smoothdata.tempnorm,2),'r','linewidth',2)
plot(mean(Table.FromIpsi.TB.smoothdata.tempnorm,2),'m','linewidth',2)
plot(mean(Table.FromIpsi.DeltA.smoothdata.tempnorm,2),'b','linewidth',2)
title('DeltA FromIpsi')

subplot(4,1,4)
%plot(Table.ToIpsi.DeltA.smoothdata.tempnorm,'k')
plot(mean(Table.ToIpsi.DeltM.smoothdata.tempnorm,2),'k','linewidth',2)
hold on
plot(mean(Table.ToIpsi.BB.smoothdata.tempnorm,2),'r','linewidth',2)
plot(mean(Table.ToIpsi.TB.smoothdata.tempnorm,2),'m','linewidth',2)
plot(mean(Table.ToIpsi.DeltA.smoothdata.tempnorm,2),'b','linewidth',2)
title('DeltA ToIpsi')