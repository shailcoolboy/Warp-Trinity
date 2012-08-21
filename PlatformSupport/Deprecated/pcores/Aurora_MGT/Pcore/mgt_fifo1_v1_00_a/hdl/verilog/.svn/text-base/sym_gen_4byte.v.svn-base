///////////////////////////////////////////////////////////////////////////////
//
//      Project:  Aurora Module Generator version 2.2
//
//         Date:  $Date: 2004/11/08 16:19:32 $
//          Tag:  $Name: i+H-38+78751 $
//         File:  $RCSfile: sym_gen_4byte.ejava,v $
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
//  SYM_GEN_4BYTE
//
//  Author: Nigel Gulstone
//          Xilinx - Embedded Networking System Engineering Group
//
//  Description: The SYM_GEN module is a symbol generator for 4-byte Aurora Lanes.
//               Its inputs request the transmission of specific symbols, and its
//               outputs drive the MGT interface to fulfill those requests.
//
//               All generation request inputs must be asserted exclusively
//               except for the GEN_K, GEN_R and GEN_A signals from the Global
//               Logic, and the GEN_PAD and TX_PE_DATA_V signals from TX_LL.
//
//               GEN_K, GEN_R and GEN_A can be asserted anytime, but they are
//               ignored when other signals are being asserted.  This allows the
//               idle generator in the Global Logic to run continuously without
//               feedback, but requires the TX_LL and Lane Init SM modules to
//               be quiescent during Channel Bonding and Verification.
//
//               The GEN_PAD signal is only valid while the TX_PE_DATA_V signal
//               is asserted.  This allows padding to be specified for the LSB
//               of the data transmission.  GEN_PAD must not be asserted when
//               TX_PE_DATA_V is not asserted - this will generate errors.
//
//

`timescale 1 ns / 10 ps

module SYM_GEN_4BYTE
(
    // TX_LL Interface
    GEN_SCP,
    GEN_ECP,
    GEN_PAD,
    TX_PE_DATA,
    TX_PE_DATA_V,
    GEN_CC,


    // Global Logic Interface
    GEN_A,
    GEN_K,
    GEN_R,
    GEN_V,


    // Lane Init SM Interface
    GEN_SP,
    GEN_SPA,


    // MGT Interface
    TX_CHAR_IS_K,
    TX_DATA,


    // System Interface
    USER_CLK
);
`define DLY #1

//***********************************Port Declarations*******************************


    // TX_LL Interface              // See description for info about GEN_PAD and TX_PE_DATA_V.
    input   [0:1]   GEN_SCP;        // Generate SCP.
    input   [0:1]   GEN_ECP;        // Generate ECP.
    input   [0:1]   GEN_PAD;        // Replace LSB with Pad character.
    input   [0:31]  TX_PE_DATA;     // Data.  Transmitted when TX_PE_DATA_V is asserted.
    input   [0:1]   TX_PE_DATA_V;   // Transmit data.
    input           GEN_CC;         // Generate Clock Correction symbols.


    // Global Logic Interface       // See description for info about GEN_K,GEN_R and GEN_A.
    input           GEN_A;          // Generate A character for MSBYTE
    input   [0:3]   GEN_K;          // Generate K character for selected bytes.
    input   [0:3]   GEN_R;          // Generate R character for selected bytes.
    input   [0:3]   GEN_V;          // Generate Ver data character on selected bytes.


    // Lane Init SM Interface
    input           GEN_SP;         // Generate SP pattern.
    input           GEN_SPA;        // Generate SPA pattern.


    // MGT Interface
    output  [3:0]   TX_CHAR_IS_K;   // Transmit TX_DATA as a control character.
    output  [31:0]  TX_DATA;        // Data to MGT for transmission to channel partner.


    // System Interface
    input           USER_CLK;       // Clock for all non-MGT Aurora Logic.



//**************************External Register Declarations****************************

    reg     [31:0]  TX_DATA;
    reg     [3:0]   TX_CHAR_IS_K;


//**************************Internal Register Declarations****************************

    // Slack registers.  These registers allow slack for routing delay and automatic retiming.
    reg     [0:1]   gen_scp_r;
    reg     [0:1]   gen_ecp_r;
    reg     [0:1]   gen_pad_r;
    reg     [0:31]  tx_pe_data_r;
    reg     [0:1]   tx_pe_data_v_r;
    reg             gen_cc_r;
    reg             gen_a_r;
    reg     [0:3]   gen_k_r;
    reg     [0:3]   gen_r_r;
    reg     [0:3]   gen_v_r;
    reg             gen_sp_r;
    reg             gen_spa_r;


//*********************************Wire Declarations**********************************

    wire    [0:3]   idle_c;

//*********************************Main Body of Code**********************************


    // Register all inputs with the slack registers.
    always @(posedge USER_CLK)
    begin
        gen_scp_r       <=  `DLY    GEN_SCP;
        gen_ecp_r       <=  `DLY    GEN_ECP;
        gen_pad_r       <=  `DLY    GEN_PAD;
        tx_pe_data_r    <=  `DLY    TX_PE_DATA;
        tx_pe_data_v_r  <=  `DLY    TX_PE_DATA_V;
        gen_cc_r        <=  `DLY    GEN_CC;
        gen_a_r         <=  `DLY    GEN_A;
        gen_k_r         <=  `DLY    GEN_K;
        gen_r_r         <=  `DLY    GEN_R;
        gen_v_r         <=  `DLY    GEN_V;
        gen_sp_r        <=  `DLY    GEN_SP;
        gen_spa_r       <=  `DLY    GEN_SPA;
    end



    //__________________________Byte 0_______________________________________________________

    // When none of the byte0 non_idle inputs are asserted, allow idle characters.
    assign  idle_c[0]   =   !(gen_scp_r[0]      |
                              gen_ecp_r[0]      |
                              tx_pe_data_v_r[0] |
                              gen_cc_r          |
                              gen_sp_r          |
                              gen_spa_r         |
                              gen_v_r[0]);



    // Generate data for byte0.  Note that all inputs must be asserted exclusively, except
    // for the GEN_A, GEN_K and GEN_R inputs which are ignored when other characters
    // are asserted.
    always @ (posedge USER_CLK)
    begin
        if(gen_scp_r[0])            TX_DATA[31:24] <= `DLY  8'h5c;             // K28.2(SCP)
        if(gen_ecp_r[0])            TX_DATA[31:24] <= `DLY  8'hfd;             // K29.7(ECP)
        if(tx_pe_data_v_r[0])       TX_DATA[31:24] <= `DLY  tx_pe_data_r[0:7]; // DATA
        if(gen_cc_r)                TX_DATA[31:24] <= `DLY  8'hf7;             // K23.7(CC)
        if(idle_c[0] & gen_a_r)     TX_DATA[31:24] <= `DLY  8'h7c;             // K28.3(A)
        if(idle_c[0] & gen_k_r[0])  TX_DATA[31:24] <= `DLY  8'hbc;             // K28.5(K)
        if(idle_c[0] & gen_r_r[0])  TX_DATA[31:24] <= `DLY  8'h1c;             // K28.0(R)
        if(gen_sp_r)                TX_DATA[31:24] <= `DLY  8'hbc;             // K28.5(K)
        if(gen_spa_r   )            TX_DATA[31:24] <= `DLY  8'hbc;             // K28.5(K)
        if(gen_v_r[0])              TX_DATA[31:24] <= `DLY  8'he8;             // D8.7(Ver data)
    end



    // Generate control signal for MSB.
    always @(posedge USER_CLK)
        TX_CHAR_IS_K[3] <=  `DLY    !(tx_pe_data_v_r[0] |
                                      gen_v_r[0]);


    //_______________________________Byte 1________________________________________

    // When none of the byte1 non_idle inputs are asserted, allow idle characters.  Note
    // that because gen_pad is only valid with the data valid signal, we only look at
    // the data valid signal.
    assign  idle_c[1]   =   !(gen_scp_r[0]      |
                              gen_ecp_r[0]      |
                              tx_pe_data_v_r[0] |
                              gen_cc_r          |
                              gen_sp_r          |
                              gen_spa_r         |
                              gen_v_r[1]);


    // Generate data for byte1.  Note that all inputs must be asserted exclusively except
    // for the GEN_PAD signal and the GEN_K and GEN_R set.  GEN_PAD can be asserted
    // at the same time as TX_DATA_VALID.  This will override TX_DATA valid and replace
    // the lsb user data with a PAD character.  The GEN_K and GEN_R inputs are
    // ignored if any other input is asserted.
    always @ (posedge USER_CLK)
    begin
        if(gen_scp_r[0])                      TX_DATA[23:16] <= `DLY 8'hfb;               // K27.7(SCP)
        if(gen_ecp_r[0])                      TX_DATA[23:16] <= `DLY 8'hfe;               // K30.7(ECP)
        if(tx_pe_data_v_r[0] & gen_pad_r[0])  TX_DATA[23:16] <= `DLY 8'h9c;               // K28.4(PAD)
        if(tx_pe_data_v_r[0] & !gen_pad_r[0]) TX_DATA[23:16] <= `DLY tx_pe_data_r[8:15];  // DATA
        if(gen_cc_r)                          TX_DATA[23:16] <= `DLY 8'hf7;               // K23.7(CC)
        if(idle_c[1] & gen_k_r[1])            TX_DATA[23:16] <= `DLY 8'hbc;               // K28.5(K)
        if(idle_c[1] & gen_r_r[1])            TX_DATA[23:16] <= `DLY 8'h1c;               // K28.0(R)
        if(gen_sp_r)                          TX_DATA[23:16] <= `DLY 8'h4a;               // D10.2(SP data)
        if(gen_spa_r)                         TX_DATA[23:16] <= `DLY 8'h2c;               // D12.1(SPA data)
        if(gen_v_r[1])                        TX_DATA[23:16] <= `DLY 8'he8;               // D8.7(Ver data)
    end


    // Generate control signal for byte1.
    always @(posedge USER_CLK)
        TX_CHAR_IS_K[2] <= `DLY !((tx_pe_data_v_r[0] && !gen_pad_r[0]) |
                                  gen_sp_r          |
                                  gen_spa_r         |
                                  gen_v_r[1]);


    //__________________________Byte 2_______________________________________________________

    // When none of the byte2 non_idle inputs are asserted, allow idle characters.
    assign  idle_c[2]   =   !(gen_scp_r[1]      |
                              gen_ecp_r[1]      |
                              tx_pe_data_v_r[1] |
                              gen_cc_r          |
                              gen_sp_r          |
                              gen_spa_r         |
                              gen_v_r[2]);



    // Generate data for byte2.  Note that all inputs must be asserted exclusively,
    // except for the GEN_K and GEN_R inputs which are ignored when other
    // characters are asserted.
    always @ (posedge USER_CLK)
    begin
        if(gen_scp_r[1])                TX_DATA[15:8] <= `DLY  8'h5c;             // K28.2(SCP)
        if(gen_ecp_r[1])                TX_DATA[15:8] <= `DLY  8'hfd;             // K29.7(ECP)
        if(tx_pe_data_v_r[1])           TX_DATA[15:8] <= `DLY  tx_pe_data_r[16:23]; // DATA
        if(gen_cc_r)                    TX_DATA[15:8] <= `DLY  8'hf7;             // K23.7(CC)
        if(idle_c[2] & gen_k_r[2])      TX_DATA[15:8] <= `DLY  8'hbc;             // K28.5(K)
        if(idle_c[2] & gen_r_r[2])      TX_DATA[15:8] <= `DLY  8'h1c;             // K28.0(R)
        if(gen_sp_r)                    TX_DATA[15:8] <= `DLY  8'h4a;             // D10.2(SP data)
        if(gen_spa_r)                   TX_DATA[15:8] <= `DLY  8'h2c;             // D12.1(SPA data)
        if(gen_v_r[2])                  TX_DATA[15:8] <= `DLY  8'he8;             // D8.7(Ver data)
    end



    // Generate control signal for MSB.
    always @(posedge USER_CLK)
        TX_CHAR_IS_K[1] <=  `DLY    !(tx_pe_data_v_r[1] |
                                      gen_sp_r          |
                                      gen_spa_r         |
                                      gen_v_r[2]);


    //_______________________________Byte 3________________________________________

    // When none of the byte3 non_idle inputs are asserted, allow idle characters.
    // Note that because gen_pad is only valid with the data valid signal, we only
    // look at the data valid signal.
    assign  idle_c[3]   =   !(gen_scp_r[1]      |
                              gen_ecp_r[1]      |
                              tx_pe_data_v_r[1] |
                              gen_cc_r          |
                              gen_sp_r          |
                              gen_spa_r         |
                              gen_v_r[3]);



    // Generate data for byte3.  Note that all inputs must be asserted exclusively
    // except for the GEN_PAD signal and the GEN_K and GEN_R set.  GEN_PAD
    // can be asserted at the same time as TX_DATA_VALID.  This will override
    // TX_DATA valid and replace the lsb user data with a PAD character.  The GEN_K
    // and GEN_R inputs are ignored if any other input is asserted.
    always @ (posedge USER_CLK)
    begin
        if(gen_scp_r[1])                      TX_DATA[7:0]  <= `DLY 8'hfb;               // K27.7(SCP)
        if(gen_ecp_r[1])                      TX_DATA[7:0]  <= `DLY 8'hfe;               // K30.7(ECP)
        if(tx_pe_data_v_r[1] & gen_pad_r[1])  TX_DATA[7:0]  <= `DLY 8'h9c;               // K28.4(PAD)
        if(tx_pe_data_v_r[1] & !gen_pad_r[1]) TX_DATA[7:0]  <= `DLY tx_pe_data_r[24:31]; // DATA
        if(gen_cc_r)                          TX_DATA[7:0]  <= `DLY 8'hf7;               // K23.7(CC)
        if(idle_c[3] & gen_k_r[3])            TX_DATA[7:0]  <= `DLY 8'hbc;               // K28.5(K)
        if(idle_c[3] & gen_r_r[3])            TX_DATA[7:0]  <= `DLY 8'h1c;               // K28.0(R)
        if(gen_sp_r)                          TX_DATA[7:0]  <= `DLY 8'h4a;               // D10.2(SP data)
        if(gen_spa_r)                         TX_DATA[7:0]  <= `DLY 8'h2c;               // D12.1(SPA data)
        if(gen_v_r[3])                        TX_DATA[7:0]  <= `DLY 8'he8;               // D8.7(Ver data)
    end



    // Generate control signal for byte3.
    always @(posedge USER_CLK)
        TX_CHAR_IS_K[0] <= `DLY !((tx_pe_data_v_r[1] && !gen_pad_r[1]) |
                                   gen_sp_r          |
                                   gen_spa_r         |
                                   gen_v_r[3]);

endmodule
