function condmat = ComputeConditionMatrix(list)
% - using an array of strings as input, determine a condition matrix
% - designed for use with stringparts function
% AS 2015 [util]

list    = cellnumchecker(list);

list    = squeeze(cat(3,list{:}));
list    = list';

condmat = zeros(size(list)); % condition matrix

for d = 1:size(condmat,2)
    
    uncond  = unique(list(:,d));
    condcod = [1:length(uncond)]';
    
    for subs = 1:size(condmat,1)
        ind  = find(strcmp(list(subs,d),uncond));
        
        condmat(subs,d) = condcod(ind);
        
    end
end
        
        
        
