function y = symm_orthog(x);

%y = x * real(inv(x' * x)^(1/2));

d =  inv(x' * x);

d(isinf(d)) = 0;

y = real(d^(1/2));

end