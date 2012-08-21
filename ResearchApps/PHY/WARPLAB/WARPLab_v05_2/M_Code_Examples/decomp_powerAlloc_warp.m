% 02/17/2011
% xyzhang
% Optimized power allocation for ZF MU-MIMO downlink, with decomposed precoding
% vector (real and imag respectively)
%clear all;
% Global varialbles
%clear all;
global numAE numCL Ptx CHrt CHout h wt N0 precodeM;
txID = 1;

%Ptx_dBm = 20; % per-antenna transmit power, 20dBm
Ptx = 1; %10^(Ptx_dBm/10)/1000;
N0 = 2.5118e-13; %noise floor
%noiseFloor 2.5118e-13 //-96dBm
%noiseFloor 7.9433e-12 //-81dBm
%noiseFloor 1.5849e-11 //-78dBm

% Read the channel matrix
%CHrt = load('chmt.txt');
%%nch = norm(CHrt);
%%CHrt = CHrt/nch;
%%CHrt = CHrt .* exp(j*2*pi*rand(size(CHrt)));

%{
for rxn = 1:numRxNode
		f1 = sprintf('OFDM_trace_amp_r%d_t%d.txt', rxn, txID);
		tr_amp = load(f1); %tr(1:maxChannelRealize,:);
		f2 = sprintf('OFDM_trace_phs_r%d_t%d.txt', rxn, txID);
		tr_pha = load(f2); %tr(1:maxChannelRealize,:)/180;  
		if (length(tr_amp) == 0)
			fprintf(1, 'decomp_powerAlloc, Nothing detected!\n');
			return;
		end
	for subc = 1:64
		amplitude = tr_amp(subc,:);
		phase = tr_pha(subc,:)/180*pi;
		gain = amplitude.*exp(j*phase);
		%CHrt1 = reshape(gain, maxRxAntenna, maxTxAntenna);
		%CHrt(:,:,subc,rxn) = CHrt1(1:numRxAntenna, 1:numTxAntenna);
		estCHrt(rxn,:,subc) = gain; 
	end
end
%}

% ---- Calculate precoding vector for each subcarrer -----------
for subc = 1:64
	if (subc <= 6 || subc >= 60 || subc == 33) continue; end 
	%CHrt = squeeze(estCHrt(:,:,subc));
	CHrt = squeeze(CHout(:,:,subc));
	
	%{
	% ZFBF with matrix inversion
	precodeM(:,:,subc) = CHrt' * inv(CHrt * CHrt'); 
	%}

numCL = length(CHrt(:,1));
numAE = length(CHrt(1,:));

numVars = 2*numCL*numAE;

% throughput weight 
% test
for k = 1:numCL
    wt(k) = 1; 
end


% Variable: real(v_ki)... imag(v_ki)

% Linear equality constraint 1
EQrowCount = 0;
for i = 1:numCL
    EQrowCount = EQrowCount + 1;
    for ii = 1:numCL 
       if (ii ~= i) continue; end
       for kk = 1:numAE
           ct = (ii-1)*numAE + kk;
           Aeq(EQrowCount, ct) = imag(CHrt(ii, kk)); 
           ct = ct + numCL*numAE;
           Aeq(EQrowCount, ct) = real(CHrt(ii, kk)); 
       end
   end 
end


% Linear equality constraint 2
for i = 1:numCL
    for jj = 1:numCL
        if (jj == i) continue; end
        EQrowCount = EQrowCount + 1;
        
        for ii = 1:numCL
            if (ii ~= i) continue; end
            for kk = 1:numAE
                ct = (ii-1)*numAE + kk;
                Aeq(EQrowCount, ct) = real(CHrt(jj, kk)); 
                ct = ct + numCL*numAE;
                Aeq(EQrowCount, ct) = -imag(CHrt(jj, kk)); 
            end
        end
   end 
end

% Linear equality constraint 3
for i = 1:numCL
    for jj = 1:numCL
        if (jj == i) continue; end
        EQrowCount = EQrowCount + 1;
        
        for ii = 1:numCL
            if (ii ~= i) continue; end
            for kk = 1:numAE
                ct = (ii-1)*numAE + kk;
                Aeq(EQrowCount, ct) = imag(CHrt(jj, kk)); 
                ct = ct + numCL*numAE;
                Aeq(EQrowCount, ct) = real(CHrt(jj, kk)); 
            end
        end
   end 
end 
beq = zeros(EQrowCount, 1);


% Linear inequality constraint
A = [];
b = [];

% lower and upper bound
ub = ones(1, numVars);
ub = ub*Ptx^0.5;
lb = -ub;
%x0 = zeros(numVars, 1);

%x0(:, 1) = (Ptx/numCL)^0.5;
% Use pseudo-inverse precoding vector as the initial start point
% Precoding matrix --- 
% Row: tx antenna index
% Column: rx stream index
% Channel matrix --- 
% Row: rx antenna index
% Column: tx antenna index
% Data matrix: a column vector for different streams
%v = CHrt' * (CHrt*CHrt')^-1;
%v1 = reshape(v, numAE*numCL, 1);
%% normalize precoding vector 
%for k = 1:length(v1(1,:))
%    %v1 = v1 / norm(v1(:, k));
%end
%x0 = [real(v1); imag(v1)];
x0 = Ptx/(numAE*numCL) * ones(numVars, 1);

%options=optimset('MaxFunEvals',1000000, 'MaxIter',1000000);
%options=optimset('Algorithm', 'interior-point', 'Display', 'iter');
options=optimset('Display','off', 'MaxFunEvals', 3000);
%options=optimset('Algorithm', 'interior-point', 'MaxFunEvals', 5000, 'Display', 'off');
%options.LargeScale='off';
[x, fval] = fmincon(@decomp_myutil_warp, x0, A, b, Aeq, beq, lb, ub, @decomp_mycon_warp, options);
%[x, fval] = fmincon(@myutil, x0, A, b, Aeq, beq, lb, ub, @mycon);
%fprintf(1, '%f\n', fval);

mt = reshape(x, length(x)/2, 2);
cmt = mt(:,1)+j*mt(:,2);
precodeM(:,:,subc) = reshape(cmt, numAE, numCL);

codedM = CHrt * squeeze(precodeM(:,:,subc));

if subc ==20 
fout = fopen('precodeMt_decomp_warp.txt', 'w');
for k = 1:length(CHrt(:,1)) 
    fprintf(fout, '%g\n', abs(codedM(k, k))^2);
end
for k=1:numAE
    fprintf(fout, '%g\n', sum(abs(precodeM(k, :, subc)).^2));
end
%{
for r = 1:numAE
	for c = 1:numCL
    %fprintf(fout, '%g+j%g  ', real(precodeM(r,c,subc)),  imag(precodeM(r,c, subc)));
    fprintf(fout, '%g+j%g  ', real(codedM(r,c)),  imag(codedM(r,c)));
	end
    fprintf(fout, '\n');
end
%}
fclose(fout); 
end

end
% ---- end calculate precoding vector for each subcarrer -----------

