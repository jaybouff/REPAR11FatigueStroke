clear all

[filename,pathname]=uigetfile('Go get your TableData file');
cd(pathname);


load([pathname,filename]);

mymuscles={'DeltA','DeltM','UT','BB','TB'};
myprocess = {'smoothdata','fdata'};
mymovements = {'FromContra','ToContra','FromIpsi','ToIpsi'};

% 
% for imuscle=1:length(mymuscles)
%     for iprocess = 1:length(myprocess)
%         ntrial = 0;
%             for imovement = 1:length(mymovements)
%                 
%                fonction = ['C', num2str(imuscle+(iprocess-1)*length(mymuscles)),'(:,ntrial+1:ntrial+size(Table.'...
%                    ,mymovements{imovement},'.',mymuscles{imuscle},'.', myprocess{iprocess},',2))'...
%                    '= Table.', mymovements{imovement},'.',mymuscles{imuscle},'.', myprocess{iprocess},'.tempnorm;'];
%                
%                eval(fonction);
%                
%                hdchnl.adname{imuscle+(iprocess-1)*length(mymuscles)} = [mymuscles{imuscle},myprocess{iprocess}];
%                hdchnl.cindx{imuscle+(iprocess-1)*length(mymuscles)} = ['C', num2str(imuscle+(iprocess-1)*length(mymuscles))];
%            
%             end
%         
%     end
% end
%     
% 
 for imuscle=1:length(mymuscles)
    for iprocess = 1:length(myprocess)
        ntrial = 0;
            for imovement = 1:length(mymovements)
                
               fonction = ['C', num2str(imuscle+(iprocess-1)*length(mymuscles)),'(:,ntrial+1:ntrial+size(Table.'...
                   ,mymovements{imovement},'.',mymuscles{imuscle},'.', myprocess{iprocess},',2))'...
                   '= Table.', mymovements{imovement},'.',mymuscles{imuscle},'.', myprocess{iprocess},'.tempnorm;'];
               
               eval(fonction);
               
               hdchnl.adname{imuscle+(iprocess-1)*length(mymuscles)} = [mymuscles{imuscle},myprocess{iprocess}];
               hdchnl.cindx{imuscle+(iprocess-1)*length(mymuscles)} = ['C', num2str(imuscle+(iprocess-1)*length(mymuscles))];
           
            end
        
    end
% end