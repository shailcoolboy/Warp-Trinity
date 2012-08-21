//--------------------------------------------------------------------------
//                                                                        --
//  OneWireMaster                                                         --
//   A synthesizable 1-wire master peripheral                             --
//   Copyright 1999-2005 Dallas Semiconductor Corporation                 --
//                                                                        --
//--------------------------------------------------------------------------
//                                                                        --
//  Purpose:  Provides timing and control of Dallas 1-wire bus            --
//            through a memory-mapped peripheral                          --
//  File:     OWM.v                                                       --
//  Date:     February 1, 2005                                            --
//  Version:  v2.100                                                      --
//  Authors:  Rick Downs and Charles Hill,                                --
//            Dallas Semiconductor Corporation                            --
//                                                                        --
//  Note:     This source code is available for use without license.      --
//            Dallas Semiconductor is not responsible for the             --
//            functionality or utility of this product.                   --
//                                                                        --
//  Rev:      Added Overdrive, Bit control, and strong pullup control     --
//            along with many other features described in the new spec    --
//            released version 2.0  9/5/01 - Greg Glennon                 --
//            Significant changes to improve synthesis - English          --
//            Ported to Verilog - Sandelin                                --
//--------------------------------------------------------------------------

module OWM (
  ADDRESS, ADS_bar, CLK, EN_bar, MR, RD_bar, WR_bar, /*DDIR, DOUT,*/ INTR,
  STPZ, DATA_IN, DATA_OUT, 
  DQ0_T, DQ1_T, DQ2_T, DQ3_T, DQ4_T, DQ5_T, DQ6_T, DQ7_T, 
  DQ0_O, DQ1_O, DQ2_O, DQ3_O, DQ4_O, DQ5_O, DQ6_O, DQ7_O, 
  DQ0_I, DQ1_I, DQ2_I, DQ3_I, DQ4_I, DQ5_I, DQ6_I, DQ7_I);

  input  [2:0] ADDRESS;  // SFR address
  input  ADS_bar;        // address latch control (active low)
  input  CLK;            // system clock
  input  EN_bar;         // SFR access enable (active low)
  input  MR;             // master reset
  input  RD_bar;         // SFR read (active low)
  input  WR_bar;         // SFR write (active low)

  //output DDIR;
  //output [7:0] DOUT;
  output INTR;           // one wire master interrupt
  output STPZ;           // strong pullup (active low)

  input [7:0] DATA_IN;     // input DATA bus
  output [7:0] DATA_OUT;   // output DATA bus
  
  output  DQ0_T;
  output  DQ1_T;
  output  DQ2_T;
  output  DQ3_T;
  output  DQ4_T;
  output  DQ5_T;
  output  DQ6_T;
  output  DQ7_T;
  
  output  DQ0_O;
  output  DQ1_O;
  output  DQ2_O;
  output  DQ3_O;
  output  DQ4_O;
  output  DQ5_O;
  output  DQ6_O;
  output  DQ7_O;
  
  input   DQ0_I;
  input   DQ1_I;
  input   DQ2_I;
  input   DQ3_I;
  input   DQ4_I;
  input   DQ5_I;
  input   DQ6_I;
  input   DQ7_I;
  
  wire   [2:0] dq_sel;

  wire  [7:0] DIN;
  wire  [7:0] DOUT;
  wire  [7:0] rcvr_buffer;
  wire  [7:0] xmit_buffer;
  wire  [2:0] ADDRESS;
  wire clk_1us;

  one_wire_io xone_wire_io
  (
    .CLK(CLK), 
    .DDIR(DDIR),
    .DOUT(DOUT), 
    .DQ_CONTROL(DQ_CONTROL),
    .MR(MR),
    .DIN(DIN),
    .DQ_IN(DQ_IN),
    .DATA_IN(DATA_IN),
    .DATA_OUT(DATA_OUT),
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
    .DQ7_I(DQ7_I),
    

    .DQ_SEL(dq_sel)
  );

  clk_prescaler xclk_prescaler
  (
    .CLK(CLK),
    .CLK_EN(CLK_EN), 
    .div_1(div_1), 
    .div_2(div_2), 
    .div_3(div_3), 
    .MR(MR), 
    .pre_0(pre_0), 
    .pre_1(pre_1), 
    .clk_1us(clk_1us)
  );

  one_wire_interface xone_wire_interface
  (
    .ADDRESS(ADDRESS), 
    .ADS_bar(ADS_bar), 
    .clear_interrupts(clear_interrupts), 
    .DIN(DIN), 
    .DQ_IN(DQ_IN), 
    .EN_bar(EN_bar), 
    .FSM_CLK(FSM_CLK), 
    .MR(MR),
    .OneWireIO_eq_Load(OneWireIO_eq_Load), 
    .pdr(pdr), 
    .OW_LOW(OW_LOW), 
    .OW_SHORT(OW_SHORT), 
    .rbf(rbf), 
    .rcvr_buffer(rcvr_buffer), 
    .RD_bar(RD_bar),
    .reset_owr(reset_owr), 
    .rsrf(rsrf), 
    .temt(temt), 
    .WR_bar(WR_bar), 
    .BIT_CTL(BIT_CTL), 
    .CLK_EN(CLK_EN), 
    .clr_activate_intr(clr_activate_intr), 
    .DDIR(DDIR),
    .div_1(div_1), 
    .div_2(div_2), 
    .div_3(div_3), 
    .DOUT(DOUT), 
    .EN_FOW(EN_FOW), 
    .EOWL(EOWL), 
    .EOWSH(EOWSH), 
    .epd(epd), 
    .erbf(erbf), 
    .ersf(ersf),
    .etbe(etbe), 
    .etmt(etmt), 
    .FOW(FOW), 
    .ias(ias), 
    .LLM(LLM), 
    .OD(OD), 
    .owr(owr), 
    .pd(pd), 
    .PPM(PPM), 
    .pre_0(pre_0), 
    .pre_1(pre_1), 
    .rbf_reset(rbf_reset),
    .sr_a(sr_a), 
    .STP_SPLY(STP_SPLY), 
    .STPEN(STPEN), 
    .tbe(tbe), 
    .xmit_buffer(xmit_buffer),
    .dq_sel(dq_sel)
   );

  onewiremaster xonewiremaster(
    .BIT_CTL(BIT_CTL), 
    .clk(CLK), 
    .clk_1us_en(clk_1us), 
    .clr_activate_intr(clr_activate_intr), 
    .DQ_IN(DQ_IN), 
    .EN_FOW(EN_FOW), 
    .EOWL(EOWL),
    .EOWSH(EOWSH), 
    .epd(epd), 
    .erbf(erbf), 
    .ersf(ersf), 
    .etbe(etbe), 
    .etmt(etmt), 
    .FOW(FOW), 
    .ias(ias), 
    .LLM(LLM), 
    .MR(MR), 
    .OD(OD),
    .owr(owr), 
    .pd(pd), 
    .PPM(PPM), 
    .rbf_reset(rbf_reset), 
    .sr_a(sr_a), 
    .STP_SPLY(STP_SPLY), 
    .STPEN(STPEN), 
    .tbe(tbe), 
    .xmit_buffer(xmit_buffer),
    .clear_interrupts(clear_interrupts), 
    .DQ_CONTROL(DQ_CONTROL), 
    .FSM_CLK(FSM_CLK), 
    .INTR(INTR), 
    .OneWireIO_eq_Load(OneWireIO_eq_Load), 
    .OW_LOW(OW_LOW),
    .OW_SHORT(OW_SHORT), 
    .pdr(pdr), 
    .rbf(rbf), 
    .rcvr_buffer(rcvr_buffer), 
    .reset_owr(reset_owr), 
    .rsrf(rsrf), 
    .STPZ(STPZ), 
    .temt(temt)
   );


  //synthesis attribute clock_signal of clk_1us IS no

  //synthesis attribute buffer_type of clk_1us IS none


endmodule
