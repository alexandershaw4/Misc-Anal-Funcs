function [m,w] = WarpingPath(varargin)
% Dynamic time warping (DTW) using a euclidean matrix and warp-path
% approach. Input length-matched vectors x & y and it returns the
% Euclidean matrix, m, and warp-path, w.
%
% Seems useful for non-linear correlations, or coherence analysis where
% signals are almost identical but slightly out of phase.
% *Input 'demo' for demo data.
%
% AS2016 [util]

% DEMO
%--------------------------------
try varargin{1} == 'demo';
    x=[ 0.5405    0.2304;
       -1.4449    0.4990;
       -0.9677   -1.2205;
        0.2021   -0.8072;
       -0.3479    0.2058;
        1.2901   -0.2704;
        1.3412    1.1481;
       -0.5808    1.1923;
        0.8751   -0.4721;
        1.3954    0.7887];
    y = x(:,2);
    x = x(:,1);
    t = 1:length(x);
    
    [m,w] = WarpingPath(x,y);
    dx = w*x;
    dy = w*y;
    
    figure,
    subplot(1,4,1),plot(t, x,t, y);
    subplot(1,4,4),plot(t,dx,t,dy);
    subplot(1,4,2),imagesc(m);
    subplot(1,4,3),imagesc(logical(w));
    return;
end



% The function
%--------------------------------
try x = varargin{1}; end
try y = varargin{2}; catch y = x; end

% ensure vectors
x = spm_vec(x); xl = length(x);
y = spm_vec(y); yl = length(y);

% euclidean [warping] matrix
for i = 1:xl
    for j  = 1:yl
        x0 = x(i);
        y0 = y(j);     
        
        E(i,j) = sum ( (x0-y0).^2 );  
    end
end

% check whether to find path or give up
if nargout == 1; m = E; return; end

% expansion point
P = E(1,1); P;

% unique matrix
Q = toeplitz(fliplr(100*TSNorm(1:length(E))));
Q = Q+1e-7;

xl1   = xl;
for i = 2:xl*.5*xl
    j = i;
    
    % find current co-ordinate
    if i ~= 2; [fx fy] = find(E==v); 
    else       [fx fy] = deal(1);
    end        
    
    % in case of matrix duplicates
    if length(fx) > 1 || length(fy) > 1
        fx       = fx(1); 
        fy       = fy(1);
        E(fx,fy) = NaN;
    end
    
    % check for matrix completion
    if size(P,2) == xl1 || size(P,1) == xl1;
        if     size(P,1) > size(P,2); P(xl,xl) = E(end,end); break
        elseif size(P,1) < size(P,2); P(xl,xl) = E(end,end); break
        end
    end

    % what are the 3 adjacent options:
    choice{1} = E(fx+1,fy  ); % dx/ y
    choice{2} = E(fx+1,fy+1); % dx/dy
    choice{3} = E(fx  ,fy+1); %  x/dy
    
    % ensure it can't stray too far from diag [by reducing options]
    if abs(fx-fy) >= round(1/16*xl1);
        if     fx > fy; choice{1} = Inf;
        elseif fy > fx; choice{3} = Inf;
        end
    end
        
    % select minimum distance & log
    [v,op] = min(spm_vec(choice));
    C(i)   = op; 
    V(i)   = v; 

    % record value [in situ]    
    if     op == 1;           P(fx+1,fy  ) = v; 
    elseif op == 2 && i ~= 2; 
        if isempty(P(fx,fy)); P(fx,fy)     = v; 
        else                  P(fx+1,fy+1) = v;
        end
    elseif op == 2 && i == 2; P(fx+1,fy+1) = v;
    elseif op == 3;           P(fx  ,fy+1) = v; 
    end
    
    % print
    %P 
    %pause(.1);
    
end

clc; logical(P);

m = E;
w = P;
    
