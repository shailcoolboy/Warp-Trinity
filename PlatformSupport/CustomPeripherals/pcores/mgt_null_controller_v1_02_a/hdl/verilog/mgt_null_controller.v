module mgt_null_controller (
	input grefclk,
	input [0:1] rxn_mgt01,
	input [0:1] rxp_mgt01,
	output [0:1] txn_mgt01,
	output [0:1] txp_mgt01,
	input [0:1] rxn_mgt02,
	input [0:1] rxp_mgt02,
	output [0:1] txn_mgt02,
	output [0:1] txp_mgt02,
	input [0:1] rxn_mgt03,
	input [0:1] rxp_mgt03,
	output [0:1] txn_mgt03,
	output [0:1] txp_mgt03,
	input [0:1] rxn_mgt05,
	input [0:1] rxp_mgt05,
	output [0:1] txn_mgt05,
	output [0:1] txp_mgt05,
	input [0:1] rxn_mgt06,
	input [0:1] rxp_mgt06,
	output [0:1] txn_mgt06,
	output [0:1] txp_mgt06,
	input [0:1] rxn_mgt09,
	input [0:1] rxp_mgt09,
	output [0:1] txn_mgt09,
	output [0:1] txp_mgt09,
	input [0:1] rxn_mgt10,
	input [0:1] rxp_mgt10,
	output [0:1] txn_mgt10,
	output [0:1] txp_mgt10,
	input [0:1] rxn_mgt12,
	input [0:1] rxp_mgt12,
	output [0:1] txn_mgt12,
	output [0:1] txp_mgt12,
	input [0:1] rxn_mgt13,
	input [0:1] rxp_mgt13,
	output [0:1] txn_mgt13,
	output [0:1] txp_mgt13,
	input [0:1] rxn_mgt14,
	input [0:1] rxp_mgt14,
	output [0:1] txn_mgt14,
	output [0:1] txp_mgt14
);

parameter enable_null_mgt02 = 1;
parameter enable_null_mgt12 = 1;
parameter enable_null_mgt13 = 1;
parameter enable_null_mgt14 = 1;

null_pair_example mgt01 (
	.clk(grefclk),
	.rx1n(rxn_mgt01),
	.rx1p(rxp_mgt01),
	.tx1n(txn_mgt01),
	.tx1p(txp_mgt01)
);

generate
if (enable_null_mgt02)
begin
	null_pair_example mgt02 (
		.clk(grefclk),
		.rx1n(rxn_mgt02),
		.rx1p(rxp_mgt02),
		.tx1n(txn_mgt02),
		.tx1p(txp_mgt02)
	);
end
endgenerate

null_pair_example mgt03 (
	.clk(grefclk),
	.rx1n(rxn_mgt03),
	.rx1p(rxp_mgt03),
	.tx1n(txn_mgt03),
	.tx1p(txp_mgt03)
);

null_pair_example mgt05 (
	.clk(grefclk),
	.rx1n(rxn_mgt05),
	.rx1p(rxp_mgt05),
	.tx1n(txn_mgt05),
	.tx1p(txp_mgt05)
);

null_pair_example mgt06 (
	.clk(grefclk),
	.rx1n(rxn_mgt06),
	.rx1p(rxp_mgt06),
	.tx1n(txn_mgt06),
	.tx1p(txp_mgt06)
);

null_pair_example mgt09 (
	.clk(grefclk),
	.rx1n(rxn_mgt09),
	.rx1p(rxp_mgt09),
	.tx1n(txn_mgt09),
	.tx1p(txp_mgt09)
);

null_pair_example mgt10 (
	.clk(grefclk),
	.rx1n(rxn_mgt10),
	.rx1p(rxp_mgt10),
	.tx1n(txn_mgt10),
	.tx1p(txp_mgt10)
);

generate
if (enable_null_mgt12)
begin
	null_pair_example mgt12 (
		.clk(grefclk),
		.rx1n(rxn_mgt12),
		.rx1p(rxp_mgt12),
		.tx1n(txn_mgt12),
		.tx1p(txp_mgt12)
	);
end
endgenerate

generate
if (enable_null_mgt13)
begin
	null_pair_example mgt13 (
		.clk(grefclk),
		.rx1n(rxn_mgt13),
		.rx1p(rxp_mgt13),
		.tx1n(txn_mgt13),
		.tx1p(txp_mgt13)
	);
end
endgenerate

generate
if (enable_null_mgt14)
begin
	null_pair_example mgt14 (
		.clk(grefclk),
		.rx1n(rxn_mgt14),
		.rx1p(rxp_mgt14),
		.tx1n(txn_mgt14),
		.tx1p(txp_mgt14)
	);
end
endgenerate

endmodule
