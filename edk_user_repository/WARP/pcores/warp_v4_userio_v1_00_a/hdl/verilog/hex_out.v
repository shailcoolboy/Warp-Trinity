////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2008 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: K.39
//  \   \         Application: netgen
//  /   /         Filename: adder_subtracter_virtex4_10_0_80b315fd28a09ef0.v
// /___/   /\     Timestamp: Thu Oct 01 13:34:30 2009
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -intstyle ise -w -sim -ofmt verilog .\tmp\_cg\adder_subtracter_virtex4_10_0_80b315fd28a09ef0.ngc .\tmp\_cg\adder_subtracter_virtex4_10_0_80b315fd28a09ef0.v 
// Device	: 4vfx12sf363-12
// Input file	: ./tmp/_cg/adder_subtracter_virtex4_10_0_80b315fd28a09ef0.ngc
// Output file	: ./tmp/_cg/adder_subtracter_virtex4_10_0_80b315fd28a09ef0.v
// # of Modules	: 1
// Design Name	: adder_subtracter_virtex4_10_0_80b315fd28a09ef0
// Xilinx        : c:\xilinx\10.1\ise
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Development System Reference Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module adder_subtracter_virtex4_10_0_80b315fd28a09ef0 (
a, b, s
);
  input [10 : 0] a;
  input [10 : 0] b;
  output [10 : 0] s;
  
  // synthesis translate_off
  
  wire \BU2/N1 ;
  wire \BU2/c_out ;
  wire NLW_VCC_P_UNCONNECTED;
  wire NLW_GND_G_UNCONNECTED;
  wire [10 : 0] \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum ;
  wire [9 : 0] \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple ;
  VCC   VCC_0 (
    .P(NLW_VCC_P_UNCONNECTED)
  );
  GND   GND_1 (
    .G(NLW_GND_G_UNCONNECTED)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/Mxor_halfsum_Result(0)1  (
    .I0(b[0]),
    .I1(a[0]),
    .O(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [0])
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/Mxor_halfsum_Result(1)1  (
    .I0(b[1]),
    .I1(a[1]),
    .O(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [1])
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/Mxor_halfsum_Result(2)1  (
    .I0(b[2]),
    .I1(a[2]),
    .O(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [2])
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/Mxor_halfsum_Result(3)1  (
    .I0(b[3]),
    .I1(a[3]),
    .O(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [3])
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/Mxor_halfsum_Result(4)1  (
    .I0(b[4]),
    .I1(a[4]),
    .O(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [4])
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/Mxor_halfsum_Result(5)1  (
    .I0(b[5]),
    .I1(a[5]),
    .O(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [5])
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/Mxor_halfsum_Result(6)1  (
    .I0(b[6]),
    .I1(a[6]),
    .O(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [6])
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/Mxor_halfsum_Result(7)1  (
    .I0(b[7]),
    .I1(a[7]),
    .O(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [7])
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/Mxor_halfsum_Result(8)1  (
    .I0(b[8]),
    .I1(a[8]),
    .O(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [8])
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/Mxor_halfsum_Result(9)1  (
    .I0(b[9]),
    .I1(a[9]),
    .O(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [9])
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/Mxor_halfsum_Result(10)1  (
    .I0(b[10]),
    .I1(a[10]),
    .O(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [10])
  );
  MUXCY   \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_need_mux.carrymux0  (
    .CI(\BU2/N1 ),
    .DI(a[0]),
    .S(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [0]),
    .O(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [0])
  );
  XORCY   \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.carryxor0  (
    .CI(\BU2/N1 ),
    .LI(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [0]),
    .O(s[0])
  );
  XORCY   \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carryxortop  (
    .CI(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [9]),
    .LI(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [10]),
    .O(s[10])
  );
  MUXCY   \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[1].carrymux  (
    .CI(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [0]),
    .DI(a[1]),
    .S(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [1]),
    .O(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [1])
  );
  XORCY   \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[1].carryxor  (
    .CI(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [0]),
    .LI(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [1]),
    .O(s[1])
  );
  MUXCY   \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[2].carrymux  (
    .CI(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [1]),
    .DI(a[2]),
    .S(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [2]),
    .O(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [2])
  );
  XORCY   \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[2].carryxor  (
    .CI(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [1]),
    .LI(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [2]),
    .O(s[2])
  );
  MUXCY   \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[3].carrymux  (
    .CI(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [2]),
    .DI(a[3]),
    .S(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [3]),
    .O(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [3])
  );
  XORCY   \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[3].carryxor  (
    .CI(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [2]),
    .LI(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [3]),
    .O(s[3])
  );
  MUXCY   \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[4].carrymux  (
    .CI(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [3]),
    .DI(a[4]),
    .S(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [4]),
    .O(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [4])
  );
  XORCY   \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[4].carryxor  (
    .CI(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [3]),
    .LI(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [4]),
    .O(s[4])
  );
  MUXCY   \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[5].carrymux  (
    .CI(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [4]),
    .DI(a[5]),
    .S(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [5]),
    .O(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [5])
  );
  XORCY   \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[5].carryxor  (
    .CI(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [4]),
    .LI(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [5]),
    .O(s[5])
  );
  MUXCY   \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[6].carrymux  (
    .CI(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [5]),
    .DI(a[6]),
    .S(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [6]),
    .O(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [6])
  );
  XORCY   \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[6].carryxor  (
    .CI(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [5]),
    .LI(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [6]),
    .O(s[6])
  );
  MUXCY   \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[7].carrymux  (
    .CI(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [6]),
    .DI(a[7]),
    .S(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [7]),
    .O(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [7])
  );
  XORCY   \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[7].carryxor  (
    .CI(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [6]),
    .LI(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [7]),
    .O(s[7])
  );
  MUXCY   \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[8].carrymux  (
    .CI(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [7]),
    .DI(a[8]),
    .S(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [8]),
    .O(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [8])
  );
  XORCY   \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[8].carryxor  (
    .CI(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [7]),
    .LI(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [8]),
    .O(s[8])
  );
  MUXCY   \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[9].carrymux  (
    .CI(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [8]),
    .DI(a[9]),
    .S(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [9]),
    .O(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [9])
  );
  XORCY   \BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[9].carryxor  (
    .CI(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [8]),
    .LI(\BU2/U0/addsub_v9_1.i_addsub_v9_1/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [9]),
    .O(s[9])
  );
  VCC   \BU2/XST_VCC  (
    .P(\BU2/N1 )
  );
  GND   \BU2/XST_GND  (
    .G(\BU2/c_out )
  );

// synthesis translate_on

endmodule

// synthesis translate_off

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

    wire GSR;
    wire GTS;
    wire PRLD;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

// synthesis translate_on
////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2008 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: K.39
//  \   \         Application: netgen
//  /   /         Filename: binary_counter_virtex4_10_0_0e77c8b832175d2c.v
// /___/   /\     Timestamp: Thu Oct 01 13:34:45 2009
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -intstyle ise -w -sim -ofmt verilog .\tmp\_cg\binary_counter_virtex4_10_0_0e77c8b832175d2c.ngc .\tmp\_cg\binary_counter_virtex4_10_0_0e77c8b832175d2c.v 
// Device	: 4vfx12sf363-12
// Input file	: ./tmp/_cg/binary_counter_virtex4_10_0_0e77c8b832175d2c.ngc
// Output file	: ./tmp/_cg/binary_counter_virtex4_10_0_0e77c8b832175d2c.v
// # of Modules	: 1
// Design Name	: binary_counter_virtex4_10_0_0e77c8b832175d2c
// Xilinx        : c:\xilinx\10.1\ise
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Development System Reference Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module binary_counter_virtex4_10_0_0e77c8b832175d2c (
  ce, sinit, clk, q
);
  input ce;
  input sinit;
  input clk;
  output [9 : 0] q;
  
  // synthesis translate_off
  
  wire \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carryxortop_rt_40 ;
  wire \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[1].carrymux_rt_38 ;
  wire \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[2].carrymux_rt_35 ;
  wire \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[3].carrymux_rt_32 ;
  wire \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[4].carrymux_rt_29 ;
  wire \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[5].carrymux_rt_26 ;
  wire \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[6].carrymux_rt_23 ;
  wire \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[7].carrymux_rt_20 ;
  wire \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[8].carrymux_rt_16 ;
  wire \BU2/N0 ;
  wire \BU2/thresh0 ;
  wire NLW_VCC_P_UNCONNECTED;
  wire NLW_GND_G_UNCONNECTED;
  wire [9 : 0] NlwRenamedSig_OI_q;
  wire [9 : 0] \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/s ;
  wire [0 : 0] \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum ;
  wire [8 : 0] \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple ;
  assign
    q[9] = NlwRenamedSig_OI_q[9],
    q[8] = NlwRenamedSig_OI_q[8],
    q[7] = NlwRenamedSig_OI_q[7],
    q[6] = NlwRenamedSig_OI_q[6],
    q[5] = NlwRenamedSig_OI_q[5],
    q[4] = NlwRenamedSig_OI_q[4],
    q[3] = NlwRenamedSig_OI_q[3],
    q[2] = NlwRenamedSig_OI_q[2],
    q[1] = NlwRenamedSig_OI_q[1],
    q[0] = NlwRenamedSig_OI_q[0];
  VCC   VCC_0 (
    .P(NLW_VCC_P_UNCONNECTED)
  );
  GND   GND_1 (
    .G(NLW_GND_G_UNCONNECTED)
  );
  INV   \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum_not00001_INV_0  (
    .I(NlwRenamedSig_OI_q[0]),
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [0])
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carryxortop_rt  (
    .I0(NlwRenamedSig_OI_q[9]),
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carryxortop_rt_40 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[1].carrymux_rt  (
    .I0(NlwRenamedSig_OI_q[1]),
    .O
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[1].carrymux_rt_38 )

  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[2].carrymux_rt  (
    .I0(NlwRenamedSig_OI_q[2]),
    .O
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[2].carrymux_rt_35 )

  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[3].carrymux_rt  (
    .I0(NlwRenamedSig_OI_q[3]),
    .O
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[3].carrymux_rt_32 )

  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[4].carrymux_rt  (
    .I0(NlwRenamedSig_OI_q[4]),
    .O
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[4].carrymux_rt_29 )

  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[5].carrymux_rt  (
    .I0(NlwRenamedSig_OI_q[5]),
    .O
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[5].carrymux_rt_26 )

  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[6].carrymux_rt  (
    .I0(NlwRenamedSig_OI_q[6]),
    .O
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[6].carrymux_rt_23 )

  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[7].carrymux_rt  (
    .I0(NlwRenamedSig_OI_q[7]),
    .O
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[7].carrymux_rt_20 )

  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[8].carrymux_rt  (
    .I0(NlwRenamedSig_OI_q[8]),
    .O
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[8].carrymux_rt_16 )

  );
  FDRE #(
    .INIT ( 1'b0 ))
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_q.i_simple.qreg/fd/output_1  (
    .C(clk),
    .CE(ce),
    .D(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/s [0]),
    .R(sinit),
    .Q(NlwRenamedSig_OI_q[0])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_q.i_simple.qreg/fd/output_2  (
    .C(clk),
    .CE(ce),
    .D(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/s [1]),
    .R(sinit),
    .Q(NlwRenamedSig_OI_q[1])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_q.i_simple.qreg/fd/output_3  (
    .C(clk),
    .CE(ce),
    .D(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/s [2]),
    .R(sinit),
    .Q(NlwRenamedSig_OI_q[2])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_q.i_simple.qreg/fd/output_4  (
    .C(clk),
    .CE(ce),
    .D(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/s [3]),
    .R(sinit),
    .Q(NlwRenamedSig_OI_q[3])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_q.i_simple.qreg/fd/output_5  (
    .C(clk),
    .CE(ce),
    .D(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/s [4]),
    .R(sinit),
    .Q(NlwRenamedSig_OI_q[4])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_q.i_simple.qreg/fd/output_6  (
    .C(clk),
    .CE(ce),
    .D(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/s [5]),
    .R(sinit),
    .Q(NlwRenamedSig_OI_q[5])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_q.i_simple.qreg/fd/output_7  (
    .C(clk),
    .CE(ce),
    .D(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/s [6]),
    .R(sinit),
    .Q(NlwRenamedSig_OI_q[6])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_q.i_simple.qreg/fd/output_8  (
    .C(clk),
    .CE(ce),
    .D(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/s [7]),
    .R(sinit),
    .Q(NlwRenamedSig_OI_q[7])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_q.i_simple.qreg/fd/output_9  (
    .C(clk),
    .CE(ce),
    .D(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/s [8]),
    .R(sinit),
    .Q(NlwRenamedSig_OI_q[8])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_q.i_simple.qreg/fd/output_10  (
    .C(clk),
    .CE(ce),
    .D(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/s [9]),
    .R(sinit),
    .Q(NlwRenamedSig_OI_q[9])
  );
  MUXCY   \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_need_mux.carrymux0  (
    .CI(\BU2/N0 ),
    .DI(\BU2/thresh0 ),
    .S(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [0]),
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [0])
  );
  XORCY   \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.carryxor0  (
    .CI(\BU2/N0 ),
    .LI(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [0]),
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/s [0])
  );
  XORCY   \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carryxortop  (
    .CI(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [8]),
    .LI(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carryxortop_rt_40 ),
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/s [9])
  );
  MUXCY 
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[1].carrymux  (
    .CI(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [0]),
    .DI(\BU2/N0 ),
    .S
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[1].carrymux_rt_38 )
,
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [1])
  );
  XORCY 
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[1].carryxor  (
    .CI(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [0]),
    .LI
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[1].carrymux_rt_38 )
,
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/s [1])
  );
  MUXCY 
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[2].carrymux  (
    .CI(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [1]),
    .DI(\BU2/N0 ),
    .S
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[2].carrymux_rt_35 )
,
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [2])
  );
  XORCY 
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[2].carryxor  (
    .CI(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [1]),
    .LI
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[2].carrymux_rt_35 )
,
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/s [2])
  );
  MUXCY 
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[3].carrymux  (
    .CI(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [2]),
    .DI(\BU2/N0 ),
    .S
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[3].carrymux_rt_32 )
,
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [3])
  );
  XORCY 
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[3].carryxor  (
    .CI(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [2]),
    .LI
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[3].carrymux_rt_32 )
,
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/s [3])
  );
  MUXCY 
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[4].carrymux  (
    .CI(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [3]),
    .DI(\BU2/N0 ),
    .S
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[4].carrymux_rt_29 )
,
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [4])
  );
  XORCY 
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[4].carryxor  (
    .CI(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [3]),
    .LI
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[4].carrymux_rt_29 )
,
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/s [4])
  );
  MUXCY 
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[5].carrymux  (
    .CI(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [4]),
    .DI(\BU2/N0 ),
    .S
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[5].carrymux_rt_26 )
,
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [5])
  );
  XORCY 
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[5].carryxor  (
    .CI(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [4]),
    .LI
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[5].carrymux_rt_26 )
,
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/s [5])
  );
  MUXCY 
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[6].carrymux  (
    .CI(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [5]),
    .DI(\BU2/N0 ),
    .S
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[6].carrymux_rt_23 )
,
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [6])
  );
  XORCY 
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[6].carryxor  (
    .CI(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [5]),
    .LI
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[6].carrymux_rt_23 )
,
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/s [6])
  );
  MUXCY 
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[7].carrymux  (
    .CI(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [6]),
    .DI(\BU2/N0 ),
    .S
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[7].carrymux_rt_20 )
,
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [7])
  );
  XORCY 
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[7].carryxor  (
    .CI(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [6]),
    .LI
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[7].carrymux_rt_20 )
,
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/s [7])
  );
  MUXCY 
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[8].carrymux  (
    .CI(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [7]),
    .DI(\BU2/N0 ),
    .S
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[8].carrymux_rt_16 )
,
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [8])
  );
  XORCY 
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[8].carryxor  (
    .CI(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [7]),
    .LI
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[8].carrymux_rt_16 )
,
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/s [8])
  );
  VCC   \BU2/XST_VCC  (
    .P(\BU2/thresh0 )
  );
  GND   \BU2/XST_GND  (
    .G(\BU2/N0 )
  );

// synthesis translate_on

endmodule

// synthesis translate_off

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

    wire GSR;
    wire GTS;
    wire PRLD;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

// synthesis translate_on
////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2008 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: K.39
//  \   \         Application: netgen
//  /   /         Filename: binary_counter_virtex4_10_0_407917162894eacc.v
// /___/   /\     Timestamp: Thu Oct 01 13:35:00 2009
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -intstyle ise -w -sim -ofmt verilog .\tmp\_cg\binary_counter_virtex4_10_0_407917162894eacc.ngc .\tmp\_cg\binary_counter_virtex4_10_0_407917162894eacc.v 
// Device	: 4vfx12sf363-12
// Input file	: ./tmp/_cg/binary_counter_virtex4_10_0_407917162894eacc.ngc
// Output file	: ./tmp/_cg/binary_counter_virtex4_10_0_407917162894eacc.v
// # of Modules	: 1
// Design Name	: binary_counter_virtex4_10_0_407917162894eacc
// Xilinx        : c:\xilinx\10.1\ise
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Development System Reference Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module binary_counter_virtex4_10_0_407917162894eacc (
  ce, sinit, clk, q
);
  input ce;
  input sinit;
  input clk;
  output [1 : 0] q;
  
  // synthesis translate_off
  
  wire \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carryxortop_rt_10 ;
  wire \BU2/N0 ;
  wire \BU2/thresh0 ;
  wire NLW_VCC_P_UNCONNECTED;
  wire NLW_GND_G_UNCONNECTED;
  wire [1 : 0] NlwRenamedSig_OI_q;
  wire [0 : 0] \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum ;
  wire [0 : 0] \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple ;
  wire [1 : 0] \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/s ;
  assign
    q[1] = NlwRenamedSig_OI_q[1],
    q[0] = NlwRenamedSig_OI_q[0];
  VCC   VCC_0 (
    .P(NLW_VCC_P_UNCONNECTED)
  );
  GND   GND_1 (
    .G(NLW_GND_G_UNCONNECTED)
  );
  INV   \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum_not00001_INV_0  (
    .I(NlwRenamedSig_OI_q[0]),
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [0])
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carryxortop_rt  (
    .I0(NlwRenamedSig_OI_q[1]),
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carryxortop_rt_10 )
  );
  MUXCY   \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_need_mux.carrymux0  (
    .CI(\BU2/N0 ),
    .DI(\BU2/thresh0 ),
    .S(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [0]),
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [0])
  );
  XORCY   \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.carryxor0  (
    .CI(\BU2/N0 ),
    .LI(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [0]),
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/s [0])
  );
  XORCY   \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carryxortop  (
    .CI(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [0]),
    .LI(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carryxortop_rt_10 ),
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/s [1])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_q.i_simple.qreg/fd/output_1  (
    .C(clk),
    .CE(ce),
    .D(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/s [0]),
    .R(sinit),
    .Q(NlwRenamedSig_OI_q[0])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_q.i_simple.qreg/fd/output_2  (
    .C(clk),
    .CE(ce),
    .D(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/s [1]),
    .R(sinit),
    .Q(NlwRenamedSig_OI_q[1])
  );
  VCC   \BU2/XST_VCC  (
    .P(\BU2/thresh0 )
  );
  GND   \BU2/XST_GND  (
    .G(\BU2/N0 )
  );

// synthesis translate_on

endmodule

// synthesis translate_off

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

    wire GSR;
    wire GTS;
    wire PRLD;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

// synthesis translate_on
////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2008 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: K.39
//  \   \         Application: netgen
//  /   /         Filename: binary_counter_virtex4_10_0_7f29bec8df1c7606.v
// /___/   /\     Timestamp: Thu Oct 01 13:35:16 2009
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -intstyle ise -w -sim -ofmt verilog .\tmp\_cg\binary_counter_virtex4_10_0_7f29bec8df1c7606.ngc .\tmp\_cg\binary_counter_virtex4_10_0_7f29bec8df1c7606.v 
// Device	: 4vfx12sf363-12
// Input file	: ./tmp/_cg/binary_counter_virtex4_10_0_7f29bec8df1c7606.ngc
// Output file	: ./tmp/_cg/binary_counter_virtex4_10_0_7f29bec8df1c7606.v
// # of Modules	: 1
// Design Name	: binary_counter_virtex4_10_0_7f29bec8df1c7606
// Xilinx        : c:\xilinx\10.1\ise
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Development System Reference Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module binary_counter_virtex4_10_0_7f29bec8df1c7606 (
  ce, sinit, clk, q
);
  input ce;
  input sinit;
  input clk;
  output [5 : 0] q;
  
  // synthesis translate_off
  
  wire \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carryxortop_rt_26 ;
  wire \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[1].carrymux_rt_25 ;
  wire \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[2].carrymux_rt_23 ;
  wire \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[3].carrymux_rt_21 ;
  wire \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[4].carrymux_rt_18 ;
  wire \BU2/N0 ;
  wire \BU2/thresh0 ;
  wire NLW_VCC_P_UNCONNECTED;
  wire NLW_GND_G_UNCONNECTED;
  wire [5 : 0] NlwRenamedSig_OI_q;
  wire [0 : 0] \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum ;
  wire [4 : 0] \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple ;
  wire [5 : 0] \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/s ;
  assign
    q[5] = NlwRenamedSig_OI_q[5],
    q[4] = NlwRenamedSig_OI_q[4],
    q[3] = NlwRenamedSig_OI_q[3],
    q[2] = NlwRenamedSig_OI_q[2],
    q[1] = NlwRenamedSig_OI_q[1],
    q[0] = NlwRenamedSig_OI_q[0];
  VCC   VCC_0 (
    .P(NLW_VCC_P_UNCONNECTED)
  );
  GND   GND_1 (
    .G(NLW_GND_G_UNCONNECTED)
  );
  INV   \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum_not00001_INV_0  (
    .I(NlwRenamedSig_OI_q[0]),
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [0])
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carryxortop_rt  (
    .I0(NlwRenamedSig_OI_q[5]),
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carryxortop_rt_26 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[1].carrymux_rt  (
    .I0(NlwRenamedSig_OI_q[1]),
    .O
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[1].carrymux_rt_25 )

  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[2].carrymux_rt  (
    .I0(NlwRenamedSig_OI_q[2]),
    .O
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[2].carrymux_rt_23 )

  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[3].carrymux_rt  (
    .I0(NlwRenamedSig_OI_q[3]),
    .O
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[3].carrymux_rt_21 )

  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[4].carrymux_rt  (
    .I0(NlwRenamedSig_OI_q[4]),
    .O
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[4].carrymux_rt_18 )

  );
  MUXCY   \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_need_mux.carrymux0  (
    .CI(\BU2/N0 ),
    .DI(\BU2/thresh0 ),
    .S(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [0]),
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [0])
  );
  XORCY   \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.carryxor0  (
    .CI(\BU2/N0 ),
    .LI(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/halfsum [0]),
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/s [0])
  );
  XORCY   \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carryxortop  (
    .CI(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [4]),
    .LI(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carryxortop_rt_26 ),
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/s [5])
  );
  MUXCY 
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[1].carrymux  (
    .CI(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [0]),
    .DI(\BU2/N0 ),
    .S
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[1].carrymux_rt_25 )
,
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [1])
  );
  XORCY 
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[1].carryxor  (
    .CI(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [0]),
    .LI
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[1].carrymux_rt_25 )
,
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/s [1])
  );
  MUXCY 
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[2].carrymux  (
    .CI(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [1]),
    .DI(\BU2/N0 ),
    .S
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[2].carrymux_rt_23 )
,
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [2])
  );
  XORCY 
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[2].carryxor  (
    .CI(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [1]),
    .LI
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[2].carrymux_rt_23 )
,
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/s [2])
  );
  MUXCY 
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[3].carrymux  (
    .CI(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [2]),
    .DI(\BU2/N0 ),
    .S
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[3].carrymux_rt_21 )
,
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [3])
  );
  XORCY 
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[3].carryxor  (
    .CI(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [2]),
    .LI
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[3].carrymux_rt_21 )
,
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/s [3])
  );
  MUXCY 
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[4].carrymux  (
    .CI(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [3]),
    .DI(\BU2/N0 ),
    .S
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[4].carrymux_rt_18 )
,
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [4])
  );
  XORCY 
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[4].carryxor  (
    .CI(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/carry_simple [3]),
    .LI
(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_simple_model.i_gt_1.carrychaingen[4].carrymux_rt_18 )
,
    .O(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/s [4])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_q.i_simple.qreg/fd/output_1  (
    .C(clk),
    .CE(ce),
    .D(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/s [0]),
    .R(sinit),
    .Q(NlwRenamedSig_OI_q[0])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_q.i_simple.qreg/fd/output_2  (
    .C(clk),
    .CE(ce),
    .D(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/s [1]),
    .R(sinit),
    .Q(NlwRenamedSig_OI_q[1])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_q.i_simple.qreg/fd/output_3  (
    .C(clk),
    .CE(ce),
    .D(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/s [2]),
    .R(sinit),
    .Q(NlwRenamedSig_OI_q[2])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_q.i_simple.qreg/fd/output_4  (
    .C(clk),
    .CE(ce),
    .D(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/s [3]),
    .R(sinit),
    .Q(NlwRenamedSig_OI_q[3])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_q.i_simple.qreg/fd/output_5  (
    .C(clk),
    .CE(ce),
    .D(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/s [4]),
    .R(sinit),
    .Q(NlwRenamedSig_OI_q[4])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/no_pipelining.the_addsub/i_lut4.i_lut4_addsub/i_q.i_simple.qreg/fd/output_6  (
    .C(clk),
    .CE(ce),
    .D(\BU2/U0/i_baseblox.i_baseblox_counter/the_addsub/s [5]),
    .R(sinit),
    .Q(NlwRenamedSig_OI_q[5])
  );
  VCC   \BU2/XST_VCC  (
    .P(\BU2/thresh0 )
  );
  GND   \BU2/XST_GND  (
    .G(\BU2/N0 )
  );

// synthesis translate_on

endmodule

// synthesis translate_off

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

    wire GSR;
    wire GTS;
    wire PRLD;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

// synthesis translate_on
/*******************************************************************************
*     This file is owned and controlled by Xilinx and must be used             *
*     solely for design, simulation, implementation and creation of            *
*     design files limited to Xilinx devices or technologies. Use              *
*     with non-Xilinx devices or technologies is expressly prohibited          *
*     and immediately terminates your license.                                 *
*                                                                              *
*     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"            *
*     SOLELY FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR                  *
*     XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION          *
*     AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE, APPLICATION              *
*     OR STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS                *
*     IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,                  *
*     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE         *
*     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY                 *
*     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE                  *
*     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR           *
*     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF          *
*     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS          *
*     FOR A PARTICULAR PURPOSE.                                                *
*                                                                              *
*     Xilinx products are not intended for use in life support                 *
*     appliances, devices, or systems. Use in such applications are            *
*     expressly prohibited.                                                    *
*                                                                              *
*     (c) Copyright 1995-2007 Xilinx, Inc.                                     *
*     All rights reserved.                                                     *
*******************************************************************************/
// The synthesis directives "translate_off/translate_on" specified below are
// supported by Xilinx, Mentor Graphics and Synplicity synthesis
// tools. Ensure they are correct for your synthesis tool(s).

// You must compile the wrapper file dmg_33_vx4_dcb0c4b6adf24a19.v when simulating
// the core, dmg_33_vx4_dcb0c4b6adf24a19. When compiling the wrapper file, be sure to
// reference the XilinxCoreLib Verilog simulation library. For detailed
// instructions, please refer to the "CORE Generator Help".

`timescale 1ns/1ps

module dmg_33_vx4_dcb0c4b6adf24a19(
	a,
	d,
	dpra,
	clk,
	we,
	spo,
	dpo);


input [5 : 0] a;
input [0 : 0] d;
input [5 : 0] dpra;
input clk;
input we;
output [0 : 0] spo;
output [0 : 0] dpo;

// synthesis translate_off

      DIST_MEM_GEN_V3_3 #(
		.C_ADDR_WIDTH(6),
		.C_DEFAULT_DATA("0"),
		.C_DEPTH(64),
		.C_HAS_CLK(1),
		.C_HAS_D(1),
		.C_HAS_DPO(1),
		.C_HAS_DPRA(1),
		.C_HAS_I_CE(0),
		.C_HAS_QDPO(0),
		.C_HAS_QDPO_CE(0),
		.C_HAS_QDPO_CLK(0),
		.C_HAS_QDPO_RST(0),
		.C_HAS_QDPO_SRST(0),
		.C_HAS_QSPO(0),
		.C_HAS_QSPO_CE(0),
		.C_HAS_QSPO_RST(0),
		.C_HAS_QSPO_SRST(0),
		.C_HAS_SPO(1),
		.C_HAS_SPRA(0),
		.C_HAS_WE(1),
		.C_MEM_INIT_FILE("dmg_33_vx4_dcb0c4b6adf24a19.mif"),
		.C_MEM_TYPE(2),
		.C_PIPELINE_STAGES(0),
		.C_QCE_JOINED(0),
		.C_QUALIFY_WE(0),
		.C_READ_MIF(1),
		.C_REG_A_D_INPUTS(0),
		.C_REG_DPRA_INPUT(0),
		.C_SYNC_ENABLE(1),
		.C_WIDTH(1))
	inst (
		.A(a),
		.D(d),
		.DPRA(dpra),
		.CLK(clk),
		.WE(we),
		.SPO(spo),
		.DPO(dpo),
		.SPRA(),
		.I_CE(),
		.QSPO_CE(),
		.QDPO_CE(),
		.QDPO_CLK(),
		.QSPO_RST(),
		.QDPO_RST(),
		.QSPO_SRST(),
		.QDPO_SRST(),
		.QSPO(),
		.QDPO());


// synthesis translate_on

endmodule


//-----------------------------------------------------------------
// System Generator version 10.1.3 VERILOG source file.
//
// Copyright(C) 2008 by Xilinx, Inc.  All rights reserved.  This
// text/file contains proprietary, confidential information of Xilinx,
// Inc., is distributed under license from Xilinx, Inc., and may be used,
// copied and/or disclosed only pursuant to the terms of a valid license
// agreement with Xilinx, Inc.  Xilinx hereby grants you a license to use
// this text/file solely for design, simulation, implementation and
// creation of design files limited to Xilinx devices or technologies.
// Use with non-Xilinx devices or technologies is expressly prohibited
// and immediately terminates your license unless covered by a separate
// agreement.
//
// Xilinx is providing this design, code, or information "as is" solely
// for use in developing programs and solutions for Xilinx devices.  By
// providing this design, code, or information as one possible
// implementation of this feature, application or standard, Xilinx is
// making no representation that this implementation is free from any
// claims of infringement.  You are responsible for obtaining any rights
// you may require for your implementation.  Xilinx expressly disclaims
// any warranty whatsoever with respect to the adequacy of the
// implementation, including but not limited to warranties of
// merchantability or fitness for a particular purpose.
//
// Xilinx products are not intended for use in life support appliances,
// devices, or systems.  Use in such applications is expressly prohibited.
//
// Any modifications that are made to the source code are done at the user's
// sole risk and will be unsupported.
//
// This copyright and support notice must be retained as part of this
// text at all times.  (c) Copyright 1995-2008 Xilinx, Inc.  All rights
// reserved.
//-----------------------------------------------------------------
// synopsys translate_off
`ifndef simulating
  `define simulating 1
`endif
// synopsys translate_on
`ifndef simulating
  `define simulating 0
`endif
`ifndef xlUnsigned
 `define xlUnsigned 1
`endif
`ifndef xlSigned
 `define xlSigned 2
`endif
`ifndef xlWrap
 `define xlWrap 1
`endif
`ifndef xlSaturate
 `define xlSaturate 2
`endif
`ifndef xlTruncate
 `define xlTruncate 1
`endif
`ifndef xlRound
 `define xlRound 2
`endif
`ifndef xlRoundBanker
 `define xlRoundBanker 3
`endif
`ifndef xlAddMode
 `define xlAddMode 1
`endif
`ifndef xlSubMode
 `define xlSubMode 2
`endif

//-----------------------------------------------------------------
// System Generator version 10.1.3 VERILOG source file.
//
// Copyright(C) 2008 by Xilinx, Inc.  All rights reserved.  This
// text/file contains proprietary, confidential information of Xilinx,
// Inc., is distributed under license from Xilinx, Inc., and may be used,
// copied and/or disclosed only pursuant to the terms of a valid license
// agreement with Xilinx, Inc.  Xilinx hereby grants you a license to use
// this text/file solely for design, simulation, implementation and
// creation of design files limited to Xilinx devices or technologies.
// Use with non-Xilinx devices or technologies is expressly prohibited
// and immediately terminates your license unless covered by a separate
// agreement.
//
// Xilinx is providing this design, code, or information "as is" solely
// for use in developing programs and solutions for Xilinx devices.  By
// providing this design, code, or information as one possible
// implementation of this feature, application or standard, Xilinx is
// making no representation that this implementation is free from any
// claims of infringement.  You are responsible for obtaining any rights
// you may require for your implementation.  Xilinx expressly disclaims
// any warranty whatsoever with respect to the adequacy of the
// implementation, including but not limited to warranties of
// merchantability or fitness for a particular purpose.
//
// Xilinx products are not intended for use in life support appliances,
// devices, or systems.  Use in such applications is expressly prohibited.
//
// Any modifications that are made to the source code are done at the user's
// sole risk and will be unsupported.
//
// This copyright and support notice must be retained as part of this
// text at all times.  (c) Copyright 1995-2008 Xilinx, Inc.  All rights
// reserved.
//-----------------------------------------------------------------
`timescale 1 ns / 10 ps
module srl17e (clk, ce, d, q);
    parameter width = 16;
    parameter latency = 8;
    input clk, ce;
    input [width-1:0] d;
    output [width-1:0] q;
    parameter signed [5:0] a = latency - 2;
    wire[width - 1:0] #0.2 d_delayed;
    wire[width - 1:0] srl16_out;
    genvar i;
    assign d_delayed = d ;
    generate
      for(i=0; i<width; i=i+1)
      begin:reg_array
            if (latency > 1)
                begin: has_2_latency
                 SRL16E u1 (.CLK(clk), .D(d_delayed[i]), .Q(srl16_out[i]), .CE(ce), .A0(a[0]), .A1(a[1]), .A2(a[2]), .A3(a[3]));
                end
            if (latency <= 1)
                begin: has_1_latency
                 assign srl16_out[i] = d_delayed[i];
                end
            if (latency != 0)
                begin: has_latency
                 FDE u2 (.C(clk), .D(srl16_out[i]), .Q(q[i]), .CE(ce));
                end
            if (latency == 0)
                begin:has_0_latency
                 assign q[i] = srl16_out[i];
                end
        end
    endgenerate
endmodule
module synth_reg (i, ce, clr, clk, o);
   parameter width  = 8;
   parameter latency  = 1;
   input[width - 1:0] i;
   input ce,clr,clk;
   output[width - 1:0] o;
   parameter complete_num_srl17es = latency/17;
   parameter remaining_latency = latency%17;
   parameter temp_num_srl17es = (latency/17) + ((latency%17)?1:0);
   parameter num_srl17es = temp_num_srl17es ? temp_num_srl17es : 1;
   wire [width - 1:0] z [0:num_srl17es-1];
   genvar t;
    generate
      if (latency <= 17)
          begin:has_only_1
              srl17e #(width, latency) srl17e_array0(.clk(clk), .ce(ce), .d(i), .q(o));
          end
     endgenerate
    generate
     if (latency > 17)
        begin:has_1
             assign o = z[num_srl17es-1];
             srl17e #(width, 17) srl17e_array0(.clk(clk), .ce(ce), .d(i), .q(z[0]));
        end
   endgenerate
   generate
      if (latency > 17)
          begin:more_than_1
              for (t=1; t < complete_num_srl17es; t=t+1)
                begin:left_complete_ones
                   srl17e #(width, 17) srl17e_array(.clk(clk), .ce(ce), .d(z[t-1]), .q(z[t]));
                end
          end
   endgenerate
   generate
     if ((remaining_latency > 0) && (latency>17))
          begin:remaining_ones
             srl17e #(width, (latency%17)) last_srl17e (.clk(clk), .ce(ce), .d(z[num_srl17es-2]), .q(z[num_srl17es-1]));
          end
   endgenerate
endmodule
module synth_reg_reg (i, ce, clr, clk, o);
   parameter width  = 8;
   parameter latency  = 1;
   input[width - 1:0] i;
   input ce, clr, clk;
   output[width - 1:0] o;
   wire[width - 1:0] o;
   genvar idx;
   reg[width - 1:0] reg_bank [latency:0];
   integer j;
   initial
     begin
        for (j=0; j < latency+1; j=j+1)
          begin
             reg_bank[j] = {width{1'b0}};
          end
     end

   generate
     if (latency == 0)
        begin:has_0_latency
         assign o = i;
       end
   endgenerate

   always @(i)
        begin
             reg_bank[0] = i;
         end
   generate
     if (latency > 0)
        begin:more_than_1
            assign o = reg_bank[latency];
         for (idx=0; idx < latency; idx=idx+1) begin:sync_loop
            always @(posedge clk)
                  begin
                  if (ce)
                    begin
                        reg_bank[idx+1] <= reg_bank[idx] ;
                    end
               end
        end
      end
   endgenerate
endmodule

//-----------------------------------------------------------------
// System Generator version 10.1.3 VERILOG source file.
//
// Copyright(C) 2008 by Xilinx, Inc.  All rights reserved.  This
// text/file contains proprietary, confidential information of Xilinx,
// Inc., is distributed under license from Xilinx, Inc., and may be used,
// copied and/or disclosed only pursuant to the terms of a valid license
// agreement with Xilinx, Inc.  Xilinx hereby grants you a license to use
// this text/file solely for design, simulation, implementation and
// creation of design files limited to Xilinx devices or technologies.
// Use with non-Xilinx devices or technologies is expressly prohibited
// and immediately terminates your license unless covered by a separate
// agreement.
//
// Xilinx is providing this design, code, or information "as is" solely
// for use in developing programs and solutions for Xilinx devices.  By
// providing this design, code, or information as one possible
// implementation of this feature, application or standard, Xilinx is
// making no representation that this implementation is free from any
// claims of infringement.  You are responsible for obtaining any rights
// you may require for your implementation.  Xilinx expressly disclaims
// any warranty whatsoever with respect to the adequacy of the
// implementation, including but not limited to warranties of
// merchantability or fitness for a particular purpose.
//
// Xilinx products are not intended for use in life support appliances,
// devices, or systems.  Use in such applications is expressly prohibited.
//
// Any modifications that are made to the source code are done at the user's
// sole risk and will be unsupported.
//
// This copyright and support notice must be retained as part of this
// text at all times.  (c) Copyright 1995-2008 Xilinx, Inc.  All rights
// reserved.
//-----------------------------------------------------------------
`timescale 1 ns / 10 ps
module synth_reg_w_init (i, ce, clr, clk, o);
   parameter width  = 8;
   parameter init_index  = 0;
   parameter [width-1 : 0] init_value  = 'b0000;
   parameter latency  = 1;

   input[width - 1:0] i;
   input ce, clr, clk;
   output[width - 1:0] o;
   wire[(latency + 1) * width - 1:0] dly_i;
   wire #0.2 dly_clr;
   genvar index;

   generate
     if (latency == 0)
        begin:has_0_latency
         assign o = i;
        end
     else
        begin:has_latency
         assign dly_i[(latency + 1) * width - 1:latency * width] = i ;
         assign dly_clr = clr ;
         for (index=1; index<=latency; index=index+1)
           begin:fd_array
// synopsys translate_off
             defparam reg_comp_1.width = width;
             defparam reg_comp_1.init_index = init_index;
             defparam reg_comp_1.init_value = init_value;
// synopsys translate_on
             single_reg_w_init #(width, init_index, init_value)
               reg_comp_1(.clk(clk),
                          .i(dly_i[(index + 1)*width-1:index*width]),
                          .o(dly_i[index * width - 1:(index - 1) * width]),
                          .ce(ce),
                          .clr(dly_clr));
             end
        assign o = dly_i[width-1:0];
       end
   endgenerate
endmodule
module single_reg_w_init (i, ce, clr, clk, o);
   parameter width  = 8;
   parameter init_index  = 0;
   parameter [width-1 : 0] init_value  = 8'b00000000;
   input[width - 1:0] i;
   input ce;
   input clr;
   input clk;
   output[width - 1:0] o;
   parameter [0:0] init_index_val = (init_index ==  1) ? 1'b1 : 1'b0;
   parameter [width-1:0] result = (width > 1) ? { {(width-1){1'b0}}, init_index_val } : init_index_val;
   parameter [width-1:0] init_const = (init_index > 1) ? init_value : result;
   wire[width - 1:0] o;
   genvar index;

   generate
     for (index=0;index < width; index=index+1) begin:fd_prim_array
          if (init_const[index] == 0)
            begin:rst_comp
              FDRE fdre_comp(.C(clk),
                             .D(i[index]),
                             .Q(o[index]),
                             .CE(ce),
                             .R(clr));
            end
          else
            begin:set_comp
             FDSE fdse_comp(.C(clk),
                            .D(i[index]),
                            .Q(o[index]),
                            .CE(ce),
                            .S(clr));
            end
    end
   endgenerate
endmodule

//-----------------------------------------------------------------
// System Generator version 10.1.3 VERILOG source file.
//
// Copyright(C) 2008 by Xilinx, Inc.  All rights reserved.  This
// text/file contains proprietary, confidential information of Xilinx,
// Inc., is distributed under license from Xilinx, Inc., and may be used,
// copied and/or disclosed only pursuant to the terms of a valid license
// agreement with Xilinx, Inc.  Xilinx hereby grants you a license to use
// this text/file solely for design, simulation, implementation and
// creation of design files limited to Xilinx devices or technologies.
// Use with non-Xilinx devices or technologies is expressly prohibited
// and immediately terminates your license unless covered by a separate
// agreement.
//
// Xilinx is providing this design, code, or information "as is" solely
// for use in developing programs and solutions for Xilinx devices.  By
// providing this design, code, or information as one possible
// implementation of this feature, application or standard, Xilinx is
// making no representation that this implementation is free from any
// claims of infringement.  You are responsible for obtaining any rights
// you may require for your implementation.  Xilinx expressly disclaims
// any warranty whatsoever with respect to the adequacy of the
// implementation, including but not limited to warranties of
// merchantability or fitness for a particular purpose.
//
// Xilinx products are not intended for use in life support appliances,
// devices, or systems.  Use in such applications is expressly prohibited.
//
// Any modifications that are made to the source code are done at the user's
// sole risk and will be unsupported.
//
// This copyright and support notice must be retained as part of this
// text at all times.  (c) Copyright 1995-2008 Xilinx, Inc.  All rights
// reserved.
//-----------------------------------------------------------------
`ifndef xlConvertType
 `define xlConvertType
 `timescale 1 ns / 10 ps
module cast (inp, res);
    parameter signed [31:0] old_width = 4;
    parameter signed [31:0] old_bin_pt = 1;
    parameter signed [31:0] new_width = 4;
    parameter signed [31:0] new_bin_pt = 1;
    parameter signed [31:0] new_arith = `xlSigned;
    input [old_width - 1 : 0] inp;
    output [new_width - 1 : 0] res;

   parameter signed [31:0] right_of_dp = new_bin_pt - old_bin_pt;
    wire [new_width-1:0] result;
   genvar i;
   assign res = result;
   generate
      for (i = 0; i<new_width;  i = i+1)
        begin:cast_loop
           if ((i-right_of_dp) > old_width - 1)
             begin:u0
                if (new_arith == `xlUnsigned)
                  begin:u1
                     assign result[i] = 1'b0;
                  end
                if (new_arith == `xlSigned)
                  begin:u2
                     assign result[i] = inp[old_width-1];
                  end
             end
           else if ((i-right_of_dp) >= 0)
             begin:u3
                assign result[i] = inp[i-right_of_dp];
             end
           else
             begin:u4
                assign result[i] = 1'b0;
             end
        end
      endgenerate

endmodule
module pad_lsb (inp, res);
   parameter signed [31:0] orig_width = 4;
   parameter signed [31:0] new_width = 2;
   input [orig_width - 1 : 0] inp;
   output [new_width - 1 : 0] res;
   parameter signed [31:0] pad_pos = new_width - orig_width -1;
   wire [new_width-1:0] result;
   genvar i;
   assign  res = result;
   generate
      if (new_width >= orig_width)
        begin:u0
           assign result[new_width-1:new_width-orig_width] = inp[orig_width-1:0];
        end
   endgenerate

   generate
      if (pad_pos >= 0)
        begin:u1
           assign result[pad_pos:0] = {pad_pos{1'b0}};
        end
   endgenerate
endmodule
module zero_ext (inp, res);
   parameter signed [31:0]  old_width = 4;
   parameter signed [31:0]  new_width = 2;
   input [old_width - 1 : 0] inp;
   output [new_width - 1 : 0] res;
   wire [new_width-1:0] result;
   genvar i;
   assign res = result;
   generate
     if (new_width >= old_width)
       begin:u0
          assign result = { {(new_width-old_width){1'b0}}, inp};
       end
     else
       begin:u1
          assign result[new_width-1:0] = inp[new_width-1:0];
       end
    endgenerate
endmodule
module sign_ext (inp, res);
   parameter signed [31:0]  old_width = 4;
   parameter signed [31:0]  new_width = 2;
   input [old_width - 1 : 0] inp;
   output [new_width - 1 : 0] res;
   wire [new_width-1:0] result;
   assign res = result;
   generate
     if (new_width >= old_width)
       begin:u0
          assign result = { {(new_width-old_width){inp[old_width-1]}}, inp};
       end
     else
       begin:u1
          assign result[new_width-1:0] = inp[new_width-1:0];
       end
   endgenerate

endmodule
module extend_msb (inp, res);
    parameter signed [31:0]  old_width = 4;
    parameter signed [31:0]  new_width = 4;
    parameter signed [31:0]  new_arith = `xlSigned;
    input [old_width - 1 : 0] inp;
    output [new_width - 1 : 0] res;
    wire [new_width-1:0] result;
   assign res = result;
   generate
      if (new_arith ==`xlUnsigned)
        begin:u0
           zero_ext # (old_width, new_width)
             em_zero_ext (.inp(inp), .res(result));
        end
      else
        begin:u1
           sign_ext # (old_width, new_width)
             em_sign_ext (.inp(inp), .res(result));
        end
    endgenerate
endmodule
module align_input (inp, res);
    parameter signed [31:0]  old_width = 4;
    parameter signed [31:0]  delta = 1;
    parameter signed [31:0]  new_arith = `xlSigned;
    parameter signed [31:0]  new_width = 4;
    input [old_width - 1 : 0] inp;
    output [new_width - 1 : 0] res;
    parameter signed [31:0]  abs_delta = (delta >= 0) ? (delta) : (-delta);
    wire [new_width-1:0] result;
    wire [(old_width+abs_delta)-1:0] padded_inp;
   assign res = result;
   generate
      if (delta > 0)
        begin:u0
           pad_lsb # (old_width, old_width+delta)
             ai_pad_lsb (.inp(inp), .res(padded_inp));
           extend_msb # (old_width+delta, new_width, new_arith)
             ai_extend_msb (.inp(padded_inp), .res(result));
        end
      else
        begin:u1
           extend_msb # (old_width, new_width, new_arith)
             ai_extend_msb (.inp(inp), .res(result));
        end
   endgenerate
endmodule
module round_towards_inf (inp, res);
    parameter signed [31:0]  old_width = 4;
    parameter signed [31:0]  old_bin_pt = 2;
    parameter signed [31:0]  old_arith = `xlSigned;
    parameter signed [31:0]  new_width = 4;
    parameter signed [31:0]  new_bin_pt = 1;
    parameter signed [31:0]  new_arith = `xlSigned;
    input [old_width - 1 : 0] inp;
    output [new_width - 1 : 0] res;

   parameter signed [31:0]  right_of_dp = old_bin_pt - new_bin_pt;
   parameter signed [31:0]  abs_right_of_dp = (new_bin_pt > old_bin_pt) ? (new_bin_pt-old_bin_pt) : (old_bin_pt - new_bin_pt);
   parameter signed [31:0]  right_of_dp_2 = (right_of_dp >=2) ? right_of_dp-2 : 0;
   parameter signed [31:0]  right_of_dp_1 = (right_of_dp >=1) ? right_of_dp-1 : 0;
   reg [new_width-1:0] one_or_zero;
   wire [new_width-1:0] truncated_val;
   wire signed [new_width-1:0] result_signed;
   wire [abs_right_of_dp+old_width-1 : 0] padded_val;
   initial
     begin
        one_or_zero = {new_width{1'b0}};
     end
   generate
      if (right_of_dp >= 0)
        begin:u0
           if (new_arith ==`xlUnsigned)
             begin:u1
                zero_ext # (old_width-right_of_dp, new_width)
                  rti_zero_ext (.inp(inp[old_width-1:right_of_dp]), .res(truncated_val));
             end
           else
             begin:u2
                sign_ext # (old_width-right_of_dp, new_width)
                  rti_sign_ext (.inp(inp[old_width-1:right_of_dp]), .res(truncated_val));
             end
        end
      else
        begin:u3
           pad_lsb # (old_width, abs_right_of_dp+old_width)
             rti_pad_lsb (.inp(inp), .res(padded_val));
           if (new_arith ==`xlUnsigned)
             begin:u4
                zero_ext # (abs_right_of_dp+old_width, new_width)
                  rti_zero_ext1 (.inp(padded_val), .res(truncated_val));
             end
           else
             begin:u5
                sign_ext # (abs_right_of_dp+old_width, new_width)
                  rti_sign_ext1 (.inp(padded_val), .res(truncated_val));
             end
        end
   endgenerate
   generate
      if (new_arith == `xlSigned)
        begin:u6
           always @(inp)
             begin
                one_or_zero = {new_width{1'b0}};
               if (inp[old_width-1] == 1'b0)
                 begin
                    one_or_zero[0] = 1'b1;
                 end
               if ((right_of_dp >=2) && (right_of_dp <= old_width))
                 begin
                    if(|inp[right_of_dp_2:0] == 1'b1)
                       begin
                          one_or_zero[0] = 1'b1;
                       end
                 end
               if ((right_of_dp >=1) && (right_of_dp <= old_width))
                 begin
                    if(inp[right_of_dp_1] == 1'b0)
                      begin
                         one_or_zero[0] = 1'b0;
                      end
                 end
               else
                 begin
                    one_or_zero[0] = 1'b0;
                 end
             end
             assign result_signed = truncated_val + one_or_zero;
             assign res = result_signed;
        end

      else
        begin:u7
           always @(inp)
             begin
                one_or_zero = {new_width{1'b0}};
               if ((right_of_dp >=1) && (right_of_dp <= old_width))
                 begin
                    one_or_zero[0] = inp[right_of_dp_1];
                 end
             end
             assign res = truncated_val + one_or_zero;
        end
   endgenerate

endmodule
module round_towards_even (inp, res);
    parameter signed [31:0]  old_width = 4;
    parameter signed [31:0]  old_bin_pt = 2;
    parameter signed [31:0]  old_arith = `xlSigned;
    parameter signed [31:0]  new_width = 4;
    parameter signed [31:0]  new_bin_pt = 1;
    parameter signed [31:0]  new_arith = `xlSigned;
    input [old_width - 1 : 0] inp;
    output [new_width - 1 : 0] res;
   parameter signed [31:0]  right_of_dp = old_bin_pt - new_bin_pt;
   parameter signed [31:0]  abs_right_of_dp = (new_bin_pt > old_bin_pt) ? (new_bin_pt-old_bin_pt) : (old_bin_pt - new_bin_pt);
   parameter signed [31:0]  expected_new_width = old_width - right_of_dp + 1;
   reg [new_width-1:0] one_or_zero;
   wire signed [new_width-1:0] result_signed;
   wire [new_width-1:0] truncated_val;
   wire [abs_right_of_dp+old_width-1 : 0] padded_val;
   initial
     begin
      one_or_zero = { new_width{1'b0}};
     end

   generate
      if (right_of_dp >= 0)
        begin:u0
           if (new_arith == `xlUnsigned)
             begin:u1
                zero_ext # (old_width-right_of_dp, new_width)
                            rte_zero_ext (.inp(inp[old_width-1:right_of_dp]), .res(truncated_val));
             end
           else
             begin:u2
                sign_ext # (old_width-right_of_dp, new_width)
                            rte_sign_ext (.inp(inp[old_width-1:right_of_dp]), .res(truncated_val));
             end
        end

      else
        begin:u3
           pad_lsb # (old_width, abs_right_of_dp+old_width)
                            rte_pad_lsb (.inp(inp), .res(padded_val));
           if (new_arith == `xlUnsigned)
             begin:u4
                zero_ext # (abs_right_of_dp+old_width, new_width)
                            rte_zero_ext1 (.inp(padded_val), .res(truncated_val));
             end
           else
             begin:u5
                sign_ext # (abs_right_of_dp+old_width, new_width)
                            rte_sign_ext1 (.inp(padded_val), .res(truncated_val));
             end
        end
   endgenerate

   generate
      if ((right_of_dp ==1) && (right_of_dp <= old_width))
        begin:u6a
           always @(inp)
             begin
                one_or_zero = { new_width{1'b0}};
                if(inp[right_of_dp-1] == 1'b1)
                  begin
                     one_or_zero[0] = inp[right_of_dp];
                  end
                else
                  begin
                     one_or_zero[0] = inp[right_of_dp-1];
                  end
             end
       end
      else if ((right_of_dp >=2) && (right_of_dp <= old_width))
        begin:u6b
           always @(inp)
             begin
                one_or_zero = { new_width{1'b0}};
                if( (inp[right_of_dp-1] == 'b1) && !(|inp[right_of_dp-2:0]) )
                  begin
                     one_or_zero[0] = inp[right_of_dp];
                  end
                else
                  begin
                     one_or_zero[0] = inp[right_of_dp-1];
                  end
             end
       end
      else
        begin:u7
            always @(inp)
             begin
                one_or_zero = { new_width{1'b0}};
             end
        end
   endgenerate

   generate
      if (new_arith == `xlSigned)
        begin:u8
           assign result_signed = truncated_val + one_or_zero;
           assign res = result_signed;
        end
      else
        begin:u9
           assign res = truncated_val + one_or_zero;
        end
   endgenerate

endmodule
module trunc (inp, res);
    parameter signed [31:0]  old_width = 4;
    parameter signed [31:0]  old_bin_pt = 2;
    parameter signed [31:0]  old_arith = `xlSigned;
    parameter signed [31:0]  new_width = 4;
    parameter signed [31:0]  new_bin_pt = 1;
    parameter signed [31:0]  new_arith = `xlSigned;
    input [old_width - 1 : 0] inp;
    output [new_width - 1 : 0] res;

   parameter signed [31:0]  right_of_dp = old_bin_pt - new_bin_pt;
   parameter signed [31:0]  abs_right_of_dp = (new_bin_pt > old_bin_pt) ? (new_bin_pt-old_bin_pt) : (old_bin_pt - new_bin_pt);
   wire [new_width-1:0] result;
   wire [abs_right_of_dp+old_width-1 : 0] padded_val;
   assign res = result;
   generate
      if (new_bin_pt > old_bin_pt)
        begin:tr_u2
           pad_lsb # (old_width, abs_right_of_dp+old_width)
             tr_pad_lsb (.inp(inp), .res(padded_val));
           extend_msb # (old_width+abs_right_of_dp, new_width, new_arith)
             tr_extend_msb (.inp(padded_val), .res(result));
        end
      else
        begin:tr_u1
           extend_msb # (old_width-right_of_dp, new_width, new_arith)
             tr_extend_msb (.inp(inp[old_width-1:right_of_dp]), .res(result));
        end
   endgenerate

endmodule
module saturation_arith (inp, res);
    parameter signed [31:0]  old_width = 4;
    parameter signed [31:0]  old_bin_pt = 2;
    parameter signed [31:0]  old_arith = `xlSigned;
    parameter signed [31:0]  new_width = 4;
    parameter signed [31:0]  new_bin_pt = 1;
    parameter signed [31:0]  new_arith = `xlSigned;
    input [old_width - 1 : 0] inp;
    output [new_width - 1 : 0] res;
   parameter signed [31:0]  abs_right_of_dp = (new_bin_pt > old_bin_pt) ? (new_bin_pt-old_bin_pt) : (old_bin_pt - new_bin_pt);
   parameter signed [31:0]  abs_width = (new_width > old_width) ? (new_width-old_width) : 1;
   parameter signed [31:0]  abs_new_width = (old_width > new_width) ? new_width : 1;
   reg overflow;
   reg [old_width-1:0] vec;
   reg [new_width-1:0] result;
   assign res = result;
   generate
      if (old_width > new_width)
        begin:sa_u0
           always @ (inp)
             begin
                vec = inp;
                overflow = 1;
                if ( (old_arith == `xlSigned) && (new_arith == `xlSigned) )
                  begin
                    if (~|inp[old_width-1:abs_new_width-1] || &inp[old_width-1:abs_new_width-1])
                     begin
                       overflow = 0;
                     end
                 end

                if ( (old_arith == `xlSigned) && (new_arith == `xlUnsigned))
                   begin
                    if (~|inp[old_width-1 : abs_new_width])
                    begin
                       overflow = 0;
                    end
                end

                if ((old_arith == `xlUnsigned) &&  (new_arith == `xlUnsigned))
                  begin
                    if (~|inp[old_width-1 : abs_new_width])
                     begin
                       overflow = 0;
                     end
                  end

               if ( (old_arith == `xlUnsigned) && (new_arith == `xlSigned))
                 begin
                  if (~|inp[old_width-1:abs_new_width-1] || &inp[old_width-1:abs_new_width-1])
                    begin
                      overflow = 0;
                    end
                 end
               if (overflow == 1)
                 begin
                   if (new_arith == `xlSigned)
                     begin
                       if (inp[old_width-1] == 'b0)
                         begin
                           result = (new_width ==1) ? 1'b0 : {1'b0, {(new_width-1){1'b1}} };
                         end
                      else
                        begin
                          result = (new_width ==1) ? 1'b1 : {1'b1, {(new_width-1){1'b0}} };
                       end
                     end
                   else
                     begin
                       if ((old_arith == `xlSigned) && (inp[old_width-1] == 'b1))
                         begin
                           result = {new_width{1'b0}};
                         end
                       else
                         begin
                           result = {new_width{1'b1}};
                         end
                     end
                 end
               else
                 begin
                    if ( (old_arith == `xlSigned) && (new_arith == `xlUnsigned) && (inp[old_width-1] == 'b1) )
                    begin
                      vec = {old_width{1'b0}};
                    end
                    result = vec[new_width-1:0];
                 end
             end
        end
   endgenerate
   generate
      if (new_width > old_width)
        begin:sa_u1
         always @ (inp)
           begin
            vec = inp;
            if ( (old_arith == `xlSigned) && (new_arith == `xlUnsigned) && (inp[old_width-1] == 1'b1) )
              begin
                vec = {old_width{1'b0}};
              end
              if (new_arith == `xlUnsigned)
                begin
                  result = { {abs_width{1'b0}}, vec};
                end
              else
                begin
                  result = { {abs_width{inp[old_width-1]}}, vec};
                end
           end
       end
   endgenerate

   generate
      if (new_width == old_width)
        begin:sa_u2
         always @ (inp)
           begin
             if ( (old_arith == `xlSigned) && (new_arith == `xlUnsigned) && (inp[old_width-1] == 'b1) )
               begin
                 result = {old_width{1'b0}};
               end
             else
               begin
                 result = inp;
               end
           end
        end
   endgenerate

endmodule
module wrap_arith (inp, res);
    parameter signed [31:0]  old_width = 4;
    parameter signed [31:0]  old_bin_pt = 2;
    parameter signed [31:0]  old_arith = `xlSigned;
    parameter signed [31:0]  new_width = 4;
    parameter signed [31:0]  new_bin_pt = 1;
    parameter signed [31:0]  new_arith = `xlSigned;
    parameter signed [31:0]  result_arith = ((old_arith==`xlSigned)&&(new_arith==`xlUnsigned))? `xlSigned : new_arith;
    input [old_width - 1 : 0] inp;
    output [new_width - 1 : 0] res;
   wire [new_width-1:0] result;
   cast # (old_width, old_bin_pt, new_width, new_bin_pt, result_arith)
     wrap_cast (.inp(inp), .res(result));
   assign res = result;

endmodule
module convert_type (inp, res);
    parameter signed [31:0]  old_width = 4;
    parameter signed [31:0]  old_bin_pt = 2;
    parameter signed [31:0]  old_arith = `xlSigned;
    parameter signed [31:0]  new_width = 4;
    parameter signed [31:0]  new_bin_pt = 1;
    parameter signed [31:0]  new_arith = `xlSigned;
    parameter signed [31:0]  quantization = `xlTruncate;
    parameter signed [31:0]  overflow = `xlWrap;
    input [old_width - 1 : 0] inp;
    output [new_width - 1 : 0] res;

   parameter signed [31:0]  fp_width = old_width + 2;
   parameter signed [31:0]  fp_bin_pt = old_bin_pt;
   parameter signed [31:0]  fp_arith = old_arith;
   parameter signed [31:0]  q_width = fp_width + new_bin_pt - old_bin_pt;
   parameter signed [31:0]  q_bin_pt = new_bin_pt;
   parameter signed [31:0]  q_arith = old_arith;
   wire [fp_width-1:0] full_precision_result;
   wire [new_width-1:0] result;
   wire [q_width-1:0] quantized_result;
   assign res = result;
   cast # (old_width, old_bin_pt, fp_width, fp_bin_pt, fp_arith)
     fp_cast (.inp(inp), .res(full_precision_result));
   generate
      if (quantization == `xlRound)
        begin:ct_u0
           round_towards_inf # (fp_width, fp_bin_pt, fp_arith, q_width, q_bin_pt, q_arith)
             quant_rtf (.inp(full_precision_result), .res(quantized_result));
        end
   endgenerate

   generate
      if (quantization == `xlRoundBanker)
        begin:ct_u1
           round_towards_even # (fp_width, fp_bin_pt, fp_arith, q_width, q_bin_pt, q_arith)
             quant_rte (.inp(full_precision_result), .res(quantized_result));
        end
   endgenerate

   generate
      if (quantization == `xlTruncate)
        begin:ct_u2
           trunc # (fp_width, fp_bin_pt, fp_arith, q_width, q_bin_pt, q_arith)
             quant_tr (.inp(full_precision_result), .res(quantized_result));
        end
   endgenerate

   generate
      if (overflow == `xlSaturate)
        begin:ct_u3
           saturation_arith # (q_width, q_bin_pt, q_arith, new_width, new_bin_pt, new_arith)
            ovflo_sat (.inp(quantized_result), .res(result));
        end
   endgenerate

   generate
      if ((overflow == `xlWrap) || (overflow == 3))
        begin:ct_u4
           wrap_arith # (q_width, q_bin_pt, q_arith, new_width, new_bin_pt, new_arith)
             ovflo_wrap (.inp(quantized_result), .res(result));
        end
   endgenerate

endmodule
//synopsys translate_off
`timescale 1 ns / 10 ps
module clock_pkg();
   wire int_clk;
endmodule
//synopsys translate_on
`endif


module constant_204e9a8bfd (
  output [(6 - 1):0] op,
  input clk,
  input ce,
  input clr);
  localparam [(6 - 1):0] const_value = 6'b000111;
  assign op = 6'b000111;
endmodule
 



module constant_752327bec1 (
  output [(6 - 1):0] op,
  input clk,
  input ce,
  input clr);
  localparam [(6 - 1):0] const_value = 6'b011111;
  assign op = 6'b011111;
endmodule
 


//-----------------------------------------------------------------
// System Generator version 10.1.3 VERILOG source file.
//
// Copyright(C) 2008 by Xilinx, Inc.  All rights reserved.  This
// text/file contains proprietary, confidential information of Xilinx,
// Inc., is distributed under license from Xilinx, Inc., and may be used,
// copied and/or disclosed only pursuant to the terms of a valid license
// agreement with Xilinx, Inc.  Xilinx hereby grants you a license to use
// this text/file solely for design, simulation, implementation and
// creation of design files limited to Xilinx devices or technologies.
// Use with non-Xilinx devices or technologies is expressly prohibited
// and immediately terminates your license unless covered by a separate
// agreement.
//
// Xilinx is providing this design, code, or information "as is" solely
// for use in developing programs and solutions for Xilinx devices.  By
// providing this design, code, or information as one possible
// implementation of this feature, application or standard, Xilinx is
// making no representation that this implementation is free from any
// claims of infringement.  You are responsible for obtaining any rights
// you may require for your implementation.  Xilinx expressly disclaims
// any warranty whatsoever with respect to the adequacy of the
// implementation, including but not limited to warranties of
// merchantability or fitness for a particular purpose.
//
// Xilinx products are not intended for use in life support appliances,
// devices, or systems.  Use in such applications is expressly prohibited.
//
// Any modifications that are made to the source code are done at the user's
// sole risk and will be unsupported.
//
// This copyright and support notice must be retained as part of this
// text at all times.  (c) Copyright 1995-2008 Xilinx, Inc.  All rights
// reserved.
//-----------------------------------------------------------------
module xlcounter_free (ce, clr, clk, op, up, load, din, en, rst);
parameter core_name0= "";
parameter op_width= 5;
parameter op_arith= `xlSigned;
input ce, clr, clk;
input up, load;
input [op_width-1:0] din;
input en, rst;
output [op_width-1:0] op;
parameter [(8*op_width)-1:0] oneStr = { op_width{"1"}};
wire  core_sinit;
wire  core_ce;
wire [op_width-1:0] op_net;
   assign core_ce = ce & en;
   assign core_sinit = (clr | rst) & ce;
   assign op = op_net;


generate
  if (core_name0 == "binary_counter_virtex4_10_0_7f29bec8df1c7606")
    begin:comp0
    binary_counter_virtex4_10_0_7f29bec8df1c7606 core_instance0 (
        .clk(clk),
        .ce(core_ce),
        .sinit(core_sinit),
        .q(op_net)
      );
  end
  if (core_name0 == "binary_counter_virtex4_10_0_0e77c8b832175d2c")
    begin:comp1
    binary_counter_virtex4_10_0_0e77c8b832175d2c core_instance1 (
        .clk(clk),
        .ce(core_ce),
        .sinit(core_sinit),
        .q(op_net)
      );
  end
  if (core_name0 == "binary_counter_virtex4_10_0_407917162894eacc")
    begin:comp2
    binary_counter_virtex4_10_0_407917162894eacc core_instance2 (
        .clk(clk),
        .ce(core_ce),
        .sinit(core_sinit),
        .q(op_net)
      );
  end
endgenerate
endmodule

//-----------------------------------------------------------------
// System Generator version 10.1.3 VERILOG source file.
//
// Copyright(C) 2008 by Xilinx, Inc.  All rights reserved.  This
// text/file contains proprietary, confidential information of Xilinx,
// Inc., is distributed under license from Xilinx, Inc., and may be used,
// copied and/or disclosed only pursuant to the terms of a valid license
// agreement with Xilinx, Inc.  Xilinx hereby grants you a license to use
// this text/file solely for design, simulation, implementation and
// creation of design files limited to Xilinx devices or technologies.
// Use with non-Xilinx devices or technologies is expressly prohibited
// and immediately terminates your license unless covered by a separate
// agreement.
//
// Xilinx is providing this design, code, or information "as is" solely
// for use in developing programs and solutions for Xilinx devices.  By
// providing this design, code, or information as one possible
// implementation of this feature, application or standard, Xilinx is
// making no representation that this implementation is free from any
// claims of infringement.  You are responsible for obtaining any rights
// you may require for your implementation.  Xilinx expressly disclaims
// any warranty whatsoever with respect to the adequacy of the
// implementation, including but not limited to warranties of
// merchantability or fitness for a particular purpose.
//
// Xilinx products are not intended for use in life support appliances,
// devices, or systems.  Use in such applications is expressly prohibited.
//
// Any modifications that are made to the source code are done at the user's
// sole risk and will be unsupported.
//
// This copyright and support notice must be retained as part of this
// text at all times.  (c) Copyright 1995-2008 Xilinx, Inc.  All rights
// reserved.
//-----------------------------------------------------------------
module xldelay #(parameter width = -1, latency = -1, reg_retiming = 0)
  (input [width-1:0] d,
   input ce, clk, en,
   output [width-1:0] q);
generate
  if ((latency == 0) || (reg_retiming == 0))
  begin:srl_delay
    synth_reg # (width, latency)
      reg1 (
        .i(d),
        .ce(ce & en),
        .clr(1'b0),
        .clk(clk),
        .o(q));
  end

  if ((latency>=1) && (reg_retiming))
  begin:reg_delay
    synth_reg_reg # (width, latency)
      reg2 (
        .i(d),
        .ce(ce & en),
        .clr(1'b0),
        .clk(clk),
        .o(q));
  end
endgenerate
endmodule


module logical_28d385d867 (
  input [(1 - 1):0] d0,
  input [(1 - 1):0] d1,
  output [(1 - 1):0] y,
  input clk,
  input ce,
  input clr);
  wire d0_1_24;
  wire d1_1_27;
  wire fully_2_1_bit;
  assign d0_1_24 = d0;
  assign d1_1_27 = d1;
  assign fully_2_1_bit = d0_1_24 & d1_1_27;
  assign y = fully_2_1_bit;
endmodule
 



module relational_440eb07a2f (
  input [(3 - 1):0] a,
  input [(6 - 1):0] b,
  input [(1 - 1):0] en,
  output [(1 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire [(3 - 1):0] a_1_31;
  wire [(6 - 1):0] b_1_34;
  wire en_1_37;
  reg op_mem_32_22[0:(1 - 1)];
  initial
    begin
      op_mem_32_22[0] = 1'b0;
    end
  wire op_mem_32_22_front_din;
  wire op_mem_32_22_back;
  wire op_mem_32_22_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value = 1'b1;
  wire [(6 - 1):0] cast_14_12;
  wire result_14_3_rel;
  reg op_mem_shift_join_34_3;
  reg op_mem_shift_join_34_3_en;
  assign a_1_31 = a;
  assign b_1_34 = b;
  assign en_1_37 = en;
  assign op_mem_32_22_back = op_mem_32_22[0];
  always @(posedge clk)
    begin:proc_op_mem_32_22
      integer i;
      if (((ce == 1'b1) && (op_mem_32_22_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_32_22[0] <= op_mem_32_22_front_din;
        end
    end
  assign cast_14_12 = {3'b000, a_1_31[2:0]};
  assign result_14_3_rel = cast_14_12 != b_1_34;
  always @(en_1_37 or result_14_3_rel)
    begin:proc_if_34_3
      if (en_1_37)
        begin
          op_mem_shift_join_34_3_en = 1'b1;
        end
      else 
        begin
          op_mem_shift_join_34_3_en = 1'b0;
        end
      op_mem_shift_join_34_3 = result_14_3_rel;
    end
  assign op_mem_32_22_front_din = op_mem_shift_join_34_3;
  assign op_mem_32_22_push_front_pop_back_en = op_mem_shift_join_34_3_en;
  assign op = op_mem_32_22_back;
endmodule
 



module relational_7e0e56c195 (
  input [(5 - 1):0] a,
  input [(6 - 1):0] b,
  input [(1 - 1):0] en,
  output [(1 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire [(5 - 1):0] a_1_31;
  wire [(6 - 1):0] b_1_34;
  wire en_1_37;
  reg op_mem_32_22[0:(1 - 1)];
  initial
    begin
      op_mem_32_22[0] = 1'b0;
    end
  wire op_mem_32_22_front_din;
  wire op_mem_32_22_back;
  wire op_mem_32_22_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value = 1'b1;
  wire [(6 - 1):0] cast_14_12;
  wire result_14_3_rel;
  reg op_mem_shift_join_34_3;
  reg op_mem_shift_join_34_3_en;
  assign a_1_31 = a;
  assign b_1_34 = b;
  assign en_1_37 = en;
  assign op_mem_32_22_back = op_mem_32_22[0];
  always @(posedge clk)
    begin:proc_op_mem_32_22
      integer i;
      if (((ce == 1'b1) && (op_mem_32_22_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_32_22[0] <= op_mem_32_22_front_din;
        end
    end
  assign cast_14_12 = {1'b0, a_1_31[4:0]};
  assign result_14_3_rel = cast_14_12 != b_1_34;
  always @(en_1_37 or result_14_3_rel)
    begin:proc_if_34_3
      if (en_1_37)
        begin
          op_mem_shift_join_34_3_en = 1'b1;
        end
      else 
        begin
          op_mem_shift_join_34_3_en = 1'b0;
        end
      op_mem_shift_join_34_3 = result_14_3_rel;
    end
  assign op_mem_32_22_front_din = op_mem_shift_join_34_3;
  assign op_mem_32_22_push_front_pop_back_en = op_mem_shift_join_34_3_en;
  assign op = op_mem_32_22_back;
endmodule
 


//-----------------------------------------------------------------
// System Generator version 10.1.3 VERILOG source file.
//
// Copyright(C) 2008 by Xilinx, Inc.  All rights reserved.  This
// text/file contains proprietary, confidential information of Xilinx,
// Inc., is distributed under license from Xilinx, Inc., and may be used,
// copied and/or disclosed only pursuant to the terms of a valid license
// agreement with Xilinx, Inc.  Xilinx hereby grants you a license to use
// this text/file solely for design, simulation, implementation and
// creation of design files limited to Xilinx devices or technologies.
// Use with non-Xilinx devices or technologies is expressly prohibited
// and immediately terminates your license unless covered by a separate
// agreement.
//
// Xilinx is providing this design, code, or information "as is" solely
// for use in developing programs and solutions for Xilinx devices.  By
// providing this design, code, or information as one possible
// implementation of this feature, application or standard, Xilinx is
// making no representation that this implementation is free from any
// claims of infringement.  You are responsible for obtaining any rights
// you may require for your implementation.  Xilinx expressly disclaims
// any warranty whatsoever with respect to the adequacy of the
// implementation, including but not limited to warranties of
// merchantability or fitness for a particular purpose.
//
// Xilinx products are not intended for use in life support appliances,
// devices, or systems.  Use in such applications is expressly prohibited.
//
// Any modifications that are made to the source code are done at the user's
// sole risk and will be unsupported.
//
// This copyright and support notice must be retained as part of this
// text at all times.  (c) Copyright 1995-2008 Xilinx, Inc.  All rights
// reserved.
//-----------------------------------------------------------------
module  xlslice  (x, y);
parameter new_msb= 9;
parameter new_lsb= 1;
parameter x_width= 16;
parameter y_width= 8;
input [x_width-1:0] x;
output [y_width-1:0] y;
assign y = x[new_msb:new_lsb];
endmodule


module concat_fb3e05a33e (
  input [(8 - 1):0] in0,
  input [(2 - 1):0] in1,
  output [(10 - 1):0] y,
  input clk,
  input ce,
  input clr);
  wire [(8 - 1):0] in0_1_23;
  wire [(2 - 1):0] in1_1_27;
  wire [(10 - 1):0] y_2_1_concat;
  assign in0_1_23 = in0;
  assign in1_1_27 = in1;
  assign y_2_1_concat = {in0_1_23, in1_1_27};
  assign y = y_2_1_concat;
endmodule
 



module constant_9e0724a33a (
  output [(2 - 1):0] op,
  input clk,
  input ce,
  input clr);
  localparam [(2 - 1):0] const_value = 2'b00;
  assign op = 2'b00;
endmodule
 



module relational_d74f8dcf86 (
  input [(10 - 1):0] a,
  input [(10 - 1):0] b,
  output [(1 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire [(10 - 1):0] a_1_31;
  wire [(10 - 1):0] b_1_34;
  reg op_mem_32_22[0:(1 - 1)];
  initial
    begin
      op_mem_32_22[0] = 1'b0;
    end
  wire op_mem_32_22_front_din;
  wire op_mem_32_22_back;
  wire op_mem_32_22_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value = 1'b1;
  wire result_12_3_rel;
  assign a_1_31 = a;
  assign b_1_34 = b;
  assign op_mem_32_22_back = op_mem_32_22[0];
  always @(posedge clk)
    begin:proc_op_mem_32_22
      integer i;
      if (((ce == 1'b1) && (op_mem_32_22_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_32_22[0] <= op_mem_32_22_front_din;
        end
    end
  assign result_12_3_rel = a_1_31 == b_1_34;
  assign op_mem_32_22_front_din = result_12_3_rel;
  assign op_mem_32_22_push_front_pop_back_en = 1'b1;
  assign op = op_mem_32_22_back;
endmodule
 



module logical_7970a672aa (
  input [(1 - 1):0] d0,
  input [(1 - 1):0] d1,
  output [(1 - 1):0] y,
  input clk,
  input ce,
  input clr);
  wire d0_1_24;
  wire d1_1_27;
  wire fully_2_1_bit;
  assign d0_1_24 = d0;
  assign d1_1_27 = d1;
  assign fully_2_1_bit = d0_1_24 | d1_1_27;
  assign y = fully_2_1_bit;
endmodule
 



module constant_787b59efba (
  output [(10 - 1):0] op,
  input clk,
  input ce,
  input clr);
  localparam [(10 - 1):0] const_value = 10'b0000000010;
  assign op = 10'b0000000010;
endmodule
 


//-----------------------------------------------------------------
// System Generator version 10.1.3 VERILOG source file.
//
// Copyright(C) 2008 by Xilinx, Inc.  All rights reserved.  This
// text/file contains proprietary, confidential information of Xilinx,
// Inc., is distributed under license from Xilinx, Inc., and may be used,
// copied and/or disclosed only pursuant to the terms of a valid license
// agreement with Xilinx, Inc.  Xilinx hereby grants you a license to use
// this text/file solely for design, simulation, implementation and
// creation of design files limited to Xilinx devices or technologies.
// Use with non-Xilinx devices or technologies is expressly prohibited
// and immediately terminates your license unless covered by a separate
// agreement.
//
// Xilinx is providing this design, code, or information "as is" solely
// for use in developing programs and solutions for Xilinx devices.  By
// providing this design, code, or information as one possible
// implementation of this feature, application or standard, Xilinx is
// making no representation that this implementation is free from any
// claims of infringement.  You are responsible for obtaining any rights
// you may require for your implementation.  Xilinx expressly disclaims
// any warranty whatsoever with respect to the adequacy of the
// implementation, including but not limited to warranties of
// merchantability or fitness for a particular purpose.
//
// Xilinx products are not intended for use in life support appliances,
// devices, or systems.  Use in such applications is expressly prohibited.
//
// Any modifications that are made to the source code are done at the user's
// sole risk and will be unsupported.
//
// This copyright and support notice must be retained as part of this
// text at all times.  (c) Copyright 1995-2008 Xilinx, Inc.  All rights
// reserved.
//-----------------------------------------------------------------
module xladdsubv10_0 (a, b, c_in, ce, clr, clk, rst, en, c_out, s);
parameter core_name0= "";
parameter a_width= 16;
parameter signed a_bin_pt= 4;
parameter a_arith= `xlUnsigned;
parameter c_in_width= 16;
parameter c_in_bin_pt= 4;
parameter c_in_arith= `xlUnsigned;
parameter c_out_width= 16;
parameter c_out_bin_pt= 4;
parameter c_out_arith= `xlUnsigned;
parameter b_width= 8;
parameter signed b_bin_pt= 2;
parameter b_arith= `xlUnsigned;
parameter s_width= 17;
parameter s_bin_pt= 4;
parameter s_arith= `xlUnsigned;
parameter rst_width= 1;
parameter rst_bin_pt= 0;
parameter rst_arith= `xlUnsigned;
parameter en_width= 1;
parameter en_bin_pt= 0;
parameter en_arith= `xlUnsigned;
parameter full_s_width= 17;
parameter full_s_arith= `xlUnsigned;
parameter mode= `xlAddMode;
parameter extra_registers= 0;
parameter latency= 0;
parameter quantization= `xlTruncate;
parameter overflow= `xlWrap;
parameter c_a_width= 16;
parameter c_b_width= 8;
parameter c_a_type= 1;
parameter c_b_type= 1;
parameter c_has_sclr= 0;
parameter c_has_ce= 0;
parameter c_latency= 0;
parameter c_output_width= 17;
parameter c_enable_rlocs= 1;
parameter c_has_c_in= 0;
parameter c_has_c_out= 0;
input [a_width-1:0] a;
input [b_width-1:0] b;
input c_in, ce, clr, clk, rst, en;
output c_out;
output [s_width-1:0] s;
parameter full_a_width = full_s_width;
parameter full_b_width = full_s_width;
parameter full_s_bin_pt = (a_bin_pt > b_bin_pt) ? a_bin_pt : b_bin_pt;
wire [full_a_width-1:0] full_a;
wire [full_b_width-1:0] full_b;
wire [full_s_width-1:0] full_s;
wire [full_s_width-1:0] core_s;
wire [s_width-1:0] conv_s;
wire  temp_cout;
wire  real_a,real_b,real_s;
wire  internal_clr;
wire  internal_ce;
wire  extra_reg_ce;
wire  override;
wire  logic1;
wire  temp_cin;
assign internal_clr = (clr | rst) & ce;
assign internal_ce = ce & en;
assign logic1 = 1'b1;
assign temp_cin = (c_has_c_in) ? c_in : 1'b0;
align_input # (a_width, b_bin_pt - a_bin_pt, a_arith, full_a_width)
align_inp_a(.inp(a),.res(full_a));
align_input # (b_width, a_bin_pt - b_bin_pt, b_arith, full_b_width)
align_inp_b(.inp(b),.res(full_b));
convert_type # (full_s_width, full_s_bin_pt, full_s_arith, s_width,
                s_bin_pt, s_arith, quantization, overflow)
conv_typ_s(.inp(core_s),.res(conv_s));
generate
  if (core_name0 == "adder_subtracter_virtex4_10_0_80b315fd28a09ef0")
    begin:comp0
    adder_subtracter_virtex4_10_0_80b315fd28a09ef0 core_instance0 (
         .a(full_a),
         .s(core_s),
         .b(full_b)
      );
  end

endgenerate
generate
  if (extra_registers > 0)
  begin:latency_test

    if (c_latency > 1)
    begin:override_test
      synth_reg # (1, c_latency)
        override_pipe (
          .i(logic1),
          .ce(internal_ce),
          .clr(internal_clr),
          .clk(clk),
          .o(override));
      assign extra_reg_ce = ce & en & override;
    end
    if ((c_latency == 0) || (c_latency == 1))
    begin:no_override
      assign extra_reg_ce = ce & en;
    end
    synth_reg # (s_width, extra_registers)
      extra_reg (
        .i(conv_s),
        .ce(extra_reg_ce),
        .clr(internal_clr),
        .clk(clk),
        .o(s));
    if (c_has_c_out == 1)
    begin:cout_test
      synth_reg # (1, extra_registers)
        c_out_extra_reg (
          .i(temp_cout),
          .ce(extra_reg_ce),
          .clr(internal_clr),
          .clk(clk),
          .o(c_out));
    end

  end
endgenerate
generate
  if ((latency == 0) || (extra_registers == 0))
  begin:latency_s
    assign s = conv_s;
  end
endgenerate
generate
  if (((latency == 0) || (extra_registers == 0)) &&
      (c_has_c_out == 1))
  begin:latency0
    assign c_out = temp_cout;
  end
endgenerate
generate
  if (c_has_c_out == 0)
  begin:tie_dangling_cout
    assign c_out = 0;
  end
endgenerate
endmodule


module concat_ba8a620a74 (
  input [(2 - 1):0] in0,
  input [(8 - 1):0] in1,
  output [(10 - 1):0] y,
  input clk,
  input ce,
  input clr);
  wire [(2 - 1):0] in0_1_23;
  wire [(8 - 1):0] in1_1_27;
  wire [(10 - 1):0] y_2_1_concat;
  assign in0_1_23 = in0;
  assign in1_1_27 = in1;
  assign y_2_1_concat = {in0_1_23, in1_1_27};
  assign y = y_2_1_concat;
endmodule
 



module inverter_33a63b558a (
  input [(1 - 1):0] ip,
  output [(1 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire ip_1_26;
  reg op_mem_22_20[0:(1 - 1)];
  initial
    begin
      op_mem_22_20[0] = 1'b0;
    end
  wire op_mem_22_20_front_din;
  wire op_mem_22_20_back;
  wire op_mem_22_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value = 1'b1;
  wire internal_ip_12_1_bitnot;
  assign ip_1_26 = ip;
  assign op_mem_22_20_back = op_mem_22_20[0];
  always @(posedge clk)
    begin:proc_op_mem_22_20
      integer i;
      if (((ce == 1'b1) && (op_mem_22_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_22_20[0] <= op_mem_22_20_front_din;
        end
    end
  assign internal_ip_12_1_bitnot = ~ip_1_26;
  assign op_mem_22_20_push_front_pop_back_en = 1'b0;
  assign op = internal_ip_12_1_bitnot;
endmodule
 



module logical_818bd6d54b (
  input [(1 - 1):0] d0,
  input [(1 - 1):0] d1,
  input [(1 - 1):0] d2,
  input [(1 - 1):0] d3,
  output [(1 - 1):0] y,
  input clk,
  input ce,
  input clr);
  wire d0_1_24;
  wire d1_1_27;
  wire d2_1_30;
  wire d3_1_33;
  wire fully_2_1_bit;
  assign d0_1_24 = d0;
  assign d1_1_27 = d1;
  assign d2_1_30 = d2;
  assign d3_1_33 = d3;
  assign fully_2_1_bit = d0_1_24 & d1_1_27 & d2_1_30 & d3_1_33;
  assign y = fully_2_1_bit;
endmodule
 


//-----------------------------------------------------------------
// System Generator version 10.1.3 VERILOG source file.
//
// Copyright(C) 2008 by Xilinx, Inc.  All rights reserved.  This
// text/file contains proprietary, confidential information of Xilinx,
// Inc., is distributed under license from Xilinx, Inc., and may be used,
// copied and/or disclosed only pursuant to the terms of a valid license
// agreement with Xilinx, Inc.  Xilinx hereby grants you a license to use
// this text/file solely for design, simulation, implementation and
// creation of design files limited to Xilinx devices or technologies.
// Use with non-Xilinx devices or technologies is expressly prohibited
// and immediately terminates your license unless covered by a separate
// agreement.
//
// Xilinx is providing this design, code, or information "as is" solely
// for use in developing programs and solutions for Xilinx devices.  By
// providing this design, code, or information as one possible
// implementation of this feature, application or standard, Xilinx is
// making no representation that this implementation is free from any
// claims of infringement.  You are responsible for obtaining any rights
// you may require for your implementation.  Xilinx expressly disclaims
// any warranty whatsoever with respect to the adequacy of the
// implementation, including but not limited to warranties of
// merchantability or fitness for a particular purpose.
//
// Xilinx products are not intended for use in life support appliances,
// devices, or systems.  Use in such applications is expressly prohibited.
//
// Any modifications that are made to the source code are done at the user's
// sole risk and will be unsupported.
//
// This copyright and support notice must be retained as part of this
// text at all times.  (c) Copyright 1995-2008 Xilinx, Inc.  All rights
// reserved.
//-----------------------------------------------------------------
`timescale 1 ns / 10 ps
module xlregister (d, rst, en, ce, clk, q);
   parameter d_width = 5;
   parameter init_value = 'b0;

   input [d_width-1:0] d;
   input rst, en, ce, clk;
   output [d_width-1:0] q;
   wire internal_clr, internal_ce;
   assign internal_clr = rst & ce;
   assign internal_ce  = ce & en;

   synth_reg_w_init #(.width(d_width),
                      .init_index(2),
                      .init_value(init_value),
                      .latency(1))
   synth_reg_inst(.i(d),
                  .ce(internal_ce),
                  .clr(internal_clr),
                  .clk(clk),
                  .o(q));
endmodule


module mux_485ea02169 (
  input [(1 - 1):0] sel,
  input [(1 - 1):0] d0,
  input [(1 - 1):0] d1,
  output [(1 - 1):0] y,
  input clk,
  input ce,
  input clr);
  wire sel_1_20;
  wire [(1 - 1):0] d0_1_24;
  wire [(1 - 1):0] d1_1_27;
  wire [(1 - 1):0] sel_internal_2_1_convert;
  reg [(1 - 1):0] unregy_join_6_1;
  assign sel_1_20 = sel;
  assign d0_1_24 = d0;
  assign d1_1_27 = d1;
  assign sel_internal_2_1_convert = {sel_1_20};
  always @(d0_1_24 or d1_1_27 or sel_internal_2_1_convert)
    begin:proc_switch_6_1
      case (sel_internal_2_1_convert)
        1'b0 :
          begin
            unregy_join_6_1 = d0_1_24;
          end
        default:
          begin
            unregy_join_6_1 = d1_1_27;
          end
      endcase
    end
  assign y = unregy_join_6_1;
endmodule
 



module constant_9cf45430cd (
  output [(1 - 1):0] op,
  input clk,
  input ce,
  input clr);
  localparam [(1 - 1):0] const_value = 1'b1;
  assign op = 1'b1;
endmodule
 



module constant_67d0b5242e (
  output [(8 - 1):0] op,
  input clk,
  input ce,
  input clr);
  localparam [(8 - 1):0] const_value = 8'b00000010;
  assign op = 8'b00000010;
endmodule
 



module mux_f80a0abc7d (
  input [(3 - 1):0] sel,
  input [(8 - 1):0] d0,
  input [(8 - 1):0] d1,
  input [(8 - 1):0] d2,
  input [(8 - 1):0] d3,
  input [(8 - 1):0] d4,
  input [(8 - 1):0] d5,
  input [(8 - 1):0] d6,
  input [(8 - 1):0] d7,
  output [(8 - 1):0] y,
  input clk,
  input ce,
  input clr);
  wire [(3 - 1):0] sel_1_20;
  wire [(8 - 1):0] d0_1_24;
  wire [(8 - 1):0] d1_1_27;
  wire [(8 - 1):0] d2_1_30;
  wire [(8 - 1):0] d3_1_33;
  wire [(8 - 1):0] d4_1_36;
  wire [(8 - 1):0] d5_1_39;
  wire [(8 - 1):0] d6_1_42;
  wire [(8 - 1):0] d7_1_45;
  reg [(8 - 1):0] unregy_join_6_1;
  assign sel_1_20 = sel;
  assign d0_1_24 = d0;
  assign d1_1_27 = d1;
  assign d2_1_30 = d2;
  assign d3_1_33 = d3;
  assign d4_1_36 = d4;
  assign d5_1_39 = d5;
  assign d6_1_42 = d6;
  assign d7_1_45 = d7;
  always @(d0_1_24 or d1_1_27 or d2_1_30 or d3_1_33 or d4_1_36 or d5_1_39 or d6_1_42 or d7_1_45 or sel_1_20)
    begin:proc_switch_6_1
      case (sel_1_20)
        3'b000 :
          begin
            unregy_join_6_1 = d0_1_24;
          end
        3'b001 :
          begin
            unregy_join_6_1 = d1_1_27;
          end
        3'b010 :
          begin
            unregy_join_6_1 = d2_1_30;
          end
        3'b011 :
          begin
            unregy_join_6_1 = d3_1_33;
          end
        3'b100 :
          begin
            unregy_join_6_1 = d4_1_36;
          end
        3'b101 :
          begin
            unregy_join_6_1 = d5_1_39;
          end
        3'b110 :
          begin
            unregy_join_6_1 = d6_1_42;
          end
        default:
          begin
            unregy_join_6_1 = d7_1_45;
          end
      endcase
    end
  assign y = unregy_join_6_1;
endmodule
 


//-----------------------------------------------------------------
// System Generator version 10.1.3 VERILOG source file.
//
// Copyright(C) 2008 by Xilinx, Inc.  All rights reserved.  This
// text/file contains proprietary, confidential information of Xilinx,
// Inc., is distributed under license from Xilinx, Inc., and may be used,
// copied and/or disclosed only pursuant to the terms of a valid license
// agreement with Xilinx, Inc.  Xilinx hereby grants you a license to use
// this text/file solely for design, simulation, implementation and
// creation of design files limited to Xilinx devices or technologies.
// Use with non-Xilinx devices or technologies is expressly prohibited
// and immediately terminates your license unless covered by a separate
// agreement.
//
// Xilinx is providing this design, code, or information "as is" solely
// for use in developing programs and solutions for Xilinx devices.  By
// providing this design, code, or information as one possible
// implementation of this feature, application or standard, Xilinx is
// making no representation that this implementation is free from any
// claims of infringement.  You are responsible for obtaining any rights
// you may require for your implementation.  Xilinx expressly disclaims
// any warranty whatsoever with respect to the adequacy of the
// implementation, including but not limited to warranties of
// merchantability or fitness for a particular purpose.
//
// Xilinx products are not intended for use in life support appliances,
// devices, or systems.  Use in such applications is expressly prohibited.
//
// Any modifications that are made to the source code are done at the user's
// sole risk and will be unsupported.
//
// This copyright and support notice must be retained as part of this
// text at all times.  (c) Copyright 1995-2008 Xilinx, Inc.  All rights
// reserved.
//-----------------------------------------------------------------
module  xlp2s  (din, src_ce, src_clr, src_clk, dest_ce, dest_clr, dest_clk, rst, en, dout);
parameter dout_width= 8;
parameter dout_arith= `xlSigned;
parameter dout_bin_pt= 0;
parameter din_width= 1;
parameter din_arith= `xlUnsigned;
parameter din_bin_pt= 0;
parameter rst_width= 1;
parameter rst_bin_pt= 0;
parameter rst_arith= `xlUnsigned;
parameter en_width= 1;
parameter en_bin_pt= 0;
parameter en_arith= `xlUnsigned;
parameter lsb_first= 0;
parameter latency= 0;
parameter num_outputs= 0;
input [din_width-1:0] din;
input src_ce, src_clr, src_clk;
input dest_ce, dest_clr, dest_clk;
input rst;
input en;
output [dout_width-1:0] dout;
   wire [dout_width-1:0] i [0:num_outputs-1];
   wire [din_width-1:0] din_temp;
   wire [dout_width-1:0] o [0:num_outputs-1];
   wire [dout_width-1:0] dout_temp;
   wire src_ce_hold;
   wire internal_src_ce;
   wire internal_dest_ce;
   wire internal_clr;
   genvar index, idx, idx1;

   assign internal_src_ce = src_ce_hold & en;
   assign internal_dest_ce = dest_ce & en;
   assign internal_clr = (dest_clr | src_clr | rst) & dest_ce;
   assign dout_temp = internal_src_ce ? din_temp[dout_width-1:0]: o[1];
   FDSE src_ce_reg(.Q(src_ce_hold),
                   .D(src_ce),
                   .C(src_clk),
                   .CE(dest_ce),
                   .S(src_clr));
   generate
      if (lsb_first==1)
        begin:lsb_is_first
           assign din_temp = din;
        end
      else
        begin:msb_is_first
           p2s_bit_reverse # (din_width, dout_width, num_outputs) reverse_input(.din(din), .dout(din_temp));
        end
   endgenerate

   generate
      for(index=0; index<num_outputs; index=index+1)
        begin:fd_array
           synth_reg_w_init # (dout_width, 0, 1'b0, 1)
             capture ( .i(i[index]),
                       .ce(internal_dest_ce),
                       .clr(internal_clr),
                       .clk(dest_clk),
                       .o(o[index]));
        end
   endgenerate
   generate
      for (idx=0; idx<num_outputs; idx=idx+1)
        begin:signal_select
           if (idx < num_outputs-1)
             begin:signal_0
                assign i[idx] = internal_src_ce ? din_temp[idx*dout_width+dout_width-1:idx*dout_width] : o[idx+1];
             end
           if (idx == num_outputs-1)
             begin:signal_1
                assign i[idx] = internal_src_ce ? din_temp[idx*dout_width+dout_width-1:idx*dout_width] : o[idx];
             end
        end
   endgenerate
   generate
      if (latency > 0)
        begin:latency_gt_0
           synth_reg # (dout_width, latency)
             data_reg (.i(dout_temp),
                       .ce(internal_dest_ce),
                       .clr(internal_clr),
                       .clk(dest_clk),
                       .o(dout));
        end
      if (latency == 0)
        begin:latency0
           assign dout = dout_temp;
        end
   endgenerate
endmodule
module p2s_bit_reverse (din, dout);
   parameter din_width = 8;
   parameter dout_width = 2;
   parameter num_outputs = 4;
   input [din_width-1:0] din;
   output [din_width-1:0] dout;
   genvar index;
   generate
      for (index=0; index<num_outputs; index=index+1)
        begin:u0
          assign dout[(num_outputs-index)*dout_width-1:(num_outputs-index-1)*dout_width] = din[index*dout_width+dout_width-1:index*dout_width];
       end
 endgenerate
endmodule


module constant_11c05a5fb4 (
  output [(8 - 1):0] op,
  input clk,
  input ce,
  input clr);
  localparam [(8 - 1):0] const_value = 8'b00000000;
  assign op = 8'b00000000;
endmodule
 



module constant_4ffad13294 (
  output [(8 - 1):0] op,
  input clk,
  input ce,
  input clr);
  localparam [(8 - 1):0] const_value = 8'b00000110;
  assign op = 8'b00000110;
endmodule
 



module constant_5e90e4a8ec (
  output [(1 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 1'b1;
endmodule
 


//-----------------------------------------------------------------
// System Generator version 10.1.3 VERILOG source file.
//
// Copyright(C) 2008 by Xilinx, Inc.  All rights reserved.  This
// text/file contains proprietary, confidential information of Xilinx,
// Inc., is distributed under license from Xilinx, Inc., and may be used,
// copied and/or disclosed only pursuant to the terms of a valid license
// agreement with Xilinx, Inc.  Xilinx hereby grants you a license to use
// this text/file solely for design, simulation, implementation and
// creation of design files limited to Xilinx devices or technologies.
// Use with non-Xilinx devices or technologies is expressly prohibited
// and immediately terminates your license unless covered by a separate
// agreement.
//
// Xilinx is providing this design, code, or information "as is" solely
// for use in developing programs and solutions for Xilinx devices.  By
// providing this design, code, or information as one possible
// implementation of this feature, application or standard, Xilinx is
// making no representation that this implementation is free from any
// claims of infringement.  You are responsible for obtaining any rights
// you may require for your implementation.  Xilinx expressly disclaims
// any warranty whatsoever with respect to the adequacy of the
// implementation, including but not limited to warranties of
// merchantability or fitness for a particular purpose.
//
// Xilinx products are not intended for use in life support appliances,
// devices, or systems.  Use in such applications is expressly prohibited.
//
// Any modifications that are made to the source code are done at the user's
// sole risk and will be unsupported.
//
// This copyright and support notice must be retained as part of this
// text at all times.  (c) Copyright 1995-2008 Xilinx, Inc.  All rights
// reserved.
//-----------------------------------------------------------------
module  xldsamp  (d, src_clk, src_ce, src_clr, dest_clk, dest_ce, dest_clr, en, q);
parameter d_width= 12;
parameter d_bin_pt= 0;
parameter d_arith= `xlUnsigned;
parameter q_width= 12;
parameter q_bin_pt= 0;
parameter q_arith= `xlUnsigned;
parameter en_width= 1;
parameter en_bin_pt= 0;
parameter en_arith= `xlUnsigned;
parameter ds_ratio= 2;
parameter phase= 0;
parameter latency= 1;
input [d_width-1:0] d;
input  src_clk;
input  src_ce;
input  src_clr;
input  dest_clk;
input  dest_ce;
input  dest_clr;
input [en_width-1:0] en;
output [q_width-1:0] q;
wire  adjusted_dest_ce;
wire  adjusted_dest_ce_w_en;
wire  dest_ce_w_en;
wire [d_width-1:0] smpld_d;
reg [q_width-1:0] q_reg;
assign dest_ce_w_en = dest_ce & en[0];
assign adjusted_dest_ce_w_en = adjusted_dest_ce & en[0];
generate
if((latency==0) | (phase!= (ds_ratio-1)))
   begin:adjusted_ce_needed
   FDSE dest_ce_reg(.Q(adjusted_dest_ce),
                    .D(dest_ce),
                    .C(src_clk),
                    .S(src_clr),
                    .CE(src_ce)
                   );
   end
if(latency==0)
  begin:shutter_d_reg
  synth_reg # (d_width,1)
  reg1(.i(d),
       .ce(adjusted_dest_ce),
       .clr(src_clr),
       .clk(src_clk),
       .o(smpld_d)
      );

   assign q = q_reg;
   always@(adjusted_dest_ce,d,smpld_d)
      begin
        if(adjusted_dest_ce == 'b0) begin
           q_reg = smpld_d;
        end
        else begin
           q_reg = d;
        end
      end
  end
 if(latency > 0)
 begin:double_reg_test
   if( phase!= (ds_ratio-1))
   begin:smpl_d_reg
   synth_reg # (d_width, 1)
          reg2 (
               .i(d),
               .ce(adjusted_dest_ce_w_en),
               .clr(src_clr),
               .clk(src_clk),
               .o(smpld_d));
   end
  if( phase == (ds_ratio-1))
  begin:sngl_reg_test
        assign smpld_d = d;
  end
  synth_reg # (d_width, latency)
          reg2 (
               .i(smpld_d),
               .ce(dest_ce_w_en),
               .clr(src_clr),
               .clk(src_clk),
               .o(q));
end

endgenerate
endmodule

//-----------------------------------------------------------------
// System Generator version 10.1.3 VERILOG source file.
//
// Copyright(C) 2008 by Xilinx, Inc.  All rights reserved.  This
// text/file contains proprietary, confidential information of Xilinx,
// Inc., is distributed under license from Xilinx, Inc., and may be used,
// copied and/or disclosed only pursuant to the terms of a valid license
// agreement with Xilinx, Inc.  Xilinx hereby grants you a license to use
// this text/file solely for design, simulation, implementation and
// creation of design files limited to Xilinx devices or technologies.
// Use with non-Xilinx devices or technologies is expressly prohibited
// and immediately terminates your license unless covered by a separate
// agreement.
//
// Xilinx is providing this design, code, or information "as is" solely
// for use in developing programs and solutions for Xilinx devices.  By
// providing this design, code, or information as one possible
// implementation of this feature, application or standard, Xilinx is
// making no representation that this implementation is free from any
// claims of infringement.  You are responsible for obtaining any rights
// you may require for your implementation.  Xilinx expressly disclaims
// any warranty whatsoever with respect to the adequacy of the
// implementation, including but not limited to warranties of
// merchantability or fitness for a particular purpose.
//
// Xilinx products are not intended for use in life support appliances,
// devices, or systems.  Use in such applications is expressly prohibited.
//
// Any modifications that are made to the source code are done at the user's
// sole risk and will be unsupported.
//
// This copyright and support notice must be retained as part of this
// text at all times.  (c) Copyright 1995-2008 Xilinx, Inc.  All rights
// reserved.
//-----------------------------------------------------------------
module xldpram_dist (dina, addra, wea, ena, a_ce, a_clk, douta, addrb, enb, b_ce, b_clk, doutb);
parameter core_name0= "";
parameter addr_width = 12;
parameter c_width= 12;
parameter c_address_width= 4;
parameter latency= 1;
input [c_width-1:0] dina;
input [addr_width-1:0] addra;
input wea, ena, a_ce, a_clk;
output [c_width-1:0] douta;
input [addr_width-1:0] addrb;
input enb, b_ce, b_clk;
output [c_width-1:0] doutb;
wire [c_address_width-1:0] core_addra,core_addrb;
wire [c_width-1:0] core_douta,core_doutb;
wire [c_width-1:0] reg_douta,reg_doutb;
wire core_we, core_cea, core_ceb;

   assign core_addra = addra;
   assign core_addrb = addrb;
   assign douta = reg_douta;
   assign doutb = reg_doutb;
   assign core_cea = a_ce & ena;
   assign core_ceb = b_ce & enb;
   assign core_we = wea & core_cea;

generate
  if (core_name0 == "dmg_33_vx4_dcb0c4b6adf24a19")
    begin:comp0
    dmg_33_vx4_dcb0c4b6adf24a19 core_instance0 (
      .a(core_addra),
      .clk(a_clk),
      .d(dina),
      .we(core_we),
      .dpra(core_addrb),
      .spo(core_douta),
      .dpo(core_doutb)

    );
  end
 if (latency > 0)
   begin:registered_dpram_instA
      synth_reg # (c_width, latency)
        output_regA (.i(core_douta),
                     .ce(core_cea),
                     .clr(1'b0),
                     .clk(a_clk),
                     .o(reg_douta));
   end
 if (latency > 0)
   begin:registered_dpram_instB
      synth_reg # (c_width, latency)
        output_regB (.i(core_doutb),
                     .ce(core_ceb),
                     .clr(1'b0),
                     .clk(b_clk),
                     .o(reg_doutb));
   end

   if (latency == 0)
     begin:nonregistered_ram
        assign reg_douta = core_douta;
        assign reg_doutb = core_doutb;
     end
endgenerate
endmodule
// Generated from Simulink block "hex_out/2wire Count Gen"

module x2wire_count_gen_module_02dae4398f (
  addr,
  ce,
  ce_1,
  clk_1,
  enable31,
  enable7,
  reset
);

  input [0:0] ce;
  input [0:0] ce_1;
  input [0:0] clk_1;
  input [0:0] reset;
  output [5:0] addr;
  output [0:0] enable31;
  output [0:0] enable7;

  wire [0:0] ce_1_sg_x0;
  wire [0:0] clk_1_sg_x0;
  wire [5:0] constant1_op_net;
  wire [5:0] constant_op_net;
  wire [5:0] counter4_op_net_x0;
  wire [5:0] delay_q_net;
  wire [0:0] logical1_y_net;
  wire [0:0] logical_y_net;
  wire [0:0] logical_y_net_x1;
  wire [0:0] relational1_op_net_x0;
  wire [0:0] relational_op_net_x1;
  wire [0:0] relational_op_net_x2;
  wire [2:0] slice1_y_net;
  wire [4:0] slice2_y_net;

  assign addr = counter4_op_net_x0;
  assign relational_op_net_x1 = ce;
  assign ce_1_sg_x0 = ce_1;
  assign clk_1_sg_x0 = clk_1;
  assign enable31 = relational1_op_net_x0;
  assign enable7 = relational_op_net_x2;
  assign logical_y_net_x1 = reset;


  constant_752327bec1  constant1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant1_op_net)
  );

  constant_204e9a8bfd  constant_x0 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant_op_net)
  );

  xlcounter_free #(

    .core_name0("binary_counter_virtex4_10_0_7f29bec8df1c7606"),
    .op_arith(`xlUnsigned),
    .op_width(6))
  counter4 (
    .ce(ce_1_sg_x0),
    .clk(clk_1_sg_x0),
    .clr(1'b0),
    .en(logical1_y_net),
    .rst(logical_y_net_x1),
    .op(counter4_op_net_x0)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .width(6))
  delay (
    .ce(ce_1_sg_x0),
    .clk(clk_1_sg_x0),
    .d(counter4_op_net_x0),
    .en(relational_op_net_x1),
    .q(delay_q_net)
  );

  logical_28d385d867  logical (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .d0(relational_op_net_x2),
    .d1(relational1_op_net_x0),
    .y(logical_y_net)
  );

  logical_28d385d867  logical1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .d0(relational_op_net_x1),
    .d1(logical_y_net),
    .y(logical1_y_net)
  );

  relational_440eb07a2f  relational (
    .a(slice1_y_net),
    .b(constant_op_net),
    .ce(ce_1_sg_x0),
    .clk(clk_1_sg_x0),
    .clr(1'b0),
    .en(relational_op_net_x1),
    .op(relational_op_net_x2)
  );

  relational_7e0e56c195  relational1 (
    .a(slice2_y_net),
    .b(constant1_op_net),
    .ce(ce_1_sg_x0),
    .clk(clk_1_sg_x0),
    .clr(1'b0),
    .en(relational_op_net_x1),
    .op(relational1_op_net_x0)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(2),
    .x_width(6),
    .y_width(3))
  slice1 (
    .x(counter4_op_net_x0),
    .y(slice1_y_net)
  );

  xlslice #(

    .new_lsb(0),
    .new_msb(4),
    .x_width(6),
    .y_width(5))
  slice2 (
    .x(delay_q_net),
    .y(slice2_y_net)
  );
endmodule
// Generated from Simulink block "hex_out/ClockEnableGen"

module clockenablegen_module_78134ac374 (
  ce,
  ce_1,
  clk_1,
  divider,
  reset
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [7:0] divider;
  input [0:0] reset;
  output [0:0] ce;

  wire [9:0] addsub_s_net;
  wire [0:0] ce_1_sg_x1;
  wire [0:0] clk_1_sg_x1;
  wire [9:0] concat_y_net;
  wire [1:0] constant15_op_net;
  wire [9:0] constant17_op_net;
  wire [9:0] counter2_op_net;
  wire [7:0] divider_net_x0;
  wire [0:0] logical_y_net;
  wire [0:0] logical_y_net_x2;
  wire [0:0] relational_op_net_x2;

  assign ce = relational_op_net_x2;
  assign ce_1_sg_x1 = ce_1;
  assign clk_1_sg_x1 = clk_1;
  assign divider_net_x0 = divider;
  assign logical_y_net_x2 = reset;


  xladdsubv10_0 #(

    .a_arith(`xlUnsigned),
    .a_bin_pt(0),
    .a_width(10),
    .b_arith(`xlUnsigned),
    .b_bin_pt(0),
    .b_width(10),
    .c_has_c_out(0),
    .c_latency(0),
    .c_output_width(11),
    .core_name0("adder_subtracter_virtex4_10_0_80b315fd28a09ef0"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(11),
    .latency(0),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlUnsigned),
    .s_bin_pt(0),
    .s_width(10))
  addsub (
    .a(concat_y_net),
    .b(constant17_op_net),
    .ce(ce_1_sg_x1),
    .clk(clk_1_sg_x1),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub_s_net)
  );

  concat_fb3e05a33e  concat (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .in0(divider_net_x0),
    .in1(constant15_op_net),
    .y(concat_y_net)
  );

  constant_9e0724a33a  constant15 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant15_op_net)
  );

  constant_787b59efba  constant17 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant17_op_net)
  );

  xlcounter_free #(

    .core_name0("binary_counter_virtex4_10_0_0e77c8b832175d2c"),
    .op_arith(`xlUnsigned),
    .op_width(10))
  counter2 (
    .ce(ce_1_sg_x1),
    .clk(clk_1_sg_x1),
    .clr(1'b0),
    .en(1'b1),
    .rst(logical_y_net),
    .op(counter2_op_net)
  );

  logical_7970a672aa  logical (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .d0(logical_y_net_x2),
    .d1(relational_op_net_x2),
    .y(logical_y_net)
  );

  relational_d74f8dcf86  relational (
    .a(addsub_s_net),
    .b(counter2_op_net),
    .ce(ce_1_sg_x1),
    .clk(clk_1_sg_x1),
    .clr(1'b0),
    .op(relational_op_net_x2)
  );
endmodule
// Generated from Simulink block "hex_out/ClockEnableGen_div4"

module clockenablegen_div4_module_fa193c9017 (
  ce4,
  ce_1,
  clk_1,
  divider,
  reset
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [7:0] divider;
  input [0:0] reset;
  output [0:0] ce4;

  wire [9:0] addsub_s_net;
  wire [0:0] ce_1_sg_x2;
  wire [0:0] clk_1_sg_x2;
  wire [9:0] concat_y_net;
  wire [1:0] constant15_op_net;
  wire [9:0] constant17_op_net;
  wire [9:0] counter2_op_net;
  wire [7:0] divider_net_x1;
  wire [0:0] logical_y_net;
  wire [0:0] logical_y_net_x3;
  wire [0:0] relational_op_net_x0;

  assign ce4 = relational_op_net_x0;
  assign ce_1_sg_x2 = ce_1;
  assign clk_1_sg_x2 = clk_1;
  assign divider_net_x1 = divider;
  assign logical_y_net_x3 = reset;


  xladdsubv10_0 #(

    .a_arith(`xlUnsigned),
    .a_bin_pt(0),
    .a_width(10),
    .b_arith(`xlUnsigned),
    .b_bin_pt(0),
    .b_width(10),
    .c_has_c_out(0),
    .c_latency(0),
    .c_output_width(11),
    .core_name0("adder_subtracter_virtex4_10_0_80b315fd28a09ef0"),
    .extra_registers(0),
    .full_s_arith(2),
    .full_s_width(11),
    .latency(0),
    .overflow(1),
    .quantization(1),
    .s_arith(`xlUnsigned),
    .s_bin_pt(0),
    .s_width(10))
  addsub (
    .a(concat_y_net),
    .b(constant17_op_net),
    .ce(ce_1_sg_x2),
    .clk(clk_1_sg_x2),
    .clr(1'b0),
    .en(1'b1),
    .s(addsub_s_net)
  );

  concat_ba8a620a74  concat (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .in0(constant15_op_net),
    .in1(divider_net_x1),
    .y(concat_y_net)
  );

  constant_9e0724a33a  constant15 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant15_op_net)
  );

  constant_787b59efba  constant17 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant17_op_net)
  );

  xlcounter_free #(

    .core_name0("binary_counter_virtex4_10_0_0e77c8b832175d2c"),
    .op_arith(`xlUnsigned),
    .op_width(10))
  counter2 (
    .ce(ce_1_sg_x2),
    .clk(clk_1_sg_x2),
    .clr(1'b0),
    .en(1'b1),
    .rst(logical_y_net),
    .op(counter2_op_net)
  );

  logical_7970a672aa  logical (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .d0(logical_y_net_x3),
    .d1(relational_op_net_x0),
    .y(logical_y_net)
  );

  relational_d74f8dcf86  relational (
    .a(addsub_s_net),
    .b(counter2_op_net),
    .ce(ce_1_sg_x2),
    .clk(clk_1_sg_x2),
    .clr(1'b0),
    .op(relational_op_net_x0)
  );
endmodule
// Generated from Simulink block "hex_out/ConfigDataMuxCtrl"

module configdatamuxctrl_module_dd079a15a5 (
  ce_1,
  clk_1,
  configrising,
  enable31falling,
  mux_sel
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [0:0] configrising;
  input [0:0] enable31falling;
  output [0:0] mux_sel;

  wire [0:0] ce_1_sg_x3;
  wire [0:0] clk_1_sg_x3;
  wire [0:0] delay1_q_net;
  wire [0:0] delay1_q_net_x1;
  wire [0:0] inverter1_op_net;
  wire [0:0] inverter_op_net;
  wire [0:0] logical1_y_net;
  wire [0:0] logical2_y_net_x0;
  wire [0:0] logical_y_net;
  wire [0:0] logical_y_net_x1;
  wire [0:0] register1_q_net;
  wire [0:0] register2_q_net;
  wire [0:0] register3_q_net;
  wire [0:0] register_q_net;

  assign ce_1_sg_x3 = ce_1;
  assign clk_1_sg_x3 = clk_1;
  assign delay1_q_net_x1 = configrising;
  assign logical_y_net_x1 = enable31falling;
  assign mux_sel = logical2_y_net_x0;


  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .width(1))
  delay1 (
    .ce(ce_1_sg_x3),
    .clk(clk_1_sg_x3),
    .d(delay1_q_net_x1),
    .en(1'b1),
    .q(delay1_q_net)
  );

  inverter_33a63b558a  inverter (
    .ce(ce_1_sg_x3),
    .clk(clk_1_sg_x3),
    .clr(1'b0),
    .ip(register2_q_net),
    .op(inverter_op_net)
  );

  inverter_33a63b558a  inverter1 (
    .ce(ce_1_sg_x3),
    .clk(clk_1_sg_x3),
    .clr(1'b0),
    .ip(register1_q_net),
    .op(inverter1_op_net)
  );

  logical_818bd6d54b  logical (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .d0(inverter_op_net),
    .d1(register1_q_net),
    .d2(register_q_net),
    .d3(register3_q_net),
    .y(logical_y_net)
  );

  logical_818bd6d54b  logical1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .d0(inverter_op_net),
    .d1(inverter1_op_net),
    .d2(register_q_net),
    .d3(register3_q_net),
    .y(logical1_y_net)
  );

  logical_7970a672aa  logical2 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .d0(logical_y_net),
    .d1(logical1_y_net),
    .y(logical2_y_net_x0)
  );

  xlregister #(

    .d_width(1),
    .init_value(1'b0))
  register1 (
    .ce(ce_1_sg_x3),
    .clk(clk_1_sg_x3),
    .d(register_q_net),
    .en(logical_y_net_x1),
    .rst(delay1_q_net_x1),
    .q(register1_q_net)
  );

  xlregister #(

    .d_width(1),
    .init_value(1'b0))
  register2 (
    .ce(ce_1_sg_x3),
    .clk(clk_1_sg_x3),
    .d(register1_q_net),
    .en(logical_y_net_x1),
    .rst(delay1_q_net_x1),
    .q(register2_q_net)
  );

  xlregister #(

    .d_width(1),
    .init_value(1'b0))
  register3 (
    .ce(ce_1_sg_x3),
    .clk(clk_1_sg_x3),
    .d(delay1_q_net),
    .en(delay1_q_net),
    .rst(delay1_q_net_x1),
    .q(register3_q_net)
  );

  xlregister #(

    .d_width(1),
    .init_value(1'b0))
  register_x0 (
    .ce(ce_1_sg_x3),
    .clk(clk_1_sg_x3),
    .d(logical_y_net_x1),
    .en(logical_y_net_x1),
    .rst(delay1_q_net_x1),
    .q(register_q_net)
  );
endmodule
// Generated from Simulink block "hex_out/SCLGenerate"

module sclgenerate_module_463ec6aa7d (
  ce,
  ce4,
  ce_1,
  clk_1,
  enable31,
  reset_rising,
  scl
);

  input [0:0] ce;
  input [0:0] ce4;
  input [0:0] ce_1;
  input [0:0] clk_1;
  input [0:0] enable31;
  input [0:0] reset_rising;
  output [0:0] scl;

  wire [0:0] ce_1_sg_x4;
  wire [0:0] clk_1_sg_x4;
  wire [0:0] constant2_op_net;
  wire [1:0] counter1_op_net;
  wire [0:0] delay2_q_net;
  wire [0:0] delay3_q_net;
  wire [0:0] logical_y_net_x4;
  wire [0:0] mux2_y_net_x0;
  wire [0:0] relational1_op_net_x1;
  wire [0:0] relational_op_net_x3;
  wire [0:0] relational_op_net_x4;
  wire [0:0] slice1_y_net;

  assign relational_op_net_x3 = ce;
  assign relational_op_net_x4 = ce4;
  assign ce_1_sg_x4 = ce_1;
  assign clk_1_sg_x4 = clk_1;
  assign relational1_op_net_x1 = enable31;
  assign logical_y_net_x4 = reset_rising;
  assign scl = mux2_y_net_x0;


  constant_9cf45430cd  constant2 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant2_op_net)
  );

  xlcounter_free #(

    .core_name0("binary_counter_virtex4_10_0_407917162894eacc"),
    .op_arith(`xlUnsigned),
    .op_width(2))
  counter1 (
    .ce(ce_1_sg_x4),
    .clk(clk_1_sg_x4),
    .clr(1'b0),
    .en(relational_op_net_x4),
    .rst(logical_y_net_x4),
    .op(counter1_op_net)
  );

  xldelay #(

    .latency(4),
    .reg_retiming(0),
    .width(1))
  delay2 (
    .ce(ce_1_sg_x4),
    .clk(clk_1_sg_x4),
    .d(slice1_y_net),
    .en(relational_op_net_x4),
    .q(delay2_q_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .width(1))
  delay3 (
    .ce(ce_1_sg_x4),
    .clk(clk_1_sg_x4),
    .d(relational1_op_net_x1),
    .en(relational_op_net_x3),
    .q(delay3_q_net)
  );

  mux_485ea02169  mux2 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .d0(constant2_op_net),
    .d1(delay2_q_net),
    .sel(delay3_q_net),
    .y(mux2_y_net_x0)
  );

  xlslice #(

    .new_lsb(1),
    .new_msb(1),
    .x_width(2),
    .y_width(1))
  slice1 (
    .x(counter1_op_net),
    .y(slice1_y_net)
  );
endmodule
// Generated from Simulink block "hex_out/SDAGenerate/inputdata_write"

module inputdata_write_module_008cea4600 (
  address0,
  address1,
  ce_1,
  ce_8,
  clk_1,
  clk_8,
  config_writedata,
  data_writedata,
  hex_l,
  hex_m,
  hex_r,
  led8,
  mux_select
);

  input [7:0] address0;
  input [7:0] address1;
  input [0:0] ce_1;
  input [0:0] ce_8;
  input [0:0] clk_1;
  input [0:0] clk_8;
  input [7:0] hex_l;
  input [7:0] hex_m;
  input [7:0] hex_r;
  input [7:0] led8;
  input [2:0] mux_select;
  output [0:0] config_writedata;
  output [0:0] data_writedata;

  wire [7:0] address0_net_x0;
  wire [7:0] address1_net_x0;
  wire [0:0] ce_1_sg_x5;
  wire [0:0] ce_8_sg_x0;
  wire [0:0] clk_1_sg_x5;
  wire [0:0] clk_8_sg_x0;
  wire [7:0] constant10_op_net;
  wire [7:0] constant12_op_net;
  wire [7:0] constant13_op_net;
  wire [7:0] constant4_op_net;
  wire [7:0] constant5_op_net;
  wire [7:0] constant6_op_net;
  wire [7:0] constant7_op_net;
  wire [7:0] constant9_op_net;
  wire [7:0] hex_l_net_x0;
  wire [7:0] hex_m_net_x0;
  wire [7:0] hex_r_net_x0;
  wire [7:0] led8_net_x0;
  wire [7:0] mux3_y_net;
  wire [7:0] mux_y_net;
  wire [0:0] parallel_to_serial1_dout_net_x0;
  wire [0:0] parallel_to_serial2_dout_net_x0;
  wire [2:0] slice_y_net_x0;

  assign address0_net_x0 = address0;
  assign address1_net_x0 = address1;
  assign ce_1_sg_x5 = ce_1;
  assign ce_8_sg_x0 = ce_8;
  assign clk_1_sg_x5 = clk_1;
  assign clk_8_sg_x0 = clk_8;
  assign config_writedata = parallel_to_serial2_dout_net_x0;
  assign data_writedata = parallel_to_serial1_dout_net_x0;
  assign hex_l_net_x0 = hex_l;
  assign hex_m_net_x0 = hex_m;
  assign hex_r_net_x0 = hex_r;
  assign led8_net_x0 = led8;
  assign slice_y_net_x0 = mux_select;


  constant_4ffad13294  constant10 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant10_op_net)
  );

  constant_11c05a5fb4  constant12 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant12_op_net)
  );

  constant_11c05a5fb4  constant13 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant13_op_net)
  );

  constant_11c05a5fb4  constant4 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant4_op_net)
  );

  constant_67d0b5242e  constant5 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant5_op_net)
  );

  constant_67d0b5242e  constant6 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant6_op_net)
  );

  constant_11c05a5fb4  constant7 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant7_op_net)
  );

  constant_4ffad13294  constant9 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant9_op_net)
  );

  mux_f80a0abc7d  mux (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .d0(address0_net_x0),
    .d1(constant5_op_net),
    .d2(hex_l_net_x0),
    .d3(hex_m_net_x0),
    .d4(address1_net_x0),
    .d5(constant6_op_net),
    .d6(hex_r_net_x0),
    .d7(led8_net_x0),
    .sel(slice_y_net_x0),
    .y(mux_y_net)
  );

  mux_f80a0abc7d  mux3 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .d0(address0_net_x0),
    .d1(constant9_op_net),
    .d2(constant4_op_net),
    .d3(constant7_op_net),
    .d4(address1_net_x0),
    .d5(constant10_op_net),
    .d6(constant12_op_net),
    .d7(constant13_op_net),
    .sel(slice_y_net_x0),
    .y(mux3_y_net)
  );

  xlp2s #(

    .din_arith(`xlUnsigned),
    .din_bin_pt(0),
    .din_width(8),
    .dout_arith(`xlUnsigned),
    .dout_bin_pt(0),
    .dout_width(1),
    .latency(0),
    .lsb_first(0),
    .num_outputs(8))
  parallel_to_serial1 (
    .dest_ce(ce_1_sg_x5),
    .dest_clk(clk_1_sg_x5),
    .dest_clr(1'b0),
    .din(mux_y_net),
    .en(1'b1),
    .rst(1'b0),
    .src_ce(ce_8_sg_x0),
    .src_clk(clk_8_sg_x0),
    .src_clr(1'b0),
    .dout(parallel_to_serial1_dout_net_x0)
  );

  xlp2s #(

    .din_arith(`xlUnsigned),
    .din_bin_pt(0),
    .din_width(8),
    .dout_arith(`xlUnsigned),
    .dout_bin_pt(0),
    .dout_width(1),
    .latency(0),
    .lsb_first(0),
    .num_outputs(8))
  parallel_to_serial2 (
    .dest_ce(ce_1_sg_x5),
    .dest_clk(clk_1_sg_x5),
    .dest_clr(1'b0),
    .din(mux3_y_net),
    .en(1'b1),
    .rst(1'b0),
    .src_ce(ce_8_sg_x0),
    .src_clk(clk_8_sg_x0),
    .src_clr(1'b0),
    .dout(parallel_to_serial2_dout_net_x0)
  );
endmodule
// Generated from Simulink block "hex_out/SDAGenerate"

module sdagenerate_module_bc7d2cf62c (
  addrb,
  address0,
  address1,
  ce,
  ce4,
  ce_1,
  ce_8,
  clk_1,
  clk_8,
  enable7,
  hex_l,
  hex_m,
  hex_r,
  led8,
  outselect,
  sda
);

  input [5:0] addrb;
  input [7:0] address0;
  input [7:0] address1;
  input [0:0] ce;
  input [0:0] ce4;
  input [0:0] ce_1;
  input [0:0] ce_8;
  input [0:0] clk_1;
  input [0:0] clk_8;
  input [0:0] enable7;
  input [7:0] hex_l;
  input [7:0] hex_m;
  input [7:0] hex_r;
  input [7:0] led8;
  input [0:0] outselect;
  output [0:0] sda;

  wire [7:0] address0_net_x1;
  wire [7:0] address1_net_x1;
  wire [0:0] ce_1_sg_x6;
  wire [0:0] ce_8_sg_x1;
  wire [0:0] clk_1_sg_x6;
  wire [0:0] clk_8_sg_x1;
  wire [0:0] config_doutb_net;
  wire [0:0] constant11_op_net;
  wire [0:0] constant14_op_net;
  wire [0:0] constant1_op_net;
  wire [0:0] constant8_op_net;
  wire [5:0] counter3_op_net;
  wire [5:0] counter4_op_net_x1;
  wire [0:0] data_doutb_net;
  wire [0:0] delay1_q_net_x0;
  wire [0:0] delay4_q_net_x0;
  wire [5:0] delay_q_net;
  wire [5:0] down_sample_q_net;
  wire [7:0] hex_l_net_x1;
  wire [7:0] hex_m_net_x1;
  wire [7:0] hex_r_net_x1;
  wire [7:0] led8_net_x1;
  wire [0:0] logical2_y_net_x1;
  wire [0:0] mux1_y_net;
  wire [0:0] mux4_y_net;
  wire [0:0] mux5_y_net;
  wire [0:0] parallel_to_serial1_dout_net_x0;
  wire [0:0] parallel_to_serial2_dout_net_x0;
  wire [0:0] relational_op_net_x5;
  wire [0:0] relational_op_net_x6;
  wire [2:0] slice_y_net_x0;

  assign counter4_op_net_x1 = addrb;
  assign address0_net_x1 = address0;
  assign address1_net_x1 = address1;
  assign relational_op_net_x5 = ce;
  assign relational_op_net_x6 = ce4;
  assign ce_1_sg_x6 = ce_1;
  assign ce_8_sg_x1 = ce_8;
  assign clk_1_sg_x6 = clk_1;
  assign clk_8_sg_x1 = clk_8;
  assign delay4_q_net_x0 = enable7;
  assign hex_l_net_x1 = hex_l;
  assign hex_m_net_x1 = hex_m;
  assign hex_r_net_x1 = hex_r;
  assign led8_net_x1 = led8;
  assign logical2_y_net_x1 = outselect;
  assign sda = delay1_q_net_x0;


  xldpram_dist #(

    .addr_width(6),
    .c_address_width(6),
    .c_width(1),
    .core_name0("dmg_33_vx4_dcb0c4b6adf24a19"),
    .latency(1))
  config_x0 (
    .a_ce(ce_1_sg_x6),
    .a_clk(clk_1_sg_x6),
    .addra(delay_q_net),
    .addrb(counter4_op_net_x1),
    .b_ce(ce_1_sg_x6),
    .b_clk(clk_1_sg_x6),
    .dina(parallel_to_serial2_dout_net_x0),
    .ena(1'b1),
    .enb(relational_op_net_x5),
    .wea(constant11_op_net),
    .doutb(config_doutb_net)
  );

  constant_9cf45430cd  constant1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant1_op_net)
  );

  constant_5e90e4a8ec  constant11 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant11_op_net)
  );

  constant_9cf45430cd  constant14 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant14_op_net)
  );

  constant_5e90e4a8ec  constant8 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .op(constant8_op_net)
  );

  xlcounter_free #(

    .core_name0("binary_counter_virtex4_10_0_7f29bec8df1c7606"),
    .op_arith(`xlUnsigned),
    .op_width(6))
  counter3 (
    .ce(ce_1_sg_x6),
    .clk(clk_1_sg_x6),
    .clr(1'b0),
    .en(1'b1),
    .rst(1'b0),
    .op(counter3_op_net)
  );

  xldpram_dist #(

    .addr_width(6),
    .c_address_width(6),
    .c_width(1),
    .core_name0("dmg_33_vx4_dcb0c4b6adf24a19"),
    .latency(1))
  data (
    .a_ce(ce_1_sg_x6),
    .a_clk(clk_1_sg_x6),
    .addra(delay_q_net),
    .addrb(counter4_op_net_x1),
    .b_ce(ce_1_sg_x6),
    .b_clk(clk_1_sg_x6),
    .dina(parallel_to_serial1_dout_net_x0),
    .ena(1'b1),
    .enb(relational_op_net_x5),
    .wea(constant8_op_net),
    .doutb(data_doutb_net)
  );

  xldelay #(

    .latency(8),
    .reg_retiming(0),
    .width(6))
  delay (
    .ce(ce_1_sg_x6),
    .clk(clk_1_sg_x6),
    .d(counter3_op_net),
    .en(1'b1),
    .q(delay_q_net)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .width(1))
  delay1 (
    .ce(ce_1_sg_x6),
    .clk(clk_1_sg_x6),
    .d(mux5_y_net),
    .en(relational_op_net_x6),
    .q(delay1_q_net_x0)
  );

  xldsamp #(

    .d_arith(`xlUnsigned),
    .d_bin_pt(0),
    .d_width(6),
    .ds_ratio(8),
    .latency(1),
    .phase(7),
    .q_arith(`xlUnsigned),
    .q_bin_pt(0),
    .q_width(6))
  down_sample (
    .d(counter3_op_net),
    .dest_ce(ce_8_sg_x1),
    .dest_clk(clk_8_sg_x1),
    .dest_clr(1'b0),
    .en(1'b1),
    .src_ce(ce_1_sg_x6),
    .src_clk(clk_1_sg_x6),
    .src_clr(1'b0),
    .q(down_sample_q_net)
  );

  inputdata_write_module_008cea4600  inputdata_write_008cea4600 (
    .address0(address0_net_x1),
    .address1(address1_net_x1),
    .ce_1(ce_1_sg_x6),
    .ce_8(ce_8_sg_x1),
    .clk_1(clk_1_sg_x6),
    .clk_8(clk_8_sg_x1),
    .hex_l(hex_l_net_x1),
    .hex_m(hex_m_net_x1),
    .hex_r(hex_r_net_x1),
    .led8(led8_net_x1),
    .mux_select(slice_y_net_x0),
    .config_writedata(parallel_to_serial2_dout_net_x0),
    .data_writedata(parallel_to_serial1_dout_net_x0)
  );

  mux_485ea02169  mux1 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .d0(constant1_op_net),
    .d1(data_doutb_net),
    .sel(delay4_q_net_x0),
    .y(mux1_y_net)
  );

  mux_485ea02169  mux4 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .d0(constant14_op_net),
    .d1(config_doutb_net),
    .sel(delay4_q_net_x0),
    .y(mux4_y_net)
  );

  mux_485ea02169  mux5 (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .d0(mux1_y_net),
    .d1(mux4_y_net),
    .sel(logical2_y_net_x1),
    .y(mux5_y_net)
  );

  xlslice #(

    .new_lsb(3),
    .new_msb(5),
    .x_width(6),
    .y_width(3))
  slice (
    .x(down_sample_q_net),
    .y(slice_y_net_x0)
  );
endmodule
// Generated from Simulink block "hex_out/fallingedge"

module fallingedge_module_0bebb75311 (
  ce_1,
  clk_1,
  edge_x0,
  in_x0
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [0:0] in_x0;
  output [0:0] edge_x0;

  wire [0:0] ce_1_sg_x7;
  wire [0:0] clk_1_sg_x7;
  wire [0:0] delay4_q_net;
  wire [0:0] inverter_op_net;
  wire [0:0] logical_y_net_x2;
  wire [0:0] relational1_op_net_x2;

  assign ce_1_sg_x7 = ce_1;
  assign clk_1_sg_x7 = clk_1;
  assign edge_x0 = logical_y_net_x2;
  assign relational1_op_net_x2 = in_x0;


  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .width(1))
  delay4 (
    .ce(ce_1_sg_x7),
    .clk(clk_1_sg_x7),
    .d(relational1_op_net_x2),
    .en(1'b1),
    .q(delay4_q_net)
  );

  inverter_33a63b558a  inverter (
    .ce(ce_1_sg_x7),
    .clk(clk_1_sg_x7),
    .clr(1'b0),
    .ip(relational1_op_net_x2),
    .op(inverter_op_net)
  );

  logical_28d385d867  logical (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .d0(inverter_op_net),
    .d1(delay4_q_net),
    .y(logical_y_net_x2)
  );
endmodule
// Generated from Simulink block "hex_out/risingedge"

module risingedge_module_530dab4a3f (
  ce_1,
  clk_1,
  edge_x0,
  in_x0
);

  input [0:0] ce_1;
  input [0:0] clk_1;
  input [0:0] in_x0;
  output [0:0] edge_x0;

  wire [0:0] ce_1_sg_x9;
  wire [0:0] clk_1_sg_x9;
  wire [0:0] delay4_q_net;
  wire [0:0] inverter_op_net;
  wire [0:0] logical_y_net_x5;
  wire [0:0] reset_net_x1;

  assign ce_1_sg_x9 = ce_1;
  assign clk_1_sg_x9 = clk_1;
  assign edge_x0 = logical_y_net_x5;
  assign reset_net_x1 = in_x0;


  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .width(1))
  delay4 (
    .ce(ce_1_sg_x9),
    .clk(clk_1_sg_x9),
    .d(inverter_op_net),
    .en(1'b1),
    .q(delay4_q_net)
  );

  inverter_33a63b558a  inverter (
    .ce(ce_1_sg_x9),
    .clk(clk_1_sg_x9),
    .clr(1'b0),
    .ip(reset_net_x1),
    .op(inverter_op_net)
  );

  logical_28d385d867  logical (
    .ce(1'b0),
    .clk(1'b0),
    .clr(1'b0),
    .d0(reset_net_x1),
    .d1(delay4_q_net),
    .y(logical_y_net_x5)
  );
endmodule
// Generated from Simulink block "hex_out"

(* core_generation_info = "hex_out,sysgen_core_10_1_3_1386,{total_blocks=164,xilinx_adder_subtractor_block=2,xilinx_arithmetic_relational_operator_block=4,xilinx_bit_slice_extractor_block=4,xilinx_bus_concatenator_block=2,xilinx_bus_multiplexer_block=6,xilinx_constant_block_block=19,xilinx_counter_block=5,xilinx_delay_block=11,xilinx_down_sampler_block=1,xilinx_dual_port_random_access_memory_block=2,xilinx_gateway_in_block=8,xilinx_gateway_out_block=2,xilinx_inverter_block=5,xilinx_logical_block_block=10,xilinx_parallel_to_serial_converter_block=2,xilinx_register_block=4,xilinx_resource_estimator_block=1,xilinx_system_generator_block=1,}" *)
module hex_out (
  address0,
  address1,
  ce_1,
  ce_8,
  clk_1,
  clk_8,
  divider,
  hex_l,
  hex_m,
  hex_r,
  led8,
  reset,
  scl,
  sda
);

  input [7:0] address0;
  input [7:0] address1;
  input [0:0] ce_1;
  input [0:0] ce_8;
  input [0:0] clk_1;
  input [0:0] clk_8;
  input [7:0] divider;
  input [7:0] hex_l;
  input [7:0] hex_m;
  input [7:0] hex_r;
  input [7:0] led8;
  input [0:0] reset;
  output [0:0] scl;
  output [0:0] sda;

  wire [7:0] address0_net;
  wire [7:0] address1_net;
  wire [0:0] ce_1_sg_x10;
  wire [0:0] ce_8_sg_x2;
  wire [0:0] clk_1_sg_x10;
  wire [0:0] clk_8_sg_x2;
  wire [5:0] counter4_op_net_x1;
  wire [0:0] delay1_q_net_x1;
  wire [0:0] delay4_q_net_x0;
  wire [7:0] divider_net;
  wire [7:0] hex_l_net;
  wire [7:0] hex_m_net;
  wire [7:0] hex_r_net;
  wire [7:0] led8_net;
  wire [0:0] logical2_y_net_x1;
  wire [0:0] logical_y_net_x0;
  wire [0:0] logical_y_net_x2;
  wire [0:0] logical_y_net_x5;
  wire [0:0] relational1_op_net_x2;
  wire [0:0] relational_op_net_x2;
  wire [0:0] relational_op_net_x5;
  wire [0:0] relational_op_net_x6;
  wire [0:0] reset_net;
  wire [0:0] scl_net;
  wire [0:0] sda_net;

  assign address0_net = address0;
  assign address1_net = address1;
  assign ce_1_sg_x10 = ce_1;
  assign ce_8_sg_x2 = ce_8;
  assign clk_1_sg_x10 = clk_1;
  assign clk_8_sg_x2 = clk_8;
  assign divider_net = divider;
  assign hex_l_net = hex_l;
  assign hex_m_net = hex_m;
  assign hex_r_net = hex_r;
  assign led8_net = led8;
  assign reset_net = reset;
  assign scl = scl_net;
  assign sda = sda_net;


  clockenablegen_module_78134ac374  clockenablegen_78134ac374 (
    .ce_1(ce_1_sg_x10),
    .clk_1(clk_1_sg_x10),
    .divider(divider_net),
    .reset(logical_y_net_x5),
    .ce(relational_op_net_x5)
  );

  clockenablegen_div4_module_fa193c9017  clockenablegen_div4_fa193c9017 (
    .ce_1(ce_1_sg_x10),
    .clk_1(clk_1_sg_x10),
    .divider(divider_net),
    .reset(logical_y_net_x5),
    .ce4(relational_op_net_x6)
  );

  configdatamuxctrl_module_dd079a15a5  configdatamuxctrl_dd079a15a5 (
    .ce_1(ce_1_sg_x10),
    .clk_1(clk_1_sg_x10),
    .configrising(delay1_q_net_x1),
    .enable31falling(logical_y_net_x2),
    .mux_sel(logical2_y_net_x1)
  );

  xldelay #(

    .latency(80),
    .reg_retiming(0),
    .width(1))
  delay1 (
    .ce(ce_1_sg_x10),
    .clk(clk_1_sg_x10),
    .d(logical_y_net_x0),
    .en(1'b1),
    .q(delay1_q_net_x1)
  );

  xldelay #(

    .latency(1),
    .reg_retiming(0),
    .width(1))
  delay4 (
    .ce(ce_1_sg_x10),
    .clk(clk_1_sg_x10),
    .d(relational_op_net_x2),
    .en(relational_op_net_x5),
    .q(delay4_q_net_x0)
  );

  fallingedge_module_0bebb75311  fallingedge1_caf59c31b2 (
    .ce_1(ce_1_sg_x10),
    .clk_1(clk_1_sg_x10),
    .in_x0(reset_net),
    .edge_x0(logical_y_net_x0)
  );

  fallingedge_module_0bebb75311  fallingedge_0bebb75311 (
    .ce_1(ce_1_sg_x10),
    .clk_1(clk_1_sg_x10),
    .in_x0(relational1_op_net_x2),
    .edge_x0(logical_y_net_x2)
  );

  risingedge_module_530dab4a3f  risingedge_530dab4a3f (
    .ce_1(ce_1_sg_x10),
    .clk_1(clk_1_sg_x10),
    .in_x0(reset_net),
    .edge_x0(logical_y_net_x5)
  );

  sclgenerate_module_463ec6aa7d  sclgenerate_463ec6aa7d (
    .ce(relational_op_net_x5),
    .ce4(relational_op_net_x6),
    .ce_1(ce_1_sg_x10),
    .clk_1(clk_1_sg_x10),
    .enable31(relational1_op_net_x2),
    .reset_rising(logical_y_net_x5),
    .scl(scl_net)
  );

  sdagenerate_module_bc7d2cf62c  sdagenerate_bc7d2cf62c (
    .addrb(counter4_op_net_x1),
    .address0(address0_net),
    .address1(address1_net),
    .ce(relational_op_net_x5),
    .ce4(relational_op_net_x6),
    .ce_1(ce_1_sg_x10),
    .ce_8(ce_8_sg_x2),
    .clk_1(clk_1_sg_x10),
    .clk_8(clk_8_sg_x2),
    .enable7(delay4_q_net_x0),
    .hex_l(hex_l_net),
    .hex_m(hex_m_net),
    .hex_r(hex_r_net),
    .led8(led8_net),
    .outselect(logical2_y_net_x1),
    .sda(sda_net)
  );

  x2wire_count_gen_module_02dae4398f  x2wire_count_gen_02dae4398f (
    .ce(relational_op_net_x5),
    .ce_1(ce_1_sg_x10),
    .clk_1(clk_1_sg_x10),
    .reset(logical_y_net_x5),
    .addr(counter4_op_net_x1),
    .enable31(relational1_op_net_x2),
    .enable7(relational_op_net_x2)
  );
endmodule
