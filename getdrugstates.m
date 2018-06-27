function [KetStates,PlaStates,KetCV,PlaCV]=getdrugstates(K,P,varargin)

linearise = 1;
try
    linearise = varargin{1};
end

%K  =  '/Users/Alex/Dropbox/KET-PMP-GABZOL/New_VEs/KET'; 
cd(K);
MK = dir('CSD_Mod_2*'); MK = {MK.name};

[KetStates,KetCV] = Getx(MK,linearise);

%P  =  '/Users/Alex/Dropbox/KET-PMP-GABZOL/New_VEs/KET_PLA'; 
cd(P);
MP = dir('CSD_Mod_2*'); MP = {MP.name};

[PlaStates,PlaCV]= Getx(MP,linearise);


end

function [States,CV] = Getx(list,linearise)

if linearise
    fprintf('Linearising models\n');
else
    fprintf('Not linearising\n');
end
    
    for i = 1:length(list)
        load(list{i});
        
        str = sprintf('Dataset: %d / %d',i,length(list));
        if i>1; fprintf(repmat('\b',[1 size(str,2)])); end
        fprintf(str);
        
        M     = DCM.M;
        P     = DCM.Ep;

        try DCM.M.x;
            x       = spm_dcm_neural_x(P,M);
            x       = spm_fx_cmm_NMDA_Extended(x,1,P,M) ;
            DCM.M.x = spm_unvec(x, DCM.M.x);
        end
        cv = [128 128 256 32 256 32 256 32]/1000;
        CV(i,:) = exp(DCM.Ep.CV) .* cv;
        
        if ~linearise
            States(i,:,:,:) = DCM.M.x;
            if i == length(list)
                return;
            else
                continue
            end
        end

        ns    = size(P.A{1},1);     % number of sources (endogenous inputs)
        a     = 2;                  % regulariser
        M.u   = sparse(ns,1);
        dnx   = 0;
        for j = 1:128

            % solve under locally linear assumptions
            %--------------------------------------------------------------
            [f,dfdx] = feval(M.f,M.x,M.u,P,M);
            dx       = - dfdx\f;

            % regularise
            %--------------------------------------------------------------
            ndx   = norm(dx,Inf);
            if ndx < dnx
                a = a/2;
            end
            dnx    = ndx;

            % update and convergence
            %--------------------------------------------------------------
            M.x    = spm_unvec(spm_vec(M.x) + exp(-a)*dx,M.x);
            if dnx < 1e-12, break, end

        end

        States(i,:,:,:) = M.x;
    end
end

