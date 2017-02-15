function corrected_t(df,alpha,n_comp)
% Bonf corrected t-value for n, 2-sided t-tests
%
%
%
% AS

% df     = 26;
% alpha  = .05;
% n_comp = 4;

bonfp  = alpha / n_comp;
twosid = 1-(bonfp / 2);

T      = tinv(twosid,df);

