function [F,T,Y] = SPM_2TF(D,cfg)

try cfg; catch cfg = []; end

if isfield(cfg,'sensors'); meth = cfg.sensors; else meth = 'pca'; end
if isfield(cfg,'resamp');  rs   = cfg.resamp ; else rs   = 2;     end



% foi
if ~isempty(D.frequencies)
     Freqs = D.frequencies;
else Freqs = 1:.2:100;
end

% Data dimensions
S  = size(D);
ns = S(1);
nc = S(3);
nsam = S(2);

% FT
FT = D.fttimelock;

dt          = 1/D.fsample;
FS          = 1/dt;        % sampling frequenct
t           = D.time;      % peristim time
cfg.fsample = FS*rs;       % adjusted sample rate
t           = linspace(t(1), t(end),rs*length(t));

smooth      = 4;

for i = 1:nc
    Yc = D(:,:,i);
    cfg.sampletimes  = t;
    cfg.kill_evagram = 0;
    cfg.baseline     = 'none';
    cfg.baseline     = 'subtract';
    cfg.basetimes    = [-.1 .1];
    
    switch meth
        case 'pca';
            YY   = HighResMeanFilt(full(Yc),rs,smooth);
            YY   = PEig(YY');
            TF_Y = bert_singlechannel([YY';YY'],cfg,Freqs);
            
            Y{i} = double(TF_Y.evagram);
            F{i} = TF_Y.freqs;
            T{i} = TF_Y.sampletimes;
            
        case 'mean';
            YY   = HighResMeanFilt(full(Yc),rs,smooth);
            YY   = mean(YY);
            TF_Y = bert_singlechannel([YY;YY],cfg,Freqs);
            
            Y{i} = double(TF_Y.evagram);
            F{i} = TF_Y.freqs;
            T{i} = TF_Y.sampletimes;
        
        case {'sep','separate'};
            for j = 1:ns
                clc;
                fprintf('Calculating TF for condition %d of %d, sensor %d of %d\n',i,nc,j,ns);
                
                % resmaple as required
                YY = HighResMeanFilt(full(Yc(j,:)),rs,smooth);
                YY = full(YY);
                
                %YY = YY(:,1);
                
                
                
                % input trials*samples
                TF_Y = bert_singlechannel([YY;YY],cfg,Freqs);
                
                %Y = double(TF_Y.agram); % real
                Y{i,j} = double(TF_Y.evagram);
                
                F{i,j} = TF_Y.freqs;
                T{i,j} = TF_Y.sampletimes;
                
                %savename = sprintf('C%d_S%d',i,j);
                %save(savename,'Y','H','F','T');
                %clear H Y F T HH YY
            end
    end
    
end
        

