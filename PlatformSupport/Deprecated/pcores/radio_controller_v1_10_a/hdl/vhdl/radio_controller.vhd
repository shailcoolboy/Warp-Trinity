-- Copyright (c) 2006 Rice University
-- All Rights Reserved
-- This code is covered by the Rice-WARP license
-- See http://warp.rice.edu/license/ for details

------------------------------------------------------------------------------
-- radio_controller.vhd - entity/architecture pair
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library proc_common_v2_00_a;
use proc_common_v2_00_a.proc_common_pkg.all;
use proc_common_v2_00_a.ipif_pkg.all;
library opb_ipif_v3_01_c;
use opb_ipif_v3_01_c.all;

library radio_controller_v1_10_a;
use radio_controller_v1_10_a.all;

------------------------------------------------------------------------------
-- Entity section
------------------------------------------------------------------------------
-- Definition of Generics:
--   C_BASEADDR                   -- User logic base address
--   C_HIGHADDR                   -- User logic high address
--   C_OPB_AWIDTH                 -- OPB address bus width
--   C_OPB_DWIDTH                 -- OPB data bus width
--   C_FAMILY                     -- Target FPGA architecture
--
-- Definition of Ports:
--   OPB_Clk                      -- OPB Clock
--   OPB_Rst                      -- OPB Reset
--   Sl_DBus                      -- Slave data bus
--   Sl_errAck                    -- Slave error acknowledge
--   Sl_retry                     -- Slave retry
--   Sl_toutSup                   -- Slave timeout suppress
--   Sl_xferAck                   -- Slave transfer acknowledge
--   OPB_ABus                     -- OPB address bus
--   OPB_BE                       -- OPB byte enable
--   OPB_DBus                     -- OPB data bus
--   OPB_RNW                      -- OPB read/not write
--   OPB_select                   -- OPB select
--   OPB_seqAddr                  -- OPB sequential address
------------------------------------------------------------------------------

entity radio_controller is
  generic
  (
    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol parameters, do not add to or delete
    C_BASEADDR                     : std_logic_vector     := X"00000000";
    C_HIGHADDR                     : std_logic_vector     := X"0000FFFF";
    C_OPB_AWIDTH                   : integer              := 32;
    C_OPB_DWIDTH                   : integer              := 32;
    C_FAMILY                       : string               := "virtex2p"
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
    OPB_Clk                        : in  std_logic;
    OPB_Rst                        : in  std_logic;
    Sl_DBus                        : out std_logic_vector(0 to C_OPB_DWIDTH-1);
    Sl_errAck                      : out std_logic;
    Sl_retry                       : out std_logic;
    Sl_toutSup                     : out std_logic;
    Sl_xferAck                     : out std_logic;
    OPB_ABus                       : in  std_logic_vector(0 to C_OPB_AWIDTH-1);
    OPB_BE                         : in  std_logic_vector(0 to C_OPB_DWIDTH/8-1);
    OPB_DBus                       : in  std_logic_vector(0 to C_OPB_DWIDTH-1);
    OPB_RNW                        : in  std_logic;
    OPB_select                     : in  std_logic;
    OPB_seqAddr                    : in  std_logic
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );

  attribute SIGIS : string;
  attribute SIGIS of OPB_Clk       : signal is "Clk";
  attribute SIGIS of OPB_Rst       : signal is "Rst";

end entity radio_controller;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture IMP of radio_controller is

  ------------------------------------------
  -- Constant: array of address range identifiers
  ------------------------------------------
  constant ARD_ID_ARRAY                   : INTEGER_ARRAY_TYPE   := 
    (
      0  => USER_00                           -- user logic S/W register address space
    );

  ------------------------------------------
  -- Constant: array of address pairs for each address range
  ------------------------------------------
  constant ZERO_ADDR_PAD                  : std_logic_vector(0 to 64-C_OPB_AWIDTH-1) := (others => '0');

  constant USER_BASEADDR  : std_logic_vector  := C_BASEADDR;
  constant USER_HIGHADDR  : std_logic_vector  := C_HIGHADDR;

  constant ARD_ADDR_RANGE_ARRAY           : SLV64_ARRAY_TYPE     := 
    (
      ZERO_ADDR_PAD & USER_BASEADDR,              -- user logic base address
      ZERO_ADDR_PAD & USER_HIGHADDR               -- user logic high address
    );

  ------------------------------------------
  -- Constant: array of data widths for each target address range
  ------------------------------------------
  constant USER_DWIDTH                    : integer              := 32;

  constant ARD_DWIDTH_ARRAY               : INTEGER_ARRAY_TYPE   := 
    (
      0  => USER_DWIDTH                       -- user logic data width
    );

  ------------------------------------------
  -- Constant: array of desired number of chip enables for each address range
  ------------------------------------------
  constant USER_NUM_CE                    : integer              := 17;

  constant ARD_NUM_CE_ARRAY               : INTEGER_ARRAY_TYPE   := 
    (
      0  => pad_power2(USER_NUM_CE)           -- user logic number of CEs
    );

  ------------------------------------------
  -- Constant: array of unique properties for each address range
  ------------------------------------------
  constant ARD_DEPENDENT_PROPS_ARRAY      : DEPENDENT_PROPS_ARRAY_TYPE := 
    (
      0  => (others => 0)                     -- user logic slave space dependent properties (none defined)
    );

  ------------------------------------------
  -- Constant: pipeline mode
  -- 1 = include OPB-In pipeline registers
  -- 2 = include IP pipeline registers
  -- 3 = include OPB-In and IP pipeline registers
  -- 4 = include OPB-Out pipeline registers
  -- 5 = include OPB-In and OPB-Out pipeline registers
  -- 6 = include IP and OPB-Out pipeline registers
  -- 7 = include OPB-In, IP, and OPB-Out pipeline registers
  -- Note:
  -- only mode 4, 5, 7 are supported for this release
  ------------------------------------------
  constant PIPELINE_MODEL                 : integer              := 5;

  ------------------------------------------
  -- Constant: user core ID code
  ------------------------------------------
  constant DEV_BLK_ID                     : integer              := 0;

  ------------------------------------------
  -- Constant: enable MIR/Reset register
  ------------------------------------------
  constant DEV_MIR_ENABLE                 : integer              := 0;

  ------------------------------------------
  -- Constant: array of IP interrupt mode
  -- 1 = Active-high interrupt condition
  -- 2 = Active-low interrupt condition
  -- 3 = Active-high pulse interrupt event
  -- 4 = Active-low pulse interrupt event
  -- 5 = Positive-edge interrupt event
  -- 6 = Negative-edge interrupt event
  ------------------------------------------
  constant IP_INTR_MODE_ARRAY             : INTEGER_ARRAY_TYPE   := 
    (
      0  => 0  -- not used
    );

  ------------------------------------------
  -- Constant: enable device burst
  ------------------------------------------
  constant DEV_BURST_ENABLE               : integer              := 0;

  ------------------------------------------
  -- Constant: include address counter for burst transfers
  ------------------------------------------
  constant INCLUDE_ADDR_CNTR              : integer              := 0;

  ------------------------------------------
  -- Constant: include write buffer that decouples OPB and IPIC write transactions
  ------------------------------------------
  constant INCLUDE_WR_BUF                 : integer              := 0;

  ------------------------------------------
  -- Constant: index for CS/CE
  ------------------------------------------
  constant USER00_CS_INDEX                : integer              := get_id_index(ARD_ID_ARRAY, USER_00);

  constant USER00_CE_INDEX                : integer              := calc_start_ce_index(ARD_NUM_CE_ARRAY, USER00_CS_INDEX);

  ------------------------------------------
  -- IP Interconnect (IPIC) signal declarations -- do not delete
  -- prefix 'i' stands for IPIF while prefix 'u' stands for user logic
  -- typically user logic will be hooked up to IPIF directly via i<sig>
  -- unless signal slicing and muxing are needed via u<sig>
  ------------------------------------------
  signal iBus2IP_RdCE                   : std_logic_vector(0 to calc_num_ce(ARD_NUM_CE_ARRAY)-1);
  signal iBus2IP_WrCE                   : std_logic_vector(0 to calc_num_ce(ARD_NUM_CE_ARRAY)-1);
  signal iBus2IP_Data                   : std_logic_vector(0 to C_OPB_DWIDTH-1);
  signal iBus2IP_BE                     : std_logic_vector(0 to C_OPB_DWIDTH/8-1);
  signal iIP2Bus_Data                   : std_logic_vector(0 to C_OPB_DWIDTH-1)   := (others => '0');
  signal iIP2Bus_Ack                    : std_logic   := '0';
  signal iIP2Bus_Error                  : std_logic   := '0';
  signal iIP2Bus_Retry                  : std_logic   := '0';
  signal iIP2Bus_ToutSup                : std_logic   := '0';
  signal ENABLE_POSTED_WRITE            : std_logic_vector(0 to ARD_ID_ARRAY'length-1)   := (others => '0'); -- enable posted write behavior
  signal ZERO_IP2RFIFO_Data             : std_logic_vector(0 to ARD_DWIDTH_ARRAY(get_id_index_iboe(ARD_ID_ARRAY, IPIF_RDFIFO_DATA))-1)   := (others => '0'); -- work around for XST not taking (others => '0') in port mapping
  signal ZERO_WFIFO2IP_Data             : std_logic_vector(0 to ARD_DWIDTH_ARRAY(get_id_index_iboe(ARD_ID_ARRAY, IPIF_WRFIFO_DATA))-1)   := (others => '0'); -- work around for XST not taking (others => '0') in port mapping
  signal ZERO_IP2Bus_IntrEvent          : std_logic_vector(0 to IP_INTR_MODE_ARRAY'length-1)   := (others => '0'); -- work around for XST not taking (others => '0') in port mapping
  signal iBus2IP_Clk                    : std_logic;
  signal iBus2IP_Reset                  : std_logic;
  signal uBus2IP_Data                   : std_logic_vector(0 to USER_DWIDTH-1);
  signal uBus2IP_BE                     : std_logic_vector(0 to USER_DWIDTH/8-1);
  signal uBus2IP_RdCE                   : std_logic_vector(0 to USER_NUM_CE-1);
  signal uBus2IP_WrCE                   : std_logic_vector(0 to USER_NUM_CE-1);
  signal uIP2Bus_Data                   : std_logic_vector(0 to USER_DWIDTH-1);

  ------------------------------------------
  -- Component declaration for verilog user logic
  ------------------------------------------
  component user_logic is
    generic
    (
      -- DO NOT EDIT BELOW THIS LINE ---------------------
      -- Bus protocol parameters, do not add to or delete
      C_DWIDTH                       : integer              := 32;
      C_NUM_CE                       : integer              := 17
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
      Bus2IP_Data                    : in  std_logic_vector(0 to C_DWIDTH-1);
      Bus2IP_BE                      : in  std_logic_vector(0 to C_DWIDTH/8-1);
      Bus2IP_RdCE                    : in  std_logic_vector(0 to C_NUM_CE-1);
      Bus2IP_WrCE                    : in  std_logic_vector(0 to C_NUM_CE-1);
      IP2Bus_Data                    : out std_logic_vector(0 to C_DWIDTH-1);
      IP2Bus_Ack                     : out std_logic;
      IP2Bus_Retry                   : out std_logic;
      IP2Bus_Error                   : out std_logic;
      IP2Bus_ToutSup                 : out std_logic
      -- DO NOT EDIT ABOVE THIS LINE ---------------------
    );
  end component user_logic;

begin

  ------------------------------------------
  -- instantiate the OPB IPIF
  ------------------------------------------
  OPB_IPIF_I : entity opb_ipif_v3_01_c.opb_ipif
    generic map
    (
      C_ARD_ID_ARRAY                 => ARD_ID_ARRAY,
      C_ARD_ADDR_RANGE_ARRAY         => ARD_ADDR_RANGE_ARRAY,
      C_ARD_DWIDTH_ARRAY             => ARD_DWIDTH_ARRAY,
      C_ARD_NUM_CE_ARRAY             => ARD_NUM_CE_ARRAY,
      C_ARD_DEPENDENT_PROPS_ARRAY    => ARD_DEPENDENT_PROPS_ARRAY,
      C_PIPELINE_MODEL               => PIPELINE_MODEL,
      C_DEV_BLK_ID                   => DEV_BLK_ID,
      C_DEV_MIR_ENABLE               => DEV_MIR_ENABLE,
      C_OPB_AWIDTH                   => C_OPB_AWIDTH,
      C_OPB_DWIDTH                   => C_OPB_DWIDTH,
      C_FAMILY                       => C_FAMILY,
      C_IP_INTR_MODE_ARRAY           => IP_INTR_MODE_ARRAY,
      C_DEV_BURST_ENABLE             => DEV_BURST_ENABLE,
      C_INCLUDE_ADDR_CNTR            => INCLUDE_ADDR_CNTR,
      C_INCLUDE_WR_BUF               => INCLUDE_WR_BUF
    )
    port map
    (
      OPB_select                     => OPB_select,
      OPB_DBus                       => OPB_DBus,
      OPB_ABus                       => OPB_ABus,
      OPB_BE                         => OPB_BE,
      OPB_RNW                        => OPB_RNW,
      OPB_seqAddr                    => OPB_seqAddr,
      Sln_DBus                       => Sl_DBus,
      Sln_xferAck                    => Sl_xferAck,
      Sln_errAck                     => Sl_errAck,
      Sln_retry                      => Sl_retry,
      Sln_toutSup                    => Sl_toutSup,
      Bus2IP_CS                      => open,
      Bus2IP_CE                      => open,
      Bus2IP_RdCE                    => iBus2IP_RdCE,
      Bus2IP_WrCE                    => iBus2IP_WrCE,
      Bus2IP_Data                    => iBus2IP_Data,
      Bus2IP_Addr                    => open,
      Bus2IP_AddrValid               => open,
      Bus2IP_BE                      => iBus2IP_BE,
      Bus2IP_RNW                     => open,
      Bus2IP_Burst                   => open,
      IP2Bus_Data                    => iIP2Bus_Data,
      IP2Bus_Ack                     => iIP2Bus_Ack,
      IP2Bus_AddrAck                 => '0',
      IP2Bus_Error                   => iIP2Bus_Error,
      IP2Bus_Retry                   => iIP2Bus_Retry,
      IP2Bus_ToutSup                 => iIP2Bus_ToutSup,
      IP2Bus_PostedWrInh             => ENABLE_POSTED_WRITE,
      IP2RFIFO_Data                  => ZERO_IP2RFIFO_Data,
      IP2RFIFO_WrMark                => '0',
      IP2RFIFO_WrRelease             => '0',
      IP2RFIFO_WrReq                 => '0',
      IP2RFIFO_WrRestore             => '0',
      RFIFO2IP_AlmostFull            => open,
      RFIFO2IP_Full                  => open,
      RFIFO2IP_Vacancy               => open,
      RFIFO2IP_WrAck                 => open,
      IP2WFIFO_RdMark                => '0',
      IP2WFIFO_RdRelease             => '0',
      IP2WFIFO_RdReq                 => '0',
      IP2WFIFO_RdRestore             => '0',
      WFIFO2IP_AlmostEmpty           => open,
      WFIFO2IP_Data                  => ZERO_WFIFO2IP_Data,
      WFIFO2IP_Empty                 => open,
      WFIFO2IP_Occupancy             => open,
      WFIFO2IP_RdAck                 => open,
      IP2Bus_IntrEvent               => ZERO_IP2Bus_IntrEvent,
      IP2INTC_Irpt                   => open,
      Freeze                         => '0',
      Bus2IP_Freeze                  => open,
      OPB_Clk                        => OPB_Clk,
      Bus2IP_Clk                     => iBus2IP_Clk,
      IP2Bus_Clk                     => '0',
      Reset                          => OPB_Rst,
      Bus2IP_Reset                   => iBus2IP_Reset
    );

  ------------------------------------------
  -- instantiate the User Logic
  ------------------------------------------
  USER_LOGIC_I : component user_logic
    generic map
    (
      C_DWIDTH                       => USER_DWIDTH,
      C_NUM_CE                       => USER_NUM_CE
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

      Bus2IP_Clk                     => iBus2IP_Clk,
      Bus2IP_Reset                   => iBus2IP_Reset,
      Bus2IP_Data                    => uBus2IP_Data,
      Bus2IP_BE                      => uBus2IP_BE,
      Bus2IP_RdCE                    => uBus2IP_RdCE,
      Bus2IP_WrCE                    => uBus2IP_WrCE,
      IP2Bus_Data                    => uIP2Bus_Data,
      IP2Bus_Ack                     => iIP2Bus_Ack,
      IP2Bus_Retry                   => iIP2Bus_Retry,
      IP2Bus_Error                   => iIP2Bus_Error,
      IP2Bus_ToutSup                 => iIP2Bus_ToutSup
    );

  ------------------------------------------
  -- hooking up signal slicing
  ------------------------------------------
  uBus2IP_BE <= iBus2IP_BE(0 to USER_DWIDTH/8-1);
  uBus2IP_Data <= iBus2IP_Data(0 to USER_DWIDTH-1);
  uBus2IP_RdCE <= iBus2IP_RdCE(USER00_CE_INDEX to USER00_CE_INDEX+USER_NUM_CE-1);
  uBus2IP_WrCE <= iBus2IP_WrCE(USER00_CE_INDEX to USER00_CE_INDEX+USER_NUM_CE-1);
  iIP2Bus_Data(0 to USER_DWIDTH-1) <= uIP2Bus_Data;

end IMP;
