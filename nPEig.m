function y = nPEig(x,nc)

C = (x*x')./(size(x,2)-1);

% eigenvalue decomposition (EVD)
[E,D] = eig(C);

% sort eigenvectors in descending order of eigenvalues
d = cat(2,(1:1:size(C,1))',diag(D));
d = sortrows(d, -2);

% return the desired number of principal components
y = E(:,d(1:nc,1))';
