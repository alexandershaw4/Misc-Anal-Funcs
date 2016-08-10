function [yout,o] = cellnumchecker(y)
% y    is an array of cells which contain strings / characters
% yout is y with any numerics changed to x, at any depth
% Alex AS

o = 1;

if iscell(y); 
    
    for j = 1:length(y)
        
        if    any(cellfun(@isnumeric,y{j}));
              id = (cellfun(@isnumeric,y{j}));
              id = find(id==1);
              y{j}(id) = {['x']};
              o = o + 1;
            
        elseif iscell(y{j}{1})
            try y = cellnumchecker(y{j});
            end
        end
        
    end
    
end
       yout = y;