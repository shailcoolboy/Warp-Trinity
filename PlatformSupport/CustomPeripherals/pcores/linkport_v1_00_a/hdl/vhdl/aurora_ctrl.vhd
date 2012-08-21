library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity aurora_ctrl is
	port (					 
		pwdn_in : in std_logic ;
		user_clk : in std_logic ;
		dcm_not_locked  : out std_logic;
		loopback : out std_logic_vector(1 downto 0);
		power_down : out std_logic;
		nfc_req_1 : out std_logic ;
		nfc_nb  : out std_logic_vector(3 downto 0)
		);
end aurora_ctrl;


architecture aurora_ctrl_b1 of aurora_ctrl is			  
	signal     pwdn_reg : std_logic_vector(1 downto 0);
begin
	
	dcm_not_locked <= '0';
	
	loopback <= "00";
	
	process(user_clk)	
	begin
		if user_clk = '1' and user_clk'event then
			pwdn_reg <= pwdn_reg(0)&pwdn_in;
		end if;
	end process;
	
	
	--	power_down <= pwdn_reg(1);
	power_down <= '0';
	
	-- Native Flow Control Interface
	nfc_req_1 <= '1';
	nfc_nb <= "0000";
	
end aurora_ctrl_b1;
