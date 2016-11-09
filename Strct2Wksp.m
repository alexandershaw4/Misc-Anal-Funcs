function Strct2Wksp(S)
% Reverse Wksp2Strct - i.e. unpack a structure to the base workspace
%
% AS

f = fieldnames(S);

for i = 1:length(f)
    assignin('base',f{i},(S.(f{i})));
end

