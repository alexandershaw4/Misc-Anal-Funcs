

c = '/Users/Alex/Dropbox/KET-PMP-GABZOL/OLD_FreqVer_NotRVE/example/';
h = '210813_51_KET_600Cut.ds'; 
cd(c);

% read markers
trl  = readmarkerfile([c h]);
trli = cell(sum(trl.number_samples),1);

for i  = 1:length(trl.marker_names)
    mi = trl.marker_names{1};
    ti = trl.trial_times{1}(:,1);
    
    trli(ti) = {mi};
end

% create spm meeg
S.dataset = h;
S.usetrials = 1;
S.datatype = 'float32-le';
S.eventpadding = 0;
S.saveorigheader = 1;
S.inputformat = [];
S.mode = 'epoched';
S.conditionlabels = trli;

D = spm_eeg_convert(S);


% read with ft and copy sensor locations
sens = ft_read_sens(h);
sens = D.sensors('MEG');
sens.coilchan = sens.tra==1;
D = sensors(D,'MEG',sens);
D.save

