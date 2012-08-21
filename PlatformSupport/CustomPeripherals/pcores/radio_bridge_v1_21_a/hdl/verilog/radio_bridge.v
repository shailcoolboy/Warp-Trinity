//////////////////////////////////////////////////////////
// Copyright (c) 2006 Rice University 			//
// All Rights Reserved 					//
// This code is covered by the Rice-WARP license 	//
// See http://warp.rice.edu/license/ for details 	//
//////////////////////////////////////////////////////////

module radio_bridge
(
	converter_clock_in,
	converter_clock_out,
	
	user_RSSI_ADC_clk,
	radio_RSSI_ADC_clk,

	user_RSSI_ADC_D,

	user_EEPROM_IO_T,
	user_EEPROM_IO_O,
	user_EEPROM_IO_I,
	
	user_TxModelStart,

	radio_EEPROM_IO,
	
	radio_DAC_I,
	radio_DAC_Q,
	
	radio_ADC_I,
	radio_ADC_Q,

	user_DAC_I,
	user_DAC_Q,
	
	user_ADC_I,
	user_ADC_Q,
	
	radio_B,
	user_Tx_gain,
	user_RxBB_gain,
	user_RxRF_gain,

	user_SHDN_external,
	user_RxEn_external,
	user_TxEn_external,
	user_RxHP_external,

	controller_logic_clk,
	controller_spi_clk,
	controller_spi_data,
	controller_radio_cs,
	controller_dac_cs,
	controller_SHDN,
	controller_TxEn,
	controller_RxEn,
	controller_RxHP,
	controller_24PA,
	controller_5PA,
	controller_ANTSW,
	controller_LED,
	controller_RX_ADC_DCS,
	controller_RX_ADC_DFS,
	controller_RX_ADC_PWDNA,
	controller_RX_ADC_PWDNB,
	controller_DIPSW,
	controller_RSSI_ADC_CLAMP,
	controller_RSSI_ADC_HIZ,
	controller_RSSI_ADC_SLEEP,
	controller_RSSI_ADC_D,
	controller_TxStart,

	controller_LD,
	controller_RX_ADC_OTRA,
	controller_RX_ADC_OTRB,
	controller_RSSI_ADC_OTR,
	controller_DAC_PLL_LOCK,
	controller_DAC_RESET,

	controller_SHDN_external,
	controller_RxEn_external,
	controller_TxEn_external,
	controller_RxHP_external,

	controller_interpfiltbypass,
	controller_decfiltbypass,

	dac_spi_data,
	dac_spi_cs,
	dac_spi_clk,

	radio_spi_clk,
	radio_spi_data,
	radio_spi_cs,

	radio_SHDN,
	radio_TxEn,
	radio_RxEn,
	radio_RxHP,
	radio_24PA,
	radio_5PA,
	radio_ANTSW,
	radio_LED,
	radio_RX_ADC_DCS,
	radio_RX_ADC_DFS,
	radio_RX_ADC_PWDNA,
	radio_RX_ADC_PWDNB,
	radio_DIPSW,
	radio_RSSI_ADC_CLAMP,
	radio_RSSI_ADC_HIZ,
	radio_RSSI_ADC_SLEEP,
	radio_RSSI_ADC_D,

	radio_LD,
	radio_RX_ADC_OTRA,
	radio_RX_ADC_OTRB,
	radio_RSSI_ADC_OTR,
	radio_DAC_PLL_LOCK,
	radio_DAC_RESET
);

//Parameter to choose which set of rate change filters to use
// Default is 4 (40MHz converter clock, 10MHz actual bandwidth)
// Value of 1 bypasses filters altogether; this is the original radio_bridge mode
// May add support for rate change = 2 in the future (requires new filter core)
// 16-bit datatype to play nice with BSB parameterization
parameter rate_change = 16'h0004;

parameter C_FAMILY = "virtex2p";

/**********************/
/* Clock & Data Ports */
/**********************/
input	converter_clock_in;
output	converter_clock_out;

input	user_RSSI_ADC_clk;
output	radio_RSSI_ADC_clk;
output	[0:9] user_RSSI_ADC_D;

input	user_EEPROM_IO_T;
input	user_EEPROM_IO_O;
output	user_EEPROM_IO_I;

output	user_TxModelStart;

output	[0:15] radio_DAC_I;
output	[0:15] radio_DAC_Q;

input	[0:13] radio_ADC_I;
input	[0:13] radio_ADC_Q;

input	[0:15] user_DAC_I;
input	[0:15] user_DAC_Q;

output	[0:13] user_ADC_I;
output	[0:13] user_ADC_Q;

input	[0:1] user_RxRF_gain;
input	[0:4] user_RxBB_gain;

input	[0:5] user_Tx_gain;

/* radio_B is a 7-bit bus */
/* In Rx mode, radio_B[0:1] = RF gain, radio_B[2:6] = baseband gain */
/* In Tx mode, radio_B[1:6] = gain, radio_B[0] is unused */
output	[0:6] radio_B;

input	user_SHDN_external;
input	user_RxEn_external;
input	user_TxEn_external;
input	user_RxHP_external;

/*******************************************/
/* Radio Controller <-> Radio Bridge Ports */
/*******************************************/
input	controller_logic_clk;
input	controller_spi_clk;
input	controller_spi_data;
input	controller_radio_cs;
input	controller_dac_cs;

input	controller_interpfiltbypass;
input	controller_decfiltbypass;

input	controller_SHDN;
input	controller_TxEn;
input	controller_RxEn;
input	controller_RxHP;
input	controller_24PA;
input	controller_5PA;
input	[0:1] controller_ANTSW;
input	[0:2] controller_LED;
input	controller_RX_ADC_DCS;
input	controller_RX_ADC_DFS;
input	controller_RX_ADC_PWDNA;
input	controller_RX_ADC_PWDNB;
input	controller_RSSI_ADC_CLAMP;
input	controller_RSSI_ADC_HIZ;
input	controller_RSSI_ADC_SLEEP;
input	controller_DAC_RESET;
input	controller_TxStart;

output	[0:3] controller_DIPSW;
output	[0:9] controller_RSSI_ADC_D;
output	controller_LD;
output	controller_RX_ADC_OTRA;
output	controller_RX_ADC_OTRB;
output	controller_RSSI_ADC_OTR;
output	controller_DAC_PLL_LOCK;

output	controller_SHDN_external;
output	controller_RxEn_external;
output	controller_TxEn_external;
output	controller_RxHP_external;

/**************************************/
/* Radio Bridge <-> Radio Board Ports */
/**************************************/
output	dac_spi_data;
output	dac_spi_cs;
output	dac_spi_clk;

output	radio_spi_clk;
output	radio_spi_data;
output	radio_spi_cs;

output	radio_SHDN;
output	radio_TxEn;
output	radio_RxEn;
output	radio_RxHP;
output	radio_24PA;
output	radio_5PA;
output	[0:1] radio_ANTSW;
output	[0:2] radio_LED;
output	radio_RX_ADC_DCS;
output	radio_RX_ADC_DFS;
output	radio_RX_ADC_PWDNA;
output	radio_RX_ADC_PWDNB;
output	radio_RSSI_ADC_CLAMP;
output	radio_RSSI_ADC_HIZ;
output	radio_RSSI_ADC_SLEEP;
output	radio_DAC_RESET;

input	[0:9] radio_RSSI_ADC_D;
input	radio_LD;
input	radio_RX_ADC_OTRA;
input	radio_RX_ADC_OTRB;
input	radio_RSSI_ADC_OTR;
input	radio_DAC_PLL_LOCK;
input	[0:3] radio_DIPSW;

inout	radio_EEPROM_IO;

//All the outputs will be registered using IOB registers
reg	radio_RSSI_ADC_clk;
reg	[0:9] user_RSSI_ADC_D;
reg	[0:15] radio_DAC_I;
reg	[0:15] radio_DAC_Q;

reg	[0:13] user_ADC_I;
reg	[0:13] user_ADC_Q;

reg [0:13] radio_ADC_I_nReg;
reg [0:13] radio_ADC_Q_nReg;

reg	[0:6] radio_B;
reg	[0:3] controller_DIPSW;
reg	[0:9] controller_RSSI_ADC_D;
reg	controller_LD;
reg	controller_RX_ADC_OTRA;
reg	controller_RX_ADC_OTRB;
reg	controller_RSSI_ADC_OTR;
reg	controller_DAC_PLL_LOCK;
reg	dac_spi_data;
reg	dac_spi_cs;
reg	dac_spi_clk;
reg	radio_spi_clk;
reg	radio_spi_data;
reg	radio_spi_cs;
reg	radio_SHDN;
reg	radio_TxEn;
reg	radio_RxEn;
reg	radio_RxHP;
reg	radio_24PA;
reg	radio_5PA;
reg	[0:1] radio_ANTSW;
reg	[0:2] radio_LED;
reg	radio_RX_ADC_DCS;
reg	radio_RX_ADC_DFS;
reg	radio_RX_ADC_PWDNA;
reg	radio_RX_ADC_PWDNB;
reg	radio_RSSI_ADC_CLAMP;
reg	radio_RSSI_ADC_HIZ;
reg	radio_RSSI_ADC_SLEEP;
reg	radio_DAC_RESET;

//Drive the clock out to the ADC/DACs
//synthesis attribute IOB of converter_clock_out IS true;
OFDDRRSE OFDDRRSE_inst (
	.Q(converter_clock_out),      // Data output (connect directly to top-level port)
	.C0(converter_clock_in),    // 0 degree clock input
	.C1(~converter_clock_in),    // 180 degree clock input
	.CE(1'b1),    // Clock enable input
	.D0(1'b1),    // Posedge data input
	.D1(1'b0),    // Negedge data input
	.R(1'b0),      // Synchronous reset input
	.S(1'b0)       // Synchronous preset input
);

//Pass the Tx start signal through to the user port
// This is an internal signal, so it won't be registered here
assign	user_TxModelStart = controller_TxStart;

// Pass user_external signals to the controller
assign controller_SHDN_external = user_SHDN_external;
assign controller_RxEn_external = user_RxEn_external;
assign controller_TxEn_external = user_TxEn_external;
assign controller_RxHP_external = user_RxHP_external;


//Make the gain mux default to the Tx settings, unless Rx is active
//The Tx gain needs to be zero when TxEn is raised
//The radio controller outputs zero for TxGain by default
wire	[0:6] radio_B_preReg;
assign radio_B_preReg = radio_RxEn ? {user_RxRF_gain, user_RxBB_gain} : {1'b0, user_Tx_gain};

wire [15:0] user_DAC_I_interpolated;
wire [15:0] user_DAC_Q_interpolated;
wire [13:0] radio_ADC_I_nReg_decimated;
wire [13:0] radio_ADC_Q_nReg_decimated;

/********************************************/
/* Instantiate the rate change filters      */
/********************************************/
generate
	if(rate_change == 1) //No filters
		begin
			assign radio_ADC_I_nReg_decimated = radio_ADC_I_nReg;
			assign radio_ADC_Q_nReg_decimated = radio_ADC_Q_nReg;
			assign user_DAC_I_interpolated = user_DAC_I;
			assign user_DAC_Q_interpolated = user_DAC_Q;
		end
	else
		begin
			radio_bridge_ratechangefilter_4x_2ch_cw bridgeFilter (
				.clk(converter_clock_in),
				.ce(1'b1),

				//Interpolate when transmitting; decimate otherwise
				// We use the negation of RxEn instead of TxEn on purpose
				// The timing of TxEn is controlled by the user's code
				//  and could be delayed, asserting too close to the first I/Q
				//  samples; RxEn is disabled long before TxEn is enabled
				.interp_en(~controller_RxEn),

				.decfiltbypass(controller_decfiltbypass),
				.interpfiltbypass(controller_interpfiltbypass),
				
				//Quarter-rate I/Q signals output to user's transceiver
				.rx_i(radio_ADC_I_nReg_decimated),
				.rx_q(radio_ADC_Q_nReg_decimated),

				//Full-rate I/Q signals from radio ADC
				.rx_i_fullrate(radio_ADC_I_nReg),
				.rx_q_fullrate(radio_ADC_Q_nReg),

				//Quarter-rate I/Q signals provided by user's transceiver
				.tx_i(user_DAC_I),
				.tx_q(user_DAC_Q),

				//Full-rate I/Q signals output to radio DAC
				.tx_i_fullrate(user_DAC_I_interpolated),
				.tx_q_fullrate(user_DAC_Q_interpolated)
			);
		end
endgenerate

/********************************************/
/* Instantiate the IOBUF for EEPROM Devices */
/********************************************/
IOBUF xIOBUF(
	.T(user_EEPROM_IO_T),
	.I(user_EEPROM_IO_O),
	.O(user_EEPROM_IO_I),
	.IO(radio_EEPROM_IO)
);

//Capture the incoming ADC signals on the negative
// edge of the converter clock
//synthesis attribute IOB of radio_ADC_I_nReg IS true;
//synthesis attribute IOB of radio_ADC_Q_nReg IS true;
always @( negedge converter_clock_in )
begin
	radio_ADC_I_nReg <= radio_ADC_I;
	radio_ADC_Q_nReg <= radio_ADC_Q;
end

always @( posedge converter_clock_in )
begin
	/*******************************************/
	/* PHY Cores <-> Radio Board */
	/*******************************************/
	radio_B <= radio_B_preReg;

	radio_RSSI_ADC_clk <= user_RSSI_ADC_clk;

	user_ADC_I <= radio_ADC_I_nReg_decimated;
	user_ADC_Q <= radio_ADC_Q_nReg_decimated;

	radio_DAC_I <= user_DAC_I_interpolated;
	radio_DAC_Q <= user_DAC_Q_interpolated;
end


//Use the clock provied by the radio_controller to register its I/O
// This will be a copy of the PLB clock for the controller's bus
// It may be different than the converter clock (probably faster, but usually still synchronous)
always @( posedge controller_logic_clk )
begin
	/*******************************************/
	/* Radio Controller -> Radio Board Drivers */
	/*******************************************/
	dac_spi_clk <= controller_spi_clk;
	dac_spi_data <= controller_spi_data;
	dac_spi_cs <= controller_dac_cs;
	radio_spi_clk <= controller_spi_clk;
	radio_spi_data <= controller_spi_data;
	radio_spi_cs <= controller_radio_cs;
	radio_SHDN <= controller_SHDN;
	radio_TxEn <= controller_TxEn;
	radio_RxEn <= controller_RxEn;
	radio_RxHP <= controller_RxHP;
	radio_24PA <= controller_24PA;
	radio_5PA <= controller_5PA;
	radio_ANTSW <= controller_ANTSW;
	radio_LED <= controller_LED;
	radio_RX_ADC_DCS <= controller_RX_ADC_DCS;
	radio_RX_ADC_DFS <= controller_RX_ADC_DFS;
	radio_RX_ADC_PWDNA <= controller_RX_ADC_PWDNA;
	radio_RX_ADC_PWDNB <= controller_RX_ADC_PWDNB;
	radio_RSSI_ADC_CLAMP <= controller_RSSI_ADC_CLAMP;
	radio_RSSI_ADC_HIZ <= controller_RSSI_ADC_HIZ;
	radio_RSSI_ADC_SLEEP <= controller_RSSI_ADC_SLEEP;

	/*******************************************/
	/* Radio Board -> Radio Controller Drivers */
	/*******************************************/
	controller_DIPSW <= radio_DIPSW;
	controller_LD <= radio_LD;
	controller_RX_ADC_OTRA <= radio_RX_ADC_OTRA;
	controller_RX_ADC_OTRB <= radio_RX_ADC_OTRB;
	controller_RSSI_ADC_OTR <= radio_RSSI_ADC_OTR;
	controller_DAC_PLL_LOCK <= radio_DAC_PLL_LOCK;
	radio_DAC_RESET <= controller_DAC_RESET;
end

//Delay the user's RSSI clk input by 1 cycle
reg user_RSSI_ADC_clk_d1;
always @( posedge controller_logic_clk )
begin
	user_RSSI_ADC_clk_d1 <= user_RSSI_ADC_clk;
end

//Only update the RSSI input regisers on the rising edge
// of the user-supplied RSSI clk; we'll assume the RSSI clk is
// synchronous with the bus clock for the radio controller's PLB
always @( posedge controller_logic_clk )
begin
	if(user_RSSI_ADC_clk & ~user_RSSI_ADC_clk_d1)
	begin
		controller_RSSI_ADC_D <= radio_RSSI_ADC_D;
		user_RSSI_ADC_D <= radio_RSSI_ADC_D;
	end
end

//Use XST attributes to force the registers for these signals into the IOBs
//synthesis attribute IOB of radio_RSSI_ADC_clk IS true;
//synthesis attribute IOB of user_RSSI_ADC_D IS true;
//synthesis attribute IOB of radio_DAC_I IS true;
//synthesis attribute IOB of radio_DAC_Q IS true;
//synthesis attribute IOB of radio_B IS true;
//synthesis attribute IOB of controller_DIPSW IS true;
//synthesis attribute IOB of controller_RSSI_ADC_D IS true;
//synthesis attribute IOB of controller_LD IS true;
//synthesis attribute IOB of controller_RX_ADC_OTRA IS true;
//synthesis attribute IOB of controller_RX_ADC_OTRB IS true;
//synthesis attribute IOB of controller_RSSI_ADC_OTR IS true;
//synthesis attribute IOB of controller_DAC_PLL_LOCK IS true;
//synthesis attribute IOB of dac_spi_data IS true;
//synthesis attribute IOB of dac_spi_cs IS true;
//synthesis attribute IOB of dac_spi_clk IS true;
//synthesis attribute IOB of radio_spi_clk IS true;
//synthesis attribute IOB of radio_spi_data IS true;
//synthesis attribute IOB of radio_spi_cs IS true;
//synthesis attribute IOB of radio_SHDN IS true;
//synthesis attribute IOB of radio_TxEn IS true;
//synthesis attribute IOB of radio_RxEn IS true;
//synthesis attribute IOB of radio_RxHP IS true;
//synthesis attribute IOB of radio_24PA IS true;
//synthesis attribute IOB of radio_5PA IS true;
//synthesis attribute IOB of radio_ANTSW IS true;
//synthesis attribute IOB of radio_LED IS true;
//synthesis attribute IOB of radio_RX_ADC_DCS IS true;
//synthesis attribute IOB of radio_RX_ADC_DFS IS true;
//synthesis attribute IOB of radio_RX_ADC_PWDNA IS true;
//synthesis attribute IOB of radio_RX_ADC_PWDNB IS true;
//synthesis attribute IOB of radio_RSSI_ADC_CLAMP IS true;
//synthesis attribute IOB of radio_RSSI_ADC_HIZ IS true;
//synthesis attribute IOB of radio_RSSI_ADC_SLEEP IS true;
//synthesis attribute IOB of radio_DAC_RESET IS true;

endmodule

//Empty module declaration for filter NGC netlist
// See mdlsrc folder for source System Generator model
module radio_bridge_ratechangefilter_4x_2ch_cw (
  clk,
  ce,
  decfiltbypass,
  interpfiltbypass,
  interp_en,
  rx_i,
  rx_i_fullrate,
  rx_q,
  rx_q_fullrate,
  tx_i,
  tx_i_fullrate,
  tx_q,
  tx_q_fullrate
);
	input	clk;
	input	ce;
	input	decfiltbypass;
	input	interpfiltbypass;
	input	interp_en;
	input	[13:0] rx_i_fullrate;
	input	[13:0] rx_q_fullrate;
	input	[15:0] tx_i;
	input	[15:0] tx_q;
	output	[13:0] rx_i;
	output	[13:0] rx_q;
	output	[15:0] tx_i_fullrate;
	output	[15:0] tx_q_fullrate;
endmodule
