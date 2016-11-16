function [Min,Max] = minmax(in)

in = in(:);

Min = min(in);
Max = max(in);

if nargout < 2
    Min = [Min Max];
else
    return;
end

return
