library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity aurora_tx_ctrl is
	port (					 
		tx_ff_empty: in std_logic;
		tx_ff_rd :out std_logic;
		tx_ff_rdata : in std_logic_vector(17 downto 0);
		
		aur_tx_sof_1 : out std_logic;
		aur_tx_eof_1: out std_logic ;
		aur_tx_data : out std_logic_vector(15 downto 0);
		aur_tx_rem: out std_logic ;
		aur_tx_src_rdy_1: out std_logic ;
		aur_tx_dst_rdy_1: in std_logic 
		
		);
end aurora_tx_ctrl;


architecture aurora_tx_ctrl_b1 of aurora_tx_ctrl is			  
	signal       flag :std_logic_vector(1 downto 0);		  
	signal tx_ff_rd_1: std_logic;
begin
	
	
	tx_ff_rd_1 <= (not tx_ff_empty)  and  (not aur_tx_dst_rdy_1) ;
	aur_tx_rem <= '1' ;
	
	flag <= tx_ff_rdata(17 downto 16) ;
	aur_tx_data <= tx_ff_rdata (15 downto 0) ;
	aur_tx_sof_1 <= not (flag(0)  and  tx_ff_rd_1) ;
	aur_tx_eof_1 <= not (flag(1)  and  tx_ff_rd_1) ;
	aur_tx_src_rdy_1 <= not tx_ff_rd_1 ;
	
	tx_ff_rd <=tx_ff_rd_1;
end aurora_tx_ctrl_b1;
