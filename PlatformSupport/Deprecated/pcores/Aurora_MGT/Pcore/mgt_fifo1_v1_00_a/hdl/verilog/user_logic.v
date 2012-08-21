//----------------------------------------------------------------------------
// user_logic.v - module
//----------------------------------------------------------------------------
//
// ***************************************************************************
// ** Copyright (c) 1995-2005 Xilinx, Inc.  All rights reserved.            **
// **                                                                       **
// ** Xilinx, Inc.                                                          **
// ** XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"         **
// ** AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND       **
// ** SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,        **
// ** OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,        **
// ** APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION           **
// ** THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,     **
// ** AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE      **
// ** FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY              **
// ** WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE               **
// ** IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR        **
// ** REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF       **
// ** INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS       **
// ** FOR A PARTICULAR PURPOSE.                                             **
// **                                                                       **
// ** YOU MAY COPY AND MODIFY THESE FILES FOR YOUR OWN INTERNAL USE SOLELY  **
// ** WITH XILINX PROGRAMMABLE LOGIC DEVICES AND XILINX EDK SYSTEM OR       **
// ** CREATE IP MODULES SOLELY FOR XILINX PROGRAMMABLE LOGIC DEVICES AND    **
// ** XILINX EDK SYSTEM. NO RIGHTS ARE GRANTED TO DISTRIBUTE ANY FILES      **
// ** UNLESS THEY ARE DISTRIBUTED IN XILINX PROGRAMMABLE LOGIC DEVICES.     **
// **                                                                       **
// ***************************************************************************
//
//----------------------------------------------------------------------------
// Filename:          user_logic.v
// Version:           1.00.a
// Description:       User logic module.
// Date:              Tue Jul 05 10:18:46 2005 (by Create and Import Peripheral Wizard)
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
  TOP_REF_CLK,
  RXP,
  RXN,
  TXP,
  TXN,
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
  IP2Bus_ToutSup,                 // IP to Bus timeout suppress
  IP2RFIFO_WrReq,                 // IP to RFIFO : IP write request
  IP2RFIFO_Data,                  // IP to RFIFO : IP write data
  RFIFO2IP_WrAck,                 // RFIFO to IP : RFIFO write acknowledge
  RFIFO2IP_AlmostFull,            // RFIFO to IP : RFIFO almost full
  RFIFO2IP_Full,                  // RFIFO to IP : RFIFO full
  RFIFO2IP_Vacancy,               // RFIFO to IP : RFIFO vacancy
  IP2WFIFO_RdReq,                 // IP to WFIFO : IP read request
  WFIFO2IP_Data,                  // WFIFO to IP : WFIFO read data
  WFIFO2IP_RdAck,                 // WFIFO to IP : WFIFO read acknowledge
  WFIFO2IP_AlmostEmpty,           // WFIFO to IP : WFIFO almost empty
  WFIFO2IP_Empty,                 // WFIFO to IP : WFIFO empty
  WFIFO2IP_Occupancy              // WFIFO to IP : WFIFO occupancy
  // -- DO NOT EDIT ABOVE THIS LINE ------------------
); // user_logic

// -- ADD USER PARAMETERS BELOW THIS LINE ------------
// --USER parameters added here 
// -- ADD USER PARAMETERS ABOVE THIS LINE ------------

// -- DO NOT EDIT BELOW THIS LINE --------------------
// -- Bus protocol parameters, do not add to or delete
parameter C_DWIDTH                       = 32;
parameter C_NUM_CE                       = 2;
parameter C_RDFIFO_DWIDTH                = 32;
parameter C_RDFIFO_DEPTH                 = 512;
parameter C_WRFIFO_DWIDTH                = 32;
parameter C_WRFIFO_DEPTH                 = 512;
// -- DO NOT EDIT ABOVE THIS LINE --------------------

// -- ADD USER PORTS BELOW THIS LINE -----------------
// --USER ports added here 
input TOP_REF_CLK;
input RXP;
input RXN;
output TXP;
output TXN;
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
output                                    IP2RFIFO_WrReq;
output     [0 : C_RDFIFO_DWIDTH-1]        IP2RFIFO_Data;
input                                     RFIFO2IP_WrAck;
input                                     RFIFO2IP_AlmostFull;
input                                     RFIFO2IP_Full;
input      [0 : 9]                        RFIFO2IP_Vacancy;
output                                    IP2WFIFO_RdReq;
input      [0 : C_WRFIFO_DWIDTH-1]        WFIFO2IP_Data;
input                                     WFIFO2IP_RdAck;
input                                     WFIFO2IP_AlmostEmpty;
input                                     WFIFO2IP_Empty;
input      [0 : 9]                        WFIFO2IP_Occupancy;
// -- DO NOT EDIT ABOVE THIS LINE --------------------

//----------------------------------------------------------------------------
// Implementation
//----------------------------------------------------------------------------

  // --USER nets declarations added here, as needed for user logic

  // Nets for user logic slave model s/w accessible register example
  reg        [0 : C_DWIDTH-1]               slv_reg0;
  reg        [0 : C_DWIDTH-1]               slv_reg1;
  wire       [0 : 1]                        slv_reg_write_select;
  wire       [0 : 1]                        slv_reg_read_select;
  reg        [0 : C_DWIDTH-1]               slv_ip2bus_data;
  wire                                      slv_read_ack;
  wire                                      slv_write_ack;
  integer                                   byte_index, bit_index;
  wire tx_src_rdy;
  wire rx_src_rdy;
  wire herr;
  wire serr;
  wire warncc;
  wire docc;
  wire channelup;
  wire dcmnotlocked;
  wire [0:31] rxd; 

  // --USER logic implementation added here

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
    slv_reg_write_select = Bus2IP_WrCE[0:1],
    slv_reg_read_select  = Bus2IP_RdCE[0:1],
    slv_write_ack        = Bus2IP_WrCE[0] || Bus2IP_WrCE[1],
    slv_read_ack         = Bus2IP_RdCE[0] || Bus2IP_RdCE[1];

  // implement slave model register(s)
  always @( posedge Bus2IP_Clk )
    begin: SLAVE_REG_WRITE_PROC

      if ( Bus2IP_Reset == 1 )
        begin
          slv_reg0 <= 0;
          slv_reg1 <= 0;
        end
      else
        case ( slv_reg_write_select )
          2'b10 :
            for ( byte_index = 0; byte_index <= (C_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg0[bit_index] <= Bus2IP_Data[bit_index];
          2'b01 :
            for ( byte_index = 0; byte_index <= (C_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg1[bit_index] <= Bus2IP_Data[bit_index];
          default : ;
        endcase

    end // SLAVE_REG_WRITE_PROC

  // implement slave model register read mux
  always @( slv_reg_read_select or slv_reg0 or slv_reg1 )
    begin: SLAVE_REG_READ_PROC

      case ( slv_reg_read_select )
        2'b10 : slv_ip2bus_data <= slv_reg0;
        2'b01 : slv_ip2bus_data <= slv_reg1;
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
  wire user_clk_gen;
  wire user_clk_n_2x_gen;
  wire rxdatrdy;
  assign IP2RFIFO_WrReq = ~rxdatrdy;
  wire txdatrdy;
  
  assign IP2WFIFO_RdReq = ~txdatrdy;


aurora4bitstream1 aurora4bitstream1(
	.TX_D(WFIFO2IP_Data),            //IN
	.TX_SRC_RDY_N(~WFIFO2IP_RdAck),      //IN
	.TX_DST_RDY_N(txdatrdy),      //OUT
	.RX_D(IP2RFIFO_Data),                      //out;
	.RX_SRC_RDY_N(rxdatrdy),      //out;
	.DO_CC(docc),                    //in;
	.WARN_CC(warncc),                //in;
	.RXP(RXP),                        //in;
	.RXN(RXN),                        //in;
	.TXP(TXP),                        //out;
	.TXN(TXN),                        //out;
	.TOP_REF_CLK(TOP_REF_CLK),      //in;
	.HARD_ERROR(herr),          //out;
	.SOFT_ERROR(serr),          //out;
	.CHANNEL_UP(channelup),          //out;
	.LANE_UP(),                //out;
	.DCM_NOT_LOCKED(dcmnotlocked),  //in;
	.USER_CLK(user_clk_gen),              //in ;
	.USER_CLK_N_2X(user_clk_n_2x_gen),
	.RESET(1'b0),                     //in;
	.POWER_DOWN(1'b0),          //in;
	.LOOPBACK(2'b0)
);             //in [1:0];

STANDARD_CC_MODULE standard_cc(
	.WARN_CC(warncc),
	.DO_CC(docc),
	.DCM_NOT_LOCKED(dcmnotlocked),
	.USER_CLK(user_clk_gen),
	.CHANNEL_UP(channelup)
);

CLOCK_MODULE clock_module(
	.MGT_REFERENCE_CLOCK(TOP_REF_CLK),
	.USER_CLK(user_clk_gen),
	.USER_CLK_2X_N(user_clk_n_2x_gen),
	.DCM_NOT_LOCKED(dcmnotlocked)
);

    
    
  
    


endmodule
