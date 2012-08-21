library IEEE;                          
use IEEE.std_logic_1164.all;                          
use work.conv_pkg.all;                          
                          
entity user_io_board_controller_opbw is                          
  generic (                          
    C_BASEADDR: std_logic_vector(0 to 31) := X"00000000";                          
    C_HIGHADDR: std_logic_vector(0 to 31) := X"0003FFFF";                          
    C_OPB_AWIDTH: integer := 32;                          
    C_OPB_DWIDTH: integer := 32                          
  );                          
  port (                          
    ce: in std_logic;                          
    opb_abus: in std_logic_vector(0 to 31);                          
    opb_be: in std_logic_vector(0 to 3);                          
    opb_clk: in std_logic;                          
    opb_dbus: in std_logic_vector(0 to 31);                          
    opb_rnw: in std_logic;                          
    opb_rst: in std_logic;                          
    opb_select: in std_logic;                          
    opb_seqaddr: in std_logic;                          
    reset: in std_logic;                          
    cs: out std_logic;                          
    resetlcd: out std_logic;                          
    scl: out std_logic;                          
    sdi: out std_logic;                          
    sgp_dbus: out std_logic_vector(0 to 31);                          
    sgp_errack: out std_logic;                          
    sgp_retry: out std_logic;                          
    sgp_toutsup: out std_logic;                          
    sgp_xferack: out std_logic                          
  );                          
end user_io_board_controller_opbw;                          
                          
architecture structural of user_io_board_controller_opbw is                          
  signal ce_x0: std_logic;                          
  signal clk: std_logic;                          
  signal cs_x0: std_logic;                          
  signal opb_abus_x0: std_logic_vector(31 downto 0);                          
  signal opb_be_x0: std_logic_vector(3 downto 0);                          
  signal opb_dbus_x0: std_logic_vector(31 downto 0);                          
  signal opb_rnw_x0: std_logic;                          
  signal opb_rst_x0: std_logic;                          
  signal opb_select_x0: std_logic;                          
  signal opb_seqaddr_x0: std_logic;                          
  signal reset_x0: std_logic;                          
  signal resetlcd_x0: std_logic;                          
  signal scl_x0: std_logic;                          
  signal sdi_x0: std_logic;                          
  signal sgp_dbus_x0: std_logic_vector(31 downto 0);                          
  signal sgp_errack_x0: std_logic;                          
  signal sgp_retry_x0: std_logic;                          
  signal sgp_toutsup_x0: std_logic;                          
  signal sgp_xferack_x0: std_logic;                          
                          
begin                          
  ce_x0 <= ce;                          
  opb_abus_x0 <= opb_abus xor C_BASEADDR;
  opb_be_x0 <= opb_be;                          
  clk <= opb_clk;                          
  opb_dbus_x0 <= opb_dbus;                          
  opb_rnw_x0 <= opb_rnw;                          
  opb_rst_x0 <= opb_rst;                          
  opb_select_x0 <= opb_select;                          
  opb_seqaddr_x0 <= opb_seqaddr;                          
  reset_x0 <= reset;                          
  cs <= cs_x0;                          
  resetlcd <= resetlcd_x0;                          
  scl <= scl_x0;                          
  sdi <= sdi_x0;                          
  sgp_dbus <= sgp_dbus_x0;                          
  sgp_errack <= sgp_errack_x0;                          
  sgp_retry <= sgp_retry_x0;                          
  sgp_toutsup <= sgp_toutsup_x0;                          
  sgp_xferack <= sgp_xferack_x0;                          
                          
  sysgen_dut: entity work.user_io_board_controller_cw                          
    port map (                          
      ce => ce_x0,                          
      clk => clk,                          
      opb_abus => opb_abus_x0,                          
      opb_be => opb_be_x0,                          
      opb_dbus => opb_dbus_x0,                          
      opb_rnw => opb_rnw_x0,                          
      opb_rst => opb_rst_x0,                          
      opb_select => opb_select_x0,                          
      opb_seqaddr => opb_seqaddr_x0,                          
      reset => reset_x0,                          
      cs => cs_x0,                          
      resetlcd => resetlcd_x0,                          
      scl => scl_x0,                          
      sdi => sdi_x0,                          
      sgp_dbus => sgp_dbus_x0,                          
      sgp_errack => sgp_errack_x0,                          
      sgp_retry => sgp_retry_x0,                          
      sgp_toutsup => sgp_toutsup_x0,                          
      sgp_xferack => sgp_xferack_x0                          
    );                          
                          
end structural;                          
