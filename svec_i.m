function y = svec_i(x,is,ie)

if length(is) == 2;
    ie = is(2);
    is = is(1);
end

y = spm_vec(x);
y = y(is:ie);
