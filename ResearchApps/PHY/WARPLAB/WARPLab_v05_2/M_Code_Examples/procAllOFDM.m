numTxNode = 4;
numRxNode = 4;
for txn = 1:numTxNode
	for rxn = 1:numRxNode
		mNodeRxMulti(rxn,txn);
	end
end
