% Find every fieldname of a structure regardless of depth 
% AS 2015
function y = fieldsearch(x)
         f = fieldnames(x);
        
     for i    = 1:length(f)
        try f = [f; fieldsearch(x.(f{i}))]; end
     end
    
         y = f;
