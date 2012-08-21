library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity reset_gen is
	port (
		
		reset_in : in std_logic;
		clk : in std_logic;
		reset_out : out std_logic
		
		);
end reset_gen;


architecture reset_gen_b1 of reset_gen is							   
	
	-- Internal signal
	signal         reset_cnt :std_logic_vector(3 downto 0) ;                  
	signal         reset_in_t0 :std_logic;
	signal         reset_in_t1 :std_logic;
begin
	
	-- Remove manta
	process(clk)
	begin
		if clk'event and clk='1' then
			reset_in_t1 <= reset_in_t0;
			reset_in_t0 <= reset_in;
		end if;
	end process;
	
	
	-- Simple Debouncer for Reset button, active high!
	process(clk)
	begin
		if clk'event and clk='1' then
			
			reset_cnt(3 downto 1) <= reset_cnt(2 downto 0);
			
			reset_cnt(0) <= reset_in_t1;
			
		end if;
	end process;
	
	
	
	
	reset_out  <= reset_cnt(0) and reset_cnt(1) and reset_cnt(2) ;
	
end reset_gen_b1;
