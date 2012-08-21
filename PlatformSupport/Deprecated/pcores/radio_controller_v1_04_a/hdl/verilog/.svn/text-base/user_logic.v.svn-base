//----------------------------------------------------------------------------
// user_logic.v - module
//----------------------------------------------------------------------------
//
/* Copyright (c) 2006 Rice University */
/* All Rights Reserved */
/* This code is covered by the Rice-WARP license */
/* See http://warp.rice.edu/license/ for details */
//
//----------------------------------------------------------------------------
// Filename:          user_logic.v
// Version:           1.04.a
// Description:       User logic module.
// Date:              Sat Apr 15 16:16:16 2006 (by Create and Import Peripheral Wizard)
// Verilog Standard:  Verilog-2001
//----------------------------------------------------------------------------
// Naming Conventions:
//   active low signals:                    "*_n"
//   clock signals:                         "clk", "clk_div#", "clk_#x"
//   reset signals:                         "rst", "rst_n"
//   generics:                              "C_*"
//   user defined types:                    "*_TYPE"
//   state machine next state:              "*_ns"
//   state machine current state:           "*_cs"
//   combinatorial signals:                 "*_com"
//   pipelined or register delay signals:   "*_d#"
//   counter signals:                       "*cnt*"
//   clock enable signals:                  "*_ce"
//   internal version of output port:       "*_i"
//   device pins:                           "*_pin"
//   ports:                                 "- Names begin with Uppercase"
//   processes:                             "*_PROCESS"
//   component instantiations:              "<ENTITY_>I_<#|FUNC>"
//----------------------------------------------------------------------------

module user_logic
(
  // -- ADD USER PORTS BELOW THIS LINE ---------------
  // --USER ports added here 
  
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
    Radio1_RxHP_external,
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
    Radio2_RxHP_external,
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
    Radio3_RxHP_external,
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
    Radio4_RxHP_external,
  
  
  // -- ADD USER PORTS ABOVE THIS LINE ---------------

  // -- DO NOT EDIT BELOW THIS LINE ------------------
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
  // -- DO NOT EDIT ABOVE THIS LINE ------------------
); // user_logic

// -- ADD USER PARAMETERS BELOW THIS LINE ------------
// --USER parameters added here 
// -- ADD USER PARAMETERS ABOVE THIS LINE ------------

// -- DO NOT EDIT BELOW THIS LINE --------------------
// -- Bus protocol parameters, do not add to or delete
parameter C_DWIDTH                       = 32;
parameter C_NUM_CE                       = 8;
// -- DO NOT EDIT ABOVE THIS LINE --------------------

// -- ADD USER PORTS BELOW THIS LINE -----------------
// --USER ports added here 

    
    output				    spi_clk;
    output				    data_out;
    output				    Radio1_cs;
    output				    Radio2_cs;
    output				    Radio3_cs;
    output				    Radio4_cs;
    output				    Dac1_cs;
    output				    Dac2_cs;
    output				    Dac3_cs;
    output				    Dac4_cs;
    output                                  Radio1_SHDN;
    output                                  Radio1_TxEn;
    output                                  Radio1_RxEn;
    output                                  Radio1_RxHP;
    input                                   Radio1_LD;
    output                                  Radio1_24PA;
    output                                  Radio1_5PA;
    output          [0 : 1]                 Radio1_ANTSW;
    output          [0 : 2]                 Radio1_LED;
    output                                  Radio1_ADC_RX_DCS;
    output                                  Radio1_ADC_RX_DFS;
    input                                   Radio1_ADC_RX_OTRA;
    input                                   Radio1_ADC_RX_OTRB;
    output                                  Radio1_ADC_RX_PWDNA;
    output                                  Radio1_ADC_RX_PWDNB;
    input           [0 : 3]                 Radio1_DIPSW;
    output                                  Radio1_RSSI_ADC_CLAMP;
    output                                  Radio1_RSSI_ADC_HIZ;
    input                                   Radio1_RSSI_ADC_OTR;
    output                                  Radio1_RSSI_ADC_SLEEP;
    input           [0 : 9]                 Radio1_RSSI_ADC_D;
    input                                   Radio1_TX_DAC_PLL_LOCK;
    output                                  Radio1_TX_DAC_RESET;
    input				    Radio1_RxHP_external;
    output                                  Radio2_SHDN;
    output                                  Radio2_TxEn;
    output                                  Radio2_RxEn;
    output                                  Radio2_RxHP;
    input                                   Radio2_LD;
    output                                  Radio2_24PA;
    output                                  Radio2_5PA;
    output          [0 : 1]                 Radio2_ANTSW;
    output          [0 : 2]                 Radio2_LED;
    output                                  Radio2_ADC_RX_DCS;
    output                                  Radio2_ADC_RX_DFS;
    input                                   Radio2_ADC_RX_OTRA;
    input                                   Radio2_ADC_RX_OTRB;
    output                                  Radio2_ADC_RX_PWDNA;
    output                                  Radio2_ADC_RX_PWDNB;
    input           [0 : 3]                 Radio2_DIPSW;
    output                                  Radio2_RSSI_ADC_CLAMP;
    output                                  Radio2_RSSI_ADC_HIZ;
    input                                   Radio2_RSSI_ADC_OTR;
    output                                  Radio2_RSSI_ADC_SLEEP;
    input           [0 : 9]                 Radio2_RSSI_ADC_D;
    input                                   Radio2_TX_DAC_PLL_LOCK;
    output                                  Radio2_TX_DAC_RESET;
    input				    Radio2_RxHP_external;
    output                                  Radio3_SHDN;
    output                                  Radio3_TxEn;
    output                                  Radio3_RxEn;
    output                                  Radio3_RxHP;
    input                                   Radio3_LD;
    output                                  Radio3_24PA;
    output                                  Radio3_5PA;
    output          [0 : 1]                 Radio3_ANTSW;
    output          [0 : 2]                 Radio3_LED;
    output                                  Radio3_ADC_RX_DCS;
    output                                  Radio3_ADC_RX_DFS;
    input                                   Radio3_ADC_RX_OTRA;
    input                                   Radio3_ADC_RX_OTRB;
    output                                  Radio3_ADC_RX_PWDNA;
    output                                  Radio3_ADC_RX_PWDNB;
    input           [0 : 3]                 Radio3_DIPSW;
    output                                  Radio3_RSSI_ADC_CLAMP;
    output                                  Radio3_RSSI_ADC_HIZ;
    input                                   Radio3_RSSI_ADC_OTR;
    output                                  Radio3_RSSI_ADC_SLEEP;
    input           [0 : 9]                 Radio3_RSSI_ADC_D;
    input                                   Radio3_TX_DAC_PLL_LOCK;
    output                                  Radio3_TX_DAC_RESET;
    input				    Radio3_RxHP_external;
    output                                  Radio4_SHDN;
    output                                  Radio4_TxEn;
    output                                  Radio4_RxEn;
    output                                  Radio4_RxHP;
    input                                   Radio4_LD;
    output                                  Radio4_24PA;
    output                                  Radio4_5PA;
    output          [0 : 1]                 Radio4_ANTSW;
    output          [0 : 2]                 Radio4_LED;                     //
    output                                  Radio4_ADC_RX_DCS;
    output                                  Radio4_ADC_RX_DFS;              // 1
    input                                   Radio4_ADC_RX_OTRA;
    input                                   Radio4_ADC_RX_OTRB;
    output                                  Radio4_ADC_RX_PWDNA;
    output                                  Radio4_ADC_RX_PWDNB;
    input           [0 : 3]                 Radio4_DIPSW;
    output                                  Radio4_RSSI_ADC_CLAMP;          //
    output                                  Radio4_RSSI_ADC_HIZ;            //
    input                                   Radio4_RSSI_ADC_OTR;
    output                                  Radio4_RSSI_ADC_SLEEP;          //
    input           [0 : 9]                 Radio4_RSSI_ADC_D;
    input                                   Radio4_TX_DAC_PLL_LOCK;
    output                                  Radio4_TX_DAC_RESET;
    input				    Radio4_RxHP_external;


// -- ADD USER PORTS ABOVE THIS LINE -----------------

// -- DO NOT EDIT BELOW THIS LINE --------------------
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
// -- DO NOT EDIT ABOVE THIS LINE --------------------

//----------------------------------------------------------------------------
// Implementation
//----------------------------------------------------------------------------

  // --USER nets declarations added here, as needed for user logic

  // Nets for user logic slave model s/w accessible register example
  reg        [0 : C_DWIDTH-1]               slv_reg0;
  reg        [0 : C_DWIDTH-1]               slv_reg1;
  reg        [0 : C_DWIDTH-1]               slv_reg2;
  reg        [0 : C_DWIDTH-1]               slv_reg3;
  reg        [0 : C_DWIDTH-1]               slv_reg4;
  reg        [0 : C_DWIDTH-1]               slv_reg5;
  reg        [0 : C_DWIDTH-1]               slv_reg6;
  reg        [0 : C_DWIDTH-1]               slv_reg7;
  wire       [0 : 7]                        slv_reg_write_select;
  wire       [0 : 7]                        slv_reg_read_select;
  reg        [0 : C_DWIDTH-1]               slv_ip2bus_data;
  wire                                      slv_read_ack;
  wire                                      slv_write_ack;
  integer                                   byte_index, bit_index;

  // --USER logic implementation added here
  
  
  wire [7:0] ss_pad_o;
  wire mytip;
  wire [13:0] reg_ctrl;
  wire [7:0] reg_ss;
  wire reg_divider;
  wire [17:0] reg_tx;
  
  
  assign  Radio1_SHDN = ~slv_reg0[31];
  assign  Radio1_TxEn = slv_reg0[30];
  assign  Radio1_RxEn = slv_reg0[29];
  assign  Radio1_RxHP = (slv_reg0[27])?slv_reg0[28]:Radio1_RxHP_external;
  assign  Radio1_24PA = ~slv_reg0[26];
  assign  Radio1_5PA = ~slv_reg0[25];
  assign  Radio1_ANTSW[0] = slv_reg0[23];
  assign  Radio1_ANTSW[1] = slv_reg0[24];
  assign  Radio1_ADC_RX_DCS = slv_reg0[22];
  assign  Radio1_LED[0] = ~Radio1_TX_DAC_PLL_LOCK;
  assign  Radio1_LED[1] = Radio1_TxEn;
  assign  Radio1_LED[2] = ~Radio1_LD;
  assign  Radio1_ADC_RX_PWDNA = slv_reg0[18];
  assign  Radio1_ADC_RX_PWDNB = slv_reg0[17];
  assign  Radio1_RSSI_ADC_SLEEP = slv_reg0[16];
  assign  Radio1_TX_DAC_RESET = slv_reg0[10];
   	
  assign  Radio1_ADC_RX_DFS = 1'b1; //slv_reg0[18];
  assign  Radio1_RSSI_ADC_CLAMP = 1'b0; //slv_reg0[9];
  assign  Radio1_RSSI_ADC_HIZ = 1'b0; //slv_reg0[8];  
  
  assign  Radio2_SHDN = ~slv_reg1[31];
  assign  Radio2_TxEn = slv_reg1[30];
  assign  Radio2_RxEn = slv_reg1[29];
  assign  Radio2_RxHP = (slv_reg1[27])?slv_reg1[28]:Radio2_RxHP_external;
  assign  Radio2_24PA = ~slv_reg1[26];
  assign  Radio2_5PA = ~slv_reg1[25];
  assign  Radio2_ANTSW[0] = slv_reg1[23];
  assign  Radio2_ANTSW[1] = slv_reg1[24];
  assign  Radio2_ADC_RX_DCS = slv_reg1[22];
  assign  Radio2_LED[0] = ~Radio2_TX_DAC_PLL_LOCK;
  assign  Radio2_LED[1] = Radio2_TxEn;
  assign  Radio2_LED[2] = ~Radio2_LD;
  assign  Radio2_ADC_RX_PWDNA = slv_reg1[18];
  assign  Radio2_ADC_RX_PWDNB = slv_reg1[17];
  assign  Radio2_RSSI_ADC_SLEEP = slv_reg1[16];
  assign  Radio2_TX_DAC_RESET = slv_reg1[10];
   	
  assign  Radio2_ADC_RX_DFS = 1'b1; //slv_reg1[18];
  assign  Radio2_RSSI_ADC_CLAMP = 1'b0; //slv_reg1[9];
  assign  Radio2_RSSI_ADC_HIZ = 1'b0; //slv_reg1[8];  

  assign  Radio3_SHDN = ~slv_reg2[31];
  assign  Radio3_TxEn = slv_reg2[30];
  assign  Radio3_RxEn = slv_reg2[29];
  assign  Radio3_RxHP = (slv_reg2[27])?slv_reg2[28]:Radio3_RxHP_external;
  assign  Radio3_24PA = ~slv_reg2[26];
  assign  Radio3_5PA = ~slv_reg2[25];
  assign  Radio3_ANTSW[0] = slv_reg2[23];
  assign  Radio3_ANTSW[1] = slv_reg2[24];
  assign  Radio3_ADC_RX_DCS = slv_reg2[22];
  assign  Radio3_LED[0] = ~Radio3_TX_DAC_PLL_LOCK;
  assign  Radio3_LED[1] = Radio3_TxEn;
  assign  Radio3_LED[2] = ~Radio3_LD;
  assign  Radio3_ADC_RX_PWDNA = slv_reg2[18];
  assign  Radio3_ADC_RX_PWDNB = slv_reg2[17];
  assign  Radio3_RSSI_ADC_SLEEP = slv_reg2[16];
  assign  Radio3_TX_DAC_RESET = slv_reg2[10];
   	
  assign  Radio3_ADC_RX_DFS = 1'b1; //slv_reg2[18];
  assign  Radio3_RSSI_ADC_CLAMP = 1'b0; //slv_reg2[9];
  assign  Radio3_RSSI_ADC_HIZ = 1'b0; //slv_reg2[8];  

  assign  Radio4_SHDN = ~slv_reg3[31];
  assign  Radio4_TxEn = slv_reg3[30];
  assign  Radio4_RxEn = slv_reg3[29];
  assign  Radio4_RxHP = (slv_reg3[27])?slv_reg3[28]:Radio4_RxHP_external;
  assign  Radio4_24PA = ~slv_reg3[26];
  assign  Radio4_5PA = ~slv_reg3[25];
  assign  Radio4_ANTSW[0] = slv_reg3[23];
  assign  Radio4_ANTSW[1] = slv_reg3[24];
  assign  Radio4_ADC_RX_DCS = slv_reg3[22];
  assign  Radio4_LED[0] = ~Radio4_TX_DAC_PLL_LOCK;
  assign  Radio4_LED[1] = Radio4_TxEn;
  assign  Radio4_LED[2] = ~Radio4_LD;
  assign  Radio4_ADC_RX_PWDNA = slv_reg3[18];
  assign  Radio4_ADC_RX_PWDNB = slv_reg3[17];
  assign  Radio4_RSSI_ADC_SLEEP = slv_reg3[16];
  assign  Radio4_TX_DAC_RESET = slv_reg3[10];
   	
  assign  Radio4_ADC_RX_DFS = 1'b1; //slv_reg3[18];
  assign  Radio4_RSSI_ADC_CLAMP = 1'b0; //slv_reg3[9];
  assign  Radio4_RSSI_ADC_HIZ = 1'b0; //slv_reg3[8];  

  assign  Radio1_cs = ss_pad_o[0];
  assign  Radio2_cs = ss_pad_o[1];
  assign  Radio3_cs = ss_pad_o[2];
  assign  Radio4_cs = ss_pad_o[3];
  assign  Dac1_cs = ss_pad_o[4];
  assign  Dac2_cs = ss_pad_o[5];
  assign  Dac3_cs = ss_pad_o[6];
  assign  Dac4_cs = ss_pad_o[7];
    
  assign reg_ctrl = slv_reg4[18:31];
  assign reg_divider = slv_reg5[31];
  assign reg_ss = slv_reg6[24:31];
  assign reg_tx = slv_reg7[14:31];
  
  spi_top spi_top(
    .opb_clk_i(Bus2IP_Clk),
    .opb_rst_i(Bus2IP_Reset),
    .reg_ctrl(reg_ctrl),
    .reg_ss(reg_ss),
    .reg_divider(reg_divider),
    .reg_tx(reg_tx),
    .ctrlwrite(Bus2IP_WrCE[4]),
    .busval(Bus2IP_Data[23]), 
    .go(mytip),
    .ss_pad_o(ss_pad_o),
    .sclk_pad_o(spi_clk),
    .mosi_pad_o(data_out)
  );
  

  // ------------------------------------------------------
  // Example code to read/write user logic slave model s/w accessible registers
  // 
  // Note:
  // The example code presented here is to show you one way of reading/writing
  // software accessible registers implemented in the user logic slave model.
  // Each bit of the Bus2IP_WrCE/Bus2IP_RdCE signals is configured to correspond
  // to one software accessible register by the top level template. For example,
  // if you have four 32 bit software accessible registers in the user logic, you
  // are basically operating on the following memory mapped registers:
  // 
  //    Bus2IP_WrCE or   Memory Mapped
  //       Bus2IP_RdCE   Register
  //            "1000"   C_BASEADDR + 0x0
  //            "0100"   C_BASEADDR + 0x4
  //            "0010"   C_BASEADDR + 0x8
  //            "0001"   C_BASEADDR + 0xC
  // 
  // ------------------------------------------------------
  
  assign
    slv_reg_write_select = Bus2IP_WrCE[0:7],
    slv_reg_read_select  = Bus2IP_RdCE[0:7],
    slv_write_ack        = Bus2IP_WrCE[0] || Bus2IP_WrCE[1] || Bus2IP_WrCE[2] || Bus2IP_WrCE[3] || Bus2IP_WrCE[4] || Bus2IP_WrCE[5] || Bus2IP_WrCE[6] || Bus2IP_WrCE[7],
    slv_read_ack         = Bus2IP_RdCE[0] || Bus2IP_RdCE[1] || Bus2IP_RdCE[2] || Bus2IP_RdCE[3] || Bus2IP_RdCE[4] || Bus2IP_RdCE[5] || Bus2IP_RdCE[6] || Bus2IP_RdCE[7];

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
        end
      else
        case ( slv_reg_write_select )
          8'b10000000 :
            for ( byte_index = 0; byte_index <= (C_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg0[bit_index] <= Bus2IP_Data[bit_index];
          8'b01000000 :
            for ( byte_index = 0; byte_index <= (C_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg1[bit_index] <= Bus2IP_Data[bit_index];
          8'b00100000 :
            for ( byte_index = 0; byte_index <= (C_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg2[bit_index] <= Bus2IP_Data[bit_index];
          8'b00010000 :
            for ( byte_index = 0; byte_index <= (C_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg3[bit_index] <= Bus2IP_Data[bit_index];
          8'b00001000 :
            for ( byte_index = 0; byte_index <= (C_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg4[bit_index] <= Bus2IP_Data[bit_index];
          8'b00000100 :
            for ( byte_index = 0; byte_index <= (C_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg5[bit_index] <= Bus2IP_Data[bit_index];
          8'b00000010 :
            for ( byte_index = 0; byte_index <= (C_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg6[bit_index] <= Bus2IP_Data[bit_index];
          8'b00000001 :
            for ( byte_index = 0; byte_index <= (C_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg7[bit_index] <= Bus2IP_Data[bit_index];
          default : ;
        endcase

    end // SLAVE_REG_WRITE_PROC

  // implement slave model register read mux
  always @( slv_reg_read_select or slv_reg0 or slv_reg1 or slv_reg2 or slv_reg3 or slv_reg4 or slv_reg5 or slv_reg6 or slv_reg7 )
    begin: SLAVE_REG_READ_PROC

      case ( slv_reg_read_select )
        8'b10000000 : slv_ip2bus_data <= {Radio1_RSSI_ADC_D[0:9],
                                          slv_reg0[10],
                                          Radio1_TX_DAC_PLL_LOCK,
                                          Radio1_RSSI_ADC_OTR,
                                          Radio1_DIPSW[3],
                                          Radio1_DIPSW[2],
                                          Radio1_DIPSW[1],
                                          Radio1_DIPSW[0],
                                          slv_reg0[17:18],
                                          Radio1_ADC_RX_OTRB,
                                          Radio1_ADC_RX_OTRA,
                                          Radio1_ADC_RX_DFS,
                                          slv_reg0[22:26],
                                          Radio1_LD,
                                          slv_reg0[28:31]};
                                          
        8'b01000000 : slv_ip2bus_data <= {Radio2_RSSI_ADC_D[0:9],
                                          slv_reg1[10],
                                          Radio2_TX_DAC_PLL_LOCK,
                                          Radio2_RSSI_ADC_OTR,
                                          Radio2_DIPSW[3],
                                          Radio2_DIPSW[2],
                                          Radio2_DIPSW[1],
                                          Radio2_DIPSW[0],
                                          slv_reg1[17:18],
                                          Radio2_ADC_RX_OTRB,
                                          Radio2_ADC_RX_OTRA,
                                          Radio2_ADC_RX_DFS,
                                          slv_reg1[22:26],
                                          Radio2_LD,
                                          slv_reg1[28:31]};
                                          
        8'b00100000 : slv_ip2bus_data <= {Radio3_RSSI_ADC_D[0:9],
                                          slv_reg2[10],
                                          Radio3_TX_DAC_PLL_LOCK,
                                          Radio3_RSSI_ADC_OTR,
                                          Radio3_DIPSW[3],
                                          Radio3_DIPSW[2],
                                          Radio3_DIPSW[1],
                                          Radio3_DIPSW[0],
                                          slv_reg2[17:18],
                                          Radio3_ADC_RX_OTRB,
                                          Radio3_ADC_RX_OTRA,
                                          Radio3_ADC_RX_DFS,
                                          slv_reg2[22:26],
                                          Radio3_LD,
                                          slv_reg2[28:31]};
                                          
        8'b00010000 : slv_ip2bus_data <= {Radio4_RSSI_ADC_D[0:9],
                                          slv_reg3[10],
                                          Radio4_TX_DAC_PLL_LOCK,
                                          Radio4_RSSI_ADC_OTR,
                                          Radio4_DIPSW[3],
                                          Radio4_DIPSW[2],
                                          Radio4_DIPSW[1],
                                          Radio4_DIPSW[0],
                                          slv_reg3[17:18],
                                          Radio4_ADC_RX_OTRB,
                                          Radio4_ADC_RX_OTRA,
                                          Radio4_ADC_RX_DFS,
                                          slv_reg3[22:26],
                                          Radio4_LD,
                                          slv_reg3[28:31]};
                                          
        8'b00001000 : slv_ip2bus_data <= {slv_reg4[0:22], mytip, slv_reg4[24:31]};
        8'b00000100 : slv_ip2bus_data <= slv_reg5;
        8'b00000010 : slv_ip2bus_data <= slv_reg6;
        8'b00000001 : slv_ip2bus_data <= slv_reg7;
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
