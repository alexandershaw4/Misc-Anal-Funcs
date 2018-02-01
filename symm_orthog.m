function y = symm_orthog(x);
% Symmetric orthogonalisation method for matrices, using:
%
% y = x * real(inv(x' * x)^(1/2));
%
% AS
     
y = [x] * real(inv([x]' * [x])^(1/2));

y = (max(x(:)) - min(x(:))) * ( (y - min(y(:))) / (max(y(:)) - min(y(:))) );

end