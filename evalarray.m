function o = evalarray(in)
% Evaluate a cell array of [base] workspace variables into array of structures.
%
% AS2016 [util]


try in = {in.name}; end
if ~iscell(in); return; end

for i = 1:size(in,1)
    for j = 1:size(in,2)
        o{i,j} = evalin('base',in{i,j});
    end
end