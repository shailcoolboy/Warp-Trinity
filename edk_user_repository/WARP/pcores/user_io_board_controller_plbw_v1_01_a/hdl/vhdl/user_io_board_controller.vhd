--------------------------------------------------------------------------------
--     This file is owned and controlled by Xilinx and must be used           --
--     solely for design, simulation, implementation and creation of          --
--     design files limited to Xilinx devices or technologies. Use            --
--     with non-Xilinx devices or technologies is expressly prohibited        --
--     and immediately terminates your license.                               --
--                                                                            --
--     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"          --
--     SOLELY FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR                --
--     XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION        --
--     AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE, APPLICATION            --
--     OR STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS              --
--     IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,                --
--     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE       --
--     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY               --
--     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE                --
--     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR         --
--     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF        --
--     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS        --
--     FOR A PARTICULAR PURPOSE.                                              --
--                                                                            --
--     Xilinx products are not intended for use in life support               --
--     appliances, devices, or systems. Use in such applications are          --
--     expressly prohibited.                                                  --
--                                                                            --
--     (c) Copyright 1995-2007 Xilinx, Inc.                                   --
--     All rights reserved.                                                   --
--------------------------------------------------------------------------------
-- You must compile the wrapper file adder_subtracter_virtex2p_7_0_453ed16ba8e84295.vhd when simulating
-- the core, adder_subtracter_virtex2p_7_0_453ed16ba8e84295. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synthesis directives "translate_off/translate_on" specified
-- below are supported by Xilinx, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synthesis translate_off
Library XilinxCoreLib;
-- synthesis translate_on
ENTITY adder_subtracter_virtex2p_7_0_453ed16ba8e84295 IS
	port (
	A: IN std_logic_VECTOR(8 downto 0);
	B: IN std_logic_VECTOR(8 downto 0);
	S: OUT std_logic_VECTOR(8 downto 0));
END adder_subtracter_virtex2p_7_0_453ed16ba8e84295;

ARCHITECTURE adder_subtracter_virtex2p_7_0_453ed16ba8e84295_a OF adder_subtracter_virtex2p_7_0_453ed16ba8e84295 IS
-- synthesis translate_off
component wrapped_adder_subtracter_virtex2p_7_0_453ed16ba8e84295
	port (
	A: IN std_logic_VECTOR(8 downto 0);
	B: IN std_logic_VECTOR(8 downto 0);
	S: OUT std_logic_VECTOR(8 downto 0));
end component;

-- Configuration specification 
	for all : wrapped_adder_subtracter_virtex2p_7_0_453ed16ba8e84295 use entity XilinxCoreLib.C_ADDSUB_V7_0(behavioral)
		generic map(
			c_has_bypass_with_cin => 0,
			c_a_type => 1,
			c_has_sclr => 0,
			c_sync_priority => 1,
			c_has_aset => 0,
			c_has_b_out => 0,
			c_has_s => 1,
			c_has_q => 0,
			c_bypass_enable => 0,
			c_b_constant => 0,
			c_has_ovfl => 0,
			c_high_bit => 8,
			c_latency => 0,
			c_sinit_val => "0",
			c_has_bypass => 0,
			c_pipe_stages => 1,
			c_has_sset => 0,
			c_has_ainit => 0,
			c_has_a_signed => 0,
			c_has_q_c_out => 0,
			c_b_type => 1,
			c_has_add => 0,
			c_has_sinit => 0,
			c_has_b_in => 0,
			c_has_b_signed => 0,
			c_bypass_low => 0,
			c_enable_rlocs => 1,
			c_b_value => "0",
			c_add_mode => 0,
			c_has_aclr => 0,
			c_out_width => 9,
			c_ainit_val => "0000",
			c_low_bit => 0,
			c_has_q_ovfl => 0,
			c_has_q_b_out => 0,
			c_has_c_out => 0,
			c_b_width => 9,
			c_a_width => 9,
			c_sync_enable => 0,
			c_has_ce => 1,
			c_has_c_in => 0);
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_adder_subtracter_virtex2p_7_0_453ed16ba8e84295
		port map (
			A => A,
			B => B,
			S => S);
-- synthesis translate_on

END adder_subtracter_virtex2p_7_0_453ed16ba8e84295_a;

--------------------------------------------------------------------------------
--     This file is owned and controlled by Xilinx and must be used           --
--     solely for design, simulation, implementation and creation of          --
--     design files limited to Xilinx devices or technologies. Use            --
--     with non-Xilinx devices or technologies is expressly prohibited        --
--     and immediately terminates your license.                               --
--                                                                            --
--     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"          --
--     SOLELY FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR                --
--     XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION        --
--     AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE, APPLICATION            --
--     OR STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS              --
--     IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,                --
--     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE       --
--     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY               --
--     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE                --
--     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR         --
--     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF        --
--     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS        --
--     FOR A PARTICULAR PURPOSE.                                              --
--                                                                            --
--     Xilinx products are not intended for use in life support               --
--     appliances, devices, or systems. Use in such applications are          --
--     expressly prohibited.                                                  --
--                                                                            --
--     (c) Copyright 1995-2007 Xilinx, Inc.                                   --
--     All rights reserved.                                                   --
--------------------------------------------------------------------------------
-- You must compile the wrapper file adder_subtracter_virtex2p_7_0_7182743c9e7adf5e.vhd when simulating
-- the core, adder_subtracter_virtex2p_7_0_7182743c9e7adf5e. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synthesis directives "translate_off/translate_on" specified
-- below are supported by Xilinx, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synthesis translate_off
Library XilinxCoreLib;
-- synthesis translate_on
ENTITY adder_subtracter_virtex2p_7_0_7182743c9e7adf5e IS
	port (
	A: IN std_logic_VECTOR(4 downto 0);
	B: IN std_logic_VECTOR(4 downto 0);
	S: OUT std_logic_VECTOR(4 downto 0));
END adder_subtracter_virtex2p_7_0_7182743c9e7adf5e;

ARCHITECTURE adder_subtracter_virtex2p_7_0_7182743c9e7adf5e_a OF adder_subtracter_virtex2p_7_0_7182743c9e7adf5e IS
-- synthesis translate_off
component wrapped_adder_subtracter_virtex2p_7_0_7182743c9e7adf5e
	port (
	A: IN std_logic_VECTOR(4 downto 0);
	B: IN std_logic_VECTOR(4 downto 0);
	S: OUT std_logic_VECTOR(4 downto 0));
end component;

-- Configuration specification 
	for all : wrapped_adder_subtracter_virtex2p_7_0_7182743c9e7adf5e use entity XilinxCoreLib.C_ADDSUB_V7_0(behavioral)
		generic map(
			c_has_bypass_with_cin => 0,
			c_a_type => 1,
			c_has_sclr => 0,
			c_sync_priority => 1,
			c_has_aset => 0,
			c_has_b_out => 0,
			c_has_s => 1,
			c_has_q => 0,
			c_bypass_enable => 0,
			c_b_constant => 0,
			c_has_ovfl => 0,
			c_high_bit => 4,
			c_latency => 0,
			c_sinit_val => "0",
			c_has_bypass => 0,
			c_pipe_stages => 1,
			c_has_sset => 0,
			c_has_ainit => 0,
			c_has_a_signed => 0,
			c_has_q_c_out => 0,
			c_b_type => 1,
			c_has_add => 0,
			c_has_sinit => 0,
			c_has_b_in => 0,
			c_has_b_signed => 0,
			c_bypass_low => 0,
			c_enable_rlocs => 1,
			c_b_value => "0",
			c_add_mode => 0,
			c_has_aclr => 0,
			c_out_width => 5,
			c_ainit_val => "0000",
			c_low_bit => 0,
			c_has_q_ovfl => 0,
			c_has_q_b_out => 0,
			c_has_c_out => 0,
			c_b_width => 5,
			c_a_width => 5,
			c_sync_enable => 0,
			c_has_ce => 1,
			c_has_c_in => 0);
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_adder_subtracter_virtex2p_7_0_7182743c9e7adf5e
		port map (
			A => A,
			B => B,
			S => S);
-- synthesis translate_on

END adder_subtracter_virtex2p_7_0_7182743c9e7adf5e_a;

--------------------------------------------------------------------------------
--     This file is owned and controlled by Xilinx and must be used           --
--     solely for design, simulation, implementation and creation of          --
--     design files limited to Xilinx devices or technologies. Use            --
--     with non-Xilinx devices or technologies is expressly prohibited        --
--     and immediately terminates your license.                               --
--                                                                            --
--     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"          --
--     SOLELY FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR                --
--     XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION        --
--     AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE, APPLICATION            --
--     OR STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS              --
--     IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,                --
--     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE       --
--     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY               --
--     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE                --
--     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR         --
--     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF        --
--     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS        --
--     FOR A PARTICULAR PURPOSE.                                              --
--                                                                            --
--     Xilinx products are not intended for use in life support               --
--     appliances, devices, or systems. Use in such applications are          --
--     expressly prohibited.                                                  --
--                                                                            --
--     (c) Copyright 1995-2007 Xilinx, Inc.                                   --
--     All rights reserved.                                                   --
--------------------------------------------------------------------------------
-- You must compile the wrapper file adder_subtracter_virtex2p_7_0_cf28bbebd75d9ce3.vhd when simulating
-- the core, adder_subtracter_virtex2p_7_0_cf28bbebd75d9ce3. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synthesis directives "translate_off/translate_on" specified
-- below are supported by Xilinx, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synthesis translate_off
Library XilinxCoreLib;
-- synthesis translate_on
ENTITY adder_subtracter_virtex2p_7_0_cf28bbebd75d9ce3 IS
	port (
	A: IN std_logic_VECTOR(8 downto 0);
	B: IN std_logic_VECTOR(8 downto 0);
	S: OUT std_logic_VECTOR(8 downto 0));
END adder_subtracter_virtex2p_7_0_cf28bbebd75d9ce3;

ARCHITECTURE adder_subtracter_virtex2p_7_0_cf28bbebd75d9ce3_a OF adder_subtracter_virtex2p_7_0_cf28bbebd75d9ce3 IS
-- synthesis translate_off
component wrapped_adder_subtracter_virtex2p_7_0_cf28bbebd75d9ce3
	port (
	A: IN std_logic_VECTOR(8 downto 0);
	B: IN std_logic_VECTOR(8 downto 0);
	S: OUT std_logic_VECTOR(8 downto 0));
end component;

-- Configuration specification 
	for all : wrapped_adder_subtracter_virtex2p_7_0_cf28bbebd75d9ce3 use entity XilinxCoreLib.C_ADDSUB_V7_0(behavioral)
		generic map(
			c_has_bypass_with_cin => 0,
			c_a_type => 0,
			c_has_sclr => 0,
			c_sync_priority => 1,
			c_has_aset => 0,
			c_has_b_out => 0,
			c_has_s => 1,
			c_has_q => 0,
			c_bypass_enable => 0,
			c_b_constant => 0,
			c_has_ovfl => 0,
			c_high_bit => 8,
			c_latency => 0,
			c_sinit_val => "0",
			c_has_bypass => 0,
			c_pipe_stages => 1,
			c_has_sset => 0,
			c_has_ainit => 0,
			c_has_a_signed => 0,
			c_has_q_c_out => 0,
			c_b_type => 0,
			c_has_add => 0,
			c_has_sinit => 0,
			c_has_b_in => 0,
			c_has_b_signed => 0,
			c_bypass_low => 0,
			c_enable_rlocs => 1,
			c_b_value => "0",
			c_add_mode => 1,
			c_has_aclr => 0,
			c_out_width => 9,
			c_ainit_val => "0000",
			c_low_bit => 0,
			c_has_q_ovfl => 0,
			c_has_q_b_out => 0,
			c_has_c_out => 0,
			c_b_width => 9,
			c_a_width => 9,
			c_sync_enable => 0,
			c_has_ce => 1,
			c_has_c_in => 0);
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_adder_subtracter_virtex2p_7_0_cf28bbebd75d9ce3
		port map (
			A => A,
			B => B,
			S => S);
-- synthesis translate_on

END adder_subtracter_virtex2p_7_0_cf28bbebd75d9ce3_a;

--------------------------------------------------------------------------------
--     This file is owned and controlled by Xilinx and must be used           --
--     solely for design, simulation, implementation and creation of          --
--     design files limited to Xilinx devices or technologies. Use            --
--     with non-Xilinx devices or technologies is expressly prohibited        --
--     and immediately terminates your license.                               --
--                                                                            --
--     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"          --
--     SOLELY FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR                --
--     XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION        --
--     AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE, APPLICATION            --
--     OR STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS              --
--     IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,                --
--     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE       --
--     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY               --
--     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE                --
--     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR         --
--     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF        --
--     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS        --
--     FOR A PARTICULAR PURPOSE.                                              --
--                                                                            --
--     Xilinx products are not intended for use in life support               --
--     appliances, devices, or systems. Use in such applications are          --
--     expressly prohibited.                                                  --
--                                                                            --
--     (c) Copyright 1995-2007 Xilinx, Inc.                                   --
--     All rights reserved.                                                   --
--------------------------------------------------------------------------------
-- You must compile the wrapper file binary_counter_virtex2p_7_0_23542cbcca0efa2e.vhd when simulating
-- the core, binary_counter_virtex2p_7_0_23542cbcca0efa2e. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synthesis directives "translate_off/translate_on" specified
-- below are supported by Xilinx, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synthesis translate_off
Library XilinxCoreLib;
-- synthesis translate_on
ENTITY binary_counter_virtex2p_7_0_23542cbcca0efa2e IS
	port (
	Q: OUT std_logic_VECTOR(3 downto 0);
	CLK: IN std_logic;
	CE: IN std_logic;
	SINIT: IN std_logic);
END binary_counter_virtex2p_7_0_23542cbcca0efa2e;

ARCHITECTURE binary_counter_virtex2p_7_0_23542cbcca0efa2e_a OF binary_counter_virtex2p_7_0_23542cbcca0efa2e IS
-- synthesis translate_off
component wrapped_binary_counter_virtex2p_7_0_23542cbcca0efa2e
	port (
	Q: OUT std_logic_VECTOR(3 downto 0);
	CLK: IN std_logic;
	CE: IN std_logic;
	SINIT: IN std_logic);
end component;

-- Configuration specification 
	for all : wrapped_binary_counter_virtex2p_7_0_23542cbcca0efa2e use entity XilinxCoreLib.C_COUNTER_BINARY_V7_0(behavioral)
		generic map(
			c_count_mode => 0,
			c_load_enable => 1,
			c_has_aset => 0,
			c_load_low => 0,
			c_count_to => "1111111111111111",
			c_sync_priority => 1,
			c_has_iv => 0,
			c_restrict_count => 0,
			c_has_sclr => 0,
			c_width => 4,
			c_has_q_thresh1 => 0,
			c_enable_rlocs => 0,
			c_has_q_thresh0 => 0,
			c_thresh1_value => "1111111111111111",
			c_has_load => 0,
			c_thresh_early => 1,
			c_has_up => 0,
			c_has_thresh1 => 0,
			c_has_thresh0 => 0,
			c_ainit_val => "0000",
			c_has_ce => 1,
			c_pipe_stages => 0,
			c_has_aclr => 0,
			c_sync_enable => 0,
			c_has_ainit => 0,
			c_sinit_val => "0000",
			c_has_sset => 0,
			c_has_sinit => 1,
			c_count_by => "0001",
			c_has_l => 0,
			c_thresh0_value => "1111111111111111");
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_binary_counter_virtex2p_7_0_23542cbcca0efa2e
		port map (
			Q => Q,
			CLK => CLK,
			CE => CE,
			SINIT => SINIT);
-- synthesis translate_on

END binary_counter_virtex2p_7_0_23542cbcca0efa2e_a;

--------------------------------------------------------------------------------
--     This file is owned and controlled by Xilinx and must be used           --
--     solely for design, simulation, implementation and creation of          --
--     design files limited to Xilinx devices or technologies. Use            --
--     with non-Xilinx devices or technologies is expressly prohibited        --
--     and immediately terminates your license.                               --
--                                                                            --
--     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"          --
--     SOLELY FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR                --
--     XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION        --
--     AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE, APPLICATION            --
--     OR STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS              --
--     IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,                --
--     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE       --
--     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY               --
--     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE                --
--     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR         --
--     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF        --
--     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS        --
--     FOR A PARTICULAR PURPOSE.                                              --
--                                                                            --
--     Xilinx products are not intended for use in life support               --
--     appliances, devices, or systems. Use in such applications are          --
--     expressly prohibited.                                                  --
--                                                                            --
--     (c) Copyright 1995-2007 Xilinx, Inc.                                   --
--     All rights reserved.                                                   --
--------------------------------------------------------------------------------
-- You must compile the wrapper file binary_counter_virtex2p_7_0_32a1863440903b9d.vhd when simulating
-- the core, binary_counter_virtex2p_7_0_32a1863440903b9d. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synthesis directives "translate_off/translate_on" specified
-- below are supported by Xilinx, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synthesis translate_off
Library XilinxCoreLib;
-- synthesis translate_on
ENTITY binary_counter_virtex2p_7_0_32a1863440903b9d IS
	port (
	Q: OUT std_logic_VECTOR(14 downto 0);
	CLK: IN std_logic;
	CE: IN std_logic;
	SINIT: IN std_logic);
END binary_counter_virtex2p_7_0_32a1863440903b9d;

ARCHITECTURE binary_counter_virtex2p_7_0_32a1863440903b9d_a OF binary_counter_virtex2p_7_0_32a1863440903b9d IS
-- synthesis translate_off
component wrapped_binary_counter_virtex2p_7_0_32a1863440903b9d
	port (
	Q: OUT std_logic_VECTOR(14 downto 0);
	CLK: IN std_logic;
	CE: IN std_logic;
	SINIT: IN std_logic);
end component;

-- Configuration specification 
	for all : wrapped_binary_counter_virtex2p_7_0_32a1863440903b9d use entity XilinxCoreLib.C_COUNTER_BINARY_V7_0(behavioral)
		generic map(
			c_count_mode => 0,
			c_load_enable => 1,
			c_has_aset => 0,
			c_load_low => 0,
			c_count_to => "1111111111111111",
			c_sync_priority => 1,
			c_has_iv => 0,
			c_restrict_count => 0,
			c_has_sclr => 0,
			c_width => 15,
			c_has_q_thresh1 => 0,
			c_enable_rlocs => 0,
			c_has_q_thresh0 => 0,
			c_thresh1_value => "1111111111111111",
			c_has_load => 0,
			c_thresh_early => 1,
			c_has_up => 0,
			c_has_thresh1 => 0,
			c_has_thresh0 => 0,
			c_ainit_val => "0000",
			c_has_ce => 1,
			c_pipe_stages => 0,
			c_has_aclr => 0,
			c_sync_enable => 0,
			c_has_ainit => 0,
			c_sinit_val => "0000",
			c_has_sset => 0,
			c_has_sinit => 1,
			c_count_by => "0001",
			c_has_l => 0,
			c_thresh0_value => "1111111111111111");
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_binary_counter_virtex2p_7_0_32a1863440903b9d
		port map (
			Q => Q,
			CLK => CLK,
			CE => CE,
			SINIT => SINIT);
-- synthesis translate_on

END binary_counter_virtex2p_7_0_32a1863440903b9d_a;

--------------------------------------------------------------------------------
--     This file is owned and controlled by Xilinx and must be used           --
--     solely for design, simulation, implementation and creation of          --
--     design files limited to Xilinx devices or technologies. Use            --
--     with non-Xilinx devices or technologies is expressly prohibited        --
--     and immediately terminates your license.                               --
--                                                                            --
--     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"          --
--     SOLELY FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR                --
--     XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION        --
--     AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE, APPLICATION            --
--     OR STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS              --
--     IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,                --
--     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE       --
--     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY               --
--     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE                --
--     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR         --
--     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF        --
--     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS        --
--     FOR A PARTICULAR PURPOSE.                                              --
--                                                                            --
--     Xilinx products are not intended for use in life support               --
--     appliances, devices, or systems. Use in such applications are          --
--     expressly prohibited.                                                  --
--                                                                            --
--     (c) Copyright 1995-2007 Xilinx, Inc.                                   --
--     All rights reserved.                                                   --
--------------------------------------------------------------------------------
-- You must compile the wrapper file binary_counter_virtex2p_7_0_77cea312f82499f0.vhd when simulating
-- the core, binary_counter_virtex2p_7_0_77cea312f82499f0. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synthesis directives "translate_off/translate_on" specified
-- below are supported by Xilinx, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synthesis translate_off
Library XilinxCoreLib;
-- synthesis translate_on
ENTITY binary_counter_virtex2p_7_0_77cea312f82499f0 IS
	port (
	Q: OUT std_logic_VECTOR(3 downto 0);
	CLK: IN std_logic;
	LOAD: IN std_logic;
	L: IN std_logic_VECTOR(3 downto 0);
	CE: IN std_logic;
	SINIT: IN std_logic);
END binary_counter_virtex2p_7_0_77cea312f82499f0;

ARCHITECTURE binary_counter_virtex2p_7_0_77cea312f82499f0_a OF binary_counter_virtex2p_7_0_77cea312f82499f0 IS
-- synthesis translate_off
component wrapped_binary_counter_virtex2p_7_0_77cea312f82499f0
	port (
	Q: OUT std_logic_VECTOR(3 downto 0);
	CLK: IN std_logic;
	LOAD: IN std_logic;
	L: IN std_logic_VECTOR(3 downto 0);
	CE: IN std_logic;
	SINIT: IN std_logic);
end component;

-- Configuration specification 
	for all : wrapped_binary_counter_virtex2p_7_0_77cea312f82499f0 use entity XilinxCoreLib.C_COUNTER_BINARY_V7_0(behavioral)
		generic map(
			c_count_mode => 0,
			c_load_enable => 1,
			c_has_aset => 0,
			c_load_low => 0,
			c_count_to => "1111111111111111",
			c_sync_priority => 1,
			c_has_iv => 0,
			c_restrict_count => 0,
			c_has_sclr => 0,
			c_width => 4,
			c_has_q_thresh1 => 0,
			c_enable_rlocs => 0,
			c_has_q_thresh0 => 0,
			c_thresh1_value => "1111111111111111",
			c_has_load => 1,
			c_thresh_early => 1,
			c_has_up => 0,
			c_has_thresh1 => 0,
			c_has_thresh0 => 0,
			c_ainit_val => "1111",
			c_has_ce => 1,
			c_pipe_stages => 0,
			c_has_aclr => 0,
			c_sync_enable => 0,
			c_has_ainit => 0,
			c_sinit_val => "1111",
			c_has_sset => 0,
			c_has_sinit => 1,
			c_count_by => "0001",
			c_has_l => 1,
			c_thresh0_value => "1111111111111111");
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_binary_counter_virtex2p_7_0_77cea312f82499f0
		port map (
			Q => Q,
			CLK => CLK,
			LOAD => LOAD,
			L => L,
			CE => CE,
			SINIT => SINIT);
-- synthesis translate_on

END binary_counter_virtex2p_7_0_77cea312f82499f0_a;

--------------------------------------------------------------------------------
--     This file is owned and controlled by Xilinx and must be used           --
--     solely for design, simulation, implementation and creation of          --
--     design files limited to Xilinx devices or technologies. Use            --
--     with non-Xilinx devices or technologies is expressly prohibited        --
--     and immediately terminates your license.                               --
--                                                                            --
--     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"          --
--     SOLELY FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR                --
--     XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION        --
--     AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE, APPLICATION            --
--     OR STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS              --
--     IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,                --
--     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE       --
--     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY               --
--     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE                --
--     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR         --
--     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF        --
--     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS        --
--     FOR A PARTICULAR PURPOSE.                                              --
--                                                                            --
--     Xilinx products are not intended for use in life support               --
--     appliances, devices, or systems. Use in such applications are          --
--     expressly prohibited.                                                  --
--                                                                            --
--     (c) Copyright 1995-2007 Xilinx, Inc.                                   --
--     All rights reserved.                                                   --
--------------------------------------------------------------------------------
-- You must compile the wrapper file binary_counter_virtex2p_7_0_950e4ab582797264.vhd when simulating
-- the core, binary_counter_virtex2p_7_0_950e4ab582797264. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synthesis directives "translate_off/translate_on" specified
-- below are supported by Xilinx, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synthesis translate_off
Library XilinxCoreLib;
-- synthesis translate_on
ENTITY binary_counter_virtex2p_7_0_950e4ab582797264 IS
	port (
	Q: OUT std_logic_VECTOR(17 downto 0);
	CLK: IN std_logic;
	CE: IN std_logic;
	SINIT: IN std_logic);
END binary_counter_virtex2p_7_0_950e4ab582797264;

ARCHITECTURE binary_counter_virtex2p_7_0_950e4ab582797264_a OF binary_counter_virtex2p_7_0_950e4ab582797264 IS
-- synthesis translate_off
component wrapped_binary_counter_virtex2p_7_0_950e4ab582797264
	port (
	Q: OUT std_logic_VECTOR(17 downto 0);
	CLK: IN std_logic;
	CE: IN std_logic;
	SINIT: IN std_logic);
end component;

-- Configuration specification 
	for all : wrapped_binary_counter_virtex2p_7_0_950e4ab582797264 use entity XilinxCoreLib.C_COUNTER_BINARY_V7_0(behavioral)
		generic map(
			c_count_mode => 0,
			c_load_enable => 1,
			c_has_aset => 0,
			c_load_low => 0,
			c_count_to => "1111111111111111",
			c_sync_priority => 1,
			c_has_iv => 0,
			c_restrict_count => 0,
			c_has_sclr => 0,
			c_width => 18,
			c_has_q_thresh1 => 0,
			c_enable_rlocs => 0,
			c_has_q_thresh0 => 0,
			c_thresh1_value => "1111111111111111",
			c_has_load => 0,
			c_thresh_early => 1,
			c_has_up => 0,
			c_has_thresh1 => 0,
			c_has_thresh0 => 0,
			c_ainit_val => "0000",
			c_has_ce => 1,
			c_pipe_stages => 0,
			c_has_aclr => 0,
			c_sync_enable => 0,
			c_has_ainit => 0,
			c_sinit_val => "0000",
			c_has_sset => 0,
			c_has_sinit => 1,
			c_count_by => "0001",
			c_has_l => 0,
			c_thresh0_value => "1111111111111111");
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_binary_counter_virtex2p_7_0_950e4ab582797264
		port map (
			Q => Q,
			CLK => CLK,
			CE => CE,
			SINIT => SINIT);
-- synthesis translate_on

END binary_counter_virtex2p_7_0_950e4ab582797264_a;

--------------------------------------------------------------------------------
--     This file is owned and controlled by Xilinx and must be used           --
--     solely for design, simulation, implementation and creation of          --
--     design files limited to Xilinx devices or technologies. Use            --
--     with non-Xilinx devices or technologies is expressly prohibited        --
--     and immediately terminates your license.                               --
--                                                                            --
--     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"          --
--     SOLELY FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR                --
--     XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION        --
--     AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE, APPLICATION            --
--     OR STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS              --
--     IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,                --
--     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE       --
--     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY               --
--     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE                --
--     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR         --
--     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF        --
--     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS        --
--     FOR A PARTICULAR PURPOSE.                                              --
--                                                                            --
--     Xilinx products are not intended for use in life support               --
--     appliances, devices, or systems. Use in such applications are          --
--     expressly prohibited.                                                  --
--                                                                            --
--     (c) Copyright 1995-2007 Xilinx, Inc.                                   --
--     All rights reserved.                                                   --
--------------------------------------------------------------------------------
-- You must compile the wrapper file binary_counter_virtex2p_7_0_a22528b4c55dc1cd.vhd when simulating
-- the core, binary_counter_virtex2p_7_0_a22528b4c55dc1cd. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synthesis directives "translate_off/translate_on" specified
-- below are supported by Xilinx, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synthesis translate_off
Library XilinxCoreLib;
-- synthesis translate_on
ENTITY binary_counter_virtex2p_7_0_a22528b4c55dc1cd IS
	port (
	Q: OUT std_logic_VECTOR(13 downto 0);
	CLK: IN std_logic;
	CE: IN std_logic;
	SINIT: IN std_logic);
END binary_counter_virtex2p_7_0_a22528b4c55dc1cd;

ARCHITECTURE binary_counter_virtex2p_7_0_a22528b4c55dc1cd_a OF binary_counter_virtex2p_7_0_a22528b4c55dc1cd IS
-- synthesis translate_off
component wrapped_binary_counter_virtex2p_7_0_a22528b4c55dc1cd
	port (
	Q: OUT std_logic_VECTOR(13 downto 0);
	CLK: IN std_logic;
	CE: IN std_logic;
	SINIT: IN std_logic);
end component;

-- Configuration specification 
	for all : wrapped_binary_counter_virtex2p_7_0_a22528b4c55dc1cd use entity XilinxCoreLib.C_COUNTER_BINARY_V7_0(behavioral)
		generic map(
			c_count_mode => 0,
			c_load_enable => 1,
			c_has_aset => 0,
			c_load_low => 0,
			c_count_to => "1111111111111111",
			c_sync_priority => 1,
			c_has_iv => 0,
			c_restrict_count => 0,
			c_has_sclr => 0,
			c_width => 14,
			c_has_q_thresh1 => 0,
			c_enable_rlocs => 0,
			c_has_q_thresh0 => 0,
			c_thresh1_value => "1111111111111111",
			c_has_load => 0,
			c_thresh_early => 1,
			c_has_up => 0,
			c_has_thresh1 => 0,
			c_has_thresh0 => 0,
			c_ainit_val => "11111111111111",
			c_has_ce => 1,
			c_pipe_stages => 0,
			c_has_aclr => 0,
			c_sync_enable => 0,
			c_has_ainit => 0,
			c_sinit_val => "11111111111111",
			c_has_sset => 0,
			c_has_sinit => 1,
			c_count_by => "0001",
			c_has_l => 0,
			c_thresh0_value => "1111111111111111");
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_binary_counter_virtex2p_7_0_a22528b4c55dc1cd
		port map (
			Q => Q,
			CLK => CLK,
			CE => CE,
			SINIT => SINIT);
-- synthesis translate_on

END binary_counter_virtex2p_7_0_a22528b4c55dc1cd_a;

--------------------------------------------------------------------------------
--     This file is owned and controlled by Xilinx and must be used           --
--     solely for design, simulation, implementation and creation of          --
--     design files limited to Xilinx devices or technologies. Use            --
--     with non-Xilinx devices or technologies is expressly prohibited        --
--     and immediately terminates your license.                               --
--                                                                            --
--     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"          --
--     SOLELY FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR                --
--     XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION        --
--     AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE, APPLICATION            --
--     OR STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS              --
--     IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,                --
--     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE       --
--     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY               --
--     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE                --
--     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR         --
--     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF        --
--     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS        --
--     FOR A PARTICULAR PURPOSE.                                              --
--                                                                            --
--     Xilinx products are not intended for use in life support               --
--     appliances, devices, or systems. Use in such applications are          --
--     expressly prohibited.                                                  --
--                                                                            --
--     (c) Copyright 1995-2007 Xilinx, Inc.                                   --
--     All rights reserved.                                                   --
--------------------------------------------------------------------------------
-- You must compile the wrapper file binary_counter_virtex2p_7_0_b0a257f5389d649a.vhd when simulating
-- the core, binary_counter_virtex2p_7_0_b0a257f5389d649a. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synthesis directives "translate_off/translate_on" specified
-- below are supported by Xilinx, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synthesis translate_off
Library XilinxCoreLib;
-- synthesis translate_on
ENTITY binary_counter_virtex2p_7_0_b0a257f5389d649a IS
	port (
	Q: OUT std_logic_VECTOR(6 downto 0);
	CLK: IN std_logic;
	CE: IN std_logic;
	SINIT: IN std_logic);
END binary_counter_virtex2p_7_0_b0a257f5389d649a;

ARCHITECTURE binary_counter_virtex2p_7_0_b0a257f5389d649a_a OF binary_counter_virtex2p_7_0_b0a257f5389d649a IS
-- synthesis translate_off
component wrapped_binary_counter_virtex2p_7_0_b0a257f5389d649a
	port (
	Q: OUT std_logic_VECTOR(6 downto 0);
	CLK: IN std_logic;
	CE: IN std_logic;
	SINIT: IN std_logic);
end component;

-- Configuration specification 
	for all : wrapped_binary_counter_virtex2p_7_0_b0a257f5389d649a use entity XilinxCoreLib.C_COUNTER_BINARY_V7_0(behavioral)
		generic map(
			c_count_mode => 0,
			c_load_enable => 1,
			c_has_aset => 0,
			c_load_low => 0,
			c_count_to => "1111111111111111",
			c_sync_priority => 1,
			c_has_iv => 0,
			c_restrict_count => 0,
			c_has_sclr => 0,
			c_width => 7,
			c_has_q_thresh1 => 0,
			c_enable_rlocs => 0,
			c_has_q_thresh0 => 0,
			c_thresh1_value => "1111111111111111",
			c_has_load => 0,
			c_thresh_early => 1,
			c_has_up => 0,
			c_has_thresh1 => 0,
			c_has_thresh0 => 0,
			c_ainit_val => "1111111",
			c_has_ce => 1,
			c_pipe_stages => 0,
			c_has_aclr => 0,
			c_sync_enable => 0,
			c_has_ainit => 0,
			c_sinit_val => "1111111",
			c_has_sset => 0,
			c_has_sinit => 1,
			c_count_by => "0001",
			c_has_l => 0,
			c_thresh0_value => "1111111111111111");
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_binary_counter_virtex2p_7_0_b0a257f5389d649a
		port map (
			Q => Q,
			CLK => CLK,
			CE => CE,
			SINIT => SINIT);
-- synthesis translate_on

END binary_counter_virtex2p_7_0_b0a257f5389d649a_a;

--------------------------------------------------------------------------------
--     This file is owned and controlled by Xilinx and must be used           --
--     solely for design, simulation, implementation and creation of          --
--     design files limited to Xilinx devices or technologies. Use            --
--     with non-Xilinx devices or technologies is expressly prohibited        --
--     and immediately terminates your license.                               --
--                                                                            --
--     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"          --
--     SOLELY FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR                --
--     XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION        --
--     AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE, APPLICATION            --
--     OR STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS              --
--     IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,                --
--     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE       --
--     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY               --
--     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE                --
--     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR         --
--     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF        --
--     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS        --
--     FOR A PARTICULAR PURPOSE.                                              --
--                                                                            --
--     Xilinx products are not intended for use in life support               --
--     appliances, devices, or systems. Use in such applications are          --
--     expressly prohibited.                                                  --
--                                                                            --
--     (c) Copyright 1995-2007 Xilinx, Inc.                                   --
--     All rights reserved.                                                   --
--------------------------------------------------------------------------------
-- You must compile the wrapper file binary_counter_virtex2p_7_0_b511f9871581ee23.vhd when simulating
-- the core, binary_counter_virtex2p_7_0_b511f9871581ee23. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synthesis directives "translate_off/translate_on" specified
-- below are supported by Xilinx, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synthesis translate_off
Library XilinxCoreLib;
-- synthesis translate_on
ENTITY binary_counter_virtex2p_7_0_b511f9871581ee23 IS
	port (
	Q: OUT std_logic_VECTOR(2 downto 0);
	CLK: IN std_logic;
	LOAD: IN std_logic;
	L: IN std_logic_VECTOR(2 downto 0);
	CE: IN std_logic;
	SINIT: IN std_logic);
END binary_counter_virtex2p_7_0_b511f9871581ee23;

ARCHITECTURE binary_counter_virtex2p_7_0_b511f9871581ee23_a OF binary_counter_virtex2p_7_0_b511f9871581ee23 IS
-- synthesis translate_off
component wrapped_binary_counter_virtex2p_7_0_b511f9871581ee23
	port (
	Q: OUT std_logic_VECTOR(2 downto 0);
	CLK: IN std_logic;
	LOAD: IN std_logic;
	L: IN std_logic_VECTOR(2 downto 0);
	CE: IN std_logic;
	SINIT: IN std_logic);
end component;

-- Configuration specification 
	for all : wrapped_binary_counter_virtex2p_7_0_b511f9871581ee23 use entity XilinxCoreLib.C_COUNTER_BINARY_V7_0(behavioral)
		generic map(
			c_count_mode => 0,
			c_load_enable => 1,
			c_has_aset => 0,
			c_load_low => 0,
			c_count_to => "1111111111111111",
			c_sync_priority => 1,
			c_has_iv => 0,
			c_restrict_count => 0,
			c_has_sclr => 0,
			c_width => 3,
			c_has_q_thresh1 => 0,
			c_enable_rlocs => 0,
			c_has_q_thresh0 => 0,
			c_thresh1_value => "1111111111111111",
			c_has_load => 1,
			c_thresh_early => 1,
			c_has_up => 0,
			c_has_thresh1 => 0,
			c_has_thresh0 => 0,
			c_ainit_val => "000",
			c_has_ce => 1,
			c_pipe_stages => 0,
			c_has_aclr => 0,
			c_sync_enable => 0,
			c_has_ainit => 0,
			c_sinit_val => "000",
			c_has_sset => 0,
			c_has_sinit => 1,
			c_count_by => "001",
			c_has_l => 1,
			c_thresh0_value => "1111111111111111");
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_binary_counter_virtex2p_7_0_b511f9871581ee23
		port map (
			Q => Q,
			CLK => CLK,
			LOAD => LOAD,
			L => L,
			CE => CE,
			SINIT => SINIT);
-- synthesis translate_on

END binary_counter_virtex2p_7_0_b511f9871581ee23_a;

--------------------------------------------------------------------------------
--     This file is owned and controlled by Xilinx and must be used           --
--     solely for design, simulation, implementation and creation of          --
--     design files limited to Xilinx devices or technologies. Use            --
--     with non-Xilinx devices or technologies is expressly prohibited        --
--     and immediately terminates your license.                               --
--                                                                            --
--     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"          --
--     SOLELY FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR                --
--     XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION        --
--     AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE, APPLICATION            --
--     OR STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS              --
--     IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,                --
--     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE       --
--     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY               --
--     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE                --
--     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR         --
--     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF        --
--     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS        --
--     FOR A PARTICULAR PURPOSE.                                              --
--                                                                            --
--     Xilinx products are not intended for use in life support               --
--     appliances, devices, or systems. Use in such applications are          --
--     expressly prohibited.                                                  --
--                                                                            --
--     (c) Copyright 1995-2007 Xilinx, Inc.                                   --
--     All rights reserved.                                                   --
--------------------------------------------------------------------------------
-- You must compile the wrapper file multiplier_virtex2p_10_1_817edd563258bb47.vhd when simulating
-- the core, multiplier_virtex2p_10_1_817edd563258bb47. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synthesis directives "translate_off/translate_on" specified
-- below are supported by Xilinx, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synthesis translate_off
Library XilinxCoreLib;
-- synthesis translate_on
ENTITY multiplier_virtex2p_10_1_817edd563258bb47 IS
	port (
	clk: IN std_logic;
	a: IN std_logic_VECTOR(17 downto 0);
	b: IN std_logic_VECTOR(17 downto 0);
	ce: IN std_logic;
	sclr: IN std_logic;
	p: OUT std_logic_VECTOR(35 downto 0));
END multiplier_virtex2p_10_1_817edd563258bb47;

ARCHITECTURE multiplier_virtex2p_10_1_817edd563258bb47_a OF multiplier_virtex2p_10_1_817edd563258bb47 IS
-- synthesis translate_off
component wrapped_multiplier_virtex2p_10_1_817edd563258bb47
	port (
	clk: IN std_logic;
	a: IN std_logic_VECTOR(17 downto 0);
	b: IN std_logic_VECTOR(17 downto 0);
	ce: IN std_logic;
	sclr: IN std_logic;
	p: OUT std_logic_VECTOR(35 downto 0));
end component;

-- Configuration specification 
	for all : wrapped_multiplier_virtex2p_10_1_817edd563258bb47 use entity XilinxCoreLib.mult_gen_v10_1(behavioral)
		generic map(
			c_a_width => 18,
			c_b_type => 1,
			c_ce_overrides_sclr => 1,
			c_has_sclr => 1,
			c_round_pt => 0,
			c_model_type => 0,
			c_out_high => 35,
			c_verbosity => 0,
			c_mult_type => 1,
			c_ccm_imp => 0,
			c_latency => 1,
			c_has_ce => 1,
			c_has_zero_detect => 0,
			c_round_output => 0,
			c_optimize_goal => 1,
			c_xdevicefamily => "virtex2p",
			c_a_type => 1,
			c_out_low => 0,
			c_b_width => 18,
			c_b_value => "10000001");
-- synthesis translate_on
BEGIN
-- synthesis translate_off
U0 : wrapped_multiplier_virtex2p_10_1_817edd563258bb47
		port map (
			clk => clk,
			a => a,
			b => b,
			ce => ce,
			sclr => sclr,
			p => p);
-- synthesis translate_on

END multiplier_virtex2p_10_1_817edd563258bb47_a;


-------------------------------------------------------------------
-- System Generator version 10.1.2 VHDL source file.
--
-- Copyright(C) 2008 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2008 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
package conv_pkg is
    constant simulating : boolean := false
      -- synopsys translate_off
        or true
      -- synopsys translate_on
    ;
    constant xlUnsigned : integer := 1;
    constant xlSigned : integer := 2;
    constant xlWrap : integer := 1;
    constant xlSaturate : integer := 2;
    constant xlTruncate : integer := 1;
    constant xlRound : integer := 2;
    constant xlRoundBanker : integer := 3;
    constant xlAddMode : integer := 1;
    constant xlSubMode : integer := 2;
    attribute black_box : boolean;
    attribute syn_black_box : boolean;
    attribute fpga_dont_touch: string;
    attribute box_type :  string;
    attribute keep : string;
    attribute syn_keep : boolean;
    function std_logic_vector_to_unsigned(inp : std_logic_vector) return unsigned;
    function unsigned_to_std_logic_vector(inp : unsigned) return std_logic_vector;
    function std_logic_vector_to_signed(inp : std_logic_vector) return signed;
    function signed_to_std_logic_vector(inp : signed) return std_logic_vector;
    function unsigned_to_signed(inp : unsigned) return signed;
    function signed_to_unsigned(inp : signed) return unsigned;
    function pos(inp : std_logic_vector; arith : INTEGER) return boolean;
    function all_same(inp: std_logic_vector) return boolean;
    function all_zeros(inp: std_logic_vector) return boolean;
    function is_point_five(inp: std_logic_vector) return boolean;
    function all_ones(inp: std_logic_vector) return boolean;
    function convert_type (inp : std_logic_vector; old_width, old_bin_pt,
                           old_arith, new_width, new_bin_pt, new_arith,
                           quantization, overflow : INTEGER)
        return std_logic_vector;
    function cast (inp : std_logic_vector; old_bin_pt,
                   new_width, new_bin_pt, new_arith : INTEGER)
        return std_logic_vector;
    function vec_slice (inp : std_logic_vector; upper, lower : INTEGER)
        return std_logic_vector;
    function s2u_slice (inp : signed; upper, lower : INTEGER)
        return unsigned;
    function u2u_slice (inp : unsigned; upper, lower : INTEGER)
        return unsigned;
    function s2s_cast (inp : signed; old_bin_pt,
                   new_width, new_bin_pt : INTEGER)
        return signed;
    function u2s_cast (inp : unsigned; old_bin_pt,
                   new_width, new_bin_pt : INTEGER)
        return signed;
    function s2u_cast (inp : signed; old_bin_pt,
                   new_width, new_bin_pt : INTEGER)
        return unsigned;
    function u2u_cast (inp : unsigned; old_bin_pt,
                   new_width, new_bin_pt : INTEGER)
        return unsigned;
    function u2v_cast (inp : unsigned; old_bin_pt,
                   new_width, new_bin_pt : INTEGER)
        return std_logic_vector;
    function s2v_cast (inp : signed; old_bin_pt,
                   new_width, new_bin_pt : INTEGER)
        return std_logic_vector;
    function trunc (inp : std_logic_vector; old_width, old_bin_pt, old_arith,
                    new_width, new_bin_pt, new_arith : INTEGER)
        return std_logic_vector;
    function round_towards_inf (inp : std_logic_vector; old_width, old_bin_pt,
                                old_arith, new_width, new_bin_pt,
                                new_arith : INTEGER) return std_logic_vector;
    function round_towards_even (inp : std_logic_vector; old_width, old_bin_pt,
                                old_arith, new_width, new_bin_pt,
                                new_arith : INTEGER) return std_logic_vector;
    function max_signed(width : INTEGER) return std_logic_vector;
    function min_signed(width : INTEGER) return std_logic_vector;
    function saturation_arith(inp:  std_logic_vector;  old_width, old_bin_pt,
                              old_arith, new_width, new_bin_pt, new_arith
                              : INTEGER) return std_logic_vector;
    function wrap_arith(inp:  std_logic_vector;  old_width, old_bin_pt,
                        old_arith, new_width, new_bin_pt, new_arith : INTEGER)
                        return std_logic_vector;
    function fractional_bits(a_bin_pt, b_bin_pt: INTEGER) return INTEGER;
    function integer_bits(a_width, a_bin_pt, b_width, b_bin_pt: INTEGER)
        return INTEGER;
    function sign_ext(inp : std_logic_vector; new_width : INTEGER)
        return std_logic_vector;
    function zero_ext(inp : std_logic_vector; new_width : INTEGER)
        return std_logic_vector;
    function zero_ext(inp : std_logic; new_width : INTEGER)
        return std_logic_vector;
    function extend_MSB(inp : std_logic_vector; new_width, arith : INTEGER)
        return std_logic_vector;
    function align_input(inp : std_logic_vector; old_width, delta, new_arith,
                          new_width: INTEGER)
        return std_logic_vector;
    function pad_LSB(inp : std_logic_vector; new_width: integer)
        return std_logic_vector;
    function pad_LSB(inp : std_logic_vector; new_width, arith : integer)
        return std_logic_vector;
    function max(L, R: INTEGER) return INTEGER;
    function min(L, R: INTEGER) return INTEGER;
    function "="(left,right: STRING) return boolean;
    function boolean_to_signed (inp : boolean; width: integer)
        return signed;
    function boolean_to_unsigned (inp : boolean; width: integer)
        return unsigned;
    function boolean_to_vector (inp : boolean)
        return std_logic_vector;
    function std_logic_to_vector (inp : std_logic)
        return std_logic_vector;
    function integer_to_std_logic_vector (inp : integer;  width, arith : integer)
        return std_logic_vector;
    function std_logic_vector_to_integer (inp : std_logic_vector;  arith : integer)
        return integer;
    function std_logic_to_integer(constant inp : std_logic := '0')
        return integer;
    function bin_string_element_to_std_logic_vector (inp : string;  width, index : integer)
        return std_logic_vector;
    function bin_string_to_std_logic_vector (inp : string)
        return std_logic_vector;
    function hex_string_to_std_logic_vector (inp : string; width : integer)
        return std_logic_vector;
    function makeZeroBinStr (width : integer) return STRING;
    function and_reduce(inp: std_logic_vector) return std_logic;
    -- synopsys translate_off
    function is_binary_string_invalid (inp : string)
        return boolean;
    function is_binary_string_undefined (inp : string)
        return boolean;
    function is_XorU(inp : std_logic_vector)
        return boolean;
    function to_real(inp : std_logic_vector; bin_pt : integer; arith : integer)
        return real;
    function std_logic_to_real(inp : std_logic; bin_pt : integer; arith : integer)
        return real;
    function real_to_std_logic_vector (inp : real;  width, bin_pt, arith : integer)
        return std_logic_vector;
    function real_string_to_std_logic_vector (inp : string;  width, bin_pt, arith : integer)
        return std_logic_vector;
    constant display_precision : integer := 20;
    function real_to_string (inp : real) return string;
    function valid_bin_string(inp : string) return boolean;
    function std_logic_vector_to_bin_string(inp : std_logic_vector) return string;
    function std_logic_to_bin_string(inp : std_logic) return string;
    function std_logic_vector_to_bin_string_w_point(inp : std_logic_vector; bin_pt : integer)
        return string;
    function real_to_bin_string(inp : real;  width, bin_pt, arith : integer)
        return string;
    type stdlogic_to_char_t is array(std_logic) of character;
    constant to_char : stdlogic_to_char_t := (
        'U' => 'U',
        'X' => 'X',
        '0' => '0',
        '1' => '1',
        'Z' => 'Z',
        'W' => 'W',
        'L' => 'L',
        'H' => 'H',
        '-' => '-');
    -- synopsys translate_on
end conv_pkg;
package body conv_pkg is
    function std_logic_vector_to_unsigned(inp : std_logic_vector)
        return unsigned
    is
    begin
        return unsigned (inp);
    end;
    function unsigned_to_std_logic_vector(inp : unsigned)
        return std_logic_vector
    is
    begin
        return std_logic_vector(inp);
    end;
    function std_logic_vector_to_signed(inp : std_logic_vector)
        return signed
    is
    begin
        return  signed (inp);
    end;
    function signed_to_std_logic_vector(inp : signed)
        return std_logic_vector
    is
    begin
        return std_logic_vector(inp);
    end;
    function unsigned_to_signed (inp : unsigned)
        return signed
    is
    begin
        return signed(std_logic_vector(inp));
    end;
    function signed_to_unsigned (inp : signed)
        return unsigned
    is
    begin
        return unsigned(std_logic_vector(inp));
    end;
    function pos(inp : std_logic_vector; arith : INTEGER)
        return boolean
    is
        constant width : integer := inp'length;
        variable vec : std_logic_vector(width-1 downto 0);
    begin
        vec := inp;
        if arith = xlUnsigned then
            return true;
        else
            if vec(width-1) = '0' then
                return true;
            else
                return false;
            end if;
        end if;
        return true;
    end;
    function max_signed(width : INTEGER)
        return std_logic_vector
    is
        variable ones : std_logic_vector(width-2 downto 0);
        variable result : std_logic_vector(width-1 downto 0);
    begin
        ones := (others => '1');
        result(width-1) := '0';
        result(width-2 downto 0) := ones;
        return result;
    end;
    function min_signed(width : INTEGER)
        return std_logic_vector
    is
        variable zeros : std_logic_vector(width-2 downto 0);
        variable result : std_logic_vector(width-1 downto 0);
    begin
        zeros := (others => '0');
        result(width-1) := '1';
        result(width-2 downto 0) := zeros;
        return result;
    end;
    function and_reduce(inp: std_logic_vector) return std_logic
    is
        variable result: std_logic;
        constant width : integer := inp'length;
        variable vec : std_logic_vector(width-1 downto 0);
    begin
        vec := inp;
        result := vec(0);
        if width > 1 then
            for i in 1 to width-1 loop
                result := result and vec(i);
            end loop;
        end if;
        return result;
    end;
    function all_same(inp: std_logic_vector) return boolean
    is
        variable result: boolean;
        constant width : integer := inp'length;
        variable vec : std_logic_vector(width-1 downto 0);
    begin
        vec := inp;
        result := true;
        if width > 0 then
            for i in 1 to width-1 loop
                if vec(i) /= vec(0) then
                    result := false;
                end if;
            end loop;
        end if;
        return result;
    end;
    function all_zeros(inp: std_logic_vector)
        return boolean
    is
        constant width : integer := inp'length;
        variable vec : std_logic_vector(width-1 downto 0);
        variable zero : std_logic_vector(width-1 downto 0);
        variable result : boolean;
    begin
        zero := (others => '0');
        vec := inp;
        -- synopsys translate_off
        if (is_XorU(vec)) then
            return false;
        end if;
         -- synopsys translate_on
        if (std_logic_vector_to_unsigned(vec) = std_logic_vector_to_unsigned(zero)) then
            result := true;
        else
            result := false;
        end if;
        return result;
    end;
    function is_point_five(inp: std_logic_vector)
        return boolean
    is
        constant width : integer := inp'length;
        variable vec : std_logic_vector(width-1 downto 0);
        variable result : boolean;
    begin
        vec := inp;
        -- synopsys translate_off
        if (is_XorU(vec)) then
            return false;
        end if;
         -- synopsys translate_on
        if (width > 1) then
           if ((vec(width-1) = '1') and (all_zeros(vec(width-2 downto 0)) = true)) then
               result := true;
           else
               result := false;
           end if;
        else
           if (vec(width-1) = '1') then
               result := true;
           else
               result := false;
           end if;
        end if;
        return result;
    end;
    function all_ones(inp: std_logic_vector)
        return boolean
    is
        constant width : integer := inp'length;
        variable vec : std_logic_vector(width-1 downto 0);
        variable one : std_logic_vector(width-1 downto 0);
        variable result : boolean;
    begin
        one := (others => '1');
        vec := inp;
        -- synopsys translate_off
        if (is_XorU(vec)) then
            return false;
        end if;
         -- synopsys translate_on
        if (std_logic_vector_to_unsigned(vec) = std_logic_vector_to_unsigned(one)) then
            result := true;
        else
            result := false;
        end if;
        return result;
    end;
    function full_precision_num_width(quantization, overflow, old_width,
                                      old_bin_pt, old_arith,
                                      new_width, new_bin_pt, new_arith : INTEGER)
        return integer
    is
        variable result : integer;
    begin
        result := old_width + 2;
        return result;
    end;
    function quantized_num_width(quantization, overflow, old_width, old_bin_pt,
                                 old_arith, new_width, new_bin_pt, new_arith
                                 : INTEGER)
        return integer
    is
        variable right_of_dp, left_of_dp, result : integer;
    begin
        right_of_dp := max(new_bin_pt, old_bin_pt);
        left_of_dp := max((new_width - new_bin_pt), (old_width - old_bin_pt));
        result := (old_width + 2) + (new_bin_pt - old_bin_pt);
        return result;
    end;
    function convert_type (inp : std_logic_vector; old_width, old_bin_pt,
                           old_arith, new_width, new_bin_pt, new_arith,
                           quantization, overflow : INTEGER)
        return std_logic_vector
    is
        constant fp_width : integer :=
            full_precision_num_width(quantization, overflow, old_width,
                                     old_bin_pt, old_arith, new_width,
                                     new_bin_pt, new_arith);
        constant fp_bin_pt : integer := old_bin_pt;
        constant fp_arith : integer := old_arith;
        variable full_precision_result : std_logic_vector(fp_width-1 downto 0);
        constant q_width : integer :=
            quantized_num_width(quantization, overflow, old_width, old_bin_pt,
                                old_arith, new_width, new_bin_pt, new_arith);
        constant q_bin_pt : integer := new_bin_pt;
        constant q_arith : integer := old_arith;
        variable quantized_result : std_logic_vector(q_width-1 downto 0);
        variable result : std_logic_vector(new_width-1 downto 0);
    begin
        result := (others => '0');
        full_precision_result := cast(inp, old_bin_pt, fp_width, fp_bin_pt,
                                      fp_arith);
        if (quantization = xlRound) then
            quantized_result := round_towards_inf(full_precision_result,
                                                  fp_width, fp_bin_pt,
                                                  fp_arith, q_width, q_bin_pt,
                                                  q_arith);
        elsif (quantization = xlRoundBanker) then
            quantized_result := round_towards_even(full_precision_result,
                                                  fp_width, fp_bin_pt,
                                                  fp_arith, q_width, q_bin_pt,
                                                  q_arith);
        else
            quantized_result := trunc(full_precision_result, fp_width, fp_bin_pt,
                                      fp_arith, q_width, q_bin_pt, q_arith);
        end if;
        if (overflow = xlSaturate) then
            result := saturation_arith(quantized_result, q_width, q_bin_pt,
                                       q_arith, new_width, new_bin_pt, new_arith);
        else
             result := wrap_arith(quantized_result, q_width, q_bin_pt, q_arith,
                                  new_width, new_bin_pt, new_arith);
        end if;
        return result;
    end;
    function cast (inp : std_logic_vector; old_bin_pt, new_width,
                   new_bin_pt, new_arith : INTEGER)
        return std_logic_vector
    is
        constant old_width : integer := inp'length;
        constant left_of_dp : integer := (new_width - new_bin_pt)
                                         - (old_width - old_bin_pt);
        constant right_of_dp : integer := (new_bin_pt - old_bin_pt);
        variable vec : std_logic_vector(old_width-1 downto 0);
        variable result : std_logic_vector(new_width-1 downto 0);
        variable j   : integer;
    begin
        vec := inp;
        for i in new_width-1 downto 0 loop
            j := i - right_of_dp;
            if ( j > old_width-1) then
                if (new_arith = xlUnsigned) then
                    result(i) := '0';
                else
                    result(i) := vec(old_width-1);
                end if;
            elsif ( j >= 0) then
                result(i) := vec(j);
            else
                result(i) := '0';
            end if;
        end loop;
        return result;
    end;
    function vec_slice (inp : std_logic_vector; upper, lower : INTEGER)
      return std_logic_vector
    is
    begin
        return inp(upper downto lower);
    end;
    function s2u_slice (inp : signed; upper, lower : INTEGER)
      return unsigned
    is
    begin
        return unsigned(vec_slice(std_logic_vector(inp), upper, lower));
    end;
    function u2u_slice (inp : unsigned; upper, lower : INTEGER)
      return unsigned
    is
    begin
        return unsigned(vec_slice(std_logic_vector(inp), upper, lower));
    end;
    function s2s_cast (inp : signed; old_bin_pt, new_width, new_bin_pt : INTEGER)
        return signed
    is
    begin
        return signed(cast(std_logic_vector(inp), old_bin_pt, new_width, new_bin_pt, xlSigned));
    end;
    function s2u_cast (inp : signed; old_bin_pt, new_width,
                   new_bin_pt : INTEGER)
        return unsigned
    is
    begin
        return unsigned(cast(std_logic_vector(inp), old_bin_pt, new_width, new_bin_pt, xlSigned));
    end;
    function u2s_cast (inp : unsigned; old_bin_pt, new_width,
                   new_bin_pt : INTEGER)
        return signed
    is
    begin
        return signed(cast(std_logic_vector(inp), old_bin_pt, new_width, new_bin_pt, xlUnsigned));
    end;
    function u2u_cast (inp : unsigned; old_bin_pt, new_width,
                   new_bin_pt : INTEGER)
        return unsigned
    is
    begin
        return unsigned(cast(std_logic_vector(inp), old_bin_pt, new_width, new_bin_pt, xlUnsigned));
    end;
    function u2v_cast (inp : unsigned; old_bin_pt, new_width,
                   new_bin_pt : INTEGER)
        return std_logic_vector
    is
    begin
        return cast(std_logic_vector(inp), old_bin_pt, new_width, new_bin_pt, xlUnsigned);
    end;
    function s2v_cast (inp : signed; old_bin_pt, new_width,
                   new_bin_pt : INTEGER)
        return std_logic_vector
    is
    begin
        return cast(std_logic_vector(inp), old_bin_pt, new_width, new_bin_pt, xlSigned);
    end;
    function boolean_to_signed (inp : boolean; width : integer)
        return signed
    is
        variable result : signed(width - 1 downto 0);
    begin
        result := (others => '0');
        if inp then
          result(0) := '1';
        else
          result(0) := '0';
        end if;
        return result;
    end;
    function boolean_to_unsigned (inp : boolean; width : integer)
        return unsigned
    is
        variable result : unsigned(width - 1 downto 0);
    begin
        result := (others => '0');
        if inp then
          result(0) := '1';
        else
          result(0) := '0';
        end if;
        return result;
    end;
    function boolean_to_vector (inp : boolean)
        return std_logic_vector
    is
        variable result : std_logic_vector(1 - 1 downto 0);
    begin
        result := (others => '0');
        if inp then
          result(0) := '1';
        else
          result(0) := '0';
        end if;
        return result;
    end;
    function std_logic_to_vector (inp : std_logic)
        return std_logic_vector
    is
        variable result : std_logic_vector(1 - 1 downto 0);
    begin
        result(0) := inp;
        return result;
    end;
    function trunc (inp : std_logic_vector; old_width, old_bin_pt, old_arith,
                                new_width, new_bin_pt, new_arith : INTEGER)
        return std_logic_vector
    is
        constant right_of_dp : integer := (old_bin_pt - new_bin_pt);
        variable vec : std_logic_vector(old_width-1 downto 0);
        variable result : std_logic_vector(new_width-1 downto 0);
    begin
        vec := inp;
        if right_of_dp >= 0 then
            if new_arith = xlUnsigned then
                result := zero_ext(vec(old_width-1 downto right_of_dp), new_width);
            else
                result := sign_ext(vec(old_width-1 downto right_of_dp), new_width);
            end if;
        else
            if new_arith = xlUnsigned then
                result := zero_ext(pad_LSB(vec, old_width +
                                           abs(right_of_dp)), new_width);
            else
                result := sign_ext(pad_LSB(vec, old_width +
                                           abs(right_of_dp)), new_width);
            end if;
        end if;
        return result;
    end;
    function round_towards_inf (inp : std_logic_vector; old_width, old_bin_pt,
                                old_arith, new_width, new_bin_pt, new_arith
                                : INTEGER)
        return std_logic_vector
    is
        constant right_of_dp : integer := (old_bin_pt - new_bin_pt);
        constant expected_new_width : integer :=  old_width - right_of_dp  + 1;
        variable vec : std_logic_vector(old_width-1 downto 0);
        variable one_or_zero : std_logic_vector(new_width-1 downto 0);
        variable truncated_val : std_logic_vector(new_width-1 downto 0);
        variable result : std_logic_vector(new_width-1 downto 0);
    begin
        vec := inp;
        if right_of_dp >= 0 then
            if new_arith = xlUnsigned then
                truncated_val := zero_ext(vec(old_width-1 downto right_of_dp),
                                          new_width);
            else
                truncated_val := sign_ext(vec(old_width-1 downto right_of_dp),
                                          new_width);
            end if;
        else
            if new_arith = xlUnsigned then
                truncated_val := zero_ext(pad_LSB(vec, old_width +
                                                  abs(right_of_dp)), new_width);
            else
                truncated_val := sign_ext(pad_LSB(vec, old_width +
                                                  abs(right_of_dp)), new_width);
            end if;
        end if;
        one_or_zero := (others => '0');
        if (new_arith = xlSigned) then
            if (vec(old_width-1) = '0') then
                one_or_zero(0) := '1';
            end if;
            if (right_of_dp >= 2) and (right_of_dp <= old_width) then
                if (all_zeros(vec(right_of_dp-2 downto 0)) = false) then
                    one_or_zero(0) := '1';
                end if;
            end if;
            if (right_of_dp >= 1) and (right_of_dp <= old_width) then
                if vec(right_of_dp-1) = '0' then
                    one_or_zero(0) := '0';
                end if;
            else
                one_or_zero(0) := '0';
            end if;
        else
            if (right_of_dp >= 1) and (right_of_dp <= old_width) then
                one_or_zero(0) :=  vec(right_of_dp-1);
            end if;
        end if;
        if new_arith = xlSigned then
            result := signed_to_std_logic_vector(std_logic_vector_to_signed(truncated_val) +
                                                 std_logic_vector_to_signed(one_or_zero));
        else
            result := unsigned_to_std_logic_vector(std_logic_vector_to_unsigned(truncated_val) +
                                                  std_logic_vector_to_unsigned(one_or_zero));
        end if;
        return result;
    end;
    function round_towards_even (inp : std_logic_vector; old_width, old_bin_pt,
                                old_arith, new_width, new_bin_pt, new_arith
                                : INTEGER)
        return std_logic_vector
    is
        constant right_of_dp : integer := (old_bin_pt - new_bin_pt);
        constant expected_new_width : integer :=  old_width - right_of_dp  + 1;
        variable vec : std_logic_vector(old_width-1 downto 0);
        variable one_or_zero : std_logic_vector(new_width-1 downto 0);
        variable truncated_val : std_logic_vector(new_width-1 downto 0);
        variable result : std_logic_vector(new_width-1 downto 0);
    begin
        vec := inp;
        if right_of_dp >= 0 then
            if new_arith = xlUnsigned then
                truncated_val := zero_ext(vec(old_width-1 downto right_of_dp),
                                          new_width);
            else
                truncated_val := sign_ext(vec(old_width-1 downto right_of_dp),
                                          new_width);
            end if;
        else
            if new_arith = xlUnsigned then
                truncated_val := zero_ext(pad_LSB(vec, old_width +
                                                  abs(right_of_dp)), new_width);
            else
                truncated_val := sign_ext(pad_LSB(vec, old_width +
                                                  abs(right_of_dp)), new_width);
            end if;
        end if;
        one_or_zero := (others => '0');
        if (right_of_dp >= 1) and (right_of_dp <= old_width) then
            if (is_point_five(vec(right_of_dp-1 downto 0)) = false) then
                one_or_zero(0) :=  vec(right_of_dp-1);
            else
                one_or_zero(0) :=  vec(right_of_dp);
            end if;
        end if;
        if new_arith = xlSigned then
            result := signed_to_std_logic_vector(std_logic_vector_to_signed(truncated_val) +
                                                 std_logic_vector_to_signed(one_or_zero));
        else
            result := unsigned_to_std_logic_vector(std_logic_vector_to_unsigned(truncated_val) +
                                                  std_logic_vector_to_unsigned(one_or_zero));
        end if;
        return result;
    end;
    function saturation_arith(inp:  std_logic_vector;  old_width, old_bin_pt,
                              old_arith, new_width, new_bin_pt, new_arith
                              : INTEGER)
        return std_logic_vector
    is
        constant left_of_dp : integer := (old_width - old_bin_pt) -
                                         (new_width - new_bin_pt);
        variable vec : std_logic_vector(old_width-1 downto 0);
        variable result : std_logic_vector(new_width-1 downto 0);
        variable overflow : boolean;
    begin
        vec := inp;
        overflow := true;
        result := (others => '0');
        if (new_width >= old_width) then
            overflow := false;
        end if;
        if ((old_arith = xlSigned and new_arith = xlSigned) and (old_width > new_width)) then
            if all_same(vec(old_width-1 downto new_width-1)) then
                overflow := false;
            end if;
        end if;
        if (old_arith = xlSigned and new_arith = xlUnsigned) then
            if (old_width > new_width) then
                if all_zeros(vec(old_width-1 downto new_width)) then
                    overflow := false;
                end if;
            else
                if (old_width = new_width) then
                    if (vec(new_width-1) = '0') then
                        overflow := false;
                    end if;
                end if;
            end if;
        end if;
        if (old_arith = xlUnsigned and new_arith = xlUnsigned) then
            if (old_width > new_width) then
                if all_zeros(vec(old_width-1 downto new_width)) then
                    overflow := false;
                end if;
            else
                if (old_width = new_width) then
                    overflow := false;
                end if;
            end if;
        end if;
        if ((old_arith = xlUnsigned and new_arith = xlSigned) and (old_width > new_width)) then
            if all_same(vec(old_width-1 downto new_width-1)) then
                overflow := false;
            end if;
        end if;
        if overflow then
            if new_arith = xlSigned then
                if vec(old_width-1) = '0' then
                    result := max_signed(new_width);
                else
                    result := min_signed(new_width);
                end if;
            else
                if ((old_arith = xlSigned) and vec(old_width-1) = '1') then
                    result := (others => '0');
                else
                    result := (others => '1');
                end if;
            end if;
        else
            if (old_arith = xlSigned) and (new_arith = xlUnsigned) then
                if (vec(old_width-1) = '1') then
                    vec := (others => '0');
                end if;
            end if;
            if new_width <= old_width then
                result := vec(new_width-1 downto 0);
            else
                if new_arith = xlUnsigned then
                    result := zero_ext(vec, new_width);
                else
                    result := sign_ext(vec, new_width);
                end if;
            end if;
        end if;
        return result;
    end;
   function wrap_arith(inp:  std_logic_vector;  old_width, old_bin_pt,
                       old_arith, new_width, new_bin_pt, new_arith : INTEGER)
        return std_logic_vector
    is
        variable result : std_logic_vector(new_width-1 downto 0);
        variable result_arith : integer;
    begin
        if (old_arith = xlSigned) and (new_arith = xlUnsigned) then
            result_arith := xlSigned;
        end if;
        result := cast(inp, old_bin_pt, new_width, new_bin_pt, result_arith);
        return result;
    end;
    function fractional_bits(a_bin_pt, b_bin_pt: INTEGER) return INTEGER is
    begin
        return max(a_bin_pt, b_bin_pt);
    end;
    function integer_bits(a_width, a_bin_pt, b_width, b_bin_pt: INTEGER)
        return INTEGER is
    begin
        return  max(a_width - a_bin_pt, b_width - b_bin_pt);
    end;
    function pad_LSB(inp : std_logic_vector; new_width: integer)
        return STD_LOGIC_VECTOR
    is
        constant orig_width : integer := inp'length;
        variable vec : std_logic_vector(orig_width-1 downto 0);
        variable result : std_logic_vector(new_width-1 downto 0);
        variable pos : integer;
        constant pad_pos : integer := new_width - orig_width - 1;
    begin
        vec := inp;
        pos := new_width-1;
        if (new_width >= orig_width) then
            for i in orig_width-1 downto 0 loop
                result(pos) := vec(i);
                pos := pos - 1;
            end loop;
            if pad_pos >= 0 then
                for i in pad_pos downto 0 loop
                    result(i) := '0';
                end loop;
            end if;
        end if;
        return result;
    end;
    function sign_ext(inp : std_logic_vector; new_width : INTEGER)
        return std_logic_vector
    is
        constant old_width : integer := inp'length;
        variable vec : std_logic_vector(old_width-1 downto 0);
        variable result : std_logic_vector(new_width-1 downto 0);
    begin
        vec := inp;
        if new_width >= old_width then
            result(old_width-1 downto 0) := vec;
            if new_width-1 >= old_width then
                for i in new_width-1 downto old_width loop
                    result(i) := vec(old_width-1);
                end loop;
            end if;
        else
            result(new_width-1 downto 0) := vec(new_width-1 downto 0);
        end if;
        return result;
    end;
    function zero_ext(inp : std_logic_vector; new_width : INTEGER)
        return std_logic_vector
    is
        constant old_width : integer := inp'length;
        variable vec : std_logic_vector(old_width-1 downto 0);
        variable result : std_logic_vector(new_width-1 downto 0);
    begin
        vec := inp;
        if new_width >= old_width then
            result(old_width-1 downto 0) := vec;
            if new_width-1 >= old_width then
                for i in new_width-1 downto old_width loop
                    result(i) := '0';
                end loop;
            end if;
        else
            result(new_width-1 downto 0) := vec(new_width-1 downto 0);
        end if;
        return result;
    end;
    function zero_ext(inp : std_logic; new_width : INTEGER)
        return std_logic_vector
    is
        variable result : std_logic_vector(new_width-1 downto 0);
    begin
        result(0) := inp;
        for i in new_width-1 downto 1 loop
            result(i) := '0';
        end loop;
        return result;
    end;
    function extend_MSB(inp : std_logic_vector; new_width, arith : INTEGER)
        return std_logic_vector
    is
        constant orig_width : integer := inp'length;
        variable vec : std_logic_vector(orig_width-1 downto 0);
        variable result : std_logic_vector(new_width-1 downto 0);
    begin
        vec := inp;
        if arith = xlUnsigned then
            result := zero_ext(vec, new_width);
        else
            result := sign_ext(vec, new_width);
        end if;
        return result;
    end;
    function pad_LSB(inp : std_logic_vector; new_width, arith: integer)
        return STD_LOGIC_VECTOR
    is
        constant orig_width : integer := inp'length;
        variable vec : std_logic_vector(orig_width-1 downto 0);
        variable result : std_logic_vector(new_width-1 downto 0);
        variable pos : integer;
    begin
        vec := inp;
        pos := new_width-1;
        if (arith = xlUnsigned) then
            result(pos) := '0';
            pos := pos - 1;
        else
            result(pos) := vec(orig_width-1);
            pos := pos - 1;
        end if;
        if (new_width >= orig_width) then
            for i in orig_width-1 downto 0 loop
                result(pos) := vec(i);
                pos := pos - 1;
            end loop;
            if pos >= 0 then
                for i in pos downto 0 loop
                    result(i) := '0';
                end loop;
            end if;
        end if;
        return result;
    end;
    function align_input(inp : std_logic_vector; old_width, delta, new_arith,
                         new_width: INTEGER)
        return std_logic_vector
    is
        variable vec : std_logic_vector(old_width-1 downto 0);
        variable padded_inp : std_logic_vector((old_width + delta)-1  downto 0);
        variable result : std_logic_vector(new_width-1 downto 0);
    begin
        vec := inp;
        if delta > 0 then
            padded_inp := pad_LSB(vec, old_width+delta);
            result := extend_MSB(padded_inp, new_width, new_arith);
        else
            result := extend_MSB(vec, new_width, new_arith);
        end if;
        return result;
    end;
    function max(L, R: INTEGER) return INTEGER is
    begin
        if L > R then
            return L;
        else
            return R;
        end if;
    end;
    function min(L, R: INTEGER) return INTEGER is
    begin
        if L < R then
            return L;
        else
            return R;
        end if;
    end;
    function "="(left,right: STRING) return boolean is
    begin
        if (left'length /= right'length) then
            return false;
        else
            test : for i in 1 to left'length loop
                if left(i) /= right(i) then
                    return false;
                end if;
            end loop test;
            return true;
        end if;
    end;
    -- synopsys translate_off
    function is_binary_string_invalid (inp : string)
        return boolean
    is
        variable vec : string(1 to inp'length);
        variable result : boolean;
    begin
        vec := inp;
        result := false;
        for i in 1 to vec'length loop
            if ( vec(i) = 'X' ) then
                result := true;
            end if;
        end loop;
        return result;
    end;
    function is_binary_string_undefined (inp : string)
        return boolean
    is
        variable vec : string(1 to inp'length);
        variable result : boolean;
    begin
        vec := inp;
        result := false;
        for i in 1 to vec'length loop
            if ( vec(i) = 'U' ) then
                result := true;
            end if;
        end loop;
        return result;
    end;
    function is_XorU(inp : std_logic_vector)
        return boolean
    is
        constant width : integer := inp'length;
        variable vec : std_logic_vector(width-1 downto 0);
        variable result : boolean;
    begin
        vec := inp;
        result := false;
        for i in 0 to width-1 loop
            if (vec(i) = 'U') or (vec(i) = 'X') then
                result := true;
            end if;
        end loop;
        return result;
    end;
    function to_real(inp : std_logic_vector; bin_pt : integer; arith : integer)
        return real
    is
        variable  vec : std_logic_vector(inp'length-1 downto 0);
        variable result, shift_val, undefined_real : real;
        variable neg_num : boolean;
    begin
        vec := inp;
        result := 0.0;
        neg_num := false;
        if vec(inp'length-1) = '1' then
            neg_num := true;
        end if;
        for i in 0 to inp'length-1 loop
            if  vec(i) = 'U' or vec(i) = 'X' then
                return undefined_real;
            end if;
            if arith = xlSigned then
                if neg_num then
                    if vec(i) = '0' then
                        result := result + 2.0**i;
                    end if;
                else
                    if vec(i) = '1' then
                        result := result + 2.0**i;
                    end if;
                end if;
            else
                if vec(i) = '1' then
                    result := result + 2.0**i;
                end if;
            end if;
        end loop;
        if arith = xlSigned then
            if neg_num then
                result := result + 1.0;
                result := result * (-1.0);
            end if;
        end if;
        shift_val := 2.0**(-1*bin_pt);
        result := result * shift_val;
        return result;
    end;
    function std_logic_to_real(inp : std_logic; bin_pt : integer; arith : integer)
        return real
    is
        variable result : real := 0.0;
    begin
        if inp = '1' then
            result := 1.0;
        end if;
        if arith = xlSigned then
            assert false
                report "It doesn't make sense to convert a 1 bit number to a signed real.";
        end if;
        return result;
    end;
    -- synopsys translate_on
    function integer_to_std_logic_vector (inp : integer;  width, arith : integer)
        return std_logic_vector
    is
        variable result : std_logic_vector(width-1 downto 0);
        variable unsigned_val : unsigned(width-1 downto 0);
        variable signed_val : signed(width-1 downto 0);
    begin
        if (arith = xlSigned) then
            signed_val := to_signed(inp, width);
            result := signed_to_std_logic_vector(signed_val);
        else
            unsigned_val := to_unsigned(inp, width);
            result := unsigned_to_std_logic_vector(unsigned_val);
        end if;
        return result;
    end;
    function std_logic_vector_to_integer (inp : std_logic_vector;  arith : integer)
        return integer
    is
        constant width : integer := inp'length;
        variable unsigned_val : unsigned(width-1 downto 0);
        variable signed_val : signed(width-1 downto 0);
        variable result : integer;
    begin
        if (arith = xlSigned) then
            signed_val := std_logic_vector_to_signed(inp);
            result := to_integer(signed_val);
        else
            unsigned_val := std_logic_vector_to_unsigned(inp);
            result := to_integer(unsigned_val);
        end if;
        return result;
    end;
    function std_logic_to_integer(constant inp : std_logic := '0')
        return integer
    is
    begin
        if inp = '1' then
            return 1;
        else
            return 0;
        end if;
    end;
    function makeZeroBinStr (width : integer) return STRING is
        variable result : string(1 to width+3);
    begin
        result(1) := '0';
        result(2) := 'b';
        for i in 3 to width+2 loop
            result(i) := '0';
        end loop;
        result(width+3) := '.';
        return result;
    end;
    -- synopsys translate_off
    function real_string_to_std_logic_vector (inp : string;  width, bin_pt, arith : integer)
        return std_logic_vector
    is
        variable result : std_logic_vector(width-1 downto 0);
    begin
        result := (others => '0');
        return result;
    end;
    function real_to_std_logic_vector (inp : real;  width, bin_pt, arith : integer)
        return std_logic_vector
    is
        variable real_val : real;
        variable int_val : integer;
        variable result : std_logic_vector(width-1 downto 0) := (others => '0');
        variable unsigned_val : unsigned(width-1 downto 0) := (others => '0');
        variable signed_val : signed(width-1 downto 0) := (others => '0');
    begin
        real_val := inp;
        int_val := integer(real_val * 2.0**(bin_pt));
        if (arith = xlSigned) then
            signed_val := to_signed(int_val, width);
            result := signed_to_std_logic_vector(signed_val);
        else
            unsigned_val := to_unsigned(int_val, width);
            result := unsigned_to_std_logic_vector(unsigned_val);
        end if;
        return result;
    end;
    -- synopsys translate_on
    function valid_bin_string (inp : string)
        return boolean
    is
        variable vec : string(1 to inp'length);
    begin
        vec := inp;
        if (vec(1) = '0' and vec(2) = 'b') then
            return true;
        else
            return false;
        end if;
    end;
    function hex_string_to_std_logic_vector(inp: string; width : integer)
        return std_logic_vector is
        constant strlen       : integer := inp'LENGTH;
        variable result       : std_logic_vector(width-1 downto 0);
        variable bitval       : std_logic_vector((strlen*4)-1 downto 0);
        variable posn         : integer;
        variable ch           : character;
        variable vec          : string(1 to strlen);
    begin
        vec := inp;
        result := (others => '0');
        posn := (strlen*4)-1;
        for i in 1 to strlen loop
            ch := vec(i);
            case ch is
                when '0' => bitval(posn downto posn-3) := "0000";
                when '1' => bitval(posn downto posn-3) := "0001";
                when '2' => bitval(posn downto posn-3) := "0010";
                when '3' => bitval(posn downto posn-3) := "0011";
                when '4' => bitval(posn downto posn-3) := "0100";
                when '5' => bitval(posn downto posn-3) := "0101";
                when '6' => bitval(posn downto posn-3) := "0110";
                when '7' => bitval(posn downto posn-3) := "0111";
                when '8' => bitval(posn downto posn-3) := "1000";
                when '9' => bitval(posn downto posn-3) := "1001";
                when 'A' | 'a' => bitval(posn downto posn-3) := "1010";
                when 'B' | 'b' => bitval(posn downto posn-3) := "1011";
                when 'C' | 'c' => bitval(posn downto posn-3) := "1100";
                when 'D' | 'd' => bitval(posn downto posn-3) := "1101";
                when 'E' | 'e' => bitval(posn downto posn-3) := "1110";
                when 'F' | 'f' => bitval(posn downto posn-3) := "1111";
                when others => bitval(posn downto posn-3) := "XXXX";
                               -- synopsys translate_off
                               ASSERT false
                                   REPORT "Invalid hex value" SEVERITY ERROR;
                               -- synopsys translate_on
            end case;
            posn := posn - 4;
        end loop;
        if (width <= strlen*4) then
            result :=  bitval(width-1 downto 0);
        else
            result((strlen*4)-1 downto 0) := bitval;
        end if;
        return result;
    end;
    function bin_string_to_std_logic_vector (inp : string)
        return std_logic_vector
    is
        variable pos : integer;
        variable vec : string(1 to inp'length);
        variable result : std_logic_vector(inp'length-1 downto 0);
    begin
        vec := inp;
        pos := inp'length-1;
        result := (others => '0');
        for i in 1 to vec'length loop
            -- synopsys translate_off
            if (pos < 0) and (vec(i) = '0' or vec(i) = '1' or vec(i) = 'X' or vec(i) = 'U')  then
                assert false
                    report "Input string is larger than output std_logic_vector. Truncating output.";
                return result;
            end if;
            -- synopsys translate_on
            if vec(i) = '0' then
                result(pos) := '0';
                pos := pos - 1;
            end if;
            if vec(i) = '1' then
                result(pos) := '1';
                pos := pos - 1;
            end if;
            -- synopsys translate_off
            if (vec(i) = 'X' or vec(i) = 'U') then
                result(pos) := 'U';
                pos := pos - 1;
            end if;
            -- synopsys translate_on
        end loop;
        return result;
    end;
    function bin_string_element_to_std_logic_vector (inp : string;  width, index : integer)
        return std_logic_vector
    is
        constant str_width : integer := width + 4;
        constant inp_len : integer := inp'length;
        constant num_elements : integer := (inp_len + 1)/str_width;
        constant reverse_index : integer := (num_elements-1) - index;
        variable left_pos : integer;
        variable right_pos : integer;
        variable vec : string(1 to inp'length);
        variable result : std_logic_vector(width-1 downto 0);
    begin
        vec := inp;
        result := (others => '0');
        if (reverse_index = 0) and (reverse_index < num_elements) and (inp_len-3 >= width) then
            left_pos := 1;
            right_pos := width + 3;
            result := bin_string_to_std_logic_vector(vec(left_pos to right_pos));
        end if;
        if (reverse_index > 0) and (reverse_index < num_elements) and (inp_len-3 >= width) then
            left_pos := (reverse_index * str_width) + 1;
            right_pos := left_pos + width + 2;
            result := bin_string_to_std_logic_vector(vec(left_pos to right_pos));
        end if;
        return result;
    end;
   -- synopsys translate_off
    function std_logic_vector_to_bin_string(inp : std_logic_vector)
        return string
    is
        variable vec : std_logic_vector(1 to inp'length);
        variable result : string(vec'range);
    begin
        vec := inp;
        for i in vec'range loop
            result(i) := to_char(vec(i));
        end loop;
        return result;
    end;
    function std_logic_to_bin_string(inp : std_logic)
        return string
    is
        variable result : string(1 to 3);
    begin
        result(1) := '0';
        result(2) := 'b';
        result(3) := to_char(inp);
        return result;
    end;
    function std_logic_vector_to_bin_string_w_point(inp : std_logic_vector; bin_pt : integer)
        return string
    is
        variable width : integer := inp'length;
        variable vec : std_logic_vector(width-1 downto 0);
        variable str_pos : integer;
        variable result : string(1 to width+3);
    begin
        vec := inp;
        str_pos := 1;
        result(str_pos) := '0';
        str_pos := 2;
        result(str_pos) := 'b';
        str_pos := 3;
        for i in width-1 downto 0  loop
            if (((width+3) - bin_pt) = str_pos) then
                result(str_pos) := '.';
                str_pos := str_pos + 1;
            end if;
            result(str_pos) := to_char(vec(i));
            str_pos := str_pos + 1;
        end loop;
        if (bin_pt = 0) then
            result(str_pos) := '.';
        end if;
        return result;
    end;
    function real_to_bin_string(inp : real;  width, bin_pt, arith : integer)
        return string
    is
        variable result : string(1 to width);
        variable vec : std_logic_vector(width-1 downto 0);
    begin
        vec := real_to_std_logic_vector(inp, width, bin_pt, arith);
        result := std_logic_vector_to_bin_string(vec);
        return result;
    end;
    function real_to_string (inp : real) return string
    is
        variable result : string(1 to display_precision) := (others => ' ');
    begin
        result(real'image(inp)'range) := real'image(inp);
        return result;
    end;
    -- synopsys translate_on
end conv_pkg;
library IEEE;
use IEEE.std_logic_1164.all;
package clock_pkg is
-- synopsys translate_off
   signal int_clk : std_logic;
-- synopsys translate_on
end clock_pkg;

-------------------------------------------------------------------
-- System Generator version 10.1.2 VHDL source file.
--
-- Copyright(C) 2008 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2008 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
-- synopsys translate_off
library unisim;
use unisim.vcomponents.all;
-- synopsys translate_on
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;
entity srl17e is
    generic (width : integer:=16;
             latency : integer :=8);
    port (clk   : in std_logic;
          ce    : in std_logic;
          d     : in std_logic_vector(width-1 downto 0);
          q     : out std_logic_vector(width-1 downto 0));
end srl17e;
architecture structural of srl17e is
    component SRL16E
        port (D   : in STD_ULOGIC;
              CE  : in STD_ULOGIC;
              CLK : in STD_ULOGIC;
              A0  : in STD_ULOGIC;
              A1  : in STD_ULOGIC;
              A2  : in STD_ULOGIC;
              A3  : in STD_ULOGIC;
              Q   : out STD_ULOGIC);
    end component;
    attribute syn_black_box of SRL16E : component is true;
    attribute fpga_dont_touch of SRL16E : component is "true";
    component FDE
        port(
            Q  :        out   STD_ULOGIC;
            D  :        in    STD_ULOGIC;
            C  :        in    STD_ULOGIC;
            CE :        in    STD_ULOGIC);
    end component;
    attribute syn_black_box of FDE : component is true;
    attribute fpga_dont_touch of FDE : component is "true";
    constant a : std_logic_vector(4 downto 0) :=
        integer_to_std_logic_vector(latency-2,5,xlSigned);
    signal d_delayed : std_logic_vector(width-1 downto 0);
    signal srl16_out : std_logic_vector(width-1 downto 0);
begin
    d_delayed <= d after 200 ps;
    reg_array : for i in 0 to width-1 generate
        srl16_used: if latency > 1 generate
            u1 : srl16e port map(clk => clk,
                                 d => d_delayed(i),
                                 q => srl16_out(i),
                                 ce => ce,
                                 a0 => a(0),
                                 a1 => a(1),
                                 a2 => a(2),
                                 a3 => a(3));
        end generate;
        srl16_not_used: if latency <= 1 generate
            srl16_out(i) <= d_delayed(i);
        end generate;
        fde_used: if latency /= 0  generate
            u2 : fde port map(c => clk,
                              d => srl16_out(i),
                              q => q(i),
                              ce => ce);
        end generate;
        fde_not_used: if latency = 0  generate
            q(i) <= srl16_out(i);
        end generate;
    end generate;
 end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;
entity synth_reg is
    generic (width           : integer := 8;
             latency         : integer := 1);
    port (i       : in std_logic_vector(width-1 downto 0);
          ce      : in std_logic;
          clr     : in std_logic;
          clk     : in std_logic;
          o       : out std_logic_vector(width-1 downto 0));
end synth_reg;
architecture structural of synth_reg is
    component srl17e
        generic (width : integer:=16;
                 latency : integer :=8);
        port (clk : in std_logic;
              ce  : in std_logic;
              d   : in std_logic_vector(width-1 downto 0);
              q   : out std_logic_vector(width-1 downto 0));
    end component;
    function calc_num_srl17es (latency : integer)
        return integer
    is
        variable remaining_latency : integer;
        variable result : integer;
    begin
        result := latency / 17;
        remaining_latency := latency - (result * 17);
        if (remaining_latency /= 0) then
            result := result + 1;
        end if;
        return result;
    end;
    constant complete_num_srl17es : integer := latency / 17;
    constant num_srl17es : integer := calc_num_srl17es(latency);
    constant remaining_latency : integer := latency - (complete_num_srl17es * 17);
    type register_array is array (num_srl17es downto 0) of
        std_logic_vector(width-1 downto 0);
    signal z : register_array;
begin
    z(0) <= i;
    complete_ones : if complete_num_srl17es > 0 generate
        srl17e_array: for i in 0 to complete_num_srl17es-1 generate
            delay_comp : srl17e
                generic map (width => width,
                             latency => 17)
                port map (clk => clk,
                          ce  => ce,
                          d       => z(i),
                          q       => z(i+1));
        end generate;
    end generate;
    partial_one : if remaining_latency > 0 generate
        last_srl17e : srl17e
            generic map (width => width,
                         latency => remaining_latency)
            port map (clk => clk,
                      ce  => ce,
                      d   => z(num_srl17es-1),
                      q   => z(num_srl17es));
    end generate;
    o <= z(num_srl17es);
end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;
entity synth_reg_reg is
    generic (width           : integer := 8;
             latency         : integer := 1);
    port (i       : in std_logic_vector(width-1 downto 0);
          ce      : in std_logic;
          clr     : in std_logic;
          clk     : in std_logic;
          o       : out std_logic_vector(width-1 downto 0));
end synth_reg_reg;
architecture behav of synth_reg_reg is
  type reg_array_type is array (latency-1 downto 0) of std_logic_vector(width -1 downto 0);
  signal reg_bank : reg_array_type := (others => (others => '0'));
  signal reg_bank_in : reg_array_type := (others => (others => '0'));
  attribute syn_allow_retiming : boolean;
  attribute syn_srlstyle : string;
  attribute syn_allow_retiming of reg_bank : signal is true;
  attribute syn_allow_retiming of reg_bank_in : signal is true;
  attribute syn_srlstyle of reg_bank : signal is "registers";
  attribute syn_srlstyle of reg_bank_in : signal is "registers";
begin
  latency_eq_0: if latency = 0 generate
    o <= i;
  end generate latency_eq_0;
  latency_gt_0: if latency >= 1 generate
    o <= reg_bank(latency-1);
    reg_bank_in(0) <= i;
    loop_gen: for idx in latency-2 downto 0 generate
      reg_bank_in(idx+1) <= reg_bank(idx);
    end generate loop_gen;
    sync_loop: for sync_idx in latency-1 downto 0 generate
      sync_proc: process (clk)
      begin
        if clk'event and clk = '1' then
          if ce = '1'  then
            reg_bank(sync_idx) <= reg_bank_in(sync_idx);
          end if;
        end if;
      end process sync_proc;
    end generate sync_loop;
  end generate latency_gt_0;
end behav;

-------------------------------------------------------------------
-- System Generator version 10.1.2 VHDL source file.
--
-- Copyright(C) 2008 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2008 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
-- synopsys translate_off
library unisim;
use unisim.vcomponents.all;
-- synopsys translate_on
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;
entity single_reg_w_init is
  generic (
    width: integer := 8;
    init_index: integer := 0;
    init_value: bit_vector := b"0000"
  );
  port (
    i: in std_logic_vector(width - 1 downto 0);
    ce: in std_logic;
    clr: in std_logic;
    clk: in std_logic;
    o: out std_logic_vector(width - 1 downto 0)
  );
end single_reg_w_init;
architecture structural of single_reg_w_init is
  function build_init_const(width: integer;
                            init_index: integer;
                            init_value: bit_vector)
    return std_logic_vector
  is
    variable result: std_logic_vector(width - 1 downto 0);
  begin
    if init_index = 0 then
      result := (others => '0');
    elsif init_index = 1 then
      result := (others => '0');
      result(0) := '1';
    else
      result := to_stdlogicvector(init_value);
    end if;
    return result;
  end;
  component fdre
    port (
      q: out std_ulogic;
      d: in  std_ulogic;
      c: in  std_ulogic;
      ce: in  std_ulogic;
      r: in  std_ulogic
    );
  end component;
  attribute syn_black_box of fdre: component is true;
  attribute fpga_dont_touch of fdre: component is "true";
  component fdse
    port (
      q: out std_ulogic;
      d: in  std_ulogic;
      c: in  std_ulogic;
      ce: in  std_ulogic;
      s: in  std_ulogic
    );
  end component;
  attribute syn_black_box of fdse: component is true;
  attribute fpga_dont_touch of fdse: component is "true";
  constant init_const: std_logic_vector(width - 1 downto 0)
    := build_init_const(width, init_index, init_value);
begin
  fd_prim_array: for index in 0 to width - 1 generate
    bit_is_0: if (init_const(index) = '0') generate
      fdre_comp: fdre
        port map (
          c => clk,
          d => i(index),
          q => o(index),
          ce => ce,
          r => clr
        );
    end generate;
    bit_is_1: if (init_const(index) = '1') generate
      fdse_comp: fdse
        port map (
          c => clk,
          d => i(index),
          q => o(index),
          ce => ce,
          s => clr
        );
    end generate;
  end generate;
end architecture structural;
-- synopsys translate_off
library unisim;
use unisim.vcomponents.all;
-- synopsys translate_on
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;
entity synth_reg_w_init is
  generic (
    width: integer := 8;
    init_index: integer := 0;
    init_value: bit_vector := b"0000";
    latency: integer := 1
  );
  port (
    i: in std_logic_vector(width - 1 downto 0);
    ce: in std_logic;
    clr: in std_logic;
    clk: in std_logic;
    o: out std_logic_vector(width - 1 downto 0)
  );
end synth_reg_w_init;
architecture structural of synth_reg_w_init is
  component single_reg_w_init
    generic (
      width: integer := 8;
      init_index: integer := 0;
      init_value: bit_vector := b"0000"
    );
    port (
      i: in std_logic_vector(width - 1 downto 0);
      ce: in std_logic;
      clr: in std_logic;
      clk: in std_logic;
      o: out std_logic_vector(width - 1 downto 0)
    );
  end component;
  signal dly_i: std_logic_vector((latency + 1) * width - 1 downto 0);
  signal dly_clr: std_logic;
begin
  latency_eq_0: if (latency = 0) generate
    o <= i;
  end generate;
  latency_gt_0: if (latency >= 1) generate
    dly_i((latency + 1) * width - 1 downto latency * width) <= i
      after 200 ps;
    dly_clr <= clr after 200 ps;
    fd_array: for index in latency downto 1 generate
       reg_comp: single_reg_w_init
          generic map (
            width => width,
            init_index => init_index,
            init_value => init_value
          )
          port map (
            clk => clk,
            i => dly_i((index + 1) * width - 1 downto index * width),
            o => dly_i(index * width - 1 downto (index - 1) * width),
            ce => ce,
            clr => dly_clr
          );
    end generate;
    o <= dly_i(width - 1 downto 0);
  end generate;
end structural;

-------------------------------------------------------------------
-- System Generator version 10.1.2 VHDL source file.
--
-- Copyright(C) 2008 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2008 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;
entity convert_func_call is
    generic (
        din_width    : integer := 16;
        din_bin_pt   : integer := 4;
        din_arith    : integer := xlUnsigned;
        dout_width   : integer := 8;
        dout_bin_pt  : integer := 2;
        dout_arith   : integer := xlUnsigned;
        quantization : integer := xlTruncate;
        overflow     : integer := xlWrap);
    port (
        din : in std_logic_vector (din_width-1 downto 0);
        result : out std_logic_vector (dout_width-1 downto 0));
end convert_func_call;
architecture behavior of convert_func_call is
begin
    result <= convert_type(din, din_width, din_bin_pt, din_arith,
                           dout_width, dout_bin_pt, dout_arith,
                           quantization, overflow);
end behavior;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;
entity xlconvert is
    generic (
        din_width    : integer := 16;
        din_bin_pt   : integer := 4;
        din_arith    : integer := xlUnsigned;
        dout_width   : integer := 8;
        dout_bin_pt  : integer := 2;
        dout_arith   : integer := xlUnsigned;
        bool_conversion : integer :=0;
        latency      : integer := 0;
        quantization : integer := xlTruncate;
        overflow     : integer := xlWrap);
    port (
        din : in std_logic_vector (din_width-1 downto 0);
        ce  : in std_logic;
        clr : in std_logic;
        clk : in std_logic;
        dout : out std_logic_vector (dout_width-1 downto 0));
end xlconvert;
architecture behavior of xlconvert is
    component synth_reg
        generic (width       : integer;
                 latency     : integer);
        port (i           : in std_logic_vector(width-1 downto 0);
              ce      : in std_logic;
              clr     : in std_logic;
              clk     : in std_logic;
              o       : out std_logic_vector(width-1 downto 0));
    end component;
    component convert_func_call
        generic (
            din_width    : integer := 16;
            din_bin_pt   : integer := 4;
            din_arith    : integer := xlUnsigned;
            dout_width   : integer := 8;
            dout_bin_pt  : integer := 2;
            dout_arith   : integer := xlUnsigned;
            quantization : integer := xlTruncate;
            overflow     : integer := xlWrap);
        port (
            din : in std_logic_vector (din_width-1 downto 0);
            result : out std_logic_vector (dout_width-1 downto 0));
    end component;
    -- synopsys translate_off
    signal real_din, real_dout : real;
    -- synopsys translate_on
    signal result : std_logic_vector(dout_width-1 downto 0);
begin
    -- synopsys translate_off
    -- synopsys translate_on
    bool_conversion_generate : if (bool_conversion = 1)
    generate
      result <= din;
    end generate;
    std_conversion_generate : if (bool_conversion = 0)
    generate
      convert : convert_func_call
        generic map (
          din_width   => din_width,
          din_bin_pt  => din_bin_pt,
          din_arith   => din_arith,
          dout_width  => dout_width,
          dout_bin_pt => dout_bin_pt,
          dout_arith  => dout_arith,
          quantization => quantization,
          overflow     => overflow)
        port map (
          din => din,
          result => result);
    end generate;
    latency_test : if (latency > 0)
    generate
        reg : synth_reg
            generic map ( width => dout_width,
                          latency => latency)
            port map (i => result,
                      ce => ce,
                      clr => clr,
                      clk => clk,
                      o => dout);
    end generate;
    latency0 : if (latency = 0)
    generate
        dout <= result;
    end generate latency0;
end  behavior;

-------------------------------------------------------------------
-- System Generator version 10.1.2 VHDL source file.
--
-- Copyright(C) 2008 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2008 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
-- synopsys translate_off
library XilinxCoreLib;
-- synopsys translate_on
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;
entity xlcounter_free is
  generic (
    core_name0: string := "";
    op_width: integer := 5;
    op_arith: integer := xlSigned
  );
  port (
    ce: in std_logic;
    clr: in std_logic;
    clk: in std_logic;
    op: out std_logic_vector(op_width - 1 downto 0);
    up: in std_logic_vector(0 downto 0) := (others => '0');
    load: in std_logic_vector(0 downto 0) := (others => '0');
    din: in std_logic_vector(op_width - 1 downto 0) := (others => '0');
    en: in std_logic_vector(0 downto 0);
    rst: in std_logic_vector(0 downto 0)
  );
end xlcounter_free ;
architecture behavior of xlcounter_free is
  component binary_counter_virtex2p_7_0_950e4ab582797264
    port (
      clk: in std_logic;
      ce: in std_logic;
      sinit: in std_logic;
      q: out std_logic_vector(op_width - 1 downto 0)
    );
  end component;
  attribute syn_black_box of binary_counter_virtex2p_7_0_950e4ab582797264:
    component is true;
  attribute fpga_dont_touch of binary_counter_virtex2p_7_0_950e4ab582797264:
    component is "true";
  attribute box_type of binary_counter_virtex2p_7_0_950e4ab582797264:
    component  is "black_box";
  component binary_counter_virtex2p_7_0_b0a257f5389d649a
    port (
      clk: in std_logic;
      ce: in std_logic;
      sinit: in std_logic;
      q: out std_logic_vector(op_width - 1 downto 0)
    );
  end component;
  attribute syn_black_box of binary_counter_virtex2p_7_0_b0a257f5389d649a:
    component is true;
  attribute fpga_dont_touch of binary_counter_virtex2p_7_0_b0a257f5389d649a:
    component is "true";
  attribute box_type of binary_counter_virtex2p_7_0_b0a257f5389d649a:
    component  is "black_box";
  component binary_counter_virtex2p_7_0_b511f9871581ee23
    port (
      clk: in std_logic;
      ce: in std_logic;
      sinit: in std_logic;
      load: in std_logic;
      l: in std_logic_vector(op_width - 1 downto 0);
      q: out std_logic_vector(op_width - 1 downto 0)
    );
  end component;
  attribute syn_black_box of binary_counter_virtex2p_7_0_b511f9871581ee23:
    component is true;
  attribute fpga_dont_touch of binary_counter_virtex2p_7_0_b511f9871581ee23:
    component is "true";
  attribute box_type of binary_counter_virtex2p_7_0_b511f9871581ee23:
    component  is "black_box";
  component binary_counter_virtex2p_7_0_a22528b4c55dc1cd
    port (
      clk: in std_logic;
      ce: in std_logic;
      sinit: in std_logic;
      q: out std_logic_vector(op_width - 1 downto 0)
    );
  end component;
  attribute syn_black_box of binary_counter_virtex2p_7_0_a22528b4c55dc1cd:
    component is true;
  attribute fpga_dont_touch of binary_counter_virtex2p_7_0_a22528b4c55dc1cd:
    component is "true";
  attribute box_type of binary_counter_virtex2p_7_0_a22528b4c55dc1cd:
    component  is "black_box";
  component binary_counter_virtex2p_7_0_77cea312f82499f0
    port (
      clk: in std_logic;
      ce: in std_logic;
      sinit: in std_logic;
      load: in std_logic;
      l: in std_logic_vector(op_width - 1 downto 0);
      q: out std_logic_vector(op_width - 1 downto 0)
    );
  end component;
  attribute syn_black_box of binary_counter_virtex2p_7_0_77cea312f82499f0:
    component is true;
  attribute fpga_dont_touch of binary_counter_virtex2p_7_0_77cea312f82499f0:
    component is "true";
  attribute box_type of binary_counter_virtex2p_7_0_77cea312f82499f0:
    component  is "black_box";
-- synopsys translate_off
  constant zeroVec: std_logic_vector(op_width - 1 downto 0) := (others => '0');
  constant oneVec: std_logic_vector(op_width - 1 downto 0) := (others => '1');
  constant zeroStr: string(1 to op_width) :=
    std_logic_vector_to_bin_string(zeroVec);
  constant oneStr: string(1 to op_width) :=
    std_logic_vector_to_bin_string(oneVec);
-- synopsys translate_on
  signal core_sinit: std_logic;
  signal core_ce: std_logic;
  signal op_net: std_logic_vector(op_width - 1 downto 0);
begin
  core_ce <= ce and en(0);
  core_sinit <= (clr or rst(0)) and ce;
  op <= op_net;
  comp0: if ((core_name0 = "binary_counter_virtex2p_7_0_950e4ab582797264")) generate
    core_instance0: binary_counter_virtex2p_7_0_950e4ab582797264
      port map (
        clk => clk,
        ce => core_ce,
        sinit => core_sinit,
        q => op_net
      );
  end generate;
  comp1: if ((core_name0 = "binary_counter_virtex2p_7_0_b0a257f5389d649a")) generate
    core_instance1: binary_counter_virtex2p_7_0_b0a257f5389d649a
      port map (
        clk => clk,
        ce => core_ce,
        sinit => core_sinit,
        q => op_net
      );
  end generate;
  comp2: if ((core_name0 = "binary_counter_virtex2p_7_0_b511f9871581ee23")) generate
    core_instance2: binary_counter_virtex2p_7_0_b511f9871581ee23
      port map (
        clk => clk,
        ce => core_ce,
        sinit => core_sinit,
        load => load(0),
        l => din,
        q => op_net
      );
  end generate;
  comp3: if ((core_name0 = "binary_counter_virtex2p_7_0_a22528b4c55dc1cd")) generate
    core_instance3: binary_counter_virtex2p_7_0_a22528b4c55dc1cd
      port map (
        clk => clk,
        ce => core_ce,
        sinit => core_sinit,
        q => op_net
      );
  end generate;
  comp4: if ((core_name0 = "binary_counter_virtex2p_7_0_77cea312f82499f0")) generate
    core_instance4: binary_counter_virtex2p_7_0_77cea312f82499f0
      port map (
        clk => clk,
        ce => core_ce,
        sinit => core_sinit,
        load => load(0),
        l => din,
        q => op_net
      );
  end generate;
end behavior;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity inverter_e2b989a05e is
  port (
    ip : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end inverter_e2b989a05e;


architecture behavior of inverter_e2b989a05e is
  signal ip_1_26: unsigned((1 - 1) downto 0);
  type array_type_op_mem_22_20 is array (0 to (1 - 1)) of unsigned((1 - 1) downto 0);
  signal op_mem_22_20: array_type_op_mem_22_20 := (
    0 => "0");
  signal op_mem_22_20_front_din: unsigned((1 - 1) downto 0);
  signal op_mem_22_20_back: unsigned((1 - 1) downto 0);
  signal op_mem_22_20_push_front_pop_back_en: std_logic;
  signal internal_ip_12_1_bitnot: unsigned((1 - 1) downto 0);
begin
  ip_1_26 <= std_logic_vector_to_unsigned(ip);
  op_mem_22_20_back <= op_mem_22_20(0);
  proc_op_mem_22_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_22_20_push_front_pop_back_en = '1')) then
        op_mem_22_20(0) <= op_mem_22_20_front_din;
      end if;
    end if;
  end process proc_op_mem_22_20;
  internal_ip_12_1_bitnot <= std_logic_vector_to_unsigned(not unsigned_to_std_logic_vector(ip_1_26));
  op_mem_22_20_push_front_pop_back_en <= '0';
  op <= unsigned_to_std_logic_vector(internal_ip_12_1_bitnot);
end behavior;


-------------------------------------------------------------------
-- System Generator version 10.1.2 VHDL source file.
--
-- Copyright(C) 2008 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2008 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
-- synopsys translate_off
library XilinxCoreLib;
-- synopsys translate_on
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.conv_pkg.all;
entity xlmult_v9_0 is
  generic (
    core_name0: string := "";
    a_width: integer := 4;
    a_bin_pt: integer := 2;
    a_arith: integer := xlSigned;
    b_width: integer := 4;
    b_bin_pt: integer := 1;
    b_arith: integer := xlSigned;
    p_width: integer := 8;
    p_bin_pt: integer := 2;
    p_arith: integer := xlSigned;
    rst_width: integer := 1;
    rst_bin_pt: integer := 0;
    rst_arith: integer := xlUnsigned;
    en_width: integer := 1;
    en_bin_pt: integer := 0;
    en_arith: integer := xlUnsigned;
    quantization: integer := xlTruncate;
    overflow: integer := xlWrap;
    extra_registers: integer := 0;
    c_a_width: integer := 7;
    c_b_width: integer := 7;
    c_type: integer := 0;
    c_a_type: integer := 0;
    c_b_type: integer := 0;
    c_pipelined: integer := 1;
    c_baat: integer := 4;
    multsign: integer := xlSigned;
    c_output_width: integer := 16
  );
  port (
    a: in std_logic_vector(a_width - 1 downto 0);
    b: in std_logic_vector(b_width - 1 downto 0);
    ce: in std_logic;
    clr: in std_logic;
    clk: in std_logic;
    core_ce: in std_logic := '0';
    core_clr: in std_logic := '0';
    core_clk: in std_logic := '0';
    rst: in std_logic_vector(rst_width - 1 downto 0);
    en: in std_logic_vector(en_width - 1 downto 0);
    p: out std_logic_vector(p_width - 1 downto 0)
  );
end xlmult_v9_0 ;
architecture behavior of xlmult_v9_0 is
  component synth_reg
    generic (
      width: integer := 16;
      latency: integer := 5
    );
    port (
      i: in std_logic_vector(width - 1 downto 0);
      ce: in std_logic;
      clr: in std_logic;
      clk: in std_logic;
      o: out std_logic_vector(width - 1 downto 0)
    );
  end component;
  component multiplier_virtex2p_10_1_817edd563258bb47
    port (
      b: in std_logic_vector(c_b_width - 1 downto 0);
      p: out std_logic_vector(c_output_width - 1 downto 0);
      clk: in std_logic;
      ce: in std_logic;
      sclr: in std_logic;
      a: in std_logic_vector(c_a_width - 1 downto 0)
    );
  end component;
  attribute syn_black_box of multiplier_virtex2p_10_1_817edd563258bb47:
    component is true;
  attribute fpga_dont_touch of multiplier_virtex2p_10_1_817edd563258bb47:
    component is "true";
  attribute box_type of multiplier_virtex2p_10_1_817edd563258bb47:
    component  is "black_box";
  signal tmp_a: std_logic_vector(c_a_width - 1 downto 0);
  signal conv_a: std_logic_vector(c_a_width - 1 downto 0);
  signal tmp_b: std_logic_vector(c_b_width - 1 downto 0);
  signal conv_b: std_logic_vector(c_b_width - 1 downto 0);
  signal tmp_p: std_logic_vector(c_output_width - 1 downto 0);
  signal conv_p: std_logic_vector(p_width - 1 downto 0);
  -- synopsys translate_off
  signal real_a, real_b, real_p: real;
  -- synopsys translate_on
  signal rfd: std_logic;
  signal rdy: std_logic;
  signal nd: std_logic;
  signal internal_ce: std_logic;
  signal internal_clr: std_logic;
  signal internal_core_ce: std_logic;
begin
-- synopsys translate_off
-- synopsys translate_on
  internal_ce <= ce and en(0);
  internal_core_ce <= core_ce and en(0);
  internal_clr <= (clr or rst(0)) and ce;
  nd <= internal_ce;
  input_process:  process (a,b)
  begin
    tmp_a <= zero_ext(a, c_a_width);
    tmp_b <= zero_ext(b, c_b_width);
  end process;
  output_process: process (tmp_p)
  begin
    conv_p <= convert_type(tmp_p, c_output_width, a_bin_pt+b_bin_pt, multsign,
                           p_width, p_bin_pt, p_arith, quantization, overflow);
  end process;
  comp0: if ((core_name0 = "multiplier_virtex2p_10_1_817edd563258bb47")) generate
    core_instance0: multiplier_virtex2p_10_1_817edd563258bb47
      port map (
        a => tmp_a,
        clk => clk,
        ce => internal_ce,
        sclr => internal_clr,
        p => tmp_p,
        b => tmp_b
      );
  end generate;
  latency_gt_0: if (extra_registers > 0) generate
    reg: synth_reg
      generic map (
        width => p_width,
        latency => extra_registers
      )
      port map (
        i => conv_p,
        ce => internal_ce,
        clr => internal_clr,
        clk => clk,
        o => p
      );
  end generate;
  latency_eq_0: if (extra_registers = 0) generate
    p <= conv_p;
  end generate;
end architecture behavior;

-------------------------------------------------------------------
-- System Generator version 10.1.2 VHDL source file.
--
-- Copyright(C) 2008 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2008 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;
entity xlregister is
   generic (d_width          : integer := 5;
            init_value       : bit_vector := b"00");
   port (d   : in std_logic_vector (d_width-1 downto 0);
         rst : in std_logic_vector(0 downto 0) := "0";
         en  : in std_logic_vector(0 downto 0) := "1";
         ce  : in std_logic;
         clk : in std_logic;
         q   : out std_logic_vector (d_width-1 downto 0));
end xlregister;
architecture behavior of xlregister is
   component synth_reg_w_init
      generic (width      : integer;
               init_index : integer;
               init_value : bit_vector;
               latency    : integer);
      port (i   : in std_logic_vector(width-1 downto 0);
            ce  : in std_logic;
            clr : in std_logic;
            clk : in std_logic;
            o   : out std_logic_vector(width-1 downto 0));
   end component;
   -- synopsys translate_off
   signal real_d, real_q           : real;
   -- synopsys translate_on
   signal internal_clr             : std_logic;
   signal internal_ce              : std_logic;
begin
   internal_clr <= rst(0) and ce;
   internal_ce  <= en(0) and ce;
   synth_reg_inst : synth_reg_w_init
      generic map (width      => d_width,
                   init_index => 2,
                   init_value => init_value,
                   latency    => 1)
      port map (i   => d,
                ce  => internal_ce,
                clr => internal_clr,
                clk => clk,
                o   => q);
end architecture behavior;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity relational_4e76b03051 is
  port (
    a : in std_logic_vector((18 - 1) downto 0);
    b : in std_logic_vector((18 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end relational_4e76b03051;


architecture behavior of relational_4e76b03051 is
  signal a_1_31: unsigned((18 - 1) downto 0);
  signal b_1_34: unsigned((18 - 1) downto 0);
  type array_type_op_mem_32_22 is array (0 to (1 - 1)) of boolean;
  signal op_mem_32_22: array_type_op_mem_32_22 := (
    0 => false);
  signal op_mem_32_22_front_din: boolean;
  signal op_mem_32_22_back: boolean;
  signal op_mem_32_22_push_front_pop_back_en: std_logic;
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  op_mem_32_22_back <= op_mem_32_22(0);
  proc_op_mem_32_22: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_32_22_push_front_pop_back_en = '1')) then
        op_mem_32_22(0) <= op_mem_32_22_front_din;
      end if;
    end if;
  end process proc_op_mem_32_22;
  result_12_3_rel <= a_1_31 = b_1_34;
  op_mem_32_22_front_din <= result_12_3_rel;
  op_mem_32_22_push_front_pop_back_en <= '1';
  op <= boolean_to_vector(op_mem_32_22_back);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity relational_1433264a0c is
  port (
    a : in std_logic_vector((18 - 1) downto 0);
    b : in std_logic_vector((18 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end relational_1433264a0c;


architecture behavior of relational_1433264a0c is
  signal a_1_31: unsigned((18 - 1) downto 0);
  signal b_1_34: unsigned((18 - 1) downto 0);
  type array_type_op_mem_32_22 is array (0 to (1 - 1)) of boolean;
  signal op_mem_32_22: array_type_op_mem_32_22 := (
    0 => false);
  signal op_mem_32_22_front_din: boolean;
  signal op_mem_32_22_back: boolean;
  signal op_mem_32_22_push_front_pop_back_en: std_logic;
  signal result_22_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  op_mem_32_22_back <= op_mem_32_22(0);
  proc_op_mem_32_22: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_32_22_push_front_pop_back_en = '1')) then
        op_mem_32_22(0) <= op_mem_32_22_front_din;
      end if;
    end if;
  end process proc_op_mem_32_22;
  result_22_3_rel <= a_1_31 >= b_1_34;
  op_mem_32_22_front_din <= result_22_3_rel;
  op_mem_32_22_push_front_pop_back_en <= '1';
  op <= boolean_to_vector(op_mem_32_22_back);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity constant_963ed6358a is
  port (
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_963ed6358a;


architecture behavior of constant_963ed6358a is
begin
  op <= "0";
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity mcode_block_8231ed31e4 is
  port (
    plbrst : in std_logic_vector((1 - 1) downto 0);
    plbabus : in std_logic_vector((32 - 1) downto 0);
    plbpavalid : in std_logic_vector((1 - 1) downto 0);
    plbrnw : in std_logic_vector((1 - 1) downto 0);
    plbwrdbus : in std_logic_vector((32 - 1) downto 0);
    rddata : in std_logic_vector((32 - 1) downto 0);
    addrpref : in std_logic_vector((15 - 1) downto 0);
    wrdbusreg : out std_logic_vector((32 - 1) downto 0);
    addrack : out std_logic_vector((1 - 1) downto 0);
    rdcomp : out std_logic_vector((1 - 1) downto 0);
    wrdack : out std_logic_vector((1 - 1) downto 0);
    bankaddr : out std_logic_vector((2 - 1) downto 0);
    rnwreg : out std_logic_vector((1 - 1) downto 0);
    rddack : out std_logic_vector((1 - 1) downto 0);
    rddbus : out std_logic_vector((32 - 1) downto 0);
    linearaddr : out std_logic_vector((13 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end mcode_block_8231ed31e4;


architecture behavior of mcode_block_8231ed31e4 is
  signal plbrst_2_20: unsigned((1 - 1) downto 0);
  signal plbabus_2_28: unsigned((32 - 1) downto 0);
  signal plbpavalid_2_37: unsigned((1 - 1) downto 0);
  signal plbrnw_2_49: unsigned((1 - 1) downto 0);
  signal plbwrdbus_2_57: unsigned((32 - 1) downto 0);
  signal rddata_2_68: unsigned((32 - 1) downto 0);
  signal addrpref_2_76: unsigned((15 - 1) downto 0);
  signal plbrstreg_13_24_next: boolean;
  signal plbrstreg_13_24: boolean := false;
  signal plbabusreg_14_25_next: unsigned((32 - 1) downto 0);
  signal plbabusreg_14_25: unsigned((32 - 1) downto 0) := "00000000000000000000000000000000";
  signal plbpavalidreg_15_28_next: boolean;
  signal plbpavalidreg_15_28: boolean := false;
  signal plbrnwreg_16_24_next: unsigned((1 - 1) downto 0);
  signal plbrnwreg_16_24: unsigned((1 - 1) downto 0) := "0";
  signal plbwrdbusreg_17_27_next: unsigned((32 - 1) downto 0);
  signal plbwrdbusreg_17_27: unsigned((32 - 1) downto 0) := "00000000000000000000000000000000";
  signal avalidreg_29_23_next: boolean;
  signal avalidreg_29_23: boolean := false;
  signal ps1reg_40_20_next: boolean;
  signal ps1reg_40_20: boolean := false;
  signal psreg_48_19_next: boolean;
  signal psreg_48_19: boolean := false;
  type array_type_rdcompdelay_59_25 is array (0 to (3 - 1)) of unsigned((1 - 1) downto 0);
  signal rdcompdelay_59_25: array_type_rdcompdelay_59_25 := (
    "0",
    "0",
    "0");
  signal rdcompdelay_59_25_front_din: unsigned((1 - 1) downto 0);
  signal rdcompdelay_59_25_back: unsigned((1 - 1) downto 0);
  signal rdcompdelay_59_25_push_front_pop_back_en: std_logic;
  signal rdcompreg_63_23_next: unsigned((1 - 1) downto 0);
  signal rdcompreg_63_23: unsigned((1 - 1) downto 0) := "0";
  signal rddackreg_67_23_next: unsigned((1 - 1) downto 0);
  signal rddackreg_67_23: unsigned((1 - 1) downto 0) := "0";
  signal wrdackreg_71_23_next: unsigned((1 - 1) downto 0);
  signal wrdackreg_71_23: unsigned((1 - 1) downto 0) := "0";
  signal rddbusreg_85_23_next: unsigned((32 - 1) downto 0);
  signal rddbusreg_85_23: unsigned((32 - 1) downto 0) := "00000000000000000000000000000000";
  signal bankaddr_21_1_slice: unsigned((2 - 1) downto 0);
  signal linearaddr_22_1_slice: unsigned((13 - 1) downto 0);
  signal addrpref_in_33_1_slice: unsigned((15 - 1) downto 0);
  signal rel_34_4: boolean;
  signal ps1_join_34_1: boolean;
  signal ps_43_1_bit: boolean;
  signal bitnot_50_49: boolean;
  signal bitnot_50_73: boolean;
  signal bit_50_49: boolean;
  signal addrack_50_1_convert: unsigned((1 - 1) downto 0);
  signal bit_56_43: unsigned((1 - 1) downto 0);
  signal bitnot_73_35: unsigned((1 - 1) downto 0);
  signal wrdackreg_73_1_bit: unsigned((1 - 1) downto 0);
  signal rdsel_77_1_bit: unsigned((1 - 1) downto 0);
  signal rel_79_4: boolean;
  signal rddbus1_join_79_1: unsigned((32 - 1) downto 0);
  signal plbwrdbusreg_98_1_slice: unsigned((32 - 1) downto 0);
  signal plbrstreg_13_24_next_x_000000: boolean;
  signal plbpavalidreg_15_28_next_x_000000: boolean;
begin
  plbrst_2_20 <= std_logic_vector_to_unsigned(plbrst);
  plbabus_2_28 <= std_logic_vector_to_unsigned(plbabus);
  plbpavalid_2_37 <= std_logic_vector_to_unsigned(plbpavalid);
  plbrnw_2_49 <= std_logic_vector_to_unsigned(plbrnw);
  plbwrdbus_2_57 <= std_logic_vector_to_unsigned(plbwrdbus);
  rddata_2_68 <= std_logic_vector_to_unsigned(rddata);
  addrpref_2_76 <= std_logic_vector_to_unsigned(addrpref);
  proc_plbrstreg_13_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        plbrstreg_13_24 <= plbrstreg_13_24_next;
      end if;
    end if;
  end process proc_plbrstreg_13_24;
  proc_plbabusreg_14_25: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        plbabusreg_14_25 <= plbabusreg_14_25_next;
      end if;
    end if;
  end process proc_plbabusreg_14_25;
  proc_plbpavalidreg_15_28: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        plbpavalidreg_15_28 <= plbpavalidreg_15_28_next;
      end if;
    end if;
  end process proc_plbpavalidreg_15_28;
  proc_plbrnwreg_16_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        plbrnwreg_16_24 <= plbrnwreg_16_24_next;
      end if;
    end if;
  end process proc_plbrnwreg_16_24;
  proc_plbwrdbusreg_17_27: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        plbwrdbusreg_17_27 <= plbwrdbusreg_17_27_next;
      end if;
    end if;
  end process proc_plbwrdbusreg_17_27;
  proc_avalidreg_29_23: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        avalidreg_29_23 <= avalidreg_29_23_next;
      end if;
    end if;
  end process proc_avalidreg_29_23;
  proc_ps1reg_40_20: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        ps1reg_40_20 <= ps1reg_40_20_next;
      end if;
    end if;
  end process proc_ps1reg_40_20;
  proc_psreg_48_19: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        psreg_48_19 <= psreg_48_19_next;
      end if;
    end if;
  end process proc_psreg_48_19;
  rdcompdelay_59_25_back <= rdcompdelay_59_25(2);
  proc_rdcompdelay_59_25: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (rdcompdelay_59_25_push_front_pop_back_en = '1')) then
        for i in 2 downto 1 loop 
          rdcompdelay_59_25(i) <= rdcompdelay_59_25(i-1);
        end loop;
        rdcompdelay_59_25(0) <= rdcompdelay_59_25_front_din;
      end if;
    end if;
  end process proc_rdcompdelay_59_25;
  proc_rdcompreg_63_23: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        rdcompreg_63_23 <= rdcompreg_63_23_next;
      end if;
    end if;
  end process proc_rdcompreg_63_23;
  proc_rddackreg_67_23: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        rddackreg_67_23 <= rddackreg_67_23_next;
      end if;
    end if;
  end process proc_rddackreg_67_23;
  proc_wrdackreg_71_23: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        wrdackreg_71_23 <= wrdackreg_71_23_next;
      end if;
    end if;
  end process proc_wrdackreg_71_23;
  proc_rddbusreg_85_23: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        rddbusreg_85_23 <= rddbusreg_85_23_next;
      end if;
    end if;
  end process proc_rddbusreg_85_23;
  bankaddr_21_1_slice <= u2u_slice(plbabusreg_14_25, 16, 15);
  linearaddr_22_1_slice <= u2u_slice(plbabusreg_14_25, 14, 2);
  addrpref_in_33_1_slice <= u2u_slice(plbabusreg_14_25, 31, 17);
  rel_34_4 <= addrpref_in_33_1_slice = addrpref_2_76;
  proc_if_34_1: process (rel_34_4)
  is
  begin
    if rel_34_4 then
      ps1_join_34_1 <= true;
    else 
      ps1_join_34_1 <= false;
    end if;
  end process proc_if_34_1;
  ps_43_1_bit <= ((boolean_to_vector(ps1_join_34_1) and boolean_to_vector(plbpavalidreg_15_28)) = "1");
  bitnot_50_49 <= ((not boolean_to_vector(plbrstreg_13_24)) = "1");
  bitnot_50_73 <= ((not boolean_to_vector(psreg_48_19)) = "1");
  bit_50_49 <= ((boolean_to_vector(bitnot_50_49) and boolean_to_vector(ps_43_1_bit) and boolean_to_vector(bitnot_50_73)) = "1");
  addrack_50_1_convert <= u2u_cast(std_logic_vector_to_unsigned(boolean_to_vector(bit_50_49)), 0, 1, 0);
  bit_56_43 <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(addrack_50_1_convert) and unsigned_to_std_logic_vector(plbrnwreg_16_24));
  bitnot_73_35 <= std_logic_vector_to_unsigned(not unsigned_to_std_logic_vector(plbrnwreg_16_24));
  wrdackreg_73_1_bit <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(addrack_50_1_convert) and unsigned_to_std_logic_vector(bitnot_73_35));
  rdsel_77_1_bit <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(rdcompdelay_59_25_back) or unsigned_to_std_logic_vector(rdcompreg_63_23));
  rel_79_4 <= rdsel_77_1_bit = std_logic_vector_to_unsigned("1");
  proc_if_79_1: process (rddata_2_68, rel_79_4)
  is
  begin
    if rel_79_4 then
      rddbus1_join_79_1 <= rddata_2_68;
    else 
      rddbus1_join_79_1 <= std_logic_vector_to_unsigned("00000000000000000000000000000000");
    end if;
  end process proc_if_79_1;
  plbwrdbusreg_98_1_slice <= u2u_slice(plbwrdbus_2_57, 31, 0);
  plbrstreg_13_24_next_x_000000 <= (plbrst_2_20 /= "0");
  plbrstreg_13_24_next <= plbrstreg_13_24_next_x_000000;
  plbabusreg_14_25_next <= plbabus_2_28;
  plbpavalidreg_15_28_next_x_000000 <= (plbpavalid_2_37 /= "0");
  plbpavalidreg_15_28_next <= plbpavalidreg_15_28_next_x_000000;
  plbrnwreg_16_24_next <= plbrnw_2_49;
  plbwrdbusreg_17_27_next <= plbwrdbusreg_98_1_slice;
  avalidreg_29_23_next <= plbpavalidreg_15_28;
  ps1reg_40_20_next <= ps1_join_34_1;
  psreg_48_19_next <= ps_43_1_bit;
  rdcompdelay_59_25_front_din <= bit_56_43;
  rdcompdelay_59_25_push_front_pop_back_en <= '1';
  rdcompreg_63_23_next <= rdcompdelay_59_25_back;
  rddackreg_67_23_next <= rdcompreg_63_23;
  wrdackreg_71_23_next <= wrdackreg_73_1_bit;
  rddbusreg_85_23_next <= rddbus1_join_79_1;
  wrdbusreg <= unsigned_to_std_logic_vector(plbwrdbusreg_17_27);
  addrack <= unsigned_to_std_logic_vector(addrack_50_1_convert);
  rdcomp <= unsigned_to_std_logic_vector(rdcompreg_63_23);
  wrdack <= unsigned_to_std_logic_vector(wrdackreg_71_23);
  bankaddr <= unsigned_to_std_logic_vector(bankaddr_21_1_slice);
  rnwreg <= unsigned_to_std_logic_vector(plbrnwreg_16_24);
  rddack <= unsigned_to_std_logic_vector(rddackreg_67_23);
  rddbus <= unsigned_to_std_logic_vector(rddbusreg_85_23);
  linearaddr <= unsigned_to_std_logic_vector(linearaddr_22_1_slice);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity mcode_block_66f25059c9 is
  port (
    wrdbus : in std_logic_vector((32 - 1) downto 0);
    bankaddr : in std_logic_vector((2 - 1) downto 0);
    linearaddr : in std_logic_vector((13 - 1) downto 0);
    rnwreg : in std_logic_vector((1 - 1) downto 0);
    addrack : in std_logic_vector((1 - 1) downto 0);
    sm_buttons_big : in std_logic_vector((2 - 1) downto 0);
    sm_buttons_small : in std_logic_vector((6 - 1) downto 0);
    sm_dip_switch : in std_logic_vector((4 - 1) downto 0);
    sm_trackball : in std_logic_vector((5 - 1) downto 0);
    sm_buzzer_dutycycle : in std_logic_vector((18 - 1) downto 0);
    sm_buzzer_enable : in std_logic_vector((1 - 1) downto 0);
    sm_buzzer_period : in std_logic_vector((18 - 1) downto 0);
    sm_lcd_backgroundcolor : in std_logic_vector((9 - 1) downto 0);
    sm_lcd_characteroffset : in std_logic_vector((4 - 1) downto 0);
    sm_lcd_charactersselect : in std_logic_vector((3 - 1) downto 0);
    sm_lcd_colset : in std_logic_vector((9 - 1) downto 0);
    sm_lcd_configlocation : in std_logic_vector((2 - 1) downto 0);
    sm_lcd_dividerselect : in std_logic_vector((1 - 1) downto 0);
    sm_lcd_firstend : in std_logic_vector((9 - 1) downto 0);
    sm_lcd_firststart : in std_logic_vector((9 - 1) downto 0);
    sm_lcd_lineoffset : in std_logic_vector((4 - 1) downto 0);
    sm_lcd_ramwrite : in std_logic_vector((9 - 1) downto 0);
    sm_lcd_reset : in std_logic_vector((1 - 1) downto 0);
    sm_lcd_resetlcd : in std_logic_vector((1 - 1) downto 0);
    sm_lcd_rowset : in std_logic_vector((9 - 1) downto 0);
    sm_lcd_secondend : in std_logic_vector((9 - 1) downto 0);
    sm_lcd_secondstart : in std_logic_vector((9 - 1) downto 0);
    sm_lcd_send : in std_logic_vector((1 - 1) downto 0);
    sm_lcd_totalcmdtransfer : in std_logic_vector((8 - 1) downto 0);
    sm_leds : in std_logic_vector((8 - 1) downto 0);
    sm_lcd_charactermap : in std_logic_vector((32 - 1) downto 0);
    sm_lcd_characters : in std_logic_vector((32 - 1) downto 0);
    sm_lcd_commands : in std_logic_vector((32 - 1) downto 0);
    read_bank_out : out std_logic_vector((32 - 1) downto 0);
    sm_buzzer_dutycycle_din : out std_logic_vector((18 - 1) downto 0);
    sm_buzzer_dutycycle_en : out std_logic_vector((1 - 1) downto 0);
    sm_buzzer_enable_din : out std_logic_vector((1 - 1) downto 0);
    sm_buzzer_enable_en : out std_logic_vector((1 - 1) downto 0);
    sm_buzzer_period_din : out std_logic_vector((18 - 1) downto 0);
    sm_buzzer_period_en : out std_logic_vector((1 - 1) downto 0);
    sm_lcd_backgroundcolor_din : out std_logic_vector((9 - 1) downto 0);
    sm_lcd_backgroundcolor_en : out std_logic_vector((1 - 1) downto 0);
    sm_lcd_characteroffset_din : out std_logic_vector((4 - 1) downto 0);
    sm_lcd_characteroffset_en : out std_logic_vector((1 - 1) downto 0);
    sm_lcd_charactersselect_din : out std_logic_vector((3 - 1) downto 0);
    sm_lcd_charactersselect_en : out std_logic_vector((1 - 1) downto 0);
    sm_lcd_colset_din : out std_logic_vector((9 - 1) downto 0);
    sm_lcd_colset_en : out std_logic_vector((1 - 1) downto 0);
    sm_lcd_configlocation_din : out std_logic_vector((2 - 1) downto 0);
    sm_lcd_configlocation_en : out std_logic_vector((1 - 1) downto 0);
    sm_lcd_dividerselect_din : out std_logic_vector((1 - 1) downto 0);
    sm_lcd_dividerselect_en : out std_logic_vector((1 - 1) downto 0);
    sm_lcd_firstend_din : out std_logic_vector((9 - 1) downto 0);
    sm_lcd_firstend_en : out std_logic_vector((1 - 1) downto 0);
    sm_lcd_firststart_din : out std_logic_vector((9 - 1) downto 0);
    sm_lcd_firststart_en : out std_logic_vector((1 - 1) downto 0);
    sm_lcd_lineoffset_din : out std_logic_vector((4 - 1) downto 0);
    sm_lcd_lineoffset_en : out std_logic_vector((1 - 1) downto 0);
    sm_lcd_ramwrite_din : out std_logic_vector((9 - 1) downto 0);
    sm_lcd_ramwrite_en : out std_logic_vector((1 - 1) downto 0);
    sm_lcd_reset_din : out std_logic_vector((1 - 1) downto 0);
    sm_lcd_reset_en : out std_logic_vector((1 - 1) downto 0);
    sm_lcd_resetlcd_din : out std_logic_vector((1 - 1) downto 0);
    sm_lcd_resetlcd_en : out std_logic_vector((1 - 1) downto 0);
    sm_lcd_rowset_din : out std_logic_vector((9 - 1) downto 0);
    sm_lcd_rowset_en : out std_logic_vector((1 - 1) downto 0);
    sm_lcd_secondend_din : out std_logic_vector((9 - 1) downto 0);
    sm_lcd_secondend_en : out std_logic_vector((1 - 1) downto 0);
    sm_lcd_secondstart_din : out std_logic_vector((9 - 1) downto 0);
    sm_lcd_secondstart_en : out std_logic_vector((1 - 1) downto 0);
    sm_lcd_send_din : out std_logic_vector((1 - 1) downto 0);
    sm_lcd_send_en : out std_logic_vector((1 - 1) downto 0);
    sm_lcd_totalcmdtransfer_din : out std_logic_vector((8 - 1) downto 0);
    sm_lcd_totalcmdtransfer_en : out std_logic_vector((1 - 1) downto 0);
    sm_leds_din : out std_logic_vector((8 - 1) downto 0);
    sm_leds_en : out std_logic_vector((1 - 1) downto 0);
    sm_lcd_charactermap_addr : out std_logic_vector((12 - 1) downto 0);
    sm_lcd_charactermap_din : out std_logic_vector((32 - 1) downto 0);
    sm_lcd_charactermap_we : out std_logic_vector((1 - 1) downto 0);
    sm_lcd_characters_addr : out std_logic_vector((9 - 1) downto 0);
    sm_lcd_characters_din : out std_logic_vector((32 - 1) downto 0);
    sm_lcd_characters_we : out std_logic_vector((1 - 1) downto 0);
    sm_lcd_commands_addr : out std_logic_vector((8 - 1) downto 0);
    sm_lcd_commands_din : out std_logic_vector((32 - 1) downto 0);
    sm_lcd_commands_we : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end mcode_block_66f25059c9;


architecture behavior of mcode_block_66f25059c9 is
  signal wrdbus_1_1186: unsigned((32 - 1) downto 0);
  signal bankaddr_1_1194: unsigned((2 - 1) downto 0);
  signal linearaddr_1_1204: unsigned((13 - 1) downto 0);
  signal rnwreg_1_1216: unsigned((1 - 1) downto 0);
  signal addrack_1_1224: unsigned((1 - 1) downto 0);
  signal sm_buttons_big_1_1233: unsigned((2 - 1) downto 0);
  signal sm_buttons_small_1_1249: unsigned((6 - 1) downto 0);
  signal sm_dip_switch_1_1267: unsigned((4 - 1) downto 0);
  signal sm_trackball_1_1282: unsigned((5 - 1) downto 0);
  signal sm_buzzer_dutycycle_1_1296: unsigned((18 - 1) downto 0);
  signal sm_buzzer_enable_1_1317: unsigned((1 - 1) downto 0);
  signal sm_buzzer_period_1_1335: unsigned((18 - 1) downto 0);
  signal sm_lcd_backgroundcolor_1_1353: unsigned((9 - 1) downto 0);
  signal sm_lcd_characteroffset_1_1377: unsigned((4 - 1) downto 0);
  signal sm_lcd_charactersselect_1_1401: unsigned((3 - 1) downto 0);
  signal sm_lcd_colset_1_1426: unsigned((9 - 1) downto 0);
  signal sm_lcd_configlocation_1_1441: unsigned((2 - 1) downto 0);
  signal sm_lcd_dividerselect_1_1464: unsigned((1 - 1) downto 0);
  signal sm_lcd_firstend_1_1486: unsigned((9 - 1) downto 0);
  signal sm_lcd_firststart_1_1503: unsigned((9 - 1) downto 0);
  signal sm_lcd_lineoffset_1_1522: unsigned((4 - 1) downto 0);
  signal sm_lcd_ramwrite_1_1541: unsigned((9 - 1) downto 0);
  signal sm_lcd_reset_1_1558: unsigned((1 - 1) downto 0);
  signal sm_lcd_resetlcd_1_1572: unsigned((1 - 1) downto 0);
  signal sm_lcd_rowset_1_1589: unsigned((9 - 1) downto 0);
  signal sm_lcd_secondend_1_1604: unsigned((9 - 1) downto 0);
  signal sm_lcd_secondstart_1_1622: unsigned((9 - 1) downto 0);
  signal sm_lcd_send_1_1642: unsigned((1 - 1) downto 0);
  signal sm_lcd_totalcmdtransfer_1_1655: unsigned((8 - 1) downto 0);
  signal sm_leds_1_1680: unsigned((8 - 1) downto 0);
  signal sm_lcd_charactermap_1_1689: unsigned((32 - 1) downto 0);
  signal sm_lcd_characters_1_1710: unsigned((32 - 1) downto 0);
  signal sm_lcd_commands_1_1729: unsigned((32 - 1) downto 0);
  signal reg_bank_out_reg_98_30_next: unsigned((32 - 1) downto 0);
  signal reg_bank_out_reg_98_30: unsigned((32 - 1) downto 0) := "00000000000000000000000000000000";
  signal ram_bank_out_reg_203_30_next: unsigned((32 - 1) downto 0);
  signal ram_bank_out_reg_203_30: unsigned((32 - 1) downto 0) := "00000000000000000000000000000000";
  signal sm_lcd_charactermap_we_reg_226_40_next: boolean;
  signal sm_lcd_charactermap_we_reg_226_40: boolean := false;
  signal sm_lcd_characters_we_reg_245_38_next: boolean;
  signal sm_lcd_characters_we_reg_245_38: boolean := false;
  signal sm_lcd_commands_we_reg_264_36_next: boolean;
  signal sm_lcd_commands_we_reg_264_36: boolean := false;
  signal sm_lcd_charactermap_addr_reg_287_1_next: unsigned((12 - 1) downto 0);
  signal sm_lcd_charactermap_addr_reg_287_1: unsigned((12 - 1) downto 0) := "000000000000";
  signal sm_lcd_charactermap_addr_reg_287_1_en: std_logic;
  signal sm_lcd_characters_addr_reg_295_1_next: unsigned((9 - 1) downto 0);
  signal sm_lcd_characters_addr_reg_295_1: unsigned((9 - 1) downto 0) := "000000000";
  signal sm_lcd_characters_addr_reg_295_1_en: std_logic;
  signal sm_lcd_commands_addr_reg_303_1_next: unsigned((8 - 1) downto 0);
  signal sm_lcd_commands_addr_reg_303_1: unsigned((8 - 1) downto 0) := "00000000";
  signal sm_lcd_commands_addr_reg_303_1_en: std_logic;
  signal read_bank_out_reg_516_31_next: unsigned((32 - 1) downto 0);
  signal read_bank_out_reg_516_31: unsigned((32 - 1) downto 0) := "00000000000000000000000000000000";
  signal bankaddr_reg_519_26_next: unsigned((2 - 1) downto 0);
  signal bankaddr_reg_519_26: unsigned((2 - 1) downto 0) := "00";
  signal rel_101_4: boolean;
  signal rel_103_8: boolean;
  signal rel_105_8: boolean;
  signal rel_107_8: boolean;
  signal rel_109_8: boolean;
  signal rel_111_8: boolean;
  signal rel_113_8: boolean;
  signal rel_115_8: boolean;
  signal rel_117_8: boolean;
  signal rel_119_8: boolean;
  signal rel_121_8: boolean;
  signal rel_123_8: boolean;
  signal rel_125_8: boolean;
  signal rel_127_8: boolean;
  signal rel_129_8: boolean;
  signal rel_131_8: boolean;
  signal rel_133_8: boolean;
  signal rel_135_8: boolean;
  signal rel_137_8: boolean;
  signal rel_139_8: boolean;
  signal rel_141_8: boolean;
  signal rel_143_8: boolean;
  signal rel_145_8: boolean;
  signal rel_147_8: boolean;
  signal rel_149_8: boolean;
  signal reg_bank_out_reg_join_101_1: unsigned((32 - 1) downto 0);
  signal opcode_160_1_concat: unsigned((17 - 1) downto 0);
  signal slice_164_51: unsigned((1 - 1) downto 0);
  signal sm_lcd_charactermap_sel_value_164_1_concat: unsigned((1 - 1) downto 0);
  signal rel_168_4: boolean;
  signal sm_lcd_charactermap_sel_join_168_1: boolean;
  signal slice_176_49: unsigned((4 - 1) downto 0);
  signal sm_lcd_characters_sel_value_176_1_concat: unsigned((4 - 1) downto 0);
  signal rel_180_4: boolean;
  signal sm_lcd_characters_sel_join_180_1: boolean;
  signal slice_188_47: unsigned((5 - 1) downto 0);
  signal sm_lcd_commands_sel_value_188_1_concat: unsigned((5 - 1) downto 0);
  signal rel_192_4: boolean;
  signal sm_lcd_commands_sel_join_192_1: boolean;
  signal ram_bank_out_reg_join_205_1: unsigned((32 - 1) downto 0);
  signal slice_214_44: unsigned((32 - 1) downto 0);
  signal slice_217_42: unsigned((32 - 1) downto 0);
  signal slice_220_40: unsigned((32 - 1) downto 0);
  signal slice_231_46: unsigned((1 - 1) downto 0);
  signal opcode_sm_lcd_charactermap_228_1_concat: unsigned((5 - 1) downto 0);
  signal rel_235_4: boolean;
  signal sm_lcd_charactermap_we_reg_join_235_1: boolean;
  signal slice_250_46: unsigned((4 - 1) downto 0);
  signal opcode_sm_lcd_characters_247_1_concat: unsigned((8 - 1) downto 0);
  signal rel_254_4: boolean;
  signal sm_lcd_characters_we_reg_join_254_1: boolean;
  signal slice_269_46: unsigned((5 - 1) downto 0);
  signal opcode_sm_lcd_commands_266_1_concat: unsigned((9 - 1) downto 0);
  signal rel_273_4: boolean;
  signal sm_lcd_commands_we_reg_join_273_1: boolean;
  signal sm_lcd_charactermap_addr_reg_290_5_slice: unsigned((13 - 1) downto 0);
  signal rel_289_4: boolean;
  signal sm_lcd_charactermap_addr_reg_join_289_1: unsigned((13 - 1) downto 0);
  signal sm_lcd_charactermap_addr_reg_join_289_1_en: std_logic;
  signal sm_lcd_characters_addr_reg_298_5_slice: unsigned((10 - 1) downto 0);
  signal rel_297_4: boolean;
  signal sm_lcd_characters_addr_reg_join_297_1: unsigned((10 - 1) downto 0);
  signal sm_lcd_characters_addr_reg_join_297_1_en: std_logic;
  signal sm_lcd_commands_addr_reg_306_5_slice: unsigned((9 - 1) downto 0);
  signal rel_305_4: boolean;
  signal sm_lcd_commands_addr_reg_join_305_1: unsigned((9 - 1) downto 0);
  signal sm_lcd_commands_addr_reg_join_305_1_en: std_logic;
  signal rel_316_4: boolean;
  signal sm_buzzer_dutycycle_en_join_316_1: boolean;
  signal rel_322_4: boolean;
  signal sm_buzzer_enable_en_join_322_1: boolean;
  signal rel_328_4: boolean;
  signal sm_buzzer_period_en_join_328_1: boolean;
  signal rel_334_4: boolean;
  signal sm_lcd_backgroundcolor_en_join_334_1: boolean;
  signal rel_340_4: boolean;
  signal sm_lcd_characteroffset_en_join_340_1: boolean;
  signal rel_346_4: boolean;
  signal sm_lcd_charactersselect_en_join_346_1: boolean;
  signal rel_352_4: boolean;
  signal sm_lcd_colset_en_join_352_1: boolean;
  signal rel_358_4: boolean;
  signal sm_lcd_configlocation_en_join_358_1: boolean;
  signal rel_364_4: boolean;
  signal sm_lcd_dividerselect_en_join_364_1: boolean;
  signal rel_370_4: boolean;
  signal sm_lcd_firstend_en_join_370_1: boolean;
  signal rel_376_4: boolean;
  signal sm_lcd_firststart_en_join_376_1: boolean;
  signal rel_382_4: boolean;
  signal sm_lcd_lineoffset_en_join_382_1: boolean;
  signal rel_388_4: boolean;
  signal sm_lcd_ramwrite_en_join_388_1: boolean;
  signal rel_394_4: boolean;
  signal sm_lcd_reset_en_join_394_1: boolean;
  signal rel_400_4: boolean;
  signal sm_lcd_resetlcd_en_join_400_1: boolean;
  signal rel_406_4: boolean;
  signal sm_lcd_rowset_en_join_406_1: boolean;
  signal rel_412_4: boolean;
  signal sm_lcd_secondend_en_join_412_1: boolean;
  signal rel_418_4: boolean;
  signal sm_lcd_secondstart_en_join_418_1: boolean;
  signal rel_424_4: boolean;
  signal sm_lcd_send_en_join_424_1: boolean;
  signal rel_430_4: boolean;
  signal sm_lcd_totalcmdtransfer_en_join_430_1: boolean;
  signal rel_436_4: boolean;
  signal sm_leds_en_join_436_1: boolean;
  signal slice_451_44: unsigned((18 - 1) downto 0);
  signal slice_454_41: unsigned((1 - 1) downto 0);
  signal slice_457_41: unsigned((18 - 1) downto 0);
  signal slice_460_47: unsigned((9 - 1) downto 0);
  signal slice_463_47: unsigned((4 - 1) downto 0);
  signal slice_466_48: unsigned((3 - 1) downto 0);
  signal slice_469_38: unsigned((9 - 1) downto 0);
  signal slice_472_46: unsigned((2 - 1) downto 0);
  signal slice_475_45: unsigned((1 - 1) downto 0);
  signal slice_478_40: unsigned((9 - 1) downto 0);
  signal slice_481_42: unsigned((9 - 1) downto 0);
  signal slice_484_42: unsigned((4 - 1) downto 0);
  signal slice_487_40: unsigned((9 - 1) downto 0);
  signal slice_490_37: unsigned((1 - 1) downto 0);
  signal slice_493_40: unsigned((1 - 1) downto 0);
  signal slice_496_38: unsigned((9 - 1) downto 0);
  signal slice_499_41: unsigned((9 - 1) downto 0);
  signal slice_502_43: unsigned((9 - 1) downto 0);
  signal slice_505_36: unsigned((1 - 1) downto 0);
  signal slice_508_48: unsigned((8 - 1) downto 0);
  signal slice_511_32: unsigned((8 - 1) downto 0);
  signal rel_521_4: boolean;
  signal rel_524_8: boolean;
  signal rel_527_8: boolean;
  signal rel_530_8: boolean;
  signal read_bank_out_reg_join_521_1: unsigned((32 - 1) downto 0);
  signal cast_sm_lcd_charactermap_addr_reg_287_1_next: unsigned((12 - 1) downto 0);
  signal cast_sm_lcd_characters_addr_reg_295_1_next: unsigned((9 - 1) downto 0);
  signal cast_sm_lcd_commands_addr_reg_303_1_next: unsigned((8 - 1) downto 0);
begin
  wrdbus_1_1186 <= std_logic_vector_to_unsigned(wrdbus);
  bankaddr_1_1194 <= std_logic_vector_to_unsigned(bankaddr);
  linearaddr_1_1204 <= std_logic_vector_to_unsigned(linearaddr);
  rnwreg_1_1216 <= std_logic_vector_to_unsigned(rnwreg);
  addrack_1_1224 <= std_logic_vector_to_unsigned(addrack);
  sm_buttons_big_1_1233 <= std_logic_vector_to_unsigned(sm_buttons_big);
  sm_buttons_small_1_1249 <= std_logic_vector_to_unsigned(sm_buttons_small);
  sm_dip_switch_1_1267 <= std_logic_vector_to_unsigned(sm_dip_switch);
  sm_trackball_1_1282 <= std_logic_vector_to_unsigned(sm_trackball);
  sm_buzzer_dutycycle_1_1296 <= std_logic_vector_to_unsigned(sm_buzzer_dutycycle);
  sm_buzzer_enable_1_1317 <= std_logic_vector_to_unsigned(sm_buzzer_enable);
  sm_buzzer_period_1_1335 <= std_logic_vector_to_unsigned(sm_buzzer_period);
  sm_lcd_backgroundcolor_1_1353 <= std_logic_vector_to_unsigned(sm_lcd_backgroundcolor);
  sm_lcd_characteroffset_1_1377 <= std_logic_vector_to_unsigned(sm_lcd_characteroffset);
  sm_lcd_charactersselect_1_1401 <= std_logic_vector_to_unsigned(sm_lcd_charactersselect);
  sm_lcd_colset_1_1426 <= std_logic_vector_to_unsigned(sm_lcd_colset);
  sm_lcd_configlocation_1_1441 <= std_logic_vector_to_unsigned(sm_lcd_configlocation);
  sm_lcd_dividerselect_1_1464 <= std_logic_vector_to_unsigned(sm_lcd_dividerselect);
  sm_lcd_firstend_1_1486 <= std_logic_vector_to_unsigned(sm_lcd_firstend);
  sm_lcd_firststart_1_1503 <= std_logic_vector_to_unsigned(sm_lcd_firststart);
  sm_lcd_lineoffset_1_1522 <= std_logic_vector_to_unsigned(sm_lcd_lineoffset);
  sm_lcd_ramwrite_1_1541 <= std_logic_vector_to_unsigned(sm_lcd_ramwrite);
  sm_lcd_reset_1_1558 <= std_logic_vector_to_unsigned(sm_lcd_reset);
  sm_lcd_resetlcd_1_1572 <= std_logic_vector_to_unsigned(sm_lcd_resetlcd);
  sm_lcd_rowset_1_1589 <= std_logic_vector_to_unsigned(sm_lcd_rowset);
  sm_lcd_secondend_1_1604 <= std_logic_vector_to_unsigned(sm_lcd_secondend);
  sm_lcd_secondstart_1_1622 <= std_logic_vector_to_unsigned(sm_lcd_secondstart);
  sm_lcd_send_1_1642 <= std_logic_vector_to_unsigned(sm_lcd_send);
  sm_lcd_totalcmdtransfer_1_1655 <= std_logic_vector_to_unsigned(sm_lcd_totalcmdtransfer);
  sm_leds_1_1680 <= std_logic_vector_to_unsigned(sm_leds);
  sm_lcd_charactermap_1_1689 <= std_logic_vector_to_unsigned(sm_lcd_charactermap);
  sm_lcd_characters_1_1710 <= std_logic_vector_to_unsigned(sm_lcd_characters);
  sm_lcd_commands_1_1729 <= std_logic_vector_to_unsigned(sm_lcd_commands);
  proc_reg_bank_out_reg_98_30: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        reg_bank_out_reg_98_30 <= reg_bank_out_reg_98_30_next;
      end if;
    end if;
  end process proc_reg_bank_out_reg_98_30;
  proc_ram_bank_out_reg_203_30: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        ram_bank_out_reg_203_30 <= ram_bank_out_reg_203_30_next;
      end if;
    end if;
  end process proc_ram_bank_out_reg_203_30;
  proc_sm_lcd_charactermap_we_reg_226_40: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        sm_lcd_charactermap_we_reg_226_40 <= sm_lcd_charactermap_we_reg_226_40_next;
      end if;
    end if;
  end process proc_sm_lcd_charactermap_we_reg_226_40;
  proc_sm_lcd_characters_we_reg_245_38: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        sm_lcd_characters_we_reg_245_38 <= sm_lcd_characters_we_reg_245_38_next;
      end if;
    end if;
  end process proc_sm_lcd_characters_we_reg_245_38;
  proc_sm_lcd_commands_we_reg_264_36: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        sm_lcd_commands_we_reg_264_36 <= sm_lcd_commands_we_reg_264_36_next;
      end if;
    end if;
  end process proc_sm_lcd_commands_we_reg_264_36;
  proc_sm_lcd_charactermap_addr_reg_287_1: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (sm_lcd_charactermap_addr_reg_287_1_en = '1')) then
        sm_lcd_charactermap_addr_reg_287_1 <= sm_lcd_charactermap_addr_reg_287_1_next;
      end if;
    end if;
  end process proc_sm_lcd_charactermap_addr_reg_287_1;
  proc_sm_lcd_characters_addr_reg_295_1: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (sm_lcd_characters_addr_reg_295_1_en = '1')) then
        sm_lcd_characters_addr_reg_295_1 <= sm_lcd_characters_addr_reg_295_1_next;
      end if;
    end if;
  end process proc_sm_lcd_characters_addr_reg_295_1;
  proc_sm_lcd_commands_addr_reg_303_1: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (sm_lcd_commands_addr_reg_303_1_en = '1')) then
        sm_lcd_commands_addr_reg_303_1 <= sm_lcd_commands_addr_reg_303_1_next;
      end if;
    end if;
  end process proc_sm_lcd_commands_addr_reg_303_1;
  proc_read_bank_out_reg_516_31: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        read_bank_out_reg_516_31 <= read_bank_out_reg_516_31_next;
      end if;
    end if;
  end process proc_read_bank_out_reg_516_31;
  proc_bankaddr_reg_519_26: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        bankaddr_reg_519_26 <= bankaddr_reg_519_26_next;
      end if;
    end if;
  end process proc_bankaddr_reg_519_26;
  rel_101_4 <= linearaddr_1_1204 = std_logic_vector_to_unsigned("0000000010101");
  rel_103_8 <= linearaddr_1_1204 = std_logic_vector_to_unsigned("0000000010110");
  rel_105_8 <= linearaddr_1_1204 = std_logic_vector_to_unsigned("0000000010111");
  rel_107_8 <= linearaddr_1_1204 = std_logic_vector_to_unsigned("0000000011000");
  rel_109_8 <= linearaddr_1_1204 = std_logic_vector_to_unsigned("0000000000000");
  rel_111_8 <= linearaddr_1_1204 = std_logic_vector_to_unsigned("0000000000001");
  rel_113_8 <= linearaddr_1_1204 = std_logic_vector_to_unsigned("0000000000010");
  rel_115_8 <= linearaddr_1_1204 = std_logic_vector_to_unsigned("0000000000011");
  rel_117_8 <= linearaddr_1_1204 = std_logic_vector_to_unsigned("0000000000100");
  rel_119_8 <= linearaddr_1_1204 = std_logic_vector_to_unsigned("0000000000101");
  rel_121_8 <= linearaddr_1_1204 = std_logic_vector_to_unsigned("0000000000110");
  rel_123_8 <= linearaddr_1_1204 = std_logic_vector_to_unsigned("0000000000111");
  rel_125_8 <= linearaddr_1_1204 = std_logic_vector_to_unsigned("0000000001000");
  rel_127_8 <= linearaddr_1_1204 = std_logic_vector_to_unsigned("0000000001001");
  rel_129_8 <= linearaddr_1_1204 = std_logic_vector_to_unsigned("0000000001010");
  rel_131_8 <= linearaddr_1_1204 = std_logic_vector_to_unsigned("0000000001011");
  rel_133_8 <= linearaddr_1_1204 = std_logic_vector_to_unsigned("0000000001100");
  rel_135_8 <= linearaddr_1_1204 = std_logic_vector_to_unsigned("0000000001101");
  rel_137_8 <= linearaddr_1_1204 = std_logic_vector_to_unsigned("0000000001110");
  rel_139_8 <= linearaddr_1_1204 = std_logic_vector_to_unsigned("0000000001111");
  rel_141_8 <= linearaddr_1_1204 = std_logic_vector_to_unsigned("0000000010000");
  rel_143_8 <= linearaddr_1_1204 = std_logic_vector_to_unsigned("0000000010001");
  rel_145_8 <= linearaddr_1_1204 = std_logic_vector_to_unsigned("0000000010010");
  rel_147_8 <= linearaddr_1_1204 = std_logic_vector_to_unsigned("0000000010011");
  rel_149_8 <= linearaddr_1_1204 = std_logic_vector_to_unsigned("0000000010100");
  proc_if_101_1: process (reg_bank_out_reg_98_30, rel_101_4, rel_103_8, rel_105_8, rel_107_8, rel_109_8, rel_111_8, rel_113_8, rel_115_8, rel_117_8, rel_119_8, rel_121_8, rel_123_8, rel_125_8, rel_127_8, rel_129_8, rel_131_8, rel_133_8, rel_135_8, rel_137_8, rel_139_8, rel_141_8, rel_143_8, rel_145_8, rel_147_8, rel_149_8, sm_buttons_big_1_1233, sm_buttons_small_1_1249, sm_buzzer_dutycycle_1_1296, sm_buzzer_enable_1_1317, sm_buzzer_period_1_1335, sm_dip_switch_1_1267, sm_lcd_backgroundcolor_1_1353, sm_lcd_characteroffset_1_1377, sm_lcd_charactersselect_1_1401, sm_lcd_colset_1_1426, sm_lcd_configlocation_1_1441, sm_lcd_dividerselect_1_1464, sm_lcd_firstend_1_1486, sm_lcd_firststart_1_1503, sm_lcd_lineoffset_1_1522, sm_lcd_ramwrite_1_1541, sm_lcd_reset_1_1558, sm_lcd_resetlcd_1_1572, sm_lcd_rowset_1_1589, sm_lcd_secondend_1_1604, sm_lcd_secondstart_1_1622, sm_lcd_send_1_1642, sm_lcd_totalcmdtransfer_1_1655, sm_leds_1_1680, sm_trackball_1_1282)
  is
  begin
    if rel_101_4 then
      reg_bank_out_reg_join_101_1 <= u2u_cast(sm_buttons_big_1_1233, 0, 32, 0);
    elsif rel_103_8 then
      reg_bank_out_reg_join_101_1 <= u2u_cast(sm_buttons_small_1_1249, 0, 32, 0);
    elsif rel_105_8 then
      reg_bank_out_reg_join_101_1 <= u2u_cast(sm_dip_switch_1_1267, 0, 32, 0);
    elsif rel_107_8 then
      reg_bank_out_reg_join_101_1 <= u2u_cast(sm_trackball_1_1282, 0, 32, 0);
    elsif rel_109_8 then
      reg_bank_out_reg_join_101_1 <= u2u_cast(sm_buzzer_dutycycle_1_1296, 0, 32, 0);
    elsif rel_111_8 then
      reg_bank_out_reg_join_101_1 <= u2u_cast(sm_buzzer_enable_1_1317, 0, 32, 0);
    elsif rel_113_8 then
      reg_bank_out_reg_join_101_1 <= u2u_cast(sm_buzzer_period_1_1335, 0, 32, 0);
    elsif rel_115_8 then
      reg_bank_out_reg_join_101_1 <= u2u_cast(sm_lcd_backgroundcolor_1_1353, 0, 32, 0);
    elsif rel_117_8 then
      reg_bank_out_reg_join_101_1 <= u2u_cast(sm_lcd_characteroffset_1_1377, 0, 32, 0);
    elsif rel_119_8 then
      reg_bank_out_reg_join_101_1 <= u2u_cast(sm_lcd_charactersselect_1_1401, 0, 32, 0);
    elsif rel_121_8 then
      reg_bank_out_reg_join_101_1 <= u2u_cast(sm_lcd_colset_1_1426, 0, 32, 0);
    elsif rel_123_8 then
      reg_bank_out_reg_join_101_1 <= u2u_cast(sm_lcd_configlocation_1_1441, 0, 32, 0);
    elsif rel_125_8 then
      reg_bank_out_reg_join_101_1 <= u2u_cast(sm_lcd_dividerselect_1_1464, 0, 32, 0);
    elsif rel_127_8 then
      reg_bank_out_reg_join_101_1 <= u2u_cast(sm_lcd_firstend_1_1486, 0, 32, 0);
    elsif rel_129_8 then
      reg_bank_out_reg_join_101_1 <= u2u_cast(sm_lcd_firststart_1_1503, 0, 32, 0);
    elsif rel_131_8 then
      reg_bank_out_reg_join_101_1 <= u2u_cast(sm_lcd_lineoffset_1_1522, 0, 32, 0);
    elsif rel_133_8 then
      reg_bank_out_reg_join_101_1 <= u2u_cast(sm_lcd_ramwrite_1_1541, 0, 32, 0);
    elsif rel_135_8 then
      reg_bank_out_reg_join_101_1 <= u2u_cast(sm_lcd_reset_1_1558, 0, 32, 0);
    elsif rel_137_8 then
      reg_bank_out_reg_join_101_1 <= u2u_cast(sm_lcd_resetlcd_1_1572, 0, 32, 0);
    elsif rel_139_8 then
      reg_bank_out_reg_join_101_1 <= u2u_cast(sm_lcd_rowset_1_1589, 0, 32, 0);
    elsif rel_141_8 then
      reg_bank_out_reg_join_101_1 <= u2u_cast(sm_lcd_secondend_1_1604, 0, 32, 0);
    elsif rel_143_8 then
      reg_bank_out_reg_join_101_1 <= u2u_cast(sm_lcd_secondstart_1_1622, 0, 32, 0);
    elsif rel_145_8 then
      reg_bank_out_reg_join_101_1 <= u2u_cast(sm_lcd_send_1_1642, 0, 32, 0);
    elsif rel_147_8 then
      reg_bank_out_reg_join_101_1 <= u2u_cast(sm_lcd_totalcmdtransfer_1_1655, 0, 32, 0);
    elsif rel_149_8 then
      reg_bank_out_reg_join_101_1 <= u2u_cast(sm_leds_1_1680, 0, 32, 0);
    else 
      reg_bank_out_reg_join_101_1 <= reg_bank_out_reg_98_30;
    end if;
  end process proc_if_101_1;
  opcode_160_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(addrack_1_1224) & unsigned_to_std_logic_vector(rnwreg_1_1216) & unsigned_to_std_logic_vector(bankaddr_1_1194) & unsigned_to_std_logic_vector(linearaddr_1_1204));
  slice_164_51 <= u2u_slice(linearaddr_1_1204, 12, 12);
  sm_lcd_charactermap_sel_value_164_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(slice_164_51));
  rel_168_4 <= sm_lcd_charactermap_sel_value_164_1_concat = std_logic_vector_to_unsigned("0");
  proc_if_168_1: process (rel_168_4)
  is
  begin
    if rel_168_4 then
      sm_lcd_charactermap_sel_join_168_1 <= true;
    else 
      sm_lcd_charactermap_sel_join_168_1 <= false;
    end if;
  end process proc_if_168_1;
  slice_176_49 <= u2u_slice(linearaddr_1_1204, 12, 9);
  sm_lcd_characters_sel_value_176_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(slice_176_49));
  rel_180_4 <= sm_lcd_characters_sel_value_176_1_concat = std_logic_vector_to_unsigned("1000");
  proc_if_180_1: process (rel_180_4)
  is
  begin
    if rel_180_4 then
      sm_lcd_characters_sel_join_180_1 <= true;
    else 
      sm_lcd_characters_sel_join_180_1 <= false;
    end if;
  end process proc_if_180_1;
  slice_188_47 <= u2u_slice(linearaddr_1_1204, 12, 8);
  sm_lcd_commands_sel_value_188_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(slice_188_47));
  rel_192_4 <= sm_lcd_commands_sel_value_188_1_concat = std_logic_vector_to_unsigned("10010");
  proc_if_192_1: process (rel_192_4)
  is
  begin
    if rel_192_4 then
      sm_lcd_commands_sel_join_192_1 <= true;
    else 
      sm_lcd_commands_sel_join_192_1 <= false;
    end if;
  end process proc_if_192_1;
  proc_if_205_1: process (ram_bank_out_reg_203_30, sm_lcd_charactermap_1_1689, sm_lcd_charactermap_sel_join_168_1, sm_lcd_characters_1_1710, sm_lcd_characters_sel_join_180_1, sm_lcd_commands_1_1729, sm_lcd_commands_sel_join_192_1)
  is
  begin
    if sm_lcd_charactermap_sel_join_168_1 then
      ram_bank_out_reg_join_205_1 <= sm_lcd_charactermap_1_1689;
    elsif sm_lcd_characters_sel_join_180_1 then
      ram_bank_out_reg_join_205_1 <= sm_lcd_characters_1_1710;
    elsif sm_lcd_commands_sel_join_192_1 then
      ram_bank_out_reg_join_205_1 <= sm_lcd_commands_1_1729;
    else 
      ram_bank_out_reg_join_205_1 <= ram_bank_out_reg_203_30;
    end if;
  end process proc_if_205_1;
  slice_214_44 <= u2u_slice(wrdbus_1_1186, 31, 0);
  slice_217_42 <= u2u_slice(wrdbus_1_1186, 31, 0);
  slice_220_40 <= u2u_slice(wrdbus_1_1186, 31, 0);
  slice_231_46 <= u2u_slice(linearaddr_1_1204, 12, 12);
  opcode_sm_lcd_charactermap_228_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(addrack_1_1224) & unsigned_to_std_logic_vector(rnwreg_1_1216) & unsigned_to_std_logic_vector(bankaddr_1_1194) & unsigned_to_std_logic_vector(slice_231_46));
  rel_235_4 <= opcode_sm_lcd_charactermap_228_1_concat = std_logic_vector_to_unsigned("10000");
  proc_if_235_1: process (rel_235_4)
  is
  begin
    if rel_235_4 then
      sm_lcd_charactermap_we_reg_join_235_1 <= true;
    else 
      sm_lcd_charactermap_we_reg_join_235_1 <= false;
    end if;
  end process proc_if_235_1;
  slice_250_46 <= u2u_slice(linearaddr_1_1204, 12, 9);
  opcode_sm_lcd_characters_247_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(addrack_1_1224) & unsigned_to_std_logic_vector(rnwreg_1_1216) & unsigned_to_std_logic_vector(bankaddr_1_1194) & unsigned_to_std_logic_vector(slice_250_46));
  rel_254_4 <= opcode_sm_lcd_characters_247_1_concat = std_logic_vector_to_unsigned("10001000");
  proc_if_254_1: process (rel_254_4)
  is
  begin
    if rel_254_4 then
      sm_lcd_characters_we_reg_join_254_1 <= true;
    else 
      sm_lcd_characters_we_reg_join_254_1 <= false;
    end if;
  end process proc_if_254_1;
  slice_269_46 <= u2u_slice(linearaddr_1_1204, 12, 8);
  opcode_sm_lcd_commands_266_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(addrack_1_1224) & unsigned_to_std_logic_vector(rnwreg_1_1216) & unsigned_to_std_logic_vector(bankaddr_1_1194) & unsigned_to_std_logic_vector(slice_269_46));
  rel_273_4 <= opcode_sm_lcd_commands_266_1_concat = std_logic_vector_to_unsigned("100010010");
  proc_if_273_1: process (rel_273_4)
  is
  begin
    if rel_273_4 then
      sm_lcd_commands_we_reg_join_273_1 <= true;
    else 
      sm_lcd_commands_we_reg_join_273_1 <= false;
    end if;
  end process proc_if_273_1;
  sm_lcd_charactermap_addr_reg_290_5_slice <= u2u_slice(linearaddr_1_1204, 12, 0);
  rel_289_4 <= addrack_1_1224 = std_logic_vector_to_unsigned("1");
  proc_if_289_1: process (rel_289_4, sm_lcd_charactermap_addr_reg_290_5_slice)
  is
  begin
    if rel_289_4 then
      sm_lcd_charactermap_addr_reg_join_289_1_en <= '1';
    else 
      sm_lcd_charactermap_addr_reg_join_289_1_en <= '0';
    end if;
    sm_lcd_charactermap_addr_reg_join_289_1 <= sm_lcd_charactermap_addr_reg_290_5_slice;
  end process proc_if_289_1;
  sm_lcd_characters_addr_reg_298_5_slice <= u2u_slice(linearaddr_1_1204, 9, 0);
  rel_297_4 <= addrack_1_1224 = std_logic_vector_to_unsigned("1");
  proc_if_297_1: process (rel_297_4, sm_lcd_characters_addr_reg_298_5_slice)
  is
  begin
    if rel_297_4 then
      sm_lcd_characters_addr_reg_join_297_1_en <= '1';
    else 
      sm_lcd_characters_addr_reg_join_297_1_en <= '0';
    end if;
    sm_lcd_characters_addr_reg_join_297_1 <= sm_lcd_characters_addr_reg_298_5_slice;
  end process proc_if_297_1;
  sm_lcd_commands_addr_reg_306_5_slice <= u2u_slice(linearaddr_1_1204, 8, 0);
  rel_305_4 <= addrack_1_1224 = std_logic_vector_to_unsigned("1");
  proc_if_305_1: process (rel_305_4, sm_lcd_commands_addr_reg_306_5_slice)
  is
  begin
    if rel_305_4 then
      sm_lcd_commands_addr_reg_join_305_1_en <= '1';
    else 
      sm_lcd_commands_addr_reg_join_305_1_en <= '0';
    end if;
    sm_lcd_commands_addr_reg_join_305_1 <= sm_lcd_commands_addr_reg_306_5_slice;
  end process proc_if_305_1;
  rel_316_4 <= opcode_160_1_concat = std_logic_vector_to_unsigned("10100000000000000");
  proc_if_316_1: process (rel_316_4)
  is
  begin
    if rel_316_4 then
      sm_buzzer_dutycycle_en_join_316_1 <= true;
    else 
      sm_buzzer_dutycycle_en_join_316_1 <= false;
    end if;
  end process proc_if_316_1;
  rel_322_4 <= opcode_160_1_concat = std_logic_vector_to_unsigned("10100000000000001");
  proc_if_322_1: process (rel_322_4)
  is
  begin
    if rel_322_4 then
      sm_buzzer_enable_en_join_322_1 <= true;
    else 
      sm_buzzer_enable_en_join_322_1 <= false;
    end if;
  end process proc_if_322_1;
  rel_328_4 <= opcode_160_1_concat = std_logic_vector_to_unsigned("10100000000000010");
  proc_if_328_1: process (rel_328_4)
  is
  begin
    if rel_328_4 then
      sm_buzzer_period_en_join_328_1 <= true;
    else 
      sm_buzzer_period_en_join_328_1 <= false;
    end if;
  end process proc_if_328_1;
  rel_334_4 <= opcode_160_1_concat = std_logic_vector_to_unsigned("10100000000000011");
  proc_if_334_1: process (rel_334_4)
  is
  begin
    if rel_334_4 then
      sm_lcd_backgroundcolor_en_join_334_1 <= true;
    else 
      sm_lcd_backgroundcolor_en_join_334_1 <= false;
    end if;
  end process proc_if_334_1;
  rel_340_4 <= opcode_160_1_concat = std_logic_vector_to_unsigned("10100000000000100");
  proc_if_340_1: process (rel_340_4)
  is
  begin
    if rel_340_4 then
      sm_lcd_characteroffset_en_join_340_1 <= true;
    else 
      sm_lcd_characteroffset_en_join_340_1 <= false;
    end if;
  end process proc_if_340_1;
  rel_346_4 <= opcode_160_1_concat = std_logic_vector_to_unsigned("10100000000000101");
  proc_if_346_1: process (rel_346_4)
  is
  begin
    if rel_346_4 then
      sm_lcd_charactersselect_en_join_346_1 <= true;
    else 
      sm_lcd_charactersselect_en_join_346_1 <= false;
    end if;
  end process proc_if_346_1;
  rel_352_4 <= opcode_160_1_concat = std_logic_vector_to_unsigned("10100000000000110");
  proc_if_352_1: process (rel_352_4)
  is
  begin
    if rel_352_4 then
      sm_lcd_colset_en_join_352_1 <= true;
    else 
      sm_lcd_colset_en_join_352_1 <= false;
    end if;
  end process proc_if_352_1;
  rel_358_4 <= opcode_160_1_concat = std_logic_vector_to_unsigned("10100000000000111");
  proc_if_358_1: process (rel_358_4)
  is
  begin
    if rel_358_4 then
      sm_lcd_configlocation_en_join_358_1 <= true;
    else 
      sm_lcd_configlocation_en_join_358_1 <= false;
    end if;
  end process proc_if_358_1;
  rel_364_4 <= opcode_160_1_concat = std_logic_vector_to_unsigned("10100000000001000");
  proc_if_364_1: process (rel_364_4)
  is
  begin
    if rel_364_4 then
      sm_lcd_dividerselect_en_join_364_1 <= true;
    else 
      sm_lcd_dividerselect_en_join_364_1 <= false;
    end if;
  end process proc_if_364_1;
  rel_370_4 <= opcode_160_1_concat = std_logic_vector_to_unsigned("10100000000001001");
  proc_if_370_1: process (rel_370_4)
  is
  begin
    if rel_370_4 then
      sm_lcd_firstend_en_join_370_1 <= true;
    else 
      sm_lcd_firstend_en_join_370_1 <= false;
    end if;
  end process proc_if_370_1;
  rel_376_4 <= opcode_160_1_concat = std_logic_vector_to_unsigned("10100000000001010");
  proc_if_376_1: process (rel_376_4)
  is
  begin
    if rel_376_4 then
      sm_lcd_firststart_en_join_376_1 <= true;
    else 
      sm_lcd_firststart_en_join_376_1 <= false;
    end if;
  end process proc_if_376_1;
  rel_382_4 <= opcode_160_1_concat = std_logic_vector_to_unsigned("10100000000001011");
  proc_if_382_1: process (rel_382_4)
  is
  begin
    if rel_382_4 then
      sm_lcd_lineoffset_en_join_382_1 <= true;
    else 
      sm_lcd_lineoffset_en_join_382_1 <= false;
    end if;
  end process proc_if_382_1;
  rel_388_4 <= opcode_160_1_concat = std_logic_vector_to_unsigned("10100000000001100");
  proc_if_388_1: process (rel_388_4)
  is
  begin
    if rel_388_4 then
      sm_lcd_ramwrite_en_join_388_1 <= true;
    else 
      sm_lcd_ramwrite_en_join_388_1 <= false;
    end if;
  end process proc_if_388_1;
  rel_394_4 <= opcode_160_1_concat = std_logic_vector_to_unsigned("10100000000001101");
  proc_if_394_1: process (rel_394_4)
  is
  begin
    if rel_394_4 then
      sm_lcd_reset_en_join_394_1 <= true;
    else 
      sm_lcd_reset_en_join_394_1 <= false;
    end if;
  end process proc_if_394_1;
  rel_400_4 <= opcode_160_1_concat = std_logic_vector_to_unsigned("10100000000001110");
  proc_if_400_1: process (rel_400_4)
  is
  begin
    if rel_400_4 then
      sm_lcd_resetlcd_en_join_400_1 <= true;
    else 
      sm_lcd_resetlcd_en_join_400_1 <= false;
    end if;
  end process proc_if_400_1;
  rel_406_4 <= opcode_160_1_concat = std_logic_vector_to_unsigned("10100000000001111");
  proc_if_406_1: process (rel_406_4)
  is
  begin
    if rel_406_4 then
      sm_lcd_rowset_en_join_406_1 <= true;
    else 
      sm_lcd_rowset_en_join_406_1 <= false;
    end if;
  end process proc_if_406_1;
  rel_412_4 <= opcode_160_1_concat = std_logic_vector_to_unsigned("10100000000010000");
  proc_if_412_1: process (rel_412_4)
  is
  begin
    if rel_412_4 then
      sm_lcd_secondend_en_join_412_1 <= true;
    else 
      sm_lcd_secondend_en_join_412_1 <= false;
    end if;
  end process proc_if_412_1;
  rel_418_4 <= opcode_160_1_concat = std_logic_vector_to_unsigned("10100000000010001");
  proc_if_418_1: process (rel_418_4)
  is
  begin
    if rel_418_4 then
      sm_lcd_secondstart_en_join_418_1 <= true;
    else 
      sm_lcd_secondstart_en_join_418_1 <= false;
    end if;
  end process proc_if_418_1;
  rel_424_4 <= opcode_160_1_concat = std_logic_vector_to_unsigned("10100000000010010");
  proc_if_424_1: process (rel_424_4)
  is
  begin
    if rel_424_4 then
      sm_lcd_send_en_join_424_1 <= true;
    else 
      sm_lcd_send_en_join_424_1 <= false;
    end if;
  end process proc_if_424_1;
  rel_430_4 <= opcode_160_1_concat = std_logic_vector_to_unsigned("10100000000010011");
  proc_if_430_1: process (rel_430_4)
  is
  begin
    if rel_430_4 then
      sm_lcd_totalcmdtransfer_en_join_430_1 <= true;
    else 
      sm_lcd_totalcmdtransfer_en_join_430_1 <= false;
    end if;
  end process proc_if_430_1;
  rel_436_4 <= opcode_160_1_concat = std_logic_vector_to_unsigned("10100000000010100");
  proc_if_436_1: process (rel_436_4)
  is
  begin
    if rel_436_4 then
      sm_leds_en_join_436_1 <= true;
    else 
      sm_leds_en_join_436_1 <= false;
    end if;
  end process proc_if_436_1;
  slice_451_44 <= u2u_slice(wrdbus_1_1186, 17, 0);
  slice_454_41 <= u2u_slice(wrdbus_1_1186, 0, 0);
  slice_457_41 <= u2u_slice(wrdbus_1_1186, 17, 0);
  slice_460_47 <= u2u_slice(wrdbus_1_1186, 8, 0);
  slice_463_47 <= u2u_slice(wrdbus_1_1186, 3, 0);
  slice_466_48 <= u2u_slice(wrdbus_1_1186, 2, 0);
  slice_469_38 <= u2u_slice(wrdbus_1_1186, 8, 0);
  slice_472_46 <= u2u_slice(wrdbus_1_1186, 1, 0);
  slice_475_45 <= u2u_slice(wrdbus_1_1186, 0, 0);
  slice_478_40 <= u2u_slice(wrdbus_1_1186, 8, 0);
  slice_481_42 <= u2u_slice(wrdbus_1_1186, 8, 0);
  slice_484_42 <= u2u_slice(wrdbus_1_1186, 3, 0);
  slice_487_40 <= u2u_slice(wrdbus_1_1186, 8, 0);
  slice_490_37 <= u2u_slice(wrdbus_1_1186, 0, 0);
  slice_493_40 <= u2u_slice(wrdbus_1_1186, 0, 0);
  slice_496_38 <= u2u_slice(wrdbus_1_1186, 8, 0);
  slice_499_41 <= u2u_slice(wrdbus_1_1186, 8, 0);
  slice_502_43 <= u2u_slice(wrdbus_1_1186, 8, 0);
  slice_505_36 <= u2u_slice(wrdbus_1_1186, 0, 0);
  slice_508_48 <= u2u_slice(wrdbus_1_1186, 7, 0);
  slice_511_32 <= u2u_slice(wrdbus_1_1186, 7, 0);
  rel_521_4 <= bankaddr_reg_519_26 = std_logic_vector_to_unsigned("00");
  rel_524_8 <= bankaddr_reg_519_26 = std_logic_vector_to_unsigned("01");
  rel_527_8 <= bankaddr_reg_519_26 = std_logic_vector_to_unsigned("10");
  rel_530_8 <= bankaddr_reg_519_26 = std_logic_vector_to_unsigned("11");
  proc_if_521_1: process (ram_bank_out_reg_203_30, read_bank_out_reg_516_31, reg_bank_out_reg_98_30, rel_521_4, rel_524_8, rel_527_8, rel_530_8)
  is
  begin
    if rel_521_4 then
      read_bank_out_reg_join_521_1 <= ram_bank_out_reg_203_30;
    elsif rel_524_8 then
      read_bank_out_reg_join_521_1 <= std_logic_vector_to_unsigned("00000000000000000000000000000000");
    elsif rel_527_8 then
      read_bank_out_reg_join_521_1 <= reg_bank_out_reg_98_30;
    elsif rel_530_8 then
      read_bank_out_reg_join_521_1 <= std_logic_vector_to_unsigned("00000000000000000000000000000000");
    else 
      read_bank_out_reg_join_521_1 <= read_bank_out_reg_516_31;
    end if;
  end process proc_if_521_1;
  reg_bank_out_reg_98_30_next <= reg_bank_out_reg_join_101_1;
  ram_bank_out_reg_203_30_next <= ram_bank_out_reg_join_205_1;
  sm_lcd_charactermap_we_reg_226_40_next <= sm_lcd_charactermap_we_reg_join_235_1;
  sm_lcd_characters_we_reg_245_38_next <= sm_lcd_characters_we_reg_join_254_1;
  sm_lcd_commands_we_reg_264_36_next <= sm_lcd_commands_we_reg_join_273_1;
  cast_sm_lcd_charactermap_addr_reg_287_1_next <= u2u_cast(sm_lcd_charactermap_addr_reg_join_289_1, 0, 12, 0);
  sm_lcd_charactermap_addr_reg_287_1_next <= cast_sm_lcd_charactermap_addr_reg_287_1_next;
  sm_lcd_charactermap_addr_reg_287_1_en <= sm_lcd_charactermap_addr_reg_join_289_1_en;
  cast_sm_lcd_characters_addr_reg_295_1_next <= u2u_cast(sm_lcd_characters_addr_reg_join_297_1, 0, 9, 0);
  sm_lcd_characters_addr_reg_295_1_next <= cast_sm_lcd_characters_addr_reg_295_1_next;
  sm_lcd_characters_addr_reg_295_1_en <= sm_lcd_characters_addr_reg_join_297_1_en;
  cast_sm_lcd_commands_addr_reg_303_1_next <= u2u_cast(sm_lcd_commands_addr_reg_join_305_1, 0, 8, 0);
  sm_lcd_commands_addr_reg_303_1_next <= cast_sm_lcd_commands_addr_reg_303_1_next;
  sm_lcd_commands_addr_reg_303_1_en <= sm_lcd_commands_addr_reg_join_305_1_en;
  read_bank_out_reg_516_31_next <= read_bank_out_reg_join_521_1;
  bankaddr_reg_519_26_next <= bankaddr_1_1194;
  read_bank_out <= unsigned_to_std_logic_vector(read_bank_out_reg_516_31);
  sm_buzzer_dutycycle_din <= unsigned_to_std_logic_vector(slice_451_44);
  sm_buzzer_dutycycle_en <= boolean_to_vector(sm_buzzer_dutycycle_en_join_316_1);
  sm_buzzer_enable_din <= unsigned_to_std_logic_vector(slice_454_41);
  sm_buzzer_enable_en <= boolean_to_vector(sm_buzzer_enable_en_join_322_1);
  sm_buzzer_period_din <= unsigned_to_std_logic_vector(slice_457_41);
  sm_buzzer_period_en <= boolean_to_vector(sm_buzzer_period_en_join_328_1);
  sm_lcd_backgroundcolor_din <= unsigned_to_std_logic_vector(slice_460_47);
  sm_lcd_backgroundcolor_en <= boolean_to_vector(sm_lcd_backgroundcolor_en_join_334_1);
  sm_lcd_characteroffset_din <= unsigned_to_std_logic_vector(slice_463_47);
  sm_lcd_characteroffset_en <= boolean_to_vector(sm_lcd_characteroffset_en_join_340_1);
  sm_lcd_charactersselect_din <= unsigned_to_std_logic_vector(slice_466_48);
  sm_lcd_charactersselect_en <= boolean_to_vector(sm_lcd_charactersselect_en_join_346_1);
  sm_lcd_colset_din <= unsigned_to_std_logic_vector(slice_469_38);
  sm_lcd_colset_en <= boolean_to_vector(sm_lcd_colset_en_join_352_1);
  sm_lcd_configlocation_din <= unsigned_to_std_logic_vector(slice_472_46);
  sm_lcd_configlocation_en <= boolean_to_vector(sm_lcd_configlocation_en_join_358_1);
  sm_lcd_dividerselect_din <= unsigned_to_std_logic_vector(slice_475_45);
  sm_lcd_dividerselect_en <= boolean_to_vector(sm_lcd_dividerselect_en_join_364_1);
  sm_lcd_firstend_din <= unsigned_to_std_logic_vector(slice_478_40);
  sm_lcd_firstend_en <= boolean_to_vector(sm_lcd_firstend_en_join_370_1);
  sm_lcd_firststart_din <= unsigned_to_std_logic_vector(slice_481_42);
  sm_lcd_firststart_en <= boolean_to_vector(sm_lcd_firststart_en_join_376_1);
  sm_lcd_lineoffset_din <= unsigned_to_std_logic_vector(slice_484_42);
  sm_lcd_lineoffset_en <= boolean_to_vector(sm_lcd_lineoffset_en_join_382_1);
  sm_lcd_ramwrite_din <= unsigned_to_std_logic_vector(slice_487_40);
  sm_lcd_ramwrite_en <= boolean_to_vector(sm_lcd_ramwrite_en_join_388_1);
  sm_lcd_reset_din <= unsigned_to_std_logic_vector(slice_490_37);
  sm_lcd_reset_en <= boolean_to_vector(sm_lcd_reset_en_join_394_1);
  sm_lcd_resetlcd_din <= unsigned_to_std_logic_vector(slice_493_40);
  sm_lcd_resetlcd_en <= boolean_to_vector(sm_lcd_resetlcd_en_join_400_1);
  sm_lcd_rowset_din <= unsigned_to_std_logic_vector(slice_496_38);
  sm_lcd_rowset_en <= boolean_to_vector(sm_lcd_rowset_en_join_406_1);
  sm_lcd_secondend_din <= unsigned_to_std_logic_vector(slice_499_41);
  sm_lcd_secondend_en <= boolean_to_vector(sm_lcd_secondend_en_join_412_1);
  sm_lcd_secondstart_din <= unsigned_to_std_logic_vector(slice_502_43);
  sm_lcd_secondstart_en <= boolean_to_vector(sm_lcd_secondstart_en_join_418_1);
  sm_lcd_send_din <= unsigned_to_std_logic_vector(slice_505_36);
  sm_lcd_send_en <= boolean_to_vector(sm_lcd_send_en_join_424_1);
  sm_lcd_totalcmdtransfer_din <= unsigned_to_std_logic_vector(slice_508_48);
  sm_lcd_totalcmdtransfer_en <= boolean_to_vector(sm_lcd_totalcmdtransfer_en_join_430_1);
  sm_leds_din <= unsigned_to_std_logic_vector(slice_511_32);
  sm_leds_en <= boolean_to_vector(sm_leds_en_join_436_1);
  sm_lcd_charactermap_addr <= unsigned_to_std_logic_vector(sm_lcd_charactermap_addr_reg_287_1);
  sm_lcd_charactermap_din <= unsigned_to_std_logic_vector(slice_214_44);
  sm_lcd_charactermap_we <= boolean_to_vector(sm_lcd_charactermap_we_reg_226_40);
  sm_lcd_characters_addr <= unsigned_to_std_logic_vector(sm_lcd_characters_addr_reg_295_1);
  sm_lcd_characters_din <= unsigned_to_std_logic_vector(slice_217_42);
  sm_lcd_characters_we <= boolean_to_vector(sm_lcd_characters_we_reg_245_38);
  sm_lcd_commands_addr <= unsigned_to_std_logic_vector(sm_lcd_commands_addr_reg_303_1);
  sm_lcd_commands_din <= unsigned_to_std_logic_vector(slice_220_40);
  sm_lcd_commands_we <= boolean_to_vector(sm_lcd_commands_we_reg_264_36);
end behavior;


-------------------------------------------------------------------
-- System Generator version 10.1.2 VHDL source file.
--
-- Copyright(C) 2008 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2008 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;
entity xldelay is
   generic(width        : integer := -1;
           latency      : integer := -1;
           reg_retiming : integer := 0);
   port(d       : in std_logic_vector (width-1 downto 0);
        ce      : in std_logic;
        clk     : in std_logic;
        en      : in std_logic;
        q       : out std_logic_vector (width-1 downto 0));
end xldelay;
architecture behavior of xldelay is
   component synth_reg
      generic (width       : integer;
               latency     : integer);
      port (i       : in std_logic_vector(width-1 downto 0);
            ce      : in std_logic;
            clr     : in std_logic;
            clk     : in std_logic;
            o       : out std_logic_vector(width-1 downto 0));
   end component;
   component synth_reg_reg
      generic (width       : integer;
               latency     : integer);
      port (i       : in std_logic_vector(width-1 downto 0);
            ce      : in std_logic;
            clr     : in std_logic;
            clk     : in std_logic;
            o       : out std_logic_vector(width-1 downto 0));
   end component;
   signal internal_ce  : std_logic;
begin
   internal_ce  <= ce and en;
   srl_delay: if (reg_retiming = 0) or (latency < 1) generate
     synth_reg_srl_inst : synth_reg
       generic map (
         width   => width,
         latency => latency)
       port map (
         i   => d,
         ce  => internal_ce,
         clr => '0',
         clk => clk,
         o   => q);
   end generate srl_delay;
   reg_delay: if (reg_retiming = 1) and (latency >= 1) generate
     synth_reg_reg_inst : synth_reg_reg
       generic map (
         width   => width,
         latency => latency)
       port map (
         i   => d,
         ce  => internal_ce,
         clr => '0',
         clk => clk,
         o   => q);
   end generate reg_delay;
end architecture behavior;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity logical_4ad38e8aed is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    d2 : in std_logic_vector((1 - 1) downto 0);
    d3 : in std_logic_vector((1 - 1) downto 0);
    d4 : in std_logic_vector((1 - 1) downto 0);
    d5 : in std_logic_vector((1 - 1) downto 0);
    d6 : in std_logic_vector((1 - 1) downto 0);
    d7 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end logical_4ad38e8aed;


architecture behavior of logical_4ad38e8aed is
  signal d0_1_24: std_logic_vector((1 - 1) downto 0);
  signal d1_1_27: std_logic_vector((1 - 1) downto 0);
  signal d2_1_30: std_logic_vector((1 - 1) downto 0);
  signal d3_1_33: std_logic_vector((1 - 1) downto 0);
  signal d4_1_36: std_logic_vector((1 - 1) downto 0);
  signal d5_1_39: std_logic_vector((1 - 1) downto 0);
  signal d6_1_42: std_logic_vector((1 - 1) downto 0);
  signal d7_1_45: std_logic_vector((1 - 1) downto 0);
  signal fully_2_1_bit: std_logic_vector((1 - 1) downto 0);
begin
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  d2_1_30 <= d2;
  d3_1_33 <= d3;
  d4_1_36 <= d4;
  d5_1_39 <= d5;
  d6_1_42 <= d6;
  d7_1_45 <= d7;
  fully_2_1_bit <= d0_1_24 or d1_1_27 or d2_1_30 or d3_1_33 or d4_1_36 or d5_1_39 or d6_1_42 or d7_1_45;
  y <= fully_2_1_bit;
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity concat_2b3acb49f4 is
  port (
    in0 : in std_logic_vector((1 - 1) downto 0);
    in1 : in std_logic_vector((1 - 1) downto 0);
    in2 : in std_logic_vector((1 - 1) downto 0);
    in3 : in std_logic_vector((1 - 1) downto 0);
    in4 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((5 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end concat_2b3acb49f4;


architecture behavior of concat_2b3acb49f4 is
  signal in0_1_23: unsigned((1 - 1) downto 0);
  signal in1_1_27: unsigned((1 - 1) downto 0);
  signal in2_1_31: unsigned((1 - 1) downto 0);
  signal in3_1_35: unsigned((1 - 1) downto 0);
  signal in4_1_39: unsigned((1 - 1) downto 0);
  signal y_2_1_concat: unsigned((5 - 1) downto 0);
begin
  in0_1_23 <= std_logic_vector_to_unsigned(in0);
  in1_1_27 <= std_logic_vector_to_unsigned(in1);
  in2_1_31 <= std_logic_vector_to_unsigned(in2);
  in3_1_35 <= std_logic_vector_to_unsigned(in3);
  in4_1_39 <= std_logic_vector_to_unsigned(in4);
  y_2_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(in0_1_23) & unsigned_to_std_logic_vector(in1_1_27) & unsigned_to_std_logic_vector(in2_1_31) & unsigned_to_std_logic_vector(in3_1_35) & unsigned_to_std_logic_vector(in4_1_39));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity constant_6293007044 is
  port (
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_6293007044;


architecture behavior of constant_6293007044 is
begin
  op <= "1";
end behavior;


-------------------------------------------------------------------
-- System Generator version 10.1.2 VHDL source file.
--
-- Copyright(C) 2008 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2008 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.conv_pkg.all;
entity xlslice is
    generic (
        new_msb      : integer := 9;
        new_lsb      : integer := 1;
        x_width      : integer := 16;
        y_width      : integer := 8);
    port (
        x : in std_logic_vector (x_width-1 downto 0);
        y : out std_logic_vector (y_width-1 downto 0));
end xlslice;
architecture behavior of xlslice is
begin
    y <= x(new_msb downto new_lsb);
end  behavior;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity constant_37567836aa is
  port (
    op : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_37567836aa;


architecture behavior of constant_37567836aa is
begin
  op <= "00000000000000000000000000000000";
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity mux_2c45f290ed is
  port (
    sel : in std_logic_vector((1 - 1) downto 0);
    d0 : in std_logic_vector((16 - 1) downto 0);
    d1 : in std_logic_vector((16 - 1) downto 0);
    y : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end mux_2c45f290ed;


architecture behavior of mux_2c45f290ed is
  signal sel_1_20: std_logic_vector((1 - 1) downto 0);
  signal d0_1_24: std_logic_vector((16 - 1) downto 0);
  signal d1_1_27: std_logic_vector((16 - 1) downto 0);
  signal unregy_join_6_1: std_logic_vector((16 - 1) downto 0);
begin
  sel_1_20 <= sel;
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  proc_switch_6_1: process (d0_1_24, d1_1_27, sel_1_20)
  is
  begin
    case sel_1_20 is 
      when "0" =>
        unregy_join_6_1 <= d0_1_24;
      when others =>
        unregy_join_6_1 <= d1_1_27;
    end case;
  end process proc_switch_6_1;
  y <= unregy_join_6_1;
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity logical_b1e9d7c303 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end logical_b1e9d7c303;


architecture behavior of logical_b1e9d7c303 is
  signal d0_1_24: std_logic_vector((1 - 1) downto 0);
  signal d1_1_27: std_logic_vector((1 - 1) downto 0);
  signal bit_2_26: std_logic_vector((1 - 1) downto 0);
  signal fully_2_1_bitnot: std_logic_vector((1 - 1) downto 0);
begin
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  bit_2_26 <= d0_1_24 or d1_1_27;
  fully_2_1_bitnot <= not bit_2_26;
  y <= fully_2_1_bitnot;
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity accum_2cb0e56e96 is
  port (
    b : in std_logic_vector((1 - 1) downto 0);
    rst : in std_logic_vector((1 - 1) downto 0);
    en : in std_logic_vector((1 - 1) downto 0);
    q : out std_logic_vector((7 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end accum_2cb0e56e96;


architecture behavior of accum_2cb0e56e96 is
  signal b_17_24: unsigned((1 - 1) downto 0);
  signal rst_17_27: boolean;
  signal en_17_32: boolean;
  signal accum_reg_41_23: unsigned((7 - 1) downto 0) := "0000000";
  signal accum_reg_41_23_rst: std_logic;
  signal accum_reg_41_23_en: std_logic;
  signal cast_51_42: unsigned((7 - 1) downto 0);
  signal accum_reg_join_47_1: unsigned((8 - 1) downto 0);
  signal accum_reg_join_47_1_en: std_logic;
  signal accum_reg_join_47_1_rst: std_logic;
begin
  b_17_24 <= std_logic_vector_to_unsigned(b);
  rst_17_27 <= ((rst) = "1");
  en_17_32 <= ((en) = "1");
  proc_accum_reg_41_23: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (accum_reg_41_23_rst = '1')) then
        accum_reg_41_23 <= "0000000";
      elsif ((ce = '1') and (accum_reg_41_23_en = '1')) then 
        accum_reg_41_23 <= accum_reg_41_23 + cast_51_42;
      end if;
    end if;
  end process proc_accum_reg_41_23;
  cast_51_42 <= u2u_cast(b_17_24, 0, 7, 0);
  proc_if_47_1: process (accum_reg_41_23, cast_51_42, en_17_32, rst_17_27)
  is
  begin
    if rst_17_27 then
      accum_reg_join_47_1_rst <= '1';
    elsif en_17_32 then
      accum_reg_join_47_1_rst <= '0';
    else 
      accum_reg_join_47_1_rst <= '0';
    end if;
    if en_17_32 then
      accum_reg_join_47_1_en <= '1';
    else 
      accum_reg_join_47_1_en <= '0';
    end if;
  end process proc_if_47_1;
  accum_reg_41_23_rst <= accum_reg_join_47_1_rst;
  accum_reg_41_23_en <= accum_reg_join_47_1_en;
  q <= unsigned_to_std_logic_vector(accum_reg_41_23);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity accum_be45dd0aa2 is
  port (
    b : in std_logic_vector((1 - 1) downto 0);
    rst : in std_logic_vector((1 - 1) downto 0);
    q : out std_logic_vector((4 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end accum_be45dd0aa2;


architecture behavior of accum_be45dd0aa2 is
  signal b_17_24: unsigned((1 - 1) downto 0);
  signal rst_17_27: boolean;
  signal accum_reg_41_23: unsigned((4 - 1) downto 0) := "0000";
  signal accum_reg_41_23_rst: std_logic;
  signal cast_51_42: unsigned((4 - 1) downto 0);
  signal accum_reg_join_47_1: unsigned((5 - 1) downto 0);
  signal accum_reg_join_47_1_rst: std_logic;
begin
  b_17_24 <= std_logic_vector_to_unsigned(b);
  rst_17_27 <= ((rst) = "1");
  proc_accum_reg_41_23: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (accum_reg_41_23_rst = '1')) then
        accum_reg_41_23 <= "0000";
      elsif (ce = '1') then 
        accum_reg_41_23 <= accum_reg_41_23 + cast_51_42;
      end if;
    end if;
  end process proc_accum_reg_41_23;
  cast_51_42 <= u2u_cast(b_17_24, 0, 4, 0);
  proc_if_47_1: process (accum_reg_41_23, cast_51_42, rst_17_27)
  is
  begin
    if rst_17_27 then
      accum_reg_join_47_1_rst <= '1';
    else 
      accum_reg_join_47_1_rst <= '0';
    end if;
  end process proc_if_47_1;
  accum_reg_41_23_rst <= accum_reg_join_47_1_rst;
  q <= unsigned_to_std_logic_vector(accum_reg_41_23);
end behavior;


-------------------------------------------------------------------
-- System Generator version 10.1.2 VHDL source file.
--
-- Copyright(C) 2008 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2008 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
-- synopsys translate_off
library XilinxCoreLib;
-- synopsys translate_on
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.conv_pkg.all;
entity xladdsub is
  generic (
    core_name0: string := "";
    a_width: integer := 16;
    a_bin_pt: integer := 4;
    a_arith: integer := xlUnsigned;
    c_in_width: integer := 16;
    c_in_bin_pt: integer := 4;
    c_in_arith: integer := xlUnsigned;
    c_out_width: integer := 16;
    c_out_bin_pt: integer := 4;
    c_out_arith: integer := xlUnsigned;
    b_width: integer := 8;
    b_bin_pt: integer := 2;
    b_arith: integer := xlUnsigned;
    s_width: integer := 17;
    s_bin_pt: integer := 4;
    s_arith: integer := xlUnsigned;
    rst_width: integer := 1;
    rst_bin_pt: integer := 0;
    rst_arith: integer := xlUnsigned;
    en_width: integer := 1;
    en_bin_pt: integer := 0;
    en_arith: integer := xlUnsigned;
    full_s_width: integer := 17;
    full_s_arith: integer := xlUnsigned;
    mode: integer := xlAddMode;
    extra_registers: integer := 0;
    latency: integer := 0;
    quantization: integer := xlTruncate;
    overflow: integer := xlWrap;
    c_latency: integer := 0;
    c_output_width: integer := 17;
    c_has_q : integer := 1;
    c_has_s : integer := 0;
    c_has_c_out : integer := 0;
    c_has_q_c_out : integer := 0;
    c_has_b_out : integer := 0;
    c_has_q_b_out : integer := 0;
    c_has_q_ovfl : integer := 0;
    c_has_ovfl : integer := 0
  );
  port (
    a: in std_logic_vector(a_width - 1 downto 0);
    b: in std_logic_vector(b_width - 1 downto 0);
    c_in : in std_logic_vector (0 downto 0) := "0";
    ce: in std_logic;
    clr: in std_logic := '0';
    clk: in std_logic;
    rst: in std_logic_vector(rst_width - 1 downto 0) := "0";
    en: in std_logic_vector(en_width - 1 downto 0) := "1";
    c_out : out std_logic_vector (0 downto 0);
    s: out std_logic_vector(s_width - 1 downto 0)
  );
end xladdsub ;
architecture behavior of xladdsub is

  component synth_reg
    generic (
      width: integer := 16;
      latency: integer := 5
    );
    port (
      i: in std_logic_vector(width - 1 downto 0);
      ce: in std_logic;
      clr: in std_logic;
      clk: in std_logic;
      o: out std_logic_vector(width - 1 downto 0)
    );
  end component;
  function format_input(inp: std_logic_vector; old_width, delta, new_arith,
                        new_width: integer)
    return std_logic_vector
  is
    variable vec: std_logic_vector(old_width-1 downto 0);
    variable padded_inp: std_logic_vector((old_width + delta)-1  downto 0);
    variable result: std_logic_vector(new_width-1 downto 0);
  begin
    vec := inp;
    if delta > 0 then
      padded_inp := pad_LSB(vec, old_width+delta);
      result := extend_MSB(padded_inp, new_width, new_arith);
    else
      result := extend_MSB(vec, new_width, new_arith);
    end if;
    return result;
  end;
  constant full_s_bin_pt: integer := fractional_bits(a_bin_pt, b_bin_pt);
  constant full_a_width: integer := full_s_width;
  constant full_b_width: integer := full_s_width;
  signal full_a: std_logic_vector(full_a_width - 1 downto 0);
  signal full_b: std_logic_vector(full_b_width - 1 downto 0);
  signal core_s: std_logic_vector(full_s_width - 1 downto 0);
  signal conv_s: std_logic_vector(s_width - 1 downto 0);
  signal temp_cout : std_logic;
  signal internal_clr: std_logic;
  signal internal_ce: std_logic;
  signal extra_reg_ce: std_logic;
  signal override: std_logic;
  signal logic1: std_logic_vector(0 downto 0);
  component adder_subtracter_virtex2p_7_0_cf28bbebd75d9ce3
    port (
      a: in std_logic_vector( 9 - 1 downto 0);
      s: out std_logic_vector(c_output_width - 1 downto 0);
      b: in std_logic_vector(9 - 1 downto 0)
    );
  end component;
  attribute syn_black_box of adder_subtracter_virtex2p_7_0_cf28bbebd75d9ce3:
    component is true;
  attribute fpga_dont_touch of adder_subtracter_virtex2p_7_0_cf28bbebd75d9ce3:
    component is "true";
  attribute box_type of adder_subtracter_virtex2p_7_0_cf28bbebd75d9ce3:
    component  is "black_box";
  component adder_subtracter_virtex2p_7_0_453ed16ba8e84295
    port (
      a: in std_logic_vector( 9 - 1 downto 0);
      s: out std_logic_vector(c_output_width - 1 downto 0);
      b: in std_logic_vector(9 - 1 downto 0)
    );
  end component;
  attribute syn_black_box of adder_subtracter_virtex2p_7_0_453ed16ba8e84295:
    component is true;
  attribute fpga_dont_touch of adder_subtracter_virtex2p_7_0_453ed16ba8e84295:
    component is "true";
  attribute box_type of adder_subtracter_virtex2p_7_0_453ed16ba8e84295:
    component  is "black_box";
  component adder_subtracter_virtex2p_7_0_7182743c9e7adf5e
    port (
      a: in std_logic_vector( 5 - 1 downto 0);
      s: out std_logic_vector(c_output_width - 1 downto 0);
      b: in std_logic_vector(5 - 1 downto 0)
    );
  end component;
  attribute syn_black_box of adder_subtracter_virtex2p_7_0_7182743c9e7adf5e:
    component is true;
  attribute fpga_dont_touch of adder_subtracter_virtex2p_7_0_7182743c9e7adf5e:
    component is "true";
  attribute box_type of adder_subtracter_virtex2p_7_0_7182743c9e7adf5e:
    component  is "black_box";
begin
  internal_clr <= (clr or (rst(0))) and ce;
  internal_ce <= ce and en(0);
  logic1(0) <= '1';
  addsub_process: process(a, b, core_s)
  begin
    full_a <= format_input(a, a_width, b_bin_pt - a_bin_pt, a_arith,
                           full_a_width);
    full_b <= format_input(b, b_width, a_bin_pt - b_bin_pt, b_arith,
                           full_b_width);
    conv_s <= convert_type(core_s, full_s_width, full_s_bin_pt, full_s_arith,
                           s_width, s_bin_pt, s_arith, quantization, overflow);
  end process addsub_process;

  comp0: if ((core_name0 = "adder_subtracter_virtex2p_7_0_cf28bbebd75d9ce3")) generate
    core_instance0: adder_subtracter_virtex2p_7_0_cf28bbebd75d9ce3
      port map (
        a => full_a,
        s => core_s,
        b => full_b
      );
  end generate;
  comp1: if ((core_name0 = "adder_subtracter_virtex2p_7_0_453ed16ba8e84295")) generate
    core_instance1: adder_subtracter_virtex2p_7_0_453ed16ba8e84295
      port map (
        a => full_a,
        s => core_s,
        b => full_b
      );
  end generate;
  comp2: if ((core_name0 = "adder_subtracter_virtex2p_7_0_7182743c9e7adf5e")) generate
    core_instance2: adder_subtracter_virtex2p_7_0_7182743c9e7adf5e
      port map (
        a => full_a,
        s => core_s,
        b => full_b
      );
  end generate;
  latency_test: if (extra_registers > 0) generate
      override_test: if (c_latency > 1) generate
       override_pipe: synth_reg
          generic map (
            width => 1,
            latency => c_latency)
          port map (
            i => logic1,
            ce => internal_ce,
            clr => internal_clr,
            clk => clk,
            o(0) => override);
       extra_reg_ce <= ce and en(0) and override;
      end generate override_test;
      no_override: if (c_latency = 0) or (c_latency = 1) generate
       extra_reg_ce <= ce and en(0);
      end generate no_override;
      extra_reg: synth_reg
        generic map (
          width => s_width,
          latency => extra_registers
        )
        port map (
          i => conv_s,
          ce => extra_reg_ce,
          clr => internal_clr,
          clk => clk,
          o => s
        );
      cout_test : if((c_has_c_out = 1) or
                (c_has_b_out = 1) or
                (c_has_q_c_out = 1) or
                (c_has_q_b_out = 1)) generate
      c_out_extra_reg: synth_reg
        generic map (
          width => 1,
          latency => extra_registers
        )
        port map (
          i(0) => temp_cout,
          ce => extra_reg_ce,
          clr => internal_clr,
          clk => clk,
          o => c_out
        );
      end generate cout_test;
  end generate;
  latency_s: if  ((latency = 0) or (extra_registers = 0))  generate
    s <= conv_s;
  end generate latency_s;
  latency0: if ( ((latency = 0) or (extra_registers = 0)) and
                ((c_has_b_out = 1) or
                (c_has_q_c_out = 1) or
                (c_has_c_out = 1) or
                (c_has_q_b_out = 1)))  generate
    c_out(0) <= temp_cout;
  end generate latency0;
  tie_dangling_cout: if ((c_has_c_out = 0) and
                        (c_has_b_out = 0) and
                        (c_has_q_c_out = 0) and
                        (c_has_q_b_out = 0)) generate
    c_out <= "0";
  end generate tie_dangling_cout;
end architecture behavior;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity concat_f62149b02a is
  port (
    in0 : in std_logic_vector((2 - 1) downto 0);
    in1 : in std_logic_vector((7 - 1) downto 0);
    y : out std_logic_vector((9 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end concat_f62149b02a;


architecture behavior of concat_f62149b02a is
  signal in0_1_23: unsigned((2 - 1) downto 0);
  signal in1_1_27: unsigned((7 - 1) downto 0);
  signal y_2_1_concat: unsigned((9 - 1) downto 0);
begin
  in0_1_23 <= std_logic_vector_to_unsigned(in0);
  in1_1_27 <= std_logic_vector_to_unsigned(in1);
  y_2_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(in0_1_23) & unsigned_to_std_logic_vector(in1_1_27));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity concat_1ece14600f is
  port (
    in0 : in std_logic_vector((1 - 1) downto 0);
    in1 : in std_logic_vector((8 - 1) downto 0);
    y : out std_logic_vector((9 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end concat_1ece14600f;


architecture behavior of concat_1ece14600f is
  signal in0_1_23: unsigned((1 - 1) downto 0);
  signal in1_1_27: unsigned((8 - 1) downto 0);
  signal y_2_1_concat: unsigned((9 - 1) downto 0);
begin
  in0_1_23 <= std_logic_vector_to_unsigned(in0);
  in1_1_27 <= std_logic_vector_to_unsigned(in1);
  y_2_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(in0_1_23) & unsigned_to_std_logic_vector(in1_1_27));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity constant_443ed96427 is
  port (
    op : out std_logic_vector((9 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_443ed96427;


architecture behavior of constant_443ed96427 is
begin
  op <= "101011100";
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity constant_145086465d is
  port (
    op : out std_logic_vector((4 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_145086465d;


architecture behavior of constant_145086465d is
begin
  op <= "1000";
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity constant_fb9f6d3796 is
  port (
    op : out std_logic_vector((9 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_fb9f6d3796;


architecture behavior of constant_fb9f6d3796 is
begin
  op <= "100010101";
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity constant_09a4afb2ee is
  port (
    op : out std_logic_vector((9 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_09a4afb2ee;


architecture behavior of constant_09a4afb2ee is
begin
  op <= "101110101";
end behavior;


-------------------------------------------------------------------
-- System Generator version 10.1.2 VHDL source file.
--
-- Copyright(C) 2008 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2008 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
-- synopsys translate_off
library XilinxCoreLib;
-- synopsys translate_on
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity xlcounter_limit is
  generic (
    core_name0: string := "";
    op_width: integer := 5;
    op_arith: integer := xlSigned;
    cnt_63_48: integer:= 0;
    cnt_47_32: integer:= 0;
    cnt_31_16: integer:= 0;
    cnt_15_0: integer:= 0;
    count_limited: integer := 0
  );
  port (
    ce: in std_logic;
    clr: in std_logic;
    clk: in std_logic;
    op: out std_logic_vector(op_width - 1 downto 0);
    up: in std_logic_vector(0 downto 0) := (others => '0');
    en: in std_logic_vector(0 downto 0);
    rst: in std_logic_vector(0 downto 0)
  );
end xlcounter_limit ;
architecture behavior of xlcounter_limit is
  signal high_cnt_to: std_logic_vector(31 downto 0);
  signal low_cnt_to: std_logic_vector(31 downto 0);
  signal cnt_to: std_logic_vector(63 downto 0);
  signal core_sinit, op_thresh0, core_ce: std_logic;
  signal rst_overrides_en: std_logic;
  signal op_net: std_logic_vector(op_width - 1 downto 0);
  -- synopsys translate_off
  signal real_op : real;
   -- synopsys translate_on
  function equals(op, cnt_to : std_logic_vector; width, arith : integer)
    return std_logic
  is
    variable signed_op, signed_cnt_to : signed (width - 1 downto 0);
    variable unsigned_op, unsigned_cnt_to : unsigned (width - 1 downto 0);
    variable result : std_logic;
  begin
    -- synopsys translate_off
    if ((is_XorU(op)) or (is_XorU(cnt_to)) ) then
      result := '0';
      return result;
    end if;
    -- synopsys translate_on
    if (op = cnt_to) then
      result := '1';
    else
      result := '0';
    end if;
    return result;
  end;
  component binary_counter_virtex2p_7_0_32a1863440903b9d
    port (
      clk: in std_logic;
      ce: in std_logic;
      sinit: in std_logic;
      q: out std_logic_vector(op_width - 1 downto 0)
    );
  end component;
  attribute syn_black_box of binary_counter_virtex2p_7_0_32a1863440903b9d:
    component is true;
  attribute fpga_dont_touch of binary_counter_virtex2p_7_0_32a1863440903b9d:
    component is "true";
  attribute box_type of binary_counter_virtex2p_7_0_32a1863440903b9d:
    component  is "black_box";
  component binary_counter_virtex2p_7_0_23542cbcca0efa2e
    port (
      clk: in std_logic;
      ce: in std_logic;
      sinit: in std_logic;
      q: out std_logic_vector(op_width - 1 downto 0)
    );
  end component;
  attribute syn_black_box of binary_counter_virtex2p_7_0_23542cbcca0efa2e:
    component is true;
  attribute fpga_dont_touch of binary_counter_virtex2p_7_0_23542cbcca0efa2e:
    component is "true";
  attribute box_type of binary_counter_virtex2p_7_0_23542cbcca0efa2e:
    component  is "black_box";
-- synopsys translate_off
  constant zeroVec : std_logic_vector(op_width - 1 downto 0) := (others => '0');
  constant oneVec : std_logic_vector(op_width - 1 downto 0) := (others => '1');
  constant zeroStr : string(1 to op_width) :=
    std_logic_vector_to_bin_string(zeroVec);
  constant oneStr : string(1 to op_width) :=
    std_logic_vector_to_bin_string(oneVec);
-- synopsys translate_on
begin
  -- synopsys translate_off
  -- synopsys translate_on
  cnt_to(63 downto 48) <= integer_to_std_logic_vector(cnt_63_48, 16, op_arith);
  cnt_to(47 downto 32) <= integer_to_std_logic_vector(cnt_47_32, 16, op_arith);
  cnt_to(31 downto 16) <= integer_to_std_logic_vector(cnt_31_16, 16, op_arith);
  cnt_to(15 downto 0) <= integer_to_std_logic_vector(cnt_15_0, 16, op_arith);
  op <= op_net;
  core_ce <= ce and en(0);
  rst_overrides_en <= rst(0) or en(0);
  limit : if (count_limited = 1) generate
    eq_cnt_to : process (op_net, cnt_to)
    begin
      op_thresh0 <= equals(op_net, cnt_to(op_width - 1 downto 0),
                     op_width, op_arith);
    end process;
    core_sinit <= (op_thresh0 or clr or rst(0)) and ce and rst_overrides_en;
  end generate;
  no_limit : if (count_limited = 0) generate
    core_sinit <= (clr or rst(0)) and ce and rst_overrides_en;
  end generate;
  comp0: if ((core_name0 = "binary_counter_virtex2p_7_0_32a1863440903b9d")) generate
    core_instance0: binary_counter_virtex2p_7_0_32a1863440903b9d
      port map (
        clk => clk,
        ce => core_ce,
        sinit => core_sinit,
        q => op_net
      );
  end generate;
  comp1: if ((core_name0 = "binary_counter_virtex2p_7_0_23542cbcca0efa2e")) generate
    core_instance1: binary_counter_virtex2p_7_0_23542cbcca0efa2e
      port map (
        clk => clk,
        ce => core_ce,
        sinit => core_sinit,
        q => op_net
      );
  end generate;
end  behavior;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity inverter_e5b38cca3b is
  port (
    ip : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end inverter_e5b38cca3b;


architecture behavior of inverter_e5b38cca3b is
  signal ip_1_26: boolean;
  type array_type_op_mem_22_20 is array (0 to (1 - 1)) of boolean;
  signal op_mem_22_20: array_type_op_mem_22_20 := (
    0 => false);
  signal op_mem_22_20_front_din: boolean;
  signal op_mem_22_20_back: boolean;
  signal op_mem_22_20_push_front_pop_back_en: std_logic;
  signal internal_ip_12_1_bitnot: boolean;
begin
  ip_1_26 <= ((ip) = "1");
  op_mem_22_20_back <= op_mem_22_20(0);
  proc_op_mem_22_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_22_20_push_front_pop_back_en = '1')) then
        op_mem_22_20(0) <= op_mem_22_20_front_din;
      end if;
    end if;
  end process proc_op_mem_22_20;
  internal_ip_12_1_bitnot <= ((not boolean_to_vector(ip_1_26)) = "1");
  op_mem_22_20_push_front_pop_back_en <= '0';
  op <= boolean_to_vector(internal_ip_12_1_bitnot);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity logical_aacf6e1b0e is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end logical_aacf6e1b0e;


architecture behavior of logical_aacf6e1b0e is
  signal d0_1_24: std_logic;
  signal d1_1_27: std_logic;
  signal fully_2_1_bit: std_logic;
begin
  d0_1_24 <= d0(0);
  d1_1_27 <= d1(0);
  fully_2_1_bit <= d0_1_24 or d1_1_27;
  y <= std_logic_to_vector(fully_2_1_bit);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity logical_80f90b97d0 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end logical_80f90b97d0;


architecture behavior of logical_80f90b97d0 is
  signal d0_1_24: std_logic;
  signal d1_1_27: std_logic;
  signal fully_2_1_bit: std_logic;
begin
  d0_1_24 <= d0(0);
  d1_1_27 <= d1(0);
  fully_2_1_bit <= d0_1_24 and d1_1_27;
  y <= std_logic_to_vector(fully_2_1_bit);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity mux_d99e59b6d4 is
  port (
    sel : in std_logic_vector((1 - 1) downto 0);
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end mux_d99e59b6d4;


architecture behavior of mux_d99e59b6d4 is
  signal sel_1_20: std_logic;
  signal d0_1_24: std_logic;
  signal d1_1_27: std_logic;
  signal sel_internal_2_1_convert: std_logic_vector((1 - 1) downto 0);
  signal unregy_join_6_1: std_logic;
begin
  sel_1_20 <= sel(0);
  d0_1_24 <= d0(0);
  d1_1_27 <= d1(0);
  sel_internal_2_1_convert <= cast(std_logic_to_vector(sel_1_20), 0, 1, 0, xlUnsigned);
  proc_switch_6_1: process (d0_1_24, d1_1_27, sel_internal_2_1_convert)
  is
  begin
    case sel_internal_2_1_convert is 
      when "0" =>
        unregy_join_6_1 <= d0_1_24;
      when others =>
        unregy_join_6_1 <= d1_1_27;
    end case;
  end process proc_switch_6_1;
  y <= std_logic_to_vector(unregy_join_6_1);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity mux_1f00a411aa is
  port (
    sel : in std_logic_vector((4 - 1) downto 0);
    d0 : in std_logic_vector((9 - 1) downto 0);
    d1 : in std_logic_vector((9 - 1) downto 0);
    d2 : in std_logic_vector((9 - 1) downto 0);
    d3 : in std_logic_vector((9 - 1) downto 0);
    d4 : in std_logic_vector((9 - 1) downto 0);
    d5 : in std_logic_vector((9 - 1) downto 0);
    d6 : in std_logic_vector((9 - 1) downto 0);
    d7 : in std_logic_vector((9 - 1) downto 0);
    d8 : in std_logic_vector((9 - 1) downto 0);
    y : out std_logic_vector((9 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end mux_1f00a411aa;


architecture behavior of mux_1f00a411aa is
  signal sel_1_20: std_logic_vector((4 - 1) downto 0);
  signal d0_1_24: std_logic_vector((9 - 1) downto 0);
  signal d1_1_27: std_logic_vector((9 - 1) downto 0);
  signal d2_1_30: std_logic_vector((9 - 1) downto 0);
  signal d3_1_33: std_logic_vector((9 - 1) downto 0);
  signal d4_1_36: std_logic_vector((9 - 1) downto 0);
  signal d5_1_39: std_logic_vector((9 - 1) downto 0);
  signal d6_1_42: std_logic_vector((9 - 1) downto 0);
  signal d7_1_45: std_logic_vector((9 - 1) downto 0);
  signal d8_1_48: std_logic_vector((9 - 1) downto 0);
  signal unregy_join_6_1: std_logic_vector((9 - 1) downto 0);
begin
  sel_1_20 <= sel;
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  d2_1_30 <= d2;
  d3_1_33 <= d3;
  d4_1_36 <= d4;
  d5_1_39 <= d5;
  d6_1_42 <= d6;
  d7_1_45 <= d7;
  d8_1_48 <= d8;
  proc_switch_6_1: process (d0_1_24, d1_1_27, d2_1_30, d3_1_33, d4_1_36, d5_1_39, d6_1_42, d7_1_45, d8_1_48, sel_1_20)
  is
  begin
    case sel_1_20 is 
      when "0000" =>
        unregy_join_6_1 <= d0_1_24;
      when "0001" =>
        unregy_join_6_1 <= d1_1_27;
      when "0010" =>
        unregy_join_6_1 <= d2_1_30;
      when "0011" =>
        unregy_join_6_1 <= d3_1_33;
      when "0100" =>
        unregy_join_6_1 <= d4_1_36;
      when "0101" =>
        unregy_join_6_1 <= d5_1_39;
      when "0110" =>
        unregy_join_6_1 <= d6_1_42;
      when "0111" =>
        unregy_join_6_1 <= d7_1_45;
      when others =>
        unregy_join_6_1 <= d8_1_48;
    end case;
  end process proc_switch_6_1;
  y <= unregy_join_6_1;
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity relational_92c392c8b6 is
  port (
    a : in std_logic_vector((7 - 1) downto 0);
    b : in std_logic_vector((9 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end relational_92c392c8b6;


architecture behavior of relational_92c392c8b6 is
  signal a_1_31: unsigned((7 - 1) downto 0);
  signal b_1_34: signed((9 - 1) downto 0);
  type array_type_op_mem_32_22 is array (0 to (1 - 1)) of boolean;
  signal op_mem_32_22: array_type_op_mem_32_22 := (
    0 => false);
  signal op_mem_32_22_front_din: boolean;
  signal op_mem_32_22_back: boolean;
  signal op_mem_32_22_push_front_pop_back_en: std_logic;
  signal cast_20_12: signed((9 - 1) downto 0);
  signal result_20_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_signed(b);
  op_mem_32_22_back <= op_mem_32_22(0);
  proc_op_mem_32_22: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_32_22_push_front_pop_back_en = '1')) then
        op_mem_32_22(0) <= op_mem_32_22_front_din;
      end if;
    end if;
  end process proc_op_mem_32_22;
  cast_20_12 <= u2s_cast(a_1_31, 0, 9, 0);
  result_20_3_rel <= cast_20_12 <= b_1_34;
  op_mem_32_22_front_din <= result_20_3_rel;
  op_mem_32_22_push_front_pop_back_en <= '1';
  op <= boolean_to_vector(op_mem_32_22_back);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity relational_fb96203f91 is
  port (
    a : in std_logic_vector((4 - 1) downto 0);
    b : in std_logic_vector((4 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end relational_fb96203f91;


architecture behavior of relational_fb96203f91 is
  signal a_1_31: unsigned((4 - 1) downto 0);
  signal b_1_34: unsigned((4 - 1) downto 0);
  signal result_16_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  result_16_3_rel <= a_1_31 < b_1_34;
  op <= boolean_to_vector(result_16_3_rel);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity mux_998e20a1ca is
  port (
    sel : in std_logic_vector((2 - 1) downto 0);
    d0 : in std_logic_vector((8 - 1) downto 0);
    d1 : in std_logic_vector((8 - 1) downto 0);
    d2 : in std_logic_vector((8 - 1) downto 0);
    d3 : in std_logic_vector((8 - 1) downto 0);
    y : out std_logic_vector((8 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end mux_998e20a1ca;


architecture behavior of mux_998e20a1ca is
  signal sel_1_20: std_logic_vector((2 - 1) downto 0);
  signal d0_1_24: std_logic_vector((8 - 1) downto 0);
  signal d1_1_27: std_logic_vector((8 - 1) downto 0);
  signal d2_1_30: std_logic_vector((8 - 1) downto 0);
  signal d3_1_33: std_logic_vector((8 - 1) downto 0);
  signal unregy_join_6_1: std_logic_vector((8 - 1) downto 0);
begin
  sel_1_20 <= sel;
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  d2_1_30 <= d2;
  d3_1_33 <= d3;
  proc_switch_6_1: process (d0_1_24, d1_1_27, d2_1_30, d3_1_33, sel_1_20)
  is
  begin
    case sel_1_20 is 
      when "00" =>
        unregy_join_6_1 <= d0_1_24;
      when "01" =>
        unregy_join_6_1 <= d1_1_27;
      when "10" =>
        unregy_join_6_1 <= d2_1_30;
      when others =>
        unregy_join_6_1 <= d3_1_33;
    end case;
  end process proc_switch_6_1;
  y <= unregy_join_6_1;
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity concat_32864ba5d6 is
  port (
    in0 : in std_logic_vector((4 - 1) downto 0);
    in1 : in std_logic_vector((3 - 1) downto 0);
    y : out std_logic_vector((7 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end concat_32864ba5d6;


architecture behavior of concat_32864ba5d6 is
  signal in0_1_23: unsigned((4 - 1) downto 0);
  signal in1_1_27: unsigned((3 - 1) downto 0);
  signal y_2_1_concat: unsigned((7 - 1) downto 0);
begin
  in0_1_23 <= std_logic_vector_to_unsigned(in0);
  in1_1_27 <= std_logic_vector_to_unsigned(in1);
  y_2_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(in0_1_23) & unsigned_to_std_logic_vector(in1_1_27));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity constant_822933f89b is
  port (
    op : out std_logic_vector((3 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_822933f89b;


architecture behavior of constant_822933f89b is
begin
  op <= "000";
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity constant_21d4a28b7e is
  port (
    op : out std_logic_vector((8 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_21d4a28b7e;


architecture behavior of constant_21d4a28b7e is
begin
  op <= "00000011";
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity constant_b940b9054a is
  port (
    op : out std_logic_vector((8 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_b940b9054a;


architecture behavior of constant_b940b9054a is
begin
  op <= "00001010";
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity concat_78218439f3 is
  port (
    in0 : in std_logic_vector((3 - 1) downto 0);
    in1 : in std_logic_vector((4 - 1) downto 0);
    in2 : in std_logic_vector((4 - 1) downto 0);
    y : out std_logic_vector((11 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end concat_78218439f3;


architecture behavior of concat_78218439f3 is
  signal in0_1_23: unsigned((3 - 1) downto 0);
  signal in1_1_27: unsigned((4 - 1) downto 0);
  signal in2_1_31: unsigned((4 - 1) downto 0);
  signal y_2_1_concat: unsigned((11 - 1) downto 0);
begin
  in0_1_23 <= std_logic_vector_to_unsigned(in0);
  in1_1_27 <= std_logic_vector_to_unsigned(in1);
  in2_1_31 <= std_logic_vector_to_unsigned(in2);
  y_2_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(in0_1_23) & unsigned_to_std_logic_vector(in1_1_27) & unsigned_to_std_logic_vector(in2_1_31));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity concat_25ab81b400 is
  port (
    in0 : in std_logic_vector((8 - 1) downto 0);
    in1 : in std_logic_vector((6 - 1) downto 0);
    y : out std_logic_vector((14 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end concat_25ab81b400;


architecture behavior of concat_25ab81b400 is
  signal in0_1_23: unsigned((8 - 1) downto 0);
  signal in1_1_27: unsigned((6 - 1) downto 0);
  signal y_2_1_concat: unsigned((14 - 1) downto 0);
begin
  in0_1_23 <= std_logic_vector_to_unsigned(in0);
  in1_1_27 <= std_logic_vector_to_unsigned(in1);
  y_2_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(in0_1_23) & unsigned_to_std_logic_vector(in1_1_27));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity concat_e6f5ee726b is
  port (
    in0 : in std_logic_vector((1 - 1) downto 0);
    in1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((2 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end concat_e6f5ee726b;


architecture behavior of concat_e6f5ee726b is
  signal in0_1_23: unsigned((1 - 1) downto 0);
  signal in1_1_27: unsigned((1 - 1) downto 0);
  signal y_2_1_concat: unsigned((2 - 1) downto 0);
begin
  in0_1_23 <= std_logic_vector_to_unsigned(in0);
  in1_1_27 <= std_logic_vector_to_unsigned(in1);
  y_2_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(in0_1_23) & unsigned_to_std_logic_vector(in1_1_27));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity constant_469094441c is
  port (
    op : out std_logic_vector((3 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_469094441c;


architecture behavior of constant_469094441c is
begin
  op <= "100";
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity constant_a1c496ea88 is
  port (
    op : out std_logic_vector((3 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_a1c496ea88;


architecture behavior of constant_a1c496ea88 is
begin
  op <= "001";
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity mux_2ec2057ae3 is
  port (
    sel : in std_logic_vector((2 - 1) downto 0);
    d0 : in std_logic_vector((3 - 1) downto 0);
    d1 : in std_logic_vector((3 - 1) downto 0);
    d2 : in std_logic_vector((3 - 1) downto 0);
    d3 : in std_logic_vector((3 - 1) downto 0);
    y : out std_logic_vector((3 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end mux_2ec2057ae3;


architecture behavior of mux_2ec2057ae3 is
  signal sel_1_20: std_logic_vector((2 - 1) downto 0);
  signal d0_1_24: std_logic_vector((3 - 1) downto 0);
  signal d1_1_27: std_logic_vector((3 - 1) downto 0);
  signal d2_1_30: std_logic_vector((3 - 1) downto 0);
  signal d3_1_33: std_logic_vector((3 - 1) downto 0);
  signal unregy_join_6_1: std_logic_vector((3 - 1) downto 0);
begin
  sel_1_20 <= sel;
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  d2_1_30 <= d2;
  d3_1_33 <= d3;
  proc_switch_6_1: process (d0_1_24, d1_1_27, d2_1_30, d3_1_33, sel_1_20)
  is
  begin
    case sel_1_20 is 
      when "00" =>
        unregy_join_6_1 <= d0_1_24;
      when "01" =>
        unregy_join_6_1 <= d1_1_27;
      when "10" =>
        unregy_join_6_1 <= d2_1_30;
      when others =>
        unregy_join_6_1 <= d3_1_33;
    end case;
  end process proc_switch_6_1;
  y <= unregy_join_6_1;
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity mux_7586447000 is
  port (
    sel : in std_logic_vector((3 - 1) downto 0);
    d0 : in std_logic_vector((9 - 1) downto 0);
    d1 : in std_logic_vector((9 - 1) downto 0);
    d2 : in std_logic_vector((9 - 1) downto 0);
    d3 : in std_logic_vector((9 - 1) downto 0);
    d4 : in std_logic_vector((9 - 1) downto 0);
    d5 : in std_logic_vector((9 - 1) downto 0);
    d6 : in std_logic_vector((9 - 1) downto 0);
    d7 : in std_logic_vector((9 - 1) downto 0);
    y : out std_logic_vector((9 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end mux_7586447000;


architecture behavior of mux_7586447000 is
  signal sel_1_20: std_logic_vector((3 - 1) downto 0);
  signal d0_1_24: std_logic_vector((9 - 1) downto 0);
  signal d1_1_27: std_logic_vector((9 - 1) downto 0);
  signal d2_1_30: std_logic_vector((9 - 1) downto 0);
  signal d3_1_33: std_logic_vector((9 - 1) downto 0);
  signal d4_1_36: std_logic_vector((9 - 1) downto 0);
  signal d5_1_39: std_logic_vector((9 - 1) downto 0);
  signal d6_1_42: std_logic_vector((9 - 1) downto 0);
  signal d7_1_45: std_logic_vector((9 - 1) downto 0);
  signal unregy_join_6_1: std_logic_vector((9 - 1) downto 0);
begin
  sel_1_20 <= sel;
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  d2_1_30 <= d2;
  d3_1_33 <= d3;
  d4_1_36 <= d4;
  d5_1_39 <= d5;
  d6_1_42 <= d6;
  d7_1_45 <= d7;
  proc_switch_6_1: process (d0_1_24, d1_1_27, d2_1_30, d3_1_33, d4_1_36, d5_1_39, d6_1_42, d7_1_45, sel_1_20)
  is
  begin
    case sel_1_20 is 
      when "000" =>
        unregy_join_6_1 <= d0_1_24;
      when "001" =>
        unregy_join_6_1 <= d1_1_27;
      when "010" =>
        unregy_join_6_1 <= d2_1_30;
      when "011" =>
        unregy_join_6_1 <= d3_1_33;
      when "100" =>
        unregy_join_6_1 <= d4_1_36;
      when "101" =>
        unregy_join_6_1 <= d5_1_39;
      when "110" =>
        unregy_join_6_1 <= d6_1_42;
      when others =>
        unregy_join_6_1 <= d7_1_45;
    end case;
  end process proc_switch_6_1;
  y <= unregy_join_6_1;
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity relational_f7cb2b0c31 is
  port (
    a : in std_logic_vector((6 - 1) downto 0);
    b : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end relational_f7cb2b0c31;


architecture behavior of relational_f7cb2b0c31 is
  signal a_1_31: unsigned((6 - 1) downto 0);
  signal b_1_34: unsigned((1 - 1) downto 0);
  signal cast_12_17: unsigned((6 - 1) downto 0);
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  cast_12_17 <= u2u_cast(b_1_34, 0, 6, 0);
  result_12_3_rel <= a_1_31 = cast_12_17;
  op <= boolean_to_vector(result_12_3_rel);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity relational_ee03197e2c is
  port (
    a : in std_logic_vector((4 - 1) downto 0);
    b : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end relational_ee03197e2c;


architecture behavior of relational_ee03197e2c is
  signal a_1_31: unsigned((4 - 1) downto 0);
  signal b_1_34: unsigned((1 - 1) downto 0);
  signal cast_12_17: unsigned((4 - 1) downto 0);
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  cast_12_17 <= u2u_cast(b_1_34, 0, 4, 0);
  result_12_3_rel <= a_1_31 = cast_12_17;
  op <= boolean_to_vector(result_12_3_rel);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity relational_04b069dd89 is
  port (
    a : in std_logic_vector((3 - 1) downto 0);
    b : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end relational_04b069dd89;


architecture behavior of relational_04b069dd89 is
  signal a_1_31: unsigned((3 - 1) downto 0);
  signal b_1_34: unsigned((1 - 1) downto 0);
  signal cast_12_17: unsigned((3 - 1) downto 0);
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  cast_12_17 <= u2u_cast(b_1_34, 0, 3, 0);
  result_12_3_rel <= a_1_31 = cast_12_17;
  op <= boolean_to_vector(result_12_3_rel);
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity mux_8e3eece8f2 is
  port (
    sel : in std_logic_vector((4 - 1) downto 0);
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    d2 : in std_logic_vector((1 - 1) downto 0);
    d3 : in std_logic_vector((1 - 1) downto 0);
    d4 : in std_logic_vector((1 - 1) downto 0);
    d5 : in std_logic_vector((1 - 1) downto 0);
    d6 : in std_logic_vector((1 - 1) downto 0);
    d7 : in std_logic_vector((1 - 1) downto 0);
    d8 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end mux_8e3eece8f2;


architecture behavior of mux_8e3eece8f2 is
  signal sel_1_20: std_logic_vector((4 - 1) downto 0);
  signal d0_1_24: std_logic_vector((1 - 1) downto 0);
  signal d1_1_27: std_logic_vector((1 - 1) downto 0);
  signal d2_1_30: std_logic_vector((1 - 1) downto 0);
  signal d3_1_33: std_logic_vector((1 - 1) downto 0);
  signal d4_1_36: std_logic_vector((1 - 1) downto 0);
  signal d5_1_39: std_logic_vector((1 - 1) downto 0);
  signal d6_1_42: std_logic_vector((1 - 1) downto 0);
  signal d7_1_45: std_logic_vector((1 - 1) downto 0);
  signal d8_1_48: std_logic_vector((1 - 1) downto 0);
  type array_type_pipe_30_22 is array (0 to (1 - 1)) of std_logic_vector((1 - 1) downto 0);
  signal pipe_30_22: array_type_pipe_30_22 := (
    0 => "0");
  signal pipe_30_22_front_din: std_logic_vector((1 - 1) downto 0);
  signal pipe_30_22_back: std_logic_vector((1 - 1) downto 0);
  signal pipe_30_22_push_front_pop_back_en: std_logic;
  signal unregy_join_6_1: std_logic_vector((1 - 1) downto 0);
begin
  sel_1_20 <= sel;
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  d2_1_30 <= d2;
  d3_1_33 <= d3;
  d4_1_36 <= d4;
  d5_1_39 <= d5;
  d6_1_42 <= d6;
  d7_1_45 <= d7;
  d8_1_48 <= d8;
  pipe_30_22_back <= pipe_30_22(0);
  proc_pipe_30_22: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (pipe_30_22_push_front_pop_back_en = '1')) then
        pipe_30_22(0) <= pipe_30_22_front_din;
      end if;
    end if;
  end process proc_pipe_30_22;
  proc_switch_6_1: process (d0_1_24, d1_1_27, d2_1_30, d3_1_33, d4_1_36, d5_1_39, d6_1_42, d7_1_45, d8_1_48, sel_1_20)
  is
  begin
    case sel_1_20 is 
      when "0000" =>
        unregy_join_6_1 <= d0_1_24;
      when "0001" =>
        unregy_join_6_1 <= d1_1_27;
      when "0010" =>
        unregy_join_6_1 <= d2_1_30;
      when "0011" =>
        unregy_join_6_1 <= d3_1_33;
      when "0100" =>
        unregy_join_6_1 <= d4_1_36;
      when "0101" =>
        unregy_join_6_1 <= d5_1_39;
      when "0110" =>
        unregy_join_6_1 <= d6_1_42;
      when "0111" =>
        unregy_join_6_1 <= d7_1_45;
      when others =>
        unregy_join_6_1 <= d8_1_48;
    end case;
  end process proc_switch_6_1;
  pipe_30_22_front_din <= unregy_join_6_1;
  pipe_30_22_push_front_pop_back_en <= '1';
  y <= pipe_30_22_back;
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity logical_938d99ac11 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end logical_938d99ac11;


architecture behavior of logical_938d99ac11 is
  signal d0_1_24: std_logic_vector((1 - 1) downto 0);
  signal d1_1_27: std_logic_vector((1 - 1) downto 0);
  signal fully_2_1_bit: std_logic_vector((1 - 1) downto 0);
begin
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  fully_2_1_bit <= d0_1_24 and d1_1_27;
  y <= fully_2_1_bit;
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity constant_06590e4008 is
  port (
    op : out std_logic_vector((4 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_06590e4008;


architecture behavior of constant_06590e4008 is
begin
  op <= "1111";
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity mux_112ed141f4 is
  port (
    sel : in std_logic_vector((1 - 1) downto 0);
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end mux_112ed141f4;


architecture behavior of mux_112ed141f4 is
  signal sel_1_20: std_logic;
  signal d0_1_24: std_logic_vector((1 - 1) downto 0);
  signal d1_1_27: std_logic_vector((1 - 1) downto 0);
  signal sel_internal_2_1_convert: std_logic_vector((1 - 1) downto 0);
  signal unregy_join_6_1: std_logic_vector((1 - 1) downto 0);
begin
  sel_1_20 <= sel(0);
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  sel_internal_2_1_convert <= cast(std_logic_to_vector(sel_1_20), 0, 1, 0, xlUnsigned);
  proc_switch_6_1: process (d0_1_24, d1_1_27, sel_internal_2_1_convert)
  is
  begin
    case sel_internal_2_1_convert is 
      when "0" =>
        unregy_join_6_1 <= d0_1_24;
      when others =>
        unregy_join_6_1 <= d1_1_27;
    end case;
  end process proc_switch_6_1;
  y <= unregy_join_6_1;
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity logical_3e1f051fb7 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end logical_3e1f051fb7;


architecture behavior of logical_3e1f051fb7 is
  signal d0_1_24: std_logic_vector((1 - 1) downto 0);
  signal d1_1_27: std_logic_vector((1 - 1) downto 0);
  signal fully_2_1_bit: std_logic_vector((1 - 1) downto 0);
begin
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  fully_2_1_bit <= d0_1_24 or d1_1_27;
  y <= fully_2_1_bit;
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;

entity mux_791081a00e is
  port (
    sel : in std_logic_vector((1 - 1) downto 0);
    d0 : in std_logic_vector((9 - 1) downto 0);
    d1 : in std_logic_vector((9 - 1) downto 0);
    y : out std_logic_vector((9 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end mux_791081a00e;


architecture behavior of mux_791081a00e is
  signal sel_1_20: std_logic;
  signal d0_1_24: std_logic_vector((9 - 1) downto 0);
  signal d1_1_27: std_logic_vector((9 - 1) downto 0);
  signal sel_internal_2_1_convert: std_logic_vector((1 - 1) downto 0);
  signal unregy_join_6_1: std_logic_vector((9 - 1) downto 0);
begin
  sel_1_20 <= sel(0);
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  sel_internal_2_1_convert <= cast(std_logic_to_vector(sel_1_20), 0, 1, 0, xlUnsigned);
  proc_switch_6_1: process (d0_1_24, d1_1_27, sel_internal_2_1_convert)
  is
  begin
    case sel_internal_2_1_convert is 
      when "0" =>
        unregy_join_6_1 <= d0_1_24;
      when others =>
        unregy_join_6_1 <= d1_1_27;
    end case;
  end process proc_switch_6_1;
  y <= unregy_join_6_1;
end behavior;

library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller/Buzzer Controller"

entity buzzer_controller_entity_063692c849 is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    from_register: in std_logic_vector(17 downto 0); 
    from_register1: in std_logic_vector(17 downto 0); 
    from_register2: in std_logic; 
    register9_x0: out std_logic
  );
end buzzer_controller_entity_063692c849;

architecture structural of buzzer_controller_entity_063692c849 is
  signal ce_1_sg_x0: std_logic;
  signal clk_1_sg_x0: std_logic;
  signal convert_dout_net: std_logic;
  signal counter_op_net: std_logic_vector(17 downto 0);
  signal from_register1_data_out_net_x0: std_logic_vector(17 downto 0);
  signal from_register2_data_out_net_x0: std_logic;
  signal from_register_data_out_net_x0: std_logic_vector(17 downto 0);
  signal inverter_op_net: std_logic;
  signal mult_p_net: std_logic_vector(17 downto 0);
  signal register8_q_net: std_logic;
  signal register9_q_net_x0: std_logic;
  signal relational1_op_net: std_logic;
  signal relational_op_net: std_logic;

begin
  ce_1_sg_x0 <= ce_1;
  clk_1_sg_x0 <= clk_1;
  from_register_data_out_net_x0 <= from_register;
  from_register1_data_out_net_x0 <= from_register1;
  from_register2_data_out_net_x0 <= from_register2;
  register9_x0 <= register9_q_net_x0;

  convert: entity work.xlconvert
    generic map (
      bool_conversion => 1,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 1,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 1,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din(0) => inverter_op_net,
      dout(0) => convert_dout_net
    );

  counter: entity work.xlcounter_free
    generic map (
      core_name0 => "binary_counter_virtex2p_7_0_950e4ab582797264",
      op_arith => xlUnsigned,
      op_width => 18
    )
    port map (
      ce => ce_1_sg_x0,
      clk => clk_1_sg_x0,
      clr => '0',
      en => "1",
      rst(0) => relational_op_net,
      op => counter_op_net
    );

  inverter: entity work.inverter_e2b989a05e
    port map (
      ce => ce_1_sg_x0,
      clk => clk_1_sg_x0,
      clr => '0',
      ip(0) => from_register2_data_out_net_x0,
      op(0) => inverter_op_net
    );

  mult: entity work.xlmult_v9_0
    generic map (
      a_arith => xlUnsigned,
      a_bin_pt => 0,
      a_width => 18,
      b_arith => xlUnsigned,
      b_bin_pt => 18,
      b_width => 18,
      c_a_type => 1,
      c_a_width => 18,
      c_b_type => 1,
      c_b_width => 18,
      c_baat => 18,
      c_output_width => 36,
      c_type => 1,
      core_name0 => "multiplier_virtex2p_10_1_817edd563258bb47",
      extra_registers => 0,
      multsign => 1,
      overflow => 1,
      p_arith => xlUnsigned,
      p_bin_pt => 0,
      p_width => 18,
      quantization => 1
    )
    port map (
      a => from_register_data_out_net_x0,
      b => from_register1_data_out_net_x0,
      ce => ce_1_sg_x0,
      clk => clk_1_sg_x0,
      clr => '0',
      core_ce => ce_1_sg_x0,
      core_clk => clk_1_sg_x0,
      core_clr => '1',
      en => "1",
      rst => "0",
      p => mult_p_net
    );

  register8: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x0,
      clk => clk_1_sg_x0,
      d(0) => relational1_op_net,
      en => "1",
      rst(0) => convert_dout_net,
      q(0) => register8_q_net
    );

  register9: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x0,
      clk => clk_1_sg_x0,
      d(0) => register8_q_net,
      en => "1",
      rst => "0",
      q(0) => register9_q_net_x0
    );

  relational: entity work.relational_4e76b03051
    port map (
      a => counter_op_net,
      b => from_register_data_out_net_x0,
      ce => ce_1_sg_x0,
      clk => clk_1_sg_x0,
      clr => '0',
      op(0) => relational_op_net
    );

  relational1: entity work.relational_1433264a0c
    port map (
      a => counter_op_net,
      b => mult_p_net,
      ce => ce_1_sg_x0,
      clk => clk_1_sg_x0,
      clr => '0',
      op(0) => relational1_op_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller/EDK Processor"

entity edk_processor_entity_94deb4def9 is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    from_register: in std_logic_vector(1 downto 0); 
    from_register1: in std_logic_vector(5 downto 0); 
    from_register2: in std_logic_vector(3 downto 0); 
    from_register3: in std_logic_vector(4 downto 0); 
    plb_abus: in std_logic_vector(31 downto 0); 
    plb_pavalid: in std_logic; 
    plb_rnw: in std_logic; 
    plb_wrdbus: in std_logic_vector(31 downto 0); 
    sg_plb_addrpref: in std_logic_vector(14 downto 0); 
    shared_memory: in std_logic_vector(31 downto 0); 
    shared_memory1: in std_logic_vector(31 downto 0); 
    shared_memory2: in std_logic_vector(31 downto 0); 
    splb_rst: in std_logic; 
    to_register: in std_logic_vector(17 downto 0); 
    to_register1: in std_logic; 
    to_register10: in std_logic_vector(8 downto 0); 
    to_register11: in std_logic_vector(3 downto 0); 
    to_register12: in std_logic_vector(8 downto 0); 
    to_register13: in std_logic; 
    to_register14: in std_logic; 
    to_register15: in std_logic_vector(8 downto 0); 
    to_register16: in std_logic_vector(8 downto 0); 
    to_register17: in std_logic_vector(8 downto 0); 
    to_register18: in std_logic; 
    to_register19: in std_logic_vector(7 downto 0); 
    to_register2: in std_logic_vector(17 downto 0); 
    to_register20: in std_logic_vector(7 downto 0); 
    to_register3: in std_logic_vector(8 downto 0); 
    to_register4: in std_logic_vector(3 downto 0); 
    to_register5: in std_logic_vector(2 downto 0); 
    to_register6: in std_logic_vector(8 downto 0); 
    to_register7: in std_logic_vector(1 downto 0); 
    to_register8: in std_logic; 
    to_register9: in std_logic_vector(8 downto 0); 
    constant5_x0: out std_logic; 
    plb_decode_x0: out std_logic; 
    plb_decode_x1: out std_logic; 
    plb_decode_x2: out std_logic; 
    plb_decode_x3: out std_logic; 
    plb_decode_x4: out std_logic_vector(31 downto 0); 
    plb_memmap_x0: out std_logic_vector(17 downto 0); 
    plb_memmap_x1: out std_logic; 
    plb_memmap_x10: out std_logic_vector(2 downto 0); 
    plb_memmap_x11: out std_logic; 
    plb_memmap_x12: out std_logic_vector(8 downto 0); 
    plb_memmap_x13: out std_logic; 
    plb_memmap_x14: out std_logic_vector(1 downto 0); 
    plb_memmap_x15: out std_logic; 
    plb_memmap_x16: out std_logic; 
    plb_memmap_x17: out std_logic; 
    plb_memmap_x18: out std_logic_vector(8 downto 0); 
    plb_memmap_x19: out std_logic; 
    plb_memmap_x2: out std_logic; 
    plb_memmap_x20: out std_logic_vector(8 downto 0); 
    plb_memmap_x21: out std_logic; 
    plb_memmap_x22: out std_logic_vector(3 downto 0); 
    plb_memmap_x23: out std_logic; 
    plb_memmap_x24: out std_logic_vector(8 downto 0); 
    plb_memmap_x25: out std_logic; 
    plb_memmap_x26: out std_logic; 
    plb_memmap_x27: out std_logic; 
    plb_memmap_x28: out std_logic; 
    plb_memmap_x29: out std_logic; 
    plb_memmap_x3: out std_logic; 
    plb_memmap_x30: out std_logic_vector(8 downto 0); 
    plb_memmap_x31: out std_logic; 
    plb_memmap_x32: out std_logic_vector(8 downto 0); 
    plb_memmap_x33: out std_logic; 
    plb_memmap_x34: out std_logic_vector(8 downto 0); 
    plb_memmap_x35: out std_logic; 
    plb_memmap_x36: out std_logic; 
    plb_memmap_x37: out std_logic; 
    plb_memmap_x38: out std_logic_vector(7 downto 0); 
    plb_memmap_x39: out std_logic; 
    plb_memmap_x4: out std_logic_vector(17 downto 0); 
    plb_memmap_x40: out std_logic_vector(7 downto 0); 
    plb_memmap_x41: out std_logic; 
    plb_memmap_x42: out std_logic_vector(11 downto 0); 
    plb_memmap_x43: out std_logic_vector(31 downto 0); 
    plb_memmap_x44: out std_logic; 
    plb_memmap_x45: out std_logic_vector(8 downto 0); 
    plb_memmap_x46: out std_logic_vector(31 downto 0); 
    plb_memmap_x47: out std_logic; 
    plb_memmap_x48: out std_logic_vector(7 downto 0); 
    plb_memmap_x49: out std_logic_vector(31 downto 0); 
    plb_memmap_x5: out std_logic; 
    plb_memmap_x50: out std_logic; 
    plb_memmap_x6: out std_logic_vector(8 downto 0); 
    plb_memmap_x7: out std_logic; 
    plb_memmap_x8: out std_logic_vector(3 downto 0); 
    plb_memmap_x9: out std_logic
  );
end edk_processor_entity_94deb4def9;

architecture structural of edk_processor_entity_94deb4def9 is
  signal bankaddr: std_logic_vector(1 downto 0);
  signal buttons_big_dout_x0: std_logic_vector(1 downto 0);
  signal buttons_small_dout_x0: std_logic_vector(5 downto 0);
  signal buzzer_dutycycle_din_x0: std_logic_vector(17 downto 0);
  signal buzzer_dutycycle_dout_x0: std_logic_vector(17 downto 0);
  signal buzzer_dutycycle_en_x0: std_logic;
  signal buzzer_enable_din_x0: std_logic;
  signal buzzer_enable_dout_x0: std_logic;
  signal buzzer_enable_en_x0: std_logic;
  signal buzzer_period_din_x0: std_logic_vector(17 downto 0);
  signal buzzer_period_dout_x0: std_logic_vector(17 downto 0);
  signal buzzer_period_en_x0: std_logic;
  signal ce_1_sg_x1: std_logic;
  signal clk_1_sg_x1: std_logic;
  signal dip_switch_dout_x0: std_logic_vector(3 downto 0);
  signal lcd_backgroundcolor_din_x0: std_logic_vector(8 downto 0);
  signal lcd_backgroundcolor_dout_x0: std_logic_vector(8 downto 0);
  signal lcd_backgroundcolor_en_x0: std_logic;
  signal lcd_charactermap_addr_x0: std_logic_vector(11 downto 0);
  signal lcd_charactermap_din_x0: std_logic_vector(31 downto 0);
  signal lcd_charactermap_dout_x0: std_logic_vector(31 downto 0);
  signal lcd_charactermap_we_x0: std_logic;
  signal lcd_characteroffset_din_x0: std_logic_vector(3 downto 0);
  signal lcd_characteroffset_dout_x0: std_logic_vector(3 downto 0);
  signal lcd_characteroffset_en_x0: std_logic;
  signal lcd_characters_addr_x0: std_logic_vector(8 downto 0);
  signal lcd_characters_din_x0: std_logic_vector(31 downto 0);
  signal lcd_characters_dout_x0: std_logic_vector(31 downto 0);
  signal lcd_characters_we_x0: std_logic;
  signal lcd_charactersselect_din_x0: std_logic_vector(2 downto 0);
  signal lcd_charactersselect_dout_x0: std_logic_vector(2 downto 0);
  signal lcd_charactersselect_en_x0: std_logic;
  signal lcd_colset_din_x0: std_logic_vector(8 downto 0);
  signal lcd_colset_dout_x0: std_logic_vector(8 downto 0);
  signal lcd_colset_en_x0: std_logic;
  signal lcd_commands_addr_x0: std_logic_vector(7 downto 0);
  signal lcd_commands_din_x0: std_logic_vector(31 downto 0);
  signal lcd_commands_dout_x0: std_logic_vector(31 downto 0);
  signal lcd_commands_we_x0: std_logic;
  signal lcd_configlocation_din_x0: std_logic_vector(1 downto 0);
  signal lcd_configlocation_dout_x0: std_logic_vector(1 downto 0);
  signal lcd_configlocation_en_x0: std_logic;
  signal lcd_dividerselect_din_x0: std_logic;
  signal lcd_dividerselect_dout_x0: std_logic;
  signal lcd_dividerselect_en_x0: std_logic;
  signal lcd_firstend_din_x0: std_logic_vector(8 downto 0);
  signal lcd_firstend_dout_x0: std_logic_vector(8 downto 0);
  signal lcd_firstend_en_x0: std_logic;
  signal lcd_firststart_din_x0: std_logic_vector(8 downto 0);
  signal lcd_firststart_dout_x0: std_logic_vector(8 downto 0);
  signal lcd_firststart_en_x0: std_logic;
  signal lcd_lineoffset_din_x0: std_logic_vector(3 downto 0);
  signal lcd_lineoffset_dout_x0: std_logic_vector(3 downto 0);
  signal lcd_lineoffset_en_x0: std_logic;
  signal lcd_ramwrite_din_x0: std_logic_vector(8 downto 0);
  signal lcd_ramwrite_dout_x0: std_logic_vector(8 downto 0);
  signal lcd_ramwrite_en_x0: std_logic;
  signal lcd_reset_din_x0: std_logic;
  signal lcd_reset_dout_x0: std_logic;
  signal lcd_reset_en_x0: std_logic;
  signal lcd_resetlcd_din_x0: std_logic;
  signal lcd_resetlcd_dout_x0: std_logic;
  signal lcd_resetlcd_en_x0: std_logic;
  signal lcd_rowset_din_x0: std_logic_vector(8 downto 0);
  signal lcd_rowset_dout_x0: std_logic_vector(8 downto 0);
  signal lcd_rowset_en_x0: std_logic;
  signal lcd_secondend_din_x0: std_logic_vector(8 downto 0);
  signal lcd_secondend_dout_x0: std_logic_vector(8 downto 0);
  signal lcd_secondend_en_x0: std_logic;
  signal lcd_secondstart_din_x0: std_logic_vector(8 downto 0);
  signal lcd_secondstart_dout_x0: std_logic_vector(8 downto 0);
  signal lcd_secondstart_en_x0: std_logic;
  signal lcd_send_din_x0: std_logic;
  signal lcd_send_dout_x0: std_logic;
  signal lcd_send_en_x0: std_logic;
  signal lcd_totalcmdtransfer_din_x0: std_logic_vector(7 downto 0);
  signal lcd_totalcmdtransfer_dout_x0: std_logic_vector(7 downto 0);
  signal lcd_totalcmdtransfer_en_x0: std_logic;
  signal leds_din_x0: std_logic_vector(7 downto 0);
  signal leds_dout_x0: std_logic_vector(7 downto 0);
  signal leds_en_x0: std_logic;
  signal linearaddr: std_logic_vector(12 downto 0);
  signal plb_abus_net_x0: std_logic_vector(31 downto 0);
  signal plb_pavalid_net_x0: std_logic;
  signal plb_rnw_net_x0: std_logic;
  signal plb_wrdbus_net_x0: std_logic_vector(31 downto 0);
  signal rddata: std_logic_vector(31 downto 0);
  signal rnwreg: std_logic;
  signal sg_plb_addrpref_net_x0: std_logic_vector(14 downto 0);
  signal sl_addrack_x0: std_logic;
  signal sl_rdcomp_x0: std_logic;
  signal sl_rddack_x0: std_logic;
  signal sl_rddbus_x0: std_logic_vector(31 downto 0);
  signal sl_wait_x0: std_logic;
  signal sl_wrdack_x0: std_logic;
  signal splb_rst_net_x0: std_logic;
  signal trackball_dout_x0: std_logic_vector(4 downto 0);
  signal wrdbusreg: std_logic_vector(31 downto 0);

begin
  ce_1_sg_x1 <= ce_1;
  clk_1_sg_x1 <= clk_1;
  buttons_big_dout_x0 <= from_register;
  buttons_small_dout_x0 <= from_register1;
  dip_switch_dout_x0 <= from_register2;
  trackball_dout_x0 <= from_register3;
  plb_abus_net_x0 <= plb_abus;
  plb_pavalid_net_x0 <= plb_pavalid;
  plb_rnw_net_x0 <= plb_rnw;
  plb_wrdbus_net_x0 <= plb_wrdbus;
  sg_plb_addrpref_net_x0 <= sg_plb_addrpref;
  lcd_charactermap_dout_x0 <= shared_memory;
  lcd_characters_dout_x0 <= shared_memory1;
  lcd_commands_dout_x0 <= shared_memory2;
  splb_rst_net_x0 <= splb_rst;
  buzzer_dutycycle_dout_x0 <= to_register;
  buzzer_enable_dout_x0 <= to_register1;
  lcd_firststart_dout_x0 <= to_register10;
  lcd_lineoffset_dout_x0 <= to_register11;
  lcd_ramwrite_dout_x0 <= to_register12;
  lcd_reset_dout_x0 <= to_register13;
  lcd_resetlcd_dout_x0 <= to_register14;
  lcd_rowset_dout_x0 <= to_register15;
  lcd_secondend_dout_x0 <= to_register16;
  lcd_secondstart_dout_x0 <= to_register17;
  lcd_send_dout_x0 <= to_register18;
  lcd_totalcmdtransfer_dout_x0 <= to_register19;
  buzzer_period_dout_x0 <= to_register2;
  leds_dout_x0 <= to_register20;
  lcd_backgroundcolor_dout_x0 <= to_register3;
  lcd_characteroffset_dout_x0 <= to_register4;
  lcd_charactersselect_dout_x0 <= to_register5;
  lcd_colset_dout_x0 <= to_register6;
  lcd_configlocation_dout_x0 <= to_register7;
  lcd_dividerselect_dout_x0 <= to_register8;
  lcd_firstend_dout_x0 <= to_register9;
  constant5_x0 <= sl_wait_x0;
  plb_decode_x0 <= sl_addrack_x0;
  plb_decode_x1 <= sl_rdcomp_x0;
  plb_decode_x2 <= sl_wrdack_x0;
  plb_decode_x3 <= sl_rddack_x0;
  plb_decode_x4 <= sl_rddbus_x0;
  plb_memmap_x0 <= buzzer_dutycycle_din_x0;
  plb_memmap_x1 <= buzzer_dutycycle_en_x0;
  plb_memmap_x10 <= lcd_charactersselect_din_x0;
  plb_memmap_x11 <= lcd_charactersselect_en_x0;
  plb_memmap_x12 <= lcd_colset_din_x0;
  plb_memmap_x13 <= lcd_colset_en_x0;
  plb_memmap_x14 <= lcd_configlocation_din_x0;
  plb_memmap_x15 <= lcd_configlocation_en_x0;
  plb_memmap_x16 <= lcd_dividerselect_din_x0;
  plb_memmap_x17 <= lcd_dividerselect_en_x0;
  plb_memmap_x18 <= lcd_firstend_din_x0;
  plb_memmap_x19 <= lcd_firstend_en_x0;
  plb_memmap_x2 <= buzzer_enable_din_x0;
  plb_memmap_x20 <= lcd_firststart_din_x0;
  plb_memmap_x21 <= lcd_firststart_en_x0;
  plb_memmap_x22 <= lcd_lineoffset_din_x0;
  plb_memmap_x23 <= lcd_lineoffset_en_x0;
  plb_memmap_x24 <= lcd_ramwrite_din_x0;
  plb_memmap_x25 <= lcd_ramwrite_en_x0;
  plb_memmap_x26 <= lcd_reset_din_x0;
  plb_memmap_x27 <= lcd_reset_en_x0;
  plb_memmap_x28 <= lcd_resetlcd_din_x0;
  plb_memmap_x29 <= lcd_resetlcd_en_x0;
  plb_memmap_x3 <= buzzer_enable_en_x0;
  plb_memmap_x30 <= lcd_rowset_din_x0;
  plb_memmap_x31 <= lcd_rowset_en_x0;
  plb_memmap_x32 <= lcd_secondend_din_x0;
  plb_memmap_x33 <= lcd_secondend_en_x0;
  plb_memmap_x34 <= lcd_secondstart_din_x0;
  plb_memmap_x35 <= lcd_secondstart_en_x0;
  plb_memmap_x36 <= lcd_send_din_x0;
  plb_memmap_x37 <= lcd_send_en_x0;
  plb_memmap_x38 <= lcd_totalcmdtransfer_din_x0;
  plb_memmap_x39 <= lcd_totalcmdtransfer_en_x0;
  plb_memmap_x4 <= buzzer_period_din_x0;
  plb_memmap_x40 <= leds_din_x0;
  plb_memmap_x41 <= leds_en_x0;
  plb_memmap_x42 <= lcd_charactermap_addr_x0;
  plb_memmap_x43 <= lcd_charactermap_din_x0;
  plb_memmap_x44 <= lcd_charactermap_we_x0;
  plb_memmap_x45 <= lcd_characters_addr_x0;
  plb_memmap_x46 <= lcd_characters_din_x0;
  plb_memmap_x47 <= lcd_characters_we_x0;
  plb_memmap_x48 <= lcd_commands_addr_x0;
  plb_memmap_x49 <= lcd_commands_din_x0;
  plb_memmap_x5 <= buzzer_period_en_x0;
  plb_memmap_x50 <= lcd_commands_we_x0;
  plb_memmap_x6 <= lcd_backgroundcolor_din_x0;
  plb_memmap_x7 <= lcd_backgroundcolor_en_x0;
  plb_memmap_x8 <= lcd_characteroffset_din_x0;
  plb_memmap_x9 <= lcd_characteroffset_en_x0;

  constant5: entity work.constant_963ed6358a
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => sl_wait_x0
    );

  plb_decode: entity work.mcode_block_8231ed31e4
    port map (
      addrpref => sg_plb_addrpref_net_x0,
      ce => ce_1_sg_x1,
      clk => clk_1_sg_x1,
      clr => '0',
      plbabus => plb_abus_net_x0,
      plbpavalid(0) => plb_pavalid_net_x0,
      plbrnw(0) => plb_rnw_net_x0,
      plbrst(0) => splb_rst_net_x0,
      plbwrdbus => plb_wrdbus_net_x0,
      rddata => rddata,
      addrack(0) => sl_addrack_x0,
      bankaddr => bankaddr,
      linearaddr => linearaddr,
      rdcomp(0) => sl_rdcomp_x0,
      rddack(0) => sl_rddack_x0,
      rddbus => sl_rddbus_x0,
      rnwreg(0) => rnwreg,
      wrdack(0) => sl_wrdack_x0,
      wrdbusreg => wrdbusreg
    );

  plb_memmap: entity work.mcode_block_66f25059c9
    port map (
      addrack(0) => sl_addrack_x0,
      bankaddr => bankaddr,
      ce => ce_1_sg_x1,
      clk => clk_1_sg_x1,
      clr => '0',
      linearaddr => linearaddr,
      rnwreg(0) => rnwreg,
      sm_buttons_big => buttons_big_dout_x0,
      sm_buttons_small => buttons_small_dout_x0,
      sm_buzzer_dutycycle => buzzer_dutycycle_dout_x0,
      sm_buzzer_enable(0) => buzzer_enable_dout_x0,
      sm_buzzer_period => buzzer_period_dout_x0,
      sm_dip_switch => dip_switch_dout_x0,
      sm_lcd_backgroundcolor => lcd_backgroundcolor_dout_x0,
      sm_lcd_charactermap => lcd_charactermap_dout_x0,
      sm_lcd_characteroffset => lcd_characteroffset_dout_x0,
      sm_lcd_characters => lcd_characters_dout_x0,
      sm_lcd_charactersselect => lcd_charactersselect_dout_x0,
      sm_lcd_colset => lcd_colset_dout_x0,
      sm_lcd_commands => lcd_commands_dout_x0,
      sm_lcd_configlocation => lcd_configlocation_dout_x0,
      sm_lcd_dividerselect(0) => lcd_dividerselect_dout_x0,
      sm_lcd_firstend => lcd_firstend_dout_x0,
      sm_lcd_firststart => lcd_firststart_dout_x0,
      sm_lcd_lineoffset => lcd_lineoffset_dout_x0,
      sm_lcd_ramwrite => lcd_ramwrite_dout_x0,
      sm_lcd_reset(0) => lcd_reset_dout_x0,
      sm_lcd_resetlcd(0) => lcd_resetlcd_dout_x0,
      sm_lcd_rowset => lcd_rowset_dout_x0,
      sm_lcd_secondend => lcd_secondend_dout_x0,
      sm_lcd_secondstart => lcd_secondstart_dout_x0,
      sm_lcd_send(0) => lcd_send_dout_x0,
      sm_lcd_totalcmdtransfer => lcd_totalcmdtransfer_dout_x0,
      sm_leds => leds_dout_x0,
      sm_trackball => trackball_dout_x0,
      wrdbus => wrdbusreg,
      read_bank_out => rddata,
      sm_buzzer_dutycycle_din => buzzer_dutycycle_din_x0,
      sm_buzzer_dutycycle_en(0) => buzzer_dutycycle_en_x0,
      sm_buzzer_enable_din(0) => buzzer_enable_din_x0,
      sm_buzzer_enable_en(0) => buzzer_enable_en_x0,
      sm_buzzer_period_din => buzzer_period_din_x0,
      sm_buzzer_period_en(0) => buzzer_period_en_x0,
      sm_lcd_backgroundcolor_din => lcd_backgroundcolor_din_x0,
      sm_lcd_backgroundcolor_en(0) => lcd_backgroundcolor_en_x0,
      sm_lcd_charactermap_addr => lcd_charactermap_addr_x0,
      sm_lcd_charactermap_din => lcd_charactermap_din_x0,
      sm_lcd_charactermap_we(0) => lcd_charactermap_we_x0,
      sm_lcd_characteroffset_din => lcd_characteroffset_din_x0,
      sm_lcd_characteroffset_en(0) => lcd_characteroffset_en_x0,
      sm_lcd_characters_addr => lcd_characters_addr_x0,
      sm_lcd_characters_din => lcd_characters_din_x0,
      sm_lcd_characters_we(0) => lcd_characters_we_x0,
      sm_lcd_charactersselect_din => lcd_charactersselect_din_x0,
      sm_lcd_charactersselect_en(0) => lcd_charactersselect_en_x0,
      sm_lcd_colset_din => lcd_colset_din_x0,
      sm_lcd_colset_en(0) => lcd_colset_en_x0,
      sm_lcd_commands_addr => lcd_commands_addr_x0,
      sm_lcd_commands_din => lcd_commands_din_x0,
      sm_lcd_commands_we(0) => lcd_commands_we_x0,
      sm_lcd_configlocation_din => lcd_configlocation_din_x0,
      sm_lcd_configlocation_en(0) => lcd_configlocation_en_x0,
      sm_lcd_dividerselect_din(0) => lcd_dividerselect_din_x0,
      sm_lcd_dividerselect_en(0) => lcd_dividerselect_en_x0,
      sm_lcd_firstend_din => lcd_firstend_din_x0,
      sm_lcd_firstend_en(0) => lcd_firstend_en_x0,
      sm_lcd_firststart_din => lcd_firststart_din_x0,
      sm_lcd_firststart_en(0) => lcd_firststart_en_x0,
      sm_lcd_lineoffset_din => lcd_lineoffset_din_x0,
      sm_lcd_lineoffset_en(0) => lcd_lineoffset_en_x0,
      sm_lcd_ramwrite_din => lcd_ramwrite_din_x0,
      sm_lcd_ramwrite_en(0) => lcd_ramwrite_en_x0,
      sm_lcd_reset_din(0) => lcd_reset_din_x0,
      sm_lcd_reset_en(0) => lcd_reset_en_x0,
      sm_lcd_resetlcd_din(0) => lcd_resetlcd_din_x0,
      sm_lcd_resetlcd_en(0) => lcd_resetlcd_en_x0,
      sm_lcd_rowset_din => lcd_rowset_din_x0,
      sm_lcd_rowset_en(0) => lcd_rowset_en_x0,
      sm_lcd_secondend_din => lcd_secondend_din_x0,
      sm_lcd_secondend_en(0) => lcd_secondend_en_x0,
      sm_lcd_secondstart_din => lcd_secondstart_din_x0,
      sm_lcd_secondstart_en(0) => lcd_secondstart_en_x0,
      sm_lcd_send_din(0) => lcd_send_din_x0,
      sm_lcd_send_en(0) => lcd_send_en_x0,
      sm_lcd_totalcmdtransfer_din => lcd_totalcmdtransfer_din_x0,
      sm_lcd_totalcmdtransfer_en(0) => lcd_totalcmdtransfer_en_x0,
      sm_leds_din => leds_din_x0,
      sm_leds_en(0) => leds_en_x0
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller/Interactive I/O/8xDebounce"

entity x8xdebounce_entity_bf5cd80880 is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    d: in std_logic; 
    q: out std_logic
  );
end x8xdebounce_entity_bf5cd80880;

architecture structural of x8xdebounce_entity_bf5cd80880 is
  signal ce_1_sg_x2: std_logic;
  signal clk_1_sg_x2: std_logic;
  signal delay1_q_net: std_logic;
  signal delay2_q_net: std_logic;
  signal delay3_q_net: std_logic;
  signal delay4_q_net: std_logic;
  signal delay5_q_net: std_logic;
  signal delay6_q_net: std_logic;
  signal delay_q_net: std_logic;
  signal logical_y_net_x0: std_logic;
  signal trackball_sel2_net_x0: std_logic;

begin
  ce_1_sg_x2 <= ce_1;
  clk_1_sg_x2 <= clk_1;
  trackball_sel2_net_x0 <= d;
  q <= logical_y_net_x0;

  delay: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x2,
      clk => clk_1_sg_x2,
      d(0) => trackball_sel2_net_x0,
      en => '1',
      q(0) => delay_q_net
    );

  delay1: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x2,
      clk => clk_1_sg_x2,
      d(0) => delay_q_net,
      en => '1',
      q(0) => delay1_q_net
    );

  delay2: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x2,
      clk => clk_1_sg_x2,
      d(0) => delay1_q_net,
      en => '1',
      q(0) => delay2_q_net
    );

  delay3: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x2,
      clk => clk_1_sg_x2,
      d(0) => delay2_q_net,
      en => '1',
      q(0) => delay3_q_net
    );

  delay4: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x2,
      clk => clk_1_sg_x2,
      d(0) => delay3_q_net,
      en => '1',
      q(0) => delay4_q_net
    );

  delay5: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x2,
      clk => clk_1_sg_x2,
      d(0) => delay4_q_net,
      en => '1',
      q(0) => delay5_q_net
    );

  delay6: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x2,
      clk => clk_1_sg_x2,
      d(0) => delay5_q_net,
      en => '1',
      q(0) => delay6_q_net
    );

  logical: entity work.logical_4ad38e8aed
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => trackball_sel2_net_x0,
      d1(0) => delay_q_net,
      d2(0) => delay1_q_net,
      d3(0) => delay2_q_net,
      d4(0) => delay3_q_net,
      d5(0) => delay4_q_net,
      d6(0) => delay5_q_net,
      d7(0) => delay6_q_net,
      y(0) => logical_y_net_x0
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller/Interactive I/O"

entity o_entity_1f30dfdbf5 is
  port (
    buttons_big: in std_logic_vector(1 downto 0); 
    buttons_small: in std_logic_vector(5 downto 0); 
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    dip_switch: in std_logic_vector(3 downto 0); 
    from_register: in std_logic_vector(7 downto 0); 
    trackball_ox: in std_logic; 
    trackball_oxn: in std_logic; 
    trackball_oy: in std_logic; 
    trackball_oyn: in std_logic; 
    trackball_sel2: in std_logic; 
    concat_x0: out std_logic_vector(4 downto 0); 
    constant2_x0: out std_logic; 
    constant4_x0: out std_logic; 
    constant6_x0: out std_logic; 
    constant_x1: out std_logic; 
    register10_x0: out std_logic; 
    register11_x0: out std_logic; 
    register12_x0: out std_logic; 
    register3_x0: out std_logic_vector(1 downto 0); 
    register5_x0: out std_logic_vector(5 downto 0); 
    register7_x0: out std_logic_vector(3 downto 0); 
    register9_x0: out std_logic_vector(7 downto 0)
  );
end o_entity_1f30dfdbf5;

architecture structural of o_entity_1f30dfdbf5 is
  signal buttons_big_net_x0: std_logic_vector(1 downto 0);
  signal buttons_small_net_x0: std_logic_vector(5 downto 0);
  signal ce_1_sg_x7: std_logic;
  signal clk_1_sg_x7: std_logic;
  signal concat_y_net_x0: std_logic_vector(4 downto 0);
  signal constant13_op_net: std_logic;
  signal constant2_op_net_x0: std_logic;
  signal constant4_op_net_x0: std_logic;
  signal constant6_op_net_x0: std_logic;
  signal constant_op_net_x0: std_logic;
  signal dip_switch_net_x0: std_logic_vector(3 downto 0);
  signal from_register_data_out_net_x0: std_logic_vector(7 downto 0);
  signal logical_y_net_x0: std_logic;
  signal logical_y_net_x1: std_logic;
  signal logical_y_net_x2: std_logic;
  signal logical_y_net_x3: std_logic;
  signal logical_y_net_x4: std_logic;
  signal register10_q_net_x0: std_logic;
  signal register11_q_net_x0: std_logic;
  signal register12_q_net_x0: std_logic;
  signal register13_q_net: std_logic;
  signal register14_q_net: std_logic;
  signal register15_q_net: std_logic;
  signal register16_q_net: std_logic;
  signal register17_q_net: std_logic;
  signal register18_q_net: std_logic;
  signal register19_q_net: std_logic;
  signal register1_q_net: std_logic;
  signal register20_q_net: std_logic;
  signal register2_q_net: std_logic_vector(1 downto 0);
  signal register3_q_net_x0: std_logic_vector(1 downto 0);
  signal register4_q_net: std_logic_vector(5 downto 0);
  signal register5_q_net_x0: std_logic_vector(5 downto 0);
  signal register6_q_net: std_logic_vector(3 downto 0);
  signal register7_q_net_x0: std_logic_vector(3 downto 0);
  signal register8_q_net: std_logic_vector(7 downto 0);
  signal register9_q_net_x0: std_logic_vector(7 downto 0);
  signal register_q_net: std_logic;
  signal trackball_ox_net_x1: std_logic;
  signal trackball_oxn_net_x1: std_logic;
  signal trackball_oy_net_x1: std_logic;
  signal trackball_oyn_net_x1: std_logic;
  signal trackball_sel2_net_x1: std_logic;

begin
  buttons_big_net_x0 <= buttons_big;
  buttons_small_net_x0 <= buttons_small;
  ce_1_sg_x7 <= ce_1;
  clk_1_sg_x7 <= clk_1;
  dip_switch_net_x0 <= dip_switch;
  from_register_data_out_net_x0 <= from_register;
  trackball_ox_net_x1 <= trackball_ox;
  trackball_oxn_net_x1 <= trackball_oxn;
  trackball_oy_net_x1 <= trackball_oy;
  trackball_oyn_net_x1 <= trackball_oyn;
  trackball_sel2_net_x1 <= trackball_sel2;
  concat_x0 <= concat_y_net_x0;
  constant2_x0 <= constant2_op_net_x0;
  constant4_x0 <= constant4_op_net_x0;
  constant6_x0 <= constant6_op_net_x0;
  constant_x1 <= constant_op_net_x0;
  register10_x0 <= register10_q_net_x0;
  register11_x0 <= register11_q_net_x0;
  register12_x0 <= register12_q_net_x0;
  register3_x0 <= register3_q_net_x0;
  register5_x0 <= register5_q_net_x0;
  register7_x0 <= register7_q_net_x0;
  register9_x0 <= register9_q_net_x0;

  concat: entity work.concat_2b3acb49f4
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0(0) => register20_q_net,
      in1(0) => register1_q_net,
      in2(0) => register14_q_net,
      in3(0) => register16_q_net,
      in4(0) => register18_q_net,
      y => concat_y_net_x0
    );

  constant13: entity work.constant_6293007044
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant13_op_net
    );

  constant2: entity work.constant_6293007044
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant2_op_net_x0
    );

  constant4: entity work.constant_6293007044
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant4_op_net_x0
    );

  constant6: entity work.constant_6293007044
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant6_op_net_x0
    );

  constant_x0: entity work.constant_6293007044
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant_op_net_x0
    );

  register1: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x7,
      clk => clk_1_sg_x7,
      d(0) => register_q_net,
      en => "1",
      rst => "0",
      q(0) => register1_q_net
    );

  register10: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x7,
      clk => clk_1_sg_x7,
      d(0) => constant13_op_net,
      en => "1",
      rst => "0",
      q(0) => register10_q_net_x0
    );

  register11: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x7,
      clk => clk_1_sg_x7,
      d(0) => constant13_op_net,
      en => "1",
      rst => "0",
      q(0) => register11_q_net_x0
    );

  register12: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x7,
      clk => clk_1_sg_x7,
      d(0) => constant13_op_net,
      en => "1",
      rst => "0",
      q(0) => register12_q_net_x0
    );

  register13: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x7,
      clk => clk_1_sg_x7,
      d(0) => logical_y_net_x2,
      en => "1",
      rst => "0",
      q(0) => register13_q_net
    );

  register14: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x7,
      clk => clk_1_sg_x7,
      d(0) => register13_q_net,
      en => "1",
      rst => "0",
      q(0) => register14_q_net
    );

  register15: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x7,
      clk => clk_1_sg_x7,
      d(0) => logical_y_net_x3,
      en => "1",
      rst => "0",
      q(0) => register15_q_net
    );

  register16: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x7,
      clk => clk_1_sg_x7,
      d(0) => register15_q_net,
      en => "1",
      rst => "0",
      q(0) => register16_q_net
    );

  register17: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x7,
      clk => clk_1_sg_x7,
      d(0) => logical_y_net_x4,
      en => "1",
      rst => "0",
      q(0) => register17_q_net
    );

  register18: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x7,
      clk => clk_1_sg_x7,
      d(0) => register17_q_net,
      en => "1",
      rst => "0",
      q(0) => register18_q_net
    );

  register19: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x7,
      clk => clk_1_sg_x7,
      d(0) => logical_y_net_x0,
      en => "1",
      rst => "0",
      q(0) => register19_q_net
    );

  register2: entity work.xlregister
    generic map (
      d_width => 2,
      init_value => b"00"
    )
    port map (
      ce => ce_1_sg_x7,
      clk => clk_1_sg_x7,
      d => buttons_big_net_x0,
      en => "1",
      rst => "0",
      q => register2_q_net
    );

  register20: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x7,
      clk => clk_1_sg_x7,
      d(0) => register19_q_net,
      en => "1",
      rst => "0",
      q(0) => register20_q_net
    );

  register3: entity work.xlregister
    generic map (
      d_width => 2,
      init_value => b"00"
    )
    port map (
      ce => ce_1_sg_x7,
      clk => clk_1_sg_x7,
      d => register2_q_net,
      en => "1",
      rst => "0",
      q => register3_q_net_x0
    );

  register4: entity work.xlregister
    generic map (
      d_width => 6,
      init_value => b"000000"
    )
    port map (
      ce => ce_1_sg_x7,
      clk => clk_1_sg_x7,
      d => buttons_small_net_x0,
      en => "1",
      rst => "0",
      q => register4_q_net
    );

  register5: entity work.xlregister
    generic map (
      d_width => 6,
      init_value => b"000000"
    )
    port map (
      ce => ce_1_sg_x7,
      clk => clk_1_sg_x7,
      d => register4_q_net,
      en => "1",
      rst => "0",
      q => register5_q_net_x0
    );

  register6: entity work.xlregister
    generic map (
      d_width => 4,
      init_value => b"0000"
    )
    port map (
      ce => ce_1_sg_x7,
      clk => clk_1_sg_x7,
      d => dip_switch_net_x0,
      en => "1",
      rst => "0",
      q => register6_q_net
    );

  register7: entity work.xlregister
    generic map (
      d_width => 4,
      init_value => b"0000"
    )
    port map (
      ce => ce_1_sg_x7,
      clk => clk_1_sg_x7,
      d => register6_q_net,
      en => "1",
      rst => "0",
      q => register7_q_net_x0
    );

  register8: entity work.xlregister
    generic map (
      d_width => 8,
      init_value => b"00000000"
    )
    port map (
      ce => ce_1_sg_x7,
      clk => clk_1_sg_x7,
      d => from_register_data_out_net_x0,
      en => "1",
      rst => "0",
      q => register8_q_net
    );

  register9: entity work.xlregister
    generic map (
      d_width => 8,
      init_value => b"00000000"
    )
    port map (
      ce => ce_1_sg_x7,
      clk => clk_1_sg_x7,
      d => register8_q_net,
      en => "1",
      rst => "0",
      q => register9_q_net_x0
    );

  register_x0: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x7,
      clk => clk_1_sg_x7,
      d(0) => logical_y_net_x1,
      en => "1",
      rst => "0",
      q(0) => register_q_net
    );

  x8xdebounce1_e364c4890f: entity work.x8xdebounce_entity_bf5cd80880
    port map (
      ce_1 => ce_1_sg_x7,
      clk_1 => clk_1_sg_x7,
      d => trackball_ox_net_x1,
      q => logical_y_net_x1
    );

  x8xdebounce2_5537837997: entity work.x8xdebounce_entity_bf5cd80880
    port map (
      ce_1 => ce_1_sg_x7,
      clk_1 => clk_1_sg_x7,
      d => trackball_oxn_net_x1,
      q => logical_y_net_x2
    );

  x8xdebounce3_1e40372202: entity work.x8xdebounce_entity_bf5cd80880
    port map (
      ce_1 => ce_1_sg_x7,
      clk_1 => clk_1_sg_x7,
      d => trackball_oy_net_x1,
      q => logical_y_net_x3
    );

  x8xdebounce4_7911ba4284: entity work.x8xdebounce_entity_bf5cd80880
    port map (
      ce_1 => ce_1_sg_x7,
      clk_1 => clk_1_sg_x7,
      d => trackball_oyn_net_x1,
      q => logical_y_net_x4
    );

  x8xdebounce_bf5cd80880: entity work.x8xdebounce_entity_bf5cd80880
    port map (
      ce_1 => ce_1_sg_x7,
      clk_1 => clk_1_sg_x7,
      d => trackball_sel2_net_x1,
      q => logical_y_net_x0
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller/LCD Controller/CommandROM/Command Memory"

entity command_memory_entity_ca978db4f0 is
  port (
    addr_9b: in std_logic_vector(8 downto 0); 
    shared_memory: in std_logic_vector(31 downto 0); 
    constant1_x0: out std_logic; 
    constant_x1: out std_logic_vector(31 downto 0); 
    data_16b: out std_logic_vector(15 downto 0); 
    x8msb_x0: out std_logic_vector(7 downto 0)
  );
end command_memory_entity_ca978db4f0;

architecture structural of command_memory_entity_ca978db4f0 is
  signal concat_y_net_x0: std_logic_vector(8 downto 0);
  signal constant1_op_net_x0: std_logic;
  signal constant_op_net_x0: std_logic_vector(31 downto 0);
  signal lsb_y_net: std_logic;
  signal mux_y_net_x0: std_logic_vector(15 downto 0);
  signal shared_memory_data_out_net_x0: std_logic_vector(31 downto 0);
  signal x16lsb_y_net: std_logic_vector(15 downto 0);
  signal x16msb_y_net: std_logic_vector(15 downto 0);
  signal x8msb_y_net_x0: std_logic_vector(7 downto 0);

begin
  concat_y_net_x0 <= addr_9b;
  shared_memory_data_out_net_x0 <= shared_memory;
  constant1_x0 <= constant1_op_net_x0;
  constant_x1 <= constant_op_net_x0;
  data_16b <= mux_y_net_x0;
  x8msb_x0 <= x8msb_y_net_x0;

  constant1: entity work.constant_963ed6358a
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant1_op_net_x0
    );

  constant_x0: entity work.constant_37567836aa
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant_op_net_x0
    );

  lsb: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 0,
      x_width => 9,
      y_width => 1
    )
    port map (
      x => concat_y_net_x0,
      y(0) => lsb_y_net
    );

  mux: entity work.mux_2c45f290ed
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => x16lsb_y_net,
      d1 => x16msb_y_net,
      sel(0) => lsb_y_net,
      y => mux_y_net_x0
    );

  x16lsb: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 15,
      x_width => 32,
      y_width => 16
    )
    port map (
      x => shared_memory_data_out_net_x0,
      y => x16lsb_y_net
    );

  x16msb: entity work.xlslice
    generic map (
      new_lsb => 16,
      new_msb => 31,
      x_width => 32,
      y_width => 16
    )
    port map (
      x => shared_memory_data_out_net_x0,
      y => x16msb_y_net
    );

  x8msb: entity work.xlslice
    generic map (
      new_lsb => 1,
      new_msb => 8,
      x_width => 9,
      y_width => 8
    )
    port map (
      x => concat_y_net_x0,
      y => x8msb_y_net_x0
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller/LCD Controller/CommandROM/Neg Edge Detector"

entity neg_edge_detector_entity_b797592ea5 is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    input_signal: in std_logic; 
    rising_edge: out std_logic
  );
end neg_edge_detector_entity_b797592ea5;

architecture structural of neg_edge_detector_entity_b797592ea5 is
  signal ce_1_sg_x8: std_logic;
  signal clk_1_sg_x8: std_logic;
  signal delay_q_net: std_logic;
  signal inverter_op_net: std_logic;
  signal logical_y_net_x0: std_logic;
  signal slice4_y_net_x0: std_logic;

begin
  ce_1_sg_x8 <= ce_1;
  clk_1_sg_x8 <= clk_1;
  slice4_y_net_x0 <= input_signal;
  rising_edge <= logical_y_net_x0;

  delay: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x8,
      clk => clk_1_sg_x8,
      d(0) => inverter_op_net,
      en => '1',
      q(0) => delay_q_net
    );

  inverter: entity work.inverter_e2b989a05e
    port map (
      ce => ce_1_sg_x8,
      clk => clk_1_sg_x8,
      clr => '0',
      ip(0) => slice4_y_net_x0,
      op(0) => inverter_op_net
    );

  logical: entity work.logical_b1e9d7c303
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => slice4_y_net_x0,
      d1(0) => delay_q_net,
      y(0) => logical_y_net_x0
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller/LCD Controller/CommandROM"

entity commandrom_entity_b68e0d97b7 is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    from_register1: in std_logic_vector(8 downto 0); 
    from_register2: in std_logic_vector(8 downto 0); 
    from_register3: in std_logic_vector(8 downto 0); 
    from_register4: in std_logic_vector(8 downto 0); 
    from_register5: in std_logic_vector(8 downto 0); 
    from_register6: in std_logic_vector(1 downto 0); 
    reset: in std_logic; 
    sendcmds: in std_logic; 
    shared_memory: in std_logic_vector(31 downto 0); 
    totalnoofcmds: in std_logic_vector(7 downto 0); 
    transferdone: in std_logic; 
    cmdsdone: out std_logic; 
    command_memory: out std_logic_vector(7 downto 0); 
    command_memory_x0: out std_logic_vector(31 downto 0); 
    command_memory_x1: out std_logic; 
    datatosend: out std_logic_vector(8 downto 0); 
    starttransfer: out std_logic
  );
end commandrom_entity_b68e0d97b7;

architecture structural of commandrom_entity_b68e0d97b7 is
  signal accumulator1_q_net: std_logic_vector(3 downto 0);
  signal accumulator_q_net: std_logic_vector(6 downto 0);
  signal addsub_s_net: std_logic_vector(8 downto 0);
  signal ce_1_sg_x9: std_logic;
  signal clk_1_sg_x9: std_logic;
  signal concat2_y_net_x0: std_logic_vector(8 downto 0);
  signal concat_y_net_x0: std_logic_vector(8 downto 0);
  signal constant11_op_net: std_logic_vector(8 downto 0);
  signal constant1_op_net_x1: std_logic;
  signal constant2_op_net: std_logic;
  signal constant3_op_net: std_logic;
  signal constant4_op_net: std_logic_vector(3 downto 0);
  signal constant5_op_net: std_logic_vector(8 downto 0);
  signal constant6_op_net: std_logic_vector(8 downto 0);
  signal constant_op_net_x1: std_logic_vector(31 downto 0);
  signal convert1_dout_net: std_logic;
  signal convert1_dout_net_x2: std_logic;
  signal convert1_dout_net_x3: std_logic;
  signal convert2_dout_net: std_logic;
  signal convert_dout_net: std_logic;
  signal counter1_op_net: std_logic_vector(14 downto 0);
  signal counter_op_net: std_logic_vector(6 downto 0);
  signal delay_q_net: std_logic;
  signal from_register1_data_out_net_x0: std_logic_vector(8 downto 0);
  signal from_register2_data_out_net_x0: std_logic_vector(8 downto 0);
  signal from_register3_data_out_net_x1: std_logic_vector(8 downto 0);
  signal from_register3_data_out_net_x2: std_logic_vector(7 downto 0);
  signal from_register4_data_out_net_x0: std_logic_vector(8 downto 0);
  signal from_register5_data_out_net_x0: std_logic_vector(8 downto 0);
  signal from_register6_data_out_net_x0: std_logic_vector(1 downto 0);
  signal inverter1_op_net: std_logic;
  signal inverter2_op_net: std_logic;
  signal logical1_y_net: std_logic;
  signal logical2_y_net: std_logic;
  signal logical3_y_net: std_logic;
  signal logical_y_net: std_logic;
  signal logical_y_net_x0: std_logic;
  signal logical_y_net_x2: std_logic;
  signal mux1_y_net: std_logic;
  signal mux2_y_net_x0: std_logic;
  signal mux3_y_net: std_logic_vector(8 downto 0);
  signal mux_y_net_x0: std_logic_vector(15 downto 0);
  signal register_q_net_x0: std_logic;
  signal relational1_op_net: std_logic;
  signal relational_op_net: std_logic;
  signal shared_memory_data_out_net_x1: std_logic_vector(31 downto 0);
  signal slice2_y_net: std_logic_vector(7 downto 0);
  signal slice3_y_net: std_logic;
  signal slice4_y_net_x0: std_logic;
  signal slice5_y_net: std_logic_vector(8 downto 0);
  signal x8msb_y_net_x1: std_logic_vector(7 downto 0);

begin
  ce_1_sg_x9 <= ce_1;
  clk_1_sg_x9 <= clk_1;
  from_register1_data_out_net_x0 <= from_register1;
  from_register2_data_out_net_x0 <= from_register2;
  from_register3_data_out_net_x1 <= from_register3;
  from_register4_data_out_net_x0 <= from_register4;
  from_register5_data_out_net_x0 <= from_register5;
  from_register6_data_out_net_x0 <= from_register6;
  convert1_dout_net_x2 <= reset;
  logical_y_net_x2 <= sendcmds;
  shared_memory_data_out_net_x1 <= shared_memory;
  from_register3_data_out_net_x2 <= totalnoofcmds;
  convert1_dout_net_x3 <= transferdone;
  cmdsdone <= register_q_net_x0;
  command_memory <= x8msb_y_net_x1;
  command_memory_x0 <= constant_op_net_x1;
  command_memory_x1 <= constant1_op_net_x1;
  datatosend <= concat2_y_net_x0;
  starttransfer <= mux2_y_net_x0;

  accumulator: entity work.accum_2cb0e56e96
    port map (
      b(0) => convert_dout_net,
      ce => ce_1_sg_x9,
      clk => clk_1_sg_x9,
      clr => '0',
      en(0) => logical1_y_net,
      rst(0) => logical_y_net_x2,
      q => accumulator_q_net
    );

  accumulator1: entity work.accum_be45dd0aa2
    port map (
      b(0) => convert1_dout_net,
      ce => ce_1_sg_x9,
      clk => clk_1_sg_x9,
      clr => '0',
      rst(0) => convert1_dout_net_x2,
      q => accumulator1_q_net
    );

  addsub: entity work.xladdsub
    generic map (
      a_arith => xlUnsigned,
      a_bin_pt => 0,
      a_width => 8,
      b_arith => xlUnsigned,
      b_bin_pt => 0,
      b_width => 1,
      c_has_b_out => 0,
      c_has_c_out => 0,
      c_has_q => 0,
      c_has_q_b_out => 0,
      c_has_q_c_out => 0,
      c_has_s => 1,
      c_latency => 0,
      c_output_width => 9,
      core_name0 => "adder_subtracter_virtex2p_7_0_cf28bbebd75d9ce3",
      extra_registers => 0,
      full_s_arith => 2,
      full_s_width => 9,
      latency => 0,
      mode => 2,
      overflow => 1,
      quantization => 1,
      s_arith => xlSigned,
      s_bin_pt => 0,
      s_width => 9
    )
    port map (
      a => from_register3_data_out_net_x2,
      b(0) => constant3_op_net,
      ce => ce_1_sg_x9,
      clk => clk_1_sg_x9,
      clr => '0',
      en => "1",
      s => addsub_s_net
    );

  command_memory_ca978db4f0: entity work.command_memory_entity_ca978db4f0
    port map (
      addr_9b => concat_y_net_x0,
      shared_memory => shared_memory_data_out_net_x1,
      constant1_x0 => constant1_op_net_x1,
      constant_x1 => constant_op_net_x1,
      data_16b => mux_y_net_x0,
      x8msb_x0 => x8msb_y_net_x1
    );

  concat: entity work.concat_f62149b02a
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0 => from_register6_data_out_net_x0,
      in1 => counter_op_net,
      y => concat_y_net_x0
    );

  concat2: entity work.concat_1ece14600f
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0(0) => inverter1_op_net,
      in1 => slice2_y_net,
      y => concat2_y_net_x0
    );

  constant11: entity work.constant_443ed96427
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant11_op_net
    );

  constant2: entity work.constant_963ed6358a
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant2_op_net
    );

  constant3: entity work.constant_6293007044
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant3_op_net
    );

  constant4: entity work.constant_145086465d
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant4_op_net
    );

  constant5: entity work.constant_fb9f6d3796
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant5_op_net
    );

  constant6: entity work.constant_09a4afb2ee
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant6_op_net
    );

  convert: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 1,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 1,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din(0) => delay_q_net,
      dout(0) => convert_dout_net
    );

  convert1: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 1,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 1,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din(0) => logical3_y_net,
      dout(0) => convert1_dout_net
    );

  convert2: entity work.xlconvert
    generic map (
      bool_conversion => 1,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 1,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 1,
      latency => 5,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => ce_1_sg_x9,
      clk => clk_1_sg_x9,
      clr => '0',
      din(0) => logical_y_net_x0,
      dout(0) => convert2_dout_net
    );

  counter: entity work.xlcounter_free
    generic map (
      core_name0 => "binary_counter_virtex2p_7_0_b0a257f5389d649a",
      op_arith => xlUnsigned,
      op_width => 7
    )
    port map (
      ce => ce_1_sg_x9,
      clk => clk_1_sg_x9,
      clr => '0',
      en(0) => logical_y_net,
      rst(0) => convert1_dout_net_x2,
      op => counter_op_net
    );

  counter1: entity work.xlcounter_limit
    generic map (
      cnt_15_0 => 17435,
      cnt_31_16 => 0,
      cnt_47_32 => 0,
      cnt_63_48 => 0,
      core_name0 => "binary_counter_virtex2p_7_0_32a1863440903b9d",
      count_limited => 1,
      op_arith => xlUnsigned,
      op_width => 15
    )
    port map (
      ce => ce_1_sg_x9,
      clk => clk_1_sg_x9,
      clr => '0',
      en(0) => logical2_y_net,
      rst(0) => convert1_dout_net_x2,
      op => counter1_op_net
    );

  delay: entity work.xldelay
    generic map (
      latency => 4,
      reg_retiming => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x9,
      clk => clk_1_sg_x9,
      d(0) => logical_y_net,
      en => '1',
      q(0) => delay_q_net
    );

  inverter1: entity work.inverter_e2b989a05e
    port map (
      ce => ce_1_sg_x9,
      clk => clk_1_sg_x9,
      clr => '0',
      ip(0) => slice3_y_net,
      op(0) => inverter1_op_net
    );

  inverter2: entity work.inverter_e5b38cca3b
    port map (
      ce => ce_1_sg_x9,
      clk => clk_1_sg_x9,
      clr => '0',
      ip(0) => relational_op_net,
      op(0) => inverter2_op_net
    );

  logical: entity work.logical_aacf6e1b0e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => logical_y_net_x2,
      d1(0) => convert1_dout_net_x3,
      y(0) => logical_y_net
    );

  logical1: entity work.logical_80f90b97d0
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => delay_q_net,
      d1(0) => relational_op_net,
      y(0) => logical1_y_net
    );

  logical2: entity work.logical_80f90b97d0
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => inverter2_op_net,
      d1(0) => convert1_dout_net_x3,
      y(0) => logical2_y_net
    );

  logical3: entity work.logical_80f90b97d0
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => relational1_op_net,
      d1(0) => logical2_y_net,
      y(0) => logical3_y_net
    );

  mux1: entity work.mux_d99e59b6d4
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => constant2_op_net,
      d1(0) => delay_q_net,
      sel(0) => relational_op_net,
      y(0) => mux1_y_net
    );

  mux2: entity work.mux_d99e59b6d4
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => mux1_y_net,
      d1(0) => delay_q_net,
      sel(0) => inverter2_op_net,
      y(0) => mux2_y_net_x0
    );

  mux3: entity work.mux_1f00a411aa
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => slice5_y_net,
      d1 => constant5_op_net,
      d2 => from_register1_data_out_net_x0,
      d3 => from_register2_data_out_net_x0,
      d4 => constant6_op_net,
      d5 => from_register4_data_out_net_x0,
      d6 => from_register5_data_out_net_x0,
      d7 => constant11_op_net,
      d8 => from_register3_data_out_net_x1,
      sel => accumulator1_q_net,
      y => mux3_y_net
    );

  neg_edge_detector_b797592ea5: entity work.neg_edge_detector_entity_b797592ea5
    port map (
      ce_1 => ce_1_sg_x9,
      clk_1 => clk_1_sg_x9,
      input_signal => slice4_y_net_x0,
      rising_edge => logical_y_net_x0
    );

  register_x0: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x9,
      clk => clk_1_sg_x9,
      d(0) => convert2_dout_net,
      en(0) => convert2_dout_net,
      rst(0) => convert1_dout_net_x2,
      q(0) => register_q_net_x0
    );

  relational: entity work.relational_92c392c8b6
    port map (
      a => accumulator_q_net,
      b => addsub_s_net,
      ce => ce_1_sg_x9,
      clk => clk_1_sg_x9,
      clr => '0',
      op(0) => relational_op_net
    );

  relational1: entity work.relational_fb96203f91
    port map (
      a => accumulator1_q_net,
      b => constant4_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational1_op_net
    );

  slice2: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 7,
      x_width => 9,
      y_width => 8
    )
    port map (
      x => mux3_y_net,
      y => slice2_y_net
    );

  slice3: entity work.xlslice
    generic map (
      new_lsb => 8,
      new_msb => 8,
      x_width => 9,
      y_width => 1
    )
    port map (
      x => mux3_y_net,
      y(0) => slice3_y_net
    );

  slice4: entity work.xlslice
    generic map (
      new_lsb => 14,
      new_msb => 14,
      x_width => 15,
      y_width => 1
    )
    port map (
      x => counter1_op_net,
      y(0) => slice4_y_net_x0
    );

  slice5: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 8,
      x_width => 16,
      y_width => 9
    )
    port map (
      x => mux_y_net_x0,
      y => slice5_y_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller/LCD Controller/DataROM/Character Buffer Shared Memory"

entity character_buffer_shared_memory_entity_1eeb1f8786 is
  port (
    addr_11b: in std_logic_vector(10 downto 0); 
    shared_memory: in std_logic_vector(31 downto 0); 
    constant1_x0: out std_logic; 
    constant_x1: out std_logic_vector(31 downto 0); 
    data_8b: out std_logic_vector(7 downto 0); 
    x9msb_x0: out std_logic_vector(8 downto 0)
  );
end character_buffer_shared_memory_entity_1eeb1f8786;

architecture structural of character_buffer_shared_memory_entity_1eeb1f8786 is
  signal concat1_y_net_x0: std_logic_vector(10 downto 0);
  signal constant1_op_net_x0: std_logic;
  signal constant_op_net_x0: std_logic_vector(31 downto 0);
  signal mux_y_net_x0: std_logic_vector(7 downto 0);
  signal shared_memory_data_out_net_x0: std_logic_vector(31 downto 0);
  signal x2lsb_y_net: std_logic_vector(1 downto 0);
  signal x8lsb_0_y_net: std_logic_vector(7 downto 0);
  signal x8lsb_16_y_net: std_logic_vector(7 downto 0);
  signal x8lsb_24_y_net: std_logic_vector(7 downto 0);
  signal x8lsb_8_y_net: std_logic_vector(7 downto 0);
  signal x9msb_y_net_x0: std_logic_vector(8 downto 0);

begin
  concat1_y_net_x0 <= addr_11b;
  shared_memory_data_out_net_x0 <= shared_memory;
  constant1_x0 <= constant1_op_net_x0;
  constant_x1 <= constant_op_net_x0;
  data_8b <= mux_y_net_x0;
  x9msb_x0 <= x9msb_y_net_x0;

  constant1: entity work.constant_963ed6358a
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant1_op_net_x0
    );

  constant_x0: entity work.constant_37567836aa
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant_op_net_x0
    );

  mux: entity work.mux_998e20a1ca
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => x8lsb_24_y_net,
      d1 => x8lsb_16_y_net,
      d2 => x8lsb_8_y_net,
      d3 => x8lsb_0_y_net,
      sel => x2lsb_y_net,
      y => mux_y_net_x0
    );

  x2lsb: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 1,
      x_width => 11,
      y_width => 2
    )
    port map (
      x => concat1_y_net_x0,
      y => x2lsb_y_net
    );

  x8lsb_0: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 7,
      x_width => 32,
      y_width => 8
    )
    port map (
      x => shared_memory_data_out_net_x0,
      y => x8lsb_0_y_net
    );

  x8lsb_16: entity work.xlslice
    generic map (
      new_lsb => 16,
      new_msb => 23,
      x_width => 32,
      y_width => 8
    )
    port map (
      x => shared_memory_data_out_net_x0,
      y => x8lsb_16_y_net
    );

  x8lsb_24: entity work.xlslice
    generic map (
      new_lsb => 24,
      new_msb => 31,
      x_width => 32,
      y_width => 8
    )
    port map (
      x => shared_memory_data_out_net_x0,
      y => x8lsb_24_y_net
    );

  x8lsb_8: entity work.xlslice
    generic map (
      new_lsb => 8,
      new_msb => 15,
      x_width => 32,
      y_width => 8
    )
    port map (
      x => shared_memory_data_out_net_x0,
      y => x8lsb_8_y_net
    );

  x9msb: entity work.xlslice
    generic map (
      new_lsb => 2,
      new_msb => 10,
      x_width => 11,
      y_width => 9
    )
    port map (
      x => concat1_y_net_x0,
      y => x9msb_y_net_x0
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller/LCD Controller/DataROM/Character Map Shared Memory"

entity character_map_shared_memory_entity_e504c38a5b is
  port (
    addr_14b: in std_logic_vector(13 downto 0); 
    shared_memory: in std_logic_vector(31 downto 0); 
    constant1_x0: out std_logic; 
    constant_x1: out std_logic_vector(31 downto 0); 
    data_8b: out std_logic_vector(7 downto 0); 
    x12msb_x0: out std_logic_vector(11 downto 0)
  );
end character_map_shared_memory_entity_e504c38a5b;

architecture structural of character_map_shared_memory_entity_e504c38a5b is
  signal concat_y_net_x0: std_logic_vector(13 downto 0);
  signal constant1_op_net_x0: std_logic;
  signal constant_op_net_x0: std_logic_vector(31 downto 0);
  signal mux_y_net_x0: std_logic_vector(7 downto 0);
  signal shared_memory_data_out_net_x0: std_logic_vector(31 downto 0);
  signal x12msb_y_net_x0: std_logic_vector(11 downto 0);
  signal x2lsb_y_net: std_logic_vector(1 downto 0);
  signal x8lsb_0_y_net: std_logic_vector(7 downto 0);
  signal x8lsb_16_y_net: std_logic_vector(7 downto 0);
  signal x8lsb_24_y_net: std_logic_vector(7 downto 0);
  signal x8lsb_8_y_net: std_logic_vector(7 downto 0);

begin
  concat_y_net_x0 <= addr_14b;
  shared_memory_data_out_net_x0 <= shared_memory;
  constant1_x0 <= constant1_op_net_x0;
  constant_x1 <= constant_op_net_x0;
  data_8b <= mux_y_net_x0;
  x12msb_x0 <= x12msb_y_net_x0;

  constant1: entity work.constant_963ed6358a
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant1_op_net_x0
    );

  constant_x0: entity work.constant_37567836aa
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant_op_net_x0
    );

  mux: entity work.mux_998e20a1ca
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => x8lsb_24_y_net,
      d1 => x8lsb_16_y_net,
      d2 => x8lsb_8_y_net,
      d3 => x8lsb_0_y_net,
      sel => x2lsb_y_net,
      y => mux_y_net_x0
    );

  x12msb: entity work.xlslice
    generic map (
      new_lsb => 2,
      new_msb => 13,
      x_width => 14,
      y_width => 12
    )
    port map (
      x => concat_y_net_x0,
      y => x12msb_y_net_x0
    );

  x2lsb: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 1,
      x_width => 14,
      y_width => 2
    )
    port map (
      x => concat_y_net_x0,
      y => x2lsb_y_net
    );

  x8lsb_0: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 7,
      x_width => 32,
      y_width => 8
    )
    port map (
      x => shared_memory_data_out_net_x0,
      y => x8lsb_0_y_net
    );

  x8lsb_16: entity work.xlslice
    generic map (
      new_lsb => 16,
      new_msb => 23,
      x_width => 32,
      y_width => 8
    )
    port map (
      x => shared_memory_data_out_net_x0,
      y => x8lsb_16_y_net
    );

  x8lsb_24: entity work.xlslice
    generic map (
      new_lsb => 24,
      new_msb => 31,
      x_width => 32,
      y_width => 8
    )
    port map (
      x => shared_memory_data_out_net_x0,
      y => x8lsb_24_y_net
    );

  x8lsb_8: entity work.xlslice
    generic map (
      new_lsb => 8,
      new_msb => 15,
      x_width => 32,
      y_width => 8
    )
    port map (
      x => shared_memory_data_out_net_x0,
      y => x8lsb_8_y_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller/LCD Controller/DataROM/Pos Edge Detector"

entity pos_edge_detector_entity_90ec5fccc3 is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    input_signal: in std_logic; 
    rising_edge: out std_logic
  );
end pos_edge_detector_entity_90ec5fccc3;

architecture structural of pos_edge_detector_entity_90ec5fccc3 is
  signal ce_1_sg_x10: std_logic;
  signal clk_1_sg_x10: std_logic;
  signal delay_q_net: std_logic;
  signal inverter_op_net: std_logic;
  signal logical_y_net_x0: std_logic;
  signal relational_op_net_x0: std_logic;

begin
  ce_1_sg_x10 <= ce_1;
  clk_1_sg_x10 <= clk_1;
  relational_op_net_x0 <= input_signal;
  rising_edge <= logical_y_net_x0;

  delay: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x10,
      clk => clk_1_sg_x10,
      d(0) => inverter_op_net,
      en => '1',
      q(0) => delay_q_net
    );

  inverter: entity work.inverter_e5b38cca3b
    port map (
      ce => ce_1_sg_x10,
      clk => clk_1_sg_x10,
      clr => '0',
      ip(0) => relational_op_net_x0,
      op(0) => inverter_op_net
    );

  logical: entity work.logical_80f90b97d0
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => relational_op_net_x0,
      d1(0) => delay_q_net,
      y(0) => logical_y_net_x0
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller/LCD Controller/DataROM/Subsystem"

entity subsystem_entity_8d430c7bea is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    not0: in std_logic; 
    transferdone: in std_logic; 
    x6bitval: in std_logic; 
    out1: out std_logic
  );
end subsystem_entity_8d430c7bea;

architecture structural of subsystem_entity_8d430c7bea is
  signal ce_1_sg_x11: std_logic;
  signal clk_1_sg_x11: std_logic;
  signal delay_q_net: std_logic;
  signal inverter2_op_net_x0: std_logic;
  signal logical1_y_net: std_logic;
  signal logical2_y_net: std_logic;
  signal logical3_y_net_x0: std_logic;
  signal logical_y_net_x0: std_logic;
  signal relational_op_net_x1: std_logic;

begin
  ce_1_sg_x11 <= ce_1;
  clk_1_sg_x11 <= clk_1;
  inverter2_op_net_x0 <= not0;
  logical_y_net_x0 <= transferdone;
  relational_op_net_x1 <= x6bitval;
  out1 <= logical3_y_net_x0;

  delay: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x11,
      clk => clk_1_sg_x11,
      d(0) => logical_y_net_x0,
      en => '1',
      q(0) => delay_q_net
    );

  logical1: entity work.logical_80f90b97d0
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => inverter2_op_net_x0,
      d1(0) => delay_q_net,
      y(0) => logical1_y_net
    );

  logical2: entity work.logical_80f90b97d0
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => relational_op_net_x1,
      d1(0) => delay_q_net,
      y(0) => logical2_y_net
    );

  logical3: entity work.logical_aacf6e1b0e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => logical2_y_net,
      d1(0) => logical1_y_net,
      y(0) => logical3_y_net_x0
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller/LCD Controller/DataROM/Subsystem1"

entity subsystem1_entity_a91e11b915 is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    x4bits: in std_logic_vector(3 downto 0); 
    end_x0: out std_logic_vector(8 downto 0); 
    start: out std_logic_vector(8 downto 0)
  );
end subsystem1_entity_a91e11b915;

architecture structural of subsystem1_entity_a91e11b915 is
  signal addsub1_s_net_x0: std_logic_vector(8 downto 0);
  signal addsub_s_net_x0: std_logic_vector(8 downto 0);
  signal ce_1_sg_x12: std_logic;
  signal clk_1_sg_x12: std_logic;
  signal concat6_y_net: std_logic_vector(6 downto 0);
  signal constant1_op_net: std_logic_vector(7 downto 0);
  signal constant2_op_net: std_logic_vector(7 downto 0);
  signal constant_op_net: std_logic_vector(2 downto 0);
  signal slice10_y_net_x0: std_logic_vector(3 downto 0);

begin
  ce_1_sg_x12 <= ce_1;
  clk_1_sg_x12 <= clk_1;
  slice10_y_net_x0 <= x4bits;
  end_x0 <= addsub1_s_net_x0;
  start <= addsub_s_net_x0;

  addsub: entity work.xladdsub
    generic map (
      a_arith => xlUnsigned,
      a_bin_pt => 0,
      a_width => 7,
      b_arith => xlUnsigned,
      b_bin_pt => 0,
      b_width => 8,
      c_has_b_out => 0,
      c_has_c_out => 0,
      c_has_q => 0,
      c_has_q_b_out => 0,
      c_has_q_c_out => 0,
      c_has_s => 1,
      c_latency => 0,
      c_output_width => 9,
      core_name0 => "adder_subtracter_virtex2p_7_0_453ed16ba8e84295",
      extra_registers => 0,
      full_s_arith => 1,
      full_s_width => 9,
      latency => 0,
      mode => 1,
      overflow => 1,
      quantization => 1,
      s_arith => xlUnsigned,
      s_bin_pt => 0,
      s_width => 9
    )
    port map (
      a => concat6_y_net,
      b => constant1_op_net,
      ce => ce_1_sg_x12,
      clk => clk_1_sg_x12,
      clr => '0',
      en => "1",
      s => addsub_s_net_x0
    );

  addsub1: entity work.xladdsub
    generic map (
      a_arith => xlUnsigned,
      a_bin_pt => 0,
      a_width => 7,
      b_arith => xlUnsigned,
      b_bin_pt => 0,
      b_width => 8,
      c_has_b_out => 0,
      c_has_c_out => 0,
      c_has_q => 0,
      c_has_q_b_out => 0,
      c_has_q_c_out => 0,
      c_has_s => 1,
      c_latency => 0,
      c_output_width => 9,
      core_name0 => "adder_subtracter_virtex2p_7_0_453ed16ba8e84295",
      extra_registers => 0,
      full_s_arith => 1,
      full_s_width => 9,
      latency => 0,
      mode => 1,
      overflow => 1,
      quantization => 1,
      s_arith => xlUnsigned,
      s_bin_pt => 0,
      s_width => 9
    )
    port map (
      a => concat6_y_net,
      b => constant2_op_net,
      ce => ce_1_sg_x12,
      clk => clk_1_sg_x12,
      clr => '0',
      en => "1",
      s => addsub1_s_net_x0
    );

  concat6: entity work.concat_32864ba5d6
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0 => slice10_y_net_x0,
      in1 => constant_op_net,
      y => concat6_y_net
    );

  constant1: entity work.constant_21d4a28b7e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant1_op_net
    );

  constant2: entity work.constant_b940b9054a
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant2_op_net
    );

  constant_x0: entity work.constant_822933f89b
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant_op_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller/LCD Controller/DataROM"

entity datarom_entity_fd2cd392cc is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    cmdsdone: in std_logic; 
    from_register1: in std_logic_vector(8 downto 0); 
    from_register2: in std_logic_vector(8 downto 0); 
    from_register3: in std_logic_vector(8 downto 0); 
    from_register4: in std_logic_vector(2 downto 0); 
    from_register5: in std_logic_vector(3 downto 0); 
    from_register7: in std_logic_vector(3 downto 0); 
    reset: in std_logic; 
    shared_memory: in std_logic_vector(31 downto 0); 
    shared_memory_x0: in std_logic_vector(31 downto 0); 
    transferdone: in std_logic; 
    character_buffer_shared_memory: out std_logic_vector(8 downto 0); 
    character_buffer_shared_memory_x0: out std_logic_vector(31 downto 0); 
    character_buffer_shared_memory_x1: out std_logic; 
    character_map_shared_memory: out std_logic_vector(11 downto 0); 
    character_map_shared_memory_x0: out std_logic_vector(31 downto 0); 
    character_map_shared_memory_x1: out std_logic; 
    data: out std_logic_vector(8 downto 0); 
    starttransfer: out std_logic
  );
end datarom_entity_fd2cd392cc;

architecture structural of datarom_entity_fd2cd392cc is
  signal addsub1_s_net: std_logic_vector(3 downto 0);
  signal addsub1_s_net_x0: std_logic_vector(8 downto 0);
  signal addsub1_s_net_x1: std_logic_vector(8 downto 0);
  signal addsub2_s_net: std_logic_vector(3 downto 0);
  signal addsub_s_net_x0: std_logic_vector(8 downto 0);
  signal addsub_s_net_x1: std_logic_vector(8 downto 0);
  signal ce_1_sg_x14: std_logic;
  signal clk_1_sg_x14: std_logic;
  signal concat1_y_net_x0: std_logic_vector(10 downto 0);
  signal concat3_y_net: std_logic_vector(1 downto 0);
  signal concat4_y_net_x0: std_logic_vector(8 downto 0);
  signal concat5_y_net: std_logic_vector(8 downto 0);
  signal concat_y_net_x0: std_logic_vector(13 downto 0);
  signal constant10_op_net: std_logic;
  signal constant1_op_net_x2: std_logic;
  signal constant1_op_net_x3: std_logic;
  signal constant4_op_net: std_logic;
  signal constant5_op_net: std_logic;
  signal constant6_op_net: std_logic_vector(2 downto 0);
  signal constant7_op_net: std_logic_vector(2 downto 0);
  signal constant8_op_net: std_logic_vector(2 downto 0);
  signal constant9_op_net: std_logic;
  signal constant_op_net_x2: std_logic_vector(31 downto 0);
  signal constant_op_net_x3: std_logic_vector(31 downto 0);
  signal convert1_dout_net: std_logic;
  signal convert1_dout_net_x4: std_logic;
  signal convert1_dout_net_x5: std_logic;
  signal convert_dout_net: std_logic;
  signal counter1_op_net: std_logic_vector(13 downto 0);
  signal counter_op_net: std_logic_vector(2 downto 0);
  signal delay_q_net_x0: std_logic;
  signal from_register1_data_out_net_x0: std_logic_vector(8 downto 0);
  signal from_register2_data_out_net_x0: std_logic_vector(8 downto 0);
  signal from_register3_data_out_net_x0: std_logic_vector(8 downto 0);
  signal from_register4_data_out_net_x0: std_logic_vector(2 downto 0);
  signal from_register5_data_out_net_x0: std_logic_vector(3 downto 0);
  signal from_register7_data_out_net_x0: std_logic_vector(3 downto 0);
  signal inverter2_op_net_x0: std_logic;
  signal inverter3_op_net: std_logic;
  signal logical1_y_net: std_logic;
  signal logical3_y_net_x0: std_logic;
  signal logical_y_net_x0: std_logic;
  signal logical_y_net_x1: std_logic;
  signal mux2_y_net: std_logic_vector(2 downto 0);
  signal mux3_y_net: std_logic_vector(8 downto 0);
  signal mux_y_net_x0: std_logic_vector(7 downto 0);
  signal mux_y_net_x1: std_logic_vector(7 downto 0);
  signal register_q_net: std_logic_vector(5 downto 0);
  signal register_q_net_x1: std_logic;
  signal relational1_op_net: std_logic;
  signal relational2_op_net: std_logic;
  signal relational_op_net_x1: std_logic;
  signal shared_memory_data_out_net_x2: std_logic_vector(31 downto 0);
  signal shared_memory_data_out_net_x3: std_logic_vector(31 downto 0);
  signal slice10_y_net_x0: std_logic_vector(3 downto 0);
  signal slice11_y_net_x0: std_logic_vector(3 downto 0);
  signal slice4_y_net: std_logic_vector(7 downto 0);
  signal slice5_y_net: std_logic_vector(5 downto 0);
  signal slice6_y_net: std_logic_vector(5 downto 0);
  signal slice7_y_net: std_logic_vector(3 downto 0);
  signal slice8_y_net: std_logic_vector(7 downto 0);
  signal slice9_y_net: std_logic;
  signal x12msb_y_net_x1: std_logic_vector(11 downto 0);
  signal x4lsb_y_net: std_logic_vector(3 downto 0);
  signal x4msb_y_net: std_logic_vector(3 downto 0);
  signal x9msb_y_net_x1: std_logic_vector(8 downto 0);

begin
  ce_1_sg_x14 <= ce_1;
  clk_1_sg_x14 <= clk_1;
  register_q_net_x1 <= cmdsdone;
  from_register1_data_out_net_x0 <= from_register1;
  from_register2_data_out_net_x0 <= from_register2;
  from_register3_data_out_net_x0 <= from_register3;
  from_register4_data_out_net_x0 <= from_register4;
  from_register5_data_out_net_x0 <= from_register5;
  from_register7_data_out_net_x0 <= from_register7;
  convert1_dout_net_x4 <= reset;
  shared_memory_data_out_net_x2 <= shared_memory;
  shared_memory_data_out_net_x3 <= shared_memory_x0;
  convert1_dout_net_x5 <= transferdone;
  character_buffer_shared_memory <= x9msb_y_net_x1;
  character_buffer_shared_memory_x0 <= constant_op_net_x2;
  character_buffer_shared_memory_x1 <= constant1_op_net_x2;
  character_map_shared_memory <= x12msb_y_net_x1;
  character_map_shared_memory_x0 <= constant_op_net_x3;
  character_map_shared_memory_x1 <= constant1_op_net_x3;
  data <= concat4_y_net_x0;
  starttransfer <= delay_q_net_x0;

  addsub1: entity work.xladdsub
    generic map (
      a_arith => xlUnsigned,
      a_bin_pt => 0,
      a_width => 4,
      b_arith => xlUnsigned,
      b_bin_pt => 0,
      b_width => 4,
      c_has_b_out => 0,
      c_has_c_out => 0,
      c_has_q => 0,
      c_has_q_b_out => 0,
      c_has_q_c_out => 0,
      c_has_s => 1,
      c_latency => 0,
      c_output_width => 5,
      core_name0 => "adder_subtracter_virtex2p_7_0_7182743c9e7adf5e",
      extra_registers => 0,
      full_s_arith => 1,
      full_s_width => 5,
      latency => 0,
      mode => 1,
      overflow => 1,
      quantization => 1,
      s_arith => xlUnsigned,
      s_bin_pt => 0,
      s_width => 4
    )
    port map (
      a => from_register7_data_out_net_x0,
      b => x4msb_y_net,
      ce => ce_1_sg_x14,
      clk => clk_1_sg_x14,
      clr => '0',
      en => "1",
      s => addsub1_s_net
    );

  addsub2: entity work.xladdsub
    generic map (
      a_arith => xlUnsigned,
      a_bin_pt => 0,
      a_width => 4,
      b_arith => xlUnsigned,
      b_bin_pt => 0,
      b_width => 4,
      c_has_b_out => 0,
      c_has_c_out => 0,
      c_has_q => 0,
      c_has_q_b_out => 0,
      c_has_q_c_out => 0,
      c_has_s => 1,
      c_latency => 0,
      c_output_width => 5,
      core_name0 => "adder_subtracter_virtex2p_7_0_7182743c9e7adf5e",
      extra_registers => 0,
      full_s_arith => 1,
      full_s_width => 5,
      latency => 0,
      mode => 1,
      overflow => 1,
      quantization => 1,
      s_arith => xlUnsigned,
      s_bin_pt => 0,
      s_width => 4
    )
    port map (
      a => x4lsb_y_net,
      b => from_register5_data_out_net_x0,
      ce => ce_1_sg_x14,
      clk => clk_1_sg_x14,
      clr => '0',
      en => "1",
      s => addsub2_s_net
    );

  character_buffer_shared_memory_1eeb1f8786: entity work.character_buffer_shared_memory_entity_1eeb1f8786
    port map (
      addr_11b => concat1_y_net_x0,
      shared_memory => shared_memory_data_out_net_x2,
      constant1_x0 => constant1_op_net_x2,
      constant_x1 => constant_op_net_x2,
      data_8b => mux_y_net_x0,
      x9msb_x0 => x9msb_y_net_x1
    );

  character_map_shared_memory_e504c38a5b: entity work.character_map_shared_memory_entity_e504c38a5b
    port map (
      addr_14b => concat_y_net_x0,
      shared_memory => shared_memory_data_out_net_x3,
      constant1_x0 => constant1_op_net_x3,
      constant_x1 => constant_op_net_x3,
      data_8b => mux_y_net_x1,
      x12msb_x0 => x12msb_y_net_x1
    );

  concat: entity work.concat_25ab81b400
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0 => mux_y_net_x0,
      in1 => register_q_net,
      y => concat_y_net_x0
    );

  concat1: entity work.concat_78218439f3
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0 => from_register4_data_out_net_x0,
      in1 => addsub1_s_net,
      in2 => addsub2_s_net,
      y => concat1_y_net_x0
    );

  concat3: entity work.concat_e6f5ee726b
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0(0) => convert_dout_net,
      in1(0) => convert1_dout_net,
      y => concat3_y_net
    );

  concat4: entity work.concat_1ece14600f
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0(0) => inverter3_op_net,
      in1 => slice8_y_net,
      y => concat4_y_net_x0
    );

  concat5: entity work.concat_1ece14600f
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0(0) => constant10_op_net,
      in1 => mux_y_net_x1,
      y => concat5_y_net
    );

  constant10: entity work.constant_963ed6358a
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant10_op_net
    );

  constant4: entity work.constant_963ed6358a
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant4_op_net
    );

  constant5: entity work.constant_963ed6358a
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant5_op_net
    );

  constant6: entity work.constant_822933f89b
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant6_op_net
    );

  constant7: entity work.constant_469094441c
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant7_op_net
    );

  constant8: entity work.constant_a1c496ea88
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant8_op_net
    );

  constant9: entity work.constant_963ed6358a
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant9_op_net
    );

  convert: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 1,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 1,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din(0) => relational_op_net_x1,
      dout(0) => convert_dout_net
    );

  convert1: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 1,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 1,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din(0) => relational1_op_net,
      dout(0) => convert1_dout_net
    );

  counter: entity work.xlcounter_free
    generic map (
      core_name0 => "binary_counter_virtex2p_7_0_b511f9871581ee23",
      op_arith => xlUnsigned,
      op_width => 3
    )
    port map (
      ce => ce_1_sg_x14,
      clk => clk_1_sg_x14,
      clr => '0',
      din => mux2_y_net,
      en(0) => logical3_y_net_x0,
      load(0) => logical_y_net_x1,
      rst => "0",
      op => counter_op_net
    );

  counter1: entity work.xlcounter_free
    generic map (
      core_name0 => "binary_counter_virtex2p_7_0_a22528b4c55dc1cd",
      op_arith => xlUnsigned,
      op_width => 14
    )
    port map (
      ce => ce_1_sg_x14,
      clk => clk_1_sg_x14,
      clr => '0',
      en(0) => logical1_y_net,
      rst(0) => convert1_dout_net_x4,
      op => counter1_op_net
    );

  delay: entity work.xldelay
    generic map (
      latency => 4,
      reg_retiming => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x14,
      clk => clk_1_sg_x14,
      d(0) => logical_y_net_x0,
      en => '1',
      q(0) => delay_q_net_x0
    );

  inverter2: entity work.inverter_e5b38cca3b
    port map (
      ce => ce_1_sg_x14,
      clk => clk_1_sg_x14,
      clr => '0',
      ip(0) => relational2_op_net,
      op(0) => inverter2_op_net_x0
    );

  inverter3: entity work.inverter_e2b989a05e
    port map (
      ce => ce_1_sg_x14,
      clk => clk_1_sg_x14,
      clr => '0',
      ip(0) => slice9_y_net,
      op(0) => inverter3_op_net
    );

  logical: entity work.logical_80f90b97d0
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => convert1_dout_net_x5,
      d1(0) => register_q_net_x1,
      y(0) => logical_y_net_x0
    );

  logical1: entity work.logical_80f90b97d0
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => relational2_op_net,
      d1(0) => logical_y_net_x0,
      y(0) => logical1_y_net
    );

  mux2: entity work.mux_2ec2057ae3
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => constant6_op_net,
      d1 => constant6_op_net,
      d2 => constant7_op_net,
      d3 => constant8_op_net,
      sel => concat3_y_net,
      y => mux2_y_net
    );

  mux3: entity work.mux_7586447000
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => concat5_y_net,
      d1 => from_register3_data_out_net_x0,
      d2 => addsub_s_net_x0,
      d3 => addsub1_s_net_x0,
      d4 => from_register1_data_out_net_x0,
      d5 => addsub_s_net_x1,
      d6 => addsub1_s_net_x1,
      d7 => from_register2_data_out_net_x0,
      sel => counter_op_net,
      y => mux3_y_net
    );

  pos_edge_detector_90ec5fccc3: entity work.pos_edge_detector_entity_90ec5fccc3
    port map (
      ce_1 => ce_1_sg_x14,
      clk_1 => clk_1_sg_x14,
      input_signal => relational_op_net_x1,
      rising_edge => logical_y_net_x1
    );

  register_x0: entity work.xlregister
    generic map (
      d_width => 6,
      init_value => b"000000"
    )
    port map (
      ce => ce_1_sg_x14,
      clk => clk_1_sg_x14,
      d => slice5_y_net,
      en => "1",
      rst => "0",
      q => register_q_net
    );

  relational: entity work.relational_f7cb2b0c31
    port map (
      a => slice6_y_net,
      b(0) => constant4_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational_op_net_x1
    );

  relational1: entity work.relational_ee03197e2c
    port map (
      a => slice7_y_net,
      b(0) => constant5_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational1_op_net
    );

  relational2: entity work.relational_04b069dd89
    port map (
      a => counter_op_net,
      b(0) => constant9_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational2_op_net
    );

  slice10: entity work.xlslice
    generic map (
      new_lsb => 10,
      new_msb => 13,
      x_width => 14,
      y_width => 4
    )
    port map (
      x => counter1_op_net,
      y => slice10_y_net_x0
    );

  slice11: entity work.xlslice
    generic map (
      new_lsb => 6,
      new_msb => 9,
      x_width => 14,
      y_width => 4
    )
    port map (
      x => counter1_op_net,
      y => slice11_y_net_x0
    );

  slice4: entity work.xlslice
    generic map (
      new_lsb => 6,
      new_msb => 13,
      x_width => 14,
      y_width => 8
    )
    port map (
      x => counter1_op_net,
      y => slice4_y_net
    );

  slice5: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 5,
      x_width => 14,
      y_width => 6
    )
    port map (
      x => counter1_op_net,
      y => slice5_y_net
    );

  slice6: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 5,
      x_width => 14,
      y_width => 6
    )
    port map (
      x => counter1_op_net,
      y => slice6_y_net
    );

  slice7: entity work.xlslice
    generic map (
      new_lsb => 6,
      new_msb => 9,
      x_width => 14,
      y_width => 4
    )
    port map (
      x => counter1_op_net,
      y => slice7_y_net
    );

  slice8: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 7,
      x_width => 9,
      y_width => 8
    )
    port map (
      x => mux3_y_net,
      y => slice8_y_net
    );

  slice9: entity work.xlslice
    generic map (
      new_lsb => 8,
      new_msb => 8,
      x_width => 9,
      y_width => 1
    )
    port map (
      x => mux3_y_net,
      y(0) => slice9_y_net
    );

  subsystem1_a91e11b915: entity work.subsystem1_entity_a91e11b915
    port map (
      ce_1 => ce_1_sg_x14,
      clk_1 => clk_1_sg_x14,
      x4bits => slice10_y_net_x0,
      end_x0 => addsub1_s_net_x0,
      start => addsub_s_net_x0
    );

  subsystem2_4e1ae86655: entity work.subsystem1_entity_a91e11b915
    port map (
      ce_1 => ce_1_sg_x14,
      clk_1 => clk_1_sg_x14,
      x4bits => slice11_y_net_x0,
      end_x0 => addsub1_s_net_x1,
      start => addsub_s_net_x1
    );

  subsystem_8d430c7bea: entity work.subsystem_entity_8d430c7bea
    port map (
      ce_1 => ce_1_sg_x14,
      clk_1 => clk_1_sg_x14,
      not0 => inverter2_op_net_x0,
      transferdone => logical_y_net_x0,
      x6bitval => relational_op_net_x1,
      out1 => logical3_y_net_x0
    );

  x4lsb: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 3,
      x_width => 8,
      y_width => 4
    )
    port map (
      x => slice4_y_net,
      y => x4lsb_y_net
    );

  x4msb: entity work.xlslice
    generic map (
      new_lsb => 4,
      new_msb => 7,
      x_width => 8,
      y_width => 4
    )
    port map (
      x => slice4_y_net,
      y => x4msb_y_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller/LCD Controller/SPI/Data_Latch"

entity data_latch_entity_d697580f4e is
  port (
    bit_select: in std_logic_vector(3 downto 0); 
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    data_to_transmit: in std_logic_vector(8 downto 0); 
    latchdata: in std_logic; 
    reset: in std_logic; 
    spi_data: out std_logic
  );
end data_latch_entity_d697580f4e;

architecture structural of data_latch_entity_d697580f4e is
  signal ce_1_sg_x16: std_logic;
  signal clk_1_sg_x16: std_logic;
  signal convert1_dout_net_x5: std_logic;
  signal counter_op_net_x0: std_logic_vector(3 downto 0);
  signal mux1_y_net_x0: std_logic;
  signal mux_y_net_x1: std_logic_vector(8 downto 0);
  signal mux_y_net_x2: std_logic;
  signal register_q_net: std_logic_vector(8 downto 0);
  signal slice1_y_net: std_logic;
  signal slice2_y_net: std_logic;
  signal slice3_y_net: std_logic;
  signal slice4_y_net: std_logic;
  signal slice5_y_net: std_logic;
  signal slice6_y_net: std_logic;
  signal slice7_y_net: std_logic;
  signal slice8_y_net: std_logic;
  signal slice_y_net: std_logic;

begin
  counter_op_net_x0 <= bit_select;
  ce_1_sg_x16 <= ce_1;
  clk_1_sg_x16 <= clk_1;
  mux_y_net_x1 <= data_to_transmit;
  mux1_y_net_x0 <= latchdata;
  convert1_dout_net_x5 <= reset;
  spi_data <= mux_y_net_x2;

  mux: entity work.mux_8e3eece8f2
    port map (
      ce => ce_1_sg_x16,
      clk => clk_1_sg_x16,
      clr => '0',
      d0(0) => slice_y_net,
      d1(0) => slice1_y_net,
      d2(0) => slice2_y_net,
      d3(0) => slice3_y_net,
      d4(0) => slice4_y_net,
      d5(0) => slice5_y_net,
      d6(0) => slice6_y_net,
      d7(0) => slice7_y_net,
      d8(0) => slice8_y_net,
      sel => counter_op_net_x0,
      y(0) => mux_y_net_x2
    );

  register_x0: entity work.xlregister
    generic map (
      d_width => 9,
      init_value => b"000000000"
    )
    port map (
      ce => ce_1_sg_x16,
      clk => clk_1_sg_x16,
      d => mux_y_net_x1,
      en(0) => mux1_y_net_x0,
      rst(0) => convert1_dout_net_x5,
      q => register_q_net
    );

  slice: entity work.xlslice
    generic map (
      new_lsb => 8,
      new_msb => 8,
      x_width => 9,
      y_width => 1
    )
    port map (
      x => register_q_net,
      y(0) => slice_y_net
    );

  slice1: entity work.xlslice
    generic map (
      new_lsb => 7,
      new_msb => 7,
      x_width => 9,
      y_width => 1
    )
    port map (
      x => register_q_net,
      y(0) => slice1_y_net
    );

  slice2: entity work.xlslice
    generic map (
      new_lsb => 6,
      new_msb => 6,
      x_width => 9,
      y_width => 1
    )
    port map (
      x => register_q_net,
      y(0) => slice2_y_net
    );

  slice3: entity work.xlslice
    generic map (
      new_lsb => 5,
      new_msb => 5,
      x_width => 9,
      y_width => 1
    )
    port map (
      x => register_q_net,
      y(0) => slice3_y_net
    );

  slice4: entity work.xlslice
    generic map (
      new_lsb => 4,
      new_msb => 4,
      x_width => 9,
      y_width => 1
    )
    port map (
      x => register_q_net,
      y(0) => slice4_y_net
    );

  slice5: entity work.xlslice
    generic map (
      new_lsb => 3,
      new_msb => 3,
      x_width => 9,
      y_width => 1
    )
    port map (
      x => register_q_net,
      y(0) => slice5_y_net
    );

  slice6: entity work.xlslice
    generic map (
      new_lsb => 2,
      new_msb => 2,
      x_width => 9,
      y_width => 1
    )
    port map (
      x => register_q_net,
      y(0) => slice6_y_net
    );

  slice7: entity work.xlslice
    generic map (
      new_lsb => 1,
      new_msb => 1,
      x_width => 9,
      y_width => 1
    )
    port map (
      x => register_q_net,
      y(0) => slice7_y_net
    );

  slice8: entity work.xlslice
    generic map (
      new_lsb => 0,
      new_msb => 0,
      x_width => 9,
      y_width => 1
    )
    port map (
      x => register_q_net,
      y(0) => slice8_y_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller/LCD Controller/SPI/Pos Edge Detector"

entity pos_edge_detector_entity_ac86c1f1ba is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    input_signal: in std_logic; 
    rising_edge: out std_logic
  );
end pos_edge_detector_entity_ac86c1f1ba;

architecture structural of pos_edge_detector_entity_ac86c1f1ba is
  signal ce_1_sg_x17: std_logic;
  signal clk_1_sg_x17: std_logic;
  signal delay_q_net: std_logic;
  signal inverter_op_net: std_logic;
  signal logical_y_net_x0: std_logic;
  signal mux_y_net_x0: std_logic;

begin
  ce_1_sg_x17 <= ce_1;
  clk_1_sg_x17 <= clk_1;
  mux_y_net_x0 <= input_signal;
  rising_edge <= logical_y_net_x0;

  delay: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x17,
      clk => clk_1_sg_x17,
      d(0) => inverter_op_net,
      en => '1',
      q(0) => delay_q_net
    );

  inverter: entity work.inverter_e2b989a05e
    port map (
      ce => ce_1_sg_x17,
      clk => clk_1_sg_x17,
      clr => '0',
      ip(0) => mux_y_net_x0,
      op(0) => inverter_op_net
    );

  logical: entity work.logical_938d99ac11
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => mux_y_net_x0,
      d1(0) => delay_q_net,
      y(0) => logical_y_net_x0
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller/LCD Controller/SPI"

entity spi_entity_fd37afb7f3 is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    data_to_transfer: in std_logic_vector(8 downto 0); 
    dividerselect: in std_logic; 
    reset: in std_logic; 
    send: in std_logic; 
    cs: out std_logic; 
    data: out std_logic; 
    done: out std_logic; 
    scl: out std_logic
  );
end spi_entity_fd37afb7f3;

architecture structural of spi_entity_fd37afb7f3 is
  signal ce_1_sg_x19: std_logic;
  signal clk_1_sg_x19: std_logic;
  signal constant_op_net: std_logic_vector(3 downto 0);
  signal convert1_dout_net_x7: std_logic;
  signal convert1_dout_net_x8: std_logic;
  signal convert_dout_net_x0: std_logic;
  signal convert_dout_net_x1: std_logic;
  signal counter1_op_net: std_logic_vector(3 downto 0);
  signal counter_op_net_x0: std_logic_vector(3 downto 0);
  signal delay1_q_net: std_logic;
  signal delay_q_net: std_logic;
  signal inverter1_op_net_x0: std_logic;
  signal inverter_op_net_x0: std_logic;
  signal logical_y_net: std_logic;
  signal logical_y_net_x0: std_logic;
  signal logical_y_net_x1: std_logic;
  signal mux1_y_net: std_logic;
  signal mux1_y_net_x1: std_logic;
  signal mux_y_net_x3: std_logic_vector(8 downto 0);
  signal mux_y_net_x4: std_logic;
  signal mux_y_net_x5: std_logic;
  signal register_q_net: std_logic;
  signal slice1_y_net: std_logic;
  signal slice2_y_net: std_logic;
  signal slice_y_net: std_logic;

begin
  ce_1_sg_x19 <= ce_1;
  clk_1_sg_x19 <= clk_1;
  mux_y_net_x3 <= data_to_transfer;
  convert_dout_net_x1 <= dividerselect;
  convert1_dout_net_x7 <= reset;
  mux1_y_net_x1 <= send;
  cs <= inverter_op_net_x0;
  data <= mux_y_net_x4;
  done <= convert1_dout_net_x8;
  scl <= mux_y_net_x5;

  constant_x0: entity work.constant_06590e4008
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant_op_net
    );

  convert: entity work.xlconvert
    generic map (
      bool_conversion => 1,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 1,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 1,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din(0) => mux1_y_net,
      dout(0) => convert_dout_net_x0
    );

  convert1: entity work.xlconvert
    generic map (
      bool_conversion => 1,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 1,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 1,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din(0) => logical_y_net_x1,
      dout(0) => convert1_dout_net_x8
    );

  counter: entity work.xlcounter_limit
    generic map (
      cnt_15_0 => 8,
      cnt_31_16 => 0,
      cnt_47_32 => 0,
      cnt_63_48 => 0,
      core_name0 => "binary_counter_virtex2p_7_0_23542cbcca0efa2e",
      count_limited => 1,
      op_arith => xlUnsigned,
      op_width => 4
    )
    port map (
      ce => ce_1_sg_x19,
      clk => clk_1_sg_x19,
      clr => '0',
      en(0) => convert_dout_net_x0,
      rst(0) => convert1_dout_net_x7,
      op => counter_op_net_x0
    );

  counter1: entity work.xlcounter_free
    generic map (
      core_name0 => "binary_counter_virtex2p_7_0_77cea312f82499f0",
      op_arith => xlUnsigned,
      op_width => 4
    )
    port map (
      ce => ce_1_sg_x19,
      clk => clk_1_sg_x19,
      clr => '0',
      din => constant_op_net,
      en(0) => register_q_net,
      load(0) => convert1_dout_net_x8,
      rst(0) => convert1_dout_net_x7,
      op => counter1_op_net
    );

  data_latch_d697580f4e: entity work.data_latch_entity_d697580f4e
    port map (
      bit_select => counter_op_net_x0,
      ce_1 => ce_1_sg_x19,
      clk_1 => clk_1_sg_x19,
      data_to_transmit => mux_y_net_x3,
      latchdata => mux1_y_net_x1,
      reset => convert1_dout_net_x7,
      spi_data => mux_y_net_x4
    );

  delay: entity work.xldelay
    generic map (
      latency => 2,
      reg_retiming => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x19,
      clk => clk_1_sg_x19,
      d(0) => logical_y_net_x0,
      en => '1',
      q(0) => delay_q_net
    );

  delay1: entity work.xldelay
    generic map (
      latency => 6,
      reg_retiming => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x19,
      clk => clk_1_sg_x19,
      d(0) => logical_y_net_x0,
      en => '1',
      q(0) => delay1_q_net
    );

  inverter: entity work.inverter_e5b38cca3b
    port map (
      ce => ce_1_sg_x19,
      clk => clk_1_sg_x19,
      clr => '0',
      ip(0) => register_q_net,
      op(0) => inverter_op_net_x0
    );

  inverter1: entity work.inverter_e2b989a05e
    port map (
      ce => ce_1_sg_x19,
      clk => clk_1_sg_x19,
      clr => '0',
      ip(0) => slice1_y_net,
      op(0) => inverter1_op_net_x0
    );

  logical: entity work.logical_aacf6e1b0e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => convert1_dout_net_x8,
      d1(0) => mux1_y_net_x1,
      y(0) => logical_y_net
    );

  mux: entity work.mux_112ed141f4
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => slice_y_net,
      d1(0) => slice2_y_net,
      sel(0) => convert_dout_net_x1,
      y(0) => mux_y_net_x5
    );

  mux1: entity work.mux_112ed141f4
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => delay_q_net,
      d1(0) => delay1_q_net,
      sel(0) => convert_dout_net_x1,
      y(0) => mux1_y_net
    );

  pos_edge_detector2_d448638b52: entity work.pos_edge_detector_entity_ac86c1f1ba
    port map (
      ce_1 => ce_1_sg_x19,
      clk_1 => clk_1_sg_x19,
      input_signal => inverter1_op_net_x0,
      rising_edge => logical_y_net_x1
    );

  pos_edge_detector_ac86c1f1ba: entity work.pos_edge_detector_entity_ac86c1f1ba
    port map (
      ce_1 => ce_1_sg_x19,
      clk_1 => clk_1_sg_x19,
      input_signal => mux_y_net_x5,
      rising_edge => logical_y_net_x0
    );

  register_x0: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x19,
      clk => clk_1_sg_x19,
      d(0) => mux1_y_net_x1,
      en(0) => logical_y_net,
      rst(0) => convert1_dout_net_x7,
      q(0) => register_q_net
    );

  slice: entity work.xlslice
    generic map (
      new_lsb => 2,
      new_msb => 2,
      x_width => 4,
      y_width => 1
    )
    port map (
      x => counter1_op_net,
      y(0) => slice_y_net
    );

  slice1: entity work.xlslice
    generic map (
      new_lsb => 3,
      new_msb => 3,
      x_width => 4,
      y_width => 1
    )
    port map (
      x => counter_op_net_x0,
      y(0) => slice1_y_net
    );

  slice2: entity work.xlslice
    generic map (
      new_lsb => 3,
      new_msb => 3,
      x_width => 4,
      y_width => 1
    )
    port map (
      x => counter1_op_net,
      y(0) => slice2_y_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller/LCD Controller"

entity lcd_controller_entity_e3a358fc2f is
  port (
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    from_register: in std_logic; 
    from_register1: in std_logic_vector(8 downto 0); 
    from_register1_x0: in std_logic_vector(8 downto 0); 
    from_register2: in std_logic_vector(8 downto 0); 
    from_register2_x0: in std_logic_vector(8 downto 0); 
    from_register3: in std_logic_vector(8 downto 0); 
    from_register3_x0: in std_logic_vector(8 downto 0); 
    from_register3_x1: in std_logic_vector(7 downto 0); 
    from_register4: in std_logic_vector(8 downto 0); 
    from_register4_x0: in std_logic_vector(2 downto 0); 
    from_register4_x1: in std_logic; 
    from_register5: in std_logic_vector(8 downto 0); 
    from_register5_x0: in std_logic_vector(3 downto 0); 
    from_register5_x1: in std_logic; 
    from_register6: in std_logic_vector(1 downto 0); 
    from_register6_x0: in std_logic; 
    from_register7: in std_logic_vector(3 downto 0); 
    reset: in std_logic; 
    shared_memory: in std_logic_vector(31 downto 0); 
    shared_memory_x0: in std_logic_vector(31 downto 0); 
    shared_memory_x1: in std_logic_vector(31 downto 0); 
    commandrom: out std_logic_vector(7 downto 0); 
    commandrom_x0: out std_logic_vector(31 downto 0); 
    commandrom_x1: out std_logic; 
    datarom: out std_logic_vector(8 downto 0); 
    datarom_x0: out std_logic_vector(31 downto 0); 
    datarom_x1: out std_logic; 
    datarom_x2: out std_logic_vector(11 downto 0); 
    datarom_x3: out std_logic_vector(31 downto 0); 
    datarom_x4: out std_logic; 
    delay_x0: out std_logic; 
    spi: out std_logic; 
    spi_x0: out std_logic; 
    spi_x1: out std_logic
  );
end lcd_controller_entity_e3a358fc2f;

architecture structural of lcd_controller_entity_e3a358fc2f is
  signal ce_1_sg_x20: std_logic;
  signal clk_1_sg_x20: std_logic;
  signal concat2_y_net_x0: std_logic_vector(8 downto 0);
  signal concat4_y_net_x0: std_logic_vector(8 downto 0);
  signal constant1_op_net_x4: std_logic;
  signal constant1_op_net_x5: std_logic;
  signal constant1_op_net_x6: std_logic;
  signal constant_op_net_x4: std_logic_vector(31 downto 0);
  signal constant_op_net_x5: std_logic_vector(31 downto 0);
  signal constant_op_net_x6: std_logic_vector(31 downto 0);
  signal convert1_dout_net_x7: std_logic;
  signal convert1_dout_net_x8: std_logic;
  signal convert2_dout_net_x0: std_logic;
  signal convert_dout_net_x1: std_logic;
  signal delay_q_net_x0: std_logic;
  signal delay_q_net_x1: std_logic;
  signal from_register1_data_out_net_x2: std_logic_vector(8 downto 0);
  signal from_register1_data_out_net_x3: std_logic_vector(8 downto 0);
  signal from_register2_data_out_net_x2: std_logic_vector(8 downto 0);
  signal from_register2_data_out_net_x3: std_logic_vector(8 downto 0);
  signal from_register3_data_out_net_x3: std_logic_vector(8 downto 0);
  signal from_register3_data_out_net_x4: std_logic_vector(8 downto 0);
  signal from_register3_data_out_net_x5: std_logic_vector(7 downto 0);
  signal from_register4_data_out_net_x2: std_logic_vector(8 downto 0);
  signal from_register4_data_out_net_x3: std_logic_vector(2 downto 0);
  signal from_register4_data_out_net_x4: std_logic;
  signal from_register5_data_out_net_x2: std_logic_vector(8 downto 0);
  signal from_register5_data_out_net_x3: std_logic_vector(3 downto 0);
  signal from_register5_data_out_net_x4: std_logic;
  signal from_register6_data_out_net_x1: std_logic_vector(1 downto 0);
  signal from_register6_data_out_net_x2: std_logic;
  signal from_register7_data_out_net_x1: std_logic_vector(3 downto 0);
  signal from_register_data_out_net_x0: std_logic;
  signal inverter_op_net_x1: std_logic;
  signal logical1_y_net: std_logic;
  signal logical_y_net_x3: std_logic;
  signal mux1_y_net_x1: std_logic;
  signal mux2_y_net_x0: std_logic;
  signal mux_y_net_x3: std_logic_vector(8 downto 0);
  signal mux_y_net_x6: std_logic;
  signal mux_y_net_x7: std_logic;
  signal register_q_net_x1: std_logic;
  signal reset_net_x0: std_logic;
  signal shared_memory_data_out_net_x4: std_logic_vector(31 downto 0);
  signal shared_memory_data_out_net_x5: std_logic_vector(31 downto 0);
  signal shared_memory_data_out_net_x6: std_logic_vector(31 downto 0);
  signal x12msb_y_net_x2: std_logic_vector(11 downto 0);
  signal x8msb_y_net_x2: std_logic_vector(7 downto 0);
  signal x9msb_y_net_x2: std_logic_vector(8 downto 0);

begin
  ce_1_sg_x20 <= ce_1;
  clk_1_sg_x20 <= clk_1;
  from_register_data_out_net_x0 <= from_register;
  from_register1_data_out_net_x2 <= from_register1;
  from_register1_data_out_net_x3 <= from_register1_x0;
  from_register2_data_out_net_x2 <= from_register2;
  from_register2_data_out_net_x3 <= from_register2_x0;
  from_register3_data_out_net_x3 <= from_register3;
  from_register3_data_out_net_x4 <= from_register3_x0;
  from_register3_data_out_net_x5 <= from_register3_x1;
  from_register4_data_out_net_x2 <= from_register4;
  from_register4_data_out_net_x3 <= from_register4_x0;
  from_register4_data_out_net_x4 <= from_register4_x1;
  from_register5_data_out_net_x2 <= from_register5;
  from_register5_data_out_net_x3 <= from_register5_x0;
  from_register5_data_out_net_x4 <= from_register5_x1;
  from_register6_data_out_net_x1 <= from_register6;
  from_register6_data_out_net_x2 <= from_register6_x0;
  from_register7_data_out_net_x1 <= from_register7;
  reset_net_x0 <= reset;
  shared_memory_data_out_net_x4 <= shared_memory;
  shared_memory_data_out_net_x5 <= shared_memory_x0;
  shared_memory_data_out_net_x6 <= shared_memory_x1;
  commandrom <= x8msb_y_net_x2;
  commandrom_x0 <= constant_op_net_x4;
  commandrom_x1 <= constant1_op_net_x4;
  datarom <= x9msb_y_net_x2;
  datarom_x0 <= constant_op_net_x5;
  datarom_x1 <= constant1_op_net_x5;
  datarom_x2 <= x12msb_y_net_x2;
  datarom_x3 <= constant_op_net_x6;
  datarom_x4 <= constant1_op_net_x6;
  delay_x0 <= delay_q_net_x1;
  spi <= mux_y_net_x6;
  spi_x0 <= inverter_op_net_x1;
  spi_x1 <= mux_y_net_x7;

  commandrom_b68e0d97b7: entity work.commandrom_entity_b68e0d97b7
    port map (
      ce_1 => ce_1_sg_x20,
      clk_1 => clk_1_sg_x20,
      from_register1 => from_register1_data_out_net_x2,
      from_register2 => from_register2_data_out_net_x2,
      from_register3 => from_register3_data_out_net_x3,
      from_register4 => from_register4_data_out_net_x2,
      from_register5 => from_register5_data_out_net_x2,
      from_register6 => from_register6_data_out_net_x1,
      reset => convert1_dout_net_x7,
      sendcmds => logical_y_net_x3,
      shared_memory => shared_memory_data_out_net_x4,
      totalnoofcmds => from_register3_data_out_net_x5,
      transferdone => convert1_dout_net_x8,
      cmdsdone => register_q_net_x1,
      command_memory => x8msb_y_net_x2,
      command_memory_x0 => constant_op_net_x4,
      command_memory_x1 => constant1_op_net_x4,
      datatosend => concat2_y_net_x0,
      starttransfer => mux2_y_net_x0
    );

  convert: entity work.xlconvert
    generic map (
      bool_conversion => 1,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 1,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 1,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din(0) => from_register4_data_out_net_x4,
      dout(0) => convert_dout_net_x1
    );

  convert1: entity work.xlconvert
    generic map (
      bool_conversion => 1,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 1,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 1,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din(0) => logical1_y_net,
      dout(0) => convert1_dout_net_x7
    );

  convert2: entity work.xlconvert
    generic map (
      bool_conversion => 1,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 1,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 1,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din(0) => from_register5_data_out_net_x4,
      dout(0) => convert2_dout_net_x0
    );

  datarom_fd2cd392cc: entity work.datarom_entity_fd2cd392cc
    port map (
      ce_1 => ce_1_sg_x20,
      clk_1 => clk_1_sg_x20,
      cmdsdone => register_q_net_x1,
      from_register1 => from_register1_data_out_net_x3,
      from_register2 => from_register2_data_out_net_x3,
      from_register3 => from_register3_data_out_net_x4,
      from_register4 => from_register4_data_out_net_x3,
      from_register5 => from_register5_data_out_net_x3,
      from_register7 => from_register7_data_out_net_x1,
      reset => convert1_dout_net_x7,
      shared_memory => shared_memory_data_out_net_x5,
      shared_memory_x0 => shared_memory_data_out_net_x6,
      transferdone => convert1_dout_net_x8,
      character_buffer_shared_memory => x9msb_y_net_x2,
      character_buffer_shared_memory_x0 => constant_op_net_x5,
      character_buffer_shared_memory_x1 => constant1_op_net_x5,
      character_map_shared_memory => x12msb_y_net_x2,
      character_map_shared_memory_x0 => constant_op_net_x6,
      character_map_shared_memory_x1 => constant1_op_net_x6,
      data => concat4_y_net_x0,
      starttransfer => delay_q_net_x0
    );

  delay: entity work.xldelay
    generic map (
      latency => 1,
      reg_retiming => 0,
      width => 1
    )
    port map (
      ce => ce_1_sg_x20,
      clk => clk_1_sg_x20,
      d(0) => from_register6_data_out_net_x2,
      en => '1',
      q(0) => delay_q_net_x1
    );

  logical1: entity work.logical_3e1f051fb7
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => reset_net_x0,
      d1(0) => from_register_data_out_net_x0,
      y(0) => logical1_y_net
    );

  mux: entity work.mux_791081a00e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => concat2_y_net_x0,
      d1 => concat4_y_net_x0,
      sel(0) => register_q_net_x1,
      y => mux_y_net_x3
    );

  mux1: entity work.mux_d99e59b6d4
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => mux2_y_net_x0,
      d1(0) => delay_q_net_x0,
      sel(0) => register_q_net_x1,
      y(0) => mux1_y_net_x1
    );

  pos_edge_detector_63345fcb1c: entity work.pos_edge_detector_entity_90ec5fccc3
    port map (
      ce_1 => ce_1_sg_x20,
      clk_1 => clk_1_sg_x20,
      input_signal => convert2_dout_net_x0,
      rising_edge => logical_y_net_x3
    );

  spi_fd37afb7f3: entity work.spi_entity_fd37afb7f3
    port map (
      ce_1 => ce_1_sg_x20,
      clk_1 => clk_1_sg_x20,
      data_to_transfer => mux_y_net_x3,
      dividerselect => convert_dout_net_x1,
      reset => convert1_dout_net_x7,
      send => mux1_y_net_x1,
      cs => inverter_op_net_x1,
      data => mux_y_net_x6,
      done => convert1_dout_net_x8,
      scl => mux_y_net_x7
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller"

entity user_io_board_controller is
  port (
    buttons_big: in std_logic_vector(1 downto 0); 
    buttons_small: in std_logic_vector(5 downto 0); 
    ce_1: in std_logic; 
    clk_1: in std_logic; 
    data_out: in std_logic_vector(17 downto 0); 
    data_out_x0: in std_logic_vector(17 downto 0); 
    data_out_x1: in std_logic; 
    data_out_x10: in std_logic; 
    data_out_x11: in std_logic_vector(7 downto 0); 
    data_out_x12: in std_logic; 
    data_out_x13: in std_logic; 
    data_out_x14: in std_logic; 
    data_out_x15: in std_logic_vector(8 downto 0); 
    data_out_x16: in std_logic_vector(8 downto 0); 
    data_out_x17: in std_logic_vector(8 downto 0); 
    data_out_x18: in std_logic_vector(8 downto 0); 
    data_out_x19: in std_logic_vector(8 downto 0); 
    data_out_x2: in std_logic_vector(1 downto 0); 
    data_out_x20: in std_logic_vector(1 downto 0); 
    data_out_x21: in std_logic_vector(31 downto 0); 
    data_out_x22: in std_logic_vector(3 downto 0); 
    data_out_x23: in std_logic_vector(3 downto 0); 
    data_out_x24: in std_logic_vector(8 downto 0); 
    data_out_x25: in std_logic_vector(8 downto 0); 
    data_out_x26: in std_logic_vector(8 downto 0); 
    data_out_x27: in std_logic_vector(2 downto 0); 
    data_out_x28: in std_logic_vector(31 downto 0); 
    data_out_x29: in std_logic_vector(31 downto 0); 
    data_out_x3: in std_logic_vector(5 downto 0); 
    data_out_x4: in std_logic_vector(3 downto 0); 
    data_out_x5: in std_logic_vector(4 downto 0); 
    data_out_x6: in std_logic_vector(31 downto 0); 
    data_out_x7: in std_logic_vector(31 downto 0); 
    data_out_x8: in std_logic_vector(31 downto 0); 
    data_out_x9: in std_logic_vector(7 downto 0); 
    dip_switch: in std_logic_vector(3 downto 0); 
    dout: in std_logic_vector(17 downto 0); 
    dout_x0: in std_logic; 
    dout_x1: in std_logic_vector(17 downto 0); 
    dout_x10: in std_logic_vector(3 downto 0); 
    dout_x11: in std_logic_vector(8 downto 0); 
    dout_x12: in std_logic; 
    dout_x13: in std_logic; 
    dout_x14: in std_logic_vector(8 downto 0); 
    dout_x15: in std_logic_vector(8 downto 0); 
    dout_x16: in std_logic_vector(8 downto 0); 
    dout_x17: in std_logic; 
    dout_x18: in std_logic_vector(7 downto 0); 
    dout_x19: in std_logic_vector(7 downto 0); 
    dout_x2: in std_logic_vector(8 downto 0); 
    dout_x3: in std_logic_vector(3 downto 0); 
    dout_x4: in std_logic_vector(2 downto 0); 
    dout_x5: in std_logic_vector(8 downto 0); 
    dout_x6: in std_logic_vector(1 downto 0); 
    dout_x7: in std_logic; 
    dout_x8: in std_logic_vector(8 downto 0); 
    dout_x9: in std_logic_vector(8 downto 0); 
    plb_abus: in std_logic_vector(31 downto 0); 
    plb_pavalid: in std_logic; 
    plb_rnw: in std_logic; 
    plb_wrdbus: in std_logic_vector(31 downto 0); 
    reset: in std_logic; 
    sg_plb_addrpref: in std_logic_vector(14 downto 0); 
    splb_rst: in std_logic; 
    trackball_ox: in std_logic; 
    trackball_oxn: in std_logic; 
    trackball_oy: in std_logic; 
    trackball_oyn: in std_logic; 
    trackball_sel2: in std_logic; 
    addr: out std_logic_vector(11 downto 0); 
    addr_x0: out std_logic_vector(8 downto 0); 
    addr_x1: out std_logic_vector(7 downto 0); 
    addr_x2: out std_logic_vector(7 downto 0); 
    addr_x3: out std_logic_vector(8 downto 0); 
    addr_x4: out std_logic_vector(11 downto 0); 
    buzzer: out std_logic; 
    cs: out std_logic; 
    data_in: out std_logic_vector(17 downto 0); 
    data_in_x0: out std_logic; 
    data_in_x1: out std_logic_vector(17 downto 0); 
    data_in_x10: out std_logic_vector(3 downto 0); 
    data_in_x11: out std_logic_vector(8 downto 0); 
    data_in_x12: out std_logic; 
    data_in_x13: out std_logic; 
    data_in_x14: out std_logic_vector(8 downto 0); 
    data_in_x15: out std_logic_vector(8 downto 0); 
    data_in_x16: out std_logic_vector(8 downto 0); 
    data_in_x17: out std_logic; 
    data_in_x18: out std_logic_vector(7 downto 0); 
    data_in_x19: out std_logic_vector(7 downto 0); 
    data_in_x2: out std_logic_vector(8 downto 0); 
    data_in_x20: out std_logic_vector(31 downto 0); 
    data_in_x21: out std_logic_vector(31 downto 0); 
    data_in_x22: out std_logic_vector(31 downto 0); 
    data_in_x23: out std_logic_vector(4 downto 0); 
    data_in_x24: out std_logic_vector(1 downto 0); 
    data_in_x25: out std_logic_vector(5 downto 0); 
    data_in_x26: out std_logic_vector(3 downto 0); 
    data_in_x27: out std_logic_vector(31 downto 0); 
    data_in_x28: out std_logic_vector(31 downto 0); 
    data_in_x29: out std_logic_vector(31 downto 0); 
    data_in_x3: out std_logic_vector(3 downto 0); 
    data_in_x4: out std_logic_vector(2 downto 0); 
    data_in_x5: out std_logic_vector(8 downto 0); 
    data_in_x6: out std_logic_vector(1 downto 0); 
    data_in_x7: out std_logic; 
    data_in_x8: out std_logic_vector(8 downto 0); 
    data_in_x9: out std_logic_vector(8 downto 0); 
    en: out std_logic; 
    en_x0: out std_logic; 
    en_x1: out std_logic; 
    en_x10: out std_logic; 
    en_x11: out std_logic; 
    en_x12: out std_logic; 
    en_x13: out std_logic; 
    en_x14: out std_logic; 
    en_x15: out std_logic; 
    en_x16: out std_logic; 
    en_x17: out std_logic; 
    en_x18: out std_logic; 
    en_x19: out std_logic; 
    en_x2: out std_logic; 
    en_x20: out std_logic; 
    en_x21: out std_logic; 
    en_x22: out std_logic; 
    en_x23: out std_logic; 
    en_x3: out std_logic; 
    en_x4: out std_logic; 
    en_x5: out std_logic; 
    en_x6: out std_logic; 
    en_x7: out std_logic; 
    en_x8: out std_logic; 
    en_x9: out std_logic; 
    leds: out std_logic_vector(7 downto 0); 
    resetlcd: out std_logic; 
    scl: out std_logic; 
    sdi: out std_logic; 
    sl_addrack: out std_logic; 
    sl_rdcomp: out std_logic; 
    sl_rddack: out std_logic; 
    sl_rddbus: out std_logic_vector(31 downto 0); 
    sl_wait: out std_logic; 
    sl_wrcomp: out std_logic; 
    sl_wrdack: out std_logic; 
    trackball_sel1: out std_logic; 
    trackball_xscn: out std_logic; 
    trackball_yscn: out std_logic; 
    we: out std_logic; 
    we_x0: out std_logic; 
    we_x1: out std_logic; 
    we_x2: out std_logic; 
    we_x3: out std_logic; 
    we_x4: out std_logic
  );
end user_io_board_controller;

architecture structural of user_io_board_controller is
  signal addr_net: std_logic_vector(11 downto 0);
  signal addr_x0_net: std_logic_vector(8 downto 0);
  signal addr_x1_net: std_logic_vector(7 downto 0);
  signal addr_x2_net: std_logic_vector(7 downto 0);
  signal addr_x3_net: std_logic_vector(8 downto 0);
  signal addr_x4_net: std_logic_vector(11 downto 0);
  signal buttons_big_net: std_logic_vector(1 downto 0);
  signal buttons_small_net: std_logic_vector(5 downto 0);
  signal buzzer_net: std_logic;
  signal ce_1_sg_x21: std_logic;
  signal clk_1_sg_x21: std_logic;
  signal cs_net: std_logic;
  signal data_in_net: std_logic_vector(17 downto 0);
  signal data_in_x0_net: std_logic;
  signal data_in_x10_net: std_logic_vector(3 downto 0);
  signal data_in_x11_net: std_logic_vector(8 downto 0);
  signal data_in_x12_net: std_logic;
  signal data_in_x13_net: std_logic;
  signal data_in_x14_net: std_logic_vector(8 downto 0);
  signal data_in_x15_net: std_logic_vector(8 downto 0);
  signal data_in_x16_net: std_logic_vector(8 downto 0);
  signal data_in_x17_net: std_logic;
  signal data_in_x18_net: std_logic_vector(7 downto 0);
  signal data_in_x19_net: std_logic_vector(7 downto 0);
  signal data_in_x1_net: std_logic_vector(17 downto 0);
  signal data_in_x20_net: std_logic_vector(31 downto 0);
  signal data_in_x21_net: std_logic_vector(31 downto 0);
  signal data_in_x22_net: std_logic_vector(31 downto 0);
  signal data_in_x23_net: std_logic_vector(4 downto 0);
  signal data_in_x24_net: std_logic_vector(1 downto 0);
  signal data_in_x25_net: std_logic_vector(5 downto 0);
  signal data_in_x26_net: std_logic_vector(3 downto 0);
  signal data_in_x27_net: std_logic_vector(31 downto 0);
  signal data_in_x28_net: std_logic_vector(31 downto 0);
  signal data_in_x29_net: std_logic_vector(31 downto 0);
  signal data_in_x2_net: std_logic_vector(8 downto 0);
  signal data_in_x3_net: std_logic_vector(3 downto 0);
  signal data_in_x4_net: std_logic_vector(2 downto 0);
  signal data_in_x5_net: std_logic_vector(8 downto 0);
  signal data_in_x6_net: std_logic_vector(1 downto 0);
  signal data_in_x7_net: std_logic;
  signal data_in_x8_net: std_logic_vector(8 downto 0);
  signal data_in_x9_net: std_logic_vector(8 downto 0);
  signal data_out_net: std_logic_vector(17 downto 0);
  signal data_out_x0_net: std_logic_vector(17 downto 0);
  signal data_out_x10_net: std_logic;
  signal data_out_x11_net: std_logic_vector(7 downto 0);
  signal data_out_x12_net: std_logic;
  signal data_out_x13_net: std_logic;
  signal data_out_x14_net: std_logic;
  signal data_out_x15_net: std_logic_vector(8 downto 0);
  signal data_out_x16_net: std_logic_vector(8 downto 0);
  signal data_out_x17_net: std_logic_vector(8 downto 0);
  signal data_out_x18_net: std_logic_vector(8 downto 0);
  signal data_out_x19_net: std_logic_vector(8 downto 0);
  signal data_out_x1_net: std_logic;
  signal data_out_x20_net: std_logic_vector(1 downto 0);
  signal data_out_x21_net: std_logic_vector(31 downto 0);
  signal data_out_x22_net: std_logic_vector(3 downto 0);
  signal data_out_x23_net: std_logic_vector(3 downto 0);
  signal data_out_x24_net: std_logic_vector(8 downto 0);
  signal data_out_x25_net: std_logic_vector(8 downto 0);
  signal data_out_x26_net: std_logic_vector(8 downto 0);
  signal data_out_x27_net: std_logic_vector(2 downto 0);
  signal data_out_x28_net: std_logic_vector(31 downto 0);
  signal data_out_x29_net: std_logic_vector(31 downto 0);
  signal data_out_x2_net: std_logic_vector(1 downto 0);
  signal data_out_x3_net: std_logic_vector(5 downto 0);
  signal data_out_x4_net: std_logic_vector(3 downto 0);
  signal data_out_x5_net: std_logic_vector(4 downto 0);
  signal data_out_x6_net: std_logic_vector(31 downto 0);
  signal data_out_x7_net: std_logic_vector(31 downto 0);
  signal data_out_x8_net: std_logic_vector(31 downto 0);
  signal data_out_x9_net: std_logic_vector(7 downto 0);
  signal dip_switch_net: std_logic_vector(3 downto 0);
  signal dout_net: std_logic_vector(17 downto 0);
  signal dout_x0_net: std_logic;
  signal dout_x10_net: std_logic_vector(3 downto 0);
  signal dout_x11_net: std_logic_vector(8 downto 0);
  signal dout_x12_net: std_logic;
  signal dout_x13_net: std_logic;
  signal dout_x14_net: std_logic_vector(8 downto 0);
  signal dout_x15_net: std_logic_vector(8 downto 0);
  signal dout_x16_net: std_logic_vector(8 downto 0);
  signal dout_x17_net: std_logic;
  signal dout_x18_net: std_logic_vector(7 downto 0);
  signal dout_x19_net: std_logic_vector(7 downto 0);
  signal dout_x1_net: std_logic_vector(17 downto 0);
  signal dout_x2_net: std_logic_vector(8 downto 0);
  signal dout_x3_net: std_logic_vector(3 downto 0);
  signal dout_x4_net: std_logic_vector(2 downto 0);
  signal dout_x5_net: std_logic_vector(8 downto 0);
  signal dout_x6_net: std_logic_vector(1 downto 0);
  signal dout_x7_net: std_logic;
  signal dout_x8_net: std_logic_vector(8 downto 0);
  signal dout_x9_net: std_logic_vector(8 downto 0);
  signal en_net: std_logic;
  signal en_x0_net: std_logic;
  signal en_x10_net: std_logic;
  signal en_x11_net: std_logic;
  signal en_x12_net: std_logic;
  signal en_x13_net: std_logic;
  signal en_x14_net: std_logic;
  signal en_x15_net: std_logic;
  signal en_x16_net: std_logic;
  signal en_x17_net: std_logic;
  signal en_x18_net: std_logic;
  signal en_x19_net: std_logic;
  signal en_x1_net: std_logic;
  signal en_x20_net: std_logic;
  signal en_x21_net: std_logic;
  signal en_x22_net: std_logic;
  signal en_x23_net: std_logic;
  signal en_x2_net: std_logic;
  signal en_x3_net: std_logic;
  signal en_x4_net: std_logic;
  signal en_x5_net: std_logic;
  signal en_x6_net: std_logic;
  signal en_x7_net: std_logic;
  signal en_x8_net: std_logic;
  signal en_x9_net: std_logic;
  signal leds_net: std_logic_vector(7 downto 0);
  signal plb_abus_net: std_logic_vector(31 downto 0);
  signal plb_pavalid_net: std_logic;
  signal plb_rnw_net: std_logic;
  signal plb_wrdbus_net: std_logic_vector(31 downto 0);
  signal reset_net: std_logic;
  signal resetlcd_net: std_logic;
  signal scl_net: std_logic;
  signal sdi_net: std_logic;
  signal sg_plb_addrpref_net: std_logic_vector(14 downto 0);
  signal sl_addrack_net: std_logic;
  signal sl_rdcomp_net: std_logic;
  signal sl_rddack_net: std_logic;
  signal sl_rddbus_net: std_logic_vector(31 downto 0);
  signal sl_wait_net: std_logic;
  signal sl_wrdack_x1: std_logic;
  signal splb_rst_net: std_logic;
  signal trackball_ox_net: std_logic;
  signal trackball_oxn_net: std_logic;
  signal trackball_oy_net: std_logic;
  signal trackball_oyn_net: std_logic;
  signal trackball_sel1_net: std_logic;
  signal trackball_sel2_net: std_logic;
  signal trackball_xscn_net: std_logic;
  signal trackball_yscn_net: std_logic;
  signal we_net: std_logic;
  signal we_x0_net: std_logic;
  signal we_x1_net: std_logic;
  signal we_x2_net: std_logic;
  signal we_x3_net: std_logic;
  signal we_x4_net: std_logic;

begin
  buttons_big_net <= buttons_big;
  buttons_small_net <= buttons_small;
  ce_1_sg_x21 <= ce_1;
  clk_1_sg_x21 <= clk_1;
  data_out_net <= data_out;
  data_out_x0_net <= data_out_x0;
  data_out_x1_net <= data_out_x1;
  data_out_x10_net <= data_out_x10;
  data_out_x11_net <= data_out_x11;
  data_out_x12_net <= data_out_x12;
  data_out_x13_net <= data_out_x13;
  data_out_x14_net <= data_out_x14;
  data_out_x15_net <= data_out_x15;
  data_out_x16_net <= data_out_x16;
  data_out_x17_net <= data_out_x17;
  data_out_x18_net <= data_out_x18;
  data_out_x19_net <= data_out_x19;
  data_out_x2_net <= data_out_x2;
  data_out_x20_net <= data_out_x20;
  data_out_x21_net <= data_out_x21;
  data_out_x22_net <= data_out_x22;
  data_out_x23_net <= data_out_x23;
  data_out_x24_net <= data_out_x24;
  data_out_x25_net <= data_out_x25;
  data_out_x26_net <= data_out_x26;
  data_out_x27_net <= data_out_x27;
  data_out_x28_net <= data_out_x28;
  data_out_x29_net <= data_out_x29;
  data_out_x3_net <= data_out_x3;
  data_out_x4_net <= data_out_x4;
  data_out_x5_net <= data_out_x5;
  data_out_x6_net <= data_out_x6;
  data_out_x7_net <= data_out_x7;
  data_out_x8_net <= data_out_x8;
  data_out_x9_net <= data_out_x9;
  dip_switch_net <= dip_switch;
  dout_net <= dout;
  dout_x0_net <= dout_x0;
  dout_x1_net <= dout_x1;
  dout_x10_net <= dout_x10;
  dout_x11_net <= dout_x11;
  dout_x12_net <= dout_x12;
  dout_x13_net <= dout_x13;
  dout_x14_net <= dout_x14;
  dout_x15_net <= dout_x15;
  dout_x16_net <= dout_x16;
  dout_x17_net <= dout_x17;
  dout_x18_net <= dout_x18;
  dout_x19_net <= dout_x19;
  dout_x2_net <= dout_x2;
  dout_x3_net <= dout_x3;
  dout_x4_net <= dout_x4;
  dout_x5_net <= dout_x5;
  dout_x6_net <= dout_x6;
  dout_x7_net <= dout_x7;
  dout_x8_net <= dout_x8;
  dout_x9_net <= dout_x9;
  plb_abus_net <= plb_abus;
  plb_pavalid_net <= plb_pavalid;
  plb_rnw_net <= plb_rnw;
  plb_wrdbus_net <= plb_wrdbus;
  reset_net <= reset;
  sg_plb_addrpref_net <= sg_plb_addrpref;
  splb_rst_net <= splb_rst;
  trackball_ox_net <= trackball_ox;
  trackball_oxn_net <= trackball_oxn;
  trackball_oy_net <= trackball_oy;
  trackball_oyn_net <= trackball_oyn;
  trackball_sel2_net <= trackball_sel2;
  addr <= addr_net;
  addr_x0 <= addr_x0_net;
  addr_x1 <= addr_x1_net;
  addr_x2 <= addr_x2_net;
  addr_x3 <= addr_x3_net;
  addr_x4 <= addr_x4_net;
  buzzer <= buzzer_net;
  cs <= cs_net;
  data_in <= data_in_net;
  data_in_x0 <= data_in_x0_net;
  data_in_x1 <= data_in_x1_net;
  data_in_x10 <= data_in_x10_net;
  data_in_x11 <= data_in_x11_net;
  data_in_x12 <= data_in_x12_net;
  data_in_x13 <= data_in_x13_net;
  data_in_x14 <= data_in_x14_net;
  data_in_x15 <= data_in_x15_net;
  data_in_x16 <= data_in_x16_net;
  data_in_x17 <= data_in_x17_net;
  data_in_x18 <= data_in_x18_net;
  data_in_x19 <= data_in_x19_net;
  data_in_x2 <= data_in_x2_net;
  data_in_x20 <= data_in_x20_net;
  data_in_x21 <= data_in_x21_net;
  data_in_x22 <= data_in_x22_net;
  data_in_x23 <= data_in_x23_net;
  data_in_x24 <= data_in_x24_net;
  data_in_x25 <= data_in_x25_net;
  data_in_x26 <= data_in_x26_net;
  data_in_x27 <= data_in_x27_net;
  data_in_x28 <= data_in_x28_net;
  data_in_x29 <= data_in_x29_net;
  data_in_x3 <= data_in_x3_net;
  data_in_x4 <= data_in_x4_net;
  data_in_x5 <= data_in_x5_net;
  data_in_x6 <= data_in_x6_net;
  data_in_x7 <= data_in_x7_net;
  data_in_x8 <= data_in_x8_net;
  data_in_x9 <= data_in_x9_net;
  en <= en_net;
  en_x0 <= en_x0_net;
  en_x1 <= en_x1_net;
  en_x10 <= en_x10_net;
  en_x11 <= en_x11_net;
  en_x12 <= en_x12_net;
  en_x13 <= en_x13_net;
  en_x14 <= en_x14_net;
  en_x15 <= en_x15_net;
  en_x16 <= en_x16_net;
  en_x17 <= en_x17_net;
  en_x18 <= en_x18_net;
  en_x19 <= en_x19_net;
  en_x2 <= en_x2_net;
  en_x20 <= en_x20_net;
  en_x21 <= en_x21_net;
  en_x22 <= en_x22_net;
  en_x23 <= en_x23_net;
  en_x3 <= en_x3_net;
  en_x4 <= en_x4_net;
  en_x5 <= en_x5_net;
  en_x6 <= en_x6_net;
  en_x7 <= en_x7_net;
  en_x8 <= en_x8_net;
  en_x9 <= en_x9_net;
  leds <= leds_net;
  resetlcd <= resetlcd_net;
  scl <= scl_net;
  sdi <= sdi_net;
  sl_addrack <= sl_addrack_net;
  sl_rdcomp <= sl_rdcomp_net;
  sl_rddack <= sl_rddack_net;
  sl_rddbus <= sl_rddbus_net;
  sl_wait <= sl_wait_net;
  sl_wrcomp <= sl_wrdack_x1;
  sl_wrdack <= sl_wrdack_x1;
  trackball_sel1 <= trackball_sel1_net;
  trackball_xscn <= trackball_xscn_net;
  trackball_yscn <= trackball_yscn_net;
  we <= we_net;
  we_x0 <= we_x0_net;
  we_x1 <= we_x1_net;
  we_x2 <= we_x2_net;
  we_x3 <= we_x3_net;
  we_x4 <= we_x4_net;

  buzzer_controller_063692c849: entity work.buzzer_controller_entity_063692c849
    port map (
      ce_1 => ce_1_sg_x21,
      clk_1 => clk_1_sg_x21,
      from_register => data_out_net,
      from_register1 => data_out_x0_net,
      from_register2 => data_out_x1_net,
      register9_x0 => buzzer_net
    );

  edk_processor_94deb4def9: entity work.edk_processor_entity_94deb4def9
    port map (
      ce_1 => ce_1_sg_x21,
      clk_1 => clk_1_sg_x21,
      from_register => data_out_x2_net,
      from_register1 => data_out_x3_net,
      from_register2 => data_out_x4_net,
      from_register3 => data_out_x5_net,
      plb_abus => plb_abus_net,
      plb_pavalid => plb_pavalid_net,
      plb_rnw => plb_rnw_net,
      plb_wrdbus => plb_wrdbus_net,
      sg_plb_addrpref => sg_plb_addrpref_net,
      shared_memory => data_out_x6_net,
      shared_memory1 => data_out_x7_net,
      shared_memory2 => data_out_x8_net,
      splb_rst => splb_rst_net,
      to_register => dout_net,
      to_register1 => dout_x0_net,
      to_register10 => dout_x9_net,
      to_register11 => dout_x10_net,
      to_register12 => dout_x11_net,
      to_register13 => dout_x12_net,
      to_register14 => dout_x13_net,
      to_register15 => dout_x14_net,
      to_register16 => dout_x15_net,
      to_register17 => dout_x16_net,
      to_register18 => dout_x17_net,
      to_register19 => dout_x18_net,
      to_register2 => dout_x1_net,
      to_register20 => dout_x19_net,
      to_register3 => dout_x2_net,
      to_register4 => dout_x3_net,
      to_register5 => dout_x4_net,
      to_register6 => dout_x5_net,
      to_register7 => dout_x6_net,
      to_register8 => dout_x7_net,
      to_register9 => dout_x8_net,
      constant5_x0 => sl_wait_net,
      plb_decode_x0 => sl_addrack_net,
      plb_decode_x1 => sl_rdcomp_net,
      plb_decode_x2 => sl_wrdack_x1,
      plb_decode_x3 => sl_rddack_net,
      plb_decode_x4 => sl_rddbus_net,
      plb_memmap_x0 => data_in_net,
      plb_memmap_x1 => en_net,
      plb_memmap_x10 => data_in_x4_net,
      plb_memmap_x11 => en_x4_net,
      plb_memmap_x12 => data_in_x5_net,
      plb_memmap_x13 => en_x5_net,
      plb_memmap_x14 => data_in_x6_net,
      plb_memmap_x15 => en_x6_net,
      plb_memmap_x16 => data_in_x7_net,
      plb_memmap_x17 => en_x7_net,
      plb_memmap_x18 => data_in_x8_net,
      plb_memmap_x19 => en_x8_net,
      plb_memmap_x2 => data_in_x0_net,
      plb_memmap_x20 => data_in_x9_net,
      plb_memmap_x21 => en_x9_net,
      plb_memmap_x22 => data_in_x10_net,
      plb_memmap_x23 => en_x10_net,
      plb_memmap_x24 => data_in_x11_net,
      plb_memmap_x25 => en_x11_net,
      plb_memmap_x26 => data_in_x12_net,
      plb_memmap_x27 => en_x12_net,
      plb_memmap_x28 => data_in_x13_net,
      plb_memmap_x29 => en_x13_net,
      plb_memmap_x3 => en_x0_net,
      plb_memmap_x30 => data_in_x14_net,
      plb_memmap_x31 => en_x14_net,
      plb_memmap_x32 => data_in_x15_net,
      plb_memmap_x33 => en_x15_net,
      plb_memmap_x34 => data_in_x16_net,
      plb_memmap_x35 => en_x16_net,
      plb_memmap_x36 => data_in_x17_net,
      plb_memmap_x37 => en_x17_net,
      plb_memmap_x38 => data_in_x18_net,
      plb_memmap_x39 => en_x18_net,
      plb_memmap_x4 => data_in_x1_net,
      plb_memmap_x40 => data_in_x19_net,
      plb_memmap_x41 => en_x19_net,
      plb_memmap_x42 => addr_net,
      plb_memmap_x43 => data_in_x20_net,
      plb_memmap_x44 => we_net,
      plb_memmap_x45 => addr_x0_net,
      plb_memmap_x46 => data_in_x21_net,
      plb_memmap_x47 => we_x0_net,
      plb_memmap_x48 => addr_x1_net,
      plb_memmap_x49 => data_in_x22_net,
      plb_memmap_x5 => en_x1_net,
      plb_memmap_x50 => we_x1_net,
      plb_memmap_x6 => data_in_x2_net,
      plb_memmap_x7 => en_x2_net,
      plb_memmap_x8 => data_in_x3_net,
      plb_memmap_x9 => en_x3_net
    );

  lcd_controller_e3a358fc2f: entity work.lcd_controller_entity_e3a358fc2f
    port map (
      ce_1 => ce_1_sg_x21,
      clk_1 => clk_1_sg_x21,
      from_register => data_out_x10_net,
      from_register1 => data_out_x15_net,
      from_register1_x0 => data_out_x24_net,
      from_register2 => data_out_x16_net,
      from_register2_x0 => data_out_x25_net,
      from_register3 => data_out_x17_net,
      from_register3_x0 => data_out_x26_net,
      from_register3_x1 => data_out_x11_net,
      from_register4 => data_out_x18_net,
      from_register4_x0 => data_out_x27_net,
      from_register4_x1 => data_out_x12_net,
      from_register5 => data_out_x19_net,
      from_register5_x0 => data_out_x23_net,
      from_register5_x1 => data_out_x13_net,
      from_register6 => data_out_x20_net,
      from_register6_x0 => data_out_x14_net,
      from_register7 => data_out_x22_net,
      reset => reset_net,
      shared_memory => data_out_x21_net,
      shared_memory_x0 => data_out_x28_net,
      shared_memory_x1 => data_out_x29_net,
      commandrom => addr_x2_net,
      commandrom_x0 => data_in_x27_net,
      commandrom_x1 => we_x2_net,
      datarom => addr_x3_net,
      datarom_x0 => data_in_x28_net,
      datarom_x1 => we_x3_net,
      datarom_x2 => addr_x4_net,
      datarom_x3 => data_in_x29_net,
      datarom_x4 => we_x4_net,
      delay_x0 => resetlcd_net,
      spi => sdi_net,
      spi_x0 => cs_net,
      spi_x1 => scl_net
    );

  o_1f30dfdbf5: entity work.o_entity_1f30dfdbf5
    port map (
      buttons_big => buttons_big_net,
      buttons_small => buttons_small_net,
      ce_1 => ce_1_sg_x21,
      clk_1 => clk_1_sg_x21,
      dip_switch => dip_switch_net,
      from_register => data_out_x9_net,
      trackball_ox => trackball_ox_net,
      trackball_oxn => trackball_oxn_net,
      trackball_oy => trackball_oy_net,
      trackball_oyn => trackball_oyn_net,
      trackball_sel2 => trackball_sel2_net,
      concat_x0 => data_in_x23_net,
      constant2_x0 => en_x21_net,
      constant4_x0 => en_x22_net,
      constant6_x0 => en_x23_net,
      constant_x1 => en_x20_net,
      register10_x0 => trackball_xscn_net,
      register11_x0 => trackball_yscn_net,
      register12_x0 => trackball_sel1_net,
      register3_x0 => data_in_x24_net,
      register5_x0 => data_in_x25_net,
      register7_x0 => data_in_x26_net,
      register9_x0 => leds_net
    );

end structural;

-------------------------------------------------------------------
-- System Generator version 10.1.2 VHDL source file.
--
-- Copyright(C) 2008 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2008 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------

-------------------------------------------------------------------
-- System Generator version 10.1.2 VHDL source file.
--
-- Copyright(C) 2008 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2008 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;
use work.clock_pkg.all;
entity xlclkprobe is
  port (clk             : in std_logic;
        clr             : in std_logic;
        ce              : in std_logic;
        fakeOutForXst   : out std_logic);
end xlclkprobe;
architecture behavior of xlclkprobe is
begin
   fakeOutForXst <= '0';
-- synopsys translate_off
   work.clock_pkg.int_clk <= clk;
-- synopsys translate_on
end behavior;

-------------------------------------------------------------------
-- System Generator version 10.1.2 VHDL source file.
--
-- Copyright(C) 2008 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2008 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
-- synopsys translate_off
library unisim;
use unisim.vcomponents.all;
-- synopsys translate_on
entity xlclockdriver is
  generic (
    period: integer := 2;
    log_2_period: integer := 0;
    pipeline_regs: integer := 5;
    use_bufg: integer := 0
  );
  port (
    sysclk: in std_logic;
    sysclr: in std_logic;
    sysce: in std_logic;
    clk: out std_logic;
    clr: out std_logic;
    ce: out std_logic
  );
end xlclockdriver;
architecture behavior of xlclockdriver is
  component bufg
    port (
      i: in std_logic;
      o: out std_logic
    );
  end component;
  component synth_reg_w_init
    generic (
      width: integer;
      init_index: integer;
      init_value: bit_vector;
      latency: integer
    );
    port (
      i: in std_logic_vector(width - 1 downto 0);
      ce: in std_logic;
      clr: in std_logic;
      clk: in std_logic;
      o: out std_logic_vector(width - 1 downto 0)
    );
  end component;
  function size_of_uint(inp: integer; power_of_2: boolean)
    return integer
  is
    constant inp_vec: std_logic_vector(31 downto 0) :=
      integer_to_std_logic_vector(inp,32, xlUnsigned);
    variable result: integer;
  begin
    result := 32;
    for i in 0 to 31 loop
      if inp_vec(i) = '1' then
        result := i;
      end if;
    end loop;
    if power_of_2 then
      return result;
    else
      return result+1;
    end if;
  end;
  function is_power_of_2(inp: std_logic_vector)
    return boolean
  is
    constant width: integer := inp'length;
    variable vec: std_logic_vector(width - 1 downto 0);
    variable single_bit_set: boolean;
    variable more_than_one_bit_set: boolean;
    variable result: boolean;
  begin
    vec := inp;
    single_bit_set := false;
    more_than_one_bit_set := false;
    -- synopsys translate_off
    if (is_XorU(vec)) then
      return false;
    end if;
     -- synopsys translate_on
    if width > 0 then
      for i in 0 to width - 1 loop
        if vec(i) = '1' then
          if single_bit_set then
            more_than_one_bit_set := true;
          end if;
          single_bit_set := true;
        end if;
      end loop;
    end if;
    if (single_bit_set and not(more_than_one_bit_set)) then
      result := true;
    else
      result := false;
    end if;
    return result;
  end;
  function ce_reg_init_val(index, period : integer)
    return integer
  is
     variable result: integer;
   begin
      result := 0;
      if ((index mod period) = 0) then
          result := 1;
      end if;
      return result;
  end;
  function remaining_pipe_regs(num_pipeline_regs, period : integer)
    return integer
  is
     variable factor, result: integer;
  begin
      factor := (num_pipeline_regs / period);
      result := num_pipeline_regs - (period * factor) + 1;
      return result;
  end;

  function sg_min(L, R: INTEGER) return INTEGER is
  begin
      if L < R then
            return L;
      else
            return R;
      end if;
  end;
  constant max_pipeline_regs : integer := 8;
  constant pipe_regs : integer := 5;
  constant num_pipeline_regs : integer := sg_min(pipeline_regs, max_pipeline_regs);
  constant rem_pipeline_regs : integer := remaining_pipe_regs(num_pipeline_regs,period);
  constant period_floor: integer := max(2, period);
  constant power_of_2_counter: boolean :=
    is_power_of_2(integer_to_std_logic_vector(period_floor,32, xlUnsigned));
  constant cnt_width: integer :=
    size_of_uint(period_floor, power_of_2_counter);
  constant clk_for_ce_pulse_minus1: std_logic_vector(cnt_width - 1 downto 0) :=
    integer_to_std_logic_vector((period_floor - 2),cnt_width, xlUnsigned);
  constant clk_for_ce_pulse_minus2: std_logic_vector(cnt_width - 1 downto 0) :=
    integer_to_std_logic_vector(max(0,period - 3),cnt_width, xlUnsigned);
  constant clk_for_ce_pulse_minus_regs: std_logic_vector(cnt_width - 1 downto 0) :=
    integer_to_std_logic_vector(max(0,period - rem_pipeline_regs),cnt_width, xlUnsigned);
  signal clk_num: unsigned(cnt_width - 1 downto 0) := (others => '0');
  signal ce_vec : std_logic_vector(num_pipeline_regs downto 0);
  attribute MAX_FANOUT : string;
  attribute MAX_FANOUT of ce_vec:signal is "REDUCE";
  signal internal_ce: std_logic_vector(0 downto 0);
  signal cnt_clr, cnt_clr_dly: std_logic_vector (0 downto 0);
begin
  clk <= sysclk;
  clr <= sysclr;
  cntr_gen: process(sysclk)
  begin
    if sysclk'event and sysclk = '1'  then
      if (sysce = '1') then
        if ((cnt_clr_dly(0) = '1') or (sysclr = '1')) then
          clk_num <= (others => '0');
        else
          clk_num <= clk_num + 1;
        end if;
    end if;
    end if;
  end process;
  clr_gen: process(clk_num, sysclr)
  begin
    if power_of_2_counter then
      cnt_clr(0) <= sysclr;
    else
      if (unsigned_to_std_logic_vector(clk_num) = clk_for_ce_pulse_minus1
          or sysclr = '1') then
        cnt_clr(0) <= '1';
      else
        cnt_clr(0) <= '0';
      end if;
    end if;
  end process;
  clr_reg: synth_reg_w_init
    generic map (
      width => 1,
      init_index => 0,
      init_value => b"0000",
      latency => 1
    )
    port map (
      i => cnt_clr,
      ce => sysce,
      clr => sysclr,
      clk => sysclk,
      o => cnt_clr_dly
    );
  pipelined_ce : if period > 1 generate
      ce_gen: process(clk_num)
      begin
          if unsigned_to_std_logic_vector(clk_num) = clk_for_ce_pulse_minus_regs then
              ce_vec(num_pipeline_regs) <= '1';
          else
              ce_vec(num_pipeline_regs) <= '0';
          end if;
      end process;
      ce_pipeline: for index in num_pipeline_regs downto 1 generate
          ce_reg : synth_reg_w_init
              generic map (
                  width => 1,
                  init_index => ce_reg_init_val(index, period),
                  init_value => b"0000",
                  latency => 1
                  )
              port map (
                  i => ce_vec(index downto index),
                  ce => sysce,
                  clr => sysclr,
                  clk => sysclk,
                  o => ce_vec(index-1 downto index-1)
                  );
      end generate;
      internal_ce <= ce_vec(0 downto 0);
  end generate;
  use_bufg_true: if period > 1 and use_bufg = 1 generate
    ce_bufg_inst: bufg
      port map (
        i => internal_ce(0),
        o => ce
      );
  end generate;
  use_bufg_false: if period > 1 and (use_bufg = 0) generate
    ce <= internal_ce(0);
  end generate;
  generate_system_clk: if period = 1 generate
    ce <= sysce;
  end generate;
end architecture behavior;

-------------------------------------------------------------------
-- System Generator version 10.1.2 VHDL source file.
--
-- Copyright(C) 2008 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2008 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
entity xland2 is
  port (
    a : in std_logic;
    b : in std_logic;
    dout : out std_logic
    );
end xland2;
architecture behavior of xland2 is
begin
    dout <= a and b;
end behavior;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

entity default_clock_driver is
  port (
    sysce: in std_logic; 
    sysce_clr: in std_logic; 
    sysclk: in std_logic; 
    ce_1: out std_logic; 
    clk_1: out std_logic
  );
end default_clock_driver;

architecture structural of default_clock_driver is
  attribute syn_noprune: boolean;
  attribute syn_noprune of structural : architecture is true;
  attribute optimize_primitives: boolean;
  attribute optimize_primitives of structural : architecture is false;
  attribute dont_touch: boolean;
  attribute dont_touch of structural : architecture is true;

  signal sysce_clr_x0: std_logic;
  signal sysce_x0: std_logic;
  signal sysclk_x0: std_logic;
  signal xlclockdriver_1_ce: std_logic;
  signal xlclockdriver_1_clk: std_logic;

begin
  sysce_x0 <= sysce;
  sysce_clr_x0 <= sysce_clr;
  sysclk_x0 <= sysclk;
  ce_1 <= xlclockdriver_1_ce;
  clk_1 <= xlclockdriver_1_clk;

  xlclockdriver_1: entity work.xlclockdriver
    generic map (
      log_2_period => 1,
      period => 1,
      use_bufg => 0
    )
    port map (
      sysce => sysce_x0,
      sysclk => sysclk_x0,
      sysclr => sysce_clr_x0,
      ce => xlclockdriver_1_ce,
      clk => xlclockdriver_1_clk
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

entity user_io_board_controller_cw is
  port (
    buttons_big: in std_logic_vector(1 downto 0); 
    buttons_small: in std_logic_vector(5 downto 0); 
    ce: in std_logic := '1'; 
    clk: in std_logic; -- clock period = 10.0 ns (100.0 Mhz)
    dip_switch: in std_logic_vector(3 downto 0); 
    plb_abus: in std_logic_vector(31 downto 0); 
    plb_pavalid: in std_logic; 
    plb_rnw: in std_logic; 
    plb_wrdbus: in std_logic_vector(31 downto 0); 
    reset: in std_logic; 
    sg_plb_addrpref: in std_logic_vector(14 downto 0); 
    splb_rst: in std_logic; 
    trackball_ox: in std_logic; 
    trackball_oxn: in std_logic; 
    trackball_oy: in std_logic; 
    trackball_oyn: in std_logic; 
    trackball_sel2: in std_logic; 
    buzzer: out std_logic; 
    cs: out std_logic; 
    leds: out std_logic_vector(7 downto 0); 
    resetlcd: out std_logic; 
    scl: out std_logic; 
    sdi: out std_logic; 
    sl_addrack: out std_logic; 
    sl_rdcomp: out std_logic; 
    sl_rddack: out std_logic; 
    sl_rddbus: out std_logic_vector(31 downto 0); 
    sl_wait: out std_logic; 
    sl_wrcomp: out std_logic; 
    sl_wrdack: out std_logic; 
    trackball_sel1: out std_logic; 
    trackball_xscn: out std_logic; 
    trackball_yscn: out std_logic
  );
end user_io_board_controller_cw;

architecture structural of user_io_board_controller_cw is
  component dual_port_block_memory_virtex2p_6_3_25371f622c89ba44
    port (
      addra: in std_logic_vector(8 downto 0); 
      addrb: in std_logic_vector(8 downto 0); 
      clka: in std_logic; 
      clkb: in std_logic; 
      dina: in std_logic_vector(31 downto 0); 
      dinb: in std_logic_vector(31 downto 0); 
      ena: in std_logic; 
      enb: in std_logic; 
      wea: in std_logic; 
      web: in std_logic; 
      douta: out std_logic_vector(31 downto 0); 
      doutb: out std_logic_vector(31 downto 0)
    );
  end component;
  attribute syn_black_box: boolean;
  attribute syn_black_box of dual_port_block_memory_virtex2p_6_3_25371f622c89ba44: component is true;
  attribute box_type: string;
  attribute box_type of dual_port_block_memory_virtex2p_6_3_25371f622c89ba44: component is "black_box";
  attribute syn_noprune: boolean;
  attribute optimize_primitives: boolean;
  attribute dont_touch: boolean;
  attribute syn_noprune of dual_port_block_memory_virtex2p_6_3_25371f622c89ba44: component is true;
  attribute optimize_primitives of dual_port_block_memory_virtex2p_6_3_25371f622c89ba44: component is false;
  attribute dont_touch of dual_port_block_memory_virtex2p_6_3_25371f622c89ba44: component is true;

  component dual_port_block_memory_virtex2p_6_3_e98c3706f2ec2c76
    port (
      addra: in std_logic_vector(11 downto 0); 
      addrb: in std_logic_vector(11 downto 0); 
      clka: in std_logic; 
      clkb: in std_logic; 
      dina: in std_logic_vector(31 downto 0); 
      dinb: in std_logic_vector(31 downto 0); 
      ena: in std_logic; 
      enb: in std_logic; 
      wea: in std_logic; 
      web: in std_logic; 
      douta: out std_logic_vector(31 downto 0); 
      doutb: out std_logic_vector(31 downto 0)
    );
  end component;
  attribute syn_black_box of dual_port_block_memory_virtex2p_6_3_e98c3706f2ec2c76: component is true;
  attribute box_type of dual_port_block_memory_virtex2p_6_3_e98c3706f2ec2c76: component is "black_box";
  attribute syn_noprune of dual_port_block_memory_virtex2p_6_3_e98c3706f2ec2c76: component is true;
  attribute optimize_primitives of dual_port_block_memory_virtex2p_6_3_e98c3706f2ec2c76: component is false;
  attribute dont_touch of dual_port_block_memory_virtex2p_6_3_e98c3706f2ec2c76: component is true;

  component dual_port_block_memory_virtex2p_6_3_fb7cc8c2a7e578f8
    port (
      addra: in std_logic_vector(7 downto 0); 
      addrb: in std_logic_vector(7 downto 0); 
      clka: in std_logic; 
      clkb: in std_logic; 
      dina: in std_logic_vector(31 downto 0); 
      dinb: in std_logic_vector(31 downto 0); 
      ena: in std_logic; 
      enb: in std_logic; 
      wea: in std_logic; 
      web: in std_logic; 
      douta: out std_logic_vector(31 downto 0); 
      doutb: out std_logic_vector(31 downto 0)
    );
  end component;
  attribute syn_black_box of dual_port_block_memory_virtex2p_6_3_fb7cc8c2a7e578f8: component is true;
  attribute box_type of dual_port_block_memory_virtex2p_6_3_fb7cc8c2a7e578f8: component is "black_box";
  attribute syn_noprune of dual_port_block_memory_virtex2p_6_3_fb7cc8c2a7e578f8: component is true;
  attribute optimize_primitives of dual_port_block_memory_virtex2p_6_3_fb7cc8c2a7e578f8: component is false;
  attribute dont_touch of dual_port_block_memory_virtex2p_6_3_fb7cc8c2a7e578f8: component is true;

  component xlpersistentdff
    port (
      clk: in std_logic; 
      d: in std_logic; 
      q: out std_logic
    );
  end component;
  attribute syn_black_box of xlpersistentdff: component is true;
  attribute box_type of xlpersistentdff: component is "black_box";
  attribute syn_noprune of xlpersistentdff: component is true;
  attribute optimize_primitives of xlpersistentdff: component is false;
  attribute dont_touch of xlpersistentdff: component is true;

  signal Buttons_Big_reg_ce: std_logic;
  signal Buttons_Small_reg_ce: std_logic;
  signal Buzzer_DutyCycle_reg_ce: std_logic;
  signal Buzzer_Enable_reg_ce: std_logic;
  signal Buzzer_Period_reg_ce: std_logic;
  signal DIP_Switch_reg_ce: std_logic;
  signal LCD_BackgroundColor_reg_ce: std_logic;
  signal LCD_CharacterOffset_reg_ce: std_logic;
  signal LCD_CharactersSelect_reg_ce: std_logic;
  signal LCD_ColSet_reg_ce: std_logic;
  signal LCD_ConfigLocation_reg_ce: std_logic;
  signal LCD_DividerSelect_reg_ce: std_logic;
  signal LCD_FirstEnd_reg_ce: std_logic;
  signal LCD_FirstStart_reg_ce: std_logic;
  signal LCD_LineOffset_reg_ce: std_logic;
  signal LCD_RamWrite_reg_ce: std_logic;
  signal LCD_ResetLCD_reg_ce: std_logic;
  signal LCD_Reset_reg_ce: std_logic;
  signal LCD_RowSet_reg_ce: std_logic;
  signal LCD_SecondEnd_reg_ce: std_logic;
  signal LCD_SecondStart_reg_ce: std_logic;
  signal LCD_Send_reg_ce: std_logic;
  signal LCD_TotalCmdTransfer_reg_ce: std_logic;
  signal LEDs_reg_ce: std_logic;
  signal Trackball_reg_ce: std_logic;
  signal addr_net: std_logic_vector(11 downto 0);
  signal addr_x0_net: std_logic_vector(8 downto 0);
  signal addr_x1_net: std_logic_vector(7 downto 0);
  signal addr_x2_net: std_logic_vector(7 downto 0);
  signal addr_x3_net: std_logic_vector(8 downto 0);
  signal addr_x4_net: std_logic_vector(11 downto 0);
  signal buttons_big_net: std_logic_vector(1 downto 0);
  signal buttons_small_net: std_logic_vector(5 downto 0);
  signal buzzer_net: std_logic;
  signal ce_1_sg_x21: std_logic;
  attribute MAX_FANOUT: string;
  attribute MAX_FANOUT of ce_1_sg_x21: signal is "REDUCE";
  signal clkNet: std_logic;
  signal clk_1_sg_x21: std_logic;
  signal cs_net: std_logic;
  signal data_in_net: std_logic_vector(17 downto 0);
  signal data_in_x0_net: std_logic;
  signal data_in_x10_net: std_logic_vector(3 downto 0);
  signal data_in_x11_net: std_logic_vector(8 downto 0);
  signal data_in_x12_net: std_logic;
  signal data_in_x13_net: std_logic;
  signal data_in_x14_net: std_logic_vector(8 downto 0);
  signal data_in_x15_net: std_logic_vector(8 downto 0);
  signal data_in_x16_net: std_logic_vector(8 downto 0);
  signal data_in_x17_net: std_logic;
  signal data_in_x18_net: std_logic_vector(7 downto 0);
  signal data_in_x19_net: std_logic_vector(7 downto 0);
  signal data_in_x1_net: std_logic_vector(17 downto 0);
  signal data_in_x20_net: std_logic_vector(31 downto 0);
  signal data_in_x21_net: std_logic_vector(31 downto 0);
  signal data_in_x22_net: std_logic_vector(31 downto 0);
  signal data_in_x23_net: std_logic_vector(4 downto 0);
  signal data_in_x24_net: std_logic_vector(1 downto 0);
  signal data_in_x25_net: std_logic_vector(5 downto 0);
  signal data_in_x26_net: std_logic_vector(3 downto 0);
  signal data_in_x27_net: std_logic_vector(31 downto 0);
  signal data_in_x28_net: std_logic_vector(31 downto 0);
  signal data_in_x29_net: std_logic_vector(31 downto 0);
  signal data_in_x2_net: std_logic_vector(8 downto 0);
  signal data_in_x3_net: std_logic_vector(3 downto 0);
  signal data_in_x4_net: std_logic_vector(2 downto 0);
  signal data_in_x5_net: std_logic_vector(8 downto 0);
  signal data_in_x6_net: std_logic_vector(1 downto 0);
  signal data_in_x7_net: std_logic;
  signal data_in_x8_net: std_logic_vector(8 downto 0);
  signal data_in_x9_net: std_logic_vector(8 downto 0);
  signal data_out_net: std_logic_vector(17 downto 0);
  signal data_out_x0_net: std_logic_vector(17 downto 0);
  signal data_out_x10_net: std_logic;
  signal data_out_x11_net: std_logic_vector(7 downto 0);
  signal data_out_x12_net: std_logic;
  signal data_out_x13_net: std_logic;
  signal data_out_x14_net: std_logic;
  signal data_out_x15_net: std_logic_vector(8 downto 0);
  signal data_out_x16_net: std_logic_vector(8 downto 0);
  signal data_out_x17_net: std_logic_vector(8 downto 0);
  signal data_out_x18_net: std_logic_vector(8 downto 0);
  signal data_out_x19_net: std_logic_vector(8 downto 0);
  signal data_out_x1_net: std_logic;
  signal data_out_x20_net: std_logic_vector(1 downto 0);
  signal data_out_x21_net: std_logic_vector(31 downto 0);
  signal data_out_x22_net: std_logic_vector(3 downto 0);
  signal data_out_x23_net: std_logic_vector(3 downto 0);
  signal data_out_x24_net: std_logic_vector(8 downto 0);
  signal data_out_x25_net: std_logic_vector(8 downto 0);
  signal data_out_x26_net: std_logic_vector(8 downto 0);
  signal data_out_x27_net: std_logic_vector(2 downto 0);
  signal data_out_x28_net: std_logic_vector(31 downto 0);
  signal data_out_x29_net: std_logic_vector(31 downto 0);
  signal data_out_x2_net: std_logic_vector(1 downto 0);
  signal data_out_x3_net: std_logic_vector(5 downto 0);
  signal data_out_x4_net: std_logic_vector(3 downto 0);
  signal data_out_x5_net: std_logic_vector(4 downto 0);
  signal data_out_x6_net: std_logic_vector(31 downto 0);
  signal data_out_x7_net: std_logic_vector(31 downto 0);
  signal data_out_x8_net: std_logic_vector(31 downto 0);
  signal data_out_x9_net: std_logic_vector(7 downto 0);
  signal dip_switch_net: std_logic_vector(3 downto 0);
  signal en_net: std_logic;
  signal en_x0_net: std_logic;
  signal en_x10_net: std_logic;
  signal en_x11_net: std_logic;
  signal en_x12_net: std_logic;
  signal en_x13_net: std_logic;
  signal en_x14_net: std_logic;
  signal en_x15_net: std_logic;
  signal en_x16_net: std_logic;
  signal en_x17_net: std_logic;
  signal en_x18_net: std_logic;
  signal en_x19_net: std_logic;
  signal en_x1_net: std_logic;
  signal en_x20_net: std_logic;
  signal en_x21_net: std_logic;
  signal en_x22_net: std_logic;
  signal en_x23_net: std_logic;
  signal en_x2_net: std_logic;
  signal en_x3_net: std_logic;
  signal en_x4_net: std_logic;
  signal en_x5_net: std_logic;
  signal en_x6_net: std_logic;
  signal en_x7_net: std_logic;
  signal en_x8_net: std_logic;
  signal en_x9_net: std_logic;
  signal leds_net: std_logic_vector(7 downto 0);
  signal persistentdff_inst_q: std_logic;
  attribute syn_keep: boolean;
  attribute syn_keep of persistentdff_inst_q: signal is true;
  attribute keep: boolean;
  attribute keep of persistentdff_inst_q: signal is true;
  attribute preserve_signal: boolean;
  attribute preserve_signal of persistentdff_inst_q: signal is true;
  signal plb_abus_net: std_logic_vector(31 downto 0);
  signal plb_pavalid_net: std_logic;
  signal plb_rnw_net: std_logic;
  signal plb_wrdbus_net: std_logic_vector(31 downto 0);
  signal reset_net: std_logic;
  signal resetlcd_net: std_logic;
  signal scl_net: std_logic;
  signal sdi_net: std_logic;
  signal sg_plb_addrpref_net: std_logic_vector(14 downto 0);
  signal sl_addrack_net: std_logic;
  signal sl_rdcomp_net: std_logic;
  signal sl_rddack_net: std_logic;
  signal sl_rddbus_net: std_logic_vector(31 downto 0);
  signal sl_wait_net: std_logic;
  signal sl_wrdack_x1: std_logic;
  signal sl_wrdack_x2: std_logic;
  signal splb_rst_net: std_logic;
  signal trackball_ox_net: std_logic;
  signal trackball_oxn_net: std_logic;
  signal trackball_oy_net: std_logic;
  signal trackball_oyn_net: std_logic;
  signal trackball_sel1_net: std_logic;
  signal trackball_sel2_net: std_logic;
  signal trackball_xscn_net: std_logic;
  signal trackball_yscn_net: std_logic;
  signal we_net: std_logic;
  signal we_x0_net: std_logic;
  signal we_x1_net: std_logic;
  signal we_x2_net: std_logic;
  signal we_x3_net: std_logic;
  signal we_x4_net: std_logic;

begin
  buttons_big_net <= buttons_big;
  buttons_small_net <= buttons_small;
  clkNet <= clk;
  dip_switch_net <= dip_switch;
  plb_abus_net <= plb_abus;
  plb_pavalid_net <= plb_pavalid;
  plb_rnw_net <= plb_rnw;
  plb_wrdbus_net <= plb_wrdbus;
  reset_net <= reset;
  sg_plb_addrpref_net <= sg_plb_addrpref;
  splb_rst_net <= splb_rst;
  trackball_ox_net <= trackball_ox;
  trackball_oxn_net <= trackball_oxn;
  trackball_oy_net <= trackball_oy;
  trackball_oyn_net <= trackball_oyn;
  trackball_sel2_net <= trackball_sel2;
  buzzer <= buzzer_net;
  cs <= cs_net;
  leds <= leds_net;
  resetlcd <= resetlcd_net;
  scl <= scl_net;
  sdi <= sdi_net;
  sl_addrack <= sl_addrack_net;
  sl_rdcomp <= sl_rdcomp_net;
  sl_rddack <= sl_rddack_net;
  sl_rddbus <= sl_rddbus_net;
  sl_wait <= sl_wait_net;
  sl_wrcomp <= sl_wrdack_x2;
  sl_wrdack <= sl_wrdack_x1;
  trackball_sel1 <= trackball_sel1_net;
  trackball_xscn <= trackball_xscn_net;
  trackball_yscn <= trackball_yscn_net;

  Buttons_Big_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x21,
      b => en_x21_net,
      dout => Buttons_Big_reg_ce
    );

  Buttons_Big_x0: entity work.synth_reg_w_init
    generic map (
      width => 2,
      init_index => 2,
      init_value => b"00",
      latency => 1
    )
    port map (
      ce => Buttons_Big_reg_ce,
      clk => clk_1_sg_x21,
      clr => '0',
      i => data_in_x24_net,
      o => data_out_x2_net
    );

  Buttons_Small_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x21,
      b => en_x22_net,
      dout => Buttons_Small_reg_ce
    );

  Buttons_Small_x0: entity work.synth_reg_w_init
    generic map (
      width => 6,
      init_index => 2,
      init_value => b"000000",
      latency => 1
    )
    port map (
      ce => Buttons_Small_reg_ce,
      clk => clk_1_sg_x21,
      clr => '0',
      i => data_in_x25_net,
      o => data_out_x3_net
    );

  Buzzer_DutyCycle: entity work.synth_reg_w_init
    generic map (
      width => 18,
      init_index => 2,
      init_value => b"000000000000000000",
      latency => 1
    )
    port map (
      ce => Buzzer_DutyCycle_reg_ce,
      clk => clk_1_sg_x21,
      clr => '0',
      i => data_in_net,
      o => data_out_x0_net
    );

  Buzzer_DutyCycle_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x21,
      b => en_net,
      dout => Buzzer_DutyCycle_reg_ce
    );

  Buzzer_Enable: entity work.synth_reg_w_init
    generic map (
      width => 1,
      init_index => 2,
      init_value => b"0",
      latency => 1
    )
    port map (
      ce => Buzzer_Enable_reg_ce,
      clk => clk_1_sg_x21,
      clr => '0',
      i(0) => data_in_x0_net,
      o(0) => data_out_x1_net
    );

  Buzzer_Enable_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x21,
      b => en_x0_net,
      dout => Buzzer_Enable_reg_ce
    );

  Buzzer_Period: entity work.synth_reg_w_init
    generic map (
      width => 18,
      init_index => 2,
      init_value => b"000000000000000000",
      latency => 1
    )
    port map (
      ce => Buzzer_Period_reg_ce,
      clk => clk_1_sg_x21,
      clr => '0',
      i => data_in_x1_net,
      o => data_out_net
    );

  Buzzer_Period_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x21,
      b => en_x1_net,
      dout => Buzzer_Period_reg_ce
    );

  DIP_Switch_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x21,
      b => en_x23_net,
      dout => DIP_Switch_reg_ce
    );

  DIP_Switch_x0: entity work.synth_reg_w_init
    generic map (
      width => 4,
      init_index => 2,
      init_value => b"0000",
      latency => 1
    )
    port map (
      ce => DIP_Switch_reg_ce,
      clk => clk_1_sg_x21,
      clr => '0',
      i => data_in_x26_net,
      o => data_out_x4_net
    );

  LCD_BackgroundColor: entity work.synth_reg_w_init
    generic map (
      width => 9,
      init_index => 2,
      init_value => b"000000000",
      latency => 1
    )
    port map (
      ce => LCD_BackgroundColor_reg_ce,
      clk => clk_1_sg_x21,
      clr => '0',
      i => data_in_x2_net,
      o => data_out_x17_net
    );

  LCD_BackgroundColor_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x21,
      b => en_x2_net,
      dout => LCD_BackgroundColor_reg_ce
    );

  LCD_CharacterMap: dual_port_block_memory_virtex2p_6_3_e98c3706f2ec2c76
    port map (
      addra => addr_x4_net,
      addrb => addr_net,
      clka => clk_1_sg_x21,
      clkb => clk_1_sg_x21,
      dina => data_in_x29_net,
      dinb => data_in_x20_net,
      ena => ce_1_sg_x21,
      enb => ce_1_sg_x21,
      wea => we_x4_net,
      web => we_net,
      douta => data_out_x29_net,
      doutb => data_out_x6_net
    );

  LCD_CharacterOffset: entity work.synth_reg_w_init
    generic map (
      width => 4,
      init_index => 2,
      init_value => b"0000",
      latency => 1
    )
    port map (
      ce => LCD_CharacterOffset_reg_ce,
      clk => clk_1_sg_x21,
      clr => '0',
      i => data_in_x3_net,
      o => data_out_x23_net
    );

  LCD_CharacterOffset_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x21,
      b => en_x3_net,
      dout => LCD_CharacterOffset_reg_ce
    );

  LCD_Characters: dual_port_block_memory_virtex2p_6_3_25371f622c89ba44
    port map (
      addra => addr_x3_net,
      addrb => addr_x0_net,
      clka => clk_1_sg_x21,
      clkb => clk_1_sg_x21,
      dina => data_in_x28_net,
      dinb => data_in_x21_net,
      ena => ce_1_sg_x21,
      enb => ce_1_sg_x21,
      wea => we_x3_net,
      web => we_x0_net,
      douta => data_out_x28_net,
      doutb => data_out_x7_net
    );

  LCD_CharactersSelect: entity work.synth_reg_w_init
    generic map (
      width => 3,
      init_index => 2,
      init_value => b"000",
      latency => 1
    )
    port map (
      ce => LCD_CharactersSelect_reg_ce,
      clk => clk_1_sg_x21,
      clr => '0',
      i => data_in_x4_net,
      o => data_out_x27_net
    );

  LCD_CharactersSelect_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x21,
      b => en_x4_net,
      dout => LCD_CharactersSelect_reg_ce
    );

  LCD_ColSet: entity work.synth_reg_w_init
    generic map (
      width => 9,
      init_index => 2,
      init_value => b"000000000",
      latency => 1
    )
    port map (
      ce => LCD_ColSet_reg_ce,
      clk => clk_1_sg_x21,
      clr => '0',
      i => data_in_x5_net,
      o => data_out_x24_net
    );

  LCD_ColSet_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x21,
      b => en_x5_net,
      dout => LCD_ColSet_reg_ce
    );

  LCD_Commands: dual_port_block_memory_virtex2p_6_3_fb7cc8c2a7e578f8
    port map (
      addra => addr_x2_net,
      addrb => addr_x1_net,
      clka => clk_1_sg_x21,
      clkb => clk_1_sg_x21,
      dina => data_in_x27_net,
      dinb => data_in_x22_net,
      ena => ce_1_sg_x21,
      enb => ce_1_sg_x21,
      wea => we_x2_net,
      web => we_x1_net,
      douta => data_out_x21_net,
      doutb => data_out_x8_net
    );

  LCD_ConfigLocation: entity work.synth_reg_w_init
    generic map (
      width => 2,
      init_index => 2,
      init_value => b"00",
      latency => 1
    )
    port map (
      ce => LCD_ConfigLocation_reg_ce,
      clk => clk_1_sg_x21,
      clr => '0',
      i => data_in_x6_net,
      o => data_out_x20_net
    );

  LCD_ConfigLocation_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x21,
      b => en_x6_net,
      dout => LCD_ConfigLocation_reg_ce
    );

  LCD_DividerSelect: entity work.synth_reg_w_init
    generic map (
      width => 1,
      init_index => 2,
      init_value => b"0",
      latency => 1
    )
    port map (
      ce => LCD_DividerSelect_reg_ce,
      clk => clk_1_sg_x21,
      clr => '0',
      i(0) => data_in_x7_net,
      o(0) => data_out_x12_net
    );

  LCD_DividerSelect_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x21,
      b => en_x7_net,
      dout => LCD_DividerSelect_reg_ce
    );

  LCD_FirstEnd: entity work.synth_reg_w_init
    generic map (
      width => 9,
      init_index => 2,
      init_value => b"000000000",
      latency => 1
    )
    port map (
      ce => LCD_FirstEnd_reg_ce,
      clk => clk_1_sg_x21,
      clr => '0',
      i => data_in_x8_net,
      o => data_out_x16_net
    );

  LCD_FirstEnd_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x21,
      b => en_x8_net,
      dout => LCD_FirstEnd_reg_ce
    );

  LCD_FirstStart: entity work.synth_reg_w_init
    generic map (
      width => 9,
      init_index => 2,
      init_value => b"000000000",
      latency => 1
    )
    port map (
      ce => LCD_FirstStart_reg_ce,
      clk => clk_1_sg_x21,
      clr => '0',
      i => data_in_x9_net,
      o => data_out_x15_net
    );

  LCD_FirstStart_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x21,
      b => en_x9_net,
      dout => LCD_FirstStart_reg_ce
    );

  LCD_LineOffset: entity work.synth_reg_w_init
    generic map (
      width => 4,
      init_index => 2,
      init_value => b"0000",
      latency => 1
    )
    port map (
      ce => LCD_LineOffset_reg_ce,
      clk => clk_1_sg_x21,
      clr => '0',
      i => data_in_x10_net,
      o => data_out_x22_net
    );

  LCD_LineOffset_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x21,
      b => en_x10_net,
      dout => LCD_LineOffset_reg_ce
    );

  LCD_RamWrite: entity work.synth_reg_w_init
    generic map (
      width => 9,
      init_index => 2,
      init_value => b"000000000",
      latency => 1
    )
    port map (
      ce => LCD_RamWrite_reg_ce,
      clk => clk_1_sg_x21,
      clr => '0',
      i => data_in_x11_net,
      o => data_out_x25_net
    );

  LCD_RamWrite_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x21,
      b => en_x11_net,
      dout => LCD_RamWrite_reg_ce
    );

  LCD_Reset: entity work.synth_reg_w_init
    generic map (
      width => 1,
      init_index => 2,
      init_value => b"0",
      latency => 1
    )
    port map (
      ce => LCD_Reset_reg_ce,
      clk => clk_1_sg_x21,
      clr => '0',
      i(0) => data_in_x12_net,
      o(0) => data_out_x10_net
    );

  LCD_ResetLCD: entity work.synth_reg_w_init
    generic map (
      width => 1,
      init_index => 2,
      init_value => b"0",
      latency => 1
    )
    port map (
      ce => LCD_ResetLCD_reg_ce,
      clk => clk_1_sg_x21,
      clr => '0',
      i(0) => data_in_x13_net,
      o(0) => data_out_x14_net
    );

  LCD_ResetLCD_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x21,
      b => en_x13_net,
      dout => LCD_ResetLCD_reg_ce
    );

  LCD_Reset_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x21,
      b => en_x12_net,
      dout => LCD_Reset_reg_ce
    );

  LCD_RowSet: entity work.synth_reg_w_init
    generic map (
      width => 9,
      init_index => 2,
      init_value => b"000000000",
      latency => 1
    )
    port map (
      ce => LCD_RowSet_reg_ce,
      clk => clk_1_sg_x21,
      clr => '0',
      i => data_in_x14_net,
      o => data_out_x26_net
    );

  LCD_RowSet_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x21,
      b => en_x14_net,
      dout => LCD_RowSet_reg_ce
    );

  LCD_SecondEnd: entity work.synth_reg_w_init
    generic map (
      width => 9,
      init_index => 2,
      init_value => b"000000000",
      latency => 1
    )
    port map (
      ce => LCD_SecondEnd_reg_ce,
      clk => clk_1_sg_x21,
      clr => '0',
      i => data_in_x15_net,
      o => data_out_x19_net
    );

  LCD_SecondEnd_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x21,
      b => en_x15_net,
      dout => LCD_SecondEnd_reg_ce
    );

  LCD_SecondStart: entity work.synth_reg_w_init
    generic map (
      width => 9,
      init_index => 2,
      init_value => b"000000000",
      latency => 1
    )
    port map (
      ce => LCD_SecondStart_reg_ce,
      clk => clk_1_sg_x21,
      clr => '0',
      i => data_in_x16_net,
      o => data_out_x18_net
    );

  LCD_SecondStart_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x21,
      b => en_x16_net,
      dout => LCD_SecondStart_reg_ce
    );

  LCD_Send: entity work.synth_reg_w_init
    generic map (
      width => 1,
      init_index => 2,
      init_value => b"0",
      latency => 1
    )
    port map (
      ce => LCD_Send_reg_ce,
      clk => clk_1_sg_x21,
      clr => '0',
      i(0) => data_in_x17_net,
      o(0) => data_out_x13_net
    );

  LCD_Send_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x21,
      b => en_x17_net,
      dout => LCD_Send_reg_ce
    );

  LCD_TotalCmdTransfer: entity work.synth_reg_w_init
    generic map (
      width => 8,
      init_index => 2,
      init_value => b"00000000",
      latency => 1
    )
    port map (
      ce => LCD_TotalCmdTransfer_reg_ce,
      clk => clk_1_sg_x21,
      clr => '0',
      i => data_in_x18_net,
      o => data_out_x11_net
    );

  LCD_TotalCmdTransfer_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x21,
      b => en_x18_net,
      dout => LCD_TotalCmdTransfer_reg_ce
    );

  LEDs_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x21,
      b => en_x19_net,
      dout => LEDs_reg_ce
    );

  LEDs_x0: entity work.synth_reg_w_init
    generic map (
      width => 8,
      init_index => 2,
      init_value => b"00000000",
      latency => 1
    )
    port map (
      ce => LEDs_reg_ce,
      clk => clk_1_sg_x21,
      clr => '0',
      i => data_in_x19_net,
      o => data_out_x9_net
    );

  Trackball: entity work.synth_reg_w_init
    generic map (
      width => 5,
      init_index => 2,
      init_value => b"00000",
      latency => 1
    )
    port map (
      ce => Trackball_reg_ce,
      clk => clk_1_sg_x21,
      clr => '0',
      i => data_in_x23_net,
      o => data_out_x5_net
    );

  Trackball_ce_and2_comp: entity work.xland2
    port map (
      a => ce_1_sg_x21,
      b => en_x20_net,
      dout => Trackball_reg_ce
    );

  clk_probe: entity work.xlclkprobe
    port map (
      ce => '1',
      clk => clkNet,
      clr => '0'
    );

  default_clock_driver_x0: entity work.default_clock_driver
    port map (
      sysce => '1',
      sysce_clr => '0',
      sysclk => clkNet,
      ce_1 => ce_1_sg_x21,
      clk_1 => clk_1_sg_x21
    );

  persistentdff_inst: xlpersistentdff
    port map (
      clk => clkNet,
      d => persistentdff_inst_q,
      q => persistentdff_inst_q
    );

  user_io_board_controller_x0: entity work.user_io_board_controller
    port map (
      buttons_big => buttons_big_net,
      buttons_small => buttons_small_net,
      ce_1 => ce_1_sg_x21,
      clk_1 => clk_1_sg_x21,
      data_out => data_out_net,
      data_out_x0 => data_out_x0_net,
      data_out_x1 => data_out_x1_net,
      data_out_x10 => data_out_x10_net,
      data_out_x11 => data_out_x11_net,
      data_out_x12 => data_out_x12_net,
      data_out_x13 => data_out_x13_net,
      data_out_x14 => data_out_x14_net,
      data_out_x15 => data_out_x15_net,
      data_out_x16 => data_out_x16_net,
      data_out_x17 => data_out_x17_net,
      data_out_x18 => data_out_x18_net,
      data_out_x19 => data_out_x19_net,
      data_out_x2 => data_out_x2_net,
      data_out_x20 => data_out_x20_net,
      data_out_x21 => data_out_x21_net,
      data_out_x22 => data_out_x22_net,
      data_out_x23 => data_out_x23_net,
      data_out_x24 => data_out_x24_net,
      data_out_x25 => data_out_x25_net,
      data_out_x26 => data_out_x26_net,
      data_out_x27 => data_out_x27_net,
      data_out_x28 => data_out_x28_net,
      data_out_x29 => data_out_x29_net,
      data_out_x3 => data_out_x3_net,
      data_out_x4 => data_out_x4_net,
      data_out_x5 => data_out_x5_net,
      data_out_x6 => data_out_x6_net,
      data_out_x7 => data_out_x7_net,
      data_out_x8 => data_out_x8_net,
      data_out_x9 => data_out_x9_net,
      dip_switch => dip_switch_net,
      dout => data_out_x0_net,
      dout_x0 => data_out_x1_net,
      dout_x1 => data_out_net,
      dout_x10 => data_out_x22_net,
      dout_x11 => data_out_x25_net,
      dout_x12 => data_out_x10_net,
      dout_x13 => data_out_x14_net,
      dout_x14 => data_out_x26_net,
      dout_x15 => data_out_x19_net,
      dout_x16 => data_out_x18_net,
      dout_x17 => data_out_x13_net,
      dout_x18 => data_out_x11_net,
      dout_x19 => data_out_x9_net,
      dout_x2 => data_out_x17_net,
      dout_x3 => data_out_x23_net,
      dout_x4 => data_out_x27_net,
      dout_x5 => data_out_x24_net,
      dout_x6 => data_out_x20_net,
      dout_x7 => data_out_x12_net,
      dout_x8 => data_out_x16_net,
      dout_x9 => data_out_x15_net,
      plb_abus => plb_abus_net,
      plb_pavalid => plb_pavalid_net,
      plb_rnw => plb_rnw_net,
      plb_wrdbus => plb_wrdbus_net,
      reset => reset_net,
      sg_plb_addrpref => sg_plb_addrpref_net,
      splb_rst => splb_rst_net,
      trackball_ox => trackball_ox_net,
      trackball_oxn => trackball_oxn_net,
      trackball_oy => trackball_oy_net,
      trackball_oyn => trackball_oyn_net,
      trackball_sel2 => trackball_sel2_net,
      addr => addr_net,
      addr_x0 => addr_x0_net,
      addr_x1 => addr_x1_net,
      addr_x2 => addr_x2_net,
      addr_x3 => addr_x3_net,
      addr_x4 => addr_x4_net,
      buzzer => buzzer_net,
      cs => cs_net,
      data_in => data_in_net,
      data_in_x0 => data_in_x0_net,
      data_in_x1 => data_in_x1_net,
      data_in_x10 => data_in_x10_net,
      data_in_x11 => data_in_x11_net,
      data_in_x12 => data_in_x12_net,
      data_in_x13 => data_in_x13_net,
      data_in_x14 => data_in_x14_net,
      data_in_x15 => data_in_x15_net,
      data_in_x16 => data_in_x16_net,
      data_in_x17 => data_in_x17_net,
      data_in_x18 => data_in_x18_net,
      data_in_x19 => data_in_x19_net,
      data_in_x2 => data_in_x2_net,
      data_in_x20 => data_in_x20_net,
      data_in_x21 => data_in_x21_net,
      data_in_x22 => data_in_x22_net,
      data_in_x23 => data_in_x23_net,
      data_in_x24 => data_in_x24_net,
      data_in_x25 => data_in_x25_net,
      data_in_x26 => data_in_x26_net,
      data_in_x27 => data_in_x27_net,
      data_in_x28 => data_in_x28_net,
      data_in_x29 => data_in_x29_net,
      data_in_x3 => data_in_x3_net,
      data_in_x4 => data_in_x4_net,
      data_in_x5 => data_in_x5_net,
      data_in_x6 => data_in_x6_net,
      data_in_x7 => data_in_x7_net,
      data_in_x8 => data_in_x8_net,
      data_in_x9 => data_in_x9_net,
      en => en_net,
      en_x0 => en_x0_net,
      en_x1 => en_x1_net,
      en_x10 => en_x10_net,
      en_x11 => en_x11_net,
      en_x12 => en_x12_net,
      en_x13 => en_x13_net,
      en_x14 => en_x14_net,
      en_x15 => en_x15_net,
      en_x16 => en_x16_net,
      en_x17 => en_x17_net,
      en_x18 => en_x18_net,
      en_x19 => en_x19_net,
      en_x2 => en_x2_net,
      en_x20 => en_x20_net,
      en_x21 => en_x21_net,
      en_x22 => en_x22_net,
      en_x23 => en_x23_net,
      en_x3 => en_x3_net,
      en_x4 => en_x4_net,
      en_x5 => en_x5_net,
      en_x6 => en_x6_net,
      en_x7 => en_x7_net,
      en_x8 => en_x8_net,
      en_x9 => en_x9_net,
      leds => leds_net,
      resetlcd => resetlcd_net,
      scl => scl_net,
      sdi => sdi_net,
      sl_addrack => sl_addrack_net,
      sl_rdcomp => sl_rdcomp_net,
      sl_rddack => sl_rddack_net,
      sl_rddbus => sl_rddbus_net,
      sl_wait => sl_wait_net,
      sl_wrcomp => sl_wrdack_x2,
      sl_wrdack => sl_wrdack_x1,
      trackball_sel1 => trackball_sel1_net,
      trackball_xscn => trackball_xscn_net,
      trackball_yscn => trackball_yscn_net,
      we => we_net,
      we_x0 => we_x0_net,
      we_x1 => we_x1_net,
      we_x2 => we_x2_net,
      we_x3 => we_x3_net,
      we_x4 => we_x4_net
    );

end structural;
