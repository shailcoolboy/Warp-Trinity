-------------------------------------------------------------------
-- System Generator version 10.1.00 VHDL source file.
--
-- Copyright(C) 2007 by Xilinx, Inc.  All rights reserved.  This
-- text/file contains proprietary, confidential information of Xilinx,
-- Inc., is distributed under license from Xilinx, Inc., and may be used,
-- copied and/or disclosed only pursuant to the terms of a valid license
-- agreement with Xilinx, Inc.  Xilinx hereby grants you a license to use
-- this text/file solely for design, simulation, implementation and
-- creation of design files limited to Xilinx devices or technologies.
-- Use with non-Xilinx devices or technologies is expressly prohibited
-- and immediately terminates your license unless covered by a separate
-- agreement.
--
-- Xilinx is providing this design, code, or information "as is" solely
-- for use in developing programs and solutions for Xilinx devices.  By
-- providing this design, code, or information as one possible
-- implementation of this feature, application or standard, Xilinx is
-- making no representation that this implementation is free from any
-- claims of infringement.  You are responsible for obtaining any rights
-- you may require for your implementation.  Xilinx expressly disclaims
-- any warranty whatsoever with respect to the adequacy of the
-- implementation, including but not limited to warranties of
-- merchantability or fitness for a particular purpose.
--
-- Xilinx products are not intended for use in life support appliances,
-- devices, or systems.  Use in such applications is expressly prohibited.
--
-- Any modifications that are made to the source code are done at the user's
-- sole risk and will be unsupported.
--
-- This copyright and support notice must be retained as part of this
-- text at all times.  (c) Copyright 1995-2007 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity plbaddrpref is
    generic (
        C_BASEADDR : std_logic_vector(31 downto 0) := X"80000000";
        C_HIGHADDR : std_logic_vector(31 downto 0) := X"8000FFFF";
        C_SPLB_DWIDTH         : integer range 32 to 128   := 32;
        C_SPLB_NATIVE_DWIDTH  : integer range 32 to 32    := 32
    );
    port (
        addrpref           : out std_logic_vector(15-1 downto 0);
        sl_rddbus          : out std_logic_vector(0 to C_SPLB_DWIDTH-1);
        plb_wrdbus         : in  std_logic_vector(0 to C_SPLB_DWIDTH-1);
        sgsl_rddbus        : in  std_logic_vector(0 to C_SPLB_NATIVE_DWIDTH-1);
        sgplb_wrdbus       : out std_logic_vector(0 to C_SPLB_NATIVE_DWIDTH-1)
    );
end plbaddrpref;

architecture behavior of plbaddrpref is

signal sl_rddbus_i            : std_logic_vector(0 to C_SPLB_DWIDTH-1);

begin
    addrpref <= C_BASEADDR(32-1 downto 17);

-------------------------------------------------------------------------------
-- Mux/Steer data/be's correctly for connect 32-bit slave to 128-bit plb
-------------------------------------------------------------------------------
GEN_128_TO_32_SLAVE : if C_SPLB_NATIVE_DWIDTH = 32 and C_SPLB_DWIDTH = 128 generate
begin
    -----------------------------------------------------------------------
    -- Map lower rd data to each quarter of the plb slave read bus
    -----------------------------------------------------------------------
    sl_rddbus_i(0 to 31)      <=  sgsl_rddbus(0 to C_SPLB_NATIVE_DWIDTH-1);
    sl_rddbus_i(32 to 63)     <=  sgsl_rddbus(0 to C_SPLB_NATIVE_DWIDTH-1);
    sl_rddbus_i(64 to 95)     <=  sgsl_rddbus(0 to C_SPLB_NATIVE_DWIDTH-1);
    sl_rddbus_i(96 to 127)    <=  sgsl_rddbus(0 to C_SPLB_NATIVE_DWIDTH-1);
end generate GEN_128_TO_32_SLAVE;

-------------------------------------------------------------------------------
-- Mux/Steer data/be's correctly for connect 32-bit slave to 64-bit plb
-------------------------------------------------------------------------------
GEN_64_TO_32_SLAVE : if C_SPLB_NATIVE_DWIDTH = 32 and C_SPLB_DWIDTH = 64 generate
begin
    ---------------------------------------------------------------------------        
    -- Map lower rd data to upper and lower halves of plb slave read bus
    ---------------------------------------------------------------------------        
    sl_rddbus_i(0 to 31)      <=  sgsl_rddbus(0 to C_SPLB_NATIVE_DWIDTH-1);
    sl_rddbus_i(32 to 63)     <=  sgsl_rddbus(0 to C_SPLB_NATIVE_DWIDTH-1);
end generate GEN_64_TO_32_SLAVE;

-------------------------------------------------------------------------------
-- IPIF DWidth = PLB DWidth
-- If IPIF Slave Data width is equal to the PLB Bus Data Width
-- Then BE and Read Data Bus map directly to eachother.
-------------------------------------------------------------------------------
GEN_FOR_EQUAL_SLAVE : if C_SPLB_NATIVE_DWIDTH = C_SPLB_DWIDTH generate
    sl_rddbus_i    <= sgsl_rddbus;
end generate GEN_FOR_EQUAL_SLAVE;

    sl_rddbus       <= sl_rddbus_i;
    sgplb_wrdbus    <= plb_wrdbus(0 to C_SPLB_NATIVE_DWIDTH-1);

end behavior;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

entity user_io_board_controller_plbw is
  generic (
    C_BASEADDR: std_logic_vector(31 downto 0) := X"80000000";
    C_HIGHADDR: std_logic_vector(31 downto 0) := X"80000FFF";
    C_SPLB_DWIDTH: integer range 32 to 128 := 32;
    C_SPLB_NATIVE_DWIDTH: integer range 32 to 32 := 32;
    C_SPLB_AWIDTH: integer := 0;
    C_SPLB_P2P: integer := 0;
    C_SPLB_MID_WIDTH: integer := 0;
    C_SPLB_NUM_MASTERS: integer := 0;
    C_SPLB_SUPPORT_BURSTS: integer := 0;
    C_MEMMAP_BUTTONS_BIG: integer := 0;
    C_MEMMAP_BUTTONS_BIG_N_BITS: integer := 0;
    C_MEMMAP_BUTTONS_BIG_BIN_PT: integer := 0;
    C_MEMMAP_BUTTONS_SMALL: integer := 0;
    C_MEMMAP_BUTTONS_SMALL_N_BITS: integer := 0;
    C_MEMMAP_BUTTONS_SMALL_BIN_PT: integer := 0;
    C_MEMMAP_DIP_SWITCH: integer := 0;
    C_MEMMAP_DIP_SWITCH_N_BITS: integer := 0;
    C_MEMMAP_DIP_SWITCH_BIN_PT: integer := 0;
    C_MEMMAP_TRACKBALL: integer := 0;
    C_MEMMAP_TRACKBALL_N_BITS: integer := 0;
    C_MEMMAP_TRACKBALL_BIN_PT: integer := 0;
    C_MEMMAP_BUZZER_DUTYCYCLE: integer := 0;
    C_MEMMAP_BUZZER_DUTYCYCLE_N_BITS: integer := 0;
    C_MEMMAP_BUZZER_DUTYCYCLE_BIN_PT: integer := 0;
    C_MEMMAP_BUZZER_ENABLE: integer := 0;
    C_MEMMAP_BUZZER_ENABLE_N_BITS: integer := 0;
    C_MEMMAP_BUZZER_ENABLE_BIN_PT: integer := 0;
    C_MEMMAP_BUZZER_PERIOD: integer := 0;
    C_MEMMAP_BUZZER_PERIOD_N_BITS: integer := 0;
    C_MEMMAP_BUZZER_PERIOD_BIN_PT: integer := 0;
    C_MEMMAP_LCD_BACKGROUNDCOLOR: integer := 0;
    C_MEMMAP_LCD_BACKGROUNDCOLOR_N_BITS: integer := 0;
    C_MEMMAP_LCD_BACKGROUNDCOLOR_BIN_PT: integer := 0;
    C_MEMMAP_LCD_CHARACTEROFFSET: integer := 0;
    C_MEMMAP_LCD_CHARACTEROFFSET_N_BITS: integer := 0;
    C_MEMMAP_LCD_CHARACTEROFFSET_BIN_PT: integer := 0;
    C_MEMMAP_LCD_CHARACTERSSELECT: integer := 0;
    C_MEMMAP_LCD_CHARACTERSSELECT_N_BITS: integer := 0;
    C_MEMMAP_LCD_CHARACTERSSELECT_BIN_PT: integer := 0;
    C_MEMMAP_LCD_COLSET: integer := 0;
    C_MEMMAP_LCD_COLSET_N_BITS: integer := 0;
    C_MEMMAP_LCD_COLSET_BIN_PT: integer := 0;
    C_MEMMAP_LCD_CONFIGLOCATION: integer := 0;
    C_MEMMAP_LCD_CONFIGLOCATION_N_BITS: integer := 0;
    C_MEMMAP_LCD_CONFIGLOCATION_BIN_PT: integer := 0;
    C_MEMMAP_LCD_DIVIDERSELECT: integer := 0;
    C_MEMMAP_LCD_DIVIDERSELECT_N_BITS: integer := 0;
    C_MEMMAP_LCD_DIVIDERSELECT_BIN_PT: integer := 0;
    C_MEMMAP_LCD_FIRSTEND: integer := 0;
    C_MEMMAP_LCD_FIRSTEND_N_BITS: integer := 0;
    C_MEMMAP_LCD_FIRSTEND_BIN_PT: integer := 0;
    C_MEMMAP_LCD_FIRSTSTART: integer := 0;
    C_MEMMAP_LCD_FIRSTSTART_N_BITS: integer := 0;
    C_MEMMAP_LCD_FIRSTSTART_BIN_PT: integer := 0;
    C_MEMMAP_LCD_LINEOFFSET: integer := 0;
    C_MEMMAP_LCD_LINEOFFSET_N_BITS: integer := 0;
    C_MEMMAP_LCD_LINEOFFSET_BIN_PT: integer := 0;
    C_MEMMAP_LCD_RAMWRITE: integer := 0;
    C_MEMMAP_LCD_RAMWRITE_N_BITS: integer := 0;
    C_MEMMAP_LCD_RAMWRITE_BIN_PT: integer := 0;
    C_MEMMAP_LCD_RESET: integer := 0;
    C_MEMMAP_LCD_RESET_N_BITS: integer := 0;
    C_MEMMAP_LCD_RESET_BIN_PT: integer := 0;
    C_MEMMAP_LCD_RESETLCD: integer := 0;
    C_MEMMAP_LCD_RESETLCD_N_BITS: integer := 0;
    C_MEMMAP_LCD_RESETLCD_BIN_PT: integer := 0;
    C_MEMMAP_LCD_ROWSET: integer := 0;
    C_MEMMAP_LCD_ROWSET_N_BITS: integer := 0;
    C_MEMMAP_LCD_ROWSET_BIN_PT: integer := 0;
    C_MEMMAP_LCD_SECONDEND: integer := 0;
    C_MEMMAP_LCD_SECONDEND_N_BITS: integer := 0;
    C_MEMMAP_LCD_SECONDEND_BIN_PT: integer := 0;
    C_MEMMAP_LCD_SECONDSTART: integer := 0;
    C_MEMMAP_LCD_SECONDSTART_N_BITS: integer := 0;
    C_MEMMAP_LCD_SECONDSTART_BIN_PT: integer := 0;
    C_MEMMAP_LCD_SEND: integer := 0;
    C_MEMMAP_LCD_SEND_N_BITS: integer := 0;
    C_MEMMAP_LCD_SEND_BIN_PT: integer := 0;
    C_MEMMAP_LCD_TOTALCMDTRANSFER: integer := 0;
    C_MEMMAP_LCD_TOTALCMDTRANSFER_N_BITS: integer := 0;
    C_MEMMAP_LCD_TOTALCMDTRANSFER_BIN_PT: integer := 0;
    C_MEMMAP_LEDS: integer := 0;
    C_MEMMAP_LEDS_N_BITS: integer := 0;
    C_MEMMAP_LEDS_BIN_PT: integer := 0;
    C_MEMMAP_LCD_CHARACTERMAP: integer := 0;
    C_MEMMAP_LCD_CHARACTERMAP_N_BITS: integer := 0;
    C_MEMMAP_LCD_CHARACTERMAP_BIN_PT: integer := 0;
    C_MEMMAP_LCD_CHARACTERS: integer := 0;
    C_MEMMAP_LCD_CHARACTERS_N_BITS: integer := 0;
    C_MEMMAP_LCD_CHARACTERS_BIN_PT: integer := 0;
    C_MEMMAP_LCD_COMMANDS: integer := 0;
    C_MEMMAP_LCD_COMMANDS_N_BITS: integer := 0;
    C_MEMMAP_LCD_COMMANDS_BIN_PT: integer := 0
  );
  port (
    buttons_big: in std_logic_vector(0 to 1); 
    buttons_small: in std_logic_vector(0 to 5); 
    ce: in std_logic; 
    dip_switch: in std_logic_vector(0 to 3); 
    plb_abus: in std_logic_vector(0 to 31); 
    plb_pavalid: in std_logic; 
    plb_rnw: in std_logic; 
    plb_wrdbus: in std_logic_vector(0 to C_SPLB_DWIDTH-1); 
    reset: in std_logic; 
    splb_clk: in std_logic; 
    splb_rst: in std_logic; 
    trackball_ox: in std_logic; 
    trackball_oxn: in std_logic; 
    trackball_oy: in std_logic; 
    trackball_oyn: in std_logic; 
    trackball_sel2: in std_logic; 
    buzzer: out std_logic; 
    cs: out std_logic; 
    leds: out std_logic_vector(0 to 7); 
    resetlcd: out std_logic; 
    scl: out std_logic; 
    sdi: out std_logic; 
    sl_addrack: out std_logic; 
    sl_rdcomp: out std_logic; 
    sl_rddack: out std_logic; 
    sl_rddbus: out std_logic_vector(0 to C_SPLB_DWIDTH-1); 
    sl_wait: out std_logic; 
    sl_wrcomp: out std_logic; 
    sl_wrdack: out std_logic; 
    trackball_sel1: out std_logic; 
    trackball_xscn: out std_logic; 
    trackball_yscn: out std_logic
  );
end user_io_board_controller_plbw;

architecture structural of user_io_board_controller_plbw is
  signal buttons_big_x0: std_logic_vector(1 downto 0);
  signal buttons_small_x0: std_logic_vector(5 downto 0);
  signal buzzer_x0: std_logic;
  signal ce_x0: std_logic;
  signal clk: std_logic;
  signal cs_x0: std_logic;
  signal dip_switch_x0: std_logic_vector(3 downto 0);
  signal leds_x0: std_logic_vector(7 downto 0);
  signal plb_abus_x0: std_logic_vector(31 downto 0);
  signal plb_pavalid_x0: std_logic;
  signal plb_rnw_x0: std_logic;
  signal plbaddrpref_addrpref_net: std_logic_vector(14 downto 0);
  signal plbaddrpref_plb_wrdbus_net: std_logic_vector(C_SPLB_DWIDTH-1 downto 0);
  signal plbaddrpref_sgplb_wrdbus_net: std_logic_vector(31 downto 0);
  signal plbaddrpref_sgsl_rddbus_net: std_logic_vector(31 downto 0);
  signal plbaddrpref_sl_rddbus_net: std_logic_vector(C_SPLB_DWIDTH-1 downto 0);
  signal reset_x0: std_logic;
  signal resetlcd_x0: std_logic;
  signal scl_x0: std_logic;
  signal sdi_x0: std_logic;
  signal sl_addrack_x0: std_logic;
  signal sl_rdcomp_x0: std_logic;
  signal sl_rddack_x0: std_logic;
  signal sl_wait_x0: std_logic;
  signal sl_wrcomp_x0: std_logic;
  signal sl_wrdack_x0: std_logic;
  signal splb_rst_x0: std_logic;
  signal trackball_ox_x0: std_logic;
  signal trackball_oxn_x0: std_logic;
  signal trackball_oy_x0: std_logic;
  signal trackball_oyn_x0: std_logic;
  signal trackball_sel1_x0: std_logic;
  signal trackball_sel2_x0: std_logic;
  signal trackball_xscn_x0: std_logic;
  signal trackball_yscn_x0: std_logic;

begin
  buttons_big_x0 <= buttons_big;
  buttons_small_x0 <= buttons_small;
  ce_x0 <= ce;
  dip_switch_x0 <= dip_switch;
  plb_abus_x0 <= plb_abus;
  plb_pavalid_x0 <= plb_pavalid;
  plb_rnw_x0 <= plb_rnw;
  plbaddrpref_plb_wrdbus_net <= plb_wrdbus;
  reset_x0 <= reset;
  clk <= splb_clk;
  splb_rst_x0 <= splb_rst;
  trackball_ox_x0 <= trackball_ox;
  trackball_oxn_x0 <= trackball_oxn;
  trackball_oy_x0 <= trackball_oy;
  trackball_oyn_x0 <= trackball_oyn;
  trackball_sel2_x0 <= trackball_sel2;
  buzzer <= buzzer_x0;
  cs <= cs_x0;
  leds <= leds_x0;
  resetlcd <= resetlcd_x0;
  scl <= scl_x0;
  sdi <= sdi_x0;
  sl_addrack <= sl_addrack_x0;
  sl_rdcomp <= sl_rdcomp_x0;
  sl_rddack <= sl_rddack_x0;
  sl_rddbus <= plbaddrpref_sl_rddbus_net;
  sl_wait <= sl_wait_x0;
  sl_wrcomp <= sl_wrcomp_x0;
  sl_wrdack <= sl_wrdack_x0;
  trackball_sel1 <= trackball_sel1_x0;
  trackball_xscn <= trackball_xscn_x0;
  trackball_yscn <= trackball_yscn_x0;

  plbaddrpref_x0: entity work.plbaddrpref
    generic map (
      C_BASEADDR => C_BASEADDR,
      C_HIGHADDR => C_HIGHADDR,
      C_SPLB_DWIDTH => C_SPLB_DWIDTH,
      C_SPLB_NATIVE_DWIDTH => C_SPLB_NATIVE_DWIDTH
    )
    port map (
      plb_wrdbus => plbaddrpref_plb_wrdbus_net,
      sgsl_rddbus => plbaddrpref_sgsl_rddbus_net,
      addrpref => plbaddrpref_addrpref_net,
      sgplb_wrdbus => plbaddrpref_sgplb_wrdbus_net,
      sl_rddbus => plbaddrpref_sl_rddbus_net
    );

  sysgen_dut: entity work.user_io_board_controller_cw
    port map (
      buttons_big => buttons_big_x0,
      buttons_small => buttons_small_x0,
      ce => ce_x0,
      clk => clk,
      dip_switch => dip_switch_x0,
      plb_abus => plb_abus_x0,
      plb_pavalid => plb_pavalid_x0,
      plb_rnw => plb_rnw_x0,
      plb_wrdbus => plbaddrpref_sgplb_wrdbus_net,
      reset => reset_x0,
      sg_plb_addrpref => plbaddrpref_addrpref_net,
      splb_rst => splb_rst_x0,
      trackball_ox => trackball_ox_x0,
      trackball_oxn => trackball_oxn_x0,
      trackball_oy => trackball_oy_x0,
      trackball_oyn => trackball_oyn_x0,
      trackball_sel2 => trackball_sel2_x0,
      buzzer => buzzer_x0,
      cs => cs_x0,
      leds => leds_x0,
      resetlcd => resetlcd_x0,
      scl => scl_x0,
      sdi => sdi_x0,
      sl_addrack => sl_addrack_x0,
      sl_rdcomp => sl_rdcomp_x0,
      sl_rddack => sl_rddack_x0,
      sl_rddbus => plbaddrpref_sgsl_rddbus_net,
      sl_wait => sl_wait_x0,
      sl_wrcomp => sl_wrcomp_x0,
      sl_wrdack => sl_wrdack_x0,
      trackball_sel1 => trackball_sel1_x0,
      trackball_xscn => trackball_xscn_x0,
      trackball_yscn => trackball_yscn_x0
    );

end structural;
