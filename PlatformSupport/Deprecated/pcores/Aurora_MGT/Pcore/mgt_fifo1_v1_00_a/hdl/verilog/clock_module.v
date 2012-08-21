///////////////////////////////////////////////////////////////////////////////
//
//      Project:  Aurora Module Generator version 2.2
//
//         Date:  $Date: 2004/11/08 16:19:25 $
//          Tag:  $Name: i+H-38+78751 $
//         File:  $RCSfile: clock_module.ejava,v $
//          Rev:  $Revision: 1.1.6.2 $
//
//      Company:  Xilinx
// Contributors:  R. K. Awalt, B. L. Woodard, N. Gulstone
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
///////////////////////////////////////////////////////////////////////////////
//
//  CLOCK_MODULE
//
//  Author: Nigel Gulstone
//          Xilinx - Embedded Networking System Engineering Group
//
//  Description: A module provided as a convenience for desingners using 4-byte
//               lane Aurora Modules. This module takes the MGT reference clock as
//               input, and produces a divided clock on a global clock net suitable
//               for driving application logic connected to the Aurora User Interface.
//

`timescale 1 ns / 10 ps

module CLOCK_MODULE
(
    MGT_REFERENCE_CLOCK,

    USER_CLK,
    USER_CLK_2X_N,
    DCM_NOT_LOCKED

);

`define DLY #1


//***********************************Port Declarations*******************************

    input       MGT_REFERENCE_CLOCK;

    output      USER_CLK;
    output      USER_CLK_2X_N;
    output      DCM_NOT_LOCKED;

//*********************************Wire Declarations**********************************

    wire    [15:0]  not_connected_i;
    wire            clkfb_i;
    wire            clkdv_i;
    wire            clk0_i;
    wire            locked_i;




//*********************************Main Body of Code**********************************



    // Instantiate a DCM module to divide the reference clock.
    DCM  clock_divider_i
    (
        .CLK0(clk0_i),
        .CLK180(not_connected_i[0]),
        .CLK270(not_connected_i[1]),
        .CLK2X(not_connected_i[2]),
        .CLK2X180(not_connected_i[3]),
        .CLK90(not_connected_i[4]),
        .CLKDV(clkdv_i),
        .CLKFX(not_connected_i[5]),
        .CLKFX180(not_connected_i[6]),
        .LOCKED(locked_i),
        .PSDONE(not_connected_i[7]),
        .STATUS(not_connected_i[15:8]),
        .CLKFB(clkfb_i),
        .CLKIN(MGT_REFERENCE_CLOCK),
        .DSSEN(1'b0),
        .PSCLK(1'b0),
        .PSEN(1'b0),
        .PSINCDEC(1'b0),
        .RST(1'b0)
    );



    // BUFG for the feedback clock.  The feedback signal is phase aligned to the input
    // and must come from the CLK0 or CLK2X output of the DCM.  In this case, we use
    // the CLK0 output.
    BUFG feedback_clock_net_i
    (
        .I(clk0_i),
        .O(clkfb_i)
    );


    // We invert the feedback clock to get USER_CLK_2X_N.
    INV  user_clk_2x_inverter_i
    (
        .I(clkfb_i),
        .O(USER_CLK_2X_N)
    );


    // The User Clock is distributed on a global clock net.
    BUFG user_clk_net_i
    (
        .I(clkdv_i),
        .O(USER_CLK)
    );


    // The DCM_NOT_LOCKED signal is created by inverting the DCM's locked signal.
    assign  DCM_NOT_LOCKED  =   ~locked_i;

endmodule
