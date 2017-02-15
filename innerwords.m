function list = innerwords(x,y)

for i = 1:length(x)
    for j = 1:length(y)
        list{i,j} = [x{i} ' ' y{j}];
    end
end