library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity tx_ff_ctrl is
	port (
		tx_wr : in std_logic;
		tx_wdata  :in std_logic_vector(15 downto 0);
		tx_rdy :out std_logic ;
		tx_first  :in std_logic;
		tx_last :in std_logic ;
		tx_en :in std_logic ;
		
		tx_ff_wr  :out std_logic;
		tx_ff_full :in std_logic ;       
		tx_ff_wdata :out std_logic_vector(17 downto 0) ;
		tx_ff_almost_full : in std_logic;
		aur_lane_up :in std_logic 
		);
end tx_ff_ctrl;


architecture tx_ff_ctrl_b1 of tx_ff_ctrl is
begin
	
	tx_rdy <= (not tx_ff_almost_full) and aur_lane_up and tx_en;
	
	
	
	tx_ff_Wr <=  tx_wr and (not tx_ff_full) and aur_lane_up and tx_en;
	
	
	
	tx_ff_wdata <= tx_last&tx_first&tx_wdata;
	
end tx_ff_ctrl_b1;
