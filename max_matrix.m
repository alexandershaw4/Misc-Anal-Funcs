function [x,y,i] = max_matrix(M)
% same as 'max' but for matrices: returns x and y indices & val, i.
%
% AS2016

dx    = spm_vec(M);
[i,m] = max(dx);
[x,y] = find(M==i);

i = i(1);
x = x(1);
y = y(1);
