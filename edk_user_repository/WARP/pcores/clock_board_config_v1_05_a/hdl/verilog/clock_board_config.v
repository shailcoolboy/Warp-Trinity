// The two clocks fed to the FPGA over the clock board
// header orginate in the AD9510 that supplied A/D and
// D/A (logic) clocks.  OUT5 supplies the two series
// terminated CMOS outputs, while OUT4 supplies the LVDS
// outputs that are (should be) parallel terminated at
// the inputs of the FPGA.
//
// To support various operating modes, a variable is
// defined to specify the operating modes for OUT4 and
// OUT5.
//
// OUT 5 supplies + and - CMOS outputs (test mode) : 16'h1EFF
// OUT 5 supplies + CMOS output only (normal mode) : 16'h0EFF
// OUT 5 powered down                              : 16'h0FFF

`define fpga_clk_out5_reg 16'h0EFF

// OUT 4 supplies + and - CMOS outputs (test mode) : 16'h1EFF
// OUT 4 powered down (normal mode)                : 16'h07FF
// OUT 4 supplies LVDS outputs                     : 16'h06FF

`define fpga_clk_out4_reg 16'h07FF

module clock_board_config (
	sys_clk,
	sys_rst,

	cfg_radio_dat_out,
	cfg_radio_csb_out,
	cfg_radio_en_out,
	cfg_radio_clk_out,

	cfg_logic_dat_out,
	cfg_logic_csb_out,
	cfg_logic_en_out,
	cfg_logic_clk_out,
	
	radio_clk_src_sel,
	logic_clk_src_sel,
	
	config_invalid
);

parameter sys_clk_freq_hz = 120000000;

// Select whether to use ports or parameters to select the clock sources
//  0: Use parameter (fpga_radio_clk_source or fpga_logic_clk_source)
//  1: Use port (radio_clk_src_sel or logic_clk_src_sel)
parameter radio_clk_source_sel_mode = 1'b0;
parameter logic_clk_source_sel_mode = 1'b0;

// Select the input source for the radio clocks.
//  CLK source for radio distribution = oscillator    : 0; //16'h1AFF
//  CLK source for radio distribution = external coax : 1; //16'h1DFF
//parameter fpga_radio_clk_source = 16'h1Aff;
parameter fpga_radio_clk_source = 1'b0;

// Select the input source for the logic (A/D and D/A) clocks.
//  CLK source for logic distribution = oscillator    : 0; //16'h1AFF
//  CLK source for logic distribution = external coax : 1; //16'h1DFF
//parameter fpga_logic_clk_source = 16'h1Aff;
parameter fpga_logic_clk_source = 1'b0;

// Parameters controlling en/disable on radio reference clk outputs
//  0x01ff disables the corresponding output
//  0x1eff enables the corresponding ouptput
// By default, outputs for slots 2 and 3 are enabled, matching
//  the hardware config for a WARP MIMO kit
parameter radio_clk_out4_mode = 16'h01ff; //J12
parameter radio_clk_out5_mode = 16'h1eff; //J11 (usually radio in slot 3)
parameter radio_clk_out6_mode = 16'h1eff; //J10 (usually radio in slot 2)
parameter radio_clk_out7_mode = 16'h01ff; //J6

// Parameter controlling whether to enable the off-board output of
//  the radio reference clock (used for dasiy-chaining clocks)
// 0x0BFF is disabled; 0x08FF is enabled
parameter radio_clk_forward_out_mode = 16'h0BFF;

// Parameters controlling en/disable on radio sampling clk outputs
//  0x02ff disables the corresponding output
//  0x04ff enables the corresponding output with min (340mV) drive
//  0x08ff enables the corresponding output with max (810mV) drive
// By default, outputs for slots 2 and 3 are enabled, matching
//  the hardware config for a WARP MIMO kit
parameter logic_clk_out0_mode = 16'h02ff; //J8
parameter logic_clk_out1_mode = 16'h02ff; //J7
parameter logic_clk_out2_mode = 16'h08ff; //J9 (usually radio in slot 3)
parameter logic_clk_out3_mode = 16'h08ff; //J13 (usually radio in slot 2)

// Parameter controlling whether to enable the off-board output of
//  the radio sampling clock (used for dasiy-chaining clocks)
// 0xh1FFF is disabled; 0xh1EFF is enabled
parameter logic_clk_forward_out_mode = 16'h1FFF;

input  sys_clk;
input  sys_rst;

output cfg_radio_dat_out; reg cfg_radio_dat_out = 1'b1;
output cfg_radio_csb_out; reg cfg_radio_csb_out = 1'b1;
output cfg_radio_en_out;  reg cfg_radio_en_out  = 1'b1;
output cfg_radio_clk_out; reg cfg_radio_clk_out = 1'b1;

output cfg_logic_dat_out; reg cfg_logic_dat_out = 1'b1;
output cfg_logic_csb_out; reg cfg_logic_csb_out = 1'b1;
output cfg_logic_en_out;  reg cfg_logic_en_out  = 1'b1;
output cfg_logic_clk_out; reg cfg_logic_clk_out = 1'b1;

input radio_clk_src_sel;
input logic_clk_src_sel;

wire srl11_radio_src_sel_ext_Q;
wire srl11_radio_src_sel_osc_Q;
wire srl11_logic_src_sel_ext_Q;
wire srl11_logic_src_sel_osc_Q;
wire srl11_radio_Q;
wire srl11_logic_Q;

output config_invalid;

// SCP_CNT [7:0] increments throughout each clock period
// of the AD9510 serial control port (SCP).  The absolute
// maximum clock frequency for the SCP is 25 MHz, but I'm
// limiting it to 12.5 MHz to be conservative.  If the
// system clock operates at exactly 87.5 MHz, then the
// minimum SCP clock period would equal exactly seven
// SYS_CLK periods.  In this case, SCP_CNT cycles through
// seven values -- 0, 1, 2, ..., 6 -- durin each SCP clock
// period.  The result is an SCP clock period of 80 nsec
// (12.5 MHz)..
//
// SCP_CYC_START and SCP_CYC_MID detect the start and middle
// of each SCP cycle, respectively.  The assertion of
// SCP_CYC_START, when appropriate, causes the SCP clock
// to go low.  In this state, the assertion of SCP_CYC_MID
// causes the SCP clock to return to its high state.

parameter scp_min_freq_hz = 2500000;

// a : How many SYS_CLK cycles per SCP cycle -- CEIL(X/Y)?
// b : Impose a minimum of 2 SYS_CLK cycles per SCP cycle.

parameter scp_cyc_leng_a = ((sys_clk_freq_hz + scp_min_freq_hz - 1) / scp_min_freq_hz);
parameter scp_cyc_leng_b = (scp_cyc_leng_a < 2) ? 2 : scp_cyc_leng_a;
parameter scp_cyc_leng   = scp_cyc_leng_b;

reg [3:0] scp_cnt_en     = 4'b0000;     // enable used for graceful power-up
reg [7:0] scp_cnt        = 8'b00000000; // SCP cycle counter
reg       scp_cnt_tc     = 1'b0;        // pulses HIGH during last SCP cycle to reset counter
reg       scp_cyc_start  = 1'b0;        // pulses high to denote start  of each SCP clock period
reg       scp_cyc_mid    = 1'b0;        // pulses high to denote middle of each SCP clock period 

always @ (posedge sys_clk)
begin
	scp_cnt_en [3:0] <= {1'b1,scp_cnt_en [3:1]};

	if (~scp_cnt_en [0])
	begin
		scp_cnt       [7:0] <= 8'b00000000;
		scp_cnt_tc          <= 1'b0;
		scp_cyc_start       <= 1'b0;
		scp_cyc_mid         <= 1'b0;
	end

	else
	begin
		if   (~scp_cnt_tc) scp_cnt [7:0] <= scp_cnt [7:0] + 1;
		else               scp_cnt [7:0] <= 8'b00000000;

		scp_cnt_tc     <= (scp_cnt [7:0] == ((scp_cyc_leng + 0) - 2));
		scp_cyc_start  <= (scp_cnt [7:0] ==                       0 );
		scp_cyc_mid    <= (scp_cnt [7:0] == ((scp_cyc_leng + 1) / 2));
	end

end



reg [3:0] sys_rst_lock = 4'b1111;
reg [2:0] sys_rst_sync = 3'b111;

always @ (posedge sys_clk or posedge sys_rst)
begin
	if   (sys_rst) sys_rst_lock [3] <= 1'b1;
	else           sys_rst_lock [3] <= 1'b0;
end

always @ (posedge sys_clk or posedge sys_rst_lock [3])
begin
	if   (sys_rst_lock [3]) sys_rst_lock [2:0] <= 3'b111;
	else                    sys_rst_lock [2:0] <= {1'b0,sys_rst_lock [2:1]};
end

always @ (posedge sys_clk)
begin
	sys_rst_sync [2:0] <= {sys_rst_lock [0],sys_rst_sync [2:1]};
end



// CFG_CYC [9:0] increments by 1 following each assertion
// of SCP_CYC_MID, until it finally "rolls over" to 0.
// Coincident with this roll-over is the assertion of
// CFG_CYC_DONE, thereby preventing any further increments
// to CFG_CYC.  The net result?...  SCP_CYC_START and
// SCP_CYC_MID each pulse high 1024 times while
// CFG_CYC_DONE is deasserted (low).  After this,
// CFG_CYC_START and CFG_CYC_MID continue to pulse, but
// CFG_CYC_DONE is asserted to mask of any "events" that
// depend upon the START and MID pulses.
//
// EXAMPLE : SCP_CYC_LENG = 6...
//
// SYS_CLK         : \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/       \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
// SCP_CYC_START   : 0|0|0|0|0|0|0|0|0|1|0|0|0|0|0|1|0|0|0|0|0|1|  ... |0|0|0|1|0|0|0|0|0|1|0|0|0|0|0|1|
// SCP_CYC_MID     : 0|0|0|0|0|0|0|0|0|0|0|0|1|0|0|0|0|0|1|0|0|0|  ... |1|0|0|0|0|0|1|0|0|0|0|0|1|0|0|0|
// CFG_CYC         :                 0        |     1     |     2  ...   |    1023   |        0
// CFG_DONE        : 0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|  ... |0|0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|
//
// EXAMPLE : SCP_CYC_LENG = 2...
//
// Same as in the previous example, except that
// SCP_CYC_START and SCP_CYC_MID are alternately pulsing
// high and low 180 degrees out of phase with respect to
// one another.

reg [9:0] cfg_cyc      = 10'b0000000000;
reg       cfg_cyc_done =  1'b1;
reg       cfg_restart  =  1'b0;
reg       cfg_clk_low  =  1'b0;
reg       cfg_clk_high =  1'b0;

reg		  cfg_cyc_done_d1 = 1'b1;

always @ (posedge sys_clk)
begin
	cfg_cyc_done_d1 <= cfg_cyc_done;
end



always @ (posedge sys_clk)
begin

	if (~scp_cyc_mid)
	begin
		cfg_cyc      [9:0] <= cfg_cyc [9:0];
		cfg_cyc_done       <= cfg_cyc_done;
	end

	else
	begin
		if (cfg_cyc_done)
		begin
			cfg_cyc      [9:0] <= 10'b0000000000;
			cfg_cyc_done       <= ~cfg_restart;
		end

		else
		begin
			cfg_cyc      [9:0] <= cfg_cyc [9:0] + 1;
			cfg_cyc_done       <= (cfg_cyc [9:0] == 10'b1111111111);
		end
	end

   cfg_restart  <= ~cfg_restart & cfg_cyc_done & (sys_rst_sync [1:0] == 2'b01)
                 |  cfg_restart & cfg_cyc_done & ~scp_cyc_mid;

   cfg_clk_low  <= ~cfg_cyc_done & scp_cyc_start;
   cfg_clk_high <= ~cfg_cyc_done & scp_cyc_mid;
end



// For a given sequence generation register (chain of
// SRLs), the SRL having index 0 delivers its data
// first, followed by the SRL having index 1.  The SRL
// having index 63 delivers its data last.  Hence the
// input of SRL N is fed by the output of SRL N + 1.
// The last SRL in each chain is fed with the output
// of the first SRL in he chain so that the configuration
// may be repeated on demand.
//
// Two sequence generators are defined, one for the
// AD9510 that clocks the radio ICs for up- and down-
// conversion, and another that clocks the FPGA and
// the radio boards' converters.

wire        srl_shift;

wire [63:0] srl_radio_d;
wire [63:0] srl_radio_q;

wire [63:0] srl_logic_d;
wire [63:0] srl_logic_q;

assign srl_shift          = cfg_clk_low;
//assign srl_radio_d [63:0] = {srl_radio_q [0],srl_radio_q [63:1]};
//assign srl_logic_d [63:0] = {srl_logic_q [0],srl_logic_q [63:1]};
assign srl_radio_d [63:0] = {srl_radio_q[0], srl_radio_q[63:12], srl11_radio_Q, srl_radio_q[10:1]};
assign srl_logic_d [63:0] = {srl_logic_q[0], srl_logic_q[63:12], srl11_logic_Q, srl_logic_q[10:1]};

//Select which srl will provide the clock source register value
// if:
//  param x_clk_source_sel_mode==1 AND port x_clk_src_sel==1, select srl for external source
//  param x_clk_source_sel_mode==0 AND parameter fpga_x_clk_source==1, select srl for external source
// else:
//  select srl for on-board oscillator
assign srl11_radio_Q = ( (radio_clk_source_sel_mode & radio_clk_src_sel) | (~radio_clk_source_sel_mode & fpga_radio_clk_source) ) ? srl11_radio_src_sel_ext_Q : srl11_radio_src_sel_osc_Q;
assign srl11_logic_Q = ( (logic_clk_source_sel_mode & logic_clk_src_sel) | (~logic_clk_source_sel_mode & fpga_logic_clk_source) ) ? srl11_logic_src_sel_ext_Q : srl11_logic_src_sel_osc_Q;

reg    config_invalid = 1'b1;

always @(posedge sys_clk)
begin
	if(cfg_cyc_done & ~cfg_cyc_done_d1)
		config_invalid <= 1'b0;
	else if(cfg_restart)
		config_invalid <= 1'b1;
end

// ALL SRLs in this module are configured for a static
// shift length of 16.  For a given 16-bit SRL INIT
// value, the high order bit will be shifted out first,
// while the low order bit will be shifted out last.
// It is, therefore, VERY convenient to operate the
// AD9510s in MSB first mode.  Pros : This is the
// default operating mode for the AD9510, and requires
// no additional hocus pocus.  Cons : Addresses are
// decremented as data is written into each device.
// This requires an extra control access to address
// 5A in order to force the update -- not rocket science,
// but very important to remember.  See the AD9510 data
// sheet, revision A, pages 42 and 43 for details.

genvar ii;
generate
	for (ii = 0 ; ii < 64 ; ii = ii + 1)
	begin : gen_srls

		SRL16E srl_radio (
			.Q   (srl_radio_q [ii]),
			.A0  (1'b1            ),
			.A1  (1'b1            ),
			.A2  (1'b1            ),
			.A3  (1'b1            ),
			.CE  (srl_shift       ),
			.CLK (sys_clk         ),
			.D   (srl_radio_d [ii])
		);

		SRL16E srl_logic (
			.Q   (srl_logic_q [ii]),
			.A0  (1'b1            ),
			.A1  (1'b1            ),
			.A2  (1'b1            ),
			.A3  (1'b1            ),
			.CE  (srl_shift       ),
			.CLK (sys_clk         ),
			.D   (srl_logic_d [ii])
		);

	end
endgenerate

SRL16E srl11_radio_src_sel_ext (
	.Q   (srl11_radio_src_sel_ext_Q),
	.A0  (1'b1            ),
	.A1  (1'b1            ),
	.A2  (1'b1            ),
	.A3  (1'b1            ),
	.CE  (srl_shift       ),
	.CLK (sys_clk         ),
	.D   (srl_radio_d [11])
);

SRL16E srl11_radio_src_sel_osc (
	.Q   (srl11_radio_src_sel_osc_Q),
	.A0  (1'b1            ),
	.A1  (1'b1            ),
	.A2  (1'b1            ),
	.A3  (1'b1            ),
	.CE  (srl_shift       ),
	.CLK (sys_clk         ),
	.D   (srl_radio_d [11])
);

SRL16E srl11_logic_src_sel_ext (
	.Q   (srl11_logic_src_sel_ext_Q),
	.A0  (1'b1            ),
	.A1  (1'b1            ),
	.A2  (1'b1            ),
	.A3  (1'b1            ),
	.CE  (srl_shift       ),
	.CLK (sys_clk         ),
	.D   (srl_logic_d [11])
);

SRL16E srl11_logic_src_sel_osc (
	.Q   (srl11_logic_src_sel_osc_Q),
	.A0  (1'b1            ),
	.A1  (1'b1            ),
	.A2  (1'b1            ),
	.A3  (1'b1            ),
	.CE  (srl_shift       ),
	.CLK (sys_clk         ),
	.D   (srl_logic_d [11])
);

defparam srl11_logic_src_sel_osc.INIT = 16'h1AFF;
defparam srl11_logic_src_sel_ext.INIT = 16'h1DFF;
defparam srl11_radio_src_sel_osc.INIT = 16'h1AFF;
defparam srl11_radio_src_sel_ext.INIT = 16'h1DFF;

// Here's where we define the register contents
// Each "defparam gen_srls" corresponds to one 16 bit SPI transaction

// Register contents for the radio reference generator

// Leave some emtpy clock cycles at boot to let things settle
defparam gen_srls[ 0].srl_radio.INIT = 16'hFFFF; // CYCLES    0 -   15
defparam gen_srls[ 1].srl_radio.INIT = 16'hFFFF; // CYCLES   16 -   31
defparam gen_srls[ 2].srl_radio.INIT = 16'hFFFF; // CYCLES   32 -   47
defparam gen_srls[ 3].srl_radio.INIT = 16'hFFFF; // CYCLES   48 -   63
defparam gen_srls[ 4].srl_radio.INIT = 16'hFFFF; // CYCLES   64 -   79
defparam gen_srls[ 5].srl_radio.INIT = 16'hFFFF; // CYCLES   80 -   95

// Issue soft-reset; does *not* require write to 5A to take effect
// reg[0] <= 30, then 10 (assert, then de-assert reset bit)
defparam gen_srls[ 6].srl_radio.INIT = 16'h0000; // CYCLES   96 -  111
defparam gen_srls[ 7].srl_radio.INIT = 16'h30FF; // CYCLES  112 -  127

defparam gen_srls[ 8].srl_radio.INIT = 16'h0000; // CYCLES  128 -  143
defparam gen_srls[ 9].srl_radio.INIT = 16'h10FF; // CYCLES  144 -  159

// Switch clock input to CLK2; power-down CLK1 and PLL input
// reg[45] <= 1A
defparam gen_srls[10].srl_radio.INIT = 16'h0045;               // CYCLES  160 -  175
defparam gen_srls[11].srl_radio.INIT = fpga_radio_clk_source; // CYCLES  176 -  191

// Bypass dividers on all clocks
// reg[49,4B,4D,4F,51,53,55,57] <= 80

defparam gen_srls[12].srl_radio.INIT = 16'h0049; // CYCLES  192 -  207
defparam gen_srls[13].srl_radio.INIT = 16'h80FF; // CYCLES  208 -  223

defparam gen_srls[14].srl_radio.INIT = 16'h004B; // CYCLES  224 -  239
defparam gen_srls[15].srl_radio.INIT = 16'h80FF; // CYCLES  240 -  255

defparam gen_srls[16].srl_radio.INIT = 16'h004D; // CYCLES  256 -  271
defparam gen_srls[17].srl_radio.INIT = 16'h80FF; // CYCLES  272 -  287

defparam gen_srls[18].srl_radio.INIT = 16'h004F; // CYCLES  288 -  303
defparam gen_srls[19].srl_radio.INIT = 16'h80FF; // CYCLES  304 -  319

defparam gen_srls[20].srl_radio.INIT = 16'h0051; // CYCLES  320 -  335
defparam gen_srls[21].srl_radio.INIT = 16'h80FF; // CYCLES  336 -  351

defparam gen_srls[22].srl_radio.INIT = 16'h0053; // CYCLES  352 -  367
defparam gen_srls[23].srl_radio.INIT = 16'h80FF; // CYCLES  368 -  383

defparam gen_srls[24].srl_radio.INIT = 16'h0055; // CYCLES  384 -  399
defparam gen_srls[25].srl_radio.INIT = 16'h80FF; // CYCLES  400 -  415

defparam gen_srls[26].srl_radio.INIT = 16'h0057; // CYCLES  416 -  431
defparam gen_srls[27].srl_radio.INIT = 16'h80FF; // CYCLES  432 -  447

// Configure the output properties on the CMOS clock outputs.
// Enabled outputs require CMOS (not LVDS), invertered output enabled
// reg[40,41,42,43] <= 1E means output is enabled
// reg[40,41,42,43] <= 01 means output is disabled
defparam gen_srls[28].srl_radio.INIT = 16'h0040; // CYCLES  448 -  463
defparam gen_srls[29].srl_radio.INIT = radio_clk_out4_mode; // CYCLES  464 -  479

defparam gen_srls[30].srl_radio.INIT = 16'h0041; // CYCLES  480 -  495
defparam gen_srls[31].srl_radio.INIT = radio_clk_out5_mode; // CYCLES  496 -  511

defparam gen_srls[32].srl_radio.INIT = 16'h0042; // CYCLES  512 -  527
defparam gen_srls[33].srl_radio.INIT = radio_clk_out6_mode; // CYCLES  528 -  543

defparam gen_srls[34].srl_radio.INIT = 16'h0043; // CYCLES  544 -  559
defparam gen_srls[35].srl_radio.INIT = radio_clk_out7_mode; // CYCLES  560 -  575

// Configure the output properties on the PECL clock outputs
// OUT0 enabled, 810mV drive; OUT1/2/3 disabled
// reg[3C] <= 08; reg[3D,3E,3F] <= 0B
defparam gen_srls[36].srl_radio.INIT = 16'h003C; // CYCLES  576 -  591
//defparam gen_srls[37].srl_radio.INIT = 16'h08FF; // CYCLES  592 -  607
defparam gen_srls[37].srl_radio.INIT = radio_clk_forward_out_mode; // CYCLES  592 -  607

defparam gen_srls[38].srl_radio.INIT = 16'h003D; // CYCLES  608 -  623
defparam gen_srls[39].srl_radio.INIT = 16'h0BFF; // CYCLES  624 -  639

defparam gen_srls[40].srl_radio.INIT = 16'h003E; // CYCLES  640 -  655
defparam gen_srls[41].srl_radio.INIT = 16'h0BFF; // CYCLES  656 -  671

defparam gen_srls[42].srl_radio.INIT = 16'h003F; // CYCLES  672 -  687
defparam gen_srls[43].srl_radio.INIT = 16'h0BFF; // CYCLES  688 -  703


// Latch the loaded values into the actual config registers
// reg[5A] <= FF
defparam gen_srls[44].srl_radio.INIT = 16'h005A; // CYCLES  704 -  719
defparam gen_srls[45].srl_radio.INIT = 16'hFFFF; // CYCLES  720 -  735

// unused cycles
defparam gen_srls[46].srl_radio.INIT = 16'hFFFF; // CYCLES  736 -  751
defparam gen_srls[47].srl_radio.INIT = 16'hFFFF; // CYCLES  752 -  767
defparam gen_srls[48].srl_radio.INIT = 16'hFFFF; // CYCLES  768 -  783
defparam gen_srls[49].srl_radio.INIT = 16'hFFFF; // CYCLES  784 -  799
defparam gen_srls[50].srl_radio.INIT = 16'hFFFF; // CYCLES  800 -  815
defparam gen_srls[51].srl_radio.INIT = 16'hFFFF; // CYCLES  816 -  831
defparam gen_srls[52].srl_radio.INIT = 16'hFFFF; // CYCLES  832 -  847
defparam gen_srls[53].srl_radio.INIT = 16'hFFFF; // CYCLES  848 -  863
defparam gen_srls[54].srl_radio.INIT = 16'hFFFF; // CYCLES  864 -  879
defparam gen_srls[55].srl_radio.INIT = 16'hFFFF; // CYCLES  880 -  895
defparam gen_srls[56].srl_radio.INIT = 16'hFFFF; // CYCLES  896 -  911
defparam gen_srls[57].srl_radio.INIT = 16'hFFFF; // CYCLES  912 -  927
defparam gen_srls[58].srl_radio.INIT = 16'hFFFF; // CYCLES  928 -  943
defparam gen_srls[59].srl_radio.INIT = 16'hFFFF; // CYCLES  944 -  959
defparam gen_srls[60].srl_radio.INIT = 16'hFFFF; // CYCLES  960 -  975
defparam gen_srls[61].srl_radio.INIT = 16'hFFFF; // CYCLES  976 -  991
defparam gen_srls[62].srl_radio.INIT = 16'hFFFF; // CYCLES  992 - 1007
defparam gen_srls[63].srl_radio.INIT = 16'hFFFF; // CYCLES 1008 - 1023

// Here's some m-code that will help generate these vectors:
// csb_low =  96   + 32*[0:15];sprintf('cfg_cyc == %d | ',csb_low)
// csb_high = 96-8 + 32*[1:16];sprintf('cfg_cyc == %d | ',csb_high)

`define RADIO_CSB_LOW_DECODE  ((cfg_cyc ==  96) | (cfg_cyc == 128) | (cfg_cyc == 160) | (cfg_cyc == 192) | (cfg_cyc == 224) | (cfg_cyc == 256) | (cfg_cyc == 288) | (cfg_cyc == 320) | (cfg_cyc == 352) | (cfg_cyc == 384) | (cfg_cyc == 416) | (cfg_cyc == 448) | (cfg_cyc == 480) | (cfg_cyc == 512) | (cfg_cyc == 544) | (cfg_cyc == 576) | (cfg_cyc == 608) | (cfg_cyc == 640) | (cfg_cyc == 672) | (cfg_cyc == 704))
`define RADIO_CSB_HIGH_DECODE ((cfg_cyc == 120) | (cfg_cyc == 152) | (cfg_cyc == 184) | (cfg_cyc == 216) | (cfg_cyc == 248) | (cfg_cyc == 280) | (cfg_cyc == 312) | (cfg_cyc == 344) | (cfg_cyc == 376) | (cfg_cyc == 408) | (cfg_cyc == 440) | (cfg_cyc == 472) | (cfg_cyc == 504) | (cfg_cyc == 536) | (cfg_cyc == 568) | (cfg_cyc == 600) | (cfg_cyc == 632) | (cfg_cyc == 664) | (cfg_cyc == 696) | (cfg_cyc == 728))
`define RADIO_EN_LOW_DECODE   ( cfg_cyc ==   0)
`define RADIO_EN_HIGH_DECODE	( cfg_cyc ==   4)

//Register contents for the converter clock generator

// Leave some emtpy clock cycles at boot to let things settle
defparam gen_srls[ 0].srl_logic.INIT = 16'hFFFF; // CYCLES    0 -   15
defparam gen_srls[ 1].srl_logic.INIT = 16'hFFFF; // CYCLES   16 -   31
defparam gen_srls[ 2].srl_logic.INIT = 16'hFFFF; // CYCLES   32 -   47
defparam gen_srls[ 3].srl_logic.INIT = 16'hFFFF; // CYCLES   48 -   63
defparam gen_srls[ 4].srl_logic.INIT = 16'hFFFF; // CYCLES   64 -   79
defparam gen_srls[ 5].srl_logic.INIT = 16'hFFFF; // CYCLES   80 -   95

// Issue soft-reset; does *not* require write to 5A to take effect
// reg[0] <= 30, then 10 (assert, then de-assert reset bit)
defparam gen_srls[ 6].srl_logic.INIT = 16'h0000; // CYCLES   96 -  111
defparam gen_srls[ 7].srl_logic.INIT = 16'h30FF; // CYCLES  112 -  127

defparam gen_srls[ 8].srl_logic.INIT = 16'h0000; // CYCLES  128 -  143
defparam gen_srls[ 9].srl_logic.INIT = 16'h10FF; // CYCLES  144 -  159

// Switch clock input to CLK2; power-down CLK1 and PLL input
// reg[45] <= 1A
// defparam gen_srls[10].srl_logic.INIT = 16'h0045; // CYCLES  160 -  175
// defparam gen_srls[11].srl_logic.INIT = 16'h1AFF; // CYCLES  176 -  191

// For now, switch clock input to CLK1; power-down CLK2 and PLL input
// reg[45] <= 1D
defparam gen_srls[10].srl_logic.INIT = 16'h0045;               // CYCLES  160 -  175
defparam gen_srls[11].srl_logic.INIT = fpga_logic_clk_source; // CYCLES  176 -  191

// Bypass dividers on all clocks
// reg[49,4B,4D,4F,51,53,55,57] <= 80

defparam gen_srls[12].srl_logic.INIT = 16'h0049; // CYCLES  192 -  207
defparam gen_srls[13].srl_logic.INIT = 16'h80FF; // CYCLES  208 -  223

defparam gen_srls[14].srl_logic.INIT = 16'h004B; // CYCLES  224 -  239
defparam gen_srls[15].srl_logic.INIT = 16'h80FF; // CYCLES  240 -  255

defparam gen_srls[16].srl_logic.INIT = 16'h004D; // CYCLES  256 -  271
defparam gen_srls[17].srl_logic.INIT = 16'h80FF; // CYCLES  272 -  287

defparam gen_srls[18].srl_logic.INIT = 16'h004F; // CYCLES  288 -  303
defparam gen_srls[19].srl_logic.INIT = 16'h80FF; // CYCLES  304 -  319

defparam gen_srls[20].srl_logic.INIT = 16'h0051; // CYCLES  320 -  335
defparam gen_srls[21].srl_logic.INIT = 16'h80FF; // CYCLES  336 -  351

defparam gen_srls[22].srl_logic.INIT = 16'h0053; // CYCLES  352 -  367
defparam gen_srls[23].srl_logic.INIT = 16'h80FF; // CYCLES  368 -  383

defparam gen_srls[24].srl_logic.INIT = 16'h0055; // CYCLES  384 -  399
defparam gen_srls[25].srl_logic.INIT = 16'h80FF; // CYCLES  400 -  415

defparam gen_srls[26].srl_logic.INIT = 16'h0057; // CYCLES  416 -  431
defparam gen_srls[27].srl_logic.INIT = 16'h80FF; // CYCLES  432 -  447

// Configure the output properties on the PECL clock outputs
// OUT0-OUT3 enabled, 810mV drive;
// reg[3C,3D,3E,3F] <= 08; enables outputs with max (810mV) drive
// reg[3C,3D,3E,3F] <= 04; enables outputs with min (340mV) drive
// reg[3C,3D,3E,3F] <= 02; disables outputs

defparam gen_srls[28].srl_logic.INIT = 16'h003C; // CYCLES  448 -  463
defparam gen_srls[29].srl_logic.INIT = logic_clk_out0_mode; // CYCLES  464 -  479

defparam gen_srls[30].srl_logic.INIT = 16'h003D; // CYCLES  480 -  495
defparam gen_srls[31].srl_logic.INIT = logic_clk_out1_mode; // CYCLES  496 -  511

defparam gen_srls[32].srl_logic.INIT = 16'h003E; // CYCLES  512 -  527
defparam gen_srls[33].srl_logic.INIT = logic_clk_out2_mode; // CYCLES  528 -  543

defparam gen_srls[34].srl_logic.INIT = 16'h003F; // CYCLES  544 -  559
defparam gen_srls[35].srl_logic.INIT = logic_clk_out3_mode; // CYCLES  560 -  575

// Configure the output properties for the forwarded clock (OUT7)
// CMOS (not LVDS), inverted output enabled, maximum drive current
// reg[43] <= 1E;
defparam gen_srls[36].srl_logic.INIT = 16'h0043; // CYCLES  576 -  591
//defparam gen_srls[37].srl_logic.INIT = 16'h1EFF; // CYCLES  592 -  607
defparam gen_srls[37].srl_logic.INIT = logic_clk_forward_out_mode; // CYCLES  592 -  607

// Power down CMOS OUT6
// reg[42] <= 1F;
defparam gen_srls[38].srl_logic.INIT = 16'h0042; // CYCLES  608 -  623
defparam gen_srls[39].srl_logic.INIT = 16'h1FFF; // CYCLES  624 -  639

// OUT5 : See comments at the top of this file
defparam gen_srls[40].srl_logic.INIT = 16'h0041;           // CYCLES  640 -  655
defparam gen_srls[41].srl_logic.INIT = `fpga_clk_out5_reg; // CYCLES  656 -  671

// OUT4 : See comments at the top of this file
defparam gen_srls[42].srl_logic.INIT = 16'h0040;           // CYCLES  672 -  687
defparam gen_srls[43].srl_logic.INIT = `fpga_clk_out4_reg; // CYCLES  688 -  703

// Latch the loaded values into the actual config registers
// reg[5A] <= FF

defparam gen_srls[44].srl_logic.INIT = 16'h005A; // CYCLES  704 -  719
defparam gen_srls[45].srl_logic.INIT = 16'hFFFF; // CYCLES  720 -  735

// unused cycles
defparam gen_srls[46].srl_logic.INIT = 16'h0000; // CYCLES  736 -  751
defparam gen_srls[47].srl_logic.INIT = 16'h0000; // CYCLES  752 -  767
defparam gen_srls[48].srl_logic.INIT = 16'h0000; // CYCLES  768 -  783
defparam gen_srls[49].srl_logic.INIT = 16'h0000; // CYCLES  784 -  799
defparam gen_srls[50].srl_logic.INIT = 16'h0000; // CYCLES  800 -  815
defparam gen_srls[51].srl_logic.INIT = 16'h0000; // CYCLES  816 -  831
defparam gen_srls[52].srl_logic.INIT = 16'h0000; // CYCLES  832 -  847
defparam gen_srls[53].srl_logic.INIT = 16'h0000; // CYCLES  848 -  863
defparam gen_srls[54].srl_logic.INIT = 16'h0000; // CYCLES  864 -  879
defparam gen_srls[55].srl_logic.INIT = 16'h0000; // CYCLES  880 -  895
defparam gen_srls[56].srl_logic.INIT = 16'h0000; // CYCLES  896 -  911
defparam gen_srls[57].srl_logic.INIT = 16'h0000; // CYCLES  912 -  927
defparam gen_srls[58].srl_logic.INIT = 16'h0000; // CYCLES  928 -  943
defparam gen_srls[59].srl_logic.INIT = 16'h0000; // CYCLES  944 -  959
defparam gen_srls[60].srl_logic.INIT = 16'h0000; // CYCLES  960 -  975
defparam gen_srls[61].srl_logic.INIT = 16'h0000; // CYCLES  976 -  991
defparam gen_srls[62].srl_logic.INIT = 16'h0000; // CYCLES  992 - 1007
defparam gen_srls[63].srl_logic.INIT = 16'h0000; // CYCLES 1008 - 1023

`define LOGIC_CSB_LOW_DECODE  ((cfg_cyc ==  96) | (cfg_cyc == 128) | (cfg_cyc == 160) | (cfg_cyc == 192) | (cfg_cyc == 224) | (cfg_cyc == 256) | (cfg_cyc == 288) | (cfg_cyc == 320) | (cfg_cyc == 352) | (cfg_cyc == 384) | (cfg_cyc == 416) | (cfg_cyc == 448) | (cfg_cyc == 480) | (cfg_cyc == 512) | (cfg_cyc == 544) | (cfg_cyc == 576) | (cfg_cyc == 608) | (cfg_cyc == 640) | (cfg_cyc == 672) | (cfg_cyc == 704))
`define LOGIC_CSB_HIGH_DECODE ((cfg_cyc == 120) | (cfg_cyc == 152) | (cfg_cyc == 184) | (cfg_cyc == 216) | (cfg_cyc == 248) | (cfg_cyc == 280) | (cfg_cyc == 312) | (cfg_cyc == 344) | (cfg_cyc == 376) | (cfg_cyc == 408) | (cfg_cyc == 440) | (cfg_cyc == 472) | (cfg_cyc == 504) | (cfg_cyc == 536) | (cfg_cyc == 568) | (cfg_cyc == 600) | (cfg_cyc == 632) | (cfg_cyc == 664) | (cfg_cyc == 696) | (cfg_cyc == 728))
`define LOGIC_EN_LOW_DECODE   (cfg_cyc ==  0)
`define LOGIC_EN_HIGH_DECODE  (cfg_cyc ==  4)

// Decode various values of CFG_CYC to assert and deassert
// control signals at various bit positions within the
// configuration sequences.  CFG_RADIO_CSB_LOW, for example,
// should decode the value of CFG_CYC corresponding to the
// first bit of an SCP command.  CFG_RADIO_CSB_HIGH should
// likewise decode the value corresponding to the first
// bit FOLLOWING a streaming register access.

reg       cfg_radio_csb_low  = 1'b0;
reg       cfg_radio_csb_high = 1'b0;
reg       cfg_radio_en_low   = 1'b0;
reg       cfg_radio_en_high  = 1'b0;

reg       cfg_logic_csb_low  = 1'b0;
reg       cfg_logic_csb_high = 1'b0;
reg       cfg_logic_en_low   = 1'b0;
reg       cfg_logic_en_high  = 1'b0;

always @ (posedge sys_clk)
begin
	if (~scp_cyc_start)
	begin
		cfg_radio_csb_low   <=  1'b0;
		cfg_radio_csb_high  <=  1'b0;
		cfg_radio_en_low    <=  1'b0;
		cfg_radio_en_high   <=  1'b0;

		cfg_logic_csb_low   <=  1'b0;
		cfg_logic_csb_high  <=  1'b0;
		cfg_logic_en_low    <=  1'b0;
		cfg_logic_en_high   <=  1'b0;
	end

	else
	begin
		if (cfg_cyc_done)
		begin
			cfg_radio_csb_low   <=  1'b0;
			cfg_radio_csb_high  <=  1'b1;
			cfg_radio_en_low    <=  1'b0;
			cfg_radio_en_high   <=  1'b1;

			cfg_logic_csb_low   <=  1'b0;
			cfg_logic_csb_high  <=  1'b1;
			cfg_logic_en_low    <=  1'b0;
			cfg_logic_en_high   <=  1'b1;
		end
		else
		begin
			cfg_radio_csb_low   <= `RADIO_CSB_LOW_DECODE;
			cfg_radio_csb_high  <= `RADIO_CSB_HIGH_DECODE;
			cfg_radio_en_low    <= `RADIO_EN_LOW_DECODE;
			cfg_radio_en_high   <= `RADIO_EN_HIGH_DECODE;

			cfg_logic_csb_low   <= `LOGIC_CSB_LOW_DECODE;
			cfg_logic_csb_high  <= `LOGIC_CSB_HIGH_DECODE;
			cfg_logic_en_low    <= `LOGIC_EN_LOW_DECODE;
			cfg_logic_en_high   <= `LOGIC_EN_HIGH_DECODE;
		end

	end

end



always @ (posedge sys_clk)
begin
	if   (srl_shift) cfg_radio_dat_out <=  srl_radio_q [0];
	else             cfg_radio_dat_out <=  cfg_radio_dat_out; 

	cfg_radio_csb_out <=  cfg_radio_csb_out & ~cfg_radio_csb_low
                      | ~cfg_radio_csb_out &  cfg_radio_csb_high;
	cfg_radio_en_out  <=  cfg_radio_en_out  & ~cfg_radio_en_low
                      | ~cfg_radio_en_out  &  cfg_radio_en_high;
	cfg_radio_clk_out <=  cfg_radio_clk_out & ~cfg_clk_low
                      | ~cfg_radio_clk_out &  cfg_clk_high;

	if   (srl_shift) cfg_logic_dat_out <=  srl_logic_q [0];
	else             cfg_logic_dat_out <=  cfg_logic_dat_out;

	cfg_logic_csb_out <=  cfg_logic_csb_out & ~cfg_logic_csb_low
                      | ~cfg_logic_csb_out &  cfg_logic_csb_high;
	cfg_logic_en_out  <=  cfg_logic_en_out  & ~cfg_logic_en_low
                      | ~cfg_logic_en_out  &  cfg_logic_en_high;
	cfg_logic_clk_out <=  cfg_logic_clk_out & ~cfg_clk_low
                      | ~cfg_logic_clk_out &  cfg_clk_high;
end

endmodule
