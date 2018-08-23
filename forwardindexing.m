function y = forwardindexing(f,x,v)
%
% evaluate input function f at x and return output element v
%
%

y0 = feval(f,x);

try    y  = y0{v};
catch  y  = y0(v);
end