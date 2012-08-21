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
// Version:           1.01.a
// Description:       User logic module.
// Date:              Thu Jul 07 16:33:45 2005 (by Create and Import Peripheral Wizard)
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
  
  Radio1_SHDN,
  Radio1_TxEn,
  Radio1_RxEn,
  Radio1_RxHP,
  Radio1_LD,
  Radio1_24PA,
  Radio1_5PA,
  Radio1_ANTSW,
  Radio1_LED,
  Radio2_SHDN,
  Radio2_TxEn,
  Radio2_RxEn,
  Radio2_RxHP,
  Radio2_LD,
  Radio2_24PA,
  Radio2_5PA,
  Radio2_ANTSW,
  Radio2_LED,
  Radio3_SHDN,
  Radio3_TxEn,
  Radio3_RxEn,
  Radio3_RxHP,
  Radio3_LD,
  Radio3_24PA,
  Radio3_5PA,
  Radio3_ANTSW,
  Radio3_LED,
  Radio4_SHDN,
  Radio4_TxEn,
  Radio4_RxEn,
  Radio4_RxHP,
  Radio4_LD,
  Radio4_24PA,
  Radio4_5PA,
  Radio4_ANTSW,
  Radio4_LED,

  
  
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
parameter C_NUM_CE                       = 4;
// -- DO NOT EDIT ABOVE THIS LINE --------------------

// -- ADD USER PORTS BELOW THIS LINE -----------------
// --USER ports added here 

output					Radio1_SHDN;
output					Radio1_TxEn;
output					Radio1_RxEn;
output					Radio1_RxHP;
input					Radio1_LD;
output					Radio1_24PA;
output					Radio1_5PA;
output		[0 : 1]			Radio1_ANTSW;
output		[0 : 2]			Radio1_LED;
output					Radio2_SHDN;
output					Radio2_TxEn;
output					Radio2_RxEn;
output					Radio2_RxHP;
input					Radio2_LD;
output					Radio2_24PA;
output					Radio2_5PA;
output		[0 : 1]			Radio2_ANTSW;
output		[0 : 2]			Radio2_LED;
output					Radio3_SHDN;
output					Radio3_TxEn;
output					Radio3_RxEn;
output					Radio3_RxHP;
input					Radio3_LD;
output					Radio3_24PA;
output					Radio3_5PA;
output		[0 : 1]			Radio3_ANTSW;
output		[0 : 2]			Radio3_LED;
output					Radio4_SHDN;
output					Radio4_TxEn;
output					Radio4_RxEn;
output					Radio4_RxHP;
input					Radio4_LD;
output					Radio4_24PA;
output					Radio4_5PA;
output		[0 : 1]			Radio4_ANTSW;
output		[0 : 2]			Radio4_LED;


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
  wire       [0 : 3]                        slv_reg_write_select;
  wire       [0 : 3]                        slv_reg_read_select;
  reg        [0 : C_DWIDTH-1]               slv_ip2bus_data;
  wire                                      slv_read_ack;
  wire                                      slv_write_ack;
  integer                                   byte_index, bit_index;

  // --USER logic implementation added here


assign  Radio1_SHDN = slv_reg0[31];
assign  Radio1_TxEn = slv_reg0[30];
assign  Radio1_RxEn = slv_reg0[29];
assign  Radio1_RxHP = slv_reg0[28];
assign  Radio1_24PA = slv_reg0[26];
assign  Radio1_5PA = slv_reg0[25];
assign  Radio1_ANTSW[0] = slv_reg0[24];
assign  Radio1_ANTSW[1] = slv_reg0[23];
assign  Radio1_LED[0] = slv_reg0[22];
assign  Radio1_LED[1] = slv_reg0[21];
assign  Radio1_LED[2] = slv_reg0[20];
assign  Radio2_SHDN = slv_reg1[31];
assign  Radio2_TxEn = slv_reg1[30];
assign  Radio2_RxEn = slv_reg1[29];
assign  Radio2_RxHP = slv_reg1[28];
assign  Radio2_24PA = slv_reg1[26];
assign  Radio2_5PA = slv_reg1[25];
assign  Radio2_ANTSW[0] = slv_reg1[24];
assign  Radio2_ANTSW[1] = slv_reg1[23];
assign  Radio2_LED[0] = slv_reg1[22];
assign  Radio2_LED[1] = slv_reg1[21];
assign  Radio2_LED[2] = slv_reg1[20];
assign  Radio3_SHDN = slv_reg2[31];
assign  Radio3_TxEn = slv_reg2[30];
assign  Radio3_RxEn = slv_reg2[29];
assign  Radio3_RxHP = slv_reg2[28];
assign  Radio3_24PA = slv_reg2[26];
assign  Radio3_5PA = slv_reg2[25];
assign  Radio3_ANTSW[0] = slv_reg2[24];
assign  Radio3_ANTSW[1] = slv_reg2[23];
assign  Radio3_LED[0] = slv_reg2[22];
assign  Radio3_LED[1] = slv_reg2[21];
assign  Radio3_LED[2] = slv_reg2[20];
assign  Radio4_SHDN = slv_reg3[31];
assign  Radio4_TxEn = slv_reg3[30];
assign  Radio4_RxEn = slv_reg3[29];
assign  Radio4_RxHP = slv_reg3[28];
assign  Radio4_24PA = slv_reg3[26];
assign  Radio4_5PA = slv_reg3[25];
assign  Radio4_ANTSW[0] = slv_reg3[24];
assign  Radio4_ANTSW[1] = slv_reg3[23];
assign  Radio4_LED[0] = slv_reg3[22];
assign  Radio4_LED[1] = slv_reg3[21];
assign  Radio4_LED[2] = slv_reg3[20];




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
    slv_reg_write_select = Bus2IP_WrCE[0:3],
    slv_reg_read_select  = Bus2IP_RdCE[0:3],
    slv_write_ack        = Bus2IP_WrCE[0] || Bus2IP_WrCE[1] || Bus2IP_WrCE[2] || Bus2IP_WrCE[3],
    slv_read_ack         = Bus2IP_RdCE[0] || Bus2IP_RdCE[1] || Bus2IP_RdCE[2] || Bus2IP_RdCE[3];

  // implement slave model register(s)
  always @( posedge Bus2IP_Clk )
    begin: SLAVE_REG_WRITE_PROC

      if ( Bus2IP_Reset == 1 )
        begin
          slv_reg0 <= 0;
          slv_reg1 <= 0;
          slv_reg2 <= 0;
          slv_reg3 <= 0;
        end
      else
        case ( slv_reg_write_select )
          4'b1000 :
            for ( byte_index = 0; byte_index <= (C_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg0[bit_index] <= Bus2IP_Data[bit_index];
          4'b0100 :
            for ( byte_index = 0; byte_index <= (C_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg1[bit_index] <= Bus2IP_Data[bit_index];
          4'b0010 :
            for ( byte_index = 0; byte_index <= (C_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg2[bit_index] <= Bus2IP_Data[bit_index];
          4'b0001 :
            for ( byte_index = 0; byte_index <= (C_DWIDTH/8)-1; byte_index = byte_index+1 )
              if ( Bus2IP_BE[byte_index] == 1 )
                for ( bit_index = byte_index*8; bit_index <= byte_index*8+7; bit_index = bit_index+1 )
                  slv_reg3[bit_index] <= Bus2IP_Data[bit_index];
          default : ;
        endcase

    end // SLAVE_REG_WRITE_PROC

  // implement slave model register read mux
  always @( slv_reg_read_select or slv_reg0 or slv_reg1 or slv_reg2 or slv_reg3 )
    begin: SLAVE_REG_READ_PROC

      case ( slv_reg_read_select )
        4'b1000 : slv_ip2bus_data <= {20'b0, slv_reg0[20:26], Radio1_LD, slv_reg0[28:31]};
        4'b0100 : slv_ip2bus_data <= {20'b0, slv_reg1[20:26], Radio2_LD, slv_reg1[28:31]};
        4'b0010 : slv_ip2bus_data <= {20'b0, slv_reg2[20:26], Radio3_LD, slv_reg2[28:31]};
        4'b0001 : slv_ip2bus_data <= {20'b0, slv_reg3[20:26], Radio4_LD, slv_reg3[28:31]};
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
