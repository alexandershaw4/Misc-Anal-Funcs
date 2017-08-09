function fitline3d(x,y,z,c)

x = sort(x);
y = sort(y);
z = sort(z);

if nargin < 4;
    c = [1 0 0];
end
line(x,y,z,'color',c);