library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity rx_ff_ctrl is
	port (
		
		rx_en : in std_logic;
		aur_rx_src_rdy_1  : in std_logic;
		aur_rx_data  :in std_logic_vector(15 downto 0);
		aur_rx_sof_1 :in std_logic;
		aur_rx_eof_1:in std_logic;
		rx_ff_wr  :out std_logic;
		rx_ff_wdata :out std_logic_vector(17 downto 0);
		
		rx_ff_empty :in std_logic; 
		rx_ff_rdata :in std_logic_vector(17 downto 0); 
		rx_drdy :out std_logic;     
		rx_first  :out std_logic;
		rx_last  :out std_logic;    
		rx_data : out std_logic_vector(15 downto 0);     
		rx_ff_rd :out std_logic
		);
end rx_ff_ctrl;


architecture rx_ff_ctrl_b1 of rx_ff_ctrl is
	signal rx_drdy_2: std_logic;							  
	signal rx_ff_rd_2:std_logic;
	
begin
	
	rx_drdy  <= 	rx_drdy_2;
	
	rx_ff_wr <= (not aur_rx_src_rdy_1) and rx_en;
	
	rx_ff_wdata <= (not aur_rx_eof_1)&(not aur_rx_sof_1)&aur_rx_data;
	
	rx_ff_rd_2 <= (not rx_ff_empty) and rx_en;
	
	rx_data <= rx_ff_rdata(15 downto 0);			   
	
	
	rx_first <= rx_ff_rdata(16) and  rx_drdy_2;
	
	rx_last <= rx_ff_rdata(17) and  rx_drdy_2;
	
	rx_drdy_2 <= rx_ff_rd_2;
	
	rx_ff_rd <= rx_ff_rd_2;
	
end rx_ff_ctrl_b1;

