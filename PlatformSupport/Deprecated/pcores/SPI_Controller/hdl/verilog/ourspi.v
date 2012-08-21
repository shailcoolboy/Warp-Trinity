module ourspi (
	OPB_Clk,
	rst,
	opb_abus,
	opb_be,
	opb_dbus,
	opb_rnw,
	opb_select,
	opb_seqaddr,
	sl_dbus,
	sl_errack,
	sl_retry,
	sl_toutsup,
	sl_xferack,
	radio1_sclk,
	radio1_dout,
	radio1_cs,
	radio2_sclk,
	radio2_dout,
	radio2_cs,
	radio3_sclk,
	radio3_dout,
	radio3_cs,
	radio4_sclk,
	radio4_dout,
	radio4_cs,
	dac1_sclk,
	dac1_dout,
	dac1_cs,
	dac2_sclk,
	dac2_dout,
	dac2_cs,
	dac3_sclk,
	dac3_dout,
	dac3_cs,
	dac4_sclk,
	dac4_dout,
	dac4_cs
);

	parameter C_BASEADDR = 32'h8000_0000, C_HIGHADDR = 32'h8000_00ff;

	input	OPB_Clk;
	input	rst;

	input	[31:0]	opb_abus;
	input	[3:0]	opb_be;
	input	[31:0]	opb_dbus;
	input	opb_rnw;
	input	opb_select;
	input	opb_seqaddr;

	output	[31:0]	sl_dbus;
	output	sl_errack;
	output	sl_retry;
	output	sl_toutsup;
	output	sl_xferack;
	
	output radio1_sclk;
	output radio1_dout;
	output radio1_cs;
	output radio2_sclk;
	output radio2_dout;
	output radio2_cs;
	output radio3_sclk;
	output radio3_dout;
	output radio3_cs;
	output radio4_sclk;
	output radio4_dout;
	output radio4_cs;
	output dac1_sclk;
	output dac1_dout;
	output dac1_cs;
	output dac2_sclk;
	output dac2_dout;
	output dac2_cs;
	output dac3_sclk;
	output dac3_dout;
	output dac3_cs;
	output dac4_sclk;
	output dac4_dout;
	output dac4_cs;


	
	wire [4:0] spi_wb_adr_i;
	wire [31:0] spi_wb_dat_i;
	wire [31:0] spi_wb_dat_o;
	wire [3:0] spi_wb_sel_i;
	wire spi_wb_we_i;
	wire spi_wb_stb_i;
	wire spi_wb_cyc_i;
	wire spi_wb_ack_o;
	wire spi_wb_err_o;
	wire spi_wb_int_o;
	
	wire [7:0] spi_cs;
	wire spi_sclk;
	wire spi_dout;
	
	assign radio1_sclk = spi_sclk;
	assign radio2_sclk = spi_sclk;
	assign radio3_sclk = spi_sclk;
	assign radio4_sclk = spi_sclk;
	assign dac1_sclk = spi_sclk;
	assign dac2_sclk = spi_sclk;
	assign dac3_sclk = spi_sclk;
	assign dac4_sclk = spi_sclk;
	
	assign radio1_dout = spi_dout;
	assign radio2_dout = spi_dout;
	assign radio3_dout = spi_dout;
	assign radio4_dout = spi_dout;
	assign dac1_dout = spi_dout;
	assign dac2_dout = spi_dout;
	assign dac3_dout = spi_dout;
	assign dac4_dout = spi_dout;
	
	assign radio1_cs = spi_cs[0];
	assign radio2_cs = spi_cs[1];
	assign radio3_cs = spi_cs[2];
	assign radio4_cs = spi_cs[3];
	assign dac1_cs = spi_cs[4];
	assign dac2_cs = spi_cs[5];
	assign dac3_cs = spi_cs[6];
	assign dac4_cs = spi_cs[7];

	spi_top wishboneSPIController (
		.wb_clk_i(OPB_Clk),
		.wb_rst_i(rst),
		.wb_adr_i(spi_wb_adr_i),
		.wb_dat_i(spi_wb_dat_i),
		.wb_dat_o(spi_wb_dat_o),
		.wb_sel_i(spi_wb_sel_i),
		.wb_we_i(spi_wb_we_i),
		.wb_stb_i(spi_wb_stb_i),
		.wb_cyc_i(spi_wb_cyc_i),
		.wb_ack_o(spi_wb_ack_o),
		.wb_err_o(spi_wb_err_o),
		.wb_int_o(spi_wb_int_o),

		// SPI signals
		.ss_pad_o(spi_cs),
		.sclk_pad_o(spi_sclk),
		.mosi_pad_o(spi_dout),
		.miso_pad_i(1'b0)
	);



	opb2wb opb2wb_0 (
		.OPB_Clk(OPB_Clk),
		.rst(rst),
		.opb_abus(opb_abus),
		.opb_be(opb_be),
		.opb_dbus(opb_dbus),
		.opb_rnw(opb_rnw),
		.opb_select(opb_select),
		.opb_seqaddr(opb_seqaddr),
		.sl_dbus(sl_dbus),
		.sl_errack(sl_errack),
		.sl_retry(sl_retry),
		.sl_toutsup(sl_toutsup),
		.sl_xferack(sl_xferack),

		.wb_data_o(spi_wb_dat_i),
		.wb_data_i(spi_wb_dat_o),
		.wb_addr_o(spi_wb_adr_i),
		.wb_cyc_o(spi_wb_cyc_i),
		.wb_stb_o(spi_wb_stb_i),
		.wb_sel_o(spi_wb_sel_i),
		.wb_we_o(spi_wb_we_i),
		.wb_ack_i(spi_wb_ack_o),
		.wb_err_i(spi_wb_err_o),
		.wb_rty_i(1'b0)
	);

endmodule