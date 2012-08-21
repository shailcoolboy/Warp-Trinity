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
reg		[0:6] radio_B; //Register radio_B to avoid timing problems

/*******************************************/
/* Radio Controller <-> Radio Bridge Ports */
/*******************************************/
input	controller_spi_clk;
input	controller_spi_data;
input	controller_radio_cs;
input	controller_dac_cs;

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

/**********************************/
/* Clocks and analog data signals */
/**********************************/
assign converter_clock_out = converter_clock_in;

assign radio_RSSI_ADC_clk = user_RSSI_ADC_clk;

assign user_ADC_I = radio_ADC_I;
assign user_ADC_Q = radio_ADC_Q;

assign radio_DAC_I = user_DAC_I;
assign radio_DAC_Q = user_DAC_Q;

//Make the gain mux default to the Tx settings, unless Rx is active
//The Tx gain needs to be zero when TxEn is raised
//The radio controller outputs zero for TxGain by default
wire	[0:6] radio_B_preReg;
assign radio_B_preReg = controller_RxEn ? {user_RxRF_gain, user_RxBB_gain} : {1'b0, user_Tx_gain};

//Use an XST attribute to force the registers for the radio_B bus into the IOBs
// synthesis attribute iob of radio_B is true;
always @( posedge converter_clock_in )
begin
	radio_B <= radio_B_preReg;
end

//Pass the Tx start signal through to the user port
assign	user_TxModelStart = controller_TxStart;

/********************************************/
/* Instantiate the IOBUF for EEPROM Devices */
/********************************************/

IOBUF xIOBUF(
	.T(user_EEPROM_IO_T),
	.I(user_EEPROM_IO_O),
	.O(user_EEPROM_IO_I),
	.IO(radio_EEPROM_IO)
);

/*******************************************/
/* Radio Controller -> Radio Board Drivers */
/*******************************************/
assign	dac_spi_clk = controller_spi_clk;
assign	dac_spi_data = controller_spi_data;
assign	dac_spi_cs = controller_dac_cs;

assign	radio_spi_clk = controller_spi_clk;
assign	radio_spi_data = controller_spi_data;
assign	radio_spi_cs = controller_radio_cs;

assign radio_SHDN = controller_SHDN;
assign radio_TxEn = controller_TxEn;
assign radio_RxEn = controller_RxEn;
assign radio_RxHP = controller_RxHP;
assign radio_24PA = controller_24PA;
assign radio_5PA = controller_5PA;
assign radio_ANTSW = controller_ANTSW;
assign radio_LED = controller_LED;
assign radio_RX_ADC_DCS = controller_RX_ADC_DCS;
assign radio_RX_ADC_DFS = controller_RX_ADC_DFS;
assign radio_RX_ADC_PWDNA = controller_RX_ADC_PWDNA;
assign radio_RX_ADC_PWDNB = controller_RX_ADC_PWDNB;
assign radio_RSSI_ADC_CLAMP = controller_RSSI_ADC_CLAMP;
assign radio_RSSI_ADC_HIZ = controller_RSSI_ADC_HIZ;
assign radio_RSSI_ADC_SLEEP = controller_RSSI_ADC_SLEEP;

/*******************************************/
/* Radio Board -> Radio Controller Drivers */
/*******************************************/

assign controller_DIPSW = radio_DIPSW;
assign controller_RSSI_ADC_D = radio_RSSI_ADC_D;
assign user_RSSI_ADC_D = radio_RSSI_ADC_D;
assign controller_LD = radio_LD;
assign controller_RX_ADC_OTRA = radio_RX_ADC_OTRA;
assign controller_RX_ADC_OTRB = radio_RX_ADC_OTRB;
assign controller_RSSI_ADC_OTR = radio_RSSI_ADC_OTR;
assign controller_DAC_PLL_LOCK = radio_DAC_PLL_LOCK;
assign radio_DAC_RESET = controller_DAC_RESET;

endmodule