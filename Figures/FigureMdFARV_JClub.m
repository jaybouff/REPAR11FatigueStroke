

[filename,pathname]=uigetfile('*.mat','Go get your AnalyseTable file');
load([pathname,filename]);
clear g
close all
g=gramm('x',AnalyseTable.muscle,'y',AnalyseTable.data, 'color',AnalyseTable.temps);
g.facet_grid(AnalyseTable.variable,[])

g.stat_summary('type','ci','geom','point')
g.draw

g.update('x',AnalyseTable.muscle,'y',AnalyseTable.data, 'color',AnalyseTable.temps);
g.stat_summary('type','ci','geom','errorbar')
g.draw

