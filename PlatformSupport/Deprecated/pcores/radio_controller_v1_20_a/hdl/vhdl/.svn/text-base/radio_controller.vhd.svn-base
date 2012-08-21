------------------------------------------------------------------------------
-- radio_controller.vhd - entity/architecture pair
------------------------------------------------------------------------------
-- IMPORTANT:
-- DO NOT MODIFY THIS FILE EXCEPT IN THE DESIGNATED SECTIONS.
--
-- SEARCH FOR --USER TO DETERMINE WHERE CHANGES ARE ALLOWED.
--
-- TYPICALLY, THE ONLY ACCEPTABLE CHANGES INVOLVE ADDING NEW
-- PORTS AND GENERICS THAT GET PASSED THROUGH TO THE INSTANTIATION
-- OF THE USER_LOGIC ENTITY.
------------------------------------------------------------------------------
--
-- ***************************************************************************
-- ** Copyright (c) 1995-2007 Xilinx, Inc.  All rights reserved.            **
-- **                                                                       **
-- ** Xilinx, Inc.                                                          **
-- ** XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"         **
-- ** AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND       **
-- ** SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,        **
-- ** OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,        **
-- ** APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION           **
-- ** THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,     **
-- ** AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE      **
-- ** FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY              **
-- ** WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE               **
-- ** IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR        **
-- ** REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF       **
-- ** INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS       **
-- ** FOR A PARTICULAR PURPOSE.                                             **
-- **                                                                       **
-- ***************************************************************************
--
------------------------------------------------------------------------------
-- Filename:          radio_controller.vhd
-- Version:           1.20.a
-- Description:       Top level design, instantiates library components and user logic.
-- Date:              Wed Feb 06 13:11:09 2008 (by Create and Import Peripheral Wizard)
-- VHDL Standard:     VHDL'93
------------------------------------------------------------------------------
-- Naming Conventions:
--   active low signals:                    "*_n"
--   clock signals:                         "clk", "clk_div#", "clk_#x"
--   reset signals:                         "rst", "rst_n"
--   generics:                              "C_*"
--   user defined types:                    "*_TYPE"
--   state machine next state:              "*_ns"
--   state machine current state:           "*_cs"
--   combinatorial signals:                 "*_com"
--   pipelined or register delay signals:   "*_d#"
--   counter signals:                       "*cnt*"
--   clock enable signals:                  "*_ce"
--   internal version of output port:       "*_i"
--   device pins:                           "*_pin"
--   ports:                                 "- Names begin with Uppercase"
--   processes:                             "*_PROCESS"
--   component instantiations:              "<ENTITY_>I_<#|FUNC>"
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library proc_common_v2_00_a;
use proc_common_v2_00_a.proc_common_pkg.all;
use proc_common_v2_00_a.ipif_pkg.all;

library plbv46_slave_single_v1_00_a;
use plbv46_slave_single_v1_00_a.plbv46_slave_single;

------------------------------------------------------------------------------
-- Entity section
------------------------------------------------------------------------------
-- Definition of Generics:
--   C_BASEADDR                   -- PLBv46 slave: base address
--   C_HIGHADDR                   -- PLBv46 slave: high address
--   C_SPLB_AWIDTH                -- PLBv46 slave: address bus width
--   C_SPLB_DWIDTH                -- PLBv46 slave: data bus width
--   C_SPLB_NUM_MASTERS           -- PLBv46 slave: Number of masters
--   C_SPLB_MID_WIDTH             -- PLBv46 slave: master ID bus width
--   C_SPLB_NATIVE_DWIDTH         -- PLBv46 slave: internal native data bus width
--   C_SPLB_P2P                   -- PLBv46 slave: point to point interconnect scheme
--   C_SPLB_SUPPORT_BURSTS        -- PLBv46 slave: support bursts
--   C_SPLB_SMALLEST_MASTER       -- PLBv46 slave: width of the smallest master
--   C_SPLB_CLK_PERIOD_PS         -- PLBv46 slave: bus clock in picoseconds
--   C_FAMILY                     -- Xilinx FPGA family
--
-- Definition of Ports:
--   SPLB_Clk                     -- PLB main bus clock
--   SPLB_Rst                     -- PLB main bus reset
--   PLB_ABus                     -- PLB address bus
--   PLB_UABus                    -- PLB upper address bus
--   PLB_PAValid                  -- PLB primary address valid indicator
--   PLB_SAValid                  -- PLB secondary address valid indicator
--   PLB_rdPrim                   -- PLB secondary to primary read request indicator
--   PLB_wrPrim                   -- PLB secondary to primary write request indicator
--   PLB_masterID                 -- PLB current master identifier
--   PLB_abort                    -- PLB abort request indicator
--   PLB_busLock                  -- PLB bus lock
--   PLB_RNW                      -- PLB read/not write
--   PLB_BE                       -- PLB byte enables
--   PLB_MSize                    -- PLB master data bus size
--   PLB_size                     -- PLB transfer size
--   PLB_type                     -- PLB transfer type
--   PLB_lockErr                  -- PLB lock error indicator
--   PLB_wrDBus                   -- PLB write data bus
--   PLB_wrBurst                  -- PLB burst write transfer indicator
--   PLB_rdBurst                  -- PLB burst read transfer indicator
--   PLB_wrPendReq                -- PLB write pending bus request indicator
--   PLB_rdPendReq                -- PLB read pending bus request indicator
--   PLB_wrPendPri                -- PLB write pending request priority
--   PLB_rdPendPri                -- PLB read pending request priority
--   PLB_reqPri                   -- PLB current request priority
--   PLB_TAttribute               -- PLB transfer attribute
--   Sl_addrAck                   -- Slave address acknowledge
--   Sl_SSize                     -- Slave data bus size
--   Sl_wait                      -- Slave wait indicator
--   Sl_rearbitrate               -- Slave re-arbitrate bus indicator
--   Sl_wrDAck                    -- Slave write data acknowledge
--   Sl_wrComp                    -- Slave write transfer complete indicator
--   Sl_wrBTerm                   -- Slave terminate write burst transfer
--   Sl_rdDBus                    -- Slave read data bus
--   Sl_rdWdAddr                  -- Slave read word address
--   Sl_rdDAck                    -- Slave read data acknowledge
--   Sl_rdComp                    -- Slave read transfer complete indicator
--   Sl_rdBTerm                   -- Slave terminate read burst transfer
--   Sl_MBusy                     -- Slave busy indicator
--   Sl_MWrErr                    -- Slave write error indicator
--   Sl_MRdErr                    -- Slave read error indicator
--   Sl_MIRQ                      -- Slave interrupt indicator
------------------------------------------------------------------------------

entity radio_controller is
  generic
  (
    -- ADD USER GENERICS BELOW THIS LINE ---------------
    --USER generics added here
    -- ADD USER GENERICS ABOVE THIS LINE ---------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol parameters, do not add to or delete
    C_BASEADDR                     : std_logic_vector     := X"FFFFFFFF";
    C_HIGHADDR                     : std_logic_vector     := X"00000000";
    C_SPLB_AWIDTH                  : integer              := 32;
    C_SPLB_DWIDTH                  : integer              := 128;
    C_SPLB_NUM_MASTERS             : integer              := 8;
    C_SPLB_MID_WIDTH               : integer              := 3;
    C_SPLB_NATIVE_DWIDTH           : integer              := 32;
    C_SPLB_P2P                     : integer              := 0;
    C_SPLB_SUPPORT_BURSTS          : integer              := 0;
    C_SPLB_SMALLEST_MASTER         : integer              := 32;
    C_SPLB_CLK_PERIOD_PS           : integer              := 10000;
    C_FAMILY                       : string               := "virtex5"
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );
  port
  (
    -- ADD USER PORTS BELOW THIS LINE ------------------

    spi_clk				: out std_logic;
    data_out				: out std_logic;
    radio1_cs				: out std_logic;
    radio2_cs				: out std_logic;
    radio3_cs				: out std_logic;
    radio4_cs				: out std_logic;
    dac1_cs				: out std_logic;
    dac2_cs				: out std_logic;
    dac3_cs				: out std_logic;
    dac4_cs				: out std_logic;
    radio1_SHDN                         : out std_logic;
    radio1_TxEn                         : out std_logic;
    radio1_RxEn                         : out std_logic;
    radio1_RxHP                         : out std_logic;
    radio1_LD                           : in std_logic;
    radio1_24PA                         : out std_logic;
    radio1_5PA                          : out std_logic;
    radio1_ANTSW                        : out std_logic_vector(0 to 1);
    radio1_LED                          : out std_logic_vector(0 to 2);
    radio1_ADC_RX_DCS                   : out std_logic;
    radio1_ADC_RX_DFS                   : out std_logic;
    radio1_ADC_RX_OTRA                  : in std_logic;
    radio1_ADC_RX_OTRB                  : in std_logic;
    radio1_ADC_RX_PWDNA                 : out std_logic;
    radio1_ADC_RX_PWDNB                 : out std_logic;
    radio1_DIPSW                        : in std_logic_vector(0 to 3);
    radio1_RSSI_ADC_CLAMP               : out std_logic;
    radio1_RSSI_ADC_HIZ                 : out std_logic;
    radio1_RSSI_ADC_OTR                 : in std_logic;
    radio1_RSSI_ADC_SLEEP               : out std_logic;
    radio1_RSSI_ADC_D                   : in std_logic_vector(0 to 9);
    radio1_TX_DAC_PLL_LOCK              : in std_logic;
    radio1_TX_DAC_RESET                 : out std_logic;
    radio1_SHDN_external		: in std_logic;
    radio1_TxEn_external		: in std_logic;
    radio1_RxEn_external		: in std_logic;
    radio1_RxHP_external		: in std_logic;
    radio1_TxGain			: out std_logic_vector(0 to 5);
    radio1_TxStart			: out std_logic;
    radio2_SHDN                         : out std_logic;
    radio2_TxEn                         : out std_logic;
    radio2_RxEn                         : out std_logic;
    radio2_RxHP                         : out std_logic;
    radio2_LD                           : in std_logic;
    radio2_24PA                         : out std_logic;
    radio2_5PA                          : out std_logic;
    radio2_ANTSW                        : out std_logic_vector(0 to 1);
    radio2_LED                          : out std_logic_vector(0 to 2);
    radio2_ADC_RX_DCS                   : out std_logic;
    radio2_ADC_RX_DFS                   : out std_logic;
    radio2_ADC_RX_OTRA                  : in std_logic;
    radio2_ADC_RX_OTRB                  : in std_logic;
    radio2_ADC_RX_PWDNA                 : out std_logic;
    radio2_ADC_RX_PWDNB                 : out std_logic;
    radio2_DIPSW                        : in std_logic_vector(0 to 3);
    radio2_RSSI_ADC_CLAMP               : out std_logic;
    radio2_RSSI_ADC_HIZ                 : out std_logic;
    radio2_RSSI_ADC_OTR                 : in std_logic;
    radio2_RSSI_ADC_SLEEP               : out std_logic;
    radio2_RSSI_ADC_D                   : in std_logic_vector(0 to 9);
    radio2_TX_DAC_PLL_LOCK              : in std_logic;
    radio2_TX_DAC_RESET                 : out std_logic;
    radio2_SHDN_external		: in std_logic;
    radio2_TxEn_external		: in std_logic;
    radio2_RxEn_external		: in std_logic;
    radio2_RxHP_external		: in std_logic;
    radio2_TxGain			: out std_logic_vector(0 to 5);
    radio2_TxStart			: out std_logic;
    radio3_SHDN                         : out std_logic;
    radio3_TxEn                         : out std_logic;
    radio3_RxEn                         : out std_logic;
    radio3_RxHP                         : out std_logic;
    radio3_LD                           : in std_logic;
    radio3_24PA                         : out std_logic;
    radio3_5PA                          : out std_logic;
    radio3_ANTSW                        : out std_logic_vector(0 to 1);
    radio3_LED                          : out std_logic_vector(0 to 2);
    radio3_ADC_RX_DCS                   : out std_logic;
    radio3_ADC_RX_DFS                   : out std_logic;
    radio3_ADC_RX_OTRA                  : in std_logic;
    radio3_ADC_RX_OTRB                  : in std_logic;
    radio3_ADC_RX_PWDNA                 : out std_logic;
    radio3_ADC_RX_PWDNB                 : out std_logic;
    radio3_DIPSW                        : in std_logic_vector(0 to 3);
    radio3_RSSI_ADC_CLAMP               : out std_logic;
    radio3_RSSI_ADC_HIZ                 : out std_logic;
    radio3_RSSI_ADC_OTR                 : in std_logic;
    radio3_RSSI_ADC_SLEEP               : out std_logic;
    radio3_RSSI_ADC_D                   : in std_logic_vector(0 to 9);
    radio3_TX_DAC_PLL_LOCK              : in std_logic;
    radio3_TX_DAC_RESET                 : out std_logic;
    radio3_SHDN_external		: in std_logic;
    radio3_TxEn_external		: in std_logic;
    radio3_RxEn_external		: in std_logic;
    radio3_RxHP_external		: in std_logic;
    radio3_TxGain			: out std_logic_vector(0 to 5);
    radio3_TxStart			: out std_logic;
    radio4_SHDN                         : out std_logic;
    radio4_TxEn                         : out std_logic;
    radio4_RxEn                         : out std_logic;
    radio4_RxHP                         : out std_logic;
    radio4_LD                           : in std_logic;
    radio4_24PA                         : out std_logic;
    radio4_5PA                          : out std_logic;
    radio4_ANTSW                        : out std_logic_vector(0 to 1);
    radio4_LED                          : out std_logic_vector(0 to 2);
    radio4_ADC_RX_DCS                   : out std_logic;
    radio4_ADC_RX_DFS                   : out std_logic;
    radio4_ADC_RX_OTRA                  : in std_logic;
    radio4_ADC_RX_OTRB                  : in std_logic;
    radio4_ADC_RX_PWDNA                 : out std_logic;
    radio4_ADC_RX_PWDNB                 : out std_logic;
    radio4_DIPSW                        : in std_logic_vector(0 to 3);
    radio4_RSSI_ADC_CLAMP               : out std_logic;
    radio4_RSSI_ADC_HIZ                 : out std_logic;
    radio4_RSSI_ADC_OTR                 : in std_logic;
    radio4_RSSI_ADC_SLEEP               : out std_logic;
    radio4_RSSI_ADC_D                   : in std_logic_vector(0 to 9);
    radio4_TX_DAC_PLL_LOCK              : in std_logic;
    radio4_TX_DAC_RESET                 : out std_logic;
    radio4_SHDN_external		: in std_logic;
    radio4_TxEn_external		: in std_logic;
    radio4_RxEn_external		: in std_logic;
    radio4_RxHP_external		: in std_logic;
    radio4_TxGain			: out std_logic_vector(0 to 5);
    radio4_TxStart			: out std_logic;
    -- ADD USER PORTS ABOVE THIS LINE ------------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol ports, do not add to or delete
    SPLB_Clk                       : in  std_logic;
    SPLB_Rst                       : in  std_logic;
    PLB_ABus                       : in  std_logic_vector(0 to 31);
    PLB_UABus                      : in  std_logic_vector(0 to 31);
    PLB_PAValid                    : in  std_logic;
    PLB_SAValid                    : in  std_logic;
    PLB_rdPrim                     : in  std_logic;
    PLB_wrPrim                     : in  std_logic;
    PLB_masterID                   : in  std_logic_vector(0 to C_SPLB_MID_WIDTH-1);
    PLB_abort                      : in  std_logic;
    PLB_busLock                    : in  std_logic;
    PLB_RNW                        : in  std_logic;
    PLB_BE                         : in  std_logic_vector(0 to C_SPLB_DWIDTH/8-1);
    PLB_MSize                      : in  std_logic_vector(0 to 1);
    PLB_size                       : in  std_logic_vector(0 to 3);
    PLB_type                       : in  std_logic_vector(0 to 2);
    PLB_lockErr                    : in  std_logic;
    PLB_wrDBus                     : in  std_logic_vector(0 to C_SPLB_DWIDTH-1);
    PLB_wrBurst                    : in  std_logic;
    PLB_rdBurst                    : in  std_logic;
    PLB_wrPendReq                  : in  std_logic;
    PLB_rdPendReq                  : in  std_logic;
    PLB_wrPendPri                  : in  std_logic_vector(0 to 1);
    PLB_rdPendPri                  : in  std_logic_vector(0 to 1);
    PLB_reqPri                     : in  std_logic_vector(0 to 1);
    PLB_TAttribute                 : in  std_logic_vector(0 to 15);
    Sl_addrAck                     : out std_logic;
    Sl_SSize                       : out std_logic_vector(0 to 1);
    Sl_wait                        : out std_logic;
    Sl_rearbitrate                 : out std_logic;
    Sl_wrDAck                      : out std_logic;
    Sl_wrComp                      : out std_logic;
    Sl_wrBTerm                     : out std_logic;
    Sl_rdDBus                      : out std_logic_vector(0 to C_SPLB_DWIDTH-1);
    Sl_rdWdAddr                    : out std_logic_vector(0 to 3);
    Sl_rdDAck                      : out std_logic;
    Sl_rdComp                      : out std_logic;
    Sl_rdBTerm                     : out std_logic;
    Sl_MBusy                       : out std_logic_vector(0 to C_SPLB_NUM_MASTERS-1);
    Sl_MWrErr                      : out std_logic_vector(0 to C_SPLB_NUM_MASTERS-1);
    Sl_MRdErr                      : out std_logic_vector(0 to C_SPLB_NUM_MASTERS-1);
    Sl_MIRQ                        : out std_logic_vector(0 to C_SPLB_NUM_MASTERS-1)
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );

  attribute SIGIS : string;
  attribute SIGIS of SPLB_Clk      : signal is "CLK";
  attribute SIGIS of SPLB_Rst      : signal is "RST";

end entity radio_controller;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture IMP of radio_controller is

  ------------------------------------------
  -- Array of base/high address pairs for each address range
  ------------------------------------------
  constant ZERO_ADDR_PAD                  : std_logic_vector(0 to 31) := (others => '0');
  constant USER_SLV_BASEADDR              : std_logic_vector     := C_BASEADDR;
  constant USER_SLV_HIGHADDR              : std_logic_vector     := C_HIGHADDR;

  constant IPIF_ARD_ADDR_RANGE_ARRAY      : SLV64_ARRAY_TYPE     := 
    (
      ZERO_ADDR_PAD & USER_SLV_BASEADDR,  -- user logic slave space base address
      ZERO_ADDR_PAD & USER_SLV_HIGHADDR   -- user logic slave space high address
    );

  ------------------------------------------
  -- Array of desired number of chip enables for each address range
  ------------------------------------------
  constant USER_SLV_NUM_REG               : integer              := 17;
  constant USER_NUM_REG                   : integer              := USER_SLV_NUM_REG;

  constant IPIF_ARD_NUM_CE_ARRAY          : INTEGER_ARRAY_TYPE   := 
    (
      0  => pad_power2(USER_SLV_NUM_REG)  -- number of ce for user logic slave space
    );

  ------------------------------------------
  -- Ratio of bus clock to core clock (for use in dual clock systems)
  -- 1 = ratio is 1:1
  -- 2 = ratio is 2:1
  ------------------------------------------
  constant IPIF_BUS2CORE_CLK_RATIO        : integer              := 1;

  ------------------------------------------
  -- Width of the slave data bus (32 only)
  ------------------------------------------
  constant USER_SLV_DWIDTH                : integer              := C_SPLB_NATIVE_DWIDTH;

  constant IPIF_SLV_DWIDTH                : integer              := C_SPLB_NATIVE_DWIDTH;

  ------------------------------------------
  -- Index for CS/CE
  ------------------------------------------
  constant USER_SLV_CS_INDEX              : integer              := 0;
  constant USER_SLV_CE_INDEX              : integer              := calc_start_ce_index(IPIF_ARD_NUM_CE_ARRAY, USER_SLV_CS_INDEX);

  constant USER_CE_INDEX                  : integer              := USER_SLV_CE_INDEX;

  ------------------------------------------
  -- IP Interconnect (IPIC) signal declarations
  ------------------------------------------
  signal ipif_Bus2IP_Clk                : std_logic;
  signal ipif_Bus2IP_Reset              : std_logic;
  signal ipif_IP2Bus_Data               : std_logic_vector(0 to IPIF_SLV_DWIDTH-1);
  signal ipif_IP2Bus_WrAck              : std_logic;
  signal ipif_IP2Bus_RdAck              : std_logic;
  signal ipif_IP2Bus_Error              : std_logic;
  signal ipif_Bus2IP_Addr               : std_logic_vector(0 to C_SPLB_AWIDTH-1);
  signal ipif_Bus2IP_Data               : std_logic_vector(0 to IPIF_SLV_DWIDTH-1);
  signal ipif_Bus2IP_RNW                : std_logic;
  signal ipif_Bus2IP_BE                 : std_logic_vector(0 to IPIF_SLV_DWIDTH/8-1);
  signal ipif_Bus2IP_CS                 : std_logic_vector(0 to ((IPIF_ARD_ADDR_RANGE_ARRAY'length)/2)-1);
  signal ipif_Bus2IP_RdCE               : std_logic_vector(0 to calc_num_ce(IPIF_ARD_NUM_CE_ARRAY)-1);
  signal ipif_Bus2IP_WrCE               : std_logic_vector(0 to calc_num_ce(IPIF_ARD_NUM_CE_ARRAY)-1);
  signal user_Bus2IP_RdCE               : std_logic_vector(0 to USER_NUM_REG-1);
  signal user_Bus2IP_WrCE               : std_logic_vector(0 to USER_NUM_REG-1);
  signal user_IP2Bus_Data               : std_logic_vector(0 to USER_SLV_DWIDTH-1);
  signal user_IP2Bus_RdAck              : std_logic;
  signal user_IP2Bus_WrAck              : std_logic;
  signal user_IP2Bus_Error              : std_logic;

  ------------------------------------------
  -- Component declaration for verilog user logic
  ------------------------------------------
  component user_logic is
    generic
    (
      -- ADD USER GENERICS BELOW THIS LINE ---------------
      --USER generics added here
      -- ADD USER GENERICS ABOVE THIS LINE ---------------

      -- DO NOT EDIT BELOW THIS LINE ---------------------
      -- Bus protocol parameters, do not add to or delete
      C_SLV_DWIDTH                   : integer              := 32;
      C_NUM_REG                      : integer              := 17
      -- DO NOT EDIT ABOVE THIS LINE ---------------------
    );
    port
    (
      -- ADD USER PORTS BELOW THIS LINE ------------------
      spi_clk				: out std_logic;
      data_out				: out std_logic;
      Radio1_cs				: out std_logic;
      Radio2_cs				: out std_logic;
      Radio3_cs				: out std_logic;
      Radio4_cs				: out std_logic;
      Dac1_cs				: out std_logic;
      Dac2_cs				: out std_logic;
      Dac3_cs				: out std_logic;
      Dac4_cs				: out std_logic;
      Radio1_SHDN                       : out std_logic;
      Radio1_TxEn                       : out std_logic;
      Radio1_RxEn                       : out std_logic;
      Radio1_RxHP                       : out std_logic;
      Radio1_LD                         : in std_logic;
      Radio1_24PA                       : out std_logic;
      Radio1_5PA                        : out std_logic;
      Radio1_ANTSW                      : out std_logic_vector(0 to 1);
      Radio1_LED                        : out std_logic_vector(0 to 2);
      Radio1_ADC_RX_DCS                 : out std_logic;
      Radio1_ADC_RX_DFS                 : out std_logic;
      Radio1_ADC_RX_OTRA                : in std_logic;
      Radio1_ADC_RX_OTRB                : in std_logic;
      Radio1_ADC_RX_PWDNA               : out std_logic;
      Radio1_ADC_RX_PWDNB               : out std_logic;
      Radio1_DIPSW                      : in std_logic_vector(0 to 3);
      Radio1_RSSI_ADC_CLAMP             : out std_logic;
      Radio1_RSSI_ADC_HIZ               : out std_logic;
      Radio1_RSSI_ADC_OTR               : in std_logic;
      Radio1_RSSI_ADC_SLEEP             : out std_logic;
      Radio1_RSSI_ADC_D                 : in std_logic_vector(0 to 9);
      Radio1_TX_DAC_PLL_LOCK            : in std_logic;
      Radio1_TX_DAC_RESET               : out std_logic;
      Radio1_SHDN_external		: in std_logic;
      Radio1_TxEn_external		: in std_logic;
      Radio1_RxEn_external		: in std_logic;
      Radio1_RxHP_external		: in std_logic;
      Radio1_TxGain			: out std_logic_vector(0 to 5);
      Radio1_TxStart			: out std_logic;
      Radio2_SHDN                       : out std_logic;
      Radio2_TxEn                       : out std_logic;
      Radio2_RxEn                       : out std_logic;
      Radio2_RxHP                       : out std_logic;
      Radio2_LD                         : in std_logic;
      Radio2_24PA                       : out std_logic;
      Radio2_5PA                        : out std_logic;
      Radio2_ANTSW                      : out std_logic_vector(0 to 1);
      Radio2_LED                        : out std_logic_vector(0 to 2);
      Radio2_ADC_RX_DCS                 : out std_logic;
      Radio2_ADC_RX_DFS                 : out std_logic;
      Radio2_ADC_RX_OTRA                : in std_logic;
      Radio2_ADC_RX_OTRB                : in std_logic;
      Radio2_ADC_RX_PWDNA               : out std_logic;
      Radio2_ADC_RX_PWDNB               : out std_logic;
      Radio2_DIPSW                      : in std_logic_vector(0 to 3);
      Radio2_RSSI_ADC_CLAMP             : out std_logic;
      Radio2_RSSI_ADC_HIZ               : out std_logic;
      Radio2_RSSI_ADC_OTR               : in std_logic;
      Radio2_RSSI_ADC_SLEEP             : out std_logic;
      Radio2_RSSI_ADC_D                 : in std_logic_vector(0 to 9);
      Radio2_TX_DAC_PLL_LOCK            : in std_logic;
      Radio2_TX_DAC_RESET               : out std_logic;
      Radio2_SHDN_external		: in std_logic;
      Radio2_TxEn_external		: in std_logic;
      Radio2_RxEn_external		: in std_logic;
      Radio2_RxHP_external		: in std_logic;
      Radio2_TxGain			: out std_logic_vector(0 to 5);
      Radio2_TxStart			: out std_logic;
      Radio3_SHDN                       : out std_logic;
      Radio3_TxEn                       : out std_logic;
      Radio3_RxEn                       : out std_logic;
      Radio3_RxHP                       : out std_logic;
      Radio3_LD                         : in std_logic;
      Radio3_24PA                       : out std_logic;
      Radio3_5PA                        : out std_logic;
      Radio3_ANTSW                      : out std_logic_vector(0 to 1);
      Radio3_LED                        : out std_logic_vector(0 to 2);
      Radio3_ADC_RX_DCS                 : out std_logic;
      Radio3_ADC_RX_DFS                 : out std_logic;
      Radio3_ADC_RX_OTRA                : in std_logic;
      Radio3_ADC_RX_OTRB                : in std_logic;
      Radio3_ADC_RX_PWDNA               : out std_logic;
      Radio3_ADC_RX_PWDNB               : out std_logic;
      Radio3_DIPSW                      : in std_logic_vector(0 to 3);
      Radio3_RSSI_ADC_CLAMP             : out std_logic;
      Radio3_RSSI_ADC_HIZ               : out std_logic;
      Radio3_RSSI_ADC_OTR               : in std_logic;
      Radio3_RSSI_ADC_SLEEP             : out std_logic;
      Radio3_RSSI_ADC_D                 : in std_logic_vector(0 to 9);
      Radio3_TX_DAC_PLL_LOCK            : in std_logic;
      Radio3_TX_DAC_RESET               : out std_logic;
      Radio3_SHDN_external		: in std_logic;
      Radio3_TxEn_external		: in std_logic;
      Radio3_RxEn_external		: in std_logic;
      Radio3_RxHP_external		: in std_logic;
      Radio3_TxGain			: out std_logic_vector(0 to 5);
      Radio3_TxStart			: out std_logic;
      Radio4_SHDN                       : out std_logic;
      Radio4_TxEn                       : out std_logic;
      Radio4_RxEn                       : out std_logic;
      Radio4_RxHP                       : out std_logic;
      Radio4_LD                         : in std_logic;
      Radio4_24PA                       : out std_logic;
      Radio4_5PA                        : out std_logic;
      Radio4_ANTSW                      : out std_logic_vector(0 to 1);
      Radio4_LED                        : out std_logic_vector(0 to 2);
      Radio4_ADC_RX_DCS                 : out std_logic;
      Radio4_ADC_RX_DFS                 : out std_logic;
      Radio4_ADC_RX_OTRA                : in std_logic;
      Radio4_ADC_RX_OTRB                : in std_logic;
      Radio4_ADC_RX_PWDNA               : out std_logic;
      Radio4_ADC_RX_PWDNB               : out std_logic;
      Radio4_DIPSW                      : in std_logic_vector(0 to 3);
      Radio4_RSSI_ADC_CLAMP             : out std_logic;
      Radio4_RSSI_ADC_HIZ               : out std_logic;
      Radio4_RSSI_ADC_OTR               : in std_logic;
      Radio4_RSSI_ADC_SLEEP             : out std_logic;
      Radio4_RSSI_ADC_D                 : in std_logic_vector(0 to 9);
      Radio4_TX_DAC_PLL_LOCK            : in std_logic;
      Radio4_TX_DAC_RESET               : out std_logic;
      Radio4_SHDN_external		: in std_logic;
      Radio4_TxEn_external		: in std_logic;
      Radio4_RxEn_external		: in std_logic;
      Radio4_RxHP_external		: in std_logic;
      Radio4_TxGain			: out std_logic_vector(0 to 5);
      Radio4_TxStart			: out std_logic;
      -- ADD USER PORTS ABOVE THIS LINE ------------------

      -- DO NOT EDIT BELOW THIS LINE ---------------------
      -- Bus protocol ports, do not add to or delete
      Bus2IP_Clk                     : in  std_logic;
      Bus2IP_Reset                   : in  std_logic;
      Bus2IP_Data                    : in  std_logic_vector(0 to C_SLV_DWIDTH-1);
      Bus2IP_BE                      : in  std_logic_vector(0 to C_SLV_DWIDTH/8-1);
      Bus2IP_RdCE                    : in  std_logic_vector(0 to C_NUM_REG-1);
      Bus2IP_WrCE                    : in  std_logic_vector(0 to C_NUM_REG-1);
      IP2Bus_Data                    : out std_logic_vector(0 to C_SLV_DWIDTH-1);
      IP2Bus_RdAck                   : out std_logic;
      IP2Bus_WrAck                   : out std_logic;
      IP2Bus_Error                   : out std_logic
      -- DO NOT EDIT ABOVE THIS LINE ---------------------
    );
  end component user_logic;

begin

  ------------------------------------------
  -- instantiate plbv46_slave_single
  ------------------------------------------
  PLBV46_SLAVE_SINGLE_I : entity plbv46_slave_single_v1_00_a.plbv46_slave_single
    generic map
    (
      C_ARD_ADDR_RANGE_ARRAY         => IPIF_ARD_ADDR_RANGE_ARRAY,
      C_ARD_NUM_CE_ARRAY             => IPIF_ARD_NUM_CE_ARRAY,
      C_SPLB_P2P                     => C_SPLB_P2P,
      C_BUS2CORE_CLK_RATIO           => IPIF_BUS2CORE_CLK_RATIO,
      C_SPLB_MID_WIDTH               => C_SPLB_MID_WIDTH,
      C_SPLB_NUM_MASTERS             => C_SPLB_NUM_MASTERS,
      C_SPLB_AWIDTH                  => C_SPLB_AWIDTH,
      C_SPLB_DWIDTH                  => C_SPLB_DWIDTH,
      C_SIPIF_DWIDTH                 => IPIF_SLV_DWIDTH,
      C_FAMILY                       => C_FAMILY
    )
    port map
    (
      SPLB_Clk                       => SPLB_Clk,
      SPLB_Rst                       => SPLB_Rst,
      PLB_ABus                       => PLB_ABus,
      PLB_UABus                      => PLB_UABus,
      PLB_PAValid                    => PLB_PAValid,
      PLB_SAValid                    => PLB_SAValid,
      PLB_rdPrim                     => PLB_rdPrim,
      PLB_wrPrim                     => PLB_wrPrim,
      PLB_masterID                   => PLB_masterID,
      PLB_abort                      => PLB_abort,
      PLB_busLock                    => PLB_busLock,
      PLB_RNW                        => PLB_RNW,
      PLB_BE                         => PLB_BE,
      PLB_MSize                      => PLB_MSize,
      PLB_size                       => PLB_size,
      PLB_type                       => PLB_type,
      PLB_lockErr                    => PLB_lockErr,
      PLB_wrDBus                     => PLB_wrDBus,
      PLB_wrBurst                    => PLB_wrBurst,
      PLB_rdBurst                    => PLB_rdBurst,
      PLB_wrPendReq                  => PLB_wrPendReq,
      PLB_rdPendReq                  => PLB_rdPendReq,
      PLB_wrPendPri                  => PLB_wrPendPri,
      PLB_rdPendPri                  => PLB_rdPendPri,
      PLB_reqPri                     => PLB_reqPri,
      PLB_TAttribute                 => PLB_TAttribute,
      Sl_addrAck                     => Sl_addrAck,
      Sl_SSize                       => Sl_SSize,
      Sl_wait                        => Sl_wait,
      Sl_rearbitrate                 => Sl_rearbitrate,
      Sl_wrDAck                      => Sl_wrDAck,
      Sl_wrComp                      => Sl_wrComp,
      Sl_wrBTerm                     => Sl_wrBTerm,
      Sl_rdDBus                      => Sl_rdDBus,
      Sl_rdWdAddr                    => Sl_rdWdAddr,
      Sl_rdDAck                      => Sl_rdDAck,
      Sl_rdComp                      => Sl_rdComp,
      Sl_rdBTerm                     => Sl_rdBTerm,
      Sl_MBusy                       => Sl_MBusy,
      Sl_MWrErr                      => Sl_MWrErr,
      Sl_MRdErr                      => Sl_MRdErr,
      Sl_MIRQ                        => Sl_MIRQ,
      Bus2IP_Clk                     => ipif_Bus2IP_Clk,
      Bus2IP_Reset                   => ipif_Bus2IP_Reset,
      IP2Bus_Data                    => ipif_IP2Bus_Data,
      IP2Bus_WrAck                   => ipif_IP2Bus_WrAck,
      IP2Bus_RdAck                   => ipif_IP2Bus_RdAck,
      IP2Bus_Error                   => ipif_IP2Bus_Error,
      Bus2IP_Addr                    => ipif_Bus2IP_Addr,
      Bus2IP_Data                    => ipif_Bus2IP_Data,
      Bus2IP_RNW                     => ipif_Bus2IP_RNW,
      Bus2IP_BE                      => ipif_Bus2IP_BE,
      Bus2IP_CS                      => ipif_Bus2IP_CS,
      Bus2IP_RdCE                    => ipif_Bus2IP_RdCE,
      Bus2IP_WrCE                    => ipif_Bus2IP_WrCE
    );

  ------------------------------------------
  -- instantiate User Logic
  ------------------------------------------
  USER_LOGIC_I : component user_logic
    generic map
    (
      -- MAP USER GENERICS BELOW THIS LINE ---------------
      --USER generics mapped here
      -- MAP USER GENERICS ABOVE THIS LINE ---------------

      C_SLV_DWIDTH                   => USER_SLV_DWIDTH,
      C_NUM_REG                      => USER_NUM_REG
    )
    port map
    (
      -- MAP USER PORTS BELOW THIS LINE ------------------

      spi_clk			                => spi_clk,
      data_out			                => data_out,
      Radio1_cs			                => radio1_cs,
      Radio2_cs			                => radio2_cs,
      Radio3_cs			                => radio3_cs,
      Radio4_cs			                => radio4_cs,
      Dac1_cs			                => dac1_cs,
      Dac2_cs			                => dac2_cs,
      Dac3_cs			                => dac3_cs,
      Dac4_cs			                => dac4_cs,
      Radio1_SHDN                               => radio1_SHDN,
      Radio1_TxEn                               => radio1_TxEn,
      Radio1_RxEn                               => radio1_RxEn,
      Radio1_RxHP                               => radio1_RxHP,
      Radio1_LD                                 => radio1_LD,
      Radio1_24PA                               => radio1_24PA,
      Radio1_5PA                                => radio1_5PA,
      Radio1_ANTSW                              => radio1_ANTSW,
      Radio1_LED                                => radio1_LED,
      Radio1_ADC_RX_DCS                         => radio1_ADC_RX_DCS,
      Radio1_ADC_RX_DFS                         => radio1_ADC_RX_DFS,
      Radio1_ADC_RX_OTRA                        => radio1_ADC_RX_OTRA,
      Radio1_ADC_RX_OTRB                        => radio1_ADC_RX_OTRB,
      Radio1_ADC_RX_PWDNA                       => radio1_ADC_RX_PWDNA,
      Radio1_ADC_RX_PWDNB                       => radio1_ADC_RX_PWDNB,
      Radio1_DIPSW                              => radio1_DIPSW,
      Radio1_RSSI_ADC_CLAMP                     => radio1_RSSI_ADC_CLAMP,
      Radio1_RSSI_ADC_HIZ                       => radio1_RSSI_ADC_HIZ,
      Radio1_RSSI_ADC_OTR                       => radio1_RSSI_ADC_OTR,
      Radio1_RSSI_ADC_SLEEP                     => radio1_RSSI_ADC_SLEEP,
      Radio1_RSSI_ADC_D                         => radio1_RSSI_ADC_D,
      Radio1_TX_DAC_PLL_LOCK                    => radio1_TX_DAC_PLL_LOCK,
      Radio1_TX_DAC_RESET                       => radio1_TX_DAC_RESET,
      Radio1_SHDN_external			=> radio1_SHDN_external,
      Radio1_TxEn_external			=> radio1_TxEn_external,
      Radio1_RxEn_external			=> radio1_RxEn_external,
      Radio1_RxHP_external			=> radio1_RxHP_external,
      Radio1_TxGain				=> radio1_TxGain,
      Radio1_TxStart				=> radio1_TxStart,
      Radio2_SHDN                               => radio2_SHDN,
      Radio2_TxEn                               => radio2_TxEn,
      Radio2_RxEn                               => radio2_RxEn,
      Radio2_RxHP                               => radio2_RxHP,
      Radio2_LD                                 => radio2_LD,
      Radio2_24PA                               => radio2_24PA,
      Radio2_5PA                                => radio2_5PA,
      Radio2_ANTSW                              => radio2_ANTSW,
      Radio2_LED                                => radio2_LED,
      Radio2_ADC_RX_DCS                         => radio2_ADC_RX_DCS,
      Radio2_ADC_RX_DFS                         => radio2_ADC_RX_DFS,
      Radio2_ADC_RX_OTRA                        => radio2_ADC_RX_OTRA,
      Radio2_ADC_RX_OTRB                        => radio2_ADC_RX_OTRB,
      Radio2_ADC_RX_PWDNA                       => radio2_ADC_RX_PWDNA,
      Radio2_ADC_RX_PWDNB                       => radio2_ADC_RX_PWDNB,
      Radio2_DIPSW                              => radio2_DIPSW,
      Radio2_RSSI_ADC_CLAMP                     => radio2_RSSI_ADC_CLAMP,
      Radio2_RSSI_ADC_HIZ                       => radio2_RSSI_ADC_HIZ,
      Radio2_RSSI_ADC_OTR                       => radio2_RSSI_ADC_OTR,
      Radio2_RSSI_ADC_SLEEP                     => radio2_RSSI_ADC_SLEEP,
      Radio2_RSSI_ADC_D                         => radio2_RSSI_ADC_D,
      Radio2_TX_DAC_PLL_LOCK                    => radio2_TX_DAC_PLL_LOCK,
      Radio2_TX_DAC_RESET                       => radio2_TX_DAC_RESET,
      Radio2_SHDN_external			=> radio2_SHDN_external,
      Radio2_TxEn_external			=> radio2_TxEn_external,
      Radio2_RxEn_external			=> radio2_RxEn_external,
      Radio2_RxHP_external			=> radio2_RxHP_external,
      Radio2_TxGain				=> radio2_TxGain,
      Radio2_TxStart				=> radio2_TxStart,
      Radio3_SHDN                               => radio3_SHDN,
      Radio3_TxEn                               => radio3_TxEn,
      Radio3_RxEn                               => radio3_RxEn,
      Radio3_RxHP                               => radio3_RxHP,
      Radio3_LD                                 => radio3_LD,
      Radio3_24PA                               => radio3_24PA,
      Radio3_5PA                                => radio3_5PA,
      Radio3_ANTSW                              => radio3_ANTSW,
      Radio3_LED                                => radio3_LED,
      Radio3_ADC_RX_DCS                         => radio3_ADC_RX_DCS,
      Radio3_ADC_RX_DFS                         => radio3_ADC_RX_DFS,
      Radio3_ADC_RX_OTRA                        => radio3_ADC_RX_OTRA,
      Radio3_ADC_RX_OTRB                        => radio3_ADC_RX_OTRB,
      Radio3_ADC_RX_PWDNA                       => radio3_ADC_RX_PWDNA,
      Radio3_ADC_RX_PWDNB                       => radio3_ADC_RX_PWDNB,
      Radio3_DIPSW                              => radio3_DIPSW,
      Radio3_RSSI_ADC_CLAMP                     => radio3_RSSI_ADC_CLAMP,
      Radio3_RSSI_ADC_HIZ                       => radio3_RSSI_ADC_HIZ,
      Radio3_RSSI_ADC_OTR                       => radio3_RSSI_ADC_OTR,
      Radio3_RSSI_ADC_SLEEP                     => radio3_RSSI_ADC_SLEEP,
      Radio3_RSSI_ADC_D                         => radio3_RSSI_ADC_D,
      Radio3_TX_DAC_PLL_LOCK                    => radio3_TX_DAC_PLL_LOCK,
      Radio3_TX_DAC_RESET                       => radio3_TX_DAC_RESET,
      Radio3_SHDN_external			=> radio3_SHDN_external,
      Radio3_TxEn_external			=> radio3_TxEn_external,
      Radio3_RxEn_external			=> radio3_RxEn_external,
      Radio3_RxHP_external			=> radio3_RxHP_external,
      Radio3_TxGain				=> radio3_TxGain,
      Radio3_TxStart				=> radio3_TxStart,
      Radio4_SHDN                               => radio4_SHDN,
      Radio4_TxEn                               => radio4_TxEn,
      Radio4_RxEn                               => radio4_RxEn,
      Radio4_RxHP                               => radio4_RxHP,
      Radio4_LD                                 => radio4_LD,
      Radio4_24PA                               => radio4_24PA,
      Radio4_5PA                                => radio4_5PA,
      Radio4_ANTSW                              => radio4_ANTSW,
      Radio4_LED                                => radio4_LED,
      Radio4_ADC_RX_DCS                         => radio4_ADC_RX_DCS,
      Radio4_ADC_RX_DFS                         => radio4_ADC_RX_DFS,
      Radio4_ADC_RX_OTRA                        => radio4_ADC_RX_OTRA,
      Radio4_ADC_RX_OTRB                        => radio4_ADC_RX_OTRB,
      Radio4_ADC_RX_PWDNA                       => radio4_ADC_RX_PWDNA,
      Radio4_ADC_RX_PWDNB                       => radio4_ADC_RX_PWDNB,
      Radio4_DIPSW                              => radio4_DIPSW,
      Radio4_RSSI_ADC_CLAMP                     => radio4_RSSI_ADC_CLAMP,
      Radio4_RSSI_ADC_HIZ                       => radio4_RSSI_ADC_HIZ,
      Radio4_RSSI_ADC_OTR                       => radio4_RSSI_ADC_OTR,
      Radio4_RSSI_ADC_SLEEP                     => radio4_RSSI_ADC_SLEEP,
      Radio4_RSSI_ADC_D                         => radio4_RSSI_ADC_D,
      Radio4_TX_DAC_PLL_LOCK                    => radio4_TX_DAC_PLL_LOCK,
      Radio4_TX_DAC_RESET                       => radio4_TX_DAC_RESET,
      Radio4_SHDN_external			=> radio4_SHDN_external,
      Radio4_TxEn_external			=> radio4_TxEn_external,
      Radio4_RxEn_external			=> radio4_RxEn_external,
      Radio4_RxHP_external			=> radio4_RxHP_external,
      Radio4_TxGain				=> radio4_TxGain,
      Radio4_TxStart				=> radio4_TxStart,
      -- MAP USER PORTS ABOVE THIS LINE ------------------

      Bus2IP_Clk                     => ipif_Bus2IP_Clk,
      Bus2IP_Reset                   => ipif_Bus2IP_Reset,
      Bus2IP_Data                    => ipif_Bus2IP_Data,
      Bus2IP_BE                      => ipif_Bus2IP_BE,
      Bus2IP_RdCE                    => user_Bus2IP_RdCE,
      Bus2IP_WrCE                    => user_Bus2IP_WrCE,
      IP2Bus_Data                    => user_IP2Bus_Data,
      IP2Bus_RdAck                   => user_IP2Bus_RdAck,
      IP2Bus_WrAck                   => user_IP2Bus_WrAck,
      IP2Bus_Error                   => user_IP2Bus_Error
    );

  ------------------------------------------
  -- connect internal signals
  ------------------------------------------
  ipif_IP2Bus_Data <= user_IP2Bus_Data;
  ipif_IP2Bus_WrAck <= user_IP2Bus_WrAck;
  ipif_IP2Bus_RdAck <= user_IP2Bus_RdAck;
  ipif_IP2Bus_Error <= user_IP2Bus_Error;

  user_Bus2IP_RdCE <= ipif_Bus2IP_RdCE(USER_CE_INDEX to USER_CE_INDEX+USER_NUM_REG-1);
  user_Bus2IP_WrCE <= ipif_Bus2IP_WrCE(USER_CE_INDEX to USER_CE_INDEX+USER_NUM_REG-1);

end IMP;
