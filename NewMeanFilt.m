function y = NewMeanFilt3D(mIn,n,m)
% Mean window filtering & matrix sampling
% mIn in an n dimensional matrix
% n   is a resampling value (1 = no resamp, .5 = half, 2 = double etc).
% m   is the window kernel size
%
% *uses imresize which only resizes the first 2 dimensions!*
% AS2016 [updt] [updt 17]


if ndims(mIn) > 3; 
    % handle high dimentions
    mOut = size(mIn);
    mIn  = VecRetainDim(mIn,1);
end


M = imresize(mIn,n);
y = smoothmat(M,m,m,m);


try mOut;
    % reinstate orginal dimentions
    y = spm_unvec(y, ones([mOut(1)*(n*nn) mOut(2)*(n*nn) mOut(3)]));
end

end

function matrixOut = smoothmat(matrixIn,Nr,Nc,Nz)
% Smooths 2D array data.  Ignores NaN's.


if length(N(1)) ~= 1, error('Nr must be a scalar!'), end
if length(N(2)) ~= 1, error('Nc must be a scalar!'), end
if length(N(3)) ~= 1, error('Nz must be a scalar!'), end

[row,col,dep] = size(matrixIn);

eL = spdiags(ones(row,2*N(1)+1),(-N(1):N(1)),row,row);
eR = spdiags(ones(col,2*N(2)+1),(-N(2):N(2)),col,col);
eZ = spdiags(ones(dep,2*N(3)+1),(-N(3):N(3)),dep,dep);

A = isnan(matrixIn);
matrixIn(A) = 0;

%nrmlize = eL*(~A)*eR;
nrmlize = eL*(~A)*eR*(~A)*eZ;
nrmlize(A) = NaN;

matrixOut = eL*matrixIn*eR;
matrixOut = matrixOut./nrmlize;

end

