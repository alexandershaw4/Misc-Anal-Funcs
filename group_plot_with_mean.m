function group_plot_with_mean(varargin)

if nargin == 1; Data = varargin{1}; end
if nargin >  1; f    = varargin{1};
                Data = varargin{2}; end

try   f;
catch f = 1:1:length(Data);
end
    
            
       h = plot(f, Data, 'k');         hold on; 
try    plot(f, mean(Data,2), 'r', 'LineWidth', 2);
catch  plot(f, mean(Data,1), 'r', 'LineWidth', 2);
end
set(h, 'color', [0.5 0.5 0.5]); hold off
