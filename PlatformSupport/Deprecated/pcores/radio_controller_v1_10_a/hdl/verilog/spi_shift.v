//////////////////////////////////////////////////////////////////////
////                                                              ////
////  spi_shift.v                                                 ////
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
////
//// /* Modifications to spi_shift.v			*/
//// /* Copyright (c) 2006 Rice University		*/
//// /* All Rights Reserved				*/
//// /* This code is covered by the Rice-WARP license	*/
//// /* See http://warp.rice.edu/license/ for details	*/


module spi_shift (clk, rst, len, lsb, go,
                  pos_edge, neg_edge, rx_negedge, tx_negedge,
                  tip, last, 
                  p_in, p_out, s_clk, s_out);

  parameter Tp = 1;
  
  input                          clk;          // system clock
  input                          rst;          // reset
  input [4:0] len;          // data len in bits (minus one)
  input                          lsb;          // lbs first on the line
  input                          go;           // start stansfer
  input                          pos_edge;     // recognize posedge of sclk
  input                          neg_edge;     // recognize negedge of sclk
  input                          rx_negedge;   // s_in is sampled on negative edge 
  input                          tx_negedge;   // s_out is driven on negative edge
  output                         tip;          // transfer in progress
  output                         last;         // last bit
  input           /*31*/  [17:0] p_in;         // parallel in
  output     [17:0] p_out;        // parallel out
  input                          s_clk;        // serial clock
  output                         s_out;        // serial out
                                               
  reg                            s_out;        
  reg                            tip;
                              
  reg     [5:0] cnt;          // data bit count
  wire        [17:0] data;         // shift register
  wire    [5:0] tx_bit_pos;   // next bit position
  wire    [5:0] rx_bit_pos;   // next bit position
  wire                           rx_clk;       // rx clock enable
  wire                           tx_clk;       // tx clock enable
  
  //assign p_out = data;
  assign data = p_in;
  
  assign tx_bit_pos = lsb ? {!(|len), len} - cnt : cnt - {{5{1'b0}},1'b1};
  assign rx_bit_pos = lsb ? {!(|len), len} - (rx_negedge ? cnt + {{5{1'b0}},1'b1} : cnt) : 
                            (rx_negedge ? cnt : cnt - {{5{1'b0}},1'b1});
  
  assign last = !(|cnt);
  
  assign rx_clk = (rx_negedge ? neg_edge : pos_edge) && (!last || s_clk);
  assign tx_clk = (tx_negedge ? neg_edge : pos_edge) && !last;
  
  // Character bit counter
  always @(posedge clk or posedge rst)
  begin
    if(rst)
      cnt <= #Tp {6{1'b0}};
    else
      begin
        if(tip)
          cnt <= #Tp pos_edge ? (cnt - {{5{1'b0}}, 1'b1}) : cnt;
        else
          cnt <= #Tp !(|len) ? {1'b1, {5{1'b0}}} : {1'b0, len};
      end
  end
  
  // Transfer in progress
  always @(posedge clk or posedge rst)
  begin
    if(rst)
      tip <= #Tp 1'b0;
  else if(go && ~tip)
    tip <= #Tp 1'b1;
  else if(tip && last && pos_edge)
    tip <= #Tp 1'b0;
  end
  
  // Sending bits to the line
  always @(posedge clk or posedge rst)
  begin
    if (rst)
      s_out   <= #Tp 1'b0;
    else
      s_out <= #Tp (tx_clk || !tip) ? data[tx_bit_pos[4:0]] : s_out;
  end
  
  
endmodule

