function D = Wksp2Strct()
% Put everything in the current base workspace into a strcutre and clear
% base wkspace

w = evalin('base','whos'); 
w = {w.name}; 
D = struct;

for i = 1:length(w)
    D.(w{i}) = evalin('base',w{i});
end

evalin('base','clear');