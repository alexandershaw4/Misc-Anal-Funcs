function [o,a] = make_matrix_indices(m)
% input  m is a cell array of size-matched matrices
% output o is a cell array of vectors with indices for n = ndims(m) components
%
% designed for use with glm / anova functions as a way of automatically
% generating the grouping variables / factors based on the dimentionality
% of the data.
% AS2016 [util]



    
%[sizes]
tot   = length(spm_vec(m));
s     = size(m);
s2    = size(m{1,1});

%[reshape]
for i = 1:s(1)
    for j = 1:s(2)
        a(i,j,:,:,:,:) = m{i,j};
    end
end


n     = 0;         
o{1}  = [];       
s     = size(a);
for i = 1:ndims(a)
    
    n     = 0;       % counter
    o{i}  = [];      % initialise output 
    for k = 1:s(i)
        n = n + 1;  
        o{i} = [o{i} n*ones([1,prod([s(1:i-1) s(i+1:end)])])];        
    end
end
    
