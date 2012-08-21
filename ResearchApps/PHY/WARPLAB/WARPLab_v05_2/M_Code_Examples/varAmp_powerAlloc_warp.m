% 12/25/2011 % xyzhang
% Optimized power allocation for ZF MU-MIMO downlink
%clear all;
% Global varialbles
global numAE numCL Ptx CHrt CHout w N0 v, precodeM;
%numCL = 2;
%numAE = 3;
txID = 1;
Ptx = 1; %0.032; % per-antenna transmit power, 20dBm
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
		if (length(tr_amp)==0)
			fprintf(1, 'varAmp_powerAlloc, Nothing detected!\n');
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

for subc = 1:64
	if (subc <= 6 || subc >= 60 || subc == 33) continue; end 
	%CHrt = squeeze(estCHrt(:,:,subc));
	CHrt = squeeze(CHout(:,:,subc));

	numAE = length(CHrt(1,:));
	numCL = length(CHrt(:,1));
	numVars = numCL;
	
		% throughput weight 
		% test
		for k = 1:numCL
			w(k) = 1;
		end
	%{
	% ZFBF with matrix inversion
	precodeM(:,:,subc) = CHrt' * inv(CHrt * CHrt'); 
	%}

v = CHrt' * (CHrt*CHrt')^-1;
%??? Do I need this?
%for k = 1:length(v(1,:))
%    v(:,k) = v(:,k) / norm(v(:, k));
%end


% Linear inequality constraint
clear b;
for k = 1:numAE
    for i = 1:numCL
        A(k, i) = abs(v(k, i))^2;
    end 
    b(k) = Ptx;
end

% Linear equality constraint
Aeq = [];
beq = []; 

% lower and upper bound
lb = zeros(1, numVars);
ub = ones(1, numVars);
ub = ub*Ptx^0.5;
%x0 = zeros(numVars, 1);
clear x0;
x0(:, 1) = ones(numVars,1)*(Ptx/(numCL*numAE))^0.5;

%options=optimset('MaxFunEvals',1000000, 'MaxIter',1000000);
options=optimset('MaxFunEvals',1000', 'Algorithm', 'interior-point');
[x, fval] = fmincon(@varAmp_myutil_warp, x0, A, b, Aeq, beq, lb, ub, [], options);

for i = 1:numCL
	precodeM(:,i,subc) = x(i)^0.5 * v(:,i);
end

if subc ==20 
codedM = CHrt * squeeze(precodeM(:,:,subc));
fout = fopen('precodeMt_varAmp_warp.txt', 'w');
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

