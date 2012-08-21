//////////////////////////////////////////////////////////////////////
////                                                              ////
////  spi_top.v                                                   ////
////                                                              ////
////  This file is part of the SPI IP core project                ////
////  http://www.opencores.org/projects/spi/                      ////
////                                                              ////
////  Author(s):                                                  ////
////      - Simon Srot (simons@opencores.org)                     ////
////                                                              ////
////  All additional information is avaliable in the Readme.txt   ////
////  file.                                                       ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2002 Authors                                   ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
// Copyright (C) 2005 Rice University - Rice Open License Fill

`include "spi_defines.v"

module spi_top
(
  // OPB signals
  opb_clk_i, opb_rst_i,
  
  // SPI registers
  reg_ctrl, reg_ss, reg_divider, reg_tx, ctrlwrite, busval, go,

  // SPI signals
  ss_pad_o, sclk_pad_o, mosi_pad_o
);

  parameter Tp = 1;



  // OPB signals
  input                            opb_clk_i;         // master clock input
  input                            opb_rst_i;         // synchronous active high reset
  
  // SPI registers
  input			[13:0]	   reg_ctrl;
  input			[7:0]	   reg_ss;
  input				   reg_divider;
  input			[17:0]	   reg_tx;
  input				   ctrlwrite;
  input				   busval;
  output			   go;
  
  // SPI signals                                     
  output          [`SPI_SS_NB-1:0] ss_pad_o;         // slave select
  output                           sclk_pad_o;       // serial clock
  output                           mosi_pad_o;       // master out slave in
                                                     
  // Internal signals
  
  wire         [`SPI_MAX_CHAR-1:0] rx;               // Rx register
  wire                             rx_negedge;       // miso is sampled on negative edge
  wire                             tx_negedge;       // mosi is driven on negative edge
  wire    [`SPI_CHAR_LEN_BITS-1:0] char_len;         // char len
  //wire                             go;               // go
  wire                             lsb;              // lsb first on line
  wire                             ie;               // interrupt enable
  wire                             ass;              // automatic slave select
  wire                             spi_divider_sel;  // divider register select
  wire                             spi_ctrl_sel;     // ctrl register select
  wire                       [3:0] spi_tx_sel;       // tx_l register select
  wire                             spi_ss_sel;       // ss register select
  wire                             tip;              // transfer in progress
  wire                             pos_edge;         // recognize posedge of sclk
  wire                             neg_edge;         // recognize negedge of sclk
  wire                             last_bit;         // marks last character bit
  reg				   ctrlbitgo;
  
  
  assign rx_negedge = reg_ctrl[`SPI_CTRL_RX_NEGEDGE];
  assign tx_negedge = reg_ctrl[`SPI_CTRL_TX_NEGEDGE];
  assign go         = ctrlbitgo;
  assign char_len   = reg_ctrl[`SPI_CTRL_CHAR_LEN];
  assign lsb        = reg_ctrl[`SPI_CTRL_LSB];
  assign ie         = reg_ctrl[`SPI_CTRL_IE];
  assign ass        = reg_ctrl[`SPI_CTRL_ASS];
  
  always @(posedge opb_clk_i or posedge opb_rst_i)
  begin
  	if (opb_rst_i)
  		ctrlbitgo <= #Tp 1'b0;
  	else if(ctrlwrite && !tip)
  		ctrlbitgo <= #Tp busval;
  	else if(tip && last_bit && pos_edge)
  		ctrlbitgo <= #Tp 1'b0;
  end
  
  assign ss_pad_o = ~((reg_ss & {`SPI_SS_NB{tip & ass}}) | (reg_ss & {`SPI_SS_NB{!ass}}));
  
  spi_clgen clgen (.clk_in(opb_clk_i), .rst(opb_rst_i), .go(go), .enable(tip), .last_clk(last_bit),
                   .divider(reg_divider), .clk_out(sclk_pad_o), .pos_edge(pos_edge), 
                   .neg_edge(neg_edge));
  
  spi_shift shift (.clk(opb_clk_i), .rst(opb_rst_i), .len(char_len[`SPI_CHAR_LEN_BITS-1:0]),
                   .lsb(lsb), .go(go), .pos_edge(pos_edge), .neg_edge(neg_edge), 
                   .rx_negedge(rx_negedge), .tx_negedge(tx_negedge),
                   .tip(tip), .last(last_bit), 
                   .p_in(reg_tx), .p_out(rx), 
                   .s_clk(sclk_pad_o), .s_out(mosi_pad_o));
endmodule
  
