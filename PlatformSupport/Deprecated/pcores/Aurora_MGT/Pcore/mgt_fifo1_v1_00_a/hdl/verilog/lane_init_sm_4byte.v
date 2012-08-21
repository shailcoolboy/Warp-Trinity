///////////////////////////////////////////////////////////////////////////////
//
//      Project:  Aurora Module Generator version 2.2
//
//         Date:  $Date: 2004/11/08 16:19:26 $
//          Tag:  $Name: i+H-38+78751 $
//         File:  $RCSfile: lane_init_sm_4byte.ejava,v $
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
//  LANE_INIT_SM_4BYTE
//
//  Author: Nigel Gulstone
//          Xilinx - Embedded Networking System Engineering Group
//
//  Description: This logic manages the initialization of the MGT in 2-byte mode.
//               It consists of a small state machine, a set of counters for
//               tracking the progress of initializtion and detecting problems,
//               and some additional support logic.
//

`timescale 1 ns / 10 ps

module LANE_INIT_SM_4BYTE
(
    // MGT Interface
    RX_NOT_IN_TABLE,
    RX_DISP_ERR,
    RX_CHAR_IS_COMMA,
    RX_REALIGN,

    RX_RESET,
    TX_RESET,
    RX_POLARITY,


    // Comma Detect Phase Alignment Interface
    ENA_COMMA_ALIGN,


    // Symbol Generator Interface
    GEN_SP,
    GEN_SPA,


    // Symbol Decoder Interface
    RX_SP,
    RX_SPA,
    RX_NEG,

    DO_WORD_ALIGN,


    // Error Detection Logic Interface
    ENABLE_ERROR_DETECT,
    HARD_ERROR_RESET,


    // Global Logic Interface
    LANE_UP,


    // System Interface
    USER_CLK,
    RESET

);

`define DLY #1

//***********************************Port Declarations*******************************

    // MGT Interface
    input   [3:0]   RX_NOT_IN_TABLE;     // MGT received invalid 10b code
    input   [3:0]   RX_DISP_ERR;         // MGT received 10b code w/ wrong disparity
    input   [3:0]   RX_CHAR_IS_COMMA;    // MGT received a Comma
    input           RX_REALIGN;          // MGT had to change alignment due to new comma

    output          RX_RESET;            // Reset the RX side of the MGT
    output          TX_RESET;            // Reset the TX side of the MGT
    output          RX_POLARITY;         // Sets polarity used to interpet rx'ed symbols


    // Comma Detect Phase Alignment Interface
    output          ENA_COMMA_ALIGN;     // Turn on SERDES Alignment in MGT


    // Symbol Generator Interface
    output          GEN_SP;              // Generate SP symbol
    output          GEN_SPA;             // Generate SPA symbol


    // Symbol Decoder Interface
    input           RX_SP;               // Lane rx'ed SP sequence w/ + or - data
    input           RX_SPA;              // Lane rx'ed SPA sequence
    input           RX_NEG;              // Lane rx'ed inverted SP or SPA data

    output          DO_WORD_ALIGN;       // Enable word alignment


    // Error Detection Logic Interface
    input           HARD_ERROR_RESET;    // Reset lane due to hard error

    output          ENABLE_ERROR_DETECT; // Turn on Soft Error detection



    // Global Logic Interface
    output          LANE_UP;             // Lane is initialized


    // System Interface
    input           USER_CLK;            // Clock for all non-MGT Aurora logic
    input           RESET;               // Reset Aurora Lane


//**************************External Register Declarations****************************

    reg             ENABLE_ERROR_DETECT;


//**************************Internal Register Declarations****************************

    reg     [0:7]   counter1_r;
    reg     [0:15]  counter2_r;
    reg     [0:3]   counter3_r;
    reg     [0:15]  counter4_r;
    reg     [0:15]  counter5_r;
    reg             rx_polarity_r;
    reg             prev_char_was_comma_r;
    reg             consecutive_commas_r;
    reg             prev_count_128d_done_r;
    reg             do_watchdog_count_r;


    // FSM states, encoded for one-hot implementation.
    reg             rst_r;          // Reset MGTs
    reg             align_r;        // Align SERDES
    reg             realign_r;      // Verify no spurious realignment
    reg             polarity_r;     // Verify polarity of rx'ed symbols
    reg             ack_r;          // Ack initialization with partner
    reg             ready_r;        // Lane ready for Bonding/Verification



//*********************************Wire Declarations**********************************

    wire            count_8d_done_r;
    wire            count_32d_done_r;
    wire            count_128d_done_r;
    wire            reset_count_c;
    wire            symbol_error_c;
    wire            txack_16d_done_r;
    wire            rxack_4d_done_r;
    wire            sp_polarity_c;
    wire            inc_count_c;
    wire            change_in_state_c;
    wire            watchdog_done_r;
    wire            remote_reset_watchdog_done_r;

    wire            next_rst_c;
    wire            next_align_c;
    wire            next_realign_c;
    wire            next_polarity_c;
    wire            next_ack_c;
    wire            next_ready_c;


//*********************************Main Body of Code**********************************



    //________________Main state machine for managing initialization________________


    // State registers
    always @(posedge USER_CLK)
        if(RESET|HARD_ERROR_RESET)
            {rst_r,align_r,realign_r,polarity_r,ack_r,ready_r}  <=  `DLY    6'b100000;
        else
        begin
            rst_r       <=  `DLY    next_rst_c;
            align_r     <=  `DLY    next_align_c;
            realign_r   <=  `DLY    next_realign_c;
            polarity_r  <=  `DLY    next_polarity_c;
            ack_r       <=  `DLY    next_ack_c;
            ready_r     <=  `DLY    next_ready_c;
        end



    // Next state logic
    assign  next_rst_c      =   (rst_r & !count_8d_done_r)|
                                (realign_r & RX_REALIGN)  |
                                (polarity_r & !sp_polarity_c)|
                                (ack_r & watchdog_done_r)|
                                (ready_r & remote_reset_watchdog_done_r);


    assign  next_align_c    =   (rst_r & count_8d_done_r)|
                                (align_r & !count_128d_done_r);


    assign  next_realign_c  =   (align_r & count_128d_done_r)|
                                (realign_r & !count_32d_done_r & !RX_REALIGN);

    assign  next_polarity_c =   (realign_r & count_32d_done_r & !RX_REALIGN);


    assign  next_ack_c      =   (polarity_r & sp_polarity_c)|
                                (ack_r & (!txack_16d_done_r|!rxack_4d_done_r) & !watchdog_done_r);


    assign  next_ready_c    =   (ack_r & txack_16d_done_r & rxack_4d_done_r & !watchdog_done_r)|
                                (ready_r & !remote_reset_watchdog_done_r);


    // Output Logic

    // Enable comma align when in the ALIGN state.
    assign  ENA_COMMA_ALIGN =   align_r;



    // Hold RX_RESET when in the RST state.
    assign  RX_RESET        =   rst_r;



    // Hold TX_RESET when in the RST state.
    assign  TX_RESET        =   rst_r;



    // LANE_UP is asserted when in the READY state.
    assign  LANE_UP         =   ready_r;



    // ENABLE_ERROR_DETECT is asserted when in the ACK or READY states. Asserting
    // it earlier will result in too many false errors. After it is asserted,
    // higher level modules can respond to Hard Errors by resetting the Aurora Lane.
    // We register the signal before it leaves the lane_init_sm submodule.
    always @(posedge USER_CLK)
        ENABLE_ERROR_DETECT <=  `DLY    ack_r | ready_r;



    // The Aurora Lane should transmit SP sequences when not ACKing or Ready.
    assign  GEN_SP   =   !(ack_r | ready_r);



    // The Aurora Lane transmits SPA sequences while in the ACK state.
    assign  GEN_SPA  =   ack_r;


    // Do word alignment in the ALIGN state and then again in the ready state.  Align
    // state word alignment makes SP and SPA decodes less expensive.  Ready state word
    // alignment is needed to correct any shifts due to channel bonding : it runs
    // until it is shut off by arrival of the first /V/ sequence in the sym_dec module.
    assign  DO_WORD_ALIGN   =   align_r || ready_r;



    //_________Counter 1, for reset cycles, align cycles and realign cycles____________


    // Core of the counter.
    always @(posedge USER_CLK)
        if(reset_count_c)           counter1_r   <=  `DLY    8'd1;
        else if(inc_count_c)        counter1_r   <=  `DLY    counter1_r + 8'd1;


    // Assert count_8d_done_r when the 2^4 flop in the register first goes high.
    assign  count_8d_done_r     =   counter1_r[4];


    // Assert count_32d_done_r when the 2^6 flop in the register first goes high.
    assign  count_32d_done_r    =   counter1_r[2];


    // Assert count_128d_done_r when the 2^8 flop in the register first goes high.
    assign  count_128d_done_r   =   counter1_r[0];


    // The counter resets any time the RESET signal is asserted, there is a change in
    // state, there is a symbol error, or commas are not consecutive in the align state.
    assign  reset_count_c = RESET | change_in_state_c | symbol_error_c |!consecutive_commas_r;



    // The counter should be reset when entering and leaving the reset state.
    assign  change_in_state_c   =   rst_r != next_rst_c;



    // Symbol error is asserted whenever there is a disparity error or an invalid
    // 10b code.
    assign  symbol_error_c  =   (RX_DISP_ERR != 4'h0) | (RX_NOT_IN_TABLE != 4'h0);



    // Previous cycle comma is used to check for consecutive commas.
    always @(posedge USER_CLK)
        prev_char_was_comma_r <=  `DLY    (RX_CHAR_IS_COMMA != 4'h0);


    // Check to see that commas are consecutive in the align state.
    always @(posedge USER_CLK)
        consecutive_commas_r <= `DLY   (RX_CHAR_IS_COMMA != 4'h0) | !align_r;


    // Increment count is always asserted, except in the ALIGN state when it is asserted
    // only upon the arrival of a comma character.
    assign  inc_count_c =   !align_r | (align_r & (RX_CHAR_IS_COMMA != 4'h0));




    //__________________________Counter 2, for counting tx_acks _______________________


    // This counter is implemented as a shift register.  It is constantly shifting.  As a
    // result, when the state machine is not in the ack state, the register clears out.
    // When the state machine goes into the ack state, the count is incremented every
    // cycle.  The txack_16d_done signal goes high and stays high after 16 cycles in the
    // ack state.  The signal deasserts only after its had enough time for all the ones
    // to clear out after the machine leaves the ack state, but this is tolerable because
    // the machine will spend at least 8 cycles in reset, 256 in ALIGN and 32 in REALIGN.
    //
    // The counter is implemented seperately from the main counter because it is required
    // to stop counting when it reaches the end of its count.  Adding this functionality
    // to the main counter is more expensive and more complex than implementing it seperately.

    // Counter Logic
    always @(posedge USER_CLK)
        counter2_r  <=  `DLY    {ack_r,counter2_r[0:14]};



    // The counter is done when a 1 reaches the end of the shift register.
    assign txack_16d_done_r = counter2_r[15];



    //__________________________Counter 3, for counting rx_acks _______________________


    // This counter is also implemented as a shift register.  It is always shifting when
    // the state machine is not in the ack state to clear it out.  When the state machine
    // goes into the ack state, the register shifts only when a SPA is received.  When
    // 4 SPAs have been received in the ACK state, the rxack_4d_done_r signal is triggered.
    //
    // This counter is implemented seperately from the main counter because it is required
    // to increment only when ACKs are received, and then hold its count.  Adding this
    // functionality to the main counter is more expensive than creating a second counter,
    // and more complex.

    // Counter Logic
    always @(posedge USER_CLK)
        if(RX_SPA|!ack_r)   counter3_r  <=  `DLY    {ack_r,counter3_r[0:2]};



    // The counter is done when a 1 reaches the end of the shift register.
    assign rxack_4d_done_r = counter3_r[3];



    //_____________________Counter 4, remote reset watchdog timer __________________


    // Another counter implemented as a shift register.  This counter puts an upper
    // limit on the number of SPs that can be recieved in the Ready state.  If the
    // number of SPs exceeds the limit, the Aurora Lane resets itself.  The Global
    // logic module will reset all the lanes if this occurs while they are all in
    // the lane ready state (ie lane_up is asserted for all).



    // Counter logic
    always @(posedge USER_CLK)
        if(RX_SP|!ready_r)  counter4_r  <=  `DLY    {ready_r,counter4_r[0:14]};



    // The counter is done when a 1 reaches the end of the shift register.
    assign remote_reset_watchdog_done_r = counter4_r[15];



    //__________________________Counter 5, internal watchdog timer __________________


    // This counter puts an upper limit on the number of cycles the state machine can
    // spend in the ack state before it gives up and resets.
    //
    // The counter is implemented as a shift register extending counter 1.  The counter
    // clears out in all non-ack cycles by keeping CE asserted.  When it gets into the
    // ack state, CE is asserted only when there is a transition on the most
    // significant bit of counter 1.  This happens every 128 cycles.  We count out 32 of
    // these transitions to get a count of approximately 4096 cycles.  The actual
    // number of cycles is less than this because we don't reset counter1, so it
    // starts off about 34 cycles into its count.



    // Counter logic
    always @(posedge USER_CLK)
        if(do_watchdog_count_r|!ack_r)  counter5_r  <=  `DLY    {ack_r,counter5_r[0:14]};



    // Store the count_128d_done_r result from the previous cycle.
    always @(posedge USER_CLK)
        prev_count_128d_done_r  <=  `DLY    count_128d_done_r;



    // Trigger CE only when the previous 128d_done is not the same as the
    // current one, and the current value is high.
    always @(posedge USER_CLK)
        do_watchdog_count_r <=  `DLY    count_128d_done_r & !prev_count_128d_done_r;



    // The counter is done when bit 15 is high.
    assign watchdog_done_r = counter5_r[15];



    //___________________________Polarity Control_____________________________


    // sp_polarity_c, is low if neg symbols received, otherwise high.
    assign  sp_polarity_c   =   !RX_NEG;



    // The Polarity flop drives the polarity setting of the MGT. We initialize it for the
    // sake of simulation.  We Initialize it after configuration for the hardware version.
    initial
        rx_polarity_r <=  1'b0;

    always @(posedge USER_CLK)
        if(polarity_r & !sp_polarity_c)  rx_polarity_r <=  `DLY    ~rx_polarity_r;



    // Drive the rx_polarity register value on the interface.
    assign  RX_POLARITY =   rx_polarity_r;

endmodule
