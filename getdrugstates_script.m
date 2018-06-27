
K  =  '/Users/Alex/Dropbox/KET-PMP-GABZOL/New_VEs/KET'; 
P  =  '/Users/Alex/Dropbox/KET-PMP-GABZOL/New_VEs/KET_PLA'; 

[KetStates,PlaStates,K_CV,P_CV]=getdrugstates(K,P,1);

% bar([squeeze(mean(PlaStates(:,1,:,4),1)) ,...
%      squeeze(mean(KetStates(:,1,:,4),1)) ])
 

PM  =  '/Users/Alex/Dropbox/KET-PMP-GABZOL/New_VEs/PMP'; 
PL =  '/Users/Alex/Dropbox/KET-PMP-GABZOL/New_VEs/PMP_PLA'; 

[PmpStates,PMPlaStates,PM_CV,PL_CV]=getdrugstates(PM,PL,0);

% figure
% bar([squeeze(mean(PMPlaStates(:,1,:,2),1)) ,...
%      squeeze(mean(PmpStates(:,1,:,2),1)) ])
 
% rep membrance capacitances over nodes:
nn = size(PmpStates,2);
for i = 1:nn
    rK_CV(:,i,:) = K_CV;
    rP_CV(:,i,:) = P_CV;
    
    rPM_CV(:,i,:) = PM_CV;
    rPL_CV(:,i,:) = PL_CV;
end

KetStates(isnan(KetStates))=0;
PlaStates(isnan(PlaStates))=0;
PmpStates(isnan(PmpStates))=0;
PMPlaStates(isnan(PMPlaStates))=0;
                   
VE   =  60;  % reversal  potential excite (Na)
VI   = -90;  % reversal  potential inhib (Cl)
VN   =  10;  % reversal Ca(NMDA)   
VB   = -100; % reversal of GABA-B


% Ketamine: I = G*V
K_NMDA  = KetStates(:,:,:,4);
K_V     = KetStates(:,:,:,1);

Kp_NMDA = PlaStates(:,:,:,4);
Kp_V    = PlaStates(:,:,:,1);

K_I  = K_NMDA  .* (VN-K_V)  .* mg_switch(K_V) ./rK_CV;
Kp_I = Kp_NMDA .* (VN-Kp_V) .* mg_switch(Kp_V) ./rP_CV;

% Perampanel: I = G*V
Pm_AMPA = PmpStates(:,:,:,2);
Pm_V    = PmpStates(:,:,:,1);

Pm_I = Pm_AMPA .* (VE-Pm_V) ./rPM_CV;

Pl_AMPA = PMPlaStates(:,:,:,2);
Pl_V    = PMPlaStates(:,:,:,1);

Pl_I = Pl_AMPA .* (VE-Pl_V) ./rPL_CV;

% % node mean extraction function
% f = inline('squeeze(mean(x(:,y,:),1))','x','y');
% 
% % Ket/Pla, node 1:
% subplot(221), bar( [f(Kp_I,1) f(K_I,1)] )
% title('Ketamine/Placebo: Mean NMDA-mediated currents, node 1');
% legend({'Placebo' 'Ketamine'});
% 
% subplot(222), bar( [f(Kp_I,2) f(K_I,2)] )
% title('Ketamine/Placebo: Mean NMDA-mediated currents, node 2');
% legend({'Placebo' 'Ketamine'});
% 
% % Pmp/Pla, node 1
% subplot(223), bar( [f(Pl_I,1) f(Pm_I,1)] )
% title('Perampanel/Placebo: Mean AMPA-mediated currents, node 1');
% legend({'Placebo' 'Perampanel'});
% 
% subplot(224), bar( [f(Pl_I,2) f(Pm_I,2)] )
% title('Perampanel/Placebo: Mean AMPA-mediated currents, node 2');
% legend({'Placebo' 'Perampanel'});

Q = @squeeze;
Ket_I_m = squeeze(mean(K_I,2));
Kpla_I_m = squeeze(mean(Kp_I,2));

Pmp_I_m  = squeeze(mean(Pm_I,2));
Ppla_I_m = squeeze(mean(Pl_I,2));

figure,
f0 = inline('mean(x,y)','x','y');
cells = {'SS' 'SP' 'SI' 'DP' 'DI' 'TP' 'RT' 'RL'};

Kpla_I_m = abs(Kpla_I_m);
Ket_I_m = abs(Ket_I_m);

subplot(121), bar( ([f0(Kpla_I_m,1); f0(Ket_I_m,1)]') )
title('Ketamine/Placebo: Mean NMDA mediated currents');
legend({'Placebo' 'Ketamine'})
set(gca,'xtick',1:length(cells),'xticklabels',cells);


subplot(122), bar( [f0(Ppla_I_m,1); f0(Pmp_I_m,1)]' )
title('Perampanel/Placebo: Mean AMPA mediated currents');
legend({'Placebo' 'Perampanel'})
set(gca,'xtick',1:length(cells),'xticklabels',cells);



% Currents = 
%
% Ket placebpo: Kpla_I_m
% Ket Ket:      Ket_I_m
% PMP placebo   Ppla_I_m
% PMP PMP       Pmp_I_m

Glob.Kpla_I_m = sum(Kpla_I_m,2);
Glob.Ket_I_m  = sum(Ket_I_m,2);
Glob.Ppla_I_m = sum(Ppla_I_m,2);
Glob.Pmp_I_m  = sum(Pmp_I_m,2);



