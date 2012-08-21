/* Copyright (c) 2006 Rice University */
/* All Rights Reserved */
/* This code is covered by the Rice-WARP license */
/* See http://warp.rice.edu/license/ for details */

module user_logic
(
	spi_clk,
	data_out,
	Radio1_cs,
	Radio2_cs,
	Radio3_cs,
	Radio4_cs,
	Dac1_cs,
	Dac2_cs,
	Dac3_cs,
	Dac4_cs,
	Radio1_SHDN,
	Radio1_TxEn,
	Radio1_RxEn,
	Radio1_RxHP,
	Radio1_LD,
	Radio1_24PA,
	Radio1_5PA,
	Radio1_ANTSW,
	Radio1_LED,
	Radio1_ADC_RX_DCS,
	Radio1_ADC_RX_DFS,
	Radio1_ADC_RX_OTRA,
	Radio1_ADC_RX_OTRB,
	Radio1_ADC_RX_PWDNA,
	Radio1_ADC_RX_PWDNB,
	Radio1_DIPSW,
	Radio1_RSSI_ADC_CLAMP,
	Radio1_RSSI_ADC_HIZ,
	Radio1_RSSI_ADC_OTR,
	Radio1_RSSI_ADC_SLEEP,
	Radio1_RSSI_ADC_D,
	Radio1_TX_DAC_PLL_LOCK,
	Radio1_TX_DAC_RESET,
	Radio1_SHDN_external,
	Radio1_TxEn_external,
	Radio1_RxEn_external,
	Radio1_RxHP_external,
	Radio1_TxGain,  
	Radio1_TxStart,
	Radio2_SHDN,
	Radio2_TxEn,
	Radio2_RxEn,
	Radio2_RxHP,
	Radio2_LD,
	Radio2_24PA,
	Radio2_5PA,
	Radio2_ANTSW,
	Radio2_LED,
	Radio2_ADC_RX_DCS,
	Radio2_ADC_RX_DFS,
	Radio2_ADC_RX_OTRA,
	Radio2_ADC_RX_OTRB,
	Radio2_ADC_RX_PWDNA,
	Radio2_ADC_RX_PWDNB,
	Radio2_DIPSW,
	Radio2_RSSI_ADC_CLAMP,
	Radio2_RSSI_ADC_HIZ,
	Radio2_RSSI_ADC_OTR,
	Radio2_RSSI_ADC_SLEEP,
	Radio2_RSSI_ADC_D,
	Radio2_TX_DAC_PLL_LOCK,
	Radio2_TX_DAC_RESET,
	Radio2_SHDN_external,
	Radio2_TxEn_external,
	Radio2_RxEn_external,
	Radio2_RxHP_external,
	Radio2_TxGain,  
	Radio2_TxStart,
	Radio3_SHDN,
	Radio3_TxEn,
	Radio3_RxEn,
	Radio3_RxHP,
	Radio3_LD,
	Radio3_24PA,
	Radio3_5PA,
	Radio3_ANTSW,
	Radio3_LED,
	Radio3_ADC_RX_DCS,
	Radio3_ADC_RX_DFS,
	Radio3_ADC_RX_OTRA,
	Radio3_ADC_RX_OTRB,
	Radio3_ADC_RX_PWDNA,
	Radio3_ADC_RX_PWDNB,
	Radio3_DIPSW,
	Radio3_RSSI_ADC_CLAMP,
	Radio3_RSSI_ADC_HIZ,
	Radio3_RSSI_ADC_OTR,
	Radio3_RSSI_ADC_SLEEP,
	Radio3_RSSI_ADC_D,
	Radio3_TX_DAC_PLL_LOCK,
	Radio3_TX_DAC_RESET,
	Radio3_SHDN_external,
	Radio3_TxEn_external,
	Radio3_RxEn_external,
	Radio3_RxHP_external,
	Radio3_TxGain,
	Radio3_TxStart,
	Radio4_SHDN,
	Radio4_TxEn,
	Radio4_RxEn,
	Radio4_RxHP,
	Radio4_LD,
	Radio4_24PA,
	Radio4_5PA,
	Radio4_ANTSW,
	Radio4_LED,
	Radio4_ADC_RX_DCS,
	Radio4_ADC_RX_DFS,
	Radio4_ADC_RX_OTRA,
	Radio4_ADC_RX_OTRB,
	Radio4_ADC_RX_PWDNA,
	Radio4_ADC_RX_PWDNB,
	Radio4_DIPSW,
	Radio4_RSSI_ADC_CLAMP,
	Radio4_RSSI_ADC_HIZ,
	Radio4_RSSI_ADC_OTR,
	Radio4_RSSI_ADC_SLEEP,
	Radio4_RSSI_ADC_D,
	Radio4_TX_DAC_PLL_LOCK,
	Radio4_TX_DAC_RESET,
	Radio4_SHDN_external,
	Radio4_TxEn_external,
	Radio4_RxEn_external,
	Radio4_RxHP_external,
	Radio4_TxGain,  
	Radio4_TxStart,

	// -- Bus protocol ports, do not add to or delete 
	Bus2IP_Clk,                     // Bus to IP clock
	Bus2IP_Reset,                   // Bus to IP reset
	Bus2IP_Data,                    // Bus to IP data bus for user logic
	Bus2IP_BE,                      // Bus to IP byte enables for user logic
	Bus2IP_RdCE,                    // Bus to IP read chip enable for user logic
	Bus2IP_WrCE,                    // Bus to IP write chip enable for user logic
	IP2Bus_Data,                    // IP to Bus data bus for user logic
	IP2Bus_Ack,                     // IP to Bus acknowledgement
	IP2Bus_Retry,                   // IP to Bus retry response
	IP2Bus_Error,                   // IP to Bus error response
	IP2Bus_ToutSup                  // IP to Bus timeout suppress
); // user_logic


	// -- Bus protocol parameters, do not add to or delete
	parameter C_DWIDTH                       = 32;
	parameter C_NUM_CE                       = 17;

	output				spi_clk;
	output				data_out;
	output				Radio1_cs;
	output				Radio2_cs;
	output				Radio3_cs;
	output				Radio4_cs;
	output				Dac1_cs;
	output				Dac2_cs;
	output				Dac3_cs;
	output				Dac4_cs;
	
	output				Radio1_SHDN;
	output				Radio1_TxEn;
	output				Radio1_RxEn;
	output				Radio1_RxHP;
	input				Radio1_LD;
	output				Radio1_24PA;
	output				Radio1_5PA;
	output		[0 : 1]		Radio1_ANTSW;
	output		[0 : 2]		Radio1_LED;
	output				Radio1_ADC_RX_DCS;
	output				Radio1_ADC_RX_DFS;
	input				Radio1_ADC_RX_OTRA;
	input				Radio1_ADC_RX_OTRB;
	output				Radio1_ADC_RX_PWDNA;
	output				Radio1_ADC_RX_PWDNB;
	input		[0 : 3]		Radio1_DIPSW;
	output				Radio1_RSSI_ADC_CLAMP;
	output				Radio1_RSSI_ADC_HIZ;
	input				Radio1_RSSI_ADC_OTR;
	output				Radio1_RSSI_ADC_SLEEP;
	input		[0 : 9]		Radio1_RSSI_ADC_D;
	input				Radio1_TX_DAC_PLL_LOCK;
	output				Radio1_TX_DAC_RESET;
	input				Radio1_SHDN_external;
	input				Radio1_TxEn_external;
	input				Radio1_RxEn_external;
	input				Radio1_RxHP_external;
	output		[0 : 5]		Radio1_TxGain;
	output				Radio1_TxStart;
	output				Radio2_SHDN;
	output				Radio2_TxEn;
	output				Radio2_RxEn;
	output				Radio2_RxHP;
	input				Radio2_LD;
	output				Radio2_24PA;
	output				Radio2_5PA;
	output		[0 : 1]		Radio2_ANTSW;
	output		[0 : 2]		Radio2_LED;
	output				Radio2_ADC_RX_DCS;
	output				Radio2_ADC_RX_DFS;
	input				Radio2_ADC_RX_OTRA;
	input				Radio2_ADC_RX_OTRB;
	output				Radio2_ADC_RX_PWDNA;
	output				Radio2_ADC_RX_PWDNB;
	input		[0 : 3]		Radio2_DIPSW;
	output				Radio2_RSSI_ADC_CLAMP;
	output				Radio2_RSSI_ADC_HIZ;
	input				Radio2_RSSI_ADC_OTR;
	output				Radio2_RSSI_ADC_SLEEP;
	input		[0 : 9]		Radio2_RSSI_ADC_D;
	input				Radio2_TX_DAC_PLL_LOCK;
	output				Radio2_TX_DAC_RESET;
	input				Radio2_SHDN_external;
	input				Radio2_TxEn_external;
	input				Radio2_RxEn_external;
	input				Radio2_RxHP_external;
	output		[0 : 5]		Radio2_TxGain;
	output				Radio2_TxStart;
	output				Radio3_SHDN;
	output				Radio3_TxEn;
	output				Radio3_RxEn;
	output				Radio3_RxHP;
	input				Radio3_LD;
	output				Radio3_24PA;
	output				Radio3_5PA;
	output		[0 : 1]		Radio3_ANTSW;
	output		[0 : 2]		Radio3_LED;
	output				Radio3_ADC_RX_DCS;
	output				Radio3_ADC_RX_DFS;
	input				Radio3_ADC_RX_OTRA;
	input				Radio3_ADC_RX_OTRB;
	output				Radio3_ADC_RX_PWDNA;
	output				Radio3_ADC_RX_PWDNB;
	input		[0 : 3]		Radio3_DIPSW;
	output				Radio3_RSSI_ADC_CLAMP;
	output				Radio3_RSSI_ADC_HIZ;
	input				Radio3_RSSI_ADC_OTR;
	output				Radio3_RSSI_ADC_SLEEP;
	input		[0 : 9]		Radio3_RSSI_ADC_D;
	input				Radio3_TX_DAC_PLL_LOCK;
	output				Radio3_TX_DAC_RESET;
	input				Radio3_SHDN_external;
	input				Radio3_TxEn_external;
	input				Radio3_RxEn_external;
	input				Radio3_RxHP_external;
	output		[0 : 5]		Radio3_TxGain;
	output				Radio3_TxStart;
	output				Radio4_SHDN;
	output				Radio4_TxEn;
	output				Radio4_RxEn;
	output				Radio4_RxHP;
	input				Radio4_LD;
	output				Radio4_24PA;
	output				Radio4_5PA;
	output		[0 : 1]		Radio4_ANTSW;
	output		[0 : 2]		Radio4_LED;
	output				Radio4_ADC_RX_DCS;
	output				Radio4_ADC_RX_DFS;
	input				Radio4_ADC_RX_OTRA;
	input				Radio4_ADC_RX_OTRB;
	output				Radio4_ADC_RX_PWDNA;
	output				Radio4_ADC_RX_PWDNB;
	input		[0 : 3]		Radio4_DIPSW;
	output				Radio4_RSSI_ADC_CLAMP;
	output				Radio4_RSSI_ADC_HIZ;
	input				Radio4_RSSI_ADC_OTR;
	output				Radio4_RSSI_ADC_SLEEP;
	input		[0 : 9]		Radio4_RSSI_ADC_D;
	input				Radio4_TX_DAC_PLL_LOCK;
	output				Radio4_TX_DAC_RESET;
	input				Radio4_SHDN_external;
	input				Radio4_TxEn_external;
	input				Radio4_RxEn_external;
	input				Radio4_RxHP_external;
	output		[0 : 5]		Radio4_TxGain;
	output				Radio4_TxStart;


	// -- Bus protocol ports, do not add to or delete
	input                                     Bus2IP_Clk;
	input                                     Bus2IP_Reset;
	input      [0 : C_DWIDTH-1]               Bus2IP_Data;
	input      [0 : C_DWIDTH/8-1]             Bus2IP_BE;
	input      [0 : C_NUM_CE-1]               Bus2IP_RdCE;
	input      [0 : C_NUM_CE-1]               Bus2IP_WrCE;
	output     [0 : C_DWIDTH-1]               IP2Bus_Data;
	output                                    IP2Bus_Ack;
	output                                    IP2Bus_Retry;
	output                                    IP2Bus_Error;
	output                                    IP2Bus_ToutSup;

	// Nets for user logic slave model s/w accessible register example
	reg        [0 : C_DWIDTH-1]               slv_reg0;
	reg        [0 : C_DWIDTH-1]               slv_reg1;
	reg        [0 : C_DWIDTH-1]               slv_reg2;
	reg        [0 : C_DWIDTH-1]               slv_reg3;
	reg        [0 : C_DWIDTH-1]               slv_reg4;
	reg        [0 : C_DWIDTH-1]               slv_reg5;
	reg        [0 : C_DWIDTH-1]               slv_reg6;
	reg        [0 : C_DWIDTH-1]               slv_reg7;
	reg        [0 : C_DWIDTH-1]               slv_reg8;
	reg        [0 : C_DWIDTH-1]               slv_reg9;
	reg        [0 : C_DWIDTH-1]               slv_reg10;
	reg        [0 : C_DWIDTH-1]               slv_reg11;
	reg        [0 : C_DWIDTH-1]               slv_reg12;
	reg        [0 : C_DWIDTH-1]               slv_reg13;
	reg        [0 : C_DWIDTH-1]               slv_reg14;
	reg        [0 : C_DWIDTH-1]               slv_reg15;
	reg        [0 : C_DWIDTH-1]               slv_reg16;
	wire       [0 : 16]                       slv_reg_write_select;
	wire       [0 : 16]                       slv_reg_read_select;
	reg        [0 : C_DWIDTH-1]               slv_ip2bus_data;
	wire                                      slv_read_ack;
	wire                                      slv_write_ack;
	integer                                   byte_index, bit_index;

	// Nets for SPI interface connected to user_logic
	wire [7:0] ss_pad_o;
	wire mytip;
	wire [13:0] reg_ctrl;
	wire [7:0] reg_ss;
	wire reg_divider;
	wire [17:0] reg_tx;
	
	// Intermediate signals for transmit gain state machine
	wire Radio1_PowerAmpEnable, Radio1_swTxEn, Radio1_sw24PAEn, Radio1_sw5PAEn;
	wire Radio2_PowerAmpEnable, Radio2_swTxEn, Radio2_sw24PAEn, Radio2_sw5PAEn;
	wire Radio3_PowerAmpEnable, Radio3_swTxEn, Radio3_sw24PAEn, Radio3_sw5PAEn;
	wire Radio4_PowerAmpEnable, Radio4_swTxEn, Radio4_sw24PAEn, Radio4_sw5PAEn;

	// Internal signals for calculating Tx gains
	wire [0:5] Radio1_TargetTxGain, Radio2_TargetTxGain, Radio3_TargetTxGain, Radio4_TargetTxGain;
	wire [0:3] Radio1_TxGainStep, Radio2_TxGainStep, Radio3_TxGainStep, Radio4_TxGainStep;
	wire [0:3] Radio1_TxGainTimeStep, Radio2_TxGainTimeStep, Radio3_TxGainTimeStep, Radio4_TxGainTimeStep;

	// Internal signals setting delays used to control Tx timing
	wire [0:7] Radio1_GainRampThresh, Radio1_PAThresh, Radio1_TxEnThresh, Radio1_TxStartThresh;
	wire [0:7] Radio2_GainRampThresh, Radio2_PAThresh, Radio2_TxEnThresh, Radio2_TxStartThresh;
	wire [0:7] Radio3_GainRampThresh, Radio3_PAThresh, Radio3_TxEnThresh, Radio3_TxStartThresh;
	wire [0:7] Radio4_GainRampThresh, Radio4_PAThresh, Radio4_TxEnThresh, Radio4_TxStartThresh;


  	// SPI Interface signals
 	assign  Radio1_cs = ss_pad_o[0];
	assign  Radio2_cs = ss_pad_o[1];
	assign  Radio3_cs = ss_pad_o[2];
	assign  Radio4_cs = ss_pad_o[3];
	assign  Dac1_cs = ss_pad_o[4];
	assign  Dac2_cs = ss_pad_o[5];
	assign  Dac3_cs = ss_pad_o[6];
	assign  Dac4_cs = ss_pad_o[7];
	
	assign reg_ctrl = slv_reg5[18:31];
	assign reg_divider = slv_reg6[31];
	assign reg_ss = slv_reg7[24:31];
	assign reg_tx = slv_reg8[14:31];
 
 	// Instantiate the SPI controller top-level
	spi_top spi_top(
		.opb_clk_i(Bus2IP_Clk),
		.opb_rst_i(Bus2IP_Reset),
		.reg_ctrl(reg_ctrl),
		.reg_ss(reg_ss),
		.reg_divider(reg_divider),
		.reg_tx(reg_tx),
		.ctrlwrite(Bus2IP_WrCE[5]),
		.busval(Bus2IP_Data[23]), 
		.go(mytip),
		.ss_pad_o(ss_pad_o),
		.sclk_pad_o(spi_clk),
		.mosi_pad_o(data_out)
	);
	
	
	//// Signals and Tx state machine for Radio 1
	
	assign  Radio1_SHDN = (slv_reg0[27])?~Radio1_SHDN_external:~slv_reg0[31];
	assign	Radio1_swTxEn = (slv_reg0[19])?Radio1_TxEn_external:slv_reg0[23];
	assign  Radio1_RxEn = (slv_reg0[11])?Radio1_RxEn_external:slv_reg0[15];
	assign  Radio1_RxHP = (slv_reg0[3])?Radio1_RxHP_external:slv_reg0[7];

	assign	Radio1_sw24PAEn = slv_reg1[31];
	assign	Radio1_sw5PAEn = slv_reg1[27];

	assign	Radio1_24PA = ~(Radio1_sw24PAEn & Radio1_PowerAmpEnable); //active low output
	assign  Radio1_5PA = ~(Radio1_sw5PAEn & Radio1_PowerAmpEnable); //active low output

	assign  Radio1_ANTSW[0] = (slv_reg0[19])? Radio1_TxEn_external : slv_reg1[15];  //slv_reg1[15];
	assign  Radio1_ANTSW[1] = (slv_reg0[11])? Radio1_RxEn_external : ~slv_reg1[15];  //~slv_reg1[15];
	assign  Radio1_ADC_RX_DCS = slv_reg1[7];
	assign  Radio1_LED[0] = Radio1_RxEn;
	assign  Radio1_LED[1] = Radio1_TxEn;
	assign  Radio1_LED[2] = ~Radio1_LD;
	assign  Radio1_ADC_RX_PWDNA = slv_reg2[23];
	assign  Radio1_ADC_RX_PWDNB = slv_reg2[19];
	assign  Radio1_RSSI_ADC_SLEEP = slv_reg2[15];
	assign  Radio1_TX_DAC_RESET = slv_reg1[11];
	 	
	assign  Radio1_ADC_RX_DFS = 1'b1; //slv_reg1[3];
	assign  Radio1_RSSI_ADC_CLAMP = 1'b0; //slv_reg2[3];
	assign  Radio1_RSSI_ADC_HIZ = 1'b0; //slv_reg2[7];  

	//Read the user register for programmed target Tx gain
	assign Radio1_TargetTxGain = slv_reg9[0:5];

	//Read the user regsiter for programmed Tx gain ramp increment
	assign Radio1_TxGainStep = slv_reg9[6:9];

	//Read the user register for programmed delay between gain steps
	assign Radio1_TxGainTimeStep = slv_reg9[10:13];

	//slv_reg9[14:31] available for future use
	
	//Read the user registers for the the delays before each Tx event
	assign Radio1_GainRampThresh = slv_reg13[0:7];
	assign Radio1_PAThresh = slv_reg13[8:15];
	assign Radio1_TxEnThresh = slv_reg13[16:23];
	assign Radio1_TxStartThresh = slv_reg13[24:31];

	radio_controller_TxTiming Radio1_TxTiming (
		.clk(Bus2IP_Clk),
		.reset(Bus2IP_Reset),

		.Tx_swEnable(Radio1_swTxEn),

		.TxGain_target(Radio1_TargetTxGain),
		.TxGain_rampGainStep(Radio1_TxGainStep),
		.TxGain_rampTimeStep(Radio1_TxGainTimeStep),

		.dly_hwTxEn(Radio1_TxEnThresh),
		.dly_TxStart(Radio1_TxStartThresh),
		.dly_PowerAmpEn(Radio1_PAThresh),
		.dly_RampGain(Radio1_GainRampThresh),

		.hw_TxEn(Radio1_TxEn),
		.hw_TxGain(Radio1_TxGain),
		.hw_PAEn(Radio1_PowerAmpEnable),
		.hw_TxStart(Radio1_TxStart)
	);


	//// Signals and Tx state machine for Radio 2
	
	assign  Radio2_SHDN = (slv_reg0[26])?~Radio2_SHDN_external:~slv_reg0[30];
	assign	Radio2_swTxEn = (slv_reg0[18])?Radio2_TxEn_external:slv_reg0[22];
	assign  Radio2_RxEn = (slv_reg0[10])?Radio2_RxEn_external:slv_reg0[14];
	assign  Radio2_RxHP = (slv_reg0[2])?Radio2_RxHP_external:slv_reg0[6];

	assign	Radio2_sw24PAEn = slv_reg1[30];
	assign	Radio2_sw5PAEn = slv_reg1[26];

	assign	Radio2_24PA = ~(Radio2_sw24PAEn & Radio2_PowerAmpEnable); //active low output
	assign  Radio2_5PA = ~(Radio2_sw5PAEn & Radio2_PowerAmpEnable); //active low output

	assign  Radio2_ANTSW[0] = (slv_reg0[18])? Radio2_TxEn_external : slv_reg1[14];  //slv_reg1[14];
	assign  Radio2_ANTSW[1] = (slv_reg0[10])? Radio2_RxEn_external : ~slv_reg1[14];  //~slv_reg1[14];
	assign  Radio2_ADC_RX_DCS = slv_reg1[6];
	assign  Radio2_LED[0] = Radio2_RxEn;
	assign  Radio2_LED[1] = Radio2_TxEn;
	assign  Radio2_LED[2] = ~Radio2_LD;
	assign  Radio2_ADC_RX_PWDNA = slv_reg2[22];
	assign  Radio2_ADC_RX_PWDNB = slv_reg2[18];
	assign  Radio2_RSSI_ADC_SLEEP = slv_reg2[14];
	assign  Radio2_TX_DAC_RESET = slv_reg1[10];
	 	
	assign  Radio2_ADC_RX_DFS = 1'b1; //slv_reg1[2];
	assign  Radio2_RSSI_ADC_CLAMP = 1'b0; //slv_reg2[2];
	assign  Radio2_RSSI_ADC_HIZ = 1'b0; //slv_reg2[6];  

	//Read the user register for programmed target Tx gain
	assign Radio2_TargetTxGain = slv_reg10[0:5];

	//Read the user regsiter for programmed Tx gain ramp increment
	assign Radio2_TxGainStep = slv_reg10[6:9];

	//Read the user register for programmed delay between gain steps
	assign Radio2_TxGainTimeStep = slv_reg10[10:13];

	//slv_reg10[14:31] available for future use
	
	//Read the user registers for the the delays before each Tx event
	assign Radio2_GainRampThresh = slv_reg14[0:7];
	assign Radio2_PAThresh = slv_reg14[8:15];
	assign Radio2_TxEnThresh = slv_reg14[16:23];
	assign Radio2_TxStartThresh = slv_reg14[24:31];

	radio_controller_TxTiming Radio2_TxTiming (
		.clk(Bus2IP_Clk),
		.reset(Bus2IP_Reset),

		.Tx_swEnable(Radio2_swTxEn),

		.TxGain_target(Radio2_TargetTxGain),
		.TxGain_rampGainStep(Radio2_TxGainStep),
		.TxGain_rampTimeStep(Radio2_TxGainTimeStep),

		.dly_hwTxEn(Radio2_TxEnThresh),
		.dly_TxStart(Radio2_TxStartThresh),
		.dly_PowerAmpEn(Radio2_PAThresh),
		.dly_RampGain(Radio2_GainRampThresh),

		.hw_TxEn(Radio2_TxEn),
		.hw_TxGain(Radio2_TxGain),
		.hw_PAEn(Radio2_PowerAmpEnable),
		.hw_TxStart(Radio2_TxStart)
	);


	//// Signals and Tx state machine for Radio 3
	
	assign  Radio3_SHDN = (slv_reg0[25])?~Radio3_SHDN_external:~slv_reg0[29];
	assign	Radio3_swTxEn = (slv_reg0[17])?Radio3_TxEn_external:slv_reg0[21];
	assign  Radio3_RxEn = (slv_reg0[9])?Radio3_RxEn_external:slv_reg0[13];
	assign  Radio3_RxHP = (slv_reg0[1])?Radio3_RxHP_external:slv_reg0[5];

	assign	Radio3_sw24PAEn = slv_reg1[29];
	assign	Radio3_sw5PAEn = slv_reg1[25];

	assign	Radio3_24PA = ~(Radio3_sw24PAEn & Radio3_PowerAmpEnable); //active low output
	assign  Radio3_5PA = ~(Radio3_sw5PAEn & Radio3_PowerAmpEnable); //active low output

	assign  Radio3_ANTSW[0] = (slv_reg0[17])? Radio3_TxEn_external : slv_reg1[13];  //slv_reg1[13];
	assign  Radio3_ANTSW[1] = (slv_reg0[9])? Radio3_RxEn_external : ~slv_reg1[13];  //~slv_reg1[13];
	assign  Radio3_ADC_RX_DCS = slv_reg1[5];
	assign  Radio3_LED[0] = Radio3_RxEn;
	assign  Radio3_LED[1] = Radio3_TxEn;
	assign  Radio3_LED[2] = ~Radio3_LD;
	assign  Radio3_ADC_RX_PWDNA = slv_reg2[21];
	assign  Radio3_ADC_RX_PWDNB = slv_reg2[17];
	assign  Radio3_RSSI_ADC_SLEEP = slv_reg2[13];
	assign  Radio3_TX_DAC_RESET = slv_reg1[9];
	 	
	assign  Radio3_ADC_RX_DFS = 1'b1; //slv_reg1[1];
	assign  Radio3_RSSI_ADC_CLAMP = 1'b0; //slv_reg2[1];
	assign  Radio3_RSSI_ADC_HIZ = 1'b0; //slv_reg2[5];  

	//Read the user register for programmed target Tx gain
	assign Radio3_TargetTxGain = slv_reg11[0:5];

	//Read the user regsiter for programmed Tx gain ramp increment
	assign Radio3_TxGainStep = slv_reg11[6:9];

	//Read the user register for programmed delay between gain steps
	assign Radio3_TxGainTimeStep = slv_reg11[10:13];

	//slv_reg11[14:31] available for future use
	
	//Read the user registers for the the delays before each Tx event
	assign Radio3_GainRampThresh = slv_reg15[0:7];
	assign Radio3_PAThresh = slv_reg15[8:15];
	assign Radio3_TxEnThresh = slv_reg15[16:23];
	assign Radio3_TxStartThresh = slv_reg15[24:31];

	radio_controller_TxTiming Radio3_TxTiming (
		.clk(Bus2IP_Clk),
		.reset(Bus2IP_Reset),

		.Tx_swEnable(Radio3_swTxEn),

		.TxGain_target(Radio3_TargetTxGain),
		.TxGain_rampGainStep(Radio3_TxGainStep),
		.TxGain_rampTimeStep(Radio3_TxGainTimeStep),

		.dly_hwTxEn(Radio3_TxEnThresh),
		.dly_TxStart(Radio3_TxStartThresh),
		.dly_PowerAmpEn(Radio3_PAThresh),
		.dly_RampGain(Radio3_GainRampThresh),

		.hw_TxEn(Radio3_TxEn),
		.hw_TxGain(Radio3_TxGain),
		.hw_PAEn(Radio3_PowerAmpEnable),
		.hw_TxStart(Radio3_TxStart)
	);


	//// Signals and Tx state machine for Radio 4
	
	assign  Radio4_SHDN = (slv_reg0[24])?~Radio4_SHDN_external:~slv_reg0[28];
	assign	Radio4_swTxEn = (slv_reg0[16])?Radio4_TxEn_external:slv_reg0[20];
	assign  Radio4_RxEn = (slv_reg0[8])?Radio4_RxEn_external:slv_reg0[12];
	assign  Radio4_RxHP = (slv_reg0[0])?Radio4_RxHP_external:slv_reg0[4];

	assign	Radio4_sw24PAEn = slv_reg1[28];
	assign	Radio4_sw5PAEn = slv_reg1[24];

	assign	Radio4_24PA = ~(Radio4_sw24PAEn & Radio4_PowerAmpEnable); //active low output
	assign  Radio4_5PA = ~(Radio4_sw5PAEn & Radio4_PowerAmpEnable); //active low output

	assign  Radio4_ANTSW[0] = (slv_reg0[16])? Radio4_TxEn_external : slv_reg1[12];  //slv_reg1[12];
	assign  Radio4_ANTSW[1] = (slv_reg0[8])? Radio4_RxEn_external : ~slv_reg1[12];  //~slv_reg1[12];
	assign  Radio4_ADC_RX_DCS = slv_reg1[4];
	assign  Radio4_LED[0] = Radio4_RxEn;
	assign  Radio4_LED[1] = Radio4_TxEn;
	assign  Radio4_LED[2] = ~Radio4_LD;
	assign  Radio4_ADC_RX_PWDNA = slv_reg2[20];
	assign  Radio4_ADC_RX_PWDNB = slv_reg2[16];
	assign  Radio4_RSSI_ADC_SLEEP = slv_reg2[12];
	assign  Radio4_TX_DAC_RESET = slv_reg1[8];
	 	
	assign  Radio4_ADC_RX_DFS = 1'b1; //slv_reg1[0];
	assign  Radio4_RSSI_ADC_CLAMP = 1'b0; //slv_reg2[0];
	assign  Radio4_RSSI_ADC_HIZ = 1'b0; //slv_reg2[4];  

	//Read the user register for programmed target Tx gain
	assign Radio4_TargetTxGain = slv_reg12[0:5];

	//Read the user regsiter for programmed Tx gain ramp increment
	assign Radio4_TxGainStep = slv_reg12[6:9];

	//Read the user register for programmed delay between gain steps
	assign Radio4_TxGainTimeStep = slv_reg12[10:13];

	//slv_reg12[14:31] available for future use
	
	//Read the user registers for the the delays before each Tx event
	assign Radio4_GainRampThresh = slv_reg16[0:7];
	assign Radio4_PAThresh = slv_reg16[8:15];
	assign Radio4_TxEnThresh = slv_reg16[16:23];
	assign Radio4_TxStartThresh = slv_reg16[24:31];

	radio_controller_TxTiming Radio4_TxTiming (
		.clk(Bus2IP_Clk),
		.reset(Bus2IP_Reset),

		.Tx_swEnable(Radio4_swTxEn),

		.TxGain_target(Radio4_TargetTxGain),
		.TxGain_rampGainStep(Radio4_TxGainStep),
		.TxGain_rampTimeStep(Radio4_TxGainTimeStep),

		.dly_hwTxEn(Radio4_TxEnThresh),
		.dly_TxStart(Radio4_TxStartThresh),
		.dly_PowerAmpEn(Radio4_PAThresh),
		.dly_RampGain(Radio4_GainRampThresh),

		.hw_TxEn(Radio4_TxEn),
		.hw_TxGain(Radio4_TxGain),
		.hw_PAEn(Radio4_PowerAmpEnable),
		.hw_TxStart(Radio4_TxStart)
	);

  
	assign
		slv_reg_write_select = Bus2IP_WrCE[0:16],
		slv_reg_read_select  = Bus2IP_RdCE[0:16],
		slv_write_ack        = Bus2IP_WrCE[0] || Bus2IP_WrCE[1] || Bus2IP_WrCE[2] || Bus2IP_WrCE[3] || Bus2IP_WrCE[4] || Bus2IP_WrCE[5] || Bus2IP_WrCE[6] || Bus2IP_WrCE[7] || Bus2IP_WrCE[8] || Bus2IP_WrCE[9] || Bus2IP_WrCE[10] || Bus2IP_WrCE[11] || Bus2IP_WrCE[12] || Bus2IP_WrCE[13] || Bus2IP_WrCE[14] || Bus2IP_WrCE[15] || Bus2IP_WrCE[16],
		slv_read_ack         = Bus2IP_RdCE[0] || Bus2IP_RdCE[1] || Bus2IP_RdCE[2] || Bus2IP_RdCE[3] || Bus2IP_RdCE[4] || Bus2IP_RdCE[5] || Bus2IP_RdCE[6] || Bus2IP_RdCE[7] || Bus2IP_RdCE[8] || Bus2IP_RdCE[9] || Bus2IP_RdCE[10] || Bus2IP_RdCE[11] || Bus2IP_RdCE[12] || Bus2IP_RdCE[13] || Bus2IP_RdCE[14] || Bus2IP_RdCE[15] || Bus2IP_RdCE[16];

	// implement slave model register(s)
	always @( posedge Bus2IP_Clk )
		begin: SLAVE_REG_WRITE_PROC

			if ( Bus2IP_Reset == 1 )
				begin
					slv_reg0 <= 0;
					slv_reg1 <= 0;
					slv_reg2 <= 0;
					slv_reg3 <= 0;
					slv_reg4 <= 0;
					slv_reg5 <= 0;
					slv_reg6 <= 0;
					slv_reg7 <= 0;
					slv_reg8 <= 0;
					slv_reg9 <= {14'h3fff, 22'h0}; //Gain increment, targets & delays all default to max values
					slv_reg10 <= {14'h3fff, 22'h0};
					slv_reg11 <= {14'h3fff, 22'h0};
					slv_reg12 <= {14'h3fff, 22'h0};
					slv_reg13 <= 0;
					slv_reg14 <= 0;
					slv_reg15 <= 0;
					slv_reg16 <= 0;
				end
			else
				case ( slv_reg_write_select )
				  17'b10000000000000000 :
				    for ( byte_index = 0; byte_index <= (C_DWIDTH/8)-1; byte_index = byte_index+1 )
				      if ( Bus2IP_BE[byte_index] == 1 )
					for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
					  slv_reg0[bit_index] <= Bus2IP_Data[bit_index];
				  17'b01000000000000000 :
				    for ( byte_index = 0; byte_index <= (C_DWIDTH/8)-1; byte_index = byte_index+1 )
				      if ( Bus2IP_BE[byte_index] == 1 )
					for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
					  slv_reg1[bit_index] <= Bus2IP_Data[bit_index];
				  17'b00100000000000000 :
				    for ( byte_index = 0; byte_index <= (C_DWIDTH/8)-1; byte_index = byte_index+1 )
				      if ( Bus2IP_BE[byte_index] == 1 )
					for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
					  slv_reg2[bit_index] <= Bus2IP_Data[bit_index];
				  17'b00010000000000000 :
				    for ( byte_index = 0; byte_index <= (C_DWIDTH/8)-1; byte_index = byte_index+1 )
				      if ( Bus2IP_BE[byte_index] == 1 )
					for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
					  slv_reg3[bit_index] <= Bus2IP_Data[bit_index];
				  17'b00001000000000000 :
				    for ( byte_index = 0; byte_index <= (C_DWIDTH/8)-1; byte_index = byte_index+1 )
				      if ( Bus2IP_BE[byte_index] == 1 )
					for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
					  slv_reg4[bit_index] <= Bus2IP_Data[bit_index];
				  17'b00000100000000000 :
				    for ( byte_index = 0; byte_index <= (C_DWIDTH/8)-1; byte_index = byte_index+1 )
				      if ( Bus2IP_BE[byte_index] == 1 )
					for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
					  slv_reg5[bit_index] <= Bus2IP_Data[bit_index];
				  17'b00000010000000000 :
				    for ( byte_index = 0; byte_index <= (C_DWIDTH/8)-1; byte_index = byte_index+1 )
				      if ( Bus2IP_BE[byte_index] == 1 )
					for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
					  slv_reg6[bit_index] <= Bus2IP_Data[bit_index];
				  17'b00000001000000000 :
				    for ( byte_index = 0; byte_index <= (C_DWIDTH/8)-1; byte_index = byte_index+1 )
				      if ( Bus2IP_BE[byte_index] == 1 )
					for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
					  slv_reg7[bit_index] <= Bus2IP_Data[bit_index];
				  17'b00000000100000000 :
				    for ( byte_index = 0; byte_index <= (C_DWIDTH/8)-1; byte_index = byte_index+1 )
				      if ( Bus2IP_BE[byte_index] == 1 )
					for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
					  slv_reg8[bit_index] <= Bus2IP_Data[bit_index];
				  17'b00000000010000000 :
				    for ( byte_index = 0; byte_index <= (C_DWIDTH/8)-1; byte_index = byte_index+1 )
				      if ( Bus2IP_BE[byte_index] == 1 )
					for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
					  slv_reg9[bit_index] <= Bus2IP_Data[bit_index];
				  17'b00000000001000000 :
				    for ( byte_index = 0; byte_index <= (C_DWIDTH/8)-1; byte_index = byte_index+1 )
				      if ( Bus2IP_BE[byte_index] == 1 )
					for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
					  slv_reg10[bit_index] <= Bus2IP_Data[bit_index];
				  17'b00000000000100000 :
				    for ( byte_index = 0; byte_index <= (C_DWIDTH/8)-1; byte_index = byte_index+1 )
				      if ( Bus2IP_BE[byte_index] == 1 )
					for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
					  slv_reg11[bit_index] <= Bus2IP_Data[bit_index];
				  17'b00000000000010000 :
				    for ( byte_index = 0; byte_index <= (C_DWIDTH/8)-1; byte_index = byte_index+1 )
				      if ( Bus2IP_BE[byte_index] == 1 )
					for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
					  slv_reg12[bit_index] <= Bus2IP_Data[bit_index];
				  17'b00000000000001000 :
				    for ( byte_index = 0; byte_index <= (C_DWIDTH/8)-1; byte_index = byte_index+1 )
				      if ( Bus2IP_BE[byte_index] == 1 )
					for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
					  slv_reg13[bit_index] <= Bus2IP_Data[bit_index];
				  17'b00000000000000100 :
				    for ( byte_index = 0; byte_index <= (C_DWIDTH/8)-1; byte_index = byte_index+1 )
				      if ( Bus2IP_BE[byte_index] == 1 )
					for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
					  slv_reg14[bit_index] <= Bus2IP_Data[bit_index];
				  17'b00000000000000010 :
				    for ( byte_index = 0; byte_index <= (C_DWIDTH/8)-1; byte_index = byte_index+1 )
				      if ( Bus2IP_BE[byte_index] == 1 )
					for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
					  slv_reg15[bit_index] <= Bus2IP_Data[bit_index];
				  17'b00000000000000001 :
				    for ( byte_index = 0; byte_index <= (C_DWIDTH/8)-1; byte_index = byte_index+1 )
				      if ( Bus2IP_BE[byte_index] == 1 )
					for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
					  slv_reg16[bit_index] <= Bus2IP_Data[bit_index];
				  default : ;
				endcase

		end // SLAVE_REG_WRITE_PROC

	// implement slave model register read mux
	always @( slv_reg_read_select or slv_reg0 or slv_reg1 or slv_reg2 or slv_reg3 or slv_reg4 or slv_reg5 or slv_reg6 or slv_reg7 or slv_reg8 or slv_reg9 or slv_reg10 or slv_reg11 or slv_reg12 or slv_reg13 or slv_reg14 or slv_reg15 or slv_reg16 )
		begin: SLAVE_REG_READ_PROC

			case ( slv_reg_read_select )
				17'b10000000000000000 : slv_ip2bus_data <= slv_reg0;
				17'b01000000000000000 : slv_ip2bus_data <= {Radio4_ADC_RX_DFS,
									    Radio3_ADC_RX_DFS,
									    Radio2_ADC_RX_DFS,
									    Radio1_ADC_RX_DFS,
									    slv_reg1[4:19],
									    Radio4_LD,
									    Radio3_LD,
									    Radio2_LD,
									    Radio1_LD,
									    slv_reg1[24:31]};
				17'b00100000000000000 : slv_ip2bus_data <= {Radio4_RSSI_ADC_CLAMP,
									    Radio3_RSSI_ADC_CLAMP,
									    Radio2_RSSI_ADC_CLAMP,
									    Radio1_RSSI_ADC_CLAMP,
									    Radio4_RSSI_ADC_HIZ,
									    Radio3_RSSI_ADC_HIZ,
									    Radio2_RSSI_ADC_HIZ,
									    Radio1_RSSI_ADC_HIZ,
									    Radio4_RSSI_ADC_OTR,
									    Radio3_RSSI_ADC_OTR,
									    Radio2_RSSI_ADC_OTR,
									    Radio1_RSSI_ADC_OTR,
									    slv_reg4[12:23],
									    Radio4_ADC_RX_OTRB,
									    Radio3_ADC_RX_OTRB,
									    Radio2_ADC_RX_OTRB,
									    Radio1_ADC_RX_OTRB,
									    Radio4_ADC_RX_OTRA,
									    Radio3_ADC_RX_OTRA,
									    Radio2_ADC_RX_OTRA,
									    Radio1_ADC_RX_OTRA};
				17'b00010000000000000 : slv_ip2bus_data <= {Radio2_TX_DAC_PLL_LOCK,
									    slv_reg3[1],
									    Radio2_DIPSW[3],
									    Radio2_DIPSW[2],
									    Radio2_DIPSW[1],
									    Radio2_DIPSW[0],
									    Radio2_RSSI_ADC_D,
									    Radio1_TX_DAC_PLL_LOCK,
									    slv_reg3[17],
									    Radio1_DIPSW[3],
									    Radio1_DIPSW[2],
									    Radio1_DIPSW[1],
									    Radio1_DIPSW[0],
									    Radio1_RSSI_ADC_D};
				17'b00001000000000000 : slv_ip2bus_data <= {Radio4_TX_DAC_PLL_LOCK,
									    slv_reg4[1],
									    Radio4_DIPSW[3],
									    Radio4_DIPSW[2],
									    Radio4_DIPSW[1],
									    Radio4_DIPSW[0],
									    Radio4_RSSI_ADC_D,
									    Radio3_TX_DAC_PLL_LOCK,
									    slv_reg4[17],
									    Radio3_DIPSW[3],
									    Radio3_DIPSW[2],
									    Radio3_DIPSW[1],
									    Radio3_DIPSW[0],
									    Radio3_RSSI_ADC_D};
				17'b00000100000000000 : slv_ip2bus_data <= {slv_reg5[0:22], mytip, slv_reg5[24:31]};
				17'b00000010000000000 : slv_ip2bus_data <= slv_reg6;
				17'b00000001000000000 : slv_ip2bus_data <= slv_reg7;
				17'b00000000100000000 : slv_ip2bus_data <= slv_reg8;
				17'b00000000010000000 : slv_ip2bus_data <= slv_reg9;
				17'b00000000001000000 : slv_ip2bus_data <= slv_reg10;
				17'b00000000000100000 : slv_ip2bus_data <= slv_reg11;
				17'b00000000000010000 : slv_ip2bus_data <= slv_reg12;
				17'b00000000000001000 : slv_ip2bus_data <= slv_reg13;
				17'b00000000000000100 : slv_ip2bus_data <= slv_reg14;
				17'b00000000000000010 : slv_ip2bus_data <= slv_reg15;
				17'b00000000000000001 : slv_ip2bus_data <= slv_reg16;
				default : slv_ip2bus_data <= 0;
			endcase

		end // SLAVE_REG_READ_PROC

	// ------------------------------------------------------------
	// Example code to drive IP to Bus signals
	// ------------------------------------------------------------

	assign IP2Bus_Data        = slv_ip2bus_data;
	assign IP2Bus_Ack         = slv_write_ack || slv_read_ack;
	assign IP2Bus_Error       = 0;
	assign IP2Bus_Retry       = 0;
	assign IP2Bus_ToutSup     = 0;

endmodule
