function y = reduce_eig(x,d,varargin)
% x is a double matrix
% y is smoothed iteratively until 90% of its variance is explained by d 
% principal components
%
% AS

try k = varargin{1}; catch k = 2; end

[~, n] = PEig90(x);
ncyc   = 0;

while n > d
    ncyc = ncyc + 1;
    x = HighResMeanFilt(x,1,k);
    [~, n] = PEig90(x);
    y = x;
    
    % Put some limit on cycles
    dn(ncyc) = n;
    if ncyc > 4 && all(dn==n); k = k * 4; end
    if ncyc > 20; fprintf('Didnt converge: giving up\n'); y = x; return; end
end

fprintf('Finished after %d cycles\n',ncyc);
y = x;