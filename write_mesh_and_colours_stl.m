% requires v, f, & data


cdata = mean(data(f),2);

% Write binary STL with coloured faces
cLims = [min(cdata) max(cdata)];      % Transform height values
nCols = 255;  cMap = jet(nCols);    % onto an 8-bit colour map
fColsDbl = interp1(linspace(cLims(1),cLims(2),nCols),cMap,cdata);

fCols8bit = fColsDbl*255; % Pass cols in 8bit (0-255) RGB triplets
stlwrite('testCol.stl',f,v,'FaceColor',fCols8bit)