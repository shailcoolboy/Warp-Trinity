///////////////////////////////////////////////////////////////////////////////
//
//      Project:  Aurora Module Generator version 2.2
//
//         Date:  $Date: 2004/11/08 16:19:22 $
//          Tag:  $Name: i+H-38+78751 $
//         File:  $RCSfile: aurora_lane_4byte.ejava,v $
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
//  AURORA_LANE_4BYTE
//
//  Author: Nigel Gulstone
//          Xilinx - Embedded Networking System Engineering Group
//
//  Description: the AURORA_LANE_4BYTE module provides a full duplex 4-byte aurora lane
//               connection using a single MGT.  The module handles lane initialization,
//               symbol generation and decoding and error detection.  It also decodes
//               some of the channel bonding indicator signals needed by the Global
//               logic.
//
//               * Supports Virtex 2 Pro
//

`timescale 1 ns / 10 ps

module AURORA_LANE_4BYTE
(
    // MGT Interface
    RX_DATA,
    RX_NOT_IN_TABLE,
    RX_DISP_ERR,
    RX_CHAR_IS_K,
    RX_CHAR_IS_COMMA,
    RX_BUF_STATUS,
    TX_BUF_ERR,
    TX_K_ERR,
    RX_CLK_COR_CNT,
    RX_REALIGN,

    RX_POLARITY,
    RX_RESET,
    TX_CHAR_IS_K,
    TX_DATA,
    TX_RESET,


    // Comma Detect Phase Align Interface
    ENA_COMMA_ALIGN,


    // TX_LL Interface
    GEN_SCP,
    GEN_ECP,
    GEN_PAD,
    TX_PE_DATA,
    TX_PE_DATA_V,
    GEN_CC,


    // RX_LL Interface
    RX_PAD,
    RX_PE_DATA,
    RX_PE_DATA_V,
    RX_SCP,
    RX_ECP,


    // Global Logic Interface
    GEN_A,
    GEN_K,
    GEN_R,
    GEN_V,

    LANE_UP,
    SOFT_ERROR,
    HARD_ERROR,
    CHANNEL_BOND_LOAD,
    GOT_A,
    GOT_V,


    // System Interface
    USER_CLK,
    RESET

);

//***********************************Port Declarations*******************************


    // MGT Interface
    input   [31:0]  RX_DATA;                // 4-byte data bus from the MGT.
    input   [3:0]   RX_NOT_IN_TABLE;        // Invalid 10-bit code was recieved.
    input   [3:0]   RX_DISP_ERR;            // Disparity error detected on RX interface.
    input   [3:0]   RX_CHAR_IS_K;           // Indicates which bytes of RX_DATA are control.
    input   [3:0]   RX_CHAR_IS_COMMA;       // Comma received on given byte.
    input           RX_BUF_STATUS;          // Overflow/Underflow of RX buffer detected.
    input           TX_BUF_ERR;             // Overflow/Underflow of TX buffer detected.
    input   [3:0]   TX_K_ERR;               // Attempt to send bad control byte detected.
    input   [2:0]   RX_CLK_COR_CNT;         // Value used to determine channel bonding status.
    input           RX_REALIGN;             // SERDES was realigned because of a new comma.

    output          RX_POLARITY;            // Controls interpreted polarity of serial data inputs.
    output          RX_RESET;               // Reset RX side of MGT logic.
    output  [3:0]   TX_CHAR_IS_K;           // TX_DATA byte is a control character.
    output  [31:0]  TX_DATA;                // 4-byte data bus to the MGT.
    output          TX_RESET;               // Reset TX side of MGT logic.


    // Comma Detect Phase Align Interface
    output          ENA_COMMA_ALIGN;        // Request comma alignment.


    // TX_LL Interface
    input   [0:1]   GEN_SCP;                // SCP generation request from TX_LL.
    input   [0:1]   GEN_ECP;                // ECP generation request from TX_LL.
    input   [0:1]   GEN_PAD;                // PAD generation request from TX_LL.
    input   [0:31]  TX_PE_DATA;             // Data from TX_LL to send over lane.
    input   [0:1]   TX_PE_DATA_V;           // Indicates TX_PE_DATA is Valid.
    input           GEN_CC;                 // CC generation request from TX_LL.


    // RX_LL Interface
    output  [0:1]   RX_PAD;                 // Indicates lane received PAD.
    output  [0:31]  RX_PE_DATA;             // RX data from lane to RX_LL.
    output  [0:1]   RX_PE_DATA_V;           // RX_PE_DATA is data, not control symbol.
    output  [0:1]   RX_SCP;                 // Indicates lane received SCP.
    output  [0:1]   RX_ECP;                 // Indicates lane received ECP.


    // Global Logic Interface
    input           GEN_A;                  // 'A character' generation request from Global Logic.
    input   [0:3]   GEN_K;                  // 'K character' generation request from Global Logic.
    input   [0:3]   GEN_R;                  // 'R character' generation request from Global Logic.
    input   [0:3]   GEN_V;                  // Verification data generation request.
    output          LANE_UP;                // Lane is ready for bonding and verification.
    output  [0:1]   SOFT_ERROR;             // Soft error detected.
    output          HARD_ERROR;             // Hard error detected.
    output          CHANNEL_BOND_LOAD;      // Channel Bongding done code recieved.
    output  [0:3]   GOT_A;                  // Indicates lane recieved 'A character' bytes.
    output          GOT_V;                  // Verification symbols received.


    // System Interface
    input           USER_CLK;               // System clock for all non-MGT Aurora Logic.
    input           RESET;                  // Reset the lane.



//*********************************Wire Declarations**********************************

    wire            ena_comma_align_i;
    wire            gen_sp_i;
    wire            gen_spa_i;
    wire            rx_sp_i;
    wire            rx_spa_i;
    wire            rx_neg_i;
    wire            enable_error_detect_i;
    wire            do_word_align_i;
    wire            hard_error_reset_i;


//*********************************Main Body of Code**********************************


    // Lane Initialization state machine
    LANE_INIT_SM_4BYTE lane_init_sm_4byte_i
    (
        // MGT Interface
        .RX_NOT_IN_TABLE(RX_NOT_IN_TABLE),
        .RX_DISP_ERR(RX_DISP_ERR),
        .RX_CHAR_IS_COMMA(RX_CHAR_IS_COMMA),
        .RX_REALIGN(RX_REALIGN),

        .RX_RESET(RX_RESET),
        .TX_RESET(TX_RESET),
        .RX_POLARITY(RX_POLARITY),


        // Comma Detect Phase Alignment Interface
        .ENA_COMMA_ALIGN(ENA_COMMA_ALIGN),


        // Symbol Generator Interface
        .GEN_SP(gen_sp_i),
        .GEN_SPA(gen_spa_i),


        // Symbol Decoder Interface
        .RX_SP(rx_sp_i),
        .RX_SPA(rx_spa_i),
        .RX_NEG(rx_neg_i),

        .DO_WORD_ALIGN(do_word_align_i),

        // Error Detection Logic Interface
        .HARD_ERROR_RESET(hard_error_reset_i),

        .ENABLE_ERROR_DETECT(enable_error_detect_i),


        // Global Logic Interface
        .LANE_UP(LANE_UP),


        // System Interface
        .USER_CLK(USER_CLK),
        .RESET(RESET)

    );



    // Channel Bonding Count Decode module
    CHBOND_COUNT_DEC_4BYTE chbond_count_dec_4byte_i
    (
        .RX_CLK_COR_CNT(RX_CLK_COR_CNT),
        .CHANNEL_BOND_LOAD(CHANNEL_BOND_LOAD),
        .USER_CLK(USER_CLK)
    );


    // Symbol Generation module
    SYM_GEN_4BYTE sym_gen_4byte_i
    (
        // TX_LL Interface
        .GEN_SCP(GEN_SCP),
        .GEN_ECP(GEN_ECP),
        .GEN_PAD(GEN_PAD),
        .TX_PE_DATA(TX_PE_DATA),
        .TX_PE_DATA_V(TX_PE_DATA_V),
        .GEN_CC(GEN_CC),


        // Global Logic Interface
        .GEN_A(GEN_A),
        .GEN_K(GEN_K),
        .GEN_R(GEN_R),
        .GEN_V(GEN_V),


        // Lane Init SM Interface
        .GEN_SP(gen_sp_i),
        .GEN_SPA(gen_spa_i),


        // MGT Interface
        .TX_CHAR_IS_K(TX_CHAR_IS_K),
        .TX_DATA(TX_DATA),


        // System Interface
        .USER_CLK(USER_CLK)
    );


    // Symbol Decode module
    SYM_DEC_4BYTE sym_dec_4byte_i
    (
        // RX_LL Interface
        .RX_PAD(RX_PAD),
        .RX_PE_DATA(RX_PE_DATA),
        .RX_PE_DATA_V(RX_PE_DATA_V),
        .RX_SCP(RX_SCP),
        .RX_ECP(RX_ECP),


        // Lane Init SM Interface
        .DO_WORD_ALIGN(do_word_align_i),
        .LANE_UP(LANE_UP),
        .RX_SP(rx_sp_i),
        .RX_SPA(rx_spa_i),
        .RX_NEG(rx_neg_i),


        // Global Logic Interface
        .GOT_A(GOT_A),
        .GOT_V(GOT_V),


        // MGT Interface
        .RX_DATA(RX_DATA),
        .RX_CHAR_IS_K(RX_CHAR_IS_K),
        .RX_CHAR_IS_COMMA(RX_CHAR_IS_COMMA),


        // System Interface
        .USER_CLK(USER_CLK),
        .RESET(RESET)
    );


    // Error Detection module
    ERROR_DETECT_4BYTE error_detect_4byte_i
    (
        // Lane Init SM Interface
        .ENABLE_ERROR_DETECT(enable_error_detect_i),

        .HARD_ERROR_RESET(hard_error_reset_i),


        // Global Logic Interface
        .SOFT_ERROR(SOFT_ERROR),
        .HARD_ERROR(HARD_ERROR),


        // MGT Interface
        .RX_DISP_ERR(RX_DISP_ERR),
        .TX_K_ERR(TX_K_ERR),
        .RX_NOT_IN_TABLE(RX_NOT_IN_TABLE),
        .RX_BUF_STATUS(RX_BUF_STATUS),
        .TX_BUF_ERR(TX_BUF_ERR),
        .RX_REALIGN(RX_REALIGN),


        // System Interface
        .USER_CLK(USER_CLK)
    );

endmodule
