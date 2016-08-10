

amp      = 10;               % amplitude 
fs       = 20500;            % sample freq
duration = 1;                % in seconds
freq     = [500 1000 1500];  % frequencies
val      = 0:1/fs:duration;  % 
a        = zeros(size(val)); % 
filename = 'tone.wav';     % output .wav

for i = 1:length(freq)
    a = amp*sin(2*pi*freq(i)*val) + a;
end
sound(a,fs) % NB. include fs for accurate duration


%b = amp*sin(2*pi*freq(1)*val);
%c = amp*sin(2*pi*freq(2)*val);
%d = amp*sin(2*pi*freq(3)*val);


audiowrite(filename,a,fs);

%[a,fs] = audioread(filename);