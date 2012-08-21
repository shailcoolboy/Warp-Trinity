% 02/19/2012
% xyzhang
% Process the decoded symbols and calculate SINR
clear all;
numRxNode=2;
USE_ALL_SUBC = 0;

% Use all subcarriers to calculate SINR
if USE_ALL_SUBC
for rxn = 1:numRxNode
	resf = load(sprintf('MUMIMO_decode_rxn%d.txt', rxn));
	pos_ct = 0;
	neg_ct = 0;
	for k = 1:length(resf(:,1))
		if (resf(k,2) == -9999) continue; end

		if (resf(k,1) > 0)
			pos_ct = pos_ct + 1;
			pos(pos_ct) = resf(k,1);
		else
			neg_ct = neg_ct + 1;
			neg(neg_ct) = resf(k,1);
		end
	end
	SINR1(rxn) = (mean(pos)^2/var(pos) + mean(pos)^2/var(pos))/2;
	SINR(rxn) = 10*log10(SINR1(rxn));
	fprintf(1, 'RXN %d SINR %f rate %f\n', rxn, SINR(rxn),log2(1+SINR1(rxn)));
	clear pos, neg;
end

else
% Calculate SINR of each subcarrier separately
for rxn = 1:numRxNode
	resf = load(sprintf('MUMIMO_decode_rxn%d.txt', rxn));
	pos_ct = zeros(48,1);
	neg_ct = zeros(48,1);
   % for k = 1:720
 
	for k = 1:length(resf(:,1))
		subc = mod(k-1,48)+1;
		if (resf(k,2) == -9999) continue; end

		if (resf(k,1) > 0)
			pos_ct(subc) = pos_ct(subc) + 1;
			pos(pos_ct(subc), subc) = resf(k,1);
		else
			neg_ct(subc) = neg_ct(subc) + 1;
			neg(neg_ct(subc), subc) = resf(k,1);
		end
	end
	for k = 1:48
			[row, col, p] = find(pos(:,k));
			[row, col, n] = find(-neg(:,k));
			allres = [p; n];
			SINR = mean(allres)^2/var(allres);
			SINRout(k,rxn) = 10*log10(SINR);
			rateOut(k,rxn) = log2(1+SINR);
			%fprintf(1, 'RXN %d subc %d SINR %f\n', rxn, k, SINR);
	end
	uRate(rxn) = mean(rateOut(:,rxn));
	fprintf(1, 'RXN %d SINR %f rate %f\n', rxn, mean(SINRout(:,rxn)), uRate(rxn));
	clear pos, neg;
end
end

fprintf(1, 'sum rate %f mean rate %f mean SNR %f\n', sum(uRate), mean(uRate), mean(mean(SINRout(:,:))));

