function [Pf,f] = Afft(signal,fs)

if ndims(signal) == 3
    for i = 1:size(signal,3); 
        [Pf(:,:,i),f] = Afft(squeeze(signal(:,:,i)),fs);
    end
    return
end

L = size(signal,2);
f = fs * (0:(L/2))/L;
for s = 1:size(signal,1)
    data  = signal(s,:);
    data  = fft(data);
    data  = abs(data/L);
    
    L2 = floor(L/2);
    Pf(s,:) = data(1:L2+1);
end
