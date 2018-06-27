function [from to]=find_connection(number)

X = reshape(1:64,[8 8]);

for i = 1:length(number)

    [x,y,~]=find(X==number(i));

    cells = {'ss' 'sp' 'si' 'dp' 'di' 'tp' 'rt' 'rc'};

    from(i) = cells(y);
    to(i)   = cells(x);
end