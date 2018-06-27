function [P,f] = spectral_peaks(Y,Hz,varargin)

if ndims(Y)==3
    % nf x node x node [csd]
    for i = 1:size(Y,2)
        for j = 1:size(Y,3)
            [P(:,i,j),f] = spectral_peaks(squeeze(Y(:,i,j)),Hz);
        end
    end
    return
end

try
    % method = @'fx'
    m = eval([ '@' varargin{1} ]);
catch
    % method = 'max'
    m = @max;
end

%    delta theta alpha  beta  gamma1 gamma 2
f0= [1   4;4   8;8  13;13 30; 30 80; 80 100];

for i = 1:length(f0)
    for j = 1:2
        f(i,j) = findthenearest(f0(i,j),Hz);
    end
end

% maximum values
for i = 1:length(f0)
    P(i) = m( Y(f(i,1):f(i,2)) );
end