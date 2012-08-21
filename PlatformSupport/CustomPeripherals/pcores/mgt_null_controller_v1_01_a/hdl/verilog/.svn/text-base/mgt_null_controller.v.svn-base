module mgt_null_controller (
	input grefclk,
	input [0:19] rxn,
	input [0:19] rxp,
	output [0:19] txn,
	output [0:19] txp
);


generate
genvar i;
	for(i=0; i<20; i=i+2) 
		begin:mgt_tiles
		null_pair_example mod (
			.clk(grefclk),
			.rx1n(rxn[i:i+1]),
			.rx1p(rxp[i:i+1]),
			.tx1n(txn[i:i+1]),
			.tx1p(txp[i:i+1])
		);
		end
endgenerate

endmodule
