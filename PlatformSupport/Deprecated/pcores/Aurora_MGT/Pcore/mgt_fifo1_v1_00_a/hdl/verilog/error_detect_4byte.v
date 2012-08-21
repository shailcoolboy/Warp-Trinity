///////////////////////////////////////////////////////////////////////////////
//
//      Project:  Aurora Module Generator version 2.2
//
//         Date:  $Date: 2004/11/08 16:19:25 $
//          Tag:  $Name: i+H-38+78751 $
//         File:  $RCSfile: error_detect_4byte.ejava,v $
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
//  ERROR_DETECT_4BYTE
//
//  Author: Nigel Gulstone
//          Xilinx - Embedded Networking System Engineering Group
//
//  Description : The ERROR_DETECT module monitors the MGT to detect hard errors.
//                It accumulates the Soft errors according to the leaky bucket
//                algorithm described in the Aurora Specification to detect Hard
//                errors.  All errors are reported to the Global Logic Interface.
//

`timescale 1 ns / 10 ps

module ERROR_DETECT_4BYTE
(
    // Lane Init SM Interface
    ENABLE_ERROR_DETECT,

    HARD_ERROR_RESET,


    // Global Logic Interface
    SOFT_ERROR,
    HARD_ERROR,


    // MGT Interface
    RX_DISP_ERR,
    TX_K_ERR,
    RX_NOT_IN_TABLE,
    RX_BUF_STATUS,
    TX_BUF_ERR,
    RX_REALIGN,


    // System Interface
    USER_CLK

);

// for test
`define DLY #1

//***********************************Port Declarations*******************************

    // Lane Init SM Interface
    input           ENABLE_ERROR_DETECT;

    output          HARD_ERROR_RESET;


    // Global Logic Interface
    output  [0:1]   SOFT_ERROR;
    output          HARD_ERROR;


    // MGT Interface
    input   [3:0]   RX_DISP_ERR;
    input   [3:0]   TX_K_ERR;
    input   [3:0]   RX_NOT_IN_TABLE;
    input           RX_BUF_STATUS;
    input           TX_BUF_ERR;
    input           RX_REALIGN;


    // System Interface
    input           USER_CLK;



//**************************External Register Declarations****************************

    reg     [0:1]   SOFT_ERROR;
    reg             HARD_ERROR;


//**************************Internal Register Declarations****************************

    reg     [0:1]   count_0_r;
    reg     [0:1]   count_1_r;
    reg             bucket_full_0_r;
    reg             bucket_full_1_r;
    reg     [0:3]   soft_error_r;
    reg     [0:1]   good_count_0_r;
    reg     [0:1]   good_count_1_r;

//*********************************Wire Declarations**********************************


//*********************************Main Body of Code**********************************


    // Detect Soft Errors.  The lane is divided into 2 2-byte sublanes for this purpose.
    always @(posedge USER_CLK)
    begin
        // Sublane 0
        soft_error_r[0] <=  `DLY   ENABLE_ERROR_DETECT & (RX_DISP_ERR[3]|RX_NOT_IN_TABLE[3]);
        soft_error_r[1] <=  `DLY   ENABLE_ERROR_DETECT & (RX_DISP_ERR[2]|RX_NOT_IN_TABLE[2]);

        // Sublane 1
        soft_error_r[2] <=  `DLY   ENABLE_ERROR_DETECT & (RX_DISP_ERR[1]|RX_NOT_IN_TABLE[1]);
        soft_error_r[3] <=  `DLY   ENABLE_ERROR_DETECT & (RX_DISP_ERR[0]|RX_NOT_IN_TABLE[0]);
    end


    always @(posedge USER_CLK)
    begin
        // Sublane 0
        SOFT_ERROR[0]  <=  `DLY    |soft_error_r[0:1];

        // Sublane 1
        SOFT_ERROR[1]  <=  `DLY    |soft_error_r[2:3];
    end



    // Detect Hard Errors
    always @(posedge USER_CLK)
        HARD_ERROR  <=  `DLY    ENABLE_ERROR_DETECT &
                                ((TX_K_ERR != 4'h0)|RX_BUF_STATUS|
                                TX_BUF_ERR|RX_REALIGN|bucket_full_0_r|bucket_full_1_r);



    // Assert hard error reset when there is a hard error.  This line of code is
    // basically just a renaming for the two fanout branches of the hard error
    // signal.
    assign HARD_ERROR_RESET =   HARD_ERROR;



    //_______________________________Leaky Bucket Sublane 0 ________________________


    // Good cycle counter: it takes 2 good cycles in a row to remove a demerit from
    // the leaky bucket.
    always @(posedge USER_CLK)
        if(!ENABLE_ERROR_DETECT)    good_count_0_r    <=  `DLY    2'b01;
        else
        begin
            case({soft_error_r[0:1], good_count_0_r})
                4'b0000 :   good_count_0_r    <=  `DLY    2'b01;
                4'b0001 :   good_count_0_r    <=  `DLY    2'b10;
                4'b0010 :   good_count_0_r    <=  `DLY    2'b01;
                4'b0011 :   good_count_0_r    <=  `DLY    2'b01;
                default :   good_count_0_r    <=  `DLY    2'b00;
            endcase
        end



    // Perform the leaky bucket algorithm using an up/down counter.  A drop is
    // added to the bucket whenever a soft error occurs, and is allowed to leak
    // out whenever the good cycles counter reaches 2.  Once the bucket fills
    // (3 drops) it stays full until it is reset by disabling and then enabling
    // the error detection circuit.
    always @(posedge USER_CLK)
        if(!ENABLE_ERROR_DETECT)    count_0_r <=  `DLY    2'b00;
        else
        begin
            case({soft_error_r[0:1],good_count_0_r[0],count_0_r})

                5'b00000    :   count_0_r <=  `DLY    count_0_r;
                5'b00001    :   count_0_r <=  `DLY    count_0_r;
                5'b00010    :   count_0_r <=  `DLY    count_0_r;
                5'b00011    :   count_0_r <=  `DLY    count_0_r;

                5'b00100    :   count_0_r <=  `DLY    2'b00;
                5'b00101    :   count_0_r <=  `DLY    2'b00;
                5'b00110    :   count_0_r <=  `DLY    2'b01;
                5'b00111    :   count_0_r <=  `DLY    2'b11;

                5'b01000    :   count_0_r <=  `DLY    2'b01;
                5'b01001    :   count_0_r <=  `DLY    2'b10;
                5'b01010    :   count_0_r <=  `DLY    2'b11;
                5'b01011    :   count_0_r <=  `DLY    2'b11;

                5'b01100    :   count_0_r <=  `DLY    2'b01;
                5'b01101    :   count_0_r <=  `DLY    2'b10;
                5'b01110    :   count_0_r <=  `DLY    2'b11;
                5'b01111    :   count_0_r <=  `DLY    2'b11;

                5'b10000    :   count_0_r <=  `DLY    2'b01;
                5'b10001    :   count_0_r <=  `DLY    2'b10;
                5'b10010    :   count_0_r <=  `DLY    2'b11;
                5'b10011    :   count_0_r <=  `DLY    2'b11;

                5'b10100    :   count_0_r <=  `DLY    2'b01;
                5'b10101    :   count_0_r <=  `DLY    2'b10;
                5'b10110    :   count_0_r <=  `DLY    2'b11;
                5'b10111    :   count_0_r <=  `DLY    2'b11;

                5'b11000    :   count_0_r <=  `DLY    2'b10;
                5'b11001    :   count_0_r <=  `DLY    2'b11;
                5'b11010    :   count_0_r <=  `DLY    2'b11;
                5'b11011    :   count_0_r <=  `DLY    2'b11;

                5'b11100    :   count_0_r <=  `DLY    2'b10;
                5'b11101    :   count_0_r <=  `DLY    2'b11;
                5'b11110    :   count_0_r <=  `DLY    2'b11;
                5'b11111    :   count_0_r <=  `DLY    2'b11;

                default     :   count_0_r <=  `DLY    2'bxx;
            endcase
        end



    // Detect when the bucket is full and register the signal.
    always  @(posedge USER_CLK)
        bucket_full_0_r   <= `DLY (count_0_r == 2'h3);



    //_______________________________Leaky Bucket Sublane 1 ________________________


        // Good cycle counter: it takes 2 good cycles in a row to remove a demerit from
        // the leaky bucket.
        always @(posedge USER_CLK)
            if(!ENABLE_ERROR_DETECT)    good_count_1_r    <=  `DLY    2'b01;
            else
            begin
                case({soft_error_r[2:3], good_count_1_r})
                    4'b0000 :   good_count_1_r    <=  `DLY    2'b01;
                    4'b0001 :   good_count_1_r    <=  `DLY    2'b10;
                    4'b0010 :   good_count_1_r    <=  `DLY    2'b01;
                    4'b0011 :   good_count_1_r    <=  `DLY    2'b01;
                    default :   good_count_1_r    <=  `DLY    2'b00;
                endcase
            end



        // Perform the leaky bucket algorithm using an up/down counter.  A drop is
        // added to the bucket whenever a soft error occurs, and is allowed to leak
        // out whenever the good cycles counter reaches 2.  Once the bucket fills
        // (3 drops) it stays full until it is reset by disabling and then enabling
        // the error detection circuit.
        always @(posedge USER_CLK)
            if(!ENABLE_ERROR_DETECT)    count_1_r <=  `DLY    2'b00;
            else
            begin
                case({soft_error_r[2:3],good_count_1_r[0],count_1_r})

                    5'b00000    :   count_1_r <=  `DLY    count_1_r;
                    5'b00001    :   count_1_r <=  `DLY    count_1_r;
                    5'b00010    :   count_1_r <=  `DLY    count_1_r;
                    5'b00011    :   count_1_r <=  `DLY    count_1_r;

                    5'b00100    :   count_1_r <=  `DLY    2'b00;
                    5'b00101    :   count_1_r <=  `DLY    2'b00;
                    5'b00110    :   count_1_r <=  `DLY    2'b01;
                    5'b00111    :   count_1_r <=  `DLY    2'b11;

                    5'b01000    :   count_1_r <=  `DLY    2'b01;
                    5'b01001    :   count_1_r <=  `DLY    2'b10;
                    5'b01010    :   count_1_r <=  `DLY    2'b11;
                    5'b01011    :   count_1_r <=  `DLY    2'b11;

                    5'b01100    :   count_1_r <=  `DLY    2'b01;
                    5'b01101    :   count_1_r <=  `DLY    2'b10;
                    5'b01110    :   count_1_r <=  `DLY    2'b11;
                    5'b01111    :   count_1_r <=  `DLY    2'b11;

                    5'b10000    :   count_1_r <=  `DLY    2'b01;
                    5'b10001    :   count_1_r <=  `DLY    2'b10;
                    5'b10010    :   count_1_r <=  `DLY    2'b11;
                    5'b10011    :   count_1_r <=  `DLY    2'b11;

                    5'b10100    :   count_1_r <=  `DLY    2'b01;
                    5'b10101    :   count_1_r <=  `DLY    2'b10;
                    5'b10110    :   count_1_r <=  `DLY    2'b11;
                    5'b10111    :   count_1_r <=  `DLY    2'b11;

                    5'b11000    :   count_1_r <=  `DLY    2'b10;
                    5'b11001    :   count_1_r <=  `DLY    2'b11;
                    5'b11010    :   count_1_r <=  `DLY    2'b11;
                    5'b11011    :   count_1_r <=  `DLY    2'b11;

                    5'b11100    :   count_1_r <=  `DLY    2'b10;
                    5'b11101    :   count_1_r <=  `DLY    2'b11;
                    5'b11110    :   count_1_r <=  `DLY    2'b11;
                    5'b11111    :   count_1_r <=  `DLY    2'b11;

                    default     :   count_1_r <=  `DLY    2'bxx;
                endcase
            end



        // Detect when the bucket is full and register the signal.
        always  @(posedge USER_CLK)
        bucket_full_1_r   <= `DLY (count_1_r == 2'h3);


endmodule


