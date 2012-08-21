---------------------------------------------------------------------------------------------------
--
-- Title       : difclk
-- Design      : flow4
-- Author      : jiang hai
-- Company     : Nokia
--
---------------------------------------------------------------------------------------------------
--
-- File        : difclk.vhd
-- Generated   : Mon Jul 31 10:34:43 2006
--
---------------------------------------------------------------------------------------------------
--
-- Description : 
--
---------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;									 

Library XilinxCoreLib;
use XilinxCoreLib.all;

library unisim ;
use unisim.vcomponents.all ;



entity difclk is
	port(
		top_ref_clk_p : in STD_LOGIC;
		top_ref_clk_n : in STD_LOGIC;
		user_clk_i : out STD_LOGIC;
		top_ref_clk_i : out STD_LOGIC
		);
end difclk;

--}} End of automatically maintained section

architecture difclk of difclk is	   

signal 		top_ref_clk_i_1: std_logic;
begin
	
	-- Differential Clock Buffers for top clock input
	diff_clk_buff_top : IBUFGDS_LVDS_25 
	port map(
		I  =>top_ref_clk_p  ,  --IN
		IB =>top_ref_clk_n  ,  --IN
		O  =>top_ref_clk_i_1     --OUT
		);
	--	
	-- Bufg used to drive user clk on global clock net
	user_clock_bufg:BUFG
	port map(
		I  =>top_ref_clk_i_1  ,  --IN
		O  =>user_clk_i    --OUT
		);							 
		
		top_ref_clk_i <= top_ref_clk_i_1;
	
end difclk;
