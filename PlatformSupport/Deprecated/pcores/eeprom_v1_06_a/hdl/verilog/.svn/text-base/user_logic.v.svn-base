//----------------------------------------------------------------------------
// user_logic.vhd - module
//----------------------------------------------------------------------------
//
// ***************************************************************************
// ** Copyright (c) 1995-2008 Xilinx, Inc.  All rights reserved.            **
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
// ***************************************************************************
//
//----------------------------------------------------------------------------
// Filename:          user_logic.vhd
// Version:           1.04.a
// Description:       User logic module.
// Date:              Tue Jun 24 12:44:50 2008 (by Create and Import Peripheral Wizard)
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
  //Eight EEPROM one-wire I/O ports (I/O/T control tri-state buffer in higher module)
  DQ0_T,                            
  DQ0_O,
  DQ0_I,
  
  DQ1_T,                             
  DQ1_O,
  DQ1_I,
  
  DQ2_T,                             
  DQ2_O,
  DQ2_I,
  
  DQ3_T,                             
  DQ3_O,
  DQ3_I,
  
  DQ4_T,                             
  DQ4_O,
  DQ4_I,
  
  DQ5_T,                             
  DQ5_O,
  DQ5_I,
  
  DQ6_T,                             
  DQ6_O,
  DQ6_I,
  
  DQ7_T,                             
  DQ7_O,
  DQ7_I,
  // -- ADD USER PORTS ABOVE THIS LINE ---------------

  // -- DO NOT EDIT BELOW THIS LINE ------------------
  // -- Bus protocol ports, do not add to or delete 
  Bus2IP_Clk,                     // Bus to IP clock
  Bus2IP_Reset,                   // Bus to IP reset
  Bus2IP_Addr,                    // Bus to IP address bus
  Bus2IP_CS,                      // Bus to IP chip select for user logic memory selection
  Bus2IP_RNW,                     // Bus to IP read/not write
  Bus2IP_Data,                    // Bus to IP data bus
  Bus2IP_BE,                      // Bus to IP byte enables
  IP2Bus_Data,                    // IP to Bus data bus
  IP2Bus_RdAck,                   // IP to Bus read transfer acknowledgement
  IP2Bus_WrAck,                   // IP to Bus write transfer acknowledgement
  IP2Bus_Error                    // IP to Bus error response
  // -- DO NOT EDIT ABOVE THIS LINE ------------------
); // user_logic

// -- ADD USER PARAMETERS BELOW THIS LINE ------------
// --USER parameters added here 
// -- ADD USER PARAMETERS ABOVE THIS LINE ------------

// -- DO NOT EDIT BELOW THIS LINE --------------------
// -- Bus protocol parameters, do not add to or delete
parameter C_SLV_AWIDTH                   = 32;
parameter C_SLV_DWIDTH                   = 32;
parameter C_NUM_MEM                      = 1;
// -- DO NOT EDIT ABOVE THIS LINE --------------------

// -- ADD USER PORTS BELOW THIS LINE -----------------
output                             DQ0_T;
output                             DQ1_T;
output                             DQ2_T;
output                             DQ3_T;
output                             DQ4_T;
output                             DQ5_T;
output                             DQ6_T;
output                             DQ7_T;

output                             DQ0_O;
output                             DQ1_O;
output                             DQ2_O;
output                             DQ3_O;
output                             DQ4_O;
output                             DQ5_O;
output                             DQ6_O;
output                             DQ7_O;

input                              DQ0_I;
input                              DQ1_I;
input                              DQ2_I;
input                              DQ3_I;
input                              DQ4_I;
input                              DQ5_I;
input                              DQ6_I;
input                              DQ7_I;
// -- ADD USER PORTS ABOVE THIS LINE -----------------

// -- DO NOT EDIT BELOW THIS LINE --------------------
// -- Bus protocol ports, do not add to or delete
input                                     Bus2IP_Clk;
input                                     Bus2IP_Reset;
input      [0 : C_SLV_AWIDTH-1]           Bus2IP_Addr;
input      [0 : C_NUM_MEM-1]              Bus2IP_CS;
input                                     Bus2IP_RNW;
input      [0 : C_SLV_DWIDTH-1]           Bus2IP_Data;
input      [0 : C_SLV_DWIDTH/8-1]         Bus2IP_BE;
output     [0 : C_SLV_DWIDTH-1]           IP2Bus_Data;
output                                    IP2Bus_RdAck;
output                                    IP2Bus_WrAck;
output                                    IP2Bus_Error;
// -- DO NOT EDIT ABOVE THIS LINE --------------------

//----------------------------------------------------------------------------
// Implementation
//----------------------------------------------------------------------------

 // --USER logic implementation added here
  wire [ 7:0] OWM_rd_data;
  wire [31:0] OWM_wt_data;
  wire [31:0] OWM_addr;
  
     assign OWM_wt_data = Bus2IP_Data;
     assign OWM_addr    = Bus2IP_Addr;
  
  reg  [ 2:0] OWM_rdwt_cycle;
  reg         OWM_wt_n;
  reg         OWM_rd_n;
  reg         OWM_rdwt_ack;
  reg         OWM_toutsup;
  
     always @ (posedge Bus2IP_Clk or posedge Bus2IP_Reset)
     begin
  
        if (Bus2IP_Reset)
        begin
  
           OWM_rdwt_cycle <= 3'b000;
           OWM_wt_n       <= 1'b1;
           OWM_rd_n       <= 1'b1;
           OWM_rdwt_ack   <= 1'b0;
           OWM_toutsup    <= 1'b0;
  
        end
  
        else
        begin
  
           if      (              ~Bus2IP_CS) OWM_rdwt_cycle <= 3'b000;
           else if (OWM_rdwt_cycle == 3'b111) OWM_rdwt_cycle <= 3'b111;
           else                               OWM_rdwt_cycle <= OWM_rdwt_cycle + 1;
  
           OWM_wt_n     <= ~(   Bus2IP_CS & ~Bus2IP_RNW & (OWM_rdwt_cycle == 1)
                              | Bus2IP_CS & ~Bus2IP_RNW & (OWM_rdwt_cycle == 2)
                            );
  
           OWM_rd_n     <= ~(   Bus2IP_CS &  Bus2IP_RNW & (OWM_rdwt_cycle == 1)
                              | Bus2IP_CS &  Bus2IP_RNW & (OWM_rdwt_cycle == 2)
                              | Bus2IP_CS &  Bus2IP_RNW & (OWM_rdwt_cycle == 3)
                              | Bus2IP_CS &  Bus2IP_RNW & (OWM_rdwt_cycle == 4)
                            );
  
           OWM_rdwt_ack <= Bus2IP_CS & (OWM_rdwt_cycle == 4);
  
           OWM_toutsup  <= ~OWM_toutsup & Bus2IP_CS & (OWM_rdwt_cycle == 0)
                         |  OWM_toutsup & Bus2IP_CS & ~OWM_rdwt_ack;
  
        end
  
     end
  
  // ********** Instantiate the OWM core here... *****************************************
  
    	wire clk_1us_out;

  	OWM owm_instance
  	 (
  	   .ADDRESS(OWM_addr[4:2]),                   
      .ADS_bar(1'b0),
      .CLK(Bus2IP_Clk),
      .EN_bar(1'b0),
      .MR(Bus2IP_Reset),
      .RD_bar(OWM_rd_n),
      .WR_bar(OWM_wt_n),
      .INTR(),	
  	   .STPZ(),
      .DATA_IN(OWM_wt_data[7:0]),
      .DATA_OUT(OWM_rd_data),
      .DQ0_T(DQ0_T),
      .DQ0_O(DQ0_O),
      .DQ0_I(DQ0_I),

      .DQ1_T(DQ1_T),
      .DQ1_O(DQ1_O),
      .DQ1_I(DQ1_I),

      .DQ2_T(DQ2_T),
      .DQ2_O(DQ2_O),
      .DQ2_I(DQ2_I),

      .DQ3_T(DQ3_T),
      .DQ3_O(DQ3_O),
      .DQ3_I(DQ3_I),

      .DQ4_T(DQ4_T),
      .DQ4_O(DQ4_O),
      .DQ4_I(DQ4_I),

      .DQ5_T(DQ5_T),
      .DQ5_O(DQ5_O),
      .DQ5_I(DQ5_I),

      .DQ6_T(DQ6_T),
      .DQ6_O(DQ6_O),
      .DQ6_I(DQ6_I),

      .DQ7_T(DQ7_T),
      .DQ7_O(DQ7_O),
      .DQ7_I(DQ7_I)
  	 );

  // Now connect signals to the OWM peripheral using the following mapping
  // (instantiate the OWM core)...
  //
  // INTR     -> IP2Bus_IntrEvent
  // DATA_IN  -> OWM_wt_data [7:0]
  // DATA_OUT -> OWM_rd_data [7:0]
  // A        -> OWM_addr    [2:0]
  // ADS      -> 1'b0;
  // RD       -> OWM_rd_n
  // WR       -> OWM_wt_n
  // EN       -> 1'b0;
  // MR       -> Bus2IP_Reset
  // CLK      -> Bus2IP_Clk
  //
  // *************************************************************************************
  
  /*
     reg [31:0] debug;
  
     always @ (posedge OWM_wt_n or posedge Bus2IP_Reset)
  	begin
  
        if (Bus2IP_Reset)
  		begin
           debug <= 32'h00000000;
  		end
  
        else
  		begin
           debug <= {Bus2IP_CS,Bus2IP_RNW,OWM_rd_n,13'h0000,OWM_addr [7:0],OWM_wt_data [7:0]}
  		end
  
     end
  */
  
  
     assign IP2Bus_Data    = {32{OWM_rdwt_ack}} & {24'h000000, OWM_rd_data};
  // assign IP2Bus_Data    = {32{OWM_rdwt_ack}} & {16'hFEDC,IP2Bus_Ack,OWM_rdwt_cycle,Bus2IP_Reset,Bus2IP_CS,OWM_wt_n,OWM_rd_n,OWM_rd_data};
     assign IP2Bus_RdAck   = OWM_rdwt_ack & Bus2IP_CS & Bus2IP_RNW;
     assign IP2Bus_WrAck   = OWM_rdwt_ack & Bus2IP_CS & ~Bus2IP_RNW;

  assign IP2Bus_Error = 1'b0;

  //synthesis attribute clock_signal of OWM_wt_n IS no
  //synthesis attribute buffer_type of OWM_wt_n IS none
endmodule
