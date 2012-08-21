//--------------------------------------------------------------------------------------------
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 1.0
//  \   \         Application : NULL MGT Tile 
//  /   /         Filename : null_pair_example.v
// /___/   /\     Date : 10/07/2005
// \   \  /  \ 
//  \___\/\___\ 
// 
// 
//   Disclaimer:  XILINX IS PROVIDING THIS DESIGN, CODE, OR
//                INFORMATION "AS IS" SOLELY FOR USE IN DEVELOPING
//                PROGRAMS AND SOLUTIONS FOR XILINX DEVICES.  BY
//                PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
//                ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,
//                APPLICATION OR STANDARD, XILINX IS MAKING NO
//                REPRESENTATION THAT THIS IMPLEMENTATION IS FREE
//                FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE
//                RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY
//                REQUIRE FOR YOUR IMPLEMENTATION.  XILINX
//                EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH
//                RESPECT TO THE ADEQUACY OF THE IMPLEMENTATION,
//                INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR
//                REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE
//                FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES
//                OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
//                PURPOSE.
//
//                (c) Copyright 2004 Xilinx, Inc.
//                All rights reserved.
// 

`timescale  1 ns / 1 ps

module null_pair_example
  (
     clk,
     rx1n,
     rx1p,
     tx1n,
     tx1p
  );

  input clk;
  input [1:0] rx1n;
  input [1:0] rx1p;
  output [1:0] tx1n;
  output [1:0] tx1p;

  //-----------------------------------------------------------------
  //
  //  NULL_PAIR wire declarations
  //
  //-----------------------------------------------------------------
  wire       clk;
  wire [1:0] rx1n;
  wire [1:0] rx1p;
  wire [1:0] tx1n;
  wire [1:0] tx1p;
  wire       global_sig;


  //-----------------------------------------------------------------
  //
  //  NULL_PAIR core instance
  //
  //-----------------------------------------------------------------
  NULL_PAIR null_pair_inst
  (  
     .GREFCLK_IN  (global_sig),
     .RX1N_IN     (rx1n),
     .RX1P_IN     (rx1p),
     .TX1N_OUT    (tx1n), 
     .TX1P_OUT    (tx1p)
  );

  
  //-----------------------------------------------------------------
  //
  //  GREFCLK_IN port needs to be driven with any global signal
  //  (any BUFG output, even a BUFG with ground for input will work).
  //
  //-----------------------------------------------------------------
  BUFG global_sig_i
  (
     .I           (clk),
     .O           (global_sig)
  );

endmodule


//-------------------------------------------------------------------
//
//  NULL_PAIR core module declaration
//
//-------------------------------------------------------------------
module NULL_PAIR(
             GREFCLK_IN,
             RX1N_IN,
             RX1P_IN,
             TX1N_OUT,
             TX1P_OUT);


input        GREFCLK_IN;
input  [1:0] RX1N_IN;
input  [1:0] RX1P_IN;
output [1:0] TX1N_OUT;
output [1:0] TX1P_OUT;

endmodule

