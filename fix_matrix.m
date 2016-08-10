function m = fix_matrix(m)
% AS2016 [util]

s1 = size(m);
s2 = size(m{1,1});


for a = 1:s1(1)
    for b = 1:s1(2)
        if ~all(size(m{a,b})==s2)
            
            % investigate
            t   = size(m{a,b});
            bad = find(t~=s2);            
            dif = s2(bad) - t(bad);
            
            %m{a,b} = [m{a,b}; zeros([dif,t(t~=t(bad))]) ];
            if bad == 1 
                  m{a,b}  = [m{a,b}; zeros([dif,t(2:end)])];
            else  m{a,b}  = [m{a,b}; zeros([dif,[t(1:bad-1),t(bad+1:end)]])];
            end
        end
    end
end