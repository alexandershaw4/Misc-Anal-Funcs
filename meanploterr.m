function meanploterr(y,hz,color)
%
%
%
% AS18

if nargin < 3 || isempty(color)
   color = [1 0 0]; 
end

mu = mean(y);
er = std(y')/sqrt(size(y,2));

plot(hz,mu   ,'color',color, 'linewidth',2); hold on;
plot(hz,mu+er,'k:','linewidth',1);
plot(hz,mu-er,'k:','linewidth',1);

