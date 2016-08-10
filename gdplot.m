function gdplot(x,varargin)

if strcmp(varargin,'error'); E = 1; else E = 0; end

if E && ~isvector(x)
     mu = mean(x);
     sd = std(x);
     se = sd./sqrt(length(sd));
     x  = [mu-se;mu;mu+se];
     E  = 1;
else E  = 0;
end


[ix,iy] = size(x);


if ix > 1;
    r   = fliplr((1:ix)/ix);
    g   =       ((1:ix)/ix)*.2;
    b   = zeros(1,ix);
    col = [g;r;b]';
    
else
    col = [1 0 0];
end

for i = 1:ix
    plot(x(i,:),'color',col(i,:),'LineWidth',2); hold on;
    if E; plot(x(i,:),'o','color',col(i,:)); end
        
end

alpha color

xlim([0 iy+1]);
set(gca,'PlotBoxAspectRatio',[2 1 1]);
whitebg(1,'k'); alpha(.5);
set(gca,'fontsize',16);


