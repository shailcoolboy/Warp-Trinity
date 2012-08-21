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
--     (c) Copyright 1995-2006 Xilinx, Inc.                                   --
--     All rights reserved.                                                   --
--------------------------------------------------------------------------------
-- You must compile the wrapper file adder_subtracter_virtex2p_7_0_219d4ec01152994f.vhd when simulating
-- the core, adder_subtracter_virtex2p_7_0_219d4ec01152994f. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synopsys directives "translate_off/translate_on" specified
-- below are supported by XST, FPGA Compiler II, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synopsys translate_off
Library XilinxCoreLib;
-- synopsys translate_on
ENTITY adder_subtracter_virtex2p_7_0_219d4ec01152994f IS
	port (
	A: IN std_logic_VECTOR(8 downto 0);
	B: IN std_logic_VECTOR(8 downto 0);
	S: OUT std_logic_VECTOR(8 downto 0));
END adder_subtracter_virtex2p_7_0_219d4ec01152994f;

ARCHITECTURE adder_subtracter_virtex2p_7_0_219d4ec01152994f_a OF adder_subtracter_virtex2p_7_0_219d4ec01152994f IS
-- synopsys translate_off
component wrapped_adder_subtracter_virtex2p_7_0_219d4ec01152994f
	port (
	A: IN std_logic_VECTOR(8 downto 0);
	B: IN std_logic_VECTOR(8 downto 0);
	S: OUT std_logic_VECTOR(8 downto 0));
end component;

-- Configuration specification 
	for all : wrapped_adder_subtracter_virtex2p_7_0_219d4ec01152994f use entity XilinxCoreLib.C_ADDSUB_V7_0(behavioral)
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
-- synopsys translate_on
BEGIN
-- synopsys translate_off
U0 : wrapped_adder_subtracter_virtex2p_7_0_219d4ec01152994f
		port map (
			A => A,
			B => B,
			S => S);
-- synopsys translate_on

END adder_subtracter_virtex2p_7_0_219d4ec01152994f_a;

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
--     (c) Copyright 1995-2006 Xilinx, Inc.                                   --
--     All rights reserved.                                                   --
--------------------------------------------------------------------------------
-- You must compile the wrapper file adder_subtracter_virtex2p_7_0_2cb583e55ff51f1e.vhd when simulating
-- the core, adder_subtracter_virtex2p_7_0_2cb583e55ff51f1e. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synopsys directives "translate_off/translate_on" specified
-- below are supported by XST, FPGA Compiler II, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synopsys translate_off
Library XilinxCoreLib;
-- synopsys translate_on
ENTITY adder_subtracter_virtex2p_7_0_2cb583e55ff51f1e IS
	port (
	A: IN std_logic_VECTOR(8 downto 0);
	B: IN std_logic_VECTOR(8 downto 0);
	S: OUT std_logic_VECTOR(8 downto 0));
END adder_subtracter_virtex2p_7_0_2cb583e55ff51f1e;

ARCHITECTURE adder_subtracter_virtex2p_7_0_2cb583e55ff51f1e_a OF adder_subtracter_virtex2p_7_0_2cb583e55ff51f1e IS
-- synopsys translate_off
component wrapped_adder_subtracter_virtex2p_7_0_2cb583e55ff51f1e
	port (
	A: IN std_logic_VECTOR(8 downto 0);
	B: IN std_logic_VECTOR(8 downto 0);
	S: OUT std_logic_VECTOR(8 downto 0));
end component;

-- Configuration specification 
	for all : wrapped_adder_subtracter_virtex2p_7_0_2cb583e55ff51f1e use entity XilinxCoreLib.C_ADDSUB_V7_0(behavioral)
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
-- synopsys translate_on
BEGIN
-- synopsys translate_off
U0 : wrapped_adder_subtracter_virtex2p_7_0_2cb583e55ff51f1e
		port map (
			A => A,
			B => B,
			S => S);
-- synopsys translate_on

END adder_subtracter_virtex2p_7_0_2cb583e55ff51f1e_a;

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
--     (c) Copyright 1995-2006 Xilinx, Inc.                                   --
--     All rights reserved.                                                   --
--------------------------------------------------------------------------------
-- You must compile the wrapper file adder_subtracter_virtex2p_7_0_cb748602b0616a72.vhd when simulating
-- the core, adder_subtracter_virtex2p_7_0_cb748602b0616a72. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synopsys directives "translate_off/translate_on" specified
-- below are supported by XST, FPGA Compiler II, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synopsys translate_off
Library XilinxCoreLib;
-- synopsys translate_on
ENTITY adder_subtracter_virtex2p_7_0_cb748602b0616a72 IS
	port (
	A: IN std_logic_VECTOR(4 downto 0);
	B: IN std_logic_VECTOR(4 downto 0);
	S: OUT std_logic_VECTOR(4 downto 0));
END adder_subtracter_virtex2p_7_0_cb748602b0616a72;

ARCHITECTURE adder_subtracter_virtex2p_7_0_cb748602b0616a72_a OF adder_subtracter_virtex2p_7_0_cb748602b0616a72 IS
-- synopsys translate_off
component wrapped_adder_subtracter_virtex2p_7_0_cb748602b0616a72
	port (
	A: IN std_logic_VECTOR(4 downto 0);
	B: IN std_logic_VECTOR(4 downto 0);
	S: OUT std_logic_VECTOR(4 downto 0));
end component;

-- Configuration specification 
	for all : wrapped_adder_subtracter_virtex2p_7_0_cb748602b0616a72 use entity XilinxCoreLib.C_ADDSUB_V7_0(behavioral)
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
			c_high_bit => 4,
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
-- synopsys translate_on
BEGIN
-- synopsys translate_off
U0 : wrapped_adder_subtracter_virtex2p_7_0_cb748602b0616a72
		port map (
			A => A,
			B => B,
			S => S);
-- synopsys translate_on

END adder_subtracter_virtex2p_7_0_cb748602b0616a72_a;

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
--     (c) Copyright 1995-2006 Xilinx, Inc.                                   --
--     All rights reserved.                                                   --
--------------------------------------------------------------------------------
-- You must compile the wrapper file binary_counter_virtex2p_7_0_016610e0863621bf.vhd when simulating
-- the core, binary_counter_virtex2p_7_0_016610e0863621bf. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synopsys directives "translate_off/translate_on" specified
-- below are supported by XST, FPGA Compiler II, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synopsys translate_off
Library XilinxCoreLib;
-- synopsys translate_on
ENTITY binary_counter_virtex2p_7_0_016610e0863621bf IS
	port (
	Q: OUT std_logic_VECTOR(6 downto 0);
	CLK: IN std_logic;
	CE: IN std_logic;
	SINIT: IN std_logic);
END binary_counter_virtex2p_7_0_016610e0863621bf;

ARCHITECTURE binary_counter_virtex2p_7_0_016610e0863621bf_a OF binary_counter_virtex2p_7_0_016610e0863621bf IS
-- synopsys translate_off
component wrapped_binary_counter_virtex2p_7_0_016610e0863621bf
	port (
	Q: OUT std_logic_VECTOR(6 downto 0);
	CLK: IN std_logic;
	CE: IN std_logic;
	SINIT: IN std_logic);
end component;

-- Configuration specification 
	for all : wrapped_binary_counter_virtex2p_7_0_016610e0863621bf use entity XilinxCoreLib.C_COUNTER_BINARY_V7_0(behavioral)
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
-- synopsys translate_on
BEGIN
-- synopsys translate_off
U0 : wrapped_binary_counter_virtex2p_7_0_016610e0863621bf
		port map (
			Q => Q,
			CLK => CLK,
			CE => CE,
			SINIT => SINIT);
-- synopsys translate_on

END binary_counter_virtex2p_7_0_016610e0863621bf_a;

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
--     (c) Copyright 1995-2006 Xilinx, Inc.                                   --
--     All rights reserved.                                                   --
--------------------------------------------------------------------------------
-- You must compile the wrapper file binary_counter_virtex2p_7_0_0611420023f6fdd6.vhd when simulating
-- the core, binary_counter_virtex2p_7_0_0611420023f6fdd6. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synopsys directives "translate_off/translate_on" specified
-- below are supported by XST, FPGA Compiler II, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synopsys translate_off
Library XilinxCoreLib;
-- synopsys translate_on
ENTITY binary_counter_virtex2p_7_0_0611420023f6fdd6 IS
	port (
	Q: OUT std_logic_VECTOR(3 downto 0);
	CLK: IN std_logic;
	CE: IN std_logic;
	SINIT: IN std_logic);
END binary_counter_virtex2p_7_0_0611420023f6fdd6;

ARCHITECTURE binary_counter_virtex2p_7_0_0611420023f6fdd6_a OF binary_counter_virtex2p_7_0_0611420023f6fdd6 IS
-- synopsys translate_off
component wrapped_binary_counter_virtex2p_7_0_0611420023f6fdd6
	port (
	Q: OUT std_logic_VECTOR(3 downto 0);
	CLK: IN std_logic;
	CE: IN std_logic;
	SINIT: IN std_logic);
end component;

-- Configuration specification 
	for all : wrapped_binary_counter_virtex2p_7_0_0611420023f6fdd6 use entity XilinxCoreLib.C_COUNTER_BINARY_V7_0(behavioral)
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
-- synopsys translate_on
BEGIN
-- synopsys translate_off
U0 : wrapped_binary_counter_virtex2p_7_0_0611420023f6fdd6
		port map (
			Q => Q,
			CLK => CLK,
			CE => CE,
			SINIT => SINIT);
-- synopsys translate_on

END binary_counter_virtex2p_7_0_0611420023f6fdd6_a;

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
--     (c) Copyright 1995-2006 Xilinx, Inc.                                   --
--     All rights reserved.                                                   --
--------------------------------------------------------------------------------
-- You must compile the wrapper file binary_counter_virtex2p_7_0_18e84c36111bc674.vhd when simulating
-- the core, binary_counter_virtex2p_7_0_18e84c36111bc674. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synopsys directives "translate_off/translate_on" specified
-- below are supported by XST, FPGA Compiler II, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synopsys translate_off
Library XilinxCoreLib;
-- synopsys translate_on
ENTITY binary_counter_virtex2p_7_0_18e84c36111bc674 IS
	port (
	Q: OUT std_logic_VECTOR(14 downto 0);
	CLK: IN std_logic;
	CE: IN std_logic;
	SINIT: IN std_logic);
END binary_counter_virtex2p_7_0_18e84c36111bc674;

ARCHITECTURE binary_counter_virtex2p_7_0_18e84c36111bc674_a OF binary_counter_virtex2p_7_0_18e84c36111bc674 IS
-- synopsys translate_off
component wrapped_binary_counter_virtex2p_7_0_18e84c36111bc674
	port (
	Q: OUT std_logic_VECTOR(14 downto 0);
	CLK: IN std_logic;
	CE: IN std_logic;
	SINIT: IN std_logic);
end component;

-- Configuration specification 
	for all : wrapped_binary_counter_virtex2p_7_0_18e84c36111bc674 use entity XilinxCoreLib.C_COUNTER_BINARY_V7_0(behavioral)
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
-- synopsys translate_on
BEGIN
-- synopsys translate_off
U0 : wrapped_binary_counter_virtex2p_7_0_18e84c36111bc674
		port map (
			Q => Q,
			CLK => CLK,
			CE => CE,
			SINIT => SINIT);
-- synopsys translate_on

END binary_counter_virtex2p_7_0_18e84c36111bc674_a;

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
--     (c) Copyright 1995-2006 Xilinx, Inc.                                   --
--     All rights reserved.                                                   --
--------------------------------------------------------------------------------
-- You must compile the wrapper file binary_counter_virtex2p_7_0_67ac1d95fffad199.vhd when simulating
-- the core, binary_counter_virtex2p_7_0_67ac1d95fffad199. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synopsys directives "translate_off/translate_on" specified
-- below are supported by XST, FPGA Compiler II, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synopsys translate_off
Library XilinxCoreLib;
-- synopsys translate_on
ENTITY binary_counter_virtex2p_7_0_67ac1d95fffad199 IS
	port (
	Q: OUT std_logic_VECTOR(13 downto 0);
	CLK: IN std_logic;
	CE: IN std_logic;
	SINIT: IN std_logic);
END binary_counter_virtex2p_7_0_67ac1d95fffad199;

ARCHITECTURE binary_counter_virtex2p_7_0_67ac1d95fffad199_a OF binary_counter_virtex2p_7_0_67ac1d95fffad199 IS
-- synopsys translate_off
component wrapped_binary_counter_virtex2p_7_0_67ac1d95fffad199
	port (
	Q: OUT std_logic_VECTOR(13 downto 0);
	CLK: IN std_logic;
	CE: IN std_logic;
	SINIT: IN std_logic);
end component;

-- Configuration specification 
	for all : wrapped_binary_counter_virtex2p_7_0_67ac1d95fffad199 use entity XilinxCoreLib.C_COUNTER_BINARY_V7_0(behavioral)
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
-- synopsys translate_on
BEGIN
-- synopsys translate_off
U0 : wrapped_binary_counter_virtex2p_7_0_67ac1d95fffad199
		port map (
			Q => Q,
			CLK => CLK,
			CE => CE,
			SINIT => SINIT);
-- synopsys translate_on

END binary_counter_virtex2p_7_0_67ac1d95fffad199_a;

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
--     (c) Copyright 1995-2006 Xilinx, Inc.                                   --
--     All rights reserved.                                                   --
--------------------------------------------------------------------------------
-- You must compile the wrapper file binary_counter_virtex2p_7_0_dbb5736f3ec3cba8.vhd when simulating
-- the core, binary_counter_virtex2p_7_0_dbb5736f3ec3cba8. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synopsys directives "translate_off/translate_on" specified
-- below are supported by XST, FPGA Compiler II, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synopsys translate_off
Library XilinxCoreLib;
-- synopsys translate_on
ENTITY binary_counter_virtex2p_7_0_dbb5736f3ec3cba8 IS
	port (
	Q: OUT std_logic_VECTOR(3 downto 0);
	CLK: IN std_logic;
	LOAD: IN std_logic;
	L: IN std_logic_VECTOR(3 downto 0);
	CE: IN std_logic;
	SINIT: IN std_logic);
END binary_counter_virtex2p_7_0_dbb5736f3ec3cba8;

ARCHITECTURE binary_counter_virtex2p_7_0_dbb5736f3ec3cba8_a OF binary_counter_virtex2p_7_0_dbb5736f3ec3cba8 IS
-- synopsys translate_off
component wrapped_binary_counter_virtex2p_7_0_dbb5736f3ec3cba8
	port (
	Q: OUT std_logic_VECTOR(3 downto 0);
	CLK: IN std_logic;
	LOAD: IN std_logic;
	L: IN std_logic_VECTOR(3 downto 0);
	CE: IN std_logic;
	SINIT: IN std_logic);
end component;

-- Configuration specification 
	for all : wrapped_binary_counter_virtex2p_7_0_dbb5736f3ec3cba8 use entity XilinxCoreLib.C_COUNTER_BINARY_V7_0(behavioral)
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
-- synopsys translate_on
BEGIN
-- synopsys translate_off
U0 : wrapped_binary_counter_virtex2p_7_0_dbb5736f3ec3cba8
		port map (
			Q => Q,
			CLK => CLK,
			LOAD => LOAD,
			L => L,
			CE => CE,
			SINIT => SINIT);
-- synopsys translate_on

END binary_counter_virtex2p_7_0_dbb5736f3ec3cba8_a;

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
--     (c) Copyright 1995-2006 Xilinx, Inc.                                   --
--     All rights reserved.                                                   --
--------------------------------------------------------------------------------
-- You must compile the wrapper file binary_counter_virtex2p_7_0_edc7d761bd25890d.vhd when simulating
-- the core, binary_counter_virtex2p_7_0_edc7d761bd25890d. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synopsys directives "translate_off/translate_on" specified
-- below are supported by XST, FPGA Compiler II, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synopsys translate_off
Library XilinxCoreLib;
-- synopsys translate_on
ENTITY binary_counter_virtex2p_7_0_edc7d761bd25890d IS
	port (
	Q: OUT std_logic_VECTOR(2 downto 0);
	CLK: IN std_logic;
	LOAD: IN std_logic;
	L: IN std_logic_VECTOR(2 downto 0);
	CE: IN std_logic;
	SINIT: IN std_logic);
END binary_counter_virtex2p_7_0_edc7d761bd25890d;

ARCHITECTURE binary_counter_virtex2p_7_0_edc7d761bd25890d_a OF binary_counter_virtex2p_7_0_edc7d761bd25890d IS
-- synopsys translate_off
component wrapped_binary_counter_virtex2p_7_0_edc7d761bd25890d
	port (
	Q: OUT std_logic_VECTOR(2 downto 0);
	CLK: IN std_logic;
	LOAD: IN std_logic;
	L: IN std_logic_VECTOR(2 downto 0);
	CE: IN std_logic;
	SINIT: IN std_logic);
end component;

-- Configuration specification 
	for all : wrapped_binary_counter_virtex2p_7_0_edc7d761bd25890d use entity XilinxCoreLib.C_COUNTER_BINARY_V7_0(behavioral)
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
-- synopsys translate_on
BEGIN
-- synopsys translate_off
U0 : wrapped_binary_counter_virtex2p_7_0_edc7d761bd25890d
		port map (
			Q => Q,
			CLK => CLK,
			LOAD => LOAD,
			L => L,
			CE => CE,
			SINIT => SINIT);
-- synopsys translate_on

END binary_counter_virtex2p_7_0_edc7d761bd25890d_a;

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
--     (c) Copyright 1995-2006 Xilinx, Inc.                                   --
--     All rights reserved.                                                   --
--------------------------------------------------------------------------------
-- You must compile the wrapper file dual_port_block_memory_virtex2p_6_1_299a9f537bb5a43d.vhd when simulating
-- the core, dual_port_block_memory_virtex2p_6_1_299a9f537bb5a43d. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synopsys directives "translate_off/translate_on" specified
-- below are supported by XST, FPGA Compiler II, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synopsys translate_off
Library XilinxCoreLib;
-- synopsys translate_on
ENTITY dual_port_block_memory_virtex2p_6_1_299a9f537bb5a43d IS
	port (
	addra: IN std_logic_VECTOR(8 downto 0);
	addrb: IN std_logic_VECTOR(7 downto 0);
	clka: IN std_logic;
	clkb: IN std_logic;
	dina: IN std_logic_VECTOR(15 downto 0);
	dinb: IN std_logic_VECTOR(31 downto 0);
	douta: OUT std_logic_VECTOR(15 downto 0);
	doutb: OUT std_logic_VECTOR(31 downto 0);
	ena: IN std_logic;
	enb: IN std_logic;
	wea: IN std_logic;
	web: IN std_logic);
END dual_port_block_memory_virtex2p_6_1_299a9f537bb5a43d;

ARCHITECTURE dual_port_block_memory_virtex2p_6_1_299a9f537bb5a43d_a OF dual_port_block_memory_virtex2p_6_1_299a9f537bb5a43d IS
-- synopsys translate_off
component wrapped_dual_port_block_memory_virtex2p_6_1_299a9f537bb5a43d
	port (
	addra: IN std_logic_VECTOR(8 downto 0);
	addrb: IN std_logic_VECTOR(7 downto 0);
	clka: IN std_logic;
	clkb: IN std_logic;
	dina: IN std_logic_VECTOR(15 downto 0);
	dinb: IN std_logic_VECTOR(31 downto 0);
	douta: OUT std_logic_VECTOR(15 downto 0);
	doutb: OUT std_logic_VECTOR(31 downto 0);
	ena: IN std_logic;
	enb: IN std_logic;
	wea: IN std_logic;
	web: IN std_logic);
end component;

-- Configuration specification 
	for all : wrapped_dual_port_block_memory_virtex2p_6_1_299a9f537bb5a43d use entity XilinxCoreLib.blkmemdp_v6_1(behavioral)
		generic map(
			c_reg_inputsb => 0,
			c_reg_inputsa => 0,
			c_has_ndb => 0,
			c_has_nda => 0,
			c_ytop_addr => "1024",
			c_has_rfdb => 0,
			c_has_rfda => 0,
			c_ywea_is_high => 1,
			c_yena_is_high => 1,
			c_yclka_is_rising => 1,
			c_yhierarchy => "hierarchy1",
			c_ysinita_is_high => 1,
			c_ybottom_addr => "0",
			c_width_b => 32,
			c_width_a => 16,
			c_sinita_value => "0",
			c_sinitb_value => "0",
			c_limit_data_pitch => 18,
			c_write_modeb => 0,
			c_write_modea => 0,
			c_has_rdyb => 0,
			c_yuse_single_primitive => 0,
			c_has_rdya => 0,
			c_addra_width => 9,
			c_addrb_width => 8,
			c_has_limit_data_pitch => 0,
			c_default_data => "0",
			c_pipe_stages_b => 0,
			c_yweb_is_high => 1,
			c_yenb_is_high => 1,
			c_pipe_stages_a => 0,
			c_yclkb_is_rising => 1,
			c_yydisable_warnings => 1,
			c_enable_rlocs => 0,
			c_ysinitb_is_high => 1,
			c_has_default_data => 0,
			c_has_web => 1,
			c_has_sinitb => 0,
			c_has_wea => 1,
			c_has_sinita => 0,
			c_has_dinb => 1,
			c_has_dina => 1,
			c_ymake_bmm => 0,
			c_has_enb => 1,
			c_has_ena => 1,
			c_mem_init_file => "dual_port_block_memory_virtex2p_6_1_299a9f537bb5a43d.mif",
			c_depth_b => 256,
			c_depth_a => 512,
			c_has_doutb => 1,
			c_has_douta => 1,
			c_yprimitive_type => "16kx1");
-- synopsys translate_on
BEGIN
-- synopsys translate_off
U0 : wrapped_dual_port_block_memory_virtex2p_6_1_299a9f537bb5a43d
		port map (
			addra => addra,
			addrb => addrb,
			clka => clka,
			clkb => clkb,
			dina => dina,
			dinb => dinb,
			douta => douta,
			doutb => doutb,
			ena => ena,
			enb => enb,
			wea => wea,
			web => web);
-- synopsys translate_on

END dual_port_block_memory_virtex2p_6_1_299a9f537bb5a43d_a;

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
--     (c) Copyright 1995-2006 Xilinx, Inc.                                   --
--     All rights reserved.                                                   --
--------------------------------------------------------------------------------
-- You must compile the wrapper file dual_port_block_memory_virtex2p_6_1_46032f721e0f73ab.vhd when simulating
-- the core, dual_port_block_memory_virtex2p_6_1_46032f721e0f73ab. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synopsys directives "translate_off/translate_on" specified
-- below are supported by XST, FPGA Compiler II, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synopsys translate_off
Library XilinxCoreLib;
-- synopsys translate_on
ENTITY dual_port_block_memory_virtex2p_6_1_46032f721e0f73ab IS
	port (
	addra: IN std_logic_VECTOR(13 downto 0);
	addrb: IN std_logic_VECTOR(11 downto 0);
	clka: IN std_logic;
	clkb: IN std_logic;
	dina: IN std_logic_VECTOR(7 downto 0);
	dinb: IN std_logic_VECTOR(31 downto 0);
	douta: OUT std_logic_VECTOR(7 downto 0);
	doutb: OUT std_logic_VECTOR(31 downto 0);
	ena: IN std_logic;
	enb: IN std_logic;
	wea: IN std_logic;
	web: IN std_logic);
END dual_port_block_memory_virtex2p_6_1_46032f721e0f73ab;

ARCHITECTURE dual_port_block_memory_virtex2p_6_1_46032f721e0f73ab_a OF dual_port_block_memory_virtex2p_6_1_46032f721e0f73ab IS
-- synopsys translate_off
component wrapped_dual_port_block_memory_virtex2p_6_1_46032f721e0f73ab
	port (
	addra: IN std_logic_VECTOR(13 downto 0);
	addrb: IN std_logic_VECTOR(11 downto 0);
	clka: IN std_logic;
	clkb: IN std_logic;
	dina: IN std_logic_VECTOR(7 downto 0);
	dinb: IN std_logic_VECTOR(31 downto 0);
	douta: OUT std_logic_VECTOR(7 downto 0);
	doutb: OUT std_logic_VECTOR(31 downto 0);
	ena: IN std_logic;
	enb: IN std_logic;
	wea: IN std_logic;
	web: IN std_logic);
end component;

-- Configuration specification 
	for all : wrapped_dual_port_block_memory_virtex2p_6_1_46032f721e0f73ab use entity XilinxCoreLib.blkmemdp_v6_1(behavioral)
		generic map(
			c_reg_inputsb => 0,
			c_reg_inputsa => 0,
			c_has_ndb => 0,
			c_has_nda => 0,
			c_ytop_addr => "1024",
			c_has_rfdb => 0,
			c_has_rfda => 0,
			c_ywea_is_high => 1,
			c_yena_is_high => 1,
			c_yclka_is_rising => 1,
			c_yhierarchy => "hierarchy1",
			c_ysinita_is_high => 1,
			c_ybottom_addr => "0",
			c_width_b => 32,
			c_width_a => 8,
			c_sinita_value => "0",
			c_sinitb_value => "0",
			c_limit_data_pitch => 18,
			c_write_modeb => 0,
			c_write_modea => 0,
			c_has_rdyb => 0,
			c_yuse_single_primitive => 0,
			c_has_rdya => 0,
			c_addra_width => 14,
			c_addrb_width => 12,
			c_has_limit_data_pitch => 0,
			c_default_data => "0",
			c_pipe_stages_b => 0,
			c_yweb_is_high => 1,
			c_yenb_is_high => 1,
			c_pipe_stages_a => 0,
			c_yclkb_is_rising => 1,
			c_yydisable_warnings => 1,
			c_enable_rlocs => 0,
			c_ysinitb_is_high => 1,
			c_has_default_data => 0,
			c_has_web => 1,
			c_has_sinitb => 0,
			c_has_wea => 1,
			c_has_sinita => 0,
			c_has_dinb => 1,
			c_has_dina => 1,
			c_ymake_bmm => 0,
			c_has_enb => 1,
			c_has_ena => 1,
			c_mem_init_file => "dual_port_block_memory_virtex2p_6_1_46032f721e0f73ab.mif",
			c_depth_b => 4096,
			c_depth_a => 16384,
			c_has_doutb => 1,
			c_has_douta => 1,
			c_yprimitive_type => "16kx1");
-- synopsys translate_on
BEGIN
-- synopsys translate_off
U0 : wrapped_dual_port_block_memory_virtex2p_6_1_46032f721e0f73ab
		port map (
			addra => addra,
			addrb => addrb,
			clka => clka,
			clkb => clkb,
			dina => dina,
			dinb => dinb,
			douta => douta,
			doutb => doutb,
			ena => ena,
			enb => enb,
			wea => wea,
			web => web);
-- synopsys translate_on

END dual_port_block_memory_virtex2p_6_1_46032f721e0f73ab_a;

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
--     (c) Copyright 1995-2006 Xilinx, Inc.                                   --
--     All rights reserved.                                                   --
--------------------------------------------------------------------------------
-- You must compile the wrapper file dual_port_block_memory_virtex2p_6_1_a4748ac34de4a8d3.vhd when simulating
-- the core, dual_port_block_memory_virtex2p_6_1_a4748ac34de4a8d3. When compiling the wrapper file, be sure to
-- reference the XilinxCoreLib VHDL simulation library. For detailed
-- instructions, please refer to the "CORE Generator Help".

-- The synopsys directives "translate_off/translate_on" specified
-- below are supported by XST, FPGA Compiler II, Mentor Graphics and Synplicity
-- synthesis tools. Ensure they are correct for your synthesis tool(s).

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- synopsys translate_off
Library XilinxCoreLib;
-- synopsys translate_on
ENTITY dual_port_block_memory_virtex2p_6_1_a4748ac34de4a8d3 IS
	port (
	addra: IN std_logic_VECTOR(10 downto 0);
	addrb: IN std_logic_VECTOR(8 downto 0);
	clka: IN std_logic;
	clkb: IN std_logic;
	dina: IN std_logic_VECTOR(7 downto 0);
	dinb: IN std_logic_VECTOR(31 downto 0);
	douta: OUT std_logic_VECTOR(7 downto 0);
	doutb: OUT std_logic_VECTOR(31 downto 0);
	ena: IN std_logic;
	enb: IN std_logic;
	wea: IN std_logic;
	web: IN std_logic);
END dual_port_block_memory_virtex2p_6_1_a4748ac34de4a8d3;

ARCHITECTURE dual_port_block_memory_virtex2p_6_1_a4748ac34de4a8d3_a OF dual_port_block_memory_virtex2p_6_1_a4748ac34de4a8d3 IS
-- synopsys translate_off
component wrapped_dual_port_block_memory_virtex2p_6_1_a4748ac34de4a8d3
	port (
	addra: IN std_logic_VECTOR(10 downto 0);
	addrb: IN std_logic_VECTOR(8 downto 0);
	clka: IN std_logic;
	clkb: IN std_logic;
	dina: IN std_logic_VECTOR(7 downto 0);
	dinb: IN std_logic_VECTOR(31 downto 0);
	douta: OUT std_logic_VECTOR(7 downto 0);
	doutb: OUT std_logic_VECTOR(31 downto 0);
	ena: IN std_logic;
	enb: IN std_logic;
	wea: IN std_logic;
	web: IN std_logic);
end component;

-- Configuration specification 
	for all : wrapped_dual_port_block_memory_virtex2p_6_1_a4748ac34de4a8d3 use entity XilinxCoreLib.blkmemdp_v6_1(behavioral)
		generic map(
			c_reg_inputsb => 0,
			c_reg_inputsa => 0,
			c_has_ndb => 0,
			c_has_nda => 0,
			c_ytop_addr => "1024",
			c_has_rfdb => 0,
			c_has_rfda => 0,
			c_ywea_is_high => 1,
			c_yena_is_high => 1,
			c_yclka_is_rising => 1,
			c_yhierarchy => "hierarchy1",
			c_ysinita_is_high => 1,
			c_ybottom_addr => "0",
			c_width_b => 32,
			c_width_a => 8,
			c_sinita_value => "0",
			c_sinitb_value => "0",
			c_limit_data_pitch => 18,
			c_write_modeb => 0,
			c_write_modea => 0,
			c_has_rdyb => 0,
			c_yuse_single_primitive => 0,
			c_has_rdya => 0,
			c_addra_width => 11,
			c_addrb_width => 9,
			c_has_limit_data_pitch => 0,
			c_default_data => "0",
			c_pipe_stages_b => 0,
			c_yweb_is_high => 1,
			c_yenb_is_high => 1,
			c_pipe_stages_a => 0,
			c_yclkb_is_rising => 1,
			c_yydisable_warnings => 1,
			c_enable_rlocs => 0,
			c_ysinitb_is_high => 1,
			c_has_default_data => 0,
			c_has_web => 1,
			c_has_sinitb => 0,
			c_has_wea => 1,
			c_has_sinita => 0,
			c_has_dinb => 1,
			c_has_dina => 1,
			c_ymake_bmm => 0,
			c_has_enb => 1,
			c_has_ena => 1,
			c_mem_init_file => "dual_port_block_memory_virtex2p_6_1_a4748ac34de4a8d3.mif",
			c_depth_b => 512,
			c_depth_a => 2048,
			c_has_doutb => 1,
			c_has_douta => 1,
			c_yprimitive_type => "16kx1");
-- synopsys translate_on
BEGIN
-- synopsys translate_off
U0 : wrapped_dual_port_block_memory_virtex2p_6_1_a4748ac34de4a8d3
		port map (
			addra => addra,
			addrb => addrb,
			clka => clka,
			clkb => clkb,
			dina => dina,
			dinb => dinb,
			douta => douta,
			doutb => doutb,
			ena => ena,
			enb => enb,
			wea => wea,
			web => web);
-- synopsys translate_on

END dual_port_block_memory_virtex2p_6_1_a4748ac34de4a8d3_a;


-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
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
    function SIGN (X: real ) return real;
    function CEIL (X : real ) return real;
    function FLOOR (X : real ) return real;
    function ROUND (X : real ) return real;
    function FMAX (X, Y : real ) return real;
    function FMIN (X, Y : real ) return real;
    -- synopsys translate_on
end conv_pkg;
package body conv_pkg is
    function std_logic_vector_to_unsigned(inp : std_logic_vector)
        return unsigned
    is
        variable vec : std_logic_vector(inp'range);
        variable result : unsigned(inp'range);
    begin
        vec := inp;
        -- synopsys translate_off
        if Is_X(vec) then
            result := (others => 'X');
            return result;
        end if;
        -- synopsys translate_on
        for i in vec'range loop
            if vec(i) = '1' then
                result(i) := '1';
            else
                result(i) := '0';
            end if;
        end loop;
        return result;
    end;
    function unsigned_to_std_logic_vector(inp : unsigned)
        return std_logic_vector
    is
        variable vec : unsigned(inp'range);
        variable result : std_logic_vector(inp'range);
    begin
        vec := inp;
        for i in vec'range loop
            if vec(i) = '1' then
                result(i) := '1';
            else
                result(i) := '0';
            end if;
        end loop;
        return result;
    end;
    function std_logic_vector_to_signed(inp : std_logic_vector)
        return signed
    is
        variable vec : std_logic_vector(inp'range);
        variable result : signed(inp'range);
    begin
        vec := inp;
        -- synopsys translate_off
        if Is_X(vec) then
            result := (others => 'X');
            return result;
        end if;
        -- synopsys translate_on
        for i in vec'range loop
            if vec(i) = '1' then
                result(i) := '1';
            else
                result(i) := '0';
            end if;
        end loop;
        return result;
    end;
    function signed_to_std_logic_vector(inp : signed)
        return std_logic_vector
    is
        variable vec : signed(inp'range);
        variable result : std_logic_vector(inp'range);
    begin
        vec := inp;
        for i in vec'range loop
            if vec(i) = '1' then
                result(i) := '1';
            else
                result(i) := '0';
            end if;
        end loop;
        return result;
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
    function SIGN (X: real ) return real is
    begin
           if  ( X > 0.0 )  then
                return 1.0;
           elsif ( X < 0.0 )  then
                return -1.0;
           else
                return 0.0;
           end if;
    end SIGN;
   function CEIL (X : real ) return real is
         variable large: real  := 1073741824.0;
         type long is range -1073741824 to 1073741824;
         variable rd: real;
      begin
         if abs( X) >= large then
            return X;
         else
            rd := real ( long( X));
            if X > 0.0 then
                if rd >= X then
                        return rd;
                else
                        return rd + 1.0;
                end if;
            elsif  X = 0.0  then
                        return 0.0;
            else
                if rd <= X then
                        return rd;
                else
                        return rd - 1.0;
                end if;
            end if;
         end if;
      end CEIL;
    function FLOOR (X : real ) return real is
         variable large: real  := 1073741824.0;
         type long is range -1073741824 to 1073741824;
         variable rd: real;
      begin
         if abs( X ) >= large then
                return X;
         else
                rd := real ( long( X));
                if X > 0.0 then
                        if rd <= X then
                                return rd;
                        else
                                return rd - 1.0;
                        end if;
                elsif  X = 0.0  then
                        return 0.0;
                else
                        if rd >= X then
                                return rd;
                        else
                                return rd + 1.0;
                        end if;
                end if;
         end if;
      end FLOOR;
    function ROUND (X : real ) return real is
    begin
           if  X > 0.0  then
                return FLOOR(X + 0.5);
           elsif  X < 0.0  then
                return CEIL( X - 0.5);
           else
                return 0.0;
           end if;
    end ROUND;
    function FMAX (X, Y : real ) return real is
    begin
        if X > Y then
           return X;
        else
           return Y;
        end if;
    end FMAX;
    function FMIN (X, Y : real ) return real is
    begin
        if X < Y then
           return X;
        else
           return Y;
        end if;
    end FMIN;
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
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
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
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
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
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;
entity xldelay is
   generic(d_width    : integer := 5;
           d_bin_pt   : integer := 2;
           d_arith    : integer := xlUnsigned;
           q_width    : integer := 5;
           q_bin_pt   : integer := 2;
           q_arith    : integer := xlUnsigned;
           rst_width  : integer := 1;
           rst_bin_pt : integer := 0;
           en_width   : integer := 5;
           en_bin_pt  : integer := 2;
           en_arith   : integer := xlUnsigned;
           rst_arith  : integer := xlUnsigned;
           latency    : integer := 10;
           reg_retiming: boolean := false);
   port(d       : in std_logic_vector (d_width-1 downto 0);
        ce      : in std_logic;
        clr     : in std_logic;
        clk     : in std_logic;
        rst     : in std_logic_vector (rst_width-1 downto 0);
        en      : in std_logic_vector (en_width-1 downto 0);
        q       : out std_logic_vector (q_width-1 downto 0));
end xldelay;
architecture behavior of xldelay is
   component synth_reg
      generic (width       : integer;
               latency     : integer);
      port (i           : in std_logic_vector(width-1 downto 0);
            ce      : in std_logic;
            clr     : in std_logic;
            clk     : in std_logic;
            o       : out std_logic_vector(width-1 downto 0));
   end component;
   component synth_reg_reg
      generic (width       : integer;
               latency     : integer);
      port (i           : in std_logic_vector(width-1 downto 0);
            ce      : in std_logic;
            clr     : in std_logic;
            clk     : in std_logic;
            o       : out std_logic_vector(width-1 downto 0));
   end component;
   signal internal_ce  : std_logic;
   signal internal_clr : std_logic;
begin
   internal_ce  <= ce and (en(0));
   internal_clr <= (clr or (rst(0))) and ce;
   srl_delay: if (not reg_retiming) or (latency<1) generate
     synth_reg_srl_inst : synth_reg
       generic map (
         width   => d_width,
         latency => latency)
       port map (
         i   => d,
         ce  => internal_ce,
         clr => internal_clr,
         clk => clk,
         o   => q);
   end generate srl_delay;
   reg_delay: if reg_retiming and (latency>=1) generate
     synth_reg_reg_inst : synth_reg_reg
       generic map (
         width   => d_width,
         latency => latency)
       port map (
         i   => d,
         ce  => internal_ce,
         clr => internal_clr,
         clk => clk,
         o   => q);
   end generate reg_delay;
end architecture behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity inverter_483484483c is
  port (
    ip : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end inverter_483484483c;
architecture behavior of inverter_483484483c is
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
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity logical_c1e87cc01e is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end logical_c1e87cc01e;
architecture behavior of logical_c1e87cc01e is
  signal d0_1_24: unsigned((1 - 1) downto 0);
  signal d1_1_27: unsigned((1 - 1) downto 0);
  signal bit_2_26: unsigned((1 - 1) downto 0);
  signal fully_2_1_bitnot: unsigned((1 - 1) downto 0);
begin
  d0_1_24 <= std_logic_vector_to_unsigned(d0);
  d1_1_27 <= std_logic_vector_to_unsigned(d1);
  bit_2_26 <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(d0_1_24) or unsigned_to_std_logic_vector(d1_1_27));
  fully_2_1_bitnot <= std_logic_vector_to_unsigned(not unsigned_to_std_logic_vector(bit_2_26));
  y <= unsigned_to_std_logic_vector(fully_2_1_bitnot);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity accumulator_3c9ca85b93 is
  port (
    b : in std_logic_vector((1 - 1) downto 0);
    rst : in std_logic_vector((1 - 1) downto 0);
    en : in std_logic_vector((1 - 1) downto 0);
    q : out std_logic_vector((7 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end accumulator_3c9ca85b93;
architecture behavior of accumulator_3c9ca85b93 is
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

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity accumulator1_c27a5ffacb is
  port (
    b : in std_logic_vector((1 - 1) downto 0);
    rst : in std_logic_vector((1 - 1) downto 0);
    q : out std_logic_vector((4 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end accumulator1_c27a5ffacb;
architecture behavior of accumulator1_c27a5ffacb is
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
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
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
  component adder_subtracter_virtex2p_7_0_219d4ec01152994f
    port (
      a: in std_logic_vector( 9 - 1 downto 0);
      s: out std_logic_vector(c_output_width - 1 downto 0);
      b: in std_logic_vector(9 - 1 downto 0)
    );
  end component;
  attribute syn_black_box of adder_subtracter_virtex2p_7_0_219d4ec01152994f:
    component is true;
  attribute fpga_dont_touch of adder_subtracter_virtex2p_7_0_219d4ec01152994f:
    component is "true";
  attribute box_type of adder_subtracter_virtex2p_7_0_219d4ec01152994f:
    component  is "black_box";
  component adder_subtracter_virtex2p_7_0_2cb583e55ff51f1e
    port (
      a: in std_logic_vector( 9 - 1 downto 0);
      s: out std_logic_vector(c_output_width - 1 downto 0);
      b: in std_logic_vector(9 - 1 downto 0)
    );
  end component;
  attribute syn_black_box of adder_subtracter_virtex2p_7_0_2cb583e55ff51f1e:
    component is true;
  attribute fpga_dont_touch of adder_subtracter_virtex2p_7_0_2cb583e55ff51f1e:
    component is "true";
  attribute box_type of adder_subtracter_virtex2p_7_0_2cb583e55ff51f1e:
    component  is "black_box";
  component adder_subtracter_virtex2p_7_0_cb748602b0616a72
    port (
      a: in std_logic_vector( 5 - 1 downto 0);
      s: out std_logic_vector(c_output_width - 1 downto 0);
      b: in std_logic_vector(5 - 1 downto 0)
    );
  end component;
  attribute syn_black_box of adder_subtracter_virtex2p_7_0_cb748602b0616a72:
    component is true;
  attribute fpga_dont_touch of adder_subtracter_virtex2p_7_0_cb748602b0616a72:
    component is "true";
  attribute box_type of adder_subtracter_virtex2p_7_0_cb748602b0616a72:
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

  comp0: if ((core_name0 = "adder_subtracter_virtex2p_7_0_219d4ec01152994f")) generate
    core_instance0: adder_subtracter_virtex2p_7_0_219d4ec01152994f
      port map (
        a => full_a,
        s => core_s,
        b => full_b
      );
  end generate;
  comp1: if ((core_name0 = "adder_subtracter_virtex2p_7_0_2cb583e55ff51f1e")) generate
    core_instance1: adder_subtracter_virtex2p_7_0_2cb583e55ff51f1e
      port map (
        a => full_a,
        s => core_s,
        b => full_b
      );
  end generate;
  comp5: if ((core_name0 = "adder_subtracter_virtex2p_7_0_cb748602b0616a72")) generate
    core_instance5: adder_subtracter_virtex2p_7_0_cb748602b0616a72
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

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity concat_f96b9412f2 is
  port (
    in0 : in std_logic_vector((2 - 1) downto 0);
    in1 : in std_logic_vector((7 - 1) downto 0);
    y : out std_logic_vector((9 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end concat_f96b9412f2;
architecture behavior of concat_f96b9412f2 is
  signal in0_1_23: unsigned((2 - 1) downto 0);
  signal in1_1_27: unsigned((7 - 1) downto 0);
  signal y_2_1_concat: unsigned((9 - 1) downto 0);
begin
  in0_1_23 <= std_logic_vector_to_unsigned(in0);
  in1_1_27 <= std_logic_vector_to_unsigned(in1);
  y_2_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(in0_1_23) & unsigned_to_std_logic_vector(in1_1_27));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity concat1_2ac6567a3e is
  port (
    in0 : in std_logic_vector((6 - 1) downto 0);
    in1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((7 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end concat1_2ac6567a3e;
architecture behavior of concat1_2ac6567a3e is
  signal in0_1_23: unsigned((6 - 1) downto 0);
  signal in1_1_27: unsigned((1 - 1) downto 0);
  signal y_2_1_concat: unsigned((7 - 1) downto 0);
begin
  in0_1_23 <= std_logic_vector_to_unsigned(in0);
  in1_1_27 <= std_logic_vector_to_unsigned(in1);
  y_2_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(in0_1_23) & unsigned_to_std_logic_vector(in1_1_27));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity concat2_8a85d2cc10 is
  port (
    in0 : in std_logic_vector((1 - 1) downto 0);
    in1 : in std_logic_vector((8 - 1) downto 0);
    y : out std_logic_vector((9 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end concat2_8a85d2cc10;
architecture behavior of concat2_8a85d2cc10 is
  signal in0_1_23: unsigned((1 - 1) downto 0);
  signal in1_1_27: unsigned((8 - 1) downto 0);
  signal y_2_1_concat: unsigned((9 - 1) downto 0);
begin
  in0_1_23 <= std_logic_vector_to_unsigned(in0);
  in1_1_27 <= std_logic_vector_to_unsigned(in1);
  y_2_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(in0_1_23) & unsigned_to_std_logic_vector(in1_1_27));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity constant_2d9b97cb9a is
  port (
    op : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_2d9b97cb9a;
architecture behavior of constant_2d9b97cb9a is
begin
  op <= "0000000000000000";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity constant1_4b9555fd30 is
  port (
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant1_4b9555fd30;
architecture behavior of constant1_4b9555fd30 is
begin
  op <= "0";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity constant11_70078828c1 is
  port (
    op : out std_logic_vector((9 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant11_70078828c1;
architecture behavior of constant11_70078828c1 is
begin
  op <= "101011100";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity constant2_0654d2f81a is
  port (
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant2_0654d2f81a;
architecture behavior of constant2_0654d2f81a is
begin
  op <= "0";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity constant3_0cf35d0c4a is
  port (
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant3_0cf35d0c4a;
architecture behavior of constant3_0cf35d0c4a is
begin
  op <= "1";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity constant4_f29fd03492 is
  port (
    op : out std_logic_vector((4 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant4_f29fd03492;
architecture behavior of constant4_f29fd03492 is
begin
  op <= "1000";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity constant5_05127ac58f is
  port (
    op : out std_logic_vector((9 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant5_05127ac58f;
architecture behavior of constant5_05127ac58f is
begin
  op <= "100010101";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity constant6_fd460e8414 is
  port (
    op : out std_logic_vector((9 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant6_fd460e8414;
architecture behavior of constant6_fd460e8414 is
begin
  op <= "101110101";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
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
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
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
  component binary_counter_virtex2p_7_0_016610e0863621bf
    port (
      clk: in std_logic;
      ce: in std_logic;
      sinit: in std_logic;
      q: out std_logic_vector(op_width - 1 downto 0)
    );
  end component;
  attribute syn_black_box of binary_counter_virtex2p_7_0_016610e0863621bf:
    component is true;
  attribute fpga_dont_touch of binary_counter_virtex2p_7_0_016610e0863621bf:
    component is "true";
  attribute box_type of binary_counter_virtex2p_7_0_016610e0863621bf:
    component  is "black_box";
  component binary_counter_virtex2p_7_0_edc7d761bd25890d
    port (
      clk: in std_logic;
      ce: in std_logic;
      sinit: in std_logic;
      load: in std_logic;
      l: in std_logic_vector(op_width - 1 downto 0);
      q: out std_logic_vector(op_width - 1 downto 0)
    );
  end component;
  attribute syn_black_box of binary_counter_virtex2p_7_0_edc7d761bd25890d:
    component is true;
  attribute fpga_dont_touch of binary_counter_virtex2p_7_0_edc7d761bd25890d:
    component is "true";
  attribute box_type of binary_counter_virtex2p_7_0_edc7d761bd25890d:
    component  is "black_box";
  component binary_counter_virtex2p_7_0_67ac1d95fffad199
    port (
      clk: in std_logic;
      ce: in std_logic;
      sinit: in std_logic;
      q: out std_logic_vector(op_width - 1 downto 0)
    );
  end component;
  attribute syn_black_box of binary_counter_virtex2p_7_0_67ac1d95fffad199:
    component is true;
  attribute fpga_dont_touch of binary_counter_virtex2p_7_0_67ac1d95fffad199:
    component is "true";
  attribute box_type of binary_counter_virtex2p_7_0_67ac1d95fffad199:
    component  is "black_box";
  component binary_counter_virtex2p_7_0_dbb5736f3ec3cba8
    port (
      clk: in std_logic;
      ce: in std_logic;
      sinit: in std_logic;
      load: in std_logic;
      l: in std_logic_vector(op_width - 1 downto 0);
      q: out std_logic_vector(op_width - 1 downto 0)
    );
  end component;
  attribute syn_black_box of binary_counter_virtex2p_7_0_dbb5736f3ec3cba8:
    component is true;
  attribute fpga_dont_touch of binary_counter_virtex2p_7_0_dbb5736f3ec3cba8:
    component is "true";
  attribute box_type of binary_counter_virtex2p_7_0_dbb5736f3ec3cba8:
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
  comp0: if ((core_name0 = "binary_counter_virtex2p_7_0_016610e0863621bf")) generate
    core_instance0: binary_counter_virtex2p_7_0_016610e0863621bf
      port map (
        clk => clk,
        ce => core_ce,
        sinit => core_sinit,
        q => op_net
      );
  end generate;
  comp1: if ((core_name0 = "binary_counter_virtex2p_7_0_edc7d761bd25890d")) generate
    core_instance1: binary_counter_virtex2p_7_0_edc7d761bd25890d
      port map (
        clk => clk,
        ce => core_ce,
        sinit => core_sinit,
        load => load(0),
        l => din,
        q => op_net
      );
  end generate;
  comp2: if ((core_name0 = "binary_counter_virtex2p_7_0_67ac1d95fffad199")) generate
    core_instance2: binary_counter_virtex2p_7_0_67ac1d95fffad199
      port map (
        clk => clk,
        ce => core_ce,
        sinit => core_sinit,
        q => op_net
      );
  end generate;
  comp3: if ((core_name0 = "binary_counter_virtex2p_7_0_dbb5736f3ec3cba8")) generate
    core_instance3: binary_counter_virtex2p_7_0_dbb5736f3ec3cba8
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

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
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
  component binary_counter_virtex2p_7_0_18e84c36111bc674
    port (
      clk: in std_logic;
      ce: in std_logic;
      sinit: in std_logic;
      q: out std_logic_vector(op_width - 1 downto 0)
    );
  end component;
  attribute syn_black_box of binary_counter_virtex2p_7_0_18e84c36111bc674:
    component is true;
  attribute fpga_dont_touch of binary_counter_virtex2p_7_0_18e84c36111bc674:
    component is "true";
  attribute box_type of binary_counter_virtex2p_7_0_18e84c36111bc674:
    component  is "black_box";
  component binary_counter_virtex2p_7_0_0611420023f6fdd6
    port (
      clk: in std_logic;
      ce: in std_logic;
      sinit: in std_logic;
      q: out std_logic_vector(op_width - 1 downto 0)
    );
  end component;
  attribute syn_black_box of binary_counter_virtex2p_7_0_0611420023f6fdd6:
    component is true;
  attribute fpga_dont_touch of binary_counter_virtex2p_7_0_0611420023f6fdd6:
    component is "true";
  attribute box_type of binary_counter_virtex2p_7_0_0611420023f6fdd6:
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
  comp0: if ((core_name0 = "binary_counter_virtex2p_7_0_18e84c36111bc674")) generate
    core_instance0: binary_counter_virtex2p_7_0_18e84c36111bc674
      port map (
        clk => clk,
        ce => core_ce,
        sinit => core_sinit,
        q => op_net
      );
  end generate;
  comp1: if ((core_name0 = "binary_counter_virtex2p_7_0_0611420023f6fdd6")) generate
    core_instance1: binary_counter_virtex2p_7_0_0611420023f6fdd6
      port map (
        clk => clk,
        ce => core_ce,
        sinit => core_sinit,
        q => op_net
      );
  end generate;
end  behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity inverter_14bb39843b is
  port (
    ip : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end inverter_14bb39843b;
architecture behavior of inverter_14bb39843b is
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
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity inverter1_3fee9159a7 is
  port (
    ip : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end inverter1_3fee9159a7;
architecture behavior of inverter1_3fee9159a7 is
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
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity inverter2_1b9490e500 is
  port (
    ip : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end inverter2_1b9490e500;
architecture behavior of inverter2_1b9490e500 is
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

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity logical_af271e0696 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end logical_af271e0696;
architecture behavior of logical_af271e0696 is
  signal d0_1_24: boolean;
  signal d1_1_27: boolean;
  signal fully_2_1_bit: boolean;
begin
  d0_1_24 <= ((d0) = "1");
  d1_1_27 <= ((d1) = "1");
  fully_2_1_bit <= ((boolean_to_vector(d0_1_24) or boolean_to_vector(d1_1_27)) = "1");
  y <= boolean_to_vector(fully_2_1_bit);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity logical1_e4df6d4a9f is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end logical1_e4df6d4a9f;
architecture behavior of logical1_e4df6d4a9f is
  signal d0_1_24: boolean;
  signal d1_1_27: boolean;
  signal fully_2_1_bit: boolean;
begin
  d0_1_24 <= ((d0) = "1");
  d1_1_27 <= ((d1) = "1");
  fully_2_1_bit <= ((boolean_to_vector(d0_1_24) and boolean_to_vector(d1_1_27)) = "1");
  y <= boolean_to_vector(fully_2_1_bit);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity logical2_137bc961d4 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end logical2_137bc961d4;
architecture behavior of logical2_137bc961d4 is
  signal d0_1_24: boolean;
  signal d1_1_27: boolean;
  signal fully_2_1_bit: boolean;
begin
  d0_1_24 <= ((d0) = "1");
  d1_1_27 <= ((d1) = "1");
  fully_2_1_bit <= ((boolean_to_vector(d0_1_24) and boolean_to_vector(d1_1_27)) = "1");
  y <= boolean_to_vector(fully_2_1_bit);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity logical3_74d991d050 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end logical3_74d991d050;
architecture behavior of logical3_74d991d050 is
  signal d0_1_24: boolean;
  signal d1_1_27: boolean;
  signal fully_2_1_bit: boolean;
begin
  d0_1_24 <= ((d0) = "1");
  d1_1_27 <= ((d1) = "1");
  fully_2_1_bit <= ((boolean_to_vector(d0_1_24) and boolean_to_vector(d1_1_27)) = "1");
  y <= boolean_to_vector(fully_2_1_bit);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity mux_afca224d2c is
  port (
    sel : in std_logic_vector((1 - 1) downto 0);
    d0 : in std_logic_vector((7 - 1) downto 0);
    d1 : in std_logic_vector((7 - 1) downto 0);
    y : out std_logic_vector((7 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end mux_afca224d2c;
architecture behavior of mux_afca224d2c is
  signal sel_1_20: unsigned((1 - 1) downto 0);
  signal d0_1_24: unsigned((7 - 1) downto 0);
  signal d1_1_27: unsigned((7 - 1) downto 0);
  signal unregy_join_3_1: unsigned((7 - 1) downto 0);
begin
  sel_1_20 <= std_logic_vector_to_unsigned(sel);
  d0_1_24 <= std_logic_vector_to_unsigned(d0);
  d1_1_27 <= std_logic_vector_to_unsigned(d1);
  proc_switch_3_1: process (d0_1_24, d1_1_27, sel_1_20)
  is
  begin
    case sel_1_20 is 
      when "0" =>
        unregy_join_3_1 <= d0_1_24;
      when "1" =>
        unregy_join_3_1 <= d1_1_27;
      when others =>
        unregy_join_3_1 <= d0_1_24;
    end case;
  end process proc_switch_3_1;
  y <= unsigned_to_std_logic_vector(unregy_join_3_1);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity mux1_b57c0b6e47 is
  port (
    sel : in std_logic_vector((1 - 1) downto 0);
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end mux1_b57c0b6e47;
architecture behavior of mux1_b57c0b6e47 is
  signal sel_1_20: boolean;
  signal d0_1_24: boolean;
  signal d1_1_27: boolean;
  signal sel_internal_2_1_convert: unsigned((1 - 1) downto 0);
  signal unregy_join_3_1: boolean;
begin
  sel_1_20 <= ((sel) = "1");
  d0_1_24 <= ((d0) = "1");
  d1_1_27 <= ((d1) = "1");
  sel_internal_2_1_convert <= u2u_cast(std_logic_vector_to_unsigned(boolean_to_vector(sel_1_20)), 0, 1, 0);
  proc_switch_3_1: process (d0_1_24, d1_1_27, sel_internal_2_1_convert)
  is
  begin
    case sel_internal_2_1_convert is 
      when "0" =>
        unregy_join_3_1 <= d0_1_24;
      when "1" =>
        unregy_join_3_1 <= d1_1_27;
      when others =>
        unregy_join_3_1 <= d0_1_24;
    end case;
  end process proc_switch_3_1;
  y <= boolean_to_vector(unregy_join_3_1);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity mux2_5692309004 is
  port (
    sel : in std_logic_vector((1 - 1) downto 0);
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end mux2_5692309004;
architecture behavior of mux2_5692309004 is
  signal sel_1_20: boolean;
  signal d0_1_24: boolean;
  signal d1_1_27: boolean;
  signal sel_internal_2_1_convert: unsigned((1 - 1) downto 0);
  signal unregy_join_3_1: boolean;
begin
  sel_1_20 <= ((sel) = "1");
  d0_1_24 <= ((d0) = "1");
  d1_1_27 <= ((d1) = "1");
  sel_internal_2_1_convert <= u2u_cast(std_logic_vector_to_unsigned(boolean_to_vector(sel_1_20)), 0, 1, 0);
  proc_switch_3_1: process (d0_1_24, d1_1_27, sel_internal_2_1_convert)
  is
  begin
    case sel_internal_2_1_convert is 
      when "0" =>
        unregy_join_3_1 <= d0_1_24;
      when "1" =>
        unregy_join_3_1 <= d1_1_27;
      when others =>
        unregy_join_3_1 <= d0_1_24;
    end case;
  end process proc_switch_3_1;
  y <= boolean_to_vector(unregy_join_3_1);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity mux3_ea5f65c51b is
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
end mux3_ea5f65c51b;
architecture behavior of mux3_ea5f65c51b is
  signal sel_1_20: unsigned((4 - 1) downto 0);
  signal d0_1_24: unsigned((9 - 1) downto 0);
  signal d1_1_27: unsigned((9 - 1) downto 0);
  signal d2_1_30: unsigned((9 - 1) downto 0);
  signal d3_1_33: unsigned((9 - 1) downto 0);
  signal d4_1_36: unsigned((9 - 1) downto 0);
  signal d5_1_39: unsigned((9 - 1) downto 0);
  signal d6_1_42: unsigned((9 - 1) downto 0);
  signal d7_1_45: unsigned((9 - 1) downto 0);
  signal d8_1_48: unsigned((9 - 1) downto 0);
  signal unregy_join_3_1: unsigned((9 - 1) downto 0);
begin
  sel_1_20 <= std_logic_vector_to_unsigned(sel);
  d0_1_24 <= std_logic_vector_to_unsigned(d0);
  d1_1_27 <= std_logic_vector_to_unsigned(d1);
  d2_1_30 <= std_logic_vector_to_unsigned(d2);
  d3_1_33 <= std_logic_vector_to_unsigned(d3);
  d4_1_36 <= std_logic_vector_to_unsigned(d4);
  d5_1_39 <= std_logic_vector_to_unsigned(d5);
  d6_1_42 <= std_logic_vector_to_unsigned(d6);
  d7_1_45 <= std_logic_vector_to_unsigned(d7);
  d8_1_48 <= std_logic_vector_to_unsigned(d8);
  proc_switch_3_1: process (d0_1_24, d1_1_27, d2_1_30, d3_1_33, d4_1_36, d5_1_39, d6_1_42, d7_1_45, d8_1_48, sel_1_20)
  is
  begin
    case sel_1_20 is 
      when "0000" =>
        unregy_join_3_1 <= d0_1_24;
      when "0001" =>
        unregy_join_3_1 <= d1_1_27;
      when "0010" =>
        unregy_join_3_1 <= d2_1_30;
      when "0011" =>
        unregy_join_3_1 <= d3_1_33;
      when "0100" =>
        unregy_join_3_1 <= d4_1_36;
      when "0101" =>
        unregy_join_3_1 <= d5_1_39;
      when "0110" =>
        unregy_join_3_1 <= d6_1_42;
      when "0111" =>
        unregy_join_3_1 <= d7_1_45;
      when "1000" =>
        unregy_join_3_1 <= d8_1_48;
      when others =>
        unregy_join_3_1 <= d0_1_24;
    end case;
  end process proc_switch_3_1;
  y <= unsigned_to_std_logic_vector(unregy_join_3_1);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
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

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity relational_3a38cb06fc is
  port (
    a : in std_logic_vector((7 - 1) downto 0);
    b : in std_logic_vector((9 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end relational_3a38cb06fc;
architecture behavior of relational_3a38cb06fc is
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

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity relational1_e136eb66e8 is
  port (
    a : in std_logic_vector((4 - 1) downto 0);
    b : in std_logic_vector((4 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end relational1_e136eb66e8;
architecture behavior of relational1_e136eb66e8 is
  signal a_1_31: unsigned((4 - 1) downto 0);
  signal b_1_34: unsigned((4 - 1) downto 0);
  signal result_16_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  result_16_3_rel <= a_1_31 < b_1_34;
  op <= boolean_to_vector(result_16_3_rel);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity smwoaddr_gwin_slice_sm1_384711ac8f is
  port (
    x : in std_logic_vector((14 - 1) downto 0);
    y : out std_logic_vector((8 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end smwoaddr_gwin_slice_sm1_384711ac8f;
architecture behavior of smwoaddr_gwin_slice_sm1_384711ac8f is
  signal x_1_22: unsigned((14 - 1) downto 0);
  signal y_2_1_slice: unsigned((8 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 7, 0);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity smwodatai_gwin_force_sm1_7de1968a9b is
  port (
    input_port : in std_logic_vector((32 - 1) downto 0);
    output_port : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end smwodatai_gwin_force_sm1_7de1968a9b;
architecture behavior of smwodatai_gwin_force_sm1_7de1968a9b is
  signal input_port_1_40: unsigned((32 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
-- synopsys translate_off
library XilinxCoreLib;
-- synopsys translate_on
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.conv_pkg.all;
entity xldpram is
  generic (
    core_name0: string := "";
    c_width_a: integer := 13;
    c_address_width_a: integer := 4;
    c_width_b: integer := 13;
    c_address_width_b: integer := 4;
    c_has_sinita: integer := 0;
    c_has_sinitb: integer := 0;
    latency: integer := 1
  );
  port (
    dina: in std_logic_vector(c_width_a - 1 downto 0);
    addra: in std_logic_vector(c_address_width_a - 1 downto 0);
    wea: in std_logic_vector(0 downto 0);
    a_ce: in std_logic;
    a_clk: in std_logic;
    rsta: in std_logic_vector(0 downto 0) := (others => '0');
    ena: in std_logic_vector(0 downto 0) := (others => '1');
    douta: out std_logic_vector(c_width_a - 1 downto 0);
    dinb: in std_logic_vector(c_width_b - 1 downto 0);
    addrb: in std_logic_vector(c_address_width_b - 1 downto 0);
    web: in std_logic_vector(0 downto 0);
    b_ce: in std_logic;
    b_clk: in std_logic;
    rstb: in std_logic_vector(0 downto 0) := (others => '0');
    enb: in std_logic_vector(0 downto 0) := (others => '1');
    doutb: out std_logic_vector(c_width_b - 1 downto 0)
  );
end xldpram ;
architecture behavior of xldpram is
  component synth_reg
    generic (
      width: integer;
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

  signal core_addra: std_logic_vector(c_address_width_a - 1 downto 0);
  signal core_addrb: std_logic_vector(c_address_width_b - 1 downto 0);
  signal core_dina, core_douta, dly_douta:
    std_logic_vector(c_width_a - 1 downto 0);
  signal core_dinb, core_doutb, dly_doutb:
    std_logic_vector(c_width_b - 1 downto 0);
  signal core_wea, core_web: std_logic;
  signal core_a_ce, core_b_ce: std_logic;
  signal sinita, sinitb: std_logic;

  component dual_port_block_memory_virtex2p_6_1_299a9f537bb5a43d
    port (
        addra: in std_logic_vector(c_address_width_a - 1 downto 0);
      addrb: in std_logic_vector(c_address_width_b - 1 downto 0);
      dina: in std_logic_vector(c_width_a - 1 downto 0);
      dinb: in std_logic_vector(c_width_b - 1 downto 0);
      clka: in std_logic;
      clkb: in std_logic;
      wea: in std_logic;
      web: in std_logic;
      ena: in std_logic;
      enb: in std_logic;
      douta: out std_logic_vector(c_width_a - 1 downto 0);
      doutb: out std_logic_vector(c_width_b - 1 downto 0)
     );
  end component;
  attribute syn_black_box of dual_port_block_memory_virtex2p_6_1_299a9f537bb5a43d:
    component is true;
  attribute fpga_dont_touch of dual_port_block_memory_virtex2p_6_1_299a9f537bb5a43d:
    component is "true";
  attribute box_type of dual_port_block_memory_virtex2p_6_1_299a9f537bb5a43d:
    component  is "black_box";
  component dual_port_block_memory_virtex2p_6_1_46032f721e0f73ab
    port (
        addra: in std_logic_vector(c_address_width_a - 1 downto 0);
      addrb: in std_logic_vector(c_address_width_b - 1 downto 0);
      dina: in std_logic_vector(c_width_a - 1 downto 0);
      dinb: in std_logic_vector(c_width_b - 1 downto 0);
      clka: in std_logic;
      clkb: in std_logic;
      wea: in std_logic;
      web: in std_logic;
      ena: in std_logic;
      enb: in std_logic;
      douta: out std_logic_vector(c_width_a - 1 downto 0);
      doutb: out std_logic_vector(c_width_b - 1 downto 0)
     );
  end component;
  attribute syn_black_box of dual_port_block_memory_virtex2p_6_1_46032f721e0f73ab:
    component is true;
  attribute fpga_dont_touch of dual_port_block_memory_virtex2p_6_1_46032f721e0f73ab:
    component is "true";
  attribute box_type of dual_port_block_memory_virtex2p_6_1_46032f721e0f73ab:
    component  is "black_box";
  component dual_port_block_memory_virtex2p_6_1_a4748ac34de4a8d3
    port (
        addra: in std_logic_vector(c_address_width_a - 1 downto 0);
      addrb: in std_logic_vector(c_address_width_b - 1 downto 0);
      dina: in std_logic_vector(c_width_a - 1 downto 0);
      dinb: in std_logic_vector(c_width_b - 1 downto 0);
      clka: in std_logic;
      clkb: in std_logic;
      wea: in std_logic;
      web: in std_logic;
      ena: in std_logic;
      enb: in std_logic;
      douta: out std_logic_vector(c_width_a - 1 downto 0);
      doutb: out std_logic_vector(c_width_b - 1 downto 0)
     );
  end component;
  attribute syn_black_box of dual_port_block_memory_virtex2p_6_1_a4748ac34de4a8d3:
    component is true;
  attribute fpga_dont_touch of dual_port_block_memory_virtex2p_6_1_a4748ac34de4a8d3:
    component is "true";
  attribute box_type of dual_port_block_memory_virtex2p_6_1_a4748ac34de4a8d3:
    component  is "black_box";
begin
  core_addra <= addra;
  core_dina <= dina;
  douta <= dly_douta;
  core_wea <= wea(0);
  core_a_ce <= a_ce and ena(0);
  sinita <= rsta(0) and a_ce;

  core_addrb <= addrb;
  core_dinb <= dinb;
  doutb <= dly_doutb;
  core_web <= web(0);
  core_b_ce <= b_ce and enb(0);
  sinitb <= rstb(0) and b_ce;
  comp0: if ((core_name0 = "dual_port_block_memory_virtex2p_6_1_299a9f537bb5a43d")) generate
    core_instance0: dual_port_block_memory_virtex2p_6_1_299a9f537bb5a43d
      port map (
          addra => core_addra,
        clka => a_clk,
        addrb => core_addrb,
        clkb => b_clk,
        dina => core_dina,
        wea => core_wea,
        dinb => core_dinb,
        web => core_web,
        ena => core_a_ce,
        enb => core_b_ce,
        douta => core_douta,
        doutb => core_doutb
      );
  end generate;
  comp1: if ((core_name0 = "dual_port_block_memory_virtex2p_6_1_46032f721e0f73ab")) generate
    core_instance1: dual_port_block_memory_virtex2p_6_1_46032f721e0f73ab
      port map (
          addra => core_addra,
        clka => a_clk,
        addrb => core_addrb,
        clkb => b_clk,
        dina => core_dina,
        wea => core_wea,
        dinb => core_dinb,
        web => core_web,
        ena => core_a_ce,
        enb => core_b_ce,
        douta => core_douta,
        doutb => core_doutb
      );
  end generate;
  comp2: if ((core_name0 = "dual_port_block_memory_virtex2p_6_1_a4748ac34de4a8d3")) generate
    core_instance2: dual_port_block_memory_virtex2p_6_1_a4748ac34de4a8d3
      port map (
          addra => core_addra,
        clka => a_clk,
        addrb => core_addrb,
        clkb => b_clk,
        dina => core_dina,
        wea => core_wea,
        dinb => core_dinb,
        web => core_web,
        ena => core_a_ce,
        enb => core_b_ce,
        douta => core_douta,
        doutb => core_doutb
      );
  end generate;
  latency_test: if (latency > 2) generate
    regA: synth_reg
      generic map (
        width => c_width_a,
        latency => latency - 2
      )
      port map (
        i => core_douta,
        ce => a_ce,
        clr => '0',
        clk => a_clk,
        o => dly_douta
      );
    regB: synth_reg
      generic map (
        width => c_width_b,
        latency => latency - 2
      )
      port map (
        i => core_doutb,
        ce => b_ce,
        clr => '0',
        clk => b_clk,
        o => dly_doutb
      );
  end generate;
  latency1: if (latency <= 2) generate
    dly_douta <= core_douta;
    dly_doutb <= core_doutb;
  end generate;
end  behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice_94ce54bf1a is
  port (
    x : in std_logic_vector((7 - 1) downto 0);
    y : out std_logic_vector((6 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice_94ce54bf1a;
architecture behavior of slice_94ce54bf1a is
  signal x_1_22: unsigned((7 - 1) downto 0);
  signal y_2_1_slice: unsigned((6 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 6, 1);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice1_7895c5de63 is
  port (
    x : in std_logic_vector((7 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice1_7895c5de63;
architecture behavior of slice1_7895c5de63 is
  signal x_1_22: unsigned((7 - 1) downto 0);
  signal y_2_1_slice: unsigned((1 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 0, 0);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice2_55e27de7aa is
  port (
    x : in std_logic_vector((9 - 1) downto 0);
    y : out std_logic_vector((8 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice2_55e27de7aa;
architecture behavior of slice2_55e27de7aa is
  signal x_1_22: unsigned((9 - 1) downto 0);
  signal y_2_1_slice: unsigned((8 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 7, 0);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice3_51a5b1a945 is
  port (
    x : in std_logic_vector((9 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice3_51a5b1a945;
architecture behavior of slice3_51a5b1a945 is
  signal x_1_22: unsigned((9 - 1) downto 0);
  signal y_2_1_slice: unsigned((1 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 8, 8);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice4_62929e0fae is
  port (
    x : in std_logic_vector((15 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice4_62929e0fae;
architecture behavior of slice4_62929e0fae is
  signal x_1_22: unsigned((15 - 1) downto 0);
  signal y_2_1_slice: unsigned((1 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 14, 14);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice5_f9ac9fec53 is
  port (
    x : in std_logic_vector((16 - 1) downto 0);
    y : out std_logic_vector((9 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice5_f9ac9fec53;
architecture behavior of slice5_f9ac9fec53 is
  signal x_1_22: unsigned((16 - 1) downto 0);
  signal y_2_1_slice: unsigned((9 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 8, 0);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity inverter_db9398644a is
  port (
    ip : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end inverter_db9398644a;
architecture behavior of inverter_db9398644a is
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

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity logical_8686a497b6 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end logical_8686a497b6;
architecture behavior of logical_8686a497b6 is
  signal d0_1_24: boolean;
  signal d1_1_27: boolean;
  signal fully_2_1_bit: boolean;
begin
  d0_1_24 <= ((d0) = "1");
  d1_1_27 <= ((d1) = "1");
  fully_2_1_bit <= ((boolean_to_vector(d0_1_24) and boolean_to_vector(d1_1_27)) = "1");
  y <= boolean_to_vector(fully_2_1_bit);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity logical1_6f907bf3b7 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end logical1_6f907bf3b7;
architecture behavior of logical1_6f907bf3b7 is
  signal d0_1_24: boolean;
  signal d1_1_27: boolean;
  signal fully_2_1_bit: boolean;
begin
  d0_1_24 <= ((d0) = "1");
  d1_1_27 <= ((d1) = "1");
  fully_2_1_bit <= ((boolean_to_vector(d0_1_24) and boolean_to_vector(d1_1_27)) = "1");
  y <= boolean_to_vector(fully_2_1_bit);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity logical2_aa2c43f34f is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end logical2_aa2c43f34f;
architecture behavior of logical2_aa2c43f34f is
  signal d0_1_24: boolean;
  signal d1_1_27: boolean;
  signal fully_2_1_bit: boolean;
begin
  d0_1_24 <= ((d0) = "1");
  d1_1_27 <= ((d1) = "1");
  fully_2_1_bit <= ((boolean_to_vector(d0_1_24) and boolean_to_vector(d1_1_27)) = "1");
  y <= boolean_to_vector(fully_2_1_bit);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity logical3_f755cf1b87 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end logical3_f755cf1b87;
architecture behavior of logical3_f755cf1b87 is
  signal d0_1_24: boolean;
  signal d1_1_27: boolean;
  signal fully_2_1_bit: boolean;
begin
  d0_1_24 <= ((d0) = "1");
  d1_1_27 <= ((d1) = "1");
  fully_2_1_bit <= ((boolean_to_vector(d0_1_24) or boolean_to_vector(d1_1_27)) = "1");
  y <= boolean_to_vector(fully_2_1_bit);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity concat6_f0fb592f91 is
  port (
    in0 : in std_logic_vector((4 - 1) downto 0);
    in1 : in std_logic_vector((3 - 1) downto 0);
    y : out std_logic_vector((7 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end concat6_f0fb592f91;
architecture behavior of concat6_f0fb592f91 is
  signal in0_1_23: unsigned((4 - 1) downto 0);
  signal in1_1_27: unsigned((3 - 1) downto 0);
  signal y_2_1_concat: unsigned((7 - 1) downto 0);
begin
  in0_1_23 <= std_logic_vector_to_unsigned(in0);
  in1_1_27 <= std_logic_vector_to_unsigned(in1);
  y_2_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(in0_1_23) & unsigned_to_std_logic_vector(in1_1_27));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity constant_a436df7149 is
  port (
    op : out std_logic_vector((3 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_a436df7149;
architecture behavior of constant_a436df7149 is
begin
  op <= "000";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity constant1_6f919f6031 is
  port (
    op : out std_logic_vector((8 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant1_6f919f6031;
architecture behavior of constant1_6f919f6031 is
begin
  op <= "00000011";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity constant2_71ac01a44b is
  port (
    op : out std_logic_vector((8 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant2_71ac01a44b;
architecture behavior of constant2_71ac01a44b is
begin
  op <= "00001010";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity concat6_47774cc3b9 is
  port (
    in0 : in std_logic_vector((4 - 1) downto 0);
    in1 : in std_logic_vector((3 - 1) downto 0);
    y : out std_logic_vector((7 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end concat6_47774cc3b9;
architecture behavior of concat6_47774cc3b9 is
  signal in0_1_23: unsigned((4 - 1) downto 0);
  signal in1_1_27: unsigned((3 - 1) downto 0);
  signal y_2_1_concat: unsigned((7 - 1) downto 0);
begin
  in0_1_23 <= std_logic_vector_to_unsigned(in0);
  in1_1_27 <= std_logic_vector_to_unsigned(in1);
  y_2_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(in0_1_23) & unsigned_to_std_logic_vector(in1_1_27));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity constant_07ae879661 is
  port (
    op : out std_logic_vector((3 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_07ae879661;
architecture behavior of constant_07ae879661 is
begin
  op <= "000";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity constant1_808364abf9 is
  port (
    op : out std_logic_vector((8 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant1_808364abf9;
architecture behavior of constant1_808364abf9 is
begin
  op <= "00000011";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity constant2_6672388427 is
  port (
    op : out std_logic_vector((8 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant2_6672388427;
architecture behavior of constant2_6672388427 is
begin
  op <= "00001010";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity concat_a8a02f4a69 is
  port (
    in0 : in std_logic_vector((8 - 1) downto 0);
    in1 : in std_logic_vector((6 - 1) downto 0);
    y : out std_logic_vector((14 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end concat_a8a02f4a69;
architecture behavior of concat_a8a02f4a69 is
  signal in0_1_23: unsigned((8 - 1) downto 0);
  signal in1_1_27: unsigned((6 - 1) downto 0);
  signal y_2_1_concat: unsigned((14 - 1) downto 0);
begin
  in0_1_23 <= std_logic_vector_to_unsigned(in0);
  in1_1_27 <= std_logic_vector_to_unsigned(in1);
  y_2_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(in0_1_23) & unsigned_to_std_logic_vector(in1_1_27));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity concat1_95451795d6 is
  port (
    in0 : in std_logic_vector((4 - 1) downto 0);
    in1 : in std_logic_vector((2 - 1) downto 0);
    y : out std_logic_vector((6 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end concat1_95451795d6;
architecture behavior of concat1_95451795d6 is
  signal in0_1_23: unsigned((4 - 1) downto 0);
  signal in1_1_27: unsigned((2 - 1) downto 0);
  signal y_2_1_concat: unsigned((6 - 1) downto 0);
begin
  in0_1_23 <= std_logic_vector_to_unsigned(in0);
  in1_1_27 <= std_logic_vector_to_unsigned(in1);
  y_2_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(in0_1_23) & unsigned_to_std_logic_vector(in1_1_27));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity concat2_a1c8ba0a60 is
  port (
    in0 : in std_logic_vector((6 - 1) downto 0);
    in1 : in std_logic_vector((2 - 1) downto 0);
    y : out std_logic_vector((8 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end concat2_a1c8ba0a60;
architecture behavior of concat2_a1c8ba0a60 is
  signal in0_1_23: unsigned((6 - 1) downto 0);
  signal in1_1_27: unsigned((2 - 1) downto 0);
  signal y_2_1_concat: unsigned((8 - 1) downto 0);
begin
  in0_1_23 <= std_logic_vector_to_unsigned(in0);
  in1_1_27 <= std_logic_vector_to_unsigned(in1);
  y_2_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(in0_1_23) & unsigned_to_std_logic_vector(in1_1_27));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity concat3_f0fe542e4c is
  port (
    in0 : in std_logic_vector((1 - 1) downto 0);
    in1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((2 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end concat3_f0fe542e4c;
architecture behavior of concat3_f0fe542e4c is
  signal in0_1_23: unsigned((1 - 1) downto 0);
  signal in1_1_27: unsigned((1 - 1) downto 0);
  signal y_2_1_concat: unsigned((2 - 1) downto 0);
begin
  in0_1_23 <= std_logic_vector_to_unsigned(in0);
  in1_1_27 <= std_logic_vector_to_unsigned(in1);
  y_2_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(in0_1_23) & unsigned_to_std_logic_vector(in1_1_27));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity concat4_85eb6439b8 is
  port (
    in0 : in std_logic_vector((1 - 1) downto 0);
    in1 : in std_logic_vector((8 - 1) downto 0);
    y : out std_logic_vector((9 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end concat4_85eb6439b8;
architecture behavior of concat4_85eb6439b8 is
  signal in0_1_23: unsigned((1 - 1) downto 0);
  signal in1_1_27: unsigned((8 - 1) downto 0);
  signal y_2_1_concat: unsigned((9 - 1) downto 0);
begin
  in0_1_23 <= std_logic_vector_to_unsigned(in0);
  in1_1_27 <= std_logic_vector_to_unsigned(in1);
  y_2_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(in0_1_23) & unsigned_to_std_logic_vector(in1_1_27));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity concat5_f055439ea6 is
  port (
    in0 : in std_logic_vector((1 - 1) downto 0);
    in1 : in std_logic_vector((8 - 1) downto 0);
    y : out std_logic_vector((9 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end concat5_f055439ea6;
architecture behavior of concat5_f055439ea6 is
  signal in0_1_23: unsigned((1 - 1) downto 0);
  signal in1_1_27: unsigned((8 - 1) downto 0);
  signal y_2_1_concat: unsigned((9 - 1) downto 0);
begin
  in0_1_23 <= std_logic_vector_to_unsigned(in0);
  in1_1_27 <= std_logic_vector_to_unsigned(in1);
  y_2_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(in0_1_23) & unsigned_to_std_logic_vector(in1_1_27));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity concat6_99bafb6ad0 is
  port (
    in0 : in std_logic_vector((3 - 1) downto 0);
    in1 : in std_logic_vector((8 - 1) downto 0);
    y : out std_logic_vector((11 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end concat6_99bafb6ad0;
architecture behavior of concat6_99bafb6ad0 is
  signal in0_1_23: unsigned((3 - 1) downto 0);
  signal in1_1_27: unsigned((8 - 1) downto 0);
  signal y_2_1_concat: unsigned((11 - 1) downto 0);
begin
  in0_1_23 <= std_logic_vector_to_unsigned(in0);
  in1_1_27 <= std_logic_vector_to_unsigned(in1);
  y_2_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(in0_1_23) & unsigned_to_std_logic_vector(in1_1_27));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity constant_9690d5cc29 is
  port (
    op : out std_logic_vector((8 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_9690d5cc29;
architecture behavior of constant_9690d5cc29 is
begin
  op <= "00000000";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity constant1_78aa2f613a is
  port (
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant1_78aa2f613a;
architecture behavior of constant1_78aa2f613a is
begin
  op <= "0";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity constant10_4cc6b4dadc is
  port (
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant10_4cc6b4dadc;
architecture behavior of constant10_4cc6b4dadc is
begin
  op <= "0";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity constant2_516311e534 is
  port (
    op : out std_logic_vector((8 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant2_516311e534;
architecture behavior of constant2_516311e534 is
begin
  op <= "00000000";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity constant3_a69f46751e is
  port (
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant3_a69f46751e;
architecture behavior of constant3_a69f46751e is
begin
  op <= "0";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity constant4_b631a3cc54 is
  port (
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant4_b631a3cc54;
architecture behavior of constant4_b631a3cc54 is
begin
  op <= "0";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity constant5_f9409d3d9a is
  port (
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant5_f9409d3d9a;
architecture behavior of constant5_f9409d3d9a is
begin
  op <= "0";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity constant6_4cafadc435 is
  port (
    op : out std_logic_vector((3 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant6_4cafadc435;
architecture behavior of constant6_4cafadc435 is
begin
  op <= "000";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity constant7_9e0a2ceff8 is
  port (
    op : out std_logic_vector((3 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant7_9e0a2ceff8;
architecture behavior of constant7_9e0a2ceff8 is
begin
  op <= "100";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity constant8_9133e877a1 is
  port (
    op : out std_logic_vector((3 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant8_9133e877a1;
architecture behavior of constant8_9133e877a1 is
begin
  op <= "001";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity constant9_ed9e6bcfcf is
  port (
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant9_ed9e6bcfcf;
architecture behavior of constant9_ed9e6bcfcf is
begin
  op <= "0";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity inverter_dadc35f831 is
  port (
    ip : in std_logic_vector((2 - 1) downto 0);
    op : out std_logic_vector((2 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end inverter_dadc35f831;
architecture behavior of inverter_dadc35f831 is
  signal ip_1_26: unsigned((2 - 1) downto 0);
  type array_type_op_mem_22_20 is array (0 to (1 - 1)) of unsigned((2 - 1) downto 0);
  signal op_mem_22_20: array_type_op_mem_22_20 := (
    0 => "00");
  signal op_mem_22_20_front_din: unsigned((2 - 1) downto 0);
  signal op_mem_22_20_back: unsigned((2 - 1) downto 0);
  signal op_mem_22_20_push_front_pop_back_en: std_logic;
  signal internal_ip_12_1_bitnot: unsigned((2 - 1) downto 0);
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
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity inverter1_d753f8ff8b is
  port (
    ip : in std_logic_vector((2 - 1) downto 0);
    op : out std_logic_vector((2 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end inverter1_d753f8ff8b;
architecture behavior of inverter1_d753f8ff8b is
  signal ip_1_26: unsigned((2 - 1) downto 0);
  type array_type_op_mem_22_20 is array (0 to (1 - 1)) of unsigned((2 - 1) downto 0);
  signal op_mem_22_20: array_type_op_mem_22_20 := (
    0 => "00");
  signal op_mem_22_20_front_din: unsigned((2 - 1) downto 0);
  signal op_mem_22_20_back: unsigned((2 - 1) downto 0);
  signal op_mem_22_20_push_front_pop_back_en: std_logic;
  signal internal_ip_12_1_bitnot: unsigned((2 - 1) downto 0);
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
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity inverter2_f4b7cb1bc8 is
  port (
    ip : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end inverter2_f4b7cb1bc8;
architecture behavior of inverter2_f4b7cb1bc8 is
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

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity inverter3_581a77b0cc is
  port (
    ip : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end inverter3_581a77b0cc;
architecture behavior of inverter3_581a77b0cc is
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
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity logical_c9fa95a6ee is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end logical_c9fa95a6ee;
architecture behavior of logical_c9fa95a6ee is
  signal d0_1_24: boolean;
  signal d1_1_27: boolean;
  signal fully_2_1_bit: boolean;
begin
  d0_1_24 <= ((d0) = "1");
  d1_1_27 <= ((d1) = "1");
  fully_2_1_bit <= ((boolean_to_vector(d0_1_24) and boolean_to_vector(d1_1_27)) = "1");
  y <= boolean_to_vector(fully_2_1_bit);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity logical1_80feb6e83e is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end logical1_80feb6e83e;
architecture behavior of logical1_80feb6e83e is
  signal d0_1_24: boolean;
  signal d1_1_27: boolean;
  signal fully_2_1_bit: boolean;
begin
  d0_1_24 <= ((d0) = "1");
  d1_1_27 <= ((d1) = "1");
  fully_2_1_bit <= ((boolean_to_vector(d0_1_24) and boolean_to_vector(d1_1_27)) = "1");
  y <= boolean_to_vector(fully_2_1_bit);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity mux_cf3712e248 is
  port (
    sel : in std_logic_vector((1 - 1) downto 0);
    d0 : in std_logic_vector((6 - 1) downto 0);
    d1 : in std_logic_vector((6 - 1) downto 0);
    y : out std_logic_vector((6 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end mux_cf3712e248;
architecture behavior of mux_cf3712e248 is
  signal sel_1_20: unsigned((1 - 1) downto 0);
  signal d0_1_24: unsigned((6 - 1) downto 0);
  signal d1_1_27: unsigned((6 - 1) downto 0);
  type array_type_pipe_15_22 is array (0 to (1 - 1)) of unsigned((6 - 1) downto 0);
  signal pipe_15_22: array_type_pipe_15_22 := (
    0 => "000000");
  signal pipe_15_22_front_din: unsigned((6 - 1) downto 0);
  signal pipe_15_22_back: unsigned((6 - 1) downto 0);
  signal pipe_15_22_push_front_pop_back_en: std_logic;
  signal unregy_join_3_1: unsigned((6 - 1) downto 0);
begin
  sel_1_20 <= std_logic_vector_to_unsigned(sel);
  d0_1_24 <= std_logic_vector_to_unsigned(d0);
  d1_1_27 <= std_logic_vector_to_unsigned(d1);
  pipe_15_22_back <= pipe_15_22(0);
  proc_pipe_15_22: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (pipe_15_22_push_front_pop_back_en = '1')) then
        pipe_15_22(0) <= pipe_15_22_front_din;
      end if;
    end if;
  end process proc_pipe_15_22;
  proc_switch_3_1: process (d0_1_24, d1_1_27, sel_1_20)
  is
  begin
    case sel_1_20 is 
      when "0" =>
        unregy_join_3_1 <= d0_1_24;
      when "1" =>
        unregy_join_3_1 <= d1_1_27;
      when others =>
        unregy_join_3_1 <= d0_1_24;
    end case;
  end process proc_switch_3_1;
  pipe_15_22_front_din <= unregy_join_3_1;
  pipe_15_22_push_front_pop_back_en <= '1';
  y <= unsigned_to_std_logic_vector(pipe_15_22_back);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity mux1_27f053850a is
  port (
    sel : in std_logic_vector((1 - 1) downto 0);
    d0 : in std_logic_vector((8 - 1) downto 0);
    d1 : in std_logic_vector((8 - 1) downto 0);
    y : out std_logic_vector((8 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end mux1_27f053850a;
architecture behavior of mux1_27f053850a is
  signal sel_1_20: unsigned((1 - 1) downto 0);
  signal d0_1_24: unsigned((8 - 1) downto 0);
  signal d1_1_27: unsigned((8 - 1) downto 0);
  signal unregy_join_3_1: unsigned((8 - 1) downto 0);
begin
  sel_1_20 <= std_logic_vector_to_unsigned(sel);
  d0_1_24 <= std_logic_vector_to_unsigned(d0);
  d1_1_27 <= std_logic_vector_to_unsigned(d1);
  proc_switch_3_1: process (d0_1_24, d1_1_27, sel_1_20)
  is
  begin
    case sel_1_20 is 
      when "0" =>
        unregy_join_3_1 <= d0_1_24;
      when "1" =>
        unregy_join_3_1 <= d1_1_27;
      when others =>
        unregy_join_3_1 <= d0_1_24;
    end case;
  end process proc_switch_3_1;
  y <= unsigned_to_std_logic_vector(unregy_join_3_1);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity mux2_0966eeec41 is
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
end mux2_0966eeec41;
architecture behavior of mux2_0966eeec41 is
  signal sel_1_20: unsigned((2 - 1) downto 0);
  signal d0_1_24: unsigned((3 - 1) downto 0);
  signal d1_1_27: unsigned((3 - 1) downto 0);
  signal d2_1_30: unsigned((3 - 1) downto 0);
  signal d3_1_33: unsigned((3 - 1) downto 0);
  signal unregy_join_3_1: unsigned((3 - 1) downto 0);
begin
  sel_1_20 <= std_logic_vector_to_unsigned(sel);
  d0_1_24 <= std_logic_vector_to_unsigned(d0);
  d1_1_27 <= std_logic_vector_to_unsigned(d1);
  d2_1_30 <= std_logic_vector_to_unsigned(d2);
  d3_1_33 <= std_logic_vector_to_unsigned(d3);
  proc_switch_3_1: process (d0_1_24, d1_1_27, d2_1_30, d3_1_33, sel_1_20)
  is
  begin
    case sel_1_20 is 
      when "00" =>
        unregy_join_3_1 <= d0_1_24;
      when "01" =>
        unregy_join_3_1 <= d1_1_27;
      when "10" =>
        unregy_join_3_1 <= d2_1_30;
      when "11" =>
        unregy_join_3_1 <= d3_1_33;
      when others =>
        unregy_join_3_1 <= d0_1_24;
    end case;
  end process proc_switch_3_1;
  y <= unsigned_to_std_logic_vector(unregy_join_3_1);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity mux3_154f8a8ba6 is
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
end mux3_154f8a8ba6;
architecture behavior of mux3_154f8a8ba6 is
  signal sel_1_20: unsigned((3 - 1) downto 0);
  signal d0_1_24: unsigned((9 - 1) downto 0);
  signal d1_1_27: unsigned((9 - 1) downto 0);
  signal d2_1_30: unsigned((9 - 1) downto 0);
  signal d3_1_33: unsigned((9 - 1) downto 0);
  signal d4_1_36: unsigned((9 - 1) downto 0);
  signal d5_1_39: unsigned((9 - 1) downto 0);
  signal d6_1_42: unsigned((9 - 1) downto 0);
  signal d7_1_45: unsigned((9 - 1) downto 0);
  signal unregy_join_3_1: unsigned((9 - 1) downto 0);
begin
  sel_1_20 <= std_logic_vector_to_unsigned(sel);
  d0_1_24 <= std_logic_vector_to_unsigned(d0);
  d1_1_27 <= std_logic_vector_to_unsigned(d1);
  d2_1_30 <= std_logic_vector_to_unsigned(d2);
  d3_1_33 <= std_logic_vector_to_unsigned(d3);
  d4_1_36 <= std_logic_vector_to_unsigned(d4);
  d5_1_39 <= std_logic_vector_to_unsigned(d5);
  d6_1_42 <= std_logic_vector_to_unsigned(d6);
  d7_1_45 <= std_logic_vector_to_unsigned(d7);
  proc_switch_3_1: process (d0_1_24, d1_1_27, d2_1_30, d3_1_33, d4_1_36, d5_1_39, d6_1_42, d7_1_45, sel_1_20)
  is
  begin
    case sel_1_20 is 
      when "000" =>
        unregy_join_3_1 <= d0_1_24;
      when "001" =>
        unregy_join_3_1 <= d1_1_27;
      when "010" =>
        unregy_join_3_1 <= d2_1_30;
      when "011" =>
        unregy_join_3_1 <= d3_1_33;
      when "100" =>
        unregy_join_3_1 <= d4_1_36;
      when "101" =>
        unregy_join_3_1 <= d5_1_39;
      when "110" =>
        unregy_join_3_1 <= d6_1_42;
      when "111" =>
        unregy_join_3_1 <= d7_1_45;
      when others =>
        unregy_join_3_1 <= d0_1_24;
    end case;
  end process proc_switch_3_1;
  y <= unsigned_to_std_logic_vector(unregy_join_3_1);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity relational_da8953c20e is
  port (
    a : in std_logic_vector((6 - 1) downto 0);
    b : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end relational_da8953c20e;
architecture behavior of relational_da8953c20e is
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

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity relational1_cb43fc6412 is
  port (
    a : in std_logic_vector((4 - 1) downto 0);
    b : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end relational1_cb43fc6412;
architecture behavior of relational1_cb43fc6412 is
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

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity relational2_bb0fa497d9 is
  port (
    a : in std_logic_vector((3 - 1) downto 0);
    b : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end relational2_bb0fa497d9;
architecture behavior of relational2_bb0fa497d9 is
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

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity smwoaddr_gwin1_slice_sm3_17d56a725c is
  port (
    x : in std_logic_vector((14 - 1) downto 0);
    y : out std_logic_vector((9 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end smwoaddr_gwin1_slice_sm3_17d56a725c;
architecture behavior of smwoaddr_gwin1_slice_sm3_17d56a725c is
  signal x_1_22: unsigned((14 - 1) downto 0);
  signal y_2_1_slice: unsigned((9 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 8, 0);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity smwoaddr_gwin_slice_sm2_346764b442 is
  port (
    x : in std_logic_vector((14 - 1) downto 0);
    y : out std_logic_vector((12 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end smwoaddr_gwin_slice_sm2_346764b442;
architecture behavior of smwoaddr_gwin_slice_sm2_346764b442 is
  signal x_1_22: unsigned((14 - 1) downto 0);
  signal y_2_1_slice: unsigned((12 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 11, 0);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity smwodatai_gwin1_force_sm3_79aa7db2fc is
  port (
    input_port : in std_logic_vector((32 - 1) downto 0);
    output_port : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end smwodatai_gwin1_force_sm3_79aa7db2fc;
architecture behavior of smwodatai_gwin1_force_sm3_79aa7db2fc is
  signal input_port_1_40: unsigned((32 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity smwodatai_gwin_force_sm2_e3a2563eaa is
  port (
    input_port : in std_logic_vector((32 - 1) downto 0);
    output_port : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end smwodatai_gwin_force_sm2_e3a2563eaa;
architecture behavior of smwodatai_gwin_force_sm2_e3a2563eaa is
  signal input_port_1_40: unsigned((32 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice_02e16f9a36 is
  port (
    x : in std_logic_vector((6 - 1) downto 0);
    y : out std_logic_vector((4 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice_02e16f9a36;
architecture behavior of slice_02e16f9a36 is
  signal x_1_22: unsigned((6 - 1) downto 0);
  signal y_2_1_slice: unsigned((4 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 5, 2);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice1_fc50c97c90 is
  port (
    x : in std_logic_vector((6 - 1) downto 0);
    y : out std_logic_vector((2 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice1_fc50c97c90;
architecture behavior of slice1_fc50c97c90 is
  signal x_1_22: unsigned((6 - 1) downto 0);
  signal y_2_1_slice: unsigned((2 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 1, 0);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice10_38adbb4dd2 is
  port (
    x : in std_logic_vector((14 - 1) downto 0);
    y : out std_logic_vector((4 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice10_38adbb4dd2;
architecture behavior of slice10_38adbb4dd2 is
  signal x_1_22: unsigned((14 - 1) downto 0);
  signal y_2_1_slice: unsigned((4 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 13, 10);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice11_6a9141b419 is
  port (
    x : in std_logic_vector((14 - 1) downto 0);
    y : out std_logic_vector((4 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice11_6a9141b419;
architecture behavior of slice11_6a9141b419 is
  signal x_1_22: unsigned((14 - 1) downto 0);
  signal y_2_1_slice: unsigned((4 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 9, 6);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice2_e306e72c5d is
  port (
    x : in std_logic_vector((8 - 1) downto 0);
    y : out std_logic_vector((6 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice2_e306e72c5d;
architecture behavior of slice2_e306e72c5d is
  signal x_1_22: unsigned((8 - 1) downto 0);
  signal y_2_1_slice: unsigned((6 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 7, 2);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice3_8ef56893c7 is
  port (
    x : in std_logic_vector((8 - 1) downto 0);
    y : out std_logic_vector((2 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice3_8ef56893c7;
architecture behavior of slice3_8ef56893c7 is
  signal x_1_22: unsigned((8 - 1) downto 0);
  signal y_2_1_slice: unsigned((2 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 1, 0);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice4_9967cd13bb is
  port (
    x : in std_logic_vector((14 - 1) downto 0);
    y : out std_logic_vector((8 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice4_9967cd13bb;
architecture behavior of slice4_9967cd13bb is
  signal x_1_22: unsigned((14 - 1) downto 0);
  signal y_2_1_slice: unsigned((8 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 13, 6);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice5_01d24d19d6 is
  port (
    x : in std_logic_vector((14 - 1) downto 0);
    y : out std_logic_vector((6 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice5_01d24d19d6;
architecture behavior of slice5_01d24d19d6 is
  signal x_1_22: unsigned((14 - 1) downto 0);
  signal y_2_1_slice: unsigned((6 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 5, 0);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice6_a810be6e87 is
  port (
    x : in std_logic_vector((14 - 1) downto 0);
    y : out std_logic_vector((6 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice6_a810be6e87;
architecture behavior of slice6_a810be6e87 is
  signal x_1_22: unsigned((14 - 1) downto 0);
  signal y_2_1_slice: unsigned((6 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 5, 0);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice7_c11cac2c76 is
  port (
    x : in std_logic_vector((14 - 1) downto 0);
    y : out std_logic_vector((4 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice7_c11cac2c76;
architecture behavior of slice7_c11cac2c76 is
  signal x_1_22: unsigned((14 - 1) downto 0);
  signal y_2_1_slice: unsigned((4 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 9, 6);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice8_57a08caed2 is
  port (
    x : in std_logic_vector((9 - 1) downto 0);
    y : out std_logic_vector((8 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice8_57a08caed2;
architecture behavior of slice8_57a08caed2 is
  signal x_1_22: unsigned((9 - 1) downto 0);
  signal y_2_1_slice: unsigned((8 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 7, 0);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice9_77924db8fb is
  port (
    x : in std_logic_vector((9 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice9_77924db8fb;
architecture behavior of slice9_77924db8fb is
  signal x_1_22: unsigned((9 - 1) downto 0);
  signal y_2_1_slice: unsigned((1 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 8, 8);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity inverter1_2cc220ed9f is
  port (
    ip : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end inverter1_2cc220ed9f;
architecture behavior of inverter1_2cc220ed9f is
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

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity inverter2_ea511efb71 is
  port (
    ip : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end inverter2_ea511efb71;
architecture behavior of inverter2_ea511efb71 is
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

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity logical_bc2e3d9aab is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    d2 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end logical_bc2e3d9aab;
architecture behavior of logical_bc2e3d9aab is
  signal d0_1_24: boolean;
  signal d1_1_27: boolean;
  signal d2_1_30: boolean;
  signal fully_2_1_bit: boolean;
begin
  d0_1_24 <= ((d0) = "1");
  d1_1_27 <= ((d1) = "1");
  d2_1_30 <= ((d2) = "1");
  fully_2_1_bit <= ((boolean_to_vector(d0_1_24) and boolean_to_vector(d1_1_27) and boolean_to_vector(d2_1_30)) = "1");
  y <= boolean_to_vector(fully_2_1_bit);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity addrslice_0020d95084 is
  port (
    x : in std_logic_vector((32 - 1) downto 0);
    y : out std_logic_vector((14 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end addrslice_0020d95084;
architecture behavior of addrslice_0020d95084 is
  signal x_1_22: unsigned((32 - 1) downto 0);
  signal y_2_1_slice: unsigned((14 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 15, 2);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity bankselect_slice_77f112ed2c is
  port (
    x : in std_logic_vector((32 - 1) downto 0);
    y : out std_logic_vector((4 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end bankselect_slice_77f112ed2c;
architecture behavior of bankselect_slice_77f112ed2c is
  signal x_1_22: unsigned((32 - 1) downto 0);
  signal y_2_1_slice: unsigned((4 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 19, 16);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity baseaddress_const_bbb19a4f50 is
  port (
    op : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end baseaddress_const_bbb19a4f50;
architecture behavior of baseaddress_const_bbb19a4f50 is
begin
  op <= "00000000000000000000000000000000";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity baseaddress_slice_845736abc9 is
  port (
    x : in std_logic_vector((32 - 1) downto 0);
    y : out std_logic_vector((4 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end baseaddress_slice_845736abc9;
architecture behavior of baseaddress_slice_845736abc9 is
  signal x_1_22: unsigned((32 - 1) downto 0);
  signal y_2_1_slice: unsigned((4 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 19, 16);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity concat_6c365eb6a2 is
  port (
    in0 : in std_logic_vector((1 - 1) downto 0);
    in1 : in std_logic_vector((1 - 1) downto 0);
    in2 : in std_logic_vector((5 - 1) downto 0);
    y : out std_logic_vector((7 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end concat_6c365eb6a2;
architecture behavior of concat_6c365eb6a2 is
  signal in0_1_23: boolean;
  signal in1_1_27: boolean;
  signal in2_1_31: unsigned((5 - 1) downto 0);
  signal y_2_1_concat: unsigned((7 - 1) downto 0);
begin
  in0_1_23 <= ((in0) = "1");
  in1_1_27 <= ((in1) = "1");
  in2_1_31 <= std_logic_vector_to_unsigned(in2);
  y_2_1_concat <= std_logic_vector_to_unsigned(boolean_to_vector(in0_1_23) & boolean_to_vector(in1_1_27) & unsigned_to_std_logic_vector(in2_1_31));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice_df251b1ebb is
  port (
    x : in std_logic_vector((32 - 1) downto 0);
    y : out std_logic_vector((5 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice_df251b1ebb;
architecture behavior of slice_df251b1ebb is
  signal x_1_22: unsigned((32 - 1) downto 0);
  signal y_2_1_slice: unsigned((5 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 6, 2);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_const_0_08dfa33fe9 is
  port (
    op : out std_logic_vector((7 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_const_0_08dfa33fe9;
architecture behavior of write_const_0_08dfa33fe9 is
begin
  op <= "1000000";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_const_1_e8f7e1b380 is
  port (
    op : out std_logic_vector((7 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_const_1_e8f7e1b380;
architecture behavior of write_const_1_e8f7e1b380 is
begin
  op <= "1000001";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_const_10_8ad7c685c5 is
  port (
    op : out std_logic_vector((7 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_const_10_8ad7c685c5;
architecture behavior of write_const_10_8ad7c685c5 is
begin
  op <= "1001010";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_const_11_5fd7cddf89 is
  port (
    op : out std_logic_vector((7 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_const_11_5fd7cddf89;
architecture behavior of write_const_11_5fd7cddf89 is
begin
  op <= "1001011";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_const_12_2accb79d1c is
  port (
    op : out std_logic_vector((7 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_const_12_2accb79d1c;
architecture behavior of write_const_12_2accb79d1c is
begin
  op <= "1001100";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_const_13_d2d229197b is
  port (
    op : out std_logic_vector((7 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_const_13_d2d229197b;
architecture behavior of write_const_13_d2d229197b is
begin
  op <= "1001101";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_const_14_6b5eb26751 is
  port (
    op : out std_logic_vector((7 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_const_14_6b5eb26751;
architecture behavior of write_const_14_6b5eb26751 is
begin
  op <= "1001110";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_const_15_47c2c6143f is
  port (
    op : out std_logic_vector((7 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_const_15_47c2c6143f;
architecture behavior of write_const_15_47c2c6143f is
begin
  op <= "1001111";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_const_16_96a078b18d is
  port (
    op : out std_logic_vector((7 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_const_16_96a078b18d;
architecture behavior of write_const_16_96a078b18d is
begin
  op <= "1010000";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_const_2_a947acd322 is
  port (
    op : out std_logic_vector((7 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_const_2_a947acd322;
architecture behavior of write_const_2_a947acd322 is
begin
  op <= "1000010";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_const_3_2bd5e75e16 is
  port (
    op : out std_logic_vector((7 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_const_3_2bd5e75e16;
architecture behavior of write_const_3_2bd5e75e16 is
begin
  op <= "1000011";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_const_4_ca1c456b45 is
  port (
    op : out std_logic_vector((7 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_const_4_ca1c456b45;
architecture behavior of write_const_4_ca1c456b45 is
begin
  op <= "1000100";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_const_5_2439e286c1 is
  port (
    op : out std_logic_vector((7 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_const_5_2439e286c1;
architecture behavior of write_const_5_2439e286c1 is
begin
  op <= "1000101";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_const_6_a2d98339b4 is
  port (
    op : out std_logic_vector((7 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_const_6_a2d98339b4;
architecture behavior of write_const_6_a2d98339b4 is
begin
  op <= "1000110";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_const_7_6281aea655 is
  port (
    op : out std_logic_vector((7 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_const_7_6281aea655;
architecture behavior of write_const_7_6281aea655 is
begin
  op <= "1000111";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_const_8_7e68c4aa0c is
  port (
    op : out std_logic_vector((7 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_const_8_7e68c4aa0c;
architecture behavior of write_const_8_7e68c4aa0c is
begin
  op <= "1001000";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_const_9_8b38b8c100 is
  port (
    op : out std_logic_vector((7 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_const_9_8b38b8c100;
architecture behavior of write_const_9_8b38b8c100 is
begin
  op <= "1001001";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_rel_0_8a527de935 is
  port (
    a : in std_logic_vector((7 - 1) downto 0);
    b : in std_logic_vector((7 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_rel_0_8a527de935;
architecture behavior of write_rel_0_8a527de935 is
  signal a_1_31: unsigned((7 - 1) downto 0);
  signal b_1_34: unsigned((7 - 1) downto 0);
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  result_12_3_rel <= a_1_31 = b_1_34;
  op <= boolean_to_vector(result_12_3_rel);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_rel_1_bbac354172 is
  port (
    a : in std_logic_vector((7 - 1) downto 0);
    b : in std_logic_vector((7 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_rel_1_bbac354172;
architecture behavior of write_rel_1_bbac354172 is
  signal a_1_31: unsigned((7 - 1) downto 0);
  signal b_1_34: unsigned((7 - 1) downto 0);
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  result_12_3_rel <= a_1_31 = b_1_34;
  op <= boolean_to_vector(result_12_3_rel);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_rel_10_c02387f564 is
  port (
    a : in std_logic_vector((7 - 1) downto 0);
    b : in std_logic_vector((7 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_rel_10_c02387f564;
architecture behavior of write_rel_10_c02387f564 is
  signal a_1_31: unsigned((7 - 1) downto 0);
  signal b_1_34: unsigned((7 - 1) downto 0);
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  result_12_3_rel <= a_1_31 = b_1_34;
  op <= boolean_to_vector(result_12_3_rel);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_rel_11_3a5922fcfa is
  port (
    a : in std_logic_vector((7 - 1) downto 0);
    b : in std_logic_vector((7 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_rel_11_3a5922fcfa;
architecture behavior of write_rel_11_3a5922fcfa is
  signal a_1_31: unsigned((7 - 1) downto 0);
  signal b_1_34: unsigned((7 - 1) downto 0);
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  result_12_3_rel <= a_1_31 = b_1_34;
  op <= boolean_to_vector(result_12_3_rel);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_rel_12_e9399fd5cb is
  port (
    a : in std_logic_vector((7 - 1) downto 0);
    b : in std_logic_vector((7 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_rel_12_e9399fd5cb;
architecture behavior of write_rel_12_e9399fd5cb is
  signal a_1_31: unsigned((7 - 1) downto 0);
  signal b_1_34: unsigned((7 - 1) downto 0);
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  result_12_3_rel <= a_1_31 = b_1_34;
  op <= boolean_to_vector(result_12_3_rel);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_rel_13_8425508f2c is
  port (
    a : in std_logic_vector((7 - 1) downto 0);
    b : in std_logic_vector((7 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_rel_13_8425508f2c;
architecture behavior of write_rel_13_8425508f2c is
  signal a_1_31: unsigned((7 - 1) downto 0);
  signal b_1_34: unsigned((7 - 1) downto 0);
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  result_12_3_rel <= a_1_31 = b_1_34;
  op <= boolean_to_vector(result_12_3_rel);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_rel_14_41383d23c9 is
  port (
    a : in std_logic_vector((7 - 1) downto 0);
    b : in std_logic_vector((7 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_rel_14_41383d23c9;
architecture behavior of write_rel_14_41383d23c9 is
  signal a_1_31: unsigned((7 - 1) downto 0);
  signal b_1_34: unsigned((7 - 1) downto 0);
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  result_12_3_rel <= a_1_31 = b_1_34;
  op <= boolean_to_vector(result_12_3_rel);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_rel_15_a5e8beac76 is
  port (
    a : in std_logic_vector((7 - 1) downto 0);
    b : in std_logic_vector((7 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_rel_15_a5e8beac76;
architecture behavior of write_rel_15_a5e8beac76 is
  signal a_1_31: unsigned((7 - 1) downto 0);
  signal b_1_34: unsigned((7 - 1) downto 0);
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  result_12_3_rel <= a_1_31 = b_1_34;
  op <= boolean_to_vector(result_12_3_rel);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_rel_16_61da6987ae is
  port (
    a : in std_logic_vector((7 - 1) downto 0);
    b : in std_logic_vector((7 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_rel_16_61da6987ae;
architecture behavior of write_rel_16_61da6987ae is
  signal a_1_31: unsigned((7 - 1) downto 0);
  signal b_1_34: unsigned((7 - 1) downto 0);
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  result_12_3_rel <= a_1_31 = b_1_34;
  op <= boolean_to_vector(result_12_3_rel);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_rel_2_80b9d47c54 is
  port (
    a : in std_logic_vector((7 - 1) downto 0);
    b : in std_logic_vector((7 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_rel_2_80b9d47c54;
architecture behavior of write_rel_2_80b9d47c54 is
  signal a_1_31: unsigned((7 - 1) downto 0);
  signal b_1_34: unsigned((7 - 1) downto 0);
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  result_12_3_rel <= a_1_31 = b_1_34;
  op <= boolean_to_vector(result_12_3_rel);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_rel_3_42fb2943d7 is
  port (
    a : in std_logic_vector((7 - 1) downto 0);
    b : in std_logic_vector((7 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_rel_3_42fb2943d7;
architecture behavior of write_rel_3_42fb2943d7 is
  signal a_1_31: unsigned((7 - 1) downto 0);
  signal b_1_34: unsigned((7 - 1) downto 0);
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  result_12_3_rel <= a_1_31 = b_1_34;
  op <= boolean_to_vector(result_12_3_rel);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_rel_4_f1b932d94c is
  port (
    a : in std_logic_vector((7 - 1) downto 0);
    b : in std_logic_vector((7 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_rel_4_f1b932d94c;
architecture behavior of write_rel_4_f1b932d94c is
  signal a_1_31: unsigned((7 - 1) downto 0);
  signal b_1_34: unsigned((7 - 1) downto 0);
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  result_12_3_rel <= a_1_31 = b_1_34;
  op <= boolean_to_vector(result_12_3_rel);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_rel_5_6f8091ca25 is
  port (
    a : in std_logic_vector((7 - 1) downto 0);
    b : in std_logic_vector((7 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_rel_5_6f8091ca25;
architecture behavior of write_rel_5_6f8091ca25 is
  signal a_1_31: unsigned((7 - 1) downto 0);
  signal b_1_34: unsigned((7 - 1) downto 0);
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  result_12_3_rel <= a_1_31 = b_1_34;
  op <= boolean_to_vector(result_12_3_rel);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_rel_6_e76a28131a is
  port (
    a : in std_logic_vector((7 - 1) downto 0);
    b : in std_logic_vector((7 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_rel_6_e76a28131a;
architecture behavior of write_rel_6_e76a28131a is
  signal a_1_31: unsigned((7 - 1) downto 0);
  signal b_1_34: unsigned((7 - 1) downto 0);
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  result_12_3_rel <= a_1_31 = b_1_34;
  op <= boolean_to_vector(result_12_3_rel);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_rel_7_910671a9c8 is
  port (
    a : in std_logic_vector((7 - 1) downto 0);
    b : in std_logic_vector((7 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_rel_7_910671a9c8;
architecture behavior of write_rel_7_910671a9c8 is
  signal a_1_31: unsigned((7 - 1) downto 0);
  signal b_1_34: unsigned((7 - 1) downto 0);
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  result_12_3_rel <= a_1_31 = b_1_34;
  op <= boolean_to_vector(result_12_3_rel);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_rel_8_f620d9bba5 is
  port (
    a : in std_logic_vector((7 - 1) downto 0);
    b : in std_logic_vector((7 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_rel_8_f620d9bba5;
architecture behavior of write_rel_8_f620d9bba5 is
  signal a_1_31: unsigned((7 - 1) downto 0);
  signal b_1_34: unsigned((7 - 1) downto 0);
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  result_12_3_rel <= a_1_31 = b_1_34;
  op <= boolean_to_vector(result_12_3_rel);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity write_rel_9_18386daa95 is
  port (
    a : in std_logic_vector((7 - 1) downto 0);
    b : in std_logic_vector((7 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end write_rel_9_18386daa95;
architecture behavior of write_rel_9_18386daa95 is
  signal a_1_31: unsigned((7 - 1) downto 0);
  signal b_1_34: unsigned((7 - 1) downto 0);
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  result_12_3_rel <= a_1_31 = b_1_34;
  op <= boolean_to_vector(result_12_3_rel);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity addr_const_0_f0995ffa21 is
  port (
    op : out std_logic_vector((4 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end addr_const_0_f0995ffa21;
architecture behavior of addr_const_0_f0995ffa21 is
begin
  op <= "0000";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity addr_const_1_8f22611e87 is
  port (
    op : out std_logic_vector((4 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end addr_const_1_8f22611e87;
architecture behavior of addr_const_1_8f22611e87 is
begin
  op <= "0001";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity addr_const_2_3f26cdcc25 is
  port (
    op : out std_logic_vector((4 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end addr_const_2_3f26cdcc25;
architecture behavior of addr_const_2_3f26cdcc25 is
begin
  op <= "0010";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity addr_const_3_45e48d0cb9 is
  port (
    op : out std_logic_vector((4 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end addr_const_3_45e48d0cb9;
architecture behavior of addr_const_3_45e48d0cb9 is
begin
  op <= "0011";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity addr_rel_0_056746e125 is
  port (
    a : in std_logic_vector((4 - 1) downto 0);
    b : in std_logic_vector((4 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end addr_rel_0_056746e125;
architecture behavior of addr_rel_0_056746e125 is
  signal a_1_31: unsigned((4 - 1) downto 0);
  signal b_1_34: unsigned((4 - 1) downto 0);
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  result_12_3_rel <= a_1_31 = b_1_34;
  op <= boolean_to_vector(result_12_3_rel);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity addr_rel_1_df4882c7b1 is
  port (
    a : in std_logic_vector((4 - 1) downto 0);
    b : in std_logic_vector((4 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end addr_rel_1_df4882c7b1;
architecture behavior of addr_rel_1_df4882c7b1 is
  signal a_1_31: unsigned((4 - 1) downto 0);
  signal b_1_34: unsigned((4 - 1) downto 0);
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  result_12_3_rel <= a_1_31 = b_1_34;
  op <= boolean_to_vector(result_12_3_rel);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity addr_rel_2_73df01b747 is
  port (
    a : in std_logic_vector((4 - 1) downto 0);
    b : in std_logic_vector((4 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end addr_rel_2_73df01b747;
architecture behavior of addr_rel_2_73df01b747 is
  signal a_1_31: unsigned((4 - 1) downto 0);
  signal b_1_34: unsigned((4 - 1) downto 0);
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  result_12_3_rel <= a_1_31 = b_1_34;
  op <= boolean_to_vector(result_12_3_rel);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity addr_rel_3_4a4da643df is
  port (
    a : in std_logic_vector((4 - 1) downto 0);
    b : in std_logic_vector((4 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end addr_rel_3_4a4da643df;
architecture behavior of addr_rel_3_4a4da643df is
  signal a_1_31: unsigned((4 - 1) downto 0);
  signal b_1_34: unsigned((4 - 1) downto 0);
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  result_12_3_rel <= a_1_31 = b_1_34;
  op <= boolean_to_vector(result_12_3_rel);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity and_sm_1_51a93160a7 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    d2 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end and_sm_1_51a93160a7;
architecture behavior of and_sm_1_51a93160a7 is
  signal d0_1_24: boolean;
  signal d1_1_27: boolean;
  signal d2_1_30: boolean;
  signal fully_2_1_bit: boolean;
begin
  d0_1_24 <= ((d0) = "1");
  d1_1_27 <= ((d1) = "1");
  d2_1_30 <= ((d2) = "1");
  fully_2_1_bit <= ((boolean_to_vector(d0_1_24) and boolean_to_vector(d1_1_27) and boolean_to_vector(d2_1_30)) = "1");
  y <= boolean_to_vector(fully_2_1_bit);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity and_sm_2_66665a2381 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    d2 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end and_sm_2_66665a2381;
architecture behavior of and_sm_2_66665a2381 is
  signal d0_1_24: boolean;
  signal d1_1_27: boolean;
  signal d2_1_30: boolean;
  signal fully_2_1_bit: boolean;
begin
  d0_1_24 <= ((d0) = "1");
  d1_1_27 <= ((d1) = "1");
  d2_1_30 <= ((d2) = "1");
  fully_2_1_bit <= ((boolean_to_vector(d0_1_24) and boolean_to_vector(d1_1_27) and boolean_to_vector(d2_1_30)) = "1");
  y <= boolean_to_vector(fully_2_1_bit);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity and_sm_3_0e8be78342 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    d2 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end and_sm_3_0e8be78342;
architecture behavior of and_sm_3_0e8be78342 is
  signal d0_1_24: boolean;
  signal d1_1_27: boolean;
  signal d2_1_30: boolean;
  signal fully_2_1_bit: boolean;
begin
  d0_1_24 <= ((d0) = "1");
  d1_1_27 <= ((d1) = "1");
  d2_1_30 <= ((d2) = "1");
  fully_2_1_bit <= ((boolean_to_vector(d0_1_24) and boolean_to_vector(d1_1_27) and boolean_to_vector(d2_1_30)) = "1");
  y <= boolean_to_vector(fully_2_1_bit);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity not_sm_1_2571507f0e is
  port (
    ip : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end not_sm_1_2571507f0e;
architecture behavior of not_sm_1_2571507f0e is
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

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity not_sm_2_71cbc2c5db is
  port (
    ip : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end not_sm_2_71cbc2c5db;
architecture behavior of not_sm_2_71cbc2c5db is
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

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity not_sm_3_8528bb8de3 is
  port (
    ip : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end not_sm_3_8528bb8de3;
architecture behavior of not_sm_3_8528bb8de3 is
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

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity not_reg_bcbed8dfd2 is
  port (
    ip : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end not_reg_bcbed8dfd2;
architecture behavior of not_reg_bcbed8dfd2 is
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

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity or_f2c44fd675 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end or_f2c44fd675;
architecture behavior of or_f2c44fd675 is
  signal d0_1_24: boolean;
  signal d1_1_27: boolean;
  signal fully_2_1_bit: boolean;
begin
  d0_1_24 <= ((d0) = "1");
  d1_1_27 <= ((d1) = "1");
  fully_2_1_bit <= ((boolean_to_vector(d0_1_24) or boolean_to_vector(d1_1_27)) = "1");
  y <= boolean_to_vector(fully_2_1_bit);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity reinterpret_0_30d8822341 is
  port (
    input_port : in std_logic_vector((32 - 1) downto 0);
    output_port : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end reinterpret_0_30d8822341;
architecture behavior of reinterpret_0_30d8822341 is
  signal input_port_1_40: unsigned((32 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity reinterpret_1_2637d80113 is
  port (
    input_port : in std_logic_vector((32 - 1) downto 0);
    output_port : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end reinterpret_1_2637d80113;
architecture behavior of reinterpret_1_2637d80113 is
  signal input_port_1_40: unsigned((32 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity reinterpret_10_dc5a913a14 is
  port (
    input_port : in std_logic_vector((32 - 1) downto 0);
    output_port : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end reinterpret_10_dc5a913a14;
architecture behavior of reinterpret_10_dc5a913a14 is
  signal input_port_1_40: unsigned((32 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity reinterpret_11_18d5986613 is
  port (
    input_port : in std_logic_vector((32 - 1) downto 0);
    output_port : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end reinterpret_11_18d5986613;
architecture behavior of reinterpret_11_18d5986613 is
  signal input_port_1_40: unsigned((32 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity reinterpret_12_d8cb68aff2 is
  port (
    input_port : in std_logic_vector((32 - 1) downto 0);
    output_port : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end reinterpret_12_d8cb68aff2;
architecture behavior of reinterpret_12_d8cb68aff2 is
  signal input_port_1_40: unsigned((32 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity reinterpret_13_da2f3dfcfb is
  port (
    input_port : in std_logic_vector((32 - 1) downto 0);
    output_port : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end reinterpret_13_da2f3dfcfb;
architecture behavior of reinterpret_13_da2f3dfcfb is
  signal input_port_1_40: unsigned((32 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity reinterpret_14_dc5e0e152e is
  port (
    input_port : in std_logic_vector((32 - 1) downto 0);
    output_port : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end reinterpret_14_dc5e0e152e;
architecture behavior of reinterpret_14_dc5e0e152e is
  signal input_port_1_40: unsigned((32 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity reinterpret_15_7a04276d04 is
  port (
    input_port : in std_logic_vector((32 - 1) downto 0);
    output_port : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end reinterpret_15_7a04276d04;
architecture behavior of reinterpret_15_7a04276d04 is
  signal input_port_1_40: unsigned((32 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity reinterpret_16_be1d93be75 is
  port (
    input_port : in std_logic_vector((32 - 1) downto 0);
    output_port : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end reinterpret_16_be1d93be75;
architecture behavior of reinterpret_16_be1d93be75 is
  signal input_port_1_40: unsigned((32 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity reinterpret_2_86b6c897b3 is
  port (
    input_port : in std_logic_vector((32 - 1) downto 0);
    output_port : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end reinterpret_2_86b6c897b3;
architecture behavior of reinterpret_2_86b6c897b3 is
  signal input_port_1_40: unsigned((32 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity reinterpret_3_4a71c92358 is
  port (
    input_port : in std_logic_vector((32 - 1) downto 0);
    output_port : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end reinterpret_3_4a71c92358;
architecture behavior of reinterpret_3_4a71c92358 is
  signal input_port_1_40: unsigned((32 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity reinterpret_4_08f87832dd is
  port (
    input_port : in std_logic_vector((32 - 1) downto 0);
    output_port : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end reinterpret_4_08f87832dd;
architecture behavior of reinterpret_4_08f87832dd is
  signal input_port_1_40: unsigned((32 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity reinterpret_5_cdd14878a6 is
  port (
    input_port : in std_logic_vector((32 - 1) downto 0);
    output_port : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end reinterpret_5_cdd14878a6;
architecture behavior of reinterpret_5_cdd14878a6 is
  signal input_port_1_40: unsigned((32 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity reinterpret_6_b56b6e0737 is
  port (
    input_port : in std_logic_vector((32 - 1) downto 0);
    output_port : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end reinterpret_6_b56b6e0737;
architecture behavior of reinterpret_6_b56b6e0737 is
  signal input_port_1_40: unsigned((32 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity reinterpret_7_778adf93f8 is
  port (
    input_port : in std_logic_vector((32 - 1) downto 0);
    output_port : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end reinterpret_7_778adf93f8;
architecture behavior of reinterpret_7_778adf93f8 is
  signal input_port_1_40: unsigned((32 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity reinterpret_8_cb1cfb6e22 is
  port (
    input_port : in std_logic_vector((32 - 1) downto 0);
    output_port : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end reinterpret_8_cb1cfb6e22;
architecture behavior of reinterpret_8_cb1cfb6e22 is
  signal input_port_1_40: unsigned((32 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity reinterpret_9_f7edd0618b is
  port (
    input_port : in std_logic_vector((32 - 1) downto 0);
    output_port : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end reinterpret_9_f7edd0618b;
architecture behavior of reinterpret_9_f7edd0618b is
  signal input_port_1_40: unsigned((32 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity concat_2c955f0350 is
  port (
    in0 : in std_logic_vector((1 - 1) downto 0);
    in1 : in std_logic_vector((1 - 1) downto 0);
    in2 : in std_logic_vector((1 - 1) downto 0);
    in3 : in std_logic_vector((1 - 1) downto 0);
    in4 : in std_logic_vector((1 - 1) downto 0);
    in5 : in std_logic_vector((1 - 1) downto 0);
    in6 : in std_logic_vector((1 - 1) downto 0);
    in7 : in std_logic_vector((1 - 1) downto 0);
    in8 : in std_logic_vector((1 - 1) downto 0);
    in9 : in std_logic_vector((1 - 1) downto 0);
    in10 : in std_logic_vector((1 - 1) downto 0);
    in11 : in std_logic_vector((1 - 1) downto 0);
    in12 : in std_logic_vector((1 - 1) downto 0);
    in13 : in std_logic_vector((1 - 1) downto 0);
    in14 : in std_logic_vector((1 - 1) downto 0);
    in15 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end concat_2c955f0350;
architecture behavior of concat_2c955f0350 is
  signal in0_1_23: boolean;
  signal in1_1_27: boolean;
  signal in2_1_31: boolean;
  signal in3_1_35: boolean;
  signal in4_1_39: boolean;
  signal in5_1_43: boolean;
  signal in6_1_47: boolean;
  signal in7_1_51: boolean;
  signal in8_1_55: boolean;
  signal in9_1_59: boolean;
  signal in10_1_63: boolean;
  signal in11_1_68: boolean;
  signal in12_1_73: boolean;
  signal in13_1_78: boolean;
  signal in14_1_83: boolean;
  signal in15_1_88: boolean;
  signal y_2_1_concat: unsigned((16 - 1) downto 0);
begin
  in0_1_23 <= ((in0) = "1");
  in1_1_27 <= ((in1) = "1");
  in2_1_31 <= ((in2) = "1");
  in3_1_35 <= ((in3) = "1");
  in4_1_39 <= ((in4) = "1");
  in5_1_43 <= ((in5) = "1");
  in6_1_47 <= ((in6) = "1");
  in7_1_51 <= ((in7) = "1");
  in8_1_55 <= ((in8) = "1");
  in9_1_59 <= ((in9) = "1");
  in10_1_63 <= ((in10) = "1");
  in11_1_68 <= ((in11) = "1");
  in12_1_73 <= ((in12) = "1");
  in13_1_78 <= ((in13) = "1");
  in14_1_83 <= ((in14) = "1");
  in15_1_88 <= ((in15) = "1");
  y_2_1_concat <= std_logic_vector_to_unsigned(boolean_to_vector(in0_1_23) & boolean_to_vector(in1_1_27) & boolean_to_vector(in2_1_31) & boolean_to_vector(in3_1_35) & boolean_to_vector(in4_1_39) & boolean_to_vector(in5_1_43) & boolean_to_vector(in6_1_47) & boolean_to_vector(in7_1_51) & boolean_to_vector(in8_1_55) & boolean_to_vector(in9_1_59) & boolean_to_vector(in10_1_63) & boolean_to_vector(in11_1_68) & boolean_to_vector(in12_1_73) & boolean_to_vector(in13_1_78) & boolean_to_vector(in14_1_83) & boolean_to_vector(in15_1_88));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity concat1_1e4752a176 is
  port (
    in0 : in std_logic_vector((1 - 1) downto 0);
    in1 : in std_logic_vector((1 - 1) downto 0);
    in2 : in std_logic_vector((1 - 1) downto 0);
    in3 : in std_logic_vector((1 - 1) downto 0);
    in4 : in std_logic_vector((1 - 1) downto 0);
    in5 : in std_logic_vector((1 - 1) downto 0);
    in6 : in std_logic_vector((1 - 1) downto 0);
    in7 : in std_logic_vector((1 - 1) downto 0);
    in8 : in std_logic_vector((1 - 1) downto 0);
    in9 : in std_logic_vector((1 - 1) downto 0);
    in10 : in std_logic_vector((1 - 1) downto 0);
    in11 : in std_logic_vector((1 - 1) downto 0);
    in12 : in std_logic_vector((1 - 1) downto 0);
    in13 : in std_logic_vector((1 - 1) downto 0);
    in14 : in std_logic_vector((1 - 1) downto 0);
    in15 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end concat1_1e4752a176;
architecture behavior of concat1_1e4752a176 is
  signal in0_1_23: boolean;
  signal in1_1_27: boolean;
  signal in2_1_31: boolean;
  signal in3_1_35: boolean;
  signal in4_1_39: boolean;
  signal in5_1_43: boolean;
  signal in6_1_47: boolean;
  signal in7_1_51: boolean;
  signal in8_1_55: boolean;
  signal in9_1_59: boolean;
  signal in10_1_63: boolean;
  signal in11_1_68: boolean;
  signal in12_1_73: boolean;
  signal in13_1_78: boolean;
  signal in14_1_83: boolean;
  signal in15_1_88: boolean;
  signal y_2_1_concat: unsigned((16 - 1) downto 0);
begin
  in0_1_23 <= ((in0) = "1");
  in1_1_27 <= ((in1) = "1");
  in2_1_31 <= ((in2) = "1");
  in3_1_35 <= ((in3) = "1");
  in4_1_39 <= ((in4) = "1");
  in5_1_43 <= ((in5) = "1");
  in6_1_47 <= ((in6) = "1");
  in7_1_51 <= ((in7) = "1");
  in8_1_55 <= ((in8) = "1");
  in9_1_59 <= ((in9) = "1");
  in10_1_63 <= ((in10) = "1");
  in11_1_68 <= ((in11) = "1");
  in12_1_73 <= ((in12) = "1");
  in13_1_78 <= ((in13) = "1");
  in14_1_83 <= ((in14) = "1");
  in15_1_88 <= ((in15) = "1");
  y_2_1_concat <= std_logic_vector_to_unsigned(boolean_to_vector(in0_1_23) & boolean_to_vector(in1_1_27) & boolean_to_vector(in2_1_31) & boolean_to_vector(in3_1_35) & boolean_to_vector(in4_1_39) & boolean_to_vector(in5_1_43) & boolean_to_vector(in6_1_47) & boolean_to_vector(in7_1_51) & boolean_to_vector(in8_1_55) & boolean_to_vector(in9_1_59) & boolean_to_vector(in10_1_63) & boolean_to_vector(in11_1_68) & boolean_to_vector(in12_1_73) & boolean_to_vector(in13_1_78) & boolean_to_vector(in14_1_83) & boolean_to_vector(in15_1_88));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity concat2_ad1502d31f is
  port (
    in0 : in std_logic_vector((16 - 1) downto 0);
    in1 : in std_logic_vector((16 - 1) downto 0);
    y : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end concat2_ad1502d31f;
architecture behavior of concat2_ad1502d31f is
  signal in0_1_23: unsigned((16 - 1) downto 0);
  signal in1_1_27: unsigned((16 - 1) downto 0);
  signal y_2_1_concat: unsigned((32 - 1) downto 0);
begin
  in0_1_23 <= std_logic_vector_to_unsigned(in0);
  in1_1_27 <= std_logic_vector_to_unsigned(in1);
  y_2_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(in0_1_23) & unsigned_to_std_logic_vector(in1_1_27));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity delay_fe9d77185b is
  port (
    d : in std_logic_vector((1 - 1) downto 0);
    q : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end delay_fe9d77185b;
architecture behavior of delay_fe9d77185b is
  signal d_1_22: boolean;
begin
  d_1_22 <= ((d) = "1");
  q <= boolean_to_vector(d_1_22);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice_7c15b5c75c is
  port (
    x : in std_logic_vector((32 - 1) downto 0);
    y : out std_logic_vector((5 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice_7c15b5c75c;
architecture behavior of slice_7c15b5c75c is
  signal x_1_22: unsigned((32 - 1) downto 0);
  signal y_2_1_slice: unsigned((5 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 6, 2);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity a_correction_0_215db66be8 is
  port (
    a : in std_logic_vector((5 - 1) downto 0);
    b : in std_logic_vector((1 - 1) downto 0);
    s : out std_logic_vector((5 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end a_correction_0_215db66be8;
architecture behavior of a_correction_0_215db66be8 is
  signal a_17_32: unsigned((5 - 1) downto 0);
  signal b_17_35: unsigned((1 - 1) downto 0);
  type array_type_op_mem_91_20 is array (0 to (1 - 1)) of unsigned((5 - 1) downto 0);
  signal op_mem_91_20: array_type_op_mem_91_20 := (
    0 => "00000");
  signal op_mem_91_20_front_din: unsigned((5 - 1) downto 0);
  signal op_mem_91_20_back: unsigned((5 - 1) downto 0);
  signal op_mem_91_20_push_front_pop_back_en: std_logic;
  type array_type_cout_mem_92_22 is array (0 to (1 - 1)) of unsigned((1 - 1) downto 0);
  signal cout_mem_92_22: array_type_cout_mem_92_22 := (
    0 => "0");
  signal cout_mem_92_22_front_din: unsigned((1 - 1) downto 0);
  signal cout_mem_92_22_back: unsigned((1 - 1) downto 0);
  signal cout_mem_92_22_push_front_pop_back_en: std_logic;
  signal prev_mode_93_22_next: unsigned((3 - 1) downto 0);
  signal prev_mode_93_22: unsigned((3 - 1) downto 0);
  signal prev_mode_93_22_reg_i: std_logic_vector((3 - 1) downto 0);
  signal prev_mode_93_22_reg_o: std_logic_vector((3 - 1) downto 0);
  signal cast_71_18: signed((7 - 1) downto 0);
  signal cast_71_22: signed((7 - 1) downto 0);
  signal internal_s_71_5_addsub: signed((7 - 1) downto 0);
  signal cast_internal_s_83_3_convert: unsigned((5 - 1) downto 0);
begin
  a_17_32 <= std_logic_vector_to_unsigned(a);
  b_17_35 <= std_logic_vector_to_unsigned(b);
  op_mem_91_20_back <= op_mem_91_20(0);
  proc_op_mem_91_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_91_20_push_front_pop_back_en = '1')) then
        op_mem_91_20(0) <= op_mem_91_20_front_din;
      end if;
    end if;
  end process proc_op_mem_91_20;
  cout_mem_92_22_back <= cout_mem_92_22(0);
  proc_cout_mem_92_22: process (clk)
  is
    variable i_x_000000: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (cout_mem_92_22_push_front_pop_back_en = '1')) then
        cout_mem_92_22(0) <= cout_mem_92_22_front_din;
      end if;
    end if;
  end process proc_cout_mem_92_22;
  prev_mode_93_22_reg_i <= unsigned_to_std_logic_vector(prev_mode_93_22_next);
  prev_mode_93_22 <= std_logic_vector_to_unsigned(prev_mode_93_22_reg_o);
  prev_mode_93_22_reg_inst: entity work.synth_reg_w_init
    generic map (
      init_index => 2, 
      init_value => b"010", 
      latency => 1, 
      width => 3)
    port map (
      ce => ce, 
      clk => clk, 
      clr => clr, 
      i => prev_mode_93_22_reg_i, 
      o => prev_mode_93_22_reg_o);
  cast_71_18 <= u2s_cast(a_17_32, 0, 7, 0);
  cast_71_22 <= u2s_cast(b_17_35, 0, 7, 0);
  internal_s_71_5_addsub <= cast_71_18 - cast_71_22;
  cast_internal_s_83_3_convert <= s2u_cast(internal_s_71_5_addsub, 0, 5, 0);
  op_mem_91_20_push_front_pop_back_en <= '0';
  cout_mem_92_22_push_front_pop_back_en <= '0';
  prev_mode_93_22_next <= std_logic_vector_to_unsigned("000");
  s <= unsigned_to_std_logic_vector(cast_internal_s_83_3_convert);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity const_0_875565ddfa is
  port (
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end const_0_875565ddfa;
architecture behavior of const_0_875565ddfa is
begin
  op <= "0";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity force_0_926b7f7642 is
  port (
    input_port : in std_logic_vector((9 - 1) downto 0);
    output_port : out std_logic_vector((9 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end force_0_926b7f7642;
architecture behavior of force_0_926b7f7642 is
  signal input_port_1_40: unsigned((9 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity force_1_6396c8c2be is
  port (
    input_port : in std_logic_vector((9 - 1) downto 0);
    output_port : out std_logic_vector((9 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end force_1_6396c8c2be;
architecture behavior of force_1_6396c8c2be is
  signal input_port_1_40: unsigned((9 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity force_10_7d19bea9a3 is
  port (
    input_port : in std_logic_vector((2 - 1) downto 0);
    output_port : out std_logic_vector((2 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end force_10_7d19bea9a3;
architecture behavior of force_10_7d19bea9a3 is
  signal input_port_1_40: unsigned((2 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity force_11_199b049259 is
  port (
    input_port : in std_logic_vector((1 - 1) downto 0);
    output_port : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end force_11_199b049259;
architecture behavior of force_11_199b049259 is
  signal input_port_1_40: unsigned((1 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity force_12_a7c5e649a9 is
  port (
    input_port : in std_logic_vector((8 - 1) downto 0);
    output_port : out std_logic_vector((8 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end force_12_a7c5e649a9;
architecture behavior of force_12_a7c5e649a9 is
  signal input_port_1_40: unsigned((8 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity force_13_04ba53f6fc is
  port (
    input_port : in std_logic_vector((1 - 1) downto 0);
    output_port : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end force_13_04ba53f6fc;
architecture behavior of force_13_04ba53f6fc is
  signal input_port_1_40: unsigned((1 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity force_14_12dfc422b4 is
  port (
    input_port : in std_logic_vector((1 - 1) downto 0);
    output_port : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end force_14_12dfc422b4;
architecture behavior of force_14_12dfc422b4 is
  signal input_port_1_40: unsigned((1 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity force_15_6984ae8d01 is
  port (
    input_port : in std_logic_vector((1 - 1) downto 0);
    output_port : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end force_15_6984ae8d01;
architecture behavior of force_15_6984ae8d01 is
  signal input_port_1_40: unsigned((1 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity force_16_506e50b36b is
  port (
    input_port : in std_logic_vector((1 - 1) downto 0);
    output_port : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end force_16_506e50b36b;
architecture behavior of force_16_506e50b36b is
  signal input_port_1_40: unsigned((1 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity force_17_5f7a1de601 is
  port (
    input_port : in std_logic_vector((1 - 1) downto 0);
    output_port : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end force_17_5f7a1de601;
architecture behavior of force_17_5f7a1de601 is
  signal input_port_1_40: boolean;
  signal output_port_7_5_convert: unsigned((1 - 1) downto 0);
begin
  input_port_1_40 <= ((input_port) = "1");
  output_port_7_5_convert <= u2u_cast(std_logic_vector_to_unsigned(boolean_to_vector(input_port_1_40)), 0, 1, 0);
  output_port <= unsigned_to_std_logic_vector(output_port_7_5_convert);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity force_2_892a3cd76c is
  port (
    input_port : in std_logic_vector((9 - 1) downto 0);
    output_port : out std_logic_vector((9 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end force_2_892a3cd76c;
architecture behavior of force_2_892a3cd76c is
  signal input_port_1_40: unsigned((9 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity force_3_202adeb79d is
  port (
    input_port : in std_logic_vector((9 - 1) downto 0);
    output_port : out std_logic_vector((9 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end force_3_202adeb79d;
architecture behavior of force_3_202adeb79d is
  signal input_port_1_40: unsigned((9 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity force_4_10478396f6 is
  port (
    input_port : in std_logic_vector((9 - 1) downto 0);
    output_port : out std_logic_vector((9 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end force_4_10478396f6;
architecture behavior of force_4_10478396f6 is
  signal input_port_1_40: unsigned((9 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity force_5_bb148c070b is
  port (
    input_port : in std_logic_vector((9 - 1) downto 0);
    output_port : out std_logic_vector((9 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end force_5_bb148c070b;
architecture behavior of force_5_bb148c070b is
  signal input_port_1_40: unsigned((9 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity force_6_970280b756 is
  port (
    input_port : in std_logic_vector((9 - 1) downto 0);
    output_port : out std_logic_vector((9 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end force_6_970280b756;
architecture behavior of force_6_970280b756 is
  signal input_port_1_40: unsigned((9 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity force_7_fbe4c3a528 is
  port (
    input_port : in std_logic_vector((9 - 1) downto 0);
    output_port : out std_logic_vector((9 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end force_7_fbe4c3a528;
architecture behavior of force_7_fbe4c3a528 is
  signal input_port_1_40: unsigned((9 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity force_8_7e507ba849 is
  port (
    input_port : in std_logic_vector((3 - 1) downto 0);
    output_port : out std_logic_vector((3 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end force_8_7e507ba849;
architecture behavior of force_8_7e507ba849 is
  signal input_port_1_40: unsigned((3 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity force_9_f25ebee362 is
  port (
    input_port : in std_logic_vector((1 - 1) downto 0);
    output_port : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end force_9_f25ebee362;
architecture behavior of force_9_f25ebee362 is
  signal input_port_1_40: unsigned((1 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity mux_0_17_06f0a07b4b is
  port (
    sel : in std_logic_vector((5 - 1) downto 0);
    d0 : in std_logic_vector((32 - 1) downto 0);
    d1 : in std_logic_vector((32 - 1) downto 0);
    d2 : in std_logic_vector((32 - 1) downto 0);
    d3 : in std_logic_vector((32 - 1) downto 0);
    d4 : in std_logic_vector((32 - 1) downto 0);
    d5 : in std_logic_vector((32 - 1) downto 0);
    d6 : in std_logic_vector((32 - 1) downto 0);
    d7 : in std_logic_vector((32 - 1) downto 0);
    d8 : in std_logic_vector((32 - 1) downto 0);
    d9 : in std_logic_vector((32 - 1) downto 0);
    d10 : in std_logic_vector((32 - 1) downto 0);
    d11 : in std_logic_vector((32 - 1) downto 0);
    d12 : in std_logic_vector((32 - 1) downto 0);
    d13 : in std_logic_vector((32 - 1) downto 0);
    d14 : in std_logic_vector((32 - 1) downto 0);
    d15 : in std_logic_vector((32 - 1) downto 0);
    d16 : in std_logic_vector((32 - 1) downto 0);
    d17 : in std_logic_vector((32 - 1) downto 0);
    y : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end mux_0_17_06f0a07b4b;
architecture behavior of mux_0_17_06f0a07b4b is
  signal sel_1_20: unsigned((5 - 1) downto 0);
  signal d0_1_24: unsigned((32 - 1) downto 0);
  signal d1_1_27: unsigned((32 - 1) downto 0);
  signal d2_1_30: unsigned((32 - 1) downto 0);
  signal d3_1_33: unsigned((32 - 1) downto 0);
  signal d4_1_36: unsigned((32 - 1) downto 0);
  signal d5_1_39: unsigned((32 - 1) downto 0);
  signal d6_1_42: unsigned((32 - 1) downto 0);
  signal d7_1_45: unsigned((32 - 1) downto 0);
  signal d8_1_48: unsigned((32 - 1) downto 0);
  signal d9_1_51: unsigned((32 - 1) downto 0);
  signal d10_1_54: unsigned((32 - 1) downto 0);
  signal d11_1_58: unsigned((32 - 1) downto 0);
  signal d12_1_62: unsigned((32 - 1) downto 0);
  signal d13_1_66: unsigned((32 - 1) downto 0);
  signal d14_1_70: unsigned((32 - 1) downto 0);
  signal d15_1_74: unsigned((32 - 1) downto 0);
  signal d16_1_78: unsigned((32 - 1) downto 0);
  signal d17_1_82: unsigned((32 - 1) downto 0);
  signal unregy_join_3_1: unsigned((32 - 1) downto 0);
begin
  sel_1_20 <= std_logic_vector_to_unsigned(sel);
  d0_1_24 <= std_logic_vector_to_unsigned(d0);
  d1_1_27 <= std_logic_vector_to_unsigned(d1);
  d2_1_30 <= std_logic_vector_to_unsigned(d2);
  d3_1_33 <= std_logic_vector_to_unsigned(d3);
  d4_1_36 <= std_logic_vector_to_unsigned(d4);
  d5_1_39 <= std_logic_vector_to_unsigned(d5);
  d6_1_42 <= std_logic_vector_to_unsigned(d6);
  d7_1_45 <= std_logic_vector_to_unsigned(d7);
  d8_1_48 <= std_logic_vector_to_unsigned(d8);
  d9_1_51 <= std_logic_vector_to_unsigned(d9);
  d10_1_54 <= std_logic_vector_to_unsigned(d10);
  d11_1_58 <= std_logic_vector_to_unsigned(d11);
  d12_1_62 <= std_logic_vector_to_unsigned(d12);
  d13_1_66 <= std_logic_vector_to_unsigned(d13);
  d14_1_70 <= std_logic_vector_to_unsigned(d14);
  d15_1_74 <= std_logic_vector_to_unsigned(d15);
  d16_1_78 <= std_logic_vector_to_unsigned(d16);
  d17_1_82 <= std_logic_vector_to_unsigned(d17);
  proc_switch_3_1: process (d0_1_24, d10_1_54, d11_1_58, d12_1_62, d13_1_66, d14_1_70, d15_1_74, d16_1_78, d17_1_82, d1_1_27, d2_1_30, d3_1_33, d4_1_36, d5_1_39, d6_1_42, d7_1_45, d8_1_48, d9_1_51, sel_1_20)
  is
  begin
    case sel_1_20 is 
      when "00000" =>
        unregy_join_3_1 <= d0_1_24;
      when "00001" =>
        unregy_join_3_1 <= d1_1_27;
      when "00010" =>
        unregy_join_3_1 <= d2_1_30;
      when "00011" =>
        unregy_join_3_1 <= d3_1_33;
      when "00100" =>
        unregy_join_3_1 <= d4_1_36;
      when "00101" =>
        unregy_join_3_1 <= d5_1_39;
      when "00110" =>
        unregy_join_3_1 <= d6_1_42;
      when "00111" =>
        unregy_join_3_1 <= d7_1_45;
      when "01000" =>
        unregy_join_3_1 <= d8_1_48;
      when "01001" =>
        unregy_join_3_1 <= d9_1_51;
      when "01010" =>
        unregy_join_3_1 <= d10_1_54;
      when "01011" =>
        unregy_join_3_1 <= d11_1_58;
      when "01100" =>
        unregy_join_3_1 <= d12_1_62;
      when "01101" =>
        unregy_join_3_1 <= d13_1_66;
      when "01110" =>
        unregy_join_3_1 <= d14_1_70;
      when "01111" =>
        unregy_join_3_1 <= d15_1_74;
      when "10000" =>
        unregy_join_3_1 <= d16_1_78;
      when "10001" =>
        unregy_join_3_1 <= d17_1_82;
      when others =>
        unregy_join_3_1 <= d0_1_24;
    end case;
  end process proc_switch_3_1;
  y <= unsigned_to_std_logic_vector(unregy_join_3_1);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity valid_data_5dfe5a8f9e is
  port (
    d0 : in std_logic_vector((32 - 1) downto 0);
    d1 : in std_logic_vector((32 - 1) downto 0);
    y : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end valid_data_5dfe5a8f9e;
architecture behavior of valid_data_5dfe5a8f9e is
  signal d0_1_24: unsigned((32 - 1) downto 0);
  signal d1_1_27: unsigned((32 - 1) downto 0);
  signal fully_2_1_bit: unsigned((32 - 1) downto 0);
begin
  d0_1_24 <= std_logic_vector_to_unsigned(d0);
  d1_1_27 <= std_logic_vector_to_unsigned(d1);
  fully_2_1_bit <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(d0_1_24) and unsigned_to_std_logic_vector(d1_1_27));
  y <= unsigned_to_std_logic_vector(fully_2_1_bit);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity constant2_bb9364aedc is
  port (
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant2_bb9364aedc;
architecture behavior of constant2_bb9364aedc is
begin
  op <= "0";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity inverter_1ad3fd342d is
  port (
    ip : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end inverter_1ad3fd342d;
architecture behavior of inverter_1ad3fd342d is
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

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity logical_9ce9caf750 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end logical_9ce9caf750;
architecture behavior of logical_9ce9caf750 is
  signal d0_1_24: boolean;
  signal d1_1_27: boolean;
  signal fully_2_1_bit: boolean;
begin
  d0_1_24 <= ((d0) = "1");
  d1_1_27 <= ((d1) = "1");
  fully_2_1_bit <= ((boolean_to_vector(d0_1_24) and boolean_to_vector(d1_1_27)) = "1");
  y <= boolean_to_vector(fully_2_1_bit);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity mux_1dfdc407ff is
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
end mux_1dfdc407ff;
architecture behavior of mux_1dfdc407ff is
  signal sel_1_20: unsigned((4 - 1) downto 0);
  signal d0_1_24: unsigned((1 - 1) downto 0);
  signal d1_1_27: unsigned((1 - 1) downto 0);
  signal d2_1_30: unsigned((1 - 1) downto 0);
  signal d3_1_33: unsigned((1 - 1) downto 0);
  signal d4_1_36: unsigned((1 - 1) downto 0);
  signal d5_1_39: unsigned((1 - 1) downto 0);
  signal d6_1_42: unsigned((1 - 1) downto 0);
  signal d7_1_45: unsigned((1 - 1) downto 0);
  signal d8_1_48: unsigned((1 - 1) downto 0);
  type array_type_pipe_29_22 is array (0 to (1 - 1)) of unsigned((1 - 1) downto 0);
  signal pipe_29_22: array_type_pipe_29_22 := (
    0 => "0");
  signal pipe_29_22_front_din: unsigned((1 - 1) downto 0);
  signal pipe_29_22_back: unsigned((1 - 1) downto 0);
  signal pipe_29_22_push_front_pop_back_en: std_logic;
  signal unregy_join_3_1: unsigned((1 - 1) downto 0);
begin
  sel_1_20 <= std_logic_vector_to_unsigned(sel);
  d0_1_24 <= std_logic_vector_to_unsigned(d0);
  d1_1_27 <= std_logic_vector_to_unsigned(d1);
  d2_1_30 <= std_logic_vector_to_unsigned(d2);
  d3_1_33 <= std_logic_vector_to_unsigned(d3);
  d4_1_36 <= std_logic_vector_to_unsigned(d4);
  d5_1_39 <= std_logic_vector_to_unsigned(d5);
  d6_1_42 <= std_logic_vector_to_unsigned(d6);
  d7_1_45 <= std_logic_vector_to_unsigned(d7);
  d8_1_48 <= std_logic_vector_to_unsigned(d8);
  pipe_29_22_back <= pipe_29_22(0);
  proc_pipe_29_22: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (pipe_29_22_push_front_pop_back_en = '1')) then
        pipe_29_22(0) <= pipe_29_22_front_din;
      end if;
    end if;
  end process proc_pipe_29_22;
  proc_switch_3_1: process (d0_1_24, d1_1_27, d2_1_30, d3_1_33, d4_1_36, d5_1_39, d6_1_42, d7_1_45, d8_1_48, sel_1_20)
  is
  begin
    case sel_1_20 is 
      when "0000" =>
        unregy_join_3_1 <= d0_1_24;
      when "0001" =>
        unregy_join_3_1 <= d1_1_27;
      when "0010" =>
        unregy_join_3_1 <= d2_1_30;
      when "0011" =>
        unregy_join_3_1 <= d3_1_33;
      when "0100" =>
        unregy_join_3_1 <= d4_1_36;
      when "0101" =>
        unregy_join_3_1 <= d5_1_39;
      when "0110" =>
        unregy_join_3_1 <= d6_1_42;
      when "0111" =>
        unregy_join_3_1 <= d7_1_45;
      when "1000" =>
        unregy_join_3_1 <= d8_1_48;
      when others =>
        unregy_join_3_1 <= d0_1_24;
    end case;
  end process proc_switch_3_1;
  pipe_29_22_front_din <= unregy_join_3_1;
  pipe_29_22_push_front_pop_back_en <= '1';
  y <= unsigned_to_std_logic_vector(pipe_29_22_back);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice_791295c431 is
  port (
    x : in std_logic_vector((9 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice_791295c431;
architecture behavior of slice_791295c431 is
  signal x_1_22: unsigned((9 - 1) downto 0);
  signal y_2_1_slice: unsigned((1 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 8, 8);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice1_ff4192363f is
  port (
    x : in std_logic_vector((9 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice1_ff4192363f;
architecture behavior of slice1_ff4192363f is
  signal x_1_22: unsigned((9 - 1) downto 0);
  signal y_2_1_slice: unsigned((1 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 7, 7);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice2_29d60a12cc is
  port (
    x : in std_logic_vector((9 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice2_29d60a12cc;
architecture behavior of slice2_29d60a12cc is
  signal x_1_22: unsigned((9 - 1) downto 0);
  signal y_2_1_slice: unsigned((1 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 6, 6);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice3_7e70c47c84 is
  port (
    x : in std_logic_vector((9 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice3_7e70c47c84;
architecture behavior of slice3_7e70c47c84 is
  signal x_1_22: unsigned((9 - 1) downto 0);
  signal y_2_1_slice: unsigned((1 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 5, 5);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice4_af90c4b694 is
  port (
    x : in std_logic_vector((9 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice4_af90c4b694;
architecture behavior of slice4_af90c4b694 is
  signal x_1_22: unsigned((9 - 1) downto 0);
  signal y_2_1_slice: unsigned((1 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 4, 4);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice5_68bd3a6261 is
  port (
    x : in std_logic_vector((9 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice5_68bd3a6261;
architecture behavior of slice5_68bd3a6261 is
  signal x_1_22: unsigned((9 - 1) downto 0);
  signal y_2_1_slice: unsigned((1 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 3, 3);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice6_b8fc9afe99 is
  port (
    x : in std_logic_vector((9 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice6_b8fc9afe99;
architecture behavior of slice6_b8fc9afe99 is
  signal x_1_22: unsigned((9 - 1) downto 0);
  signal y_2_1_slice: unsigned((1 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 2, 2);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice7_21ba1aeffb is
  port (
    x : in std_logic_vector((9 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice7_21ba1aeffb;
architecture behavior of slice7_21ba1aeffb is
  signal x_1_22: unsigned((9 - 1) downto 0);
  signal y_2_1_slice: unsigned((1 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 1, 1);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice8_e1859eb584 is
  port (
    x : in std_logic_vector((9 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice8_e1859eb584;
architecture behavior of slice8_e1859eb584 is
  signal x_1_22: unsigned((9 - 1) downto 0);
  signal y_2_1_slice: unsigned((1 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 0, 0);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity inverter_77ee0cd0d1 is
  port (
    ip : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end inverter_77ee0cd0d1;
architecture behavior of inverter_77ee0cd0d1 is
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
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity logical_efbd270832 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end logical_efbd270832;
architecture behavior of logical_efbd270832 is
  signal d0_1_24: unsigned((1 - 1) downto 0);
  signal d1_1_27: unsigned((1 - 1) downto 0);
  signal fully_2_1_bit: unsigned((1 - 1) downto 0);
begin
  d0_1_24 <= std_logic_vector_to_unsigned(d0);
  d1_1_27 <= std_logic_vector_to_unsigned(d1);
  fully_2_1_bit <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(d0_1_24) and unsigned_to_std_logic_vector(d1_1_27));
  y <= unsigned_to_std_logic_vector(fully_2_1_bit);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity inverter_8d7a99ad38 is
  port (
    ip : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end inverter_8d7a99ad38;
architecture behavior of inverter_8d7a99ad38 is
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
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity logical_d0cd988cf6 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end logical_d0cd988cf6;
architecture behavior of logical_d0cd988cf6 is
  signal d0_1_24: unsigned((1 - 1) downto 0);
  signal d1_1_27: unsigned((1 - 1) downto 0);
  signal fully_2_1_bit: unsigned((1 - 1) downto 0);
begin
  d0_1_24 <= std_logic_vector_to_unsigned(d0);
  d1_1_27 <= std_logic_vector_to_unsigned(d1);
  fully_2_1_bit <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(d0_1_24) and unsigned_to_std_logic_vector(d1_1_27));
  y <= unsigned_to_std_logic_vector(fully_2_1_bit);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity constant_d8dc206917 is
  port (
    op : out std_logic_vector((4 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_d8dc206917;
architecture behavior of constant_d8dc206917 is
begin
  op <= "1111";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity inverter_28860404e6 is
  port (
    ip : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end inverter_28860404e6;
architecture behavior of inverter_28860404e6 is
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

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity inverter1_0f8027306d is
  port (
    ip : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end inverter1_0f8027306d;
architecture behavior of inverter1_0f8027306d is
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
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity logical_46f244e8bb is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end logical_46f244e8bb;
architecture behavior of logical_46f244e8bb is
  signal d0_1_24: boolean;
  signal d1_1_27: boolean;
  signal fully_2_1_bit: boolean;
begin
  d0_1_24 <= ((d0) = "1");
  d1_1_27 <= ((d1) = "1");
  fully_2_1_bit <= ((boolean_to_vector(d0_1_24) or boolean_to_vector(d1_1_27)) = "1");
  y <= boolean_to_vector(fully_2_1_bit);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity mux_e3fe44b617 is
  port (
    sel : in std_logic_vector((1 - 1) downto 0);
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end mux_e3fe44b617;
architecture behavior of mux_e3fe44b617 is
  signal sel_1_20: boolean;
  signal d0_1_24: unsigned((1 - 1) downto 0);
  signal d1_1_27: unsigned((1 - 1) downto 0);
  signal sel_internal_2_1_convert: unsigned((1 - 1) downto 0);
  signal unregy_join_3_1: unsigned((1 - 1) downto 0);
begin
  sel_1_20 <= ((sel) = "1");
  d0_1_24 <= std_logic_vector_to_unsigned(d0);
  d1_1_27 <= std_logic_vector_to_unsigned(d1);
  sel_internal_2_1_convert <= u2u_cast(std_logic_vector_to_unsigned(boolean_to_vector(sel_1_20)), 0, 1, 0);
  proc_switch_3_1: process (d0_1_24, d1_1_27, sel_internal_2_1_convert)
  is
  begin
    case sel_internal_2_1_convert is 
      when "0" =>
        unregy_join_3_1 <= d0_1_24;
      when "1" =>
        unregy_join_3_1 <= d1_1_27;
      when others =>
        unregy_join_3_1 <= d0_1_24;
    end case;
  end process proc_switch_3_1;
  y <= unsigned_to_std_logic_vector(unregy_join_3_1);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity mux1_d0bb08f30c is
  port (
    sel : in std_logic_vector((1 - 1) downto 0);
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end mux1_d0bb08f30c;
architecture behavior of mux1_d0bb08f30c is
  signal sel_1_20: boolean;
  signal d0_1_24: unsigned((1 - 1) downto 0);
  signal d1_1_27: unsigned((1 - 1) downto 0);
  signal sel_internal_2_1_convert: unsigned((1 - 1) downto 0);
  signal unregy_join_3_1: unsigned((1 - 1) downto 0);
begin
  sel_1_20 <= ((sel) = "1");
  d0_1_24 <= std_logic_vector_to_unsigned(d0);
  d1_1_27 <= std_logic_vector_to_unsigned(d1);
  sel_internal_2_1_convert <= u2u_cast(std_logic_vector_to_unsigned(boolean_to_vector(sel_1_20)), 0, 1, 0);
  proc_switch_3_1: process (d0_1_24, d1_1_27, sel_internal_2_1_convert)
  is
  begin
    case sel_internal_2_1_convert is 
      when "0" =>
        unregy_join_3_1 <= d0_1_24;
      when "1" =>
        unregy_join_3_1 <= d1_1_27;
      when others =>
        unregy_join_3_1 <= d0_1_24;
    end case;
  end process proc_switch_3_1;
  y <= unsigned_to_std_logic_vector(unregy_join_3_1);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice_1db632eb4d is
  port (
    x : in std_logic_vector((4 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice_1db632eb4d;
architecture behavior of slice_1db632eb4d is
  signal x_1_22: unsigned((4 - 1) downto 0);
  signal y_2_1_slice: unsigned((1 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 2, 2);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice1_31d72b6151 is
  port (
    x : in std_logic_vector((4 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice1_31d72b6151;
architecture behavior of slice1_31d72b6151 is
  signal x_1_22: unsigned((4 - 1) downto 0);
  signal y_2_1_slice: unsigned((1 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 3, 3);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice2_a14dc94f53 is
  port (
    x : in std_logic_vector((4 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice2_a14dc94f53;
architecture behavior of slice2_a14dc94f53 is
  signal x_1_22: unsigned((4 - 1) downto 0);
  signal y_2_1_slice: unsigned((1 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 3, 3);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity constant_b86c2593ab is
  port (
    op : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end constant_b86c2593ab;
architecture behavior of constant_b86c2593ab is
begin
  op <= "00000000000000000000000000000000";
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity logical_cc69aebb05 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end logical_cc69aebb05;
architecture behavior of logical_cc69aebb05 is
  signal d0_1_24: boolean;
  signal d1_1_27: boolean;
  signal fully_2_1_bit: boolean;
begin
  d0_1_24 <= ((d0) = "1");
  d1_1_27 <= ((d1) = "1");
  fully_2_1_bit <= ((boolean_to_vector(d0_1_24) and boolean_to_vector(d1_1_27)) = "1");
  y <= boolean_to_vector(fully_2_1_bit);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity relational_3a7b93335f is
  port (
    a : in std_logic_vector((14 - 1) downto 0);
    b : in std_logic_vector((14 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end relational_3a7b93335f;
architecture behavior of relational_3a7b93335f is
  signal a_1_31: unsigned((14 - 1) downto 0);
  signal b_1_34: unsigned((14 - 1) downto 0);
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  result_12_3_rel <= a_1_31 = b_1_34;
  op <= boolean_to_vector(result_12_3_rel);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice_c_2025eb8052 is
  port (
    x : in std_logic_vector((32 - 1) downto 0);
    y : out std_logic_vector((14 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice_c_2025eb8052;
architecture behavior of slice_c_2025eb8052 is
  signal x_1_22: unsigned((32 - 1) downto 0);
  signal y_2_1_slice: unsigned((14 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 31, 18);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity slice_d_8b205dd8c0 is
  port (
    x : in std_logic_vector((32 - 1) downto 0);
    y : out std_logic_vector((14 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end slice_d_8b205dd8c0;
architecture behavior of slice_d_8b205dd8c0 is
  signal x_1_22: unsigned((32 - 1) downto 0);
  signal y_2_1_slice: unsigned((14 - 1) downto 0);
begin
  x_1_22 <= std_logic_vector_to_unsigned(x);
  y_2_1_slice <= u2u_slice(x_1_22, 31, 18);
  y <= unsigned_to_std_logic_vector(y_2_1_slice);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity logical1_2f79cf4de3 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end logical1_2f79cf4de3;
architecture behavior of logical1_2f79cf4de3 is
  signal d0_1_24: unsigned((1 - 1) downto 0);
  signal d1_1_27: unsigned((1 - 1) downto 0);
  signal fully_2_1_bit: unsigned((1 - 1) downto 0);
begin
  d0_1_24 <= std_logic_vector_to_unsigned(d0);
  d1_1_27 <= std_logic_vector_to_unsigned(d1);
  fully_2_1_bit <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(d0_1_24) or unsigned_to_std_logic_vector(d1_1_27));
  y <= unsigned_to_std_logic_vector(fully_2_1_bit);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity mux_a4ed0f3863 is
  port (
    sel : in std_logic_vector((1 - 1) downto 0);
    d0 : in std_logic_vector((9 - 1) downto 0);
    d1 : in std_logic_vector((9 - 1) downto 0);
    y : out std_logic_vector((9 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end mux_a4ed0f3863;
architecture behavior of mux_a4ed0f3863 is
  signal sel_1_20: boolean;
  signal d0_1_24: unsigned((9 - 1) downto 0);
  signal d1_1_27: unsigned((9 - 1) downto 0);
  signal sel_internal_2_1_convert: unsigned((1 - 1) downto 0);
  signal unregy_join_3_1: unsigned((9 - 1) downto 0);
begin
  sel_1_20 <= ((sel) = "1");
  d0_1_24 <= std_logic_vector_to_unsigned(d0);
  d1_1_27 <= std_logic_vector_to_unsigned(d1);
  sel_internal_2_1_convert <= u2u_cast(std_logic_vector_to_unsigned(boolean_to_vector(sel_1_20)), 0, 1, 0);
  proc_switch_3_1: process (d0_1_24, d1_1_27, sel_internal_2_1_convert)
  is
  begin
    case sel_internal_2_1_convert is 
      when "0" =>
        unregy_join_3_1 <= d0_1_24;
      when "1" =>
        unregy_join_3_1 <= d1_1_27;
      when others =>
        unregy_join_3_1 <= d0_1_24;
    end case;
  end process proc_switch_3_1;
  y <= unsigned_to_std_logic_vector(unregy_join_3_1);
end behavior;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.conv_pkg.all;
entity mux1_c9b55459ef is
  port (
    sel : in std_logic_vector((1 - 1) downto 0);
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end mux1_c9b55459ef;
architecture behavior of mux1_c9b55459ef is
  signal sel_1_20: boolean;
  signal d0_1_24: boolean;
  signal d1_1_27: boolean;
  signal sel_internal_2_1_convert: unsigned((1 - 1) downto 0);
  signal unregy_join_3_1: boolean;
begin
  sel_1_20 <= ((sel) = "1");
  d0_1_24 <= ((d0) = "1");
  d1_1_27 <= ((d1) = "1");
  sel_internal_2_1_convert <= u2u_cast(std_logic_vector_to_unsigned(boolean_to_vector(sel_1_20)), 0, 1, 0);
  proc_switch_3_1: process (d0_1_24, d1_1_27, sel_internal_2_1_convert)
  is
  begin
    case sel_internal_2_1_convert is 
      when "0" =>
        unregy_join_3_1 <= d0_1_24;
      when "1" =>
        unregy_join_3_1 <= d1_1_27;
      when others =>
        unregy_join_3_1 <= d0_1_24;
    end case;
  end process proc_switch_3_1;
  y <= boolean_to_vector(unregy_join_3_1);
end behavior;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller/CommandROM/Neg_Edge_Detector"

entity neg_edge_detector_entity_912b827dbd is
  port (
    ce_1: in std_logic;
    clk_1: in std_logic;
    input_signal: in std_logic;
    rising_edge: out std_logic
  );
end neg_edge_detector_entity_912b827dbd;

architecture structural of neg_edge_detector_entity_912b827dbd is
  signal ce_1_sg_x0: std_logic;
  signal clk_1_sg_x0: std_logic;
  signal delay_q_net: std_logic;
  signal inverter_op_net: std_logic;
  signal logical_y_net_x0: std_logic;
  signal slice4_y_net_x0: std_logic;

begin
  ce_1_sg_x0 <= ce_1;
  clk_1_sg_x0 <= clk_1;
  slice4_y_net_x0 <= input_signal;
  rising_edge <= logical_y_net_x0;

  delay: entity work.xldelay
    generic map (
      d_width => 1,
      en_width => 1,
      latency => 1,
      q_width => 1,
      reg_retiming => false,
      rst_width => 1
    )
    port map (
      ce => ce_1_sg_x0,
      clk => clk_1_sg_x0,
      clr => '0',
      d(0) => inverter_op_net,
      en => "1",
      rst => "0",
      q(0) => delay_q_net
    );

  inverter: entity work.inverter_483484483c
    port map (
      ce => ce_1_sg_x0,
      clk => clk_1_sg_x0,
      clr => '0',
      ip(0) => slice4_y_net_x0,
      op(0) => inverter_op_net
    );

  logical: entity work.logical_c1e87cc01e
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

-- Generated from Simulink block "user_io_board_controller/CommandROM"

entity commandrom_entity_5effcb692f is
  port (
    ce_1: in std_logic;
    clk_1: in std_logic;
    configloc: in std_logic_vector(1 downto 0);
    in_0: in std_logic_vector(8 downto 0);
    in_1: in std_logic_vector(8 downto 0);
    in_2: in std_logic_vector(8 downto 0);
    in_3: in std_logic_vector(8 downto 0);
    in_4: in std_logic_vector(8 downto 0);
    invertramaddr: in std_logic;
    reset: in std_logic;
    sendcmds: in std_logic;
    smwoaddr_0: in std_logic_vector(13 downto 0);
    smwodatai_0: in std_logic_vector(31 downto 0);
    smwowe_0: in std_logic;
    totalnoofcmds: in std_logic_vector(7 downto 0);
    transferdone: in std_logic;
    cmdsdone: out std_logic;
    datatosend: out std_logic_vector(8 downto 0);
    starttransfer: out std_logic
  );
end commandrom_entity_5effcb692f;

architecture structural of commandrom_entity_5effcb692f is
  signal accumulator1_q_net: std_logic_vector(3 downto 0);
  signal accumulator_q_net: std_logic_vector(6 downto 0);
  signal addrslice_y_net_x0: std_logic_vector(13 downto 0);
  signal addsub_s_net: std_logic_vector(8 downto 0);
  signal and_sm_1_y_net_x0: std_logic;
  signal ce_1_sg_x1: std_logic;
  signal clk_1_sg_x1: std_logic;
  signal concat1_y_net: std_logic_vector(6 downto 0);
  signal concat2_y_net_x0: std_logic_vector(8 downto 0);
  signal concat_y_net: std_logic_vector(8 downto 0);
  signal constant11_op_net: std_logic_vector(8 downto 0);
  signal constant1_op_net: std_logic;
  signal constant2_op_net: std_logic;
  signal constant3_op_net: std_logic;
  signal constant4_op_net: std_logic_vector(3 downto 0);
  signal constant5_op_net: std_logic_vector(8 downto 0);
  signal constant6_op_net: std_logic_vector(8 downto 0);
  signal constant_op_net: std_logic_vector(15 downto 0);
  signal convert1_dout_net: std_logic;
  signal convert1_dout_net_x2: std_logic;
  signal convert1_dout_net_x3: std_logic;
  signal convert2_dout_net: std_logic;
  signal convert_dout_net: std_logic;
  signal counter1_op_net: std_logic_vector(14 downto 0);
  signal counter_op_net: std_logic_vector(6 downto 0);
  signal delay_q_net: std_logic;
  signal from_register1_1_opb10_10_q_net_x0: std_logic_vector(1 downto 0);
  signal from_register1_opb0_0_q_net_x0: std_logic_vector(8 downto 0);
  signal from_register2_1_opb11_11_q_net_x0: std_logic;
  signal from_register2_opb1_1_q_net_x0: std_logic_vector(8 downto 0);
  signal from_register3_1_opb12_12_q_net_x0: std_logic_vector(7 downto 0);
  signal from_register3_opb2_2_q_net_x0: std_logic_vector(8 downto 0);
  signal from_register4_opb3_3_q_net_x0: std_logic_vector(8 downto 0);
  signal from_register5_opb4_4_q_net_x0: std_logic_vector(8 downto 0);
  signal inverter1_op_net: std_logic;
  signal inverter2_op_net: std_logic;
  signal inverter_op_net: std_logic;
  signal logical1_y_net: std_logic;
  signal logical2_y_net: std_logic;
  signal logical3_y_net: std_logic;
  signal logical_y_net: std_logic;
  signal logical_y_net_x0: std_logic;
  signal logical_y_net_x2: std_logic;
  signal mux1_y_net: std_logic;
  signal mux2_y_net_x0: std_logic;
  signal mux3_y_net: std_logic_vector(8 downto 0);
  signal mux_y_net: std_logic_vector(6 downto 0);
  signal register2_q_net_x0: std_logic_vector(31 downto 0);
  signal register_q_net_x0: std_logic;
  signal relational1_op_net: std_logic;
  signal relational_op_net: std_logic;
  signal slice1_y_net: std_logic;
  signal slice2_y_net: std_logic_vector(7 downto 0);
  signal slice3_y_net: std_logic;
  signal slice4_y_net_x0: std_logic;
  signal slice5_y_net: std_logic_vector(8 downto 0);
  signal slice_y_net: std_logic_vector(5 downto 0);
  signal smwo_lcd_commands_douta_net: std_logic_vector(15 downto 0);
  signal smwoaddr_gwin_slice_sm1_y_net: std_logic_vector(7 downto 0);
  signal smwodatai_gwin_force_sm1_output_port_net: std_logic_vector(31 downto 0);

begin
  ce_1_sg_x1 <= ce_1;
  clk_1_sg_x1 <= clk_1;
  from_register1_1_opb10_10_q_net_x0 <= configloc;
  from_register1_opb0_0_q_net_x0 <= in_0;
  from_register2_opb1_1_q_net_x0 <= in_1;
  from_register3_opb2_2_q_net_x0 <= in_2;
  from_register4_opb3_3_q_net_x0 <= in_3;
  from_register5_opb4_4_q_net_x0 <= in_4;
  from_register2_1_opb11_11_q_net_x0 <= invertramaddr;
  convert1_dout_net_x2 <= reset;
  logical_y_net_x2 <= sendcmds;
  addrslice_y_net_x0 <= smwoaddr_0;
  register2_q_net_x0 <= smwodatai_0;
  and_sm_1_y_net_x0 <= smwowe_0;
  from_register3_1_opb12_12_q_net_x0 <= totalnoofcmds;
  convert1_dout_net_x3 <= transferdone;
  cmdsdone <= register_q_net_x0;
  datatosend <= concat2_y_net_x0;
  starttransfer <= mux2_y_net_x0;

  accumulator: entity work.accumulator_3c9ca85b93
    port map (
      b(0) => convert_dout_net,
      ce => ce_1_sg_x1,
      clk => clk_1_sg_x1,
      clr => '0',
      en(0) => logical1_y_net,
      rst(0) => logical_y_net_x2,
      q => accumulator_q_net
    );

  accumulator1: entity work.accumulator1_c27a5ffacb
    port map (
      b(0) => convert1_dout_net,
      ce => ce_1_sg_x1,
      clk => clk_1_sg_x1,
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
      core_name0 => "adder_subtracter_virtex2p_7_0_219d4ec01152994f",
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
      a => from_register3_1_opb12_12_q_net_x0,
      b(0) => constant3_op_net,
      ce => ce_1_sg_x1,
      clk => clk_1_sg_x1,
      clr => '0',
      en => "1",
      s => addsub_s_net
    );

  concat: entity work.concat_f96b9412f2
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0 => from_register1_1_opb10_10_q_net_x0,
      in1 => mux_y_net,
      y => concat_y_net
    );

  concat1: entity work.concat1_2ac6567a3e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0 => slice_y_net,
      in1(0) => inverter_op_net,
      y => concat1_y_net
    );

  concat2: entity work.concat2_8a85d2cc10
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0(0) => inverter1_op_net,
      in1 => slice2_y_net,
      y => concat2_y_net_x0
    );

  constant1: entity work.constant1_4b9555fd30
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant1_op_net
    );

  constant11: entity work.constant11_70078828c1
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant11_op_net
    );

  constant2: entity work.constant2_0654d2f81a
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant2_op_net
    );

  constant3: entity work.constant3_0cf35d0c4a
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant3_op_net
    );

  constant4: entity work.constant4_f29fd03492
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant4_op_net
    );

  constant5: entity work.constant5_05127ac58f
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant5_op_net
    );

  constant6: entity work.constant6_fd460e8414
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant6_op_net
    );

  constant_x0: entity work.constant_2d9b97cb9a
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant_op_net
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
      ce => ce_1_sg_x1,
      clk => clk_1_sg_x1,
      clr => '0',
      din(0) => logical_y_net_x0,
      dout(0) => convert2_dout_net
    );

  counter: entity work.xlcounter_free
    generic map (
      core_name0 => "binary_counter_virtex2p_7_0_016610e0863621bf",
      op_arith => xlUnsigned,
      op_width => 7
    )
    port map (
      ce => ce_1_sg_x1,
      clk => clk_1_sg_x1,
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
      core_name0 => "binary_counter_virtex2p_7_0_18e84c36111bc674",
      count_limited => 1,
      op_arith => xlUnsigned,
      op_width => 15
    )
    port map (
      ce => ce_1_sg_x1,
      clk => clk_1_sg_x1,
      clr => '0',
      en(0) => logical2_y_net,
      rst(0) => convert1_dout_net_x2,
      op => counter1_op_net
    );

  delay: entity work.xldelay
    generic map (
      d_width => 1,
      en_width => 1,
      latency => 4,
      q_width => 1,
      reg_retiming => false,
      rst_width => 1
    )
    port map (
      ce => ce_1_sg_x1,
      clk => clk_1_sg_x1,
      clr => '0',
      d(0) => logical_y_net,
      en => "1",
      rst => "0",
      q(0) => delay_q_net
    );

  inverter: entity work.inverter_14bb39843b
    port map (
      ce => ce_1_sg_x1,
      clk => clk_1_sg_x1,
      clr => '0',
      ip(0) => slice1_y_net,
      op(0) => inverter_op_net
    );

  inverter1: entity work.inverter1_3fee9159a7
    port map (
      ce => ce_1_sg_x1,
      clk => clk_1_sg_x1,
      clr => '0',
      ip(0) => slice3_y_net,
      op(0) => inverter1_op_net
    );

  inverter2: entity work.inverter2_1b9490e500
    port map (
      ce => ce_1_sg_x1,
      clk => clk_1_sg_x1,
      clr => '0',
      ip(0) => relational_op_net,
      op(0) => inverter2_op_net
    );

  logical: entity work.logical_af271e0696
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => logical_y_net_x2,
      d1(0) => convert1_dout_net_x3,
      y(0) => logical_y_net
    );

  logical1: entity work.logical1_e4df6d4a9f
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => delay_q_net,
      d1(0) => relational_op_net,
      y(0) => logical1_y_net
    );

  logical2: entity work.logical2_137bc961d4
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => inverter2_op_net,
      d1(0) => convert1_dout_net_x3,
      y(0) => logical2_y_net
    );

  logical3: entity work.logical3_74d991d050
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => relational1_op_net,
      d1(0) => logical2_y_net,
      y(0) => logical3_y_net
    );

  mux: entity work.mux_afca224d2c
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => concat1_y_net,
      d1 => counter_op_net,
      sel(0) => from_register2_1_opb11_11_q_net_x0,
      y => mux_y_net
    );

  mux1: entity work.mux1_b57c0b6e47
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => constant2_op_net,
      d1(0) => delay_q_net,
      sel(0) => relational_op_net,
      y(0) => mux1_y_net
    );

  mux2: entity work.mux2_5692309004
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => mux1_y_net,
      d1(0) => delay_q_net,
      sel(0) => inverter2_op_net,
      y(0) => mux2_y_net_x0
    );

  mux3: entity work.mux3_ea5f65c51b
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => slice5_y_net,
      d1 => constant5_op_net,
      d2 => from_register1_opb0_0_q_net_x0,
      d3 => from_register2_opb1_1_q_net_x0,
      d4 => constant6_op_net,
      d5 => from_register4_opb3_3_q_net_x0,
      d6 => from_register5_opb4_4_q_net_x0,
      d7 => constant11_op_net,
      d8 => from_register3_opb2_2_q_net_x0,
      sel => accumulator1_q_net,
      y => mux3_y_net
    );

  neg_edge_detector_912b827dbd: entity work.neg_edge_detector_entity_912b827dbd
    port map (
      ce_1 => ce_1_sg_x1,
      clk_1 => clk_1_sg_x1,
      input_signal => slice4_y_net_x0,
      rising_edge => logical_y_net_x0
    );

  register_x0: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x1,
      clk => clk_1_sg_x1,
      d(0) => convert2_dout_net,
      en(0) => convert2_dout_net,
      rst(0) => convert1_dout_net_x2,
      q(0) => register_q_net_x0
    );

  relational: entity work.relational_3a38cb06fc
    port map (
      a => accumulator_q_net,
      b => addsub_s_net,
      ce => ce_1_sg_x1,
      clk => clk_1_sg_x1,
      clr => '0',
      op(0) => relational_op_net
    );

  relational1: entity work.relational1_e136eb66e8
    port map (
      a => accumulator1_q_net,
      b => constant4_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational1_op_net
    );

  slice: entity work.slice_94ce54bf1a
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => counter_op_net,
      y => slice_y_net
    );

  slice1: entity work.slice1_7895c5de63
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => counter_op_net,
      y(0) => slice1_y_net
    );

  slice2: entity work.slice2_55e27de7aa
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => mux3_y_net,
      y => slice2_y_net
    );

  slice3: entity work.slice3_51a5b1a945
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => mux3_y_net,
      y(0) => slice3_y_net
    );

  slice4: entity work.slice4_62929e0fae
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => counter1_op_net,
      y(0) => slice4_y_net_x0
    );

  slice5: entity work.slice5_f9ac9fec53
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => smwo_lcd_commands_douta_net,
      y => slice5_y_net
    );

  smwo_lcd_commands: entity work.xldpram
    generic map (
      c_address_width_a => 9,
      c_address_width_b => 8,
      c_width_a => 16,
      c_width_b => 32,
      core_name0 => "dual_port_block_memory_virtex2p_6_1_299a9f537bb5a43d",
      latency => 1
    )
    port map (
      a_ce => ce_1_sg_x1,
      a_clk => clk_1_sg_x1,
      addra => concat_y_net,
      addrb => smwoaddr_gwin_slice_sm1_y_net,
      b_ce => ce_1_sg_x1,
      b_clk => clk_1_sg_x1,
      dina => constant_op_net,
      dinb => smwodatai_gwin_force_sm1_output_port_net,
      ena => "1",
      enb => "1",
      rsta => "0",
      rstb => "0",
      wea(0) => constant1_op_net,
      web(0) => and_sm_1_y_net_x0,
      douta => smwo_lcd_commands_douta_net
    );

  smwoaddr_gwin_slice_sm1: entity work.smwoaddr_gwin_slice_sm1_384711ac8f
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => addrslice_y_net_x0,
      y => smwoaddr_gwin_slice_sm1_y_net
    );

  smwodatai_gwin_force_sm1: entity work.smwodatai_gwin_force_sm1_7de1968a9b
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => register2_q_net_x0,
      output_port => smwodatai_gwin_force_sm1_output_port_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller/DataROM/Pos_Edge_Detector"

entity pos_edge_detector_entity_6234e6e419 is
  port (
    ce_1: in std_logic;
    clk_1: in std_logic;
    input_signal: in std_logic;
    rising_edge: out std_logic
  );
end pos_edge_detector_entity_6234e6e419;

architecture structural of pos_edge_detector_entity_6234e6e419 is
  signal ce_1_sg_x2: std_logic;
  signal clk_1_sg_x2: std_logic;
  signal delay_q_net: std_logic;
  signal inverter_op_net: std_logic;
  signal logical_y_net_x0: std_logic;
  signal relational_op_net_x0: std_logic;

begin
  ce_1_sg_x2 <= ce_1;
  clk_1_sg_x2 <= clk_1;
  relational_op_net_x0 <= input_signal;
  rising_edge <= logical_y_net_x0;

  delay: entity work.xldelay
    generic map (
      d_width => 1,
      en_width => 1,
      latency => 1,
      q_width => 1,
      reg_retiming => false,
      rst_width => 1
    )
    port map (
      ce => ce_1_sg_x2,
      clk => clk_1_sg_x2,
      clr => '0',
      d(0) => inverter_op_net,
      en => "1",
      rst => "0",
      q(0) => delay_q_net
    );

  inverter: entity work.inverter_db9398644a
    port map (
      ce => ce_1_sg_x2,
      clk => clk_1_sg_x2,
      clr => '0',
      ip(0) => relational_op_net_x0,
      op(0) => inverter_op_net
    );

  logical: entity work.logical_8686a497b6
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

-- Generated from Simulink block "user_io_board_controller/DataROM/Subsystem"

entity subsystem_entity_efff7fc3ff is
  port (
    ce_1: in std_logic;
    clk_1: in std_logic;
    not0: in std_logic;
    transferdone: in std_logic;
    x6bitval: in std_logic;
    out1: out std_logic
  );
end subsystem_entity_efff7fc3ff;

architecture structural of subsystem_entity_efff7fc3ff is
  signal ce_1_sg_x3: std_logic;
  signal clk_1_sg_x3: std_logic;
  signal delay_q_net: std_logic;
  signal inverter2_op_net_x0: std_logic;
  signal logical1_y_net: std_logic;
  signal logical2_y_net: std_logic;
  signal logical3_y_net_x0: std_logic;
  signal logical_y_net_x0: std_logic;
  signal relational_op_net_x1: std_logic;

begin
  ce_1_sg_x3 <= ce_1;
  clk_1_sg_x3 <= clk_1;
  inverter2_op_net_x0 <= not0;
  logical_y_net_x0 <= transferdone;
  relational_op_net_x1 <= x6bitval;
  out1 <= logical3_y_net_x0;

  delay: entity work.xldelay
    generic map (
      d_width => 1,
      en_width => 1,
      latency => 1,
      q_width => 1,
      reg_retiming => false,
      rst_width => 1
    )
    port map (
      ce => ce_1_sg_x3,
      clk => clk_1_sg_x3,
      clr => '0',
      d(0) => logical_y_net_x0,
      en => "1",
      rst => "0",
      q(0) => delay_q_net
    );

  logical1: entity work.logical1_6f907bf3b7
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => inverter2_op_net_x0,
      d1(0) => delay_q_net,
      y(0) => logical1_y_net
    );

  logical2: entity work.logical2_aa2c43f34f
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => relational_op_net_x1,
      d1(0) => delay_q_net,
      y(0) => logical2_y_net
    );

  logical3: entity work.logical3_f755cf1b87
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

-- Generated from Simulink block "user_io_board_controller/DataROM/Subsystem1"

entity subsystem1_entity_008db081ac is
  port (
    ce_1: in std_logic;
    clk_1: in std_logic;
    x4bits: in std_logic_vector(3 downto 0);
    end_x0: out std_logic_vector(8 downto 0);
    start: out std_logic_vector(8 downto 0)
  );
end subsystem1_entity_008db081ac;

architecture structural of subsystem1_entity_008db081ac is
  signal addsub1_s_net_x0: std_logic_vector(8 downto 0);
  signal addsub_s_net_x0: std_logic_vector(8 downto 0);
  signal ce_1_sg_x4: std_logic;
  signal clk_1_sg_x4: std_logic;
  signal concat6_y_net: std_logic_vector(6 downto 0);
  signal constant1_op_net: std_logic_vector(7 downto 0);
  signal constant2_op_net: std_logic_vector(7 downto 0);
  signal constant_op_net: std_logic_vector(2 downto 0);
  signal slice10_y_net_x0: std_logic_vector(3 downto 0);

begin
  ce_1_sg_x4 <= ce_1;
  clk_1_sg_x4 <= clk_1;
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
      core_name0 => "adder_subtracter_virtex2p_7_0_2cb583e55ff51f1e",
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
      ce => ce_1_sg_x4,
      clk => clk_1_sg_x4,
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
      core_name0 => "adder_subtracter_virtex2p_7_0_2cb583e55ff51f1e",
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
      ce => ce_1_sg_x4,
      clk => clk_1_sg_x4,
      clr => '0',
      en => "1",
      s => addsub1_s_net_x0
    );

  concat6: entity work.concat6_f0fb592f91
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0 => slice10_y_net_x0,
      in1 => constant_op_net,
      y => concat6_y_net
    );

  constant1: entity work.constant1_6f919f6031
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant1_op_net
    );

  constant2: entity work.constant2_71ac01a44b
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant2_op_net
    );

  constant_x0: entity work.constant_a436df7149
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

-- Generated from Simulink block "user_io_board_controller/DataROM/Subsystem2"

entity subsystem2_entity_0207accbc7 is
  port (
    ce_1: in std_logic;
    clk_1: in std_logic;
    x4bits: in std_logic_vector(3 downto 0);
    end_x0: out std_logic_vector(8 downto 0);
    start: out std_logic_vector(8 downto 0)
  );
end subsystem2_entity_0207accbc7;

architecture structural of subsystem2_entity_0207accbc7 is
  signal addsub1_s_net_x0: std_logic_vector(8 downto 0);
  signal addsub_s_net_x0: std_logic_vector(8 downto 0);
  signal ce_1_sg_x5: std_logic;
  signal clk_1_sg_x5: std_logic;
  signal concat6_y_net: std_logic_vector(6 downto 0);
  signal constant1_op_net: std_logic_vector(7 downto 0);
  signal constant2_op_net: std_logic_vector(7 downto 0);
  signal constant_op_net: std_logic_vector(2 downto 0);
  signal slice11_y_net_x0: std_logic_vector(3 downto 0);

begin
  ce_1_sg_x5 <= ce_1;
  clk_1_sg_x5 <= clk_1;
  slice11_y_net_x0 <= x4bits;
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
      core_name0 => "adder_subtracter_virtex2p_7_0_2cb583e55ff51f1e",
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
      ce => ce_1_sg_x5,
      clk => clk_1_sg_x5,
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
      core_name0 => "adder_subtracter_virtex2p_7_0_2cb583e55ff51f1e",
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
      ce => ce_1_sg_x5,
      clk => clk_1_sg_x5,
      clr => '0',
      en => "1",
      s => addsub1_s_net_x0
    );

  concat6: entity work.concat6_47774cc3b9
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0 => slice11_y_net_x0,
      in1 => constant_op_net,
      y => concat6_y_net
    );

  constant1: entity work.constant1_808364abf9
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant1_op_net
    );

  constant2: entity work.constant2_6672388427
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant2_op_net
    );

  constant_x0: entity work.constant_07ae879661
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

-- Generated from Simulink block "user_io_board_controller/DataROM"

entity datarom_entity_76c8725483 is
  port (
    ce_1: in std_logic;
    clk_1: in std_logic;
    cmdsdone: in std_logic;
    in_5: in std_logic_vector(8 downto 0);
    in_6: in std_logic_vector(8 downto 0);
    in_7: in std_logic_vector(8 downto 0);
    in_8: in std_logic_vector(2 downto 0);
    invertramaddr: in std_logic;
    reset: in std_logic;
    smwoaddr_2: in std_logic_vector(13 downto 0);
    smwodatai_2: in std_logic_vector(31 downto 0);
    smwowe_1: in std_logic;
    smwowe_2: in std_logic;
    transferdone: in std_logic;
    data: out std_logic_vector(8 downto 0);
    starttransfer: out std_logic
  );
end datarom_entity_76c8725483;

architecture structural of datarom_entity_76c8725483 is
  signal addrslice_y_net_x1: std_logic_vector(13 downto 0);
  signal addsub1_s_net_x0: std_logic_vector(8 downto 0);
  signal addsub1_s_net_x1: std_logic_vector(8 downto 0);
  signal addsub_s_net_x0: std_logic_vector(8 downto 0);
  signal addsub_s_net_x1: std_logic_vector(8 downto 0);
  signal and_sm_2_y_net_x0: std_logic;
  signal and_sm_3_y_net_x0: std_logic;
  signal ce_1_sg_x6: std_logic;
  signal clk_1_sg_x6: std_logic;
  signal concat1_y_net: std_logic_vector(5 downto 0);
  signal concat2_y_net: std_logic_vector(7 downto 0);
  signal concat3_y_net: std_logic_vector(1 downto 0);
  signal concat4_y_net_x0: std_logic_vector(8 downto 0);
  signal concat5_y_net: std_logic_vector(8 downto 0);
  signal concat6_y_net: std_logic_vector(10 downto 0);
  signal concat_y_net: std_logic_vector(13 downto 0);
  signal constant10_op_net: std_logic;
  signal constant1_op_net: std_logic;
  signal constant2_op_net: std_logic_vector(7 downto 0);
  signal constant3_op_net: std_logic;
  signal constant4_op_net: std_logic;
  signal constant5_op_net: std_logic;
  signal constant6_op_net: std_logic_vector(2 downto 0);
  signal constant7_op_net: std_logic_vector(2 downto 0);
  signal constant8_op_net: std_logic_vector(2 downto 0);
  signal constant9_op_net: std_logic;
  signal constant_op_net: std_logic_vector(7 downto 0);
  signal convert1_dout_net: std_logic;
  signal convert1_dout_net_x4: std_logic;
  signal convert1_dout_net_x5: std_logic;
  signal convert_dout_net: std_logic;
  signal counter1_op_net: std_logic_vector(13 downto 0);
  signal counter_op_net: std_logic_vector(2 downto 0);
  signal delay_q_net_x0: std_logic;
  signal from_register1_0_opb5_5_q_net_x0: std_logic_vector(8 downto 0);
  signal from_register2_0_opb6_6_q_net_x0: std_logic_vector(8 downto 0);
  signal from_register3_0_opb7_7_q_net_x0: std_logic_vector(8 downto 0);
  signal from_register4_0_opb8_8_q_net_x0: std_logic_vector(2 downto 0);
  signal from_register7_opb16_16_q_net_x0: std_logic;
  signal inverter1_op_net: std_logic_vector(1 downto 0);
  signal inverter2_op_net_x0: std_logic;
  signal inverter3_op_net: std_logic;
  signal inverter_op_net: std_logic_vector(1 downto 0);
  signal logical1_y_net: std_logic;
  signal logical3_y_net_x0: std_logic;
  signal logical_y_net_x0: std_logic;
  signal logical_y_net_x1: std_logic;
  signal mux1_y_net: std_logic_vector(7 downto 0);
  signal mux2_y_net: std_logic_vector(2 downto 0);
  signal mux3_y_net: std_logic_vector(8 downto 0);
  signal mux_y_net: std_logic_vector(5 downto 0);
  signal register2_q_net_x1: std_logic_vector(31 downto 0);
  signal register_q_net_x1: std_logic;
  signal relational1_op_net: std_logic;
  signal relational2_op_net: std_logic;
  signal relational_op_net_x1: std_logic;
  signal slice10_y_net_x0: std_logic_vector(3 downto 0);
  signal slice11_y_net_x0: std_logic_vector(3 downto 0);
  signal slice1_y_net: std_logic_vector(1 downto 0);
  signal slice2_y_net: std_logic_vector(5 downto 0);
  signal slice3_y_net: std_logic_vector(1 downto 0);
  signal slice4_y_net: std_logic_vector(7 downto 0);
  signal slice5_y_net: std_logic_vector(5 downto 0);
  signal slice6_y_net: std_logic_vector(5 downto 0);
  signal slice7_y_net: std_logic_vector(3 downto 0);
  signal slice8_y_net: std_logic_vector(7 downto 0);
  signal slice9_y_net: std_logic;
  signal slice_y_net: std_logic_vector(3 downto 0);
  signal smwo_lcd_charactermap_douta_net: std_logic_vector(7 downto 0);
  signal smwo_lcd_characters_douta_net: std_logic_vector(7 downto 0);
  signal smwoaddr_gwin1_slice_sm3_y_net: std_logic_vector(8 downto 0);
  signal smwoaddr_gwin_slice_sm2_y_net: std_logic_vector(11 downto 0);
  signal smwodatai_gwin1_force_sm3_output_port_net: std_logic_vector(31 downto 0);
  signal smwodatai_gwin_force_sm2_output_port_net: std_logic_vector(31 downto 0);

begin
  ce_1_sg_x6 <= ce_1;
  clk_1_sg_x6 <= clk_1;
  register_q_net_x1 <= cmdsdone;
  from_register1_0_opb5_5_q_net_x0 <= in_5;
  from_register2_0_opb6_6_q_net_x0 <= in_6;
  from_register3_0_opb7_7_q_net_x0 <= in_7;
  from_register4_0_opb8_8_q_net_x0 <= in_8;
  from_register7_opb16_16_q_net_x0 <= invertramaddr;
  convert1_dout_net_x4 <= reset;
  addrslice_y_net_x1 <= smwoaddr_2;
  register2_q_net_x1 <= smwodatai_2;
  and_sm_2_y_net_x0 <= smwowe_1;
  and_sm_3_y_net_x0 <= smwowe_2;
  convert1_dout_net_x5 <= transferdone;
  data <= concat4_y_net_x0;
  starttransfer <= delay_q_net_x0;

  concat: entity work.concat_a8a02f4a69
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0 => smwo_lcd_characters_douta_net,
      in1 => mux_y_net,
      y => concat_y_net
    );

  concat1: entity work.concat1_95451795d6
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0 => slice_y_net,
      in1 => inverter_op_net,
      y => concat1_y_net
    );

  concat2: entity work.concat2_a1c8ba0a60
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0 => slice2_y_net,
      in1 => inverter1_op_net,
      y => concat2_y_net
    );

  concat3: entity work.concat3_f0fe542e4c
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0(0) => convert_dout_net,
      in1(0) => convert1_dout_net,
      y => concat3_y_net
    );

  concat4: entity work.concat4_85eb6439b8
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0(0) => inverter3_op_net,
      in1 => slice8_y_net,
      y => concat4_y_net_x0
    );

  concat5: entity work.concat5_f055439ea6
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0(0) => constant10_op_net,
      in1 => smwo_lcd_charactermap_douta_net,
      y => concat5_y_net
    );

  concat6: entity work.concat6_99bafb6ad0
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0 => from_register4_0_opb8_8_q_net_x0,
      in1 => mux1_y_net,
      y => concat6_y_net
    );

  constant1: entity work.constant1_78aa2f613a
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant1_op_net
    );

  constant10: entity work.constant10_4cc6b4dadc
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant10_op_net
    );

  constant2: entity work.constant2_516311e534
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant2_op_net
    );

  constant3: entity work.constant3_a69f46751e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant3_op_net
    );

  constant4: entity work.constant4_b631a3cc54
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant4_op_net
    );

  constant5: entity work.constant5_f9409d3d9a
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant5_op_net
    );

  constant6: entity work.constant6_4cafadc435
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant6_op_net
    );

  constant7: entity work.constant7_9e0a2ceff8
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant7_op_net
    );

  constant8: entity work.constant8_9133e877a1
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant8_op_net
    );

  constant9: entity work.constant9_ed9e6bcfcf
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant9_op_net
    );

  constant_x0: entity work.constant_9690d5cc29
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant_op_net
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
      core_name0 => "binary_counter_virtex2p_7_0_edc7d761bd25890d",
      op_arith => xlUnsigned,
      op_width => 3
    )
    port map (
      ce => ce_1_sg_x6,
      clk => clk_1_sg_x6,
      clr => '0',
      din => mux2_y_net,
      en(0) => logical3_y_net_x0,
      load(0) => logical_y_net_x1,
      rst => "0",
      op => counter_op_net
    );

  counter1: entity work.xlcounter_free
    generic map (
      core_name0 => "binary_counter_virtex2p_7_0_67ac1d95fffad199",
      op_arith => xlUnsigned,
      op_width => 14
    )
    port map (
      ce => ce_1_sg_x6,
      clk => clk_1_sg_x6,
      clr => '0',
      en(0) => logical1_y_net,
      rst(0) => convert1_dout_net_x4,
      op => counter1_op_net
    );

  delay: entity work.xldelay
    generic map (
      d_width => 1,
      en_width => 1,
      latency => 4,
      q_width => 1,
      reg_retiming => false,
      rst_width => 1
    )
    port map (
      ce => ce_1_sg_x6,
      clk => clk_1_sg_x6,
      clr => '0',
      d(0) => logical_y_net_x0,
      en => "1",
      rst => "0",
      q(0) => delay_q_net_x0
    );

  inverter: entity work.inverter_dadc35f831
    port map (
      ce => ce_1_sg_x6,
      clk => clk_1_sg_x6,
      clr => '0',
      ip => slice1_y_net,
      op => inverter_op_net
    );

  inverter1: entity work.inverter1_d753f8ff8b
    port map (
      ce => ce_1_sg_x6,
      clk => clk_1_sg_x6,
      clr => '0',
      ip => slice3_y_net,
      op => inverter1_op_net
    );

  inverter2: entity work.inverter2_f4b7cb1bc8
    port map (
      ce => ce_1_sg_x6,
      clk => clk_1_sg_x6,
      clr => '0',
      ip(0) => relational2_op_net,
      op(0) => inverter2_op_net_x0
    );

  inverter3: entity work.inverter3_581a77b0cc
    port map (
      ce => ce_1_sg_x6,
      clk => clk_1_sg_x6,
      clr => '0',
      ip(0) => slice9_y_net,
      op(0) => inverter3_op_net
    );

  logical: entity work.logical_c9fa95a6ee
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => convert1_dout_net_x5,
      d1(0) => register_q_net_x1,
      y(0) => logical_y_net_x0
    );

  logical1: entity work.logical1_80feb6e83e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => relational2_op_net,
      d1(0) => logical_y_net_x0,
      y(0) => logical1_y_net
    );

  mux: entity work.mux_cf3712e248
    port map (
      ce => ce_1_sg_x6,
      clk => clk_1_sg_x6,
      clr => '0',
      d0 => concat1_y_net,
      d1 => slice5_y_net,
      sel(0) => from_register7_opb16_16_q_net_x0,
      y => mux_y_net
    );

  mux1: entity work.mux1_27f053850a
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => concat2_y_net,
      d1 => slice4_y_net,
      sel(0) => from_register7_opb16_16_q_net_x0,
      y => mux1_y_net
    );

  mux2: entity work.mux2_0966eeec41
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

  mux3: entity work.mux3_154f8a8ba6
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => concat5_y_net,
      d1 => from_register3_0_opb7_7_q_net_x0,
      d2 => addsub_s_net_x0,
      d3 => addsub1_s_net_x0,
      d4 => from_register1_0_opb5_5_q_net_x0,
      d5 => addsub_s_net_x1,
      d6 => addsub1_s_net_x1,
      d7 => from_register2_0_opb6_6_q_net_x0,
      sel => counter_op_net,
      y => mux3_y_net
    );

  pos_edge_detector_6234e6e419: entity work.pos_edge_detector_entity_6234e6e419
    port map (
      ce_1 => ce_1_sg_x6,
      clk_1 => clk_1_sg_x6,
      input_signal => relational_op_net_x1,
      rising_edge => logical_y_net_x1
    );

  relational: entity work.relational_da8953c20e
    port map (
      a => slice6_y_net,
      b(0) => constant4_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational_op_net_x1
    );

  relational1: entity work.relational1_cb43fc6412
    port map (
      a => slice7_y_net,
      b(0) => constant5_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational1_op_net
    );

  relational2: entity work.relational2_bb0fa497d9
    port map (
      a => counter_op_net,
      b(0) => constant9_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational2_op_net
    );

  slice: entity work.slice_02e16f9a36
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => slice5_y_net,
      y => slice_y_net
    );

  slice1: entity work.slice1_fc50c97c90
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => slice5_y_net,
      y => slice1_y_net
    );

  slice10: entity work.slice10_38adbb4dd2
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => counter1_op_net,
      y => slice10_y_net_x0
    );

  slice11: entity work.slice11_6a9141b419
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => counter1_op_net,
      y => slice11_y_net_x0
    );

  slice2: entity work.slice2_e306e72c5d
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => slice4_y_net,
      y => slice2_y_net
    );

  slice3: entity work.slice3_8ef56893c7
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => slice4_y_net,
      y => slice3_y_net
    );

  slice4: entity work.slice4_9967cd13bb
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => counter1_op_net,
      y => slice4_y_net
    );

  slice5: entity work.slice5_01d24d19d6
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => counter1_op_net,
      y => slice5_y_net
    );

  slice6: entity work.slice6_a810be6e87
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => counter1_op_net,
      y => slice6_y_net
    );

  slice7: entity work.slice7_c11cac2c76
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => counter1_op_net,
      y => slice7_y_net
    );

  slice8: entity work.slice8_57a08caed2
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => mux3_y_net,
      y => slice8_y_net
    );

  slice9: entity work.slice9_77924db8fb
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => mux3_y_net,
      y(0) => slice9_y_net
    );

  smwo_lcd_charactermap: entity work.xldpram
    generic map (
      c_address_width_a => 14,
      c_address_width_b => 12,
      c_width_a => 8,
      c_width_b => 32,
      core_name0 => "dual_port_block_memory_virtex2p_6_1_46032f721e0f73ab",
      latency => 1
    )
    port map (
      a_ce => ce_1_sg_x6,
      a_clk => clk_1_sg_x6,
      addra => concat_y_net,
      addrb => smwoaddr_gwin_slice_sm2_y_net,
      b_ce => ce_1_sg_x6,
      b_clk => clk_1_sg_x6,
      dina => constant_op_net,
      dinb => smwodatai_gwin_force_sm2_output_port_net,
      ena => "1",
      enb => "1",
      rsta => "0",
      rstb => "0",
      wea(0) => constant1_op_net,
      web(0) => and_sm_2_y_net_x0,
      douta => smwo_lcd_charactermap_douta_net
    );

  smwo_lcd_characters: entity work.xldpram
    generic map (
      c_address_width_a => 11,
      c_address_width_b => 9,
      c_width_a => 8,
      c_width_b => 32,
      core_name0 => "dual_port_block_memory_virtex2p_6_1_a4748ac34de4a8d3",
      latency => 1
    )
    port map (
      a_ce => ce_1_sg_x6,
      a_clk => clk_1_sg_x6,
      addra => concat6_y_net,
      addrb => smwoaddr_gwin1_slice_sm3_y_net,
      b_ce => ce_1_sg_x6,
      b_clk => clk_1_sg_x6,
      dina => constant2_op_net,
      dinb => smwodatai_gwin1_force_sm3_output_port_net,
      ena => "1",
      enb => "1",
      rsta => "0",
      rstb => "0",
      wea(0) => constant3_op_net,
      web(0) => and_sm_3_y_net_x0,
      douta => smwo_lcd_characters_douta_net
    );

  smwoaddr_gwin1_slice_sm3: entity work.smwoaddr_gwin1_slice_sm3_17d56a725c
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => addrslice_y_net_x1,
      y => smwoaddr_gwin1_slice_sm3_y_net
    );

  smwoaddr_gwin_slice_sm2: entity work.smwoaddr_gwin_slice_sm2_346764b442
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => addrslice_y_net_x1,
      y => smwoaddr_gwin_slice_sm2_y_net
    );

  smwodatai_gwin1_force_sm3: entity work.smwodatai_gwin1_force_sm3_79aa7db2fc
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => register2_q_net_x1,
      output_port => smwodatai_gwin1_force_sm3_output_port_net
    );

  smwodatai_gwin_force_sm2: entity work.smwodatai_gwin_force_sm2_e3a2563eaa
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => register2_q_net_x1,
      output_port => smwodatai_gwin_force_sm2_output_port_net
    );

  subsystem1_008db081ac: entity work.subsystem1_entity_008db081ac
    port map (
      ce_1 => ce_1_sg_x6,
      clk_1 => clk_1_sg_x6,
      x4bits => slice10_y_net_x0,
      end_x0 => addsub1_s_net_x0,
      start => addsub_s_net_x0
    );

  subsystem2_0207accbc7: entity work.subsystem2_entity_0207accbc7
    port map (
      ce_1 => ce_1_sg_x6,
      clk_1 => clk_1_sg_x6,
      x4bits => slice11_y_net_x0,
      end_x0 => addsub1_s_net_x1,
      start => addsub_s_net_x1
    );

  subsystem_efff7fc3ff: entity work.subsystem_entity_efff7fc3ff
    port map (
      ce_1 => ce_1_sg_x6,
      clk_1 => clk_1_sg_x6,
      not0 => inverter2_op_net_x0,
      transferdone => logical_y_net_x0,
      x6bitval => relational_op_net_x1,
      out1 => logical3_y_net_x0
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller/Memory Mapped I_O/IP2OPB_IF"

entity ip2opb_if_entity_86de1e84d1 is
  port (
    ce_1: in std_logic;
    clk_1: in std_logic;
    sgp_dbus_in: in std_logic_vector(31 downto 0);
    sgp_retry_in: in std_logic;
    sgp_xferack_in: in std_logic;
    register1_x0: out std_logic;
    register2_x0: out std_logic;
    register3_x0: out std_logic;
    register4_x0: out std_logic;
    register_x1: out std_logic_vector(31 downto 0)
  );
end ip2opb_if_entity_86de1e84d1;

architecture structural of ip2opb_if_entity_86de1e84d1 is
  signal ce_1_sg_x7: std_logic;
  signal clk_1_sg_x7: std_logic;
  signal constant2_op_net_x0: std_logic;
  signal delay_q_net_x0: std_logic;
  signal register1_q_net_x0: std_logic;
  signal register2_q_net_x0: std_logic;
  signal register3_q_net_x0: std_logic;
  signal register4_q_net_x0: std_logic;
  signal register_q_net_x0: std_logic_vector(31 downto 0);
  signal valid_data_y_net_x0: std_logic_vector(31 downto 0);

begin
  ce_1_sg_x7 <= ce_1;
  clk_1_sg_x7 <= clk_1;
  valid_data_y_net_x0 <= sgp_dbus_in;
  constant2_op_net_x0 <= sgp_retry_in;
  delay_q_net_x0 <= sgp_xferack_in;
  register1_x0 <= register1_q_net_x0;
  register2_x0 <= register2_q_net_x0;
  register3_x0 <= register3_q_net_x0;
  register4_x0 <= register4_q_net_x0;
  register_x1 <= register_q_net_x0;

  register1: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x7,
      clk => clk_1_sg_x7,
      d(0) => delay_q_net_x0,
      en => "1",
      rst => "0",
      q(0) => register1_q_net_x0
    );

  register2: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x7,
      clk => clk_1_sg_x7,
      d(0) => constant2_op_net_x0,
      en => "1",
      rst => "0",
      q(0) => register2_q_net_x0
    );

  register3: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x7,
      clk => clk_1_sg_x7,
      d(0) => constant2_op_net_x0,
      en => "1",
      rst => "0",
      q(0) => register3_q_net_x0
    );

  register4: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x7,
      clk => clk_1_sg_x7,
      d(0) => constant2_op_net_x0,
      en => "1",
      rst => "0",
      q(0) => register4_q_net_x0
    );

  register_x0: entity work.xlregister
    generic map (
      d_width => 32,
      init_value => b"00000000000000000000000000000000"
    )
    port map (
      ce => ce_1_sg_x7,
      clk => clk_1_sg_x7,
      d => valid_data_y_net_x0,
      en(0) => delay_q_net_x0,
      rst(0) => register1_q_net_x0,
      q => register_q_net_x0
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller/Memory Mapped I_O/OPB2IP_IF"

entity opb2ip_if_entity_b410420760 is
  port (
    ce_1: in std_logic;
    clk_1: in std_logic;
    opb_abus: in std_logic_vector(31 downto 0);
    opb_dbus: in std_logic_vector(31 downto 0);
    opb_rnw: in std_logic;
    opb_rst: in std_logic;
    opb_select: in std_logic;
    opb_abus_reg: out std_logic_vector(31 downto 0);
    opb_dbus_reg: out std_logic_vector(31 downto 0);
    opb_rnw_reg: out std_logic;
    opb_select_reg: out std_logic
  );
end opb2ip_if_entity_b410420760;

architecture structural of opb2ip_if_entity_b410420760 is
  signal ce_1_sg_x8: std_logic;
  signal clk_1_sg_x8: std_logic;
  signal opb_abus_net_x0: std_logic_vector(31 downto 0);
  signal opb_dbus_net_x0: std_logic_vector(31 downto 0);
  signal opb_rnw_net_x0: std_logic;
  signal opb_rst_net_x0: std_logic;
  signal opb_select_net_x0: std_logic;
  signal register2_q_net_x2: std_logic_vector(31 downto 0);
  signal register3_q_net_x0: std_logic;
  signal register4_q_net_x0: std_logic;
  signal register_q_net_x0: std_logic_vector(31 downto 0);

begin
  ce_1_sg_x8 <= ce_1;
  clk_1_sg_x8 <= clk_1;
  opb_abus_net_x0 <= opb_abus;
  opb_dbus_net_x0 <= opb_dbus;
  opb_rnw_net_x0 <= opb_rnw;
  opb_rst_net_x0 <= opb_rst;
  opb_select_net_x0 <= opb_select;
  opb_abus_reg <= register_q_net_x0;
  opb_dbus_reg <= register2_q_net_x2;
  opb_rnw_reg <= register3_q_net_x0;
  opb_select_reg <= register4_q_net_x0;

  register2: entity work.xlregister
    generic map (
      d_width => 32,
      init_value => b"00000000000000000000000000000000"
    )
    port map (
      ce => ce_1_sg_x8,
      clk => clk_1_sg_x8,
      d => opb_dbus_net_x0,
      en => "1",
      rst(0) => opb_rst_net_x0,
      q => register2_q_net_x2
    );

  register3: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x8,
      clk => clk_1_sg_x8,
      d(0) => opb_rnw_net_x0,
      en => "1",
      rst(0) => opb_rst_net_x0,
      q(0) => register3_q_net_x0
    );

  register4: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x8,
      clk => clk_1_sg_x8,
      d(0) => opb_select_net_x0,
      en => "1",
      rst(0) => opb_rst_net_x0,
      q(0) => register4_q_net_x0
    );

  register_x0: entity work.xlregister
    generic map (
      d_width => 32,
      init_value => b"00000000000000000000000000000000"
    )
    port map (
      ce => ce_1_sg_x8,
      clk => clk_1_sg_x8,
      d => opb_abus_net_x0,
      en => "1",
      rst(0) => opb_rst_net_x0,
      q => register_q_net_x0
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller/Memory Mapped I_O/ack_gen"

entity ack_gen_entity_04ab867b36 is
  port (
    ce_1: in std_logic;
    clk_1: in std_logic;
    ps: in std_logic;
    rst: in std_logic;
    ack: out std_logic
  );
end ack_gen_entity_04ab867b36;

architecture structural of ack_gen_entity_04ab867b36 is
  signal ce_1_sg_x9: std_logic;
  signal clk_1_sg_x9: std_logic;
  signal inverter1_op_net: std_logic;
  signal inverter2_op_net: std_logic;
  signal logical_y_net_x1: std_logic;
  signal logical_y_net_x2: std_logic;
  signal opb_rst_net_x1: std_logic;
  signal register_q_net: std_logic;

begin
  ce_1_sg_x9 <= ce_1;
  clk_1_sg_x9 <= clk_1;
  logical_y_net_x1 <= ps;
  opb_rst_net_x1 <= rst;
  ack <= logical_y_net_x2;

  inverter1: entity work.inverter1_2cc220ed9f
    port map (
      ce => ce_1_sg_x9,
      clk => clk_1_sg_x9,
      clr => '0',
      ip(0) => opb_rst_net_x1,
      op(0) => inverter1_op_net
    );

  inverter2: entity work.inverter2_ea511efb71
    port map (
      ce => ce_1_sg_x9,
      clk => clk_1_sg_x9,
      clr => '0',
      ip(0) => register_q_net,
      op(0) => inverter2_op_net
    );

  logical: entity work.logical_bc2e3d9aab
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => logical_y_net_x1,
      d1(0) => inverter2_op_net,
      d2(0) => inverter1_op_net,
      y(0) => logical_y_net_x2
    );

  register_x0: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x9,
      clk => clk_1_sg_x9,
      d(0) => logical_y_net_x1,
      en => "1",
      rst => "0",
      q(0) => register_q_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller/Memory Mapped I_O/en_gen"

entity en_gen_entity_dc0458dd9b is
  port (
    ack_in: in std_logic;
    addr: in std_logic_vector(31 downto 0);
    ce_1: in std_logic;
    clk_1: in std_logic;
    rnw: in std_logic;
    in_0_we: out std_logic;
    in_10_we: out std_logic;
    in_11_we: out std_logic;
    in_12_we: out std_logic;
    in_13_we: out std_logic;
    in_14_we: out std_logic;
    in_15_we: out std_logic;
    in_16_we: out std_logic;
    in_1_we: out std_logic;
    in_2_we: out std_logic;
    in_3_we: out std_logic;
    in_4_we: out std_logic;
    in_5_we: out std_logic;
    in_6_we: out std_logic;
    in_7_we: out std_logic;
    in_8_we: out std_logic;
    in_9_we: out std_logic;
    smwoaddr_2: out std_logic_vector(13 downto 0);
    smwowe_0: out std_logic;
    smwowe_1: out std_logic;
    smwowe_2: out std_logic
  );
end en_gen_entity_dc0458dd9b;

architecture structural of en_gen_entity_dc0458dd9b is
  signal addr_const_0_op_net: std_logic_vector(3 downto 0);
  signal addr_const_1_op_net: std_logic_vector(3 downto 0);
  signal addr_const_2_op_net: std_logic_vector(3 downto 0);
  signal addr_const_3_op_net: std_logic_vector(3 downto 0);
  signal addr_rel_0_op_net: std_logic;
  signal addr_rel_1_op_net: std_logic;
  signal addr_rel_2_op_net: std_logic;
  signal addr_rel_3_op_net: std_logic;
  signal addr_sub_s_net: std_logic_vector(3 downto 0);
  signal addrslice_y_net_x2: std_logic_vector(13 downto 0);
  signal and_sm_1_y_net_x1: std_logic;
  signal and_sm_2_y_net_x1: std_logic;
  signal and_sm_3_y_net_x1: std_logic;
  signal bankselect_slice_y_net: std_logic_vector(3 downto 0);
  signal baseaddress_const_op_net: std_logic_vector(31 downto 0);
  signal baseaddress_slice_y_net: std_logic_vector(3 downto 0);
  signal ce_1_sg_x10: std_logic;
  signal clk_1_sg_x10: std_logic;
  signal concat_y_net: std_logic_vector(6 downto 0);
  signal logical_y_net_x3: std_logic;
  signal not_reg_op_net: std_logic;
  signal not_sm_1_op_net: std_logic;
  signal not_sm_2_op_net: std_logic;
  signal not_sm_3_op_net: std_logic;
  signal or_y_net: std_logic;
  signal register3_q_net_x1: std_logic;
  signal register_q_net_x1: std_logic_vector(31 downto 0);
  signal slice_y_net: std_logic_vector(4 downto 0);
  signal write_const_0_op_net: std_logic_vector(6 downto 0);
  signal write_const_10_op_net: std_logic_vector(6 downto 0);
  signal write_const_11_op_net: std_logic_vector(6 downto 0);
  signal write_const_12_op_net: std_logic_vector(6 downto 0);
  signal write_const_13_op_net: std_logic_vector(6 downto 0);
  signal write_const_14_op_net: std_logic_vector(6 downto 0);
  signal write_const_15_op_net: std_logic_vector(6 downto 0);
  signal write_const_16_op_net: std_logic_vector(6 downto 0);
  signal write_const_1_op_net: std_logic_vector(6 downto 0);
  signal write_const_2_op_net: std_logic_vector(6 downto 0);
  signal write_const_3_op_net: std_logic_vector(6 downto 0);
  signal write_const_4_op_net: std_logic_vector(6 downto 0);
  signal write_const_5_op_net: std_logic_vector(6 downto 0);
  signal write_const_6_op_net: std_logic_vector(6 downto 0);
  signal write_const_7_op_net: std_logic_vector(6 downto 0);
  signal write_const_8_op_net: std_logic_vector(6 downto 0);
  signal write_const_9_op_net: std_logic_vector(6 downto 0);
  signal write_rel_0_op_net_x0: std_logic;
  signal write_rel_10_op_net_x0: std_logic;
  signal write_rel_11_op_net_x0: std_logic;
  signal write_rel_12_op_net_x0: std_logic;
  signal write_rel_13_op_net_x0: std_logic;
  signal write_rel_14_op_net_x0: std_logic;
  signal write_rel_15_op_net_x0: std_logic;
  signal write_rel_16_op_net_x0: std_logic;
  signal write_rel_1_op_net_x0: std_logic;
  signal write_rel_2_op_net_x0: std_logic;
  signal write_rel_3_op_net_x0: std_logic;
  signal write_rel_4_op_net_x0: std_logic;
  signal write_rel_5_op_net_x0: std_logic;
  signal write_rel_6_op_net_x0: std_logic;
  signal write_rel_7_op_net_x0: std_logic;
  signal write_rel_8_op_net_x0: std_logic;
  signal write_rel_9_op_net_x0: std_logic;

begin
  logical_y_net_x3 <= ack_in;
  register_q_net_x1 <= addr;
  ce_1_sg_x10 <= ce_1;
  clk_1_sg_x10 <= clk_1;
  register3_q_net_x1 <= rnw;
  in_0_we <= write_rel_0_op_net_x0;
  in_10_we <= write_rel_10_op_net_x0;
  in_11_we <= write_rel_11_op_net_x0;
  in_12_we <= write_rel_12_op_net_x0;
  in_13_we <= write_rel_13_op_net_x0;
  in_14_we <= write_rel_14_op_net_x0;
  in_15_we <= write_rel_15_op_net_x0;
  in_16_we <= write_rel_16_op_net_x0;
  in_1_we <= write_rel_1_op_net_x0;
  in_2_we <= write_rel_2_op_net_x0;
  in_3_we <= write_rel_3_op_net_x0;
  in_4_we <= write_rel_4_op_net_x0;
  in_5_we <= write_rel_5_op_net_x0;
  in_6_we <= write_rel_6_op_net_x0;
  in_7_we <= write_rel_7_op_net_x0;
  in_8_we <= write_rel_8_op_net_x0;
  in_9_we <= write_rel_9_op_net_x0;
  smwoaddr_2 <= addrslice_y_net_x2;
  smwowe_0 <= and_sm_1_y_net_x1;
  smwowe_1 <= and_sm_2_y_net_x1;
  smwowe_2 <= and_sm_3_y_net_x1;

  addr_const_0: entity work.addr_const_0_f0995ffa21
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => addr_const_0_op_net
    );

  addr_const_1: entity work.addr_const_1_8f22611e87
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => addr_const_1_op_net
    );

  addr_const_2: entity work.addr_const_2_3f26cdcc25
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => addr_const_2_op_net
    );

  addr_const_3: entity work.addr_const_3_45e48d0cb9
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => addr_const_3_op_net
    );

  addr_rel_0: entity work.addr_rel_0_056746e125
    port map (
      a => addr_sub_s_net,
      b => addr_const_0_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => addr_rel_0_op_net
    );

  addr_rel_1: entity work.addr_rel_1_df4882c7b1
    port map (
      a => addr_sub_s_net,
      b => addr_const_1_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => addr_rel_1_op_net
    );

  addr_rel_2: entity work.addr_rel_2_73df01b747
    port map (
      a => addr_sub_s_net,
      b => addr_const_2_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => addr_rel_2_op_net
    );

  addr_rel_3: entity work.addr_rel_3_4a4da643df
    port map (
      a => addr_sub_s_net,
      b => addr_const_3_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => addr_rel_3_op_net
    );

  addr_sub: entity work.xladdsub
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
      core_name0 => "adder_subtracter_virtex2p_7_0_cb748602b0616a72",
      extra_registers => 0,
      full_s_arith => 2,
      full_s_width => 5,
      latency => 0,
      mode => 2,
      overflow => 1,
      quantization => 1,
      s_arith => xlUnsigned,
      s_bin_pt => 0,
      s_width => 4
    )
    port map (
      a => bankselect_slice_y_net,
      b => baseaddress_slice_y_net,
      ce => ce_1_sg_x10,
      clk => clk_1_sg_x10,
      clr => '0',
      en => "1",
      s => addr_sub_s_net
    );

  addrslice: entity work.addrslice_0020d95084
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => register_q_net_x1,
      y => addrslice_y_net_x2
    );

  and_sm_1: entity work.and_sm_1_51a93160a7
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => logical_y_net_x3,
      d1(0) => not_sm_1_op_net,
      d2(0) => addr_rel_1_op_net,
      y(0) => and_sm_1_y_net_x1
    );

  and_sm_2: entity work.and_sm_2_66665a2381
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => logical_y_net_x3,
      d1(0) => not_sm_2_op_net,
      d2(0) => addr_rel_2_op_net,
      y(0) => and_sm_2_y_net_x1
    );

  and_sm_3: entity work.and_sm_3_0e8be78342
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => logical_y_net_x3,
      d1(0) => not_sm_3_op_net,
      d2(0) => addr_rel_3_op_net,
      y(0) => and_sm_3_y_net_x1
    );

  bankselect_slice: entity work.bankselect_slice_77f112ed2c
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => register_q_net_x1,
      y => bankselect_slice_y_net
    );

  baseaddress_const: entity work.baseaddress_const_bbb19a4f50
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => baseaddress_const_op_net
    );

  baseaddress_slice: entity work.baseaddress_slice_845736abc9
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => baseaddress_const_op_net,
      y => baseaddress_slice_y_net
    );

  concat: entity work.concat_6c365eb6a2
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0(0) => logical_y_net_x3,
      in1(0) => or_y_net,
      in2 => slice_y_net,
      y => concat_y_net
    );

  not_reg: entity work.not_reg_bcbed8dfd2
    port map (
      ce => ce_1_sg_x10,
      clk => clk_1_sg_x10,
      clr => '0',
      ip(0) => addr_rel_0_op_net,
      op(0) => not_reg_op_net
    );

  not_sm_1: entity work.not_sm_1_2571507f0e
    port map (
      ce => ce_1_sg_x10,
      clk => clk_1_sg_x10,
      clr => '0',
      ip(0) => register3_q_net_x1,
      op(0) => not_sm_1_op_net
    );

  not_sm_2: entity work.not_sm_2_71cbc2c5db
    port map (
      ce => ce_1_sg_x10,
      clk => clk_1_sg_x10,
      clr => '0',
      ip(0) => register3_q_net_x1,
      op(0) => not_sm_2_op_net
    );

  not_sm_3: entity work.not_sm_3_8528bb8de3
    port map (
      ce => ce_1_sg_x10,
      clk => clk_1_sg_x10,
      clr => '0',
      ip(0) => register3_q_net_x1,
      op(0) => not_sm_3_op_net
    );

  or_x0: entity work.or_f2c44fd675
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => register3_q_net_x1,
      d1(0) => not_reg_op_net,
      y(0) => or_y_net
    );

  slice: entity work.slice_df251b1ebb
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => register_q_net_x1,
      y => slice_y_net
    );

  write_const_0: entity work.write_const_0_08dfa33fe9
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => write_const_0_op_net
    );

  write_const_1: entity work.write_const_1_e8f7e1b380
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => write_const_1_op_net
    );

  write_const_10: entity work.write_const_10_8ad7c685c5
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => write_const_10_op_net
    );

  write_const_11: entity work.write_const_11_5fd7cddf89
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => write_const_11_op_net
    );

  write_const_12: entity work.write_const_12_2accb79d1c
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => write_const_12_op_net
    );

  write_const_13: entity work.write_const_13_d2d229197b
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => write_const_13_op_net
    );

  write_const_14: entity work.write_const_14_6b5eb26751
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => write_const_14_op_net
    );

  write_const_15: entity work.write_const_15_47c2c6143f
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => write_const_15_op_net
    );

  write_const_16: entity work.write_const_16_96a078b18d
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => write_const_16_op_net
    );

  write_const_2: entity work.write_const_2_a947acd322
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => write_const_2_op_net
    );

  write_const_3: entity work.write_const_3_2bd5e75e16
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => write_const_3_op_net
    );

  write_const_4: entity work.write_const_4_ca1c456b45
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => write_const_4_op_net
    );

  write_const_5: entity work.write_const_5_2439e286c1
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => write_const_5_op_net
    );

  write_const_6: entity work.write_const_6_a2d98339b4
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => write_const_6_op_net
    );

  write_const_7: entity work.write_const_7_6281aea655
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => write_const_7_op_net
    );

  write_const_8: entity work.write_const_8_7e68c4aa0c
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => write_const_8_op_net
    );

  write_const_9: entity work.write_const_9_8b38b8c100
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => write_const_9_op_net
    );

  write_rel_0: entity work.write_rel_0_8a527de935
    port map (
      a => concat_y_net,
      b => write_const_0_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => write_rel_0_op_net_x0
    );

  write_rel_1: entity work.write_rel_1_bbac354172
    port map (
      a => concat_y_net,
      b => write_const_1_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => write_rel_1_op_net_x0
    );

  write_rel_10: entity work.write_rel_10_c02387f564
    port map (
      a => concat_y_net,
      b => write_const_10_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => write_rel_10_op_net_x0
    );

  write_rel_11: entity work.write_rel_11_3a5922fcfa
    port map (
      a => concat_y_net,
      b => write_const_11_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => write_rel_11_op_net_x0
    );

  write_rel_12: entity work.write_rel_12_e9399fd5cb
    port map (
      a => concat_y_net,
      b => write_const_12_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => write_rel_12_op_net_x0
    );

  write_rel_13: entity work.write_rel_13_8425508f2c
    port map (
      a => concat_y_net,
      b => write_const_13_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => write_rel_13_op_net_x0
    );

  write_rel_14: entity work.write_rel_14_41383d23c9
    port map (
      a => concat_y_net,
      b => write_const_14_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => write_rel_14_op_net_x0
    );

  write_rel_15: entity work.write_rel_15_a5e8beac76
    port map (
      a => concat_y_net,
      b => write_const_15_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => write_rel_15_op_net_x0
    );

  write_rel_16: entity work.write_rel_16_61da6987ae
    port map (
      a => concat_y_net,
      b => write_const_16_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => write_rel_16_op_net_x0
    );

  write_rel_2: entity work.write_rel_2_80b9d47c54
    port map (
      a => concat_y_net,
      b => write_const_2_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => write_rel_2_op_net_x0
    );

  write_rel_3: entity work.write_rel_3_42fb2943d7
    port map (
      a => concat_y_net,
      b => write_const_3_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => write_rel_3_op_net_x0
    );

  write_rel_4: entity work.write_rel_4_f1b932d94c
    port map (
      a => concat_y_net,
      b => write_const_4_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => write_rel_4_op_net_x0
    );

  write_rel_5: entity work.write_rel_5_6f8091ca25
    port map (
      a => concat_y_net,
      b => write_const_5_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => write_rel_5_op_net_x0
    );

  write_rel_6: entity work.write_rel_6_e76a28131a
    port map (
      a => concat_y_net,
      b => write_const_6_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => write_rel_6_op_net_x0
    );

  write_rel_7: entity work.write_rel_7_910671a9c8
    port map (
      a => concat_y_net,
      b => write_const_7_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => write_rel_7_op_net_x0
    );

  write_rel_8: entity work.write_rel_8_f620d9bba5
    port map (
      a => concat_y_net,
      b => write_const_8_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => write_rel_8_op_net_x0
    );

  write_rel_9: entity work.write_rel_9_18386daa95
    port map (
      a => concat_y_net,
      b => write_const_9_op_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => write_rel_9_op_net_x0
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller/Memory Mapped I_O/mem_if_in"

entity mem_if_in_entity_8c87289dd9 is
  port (
    ce_1: in std_logic;
    clk_1: in std_logic;
    in_0_we: in std_logic;
    in_10_we: in std_logic;
    in_11_we: in std_logic;
    in_12_we: in std_logic;
    in_13_we: in std_logic;
    in_14_we: in std_logic;
    in_15_we: in std_logic;
    in_16_we: in std_logic;
    in_1_we: in std_logic;
    in_2_we: in std_logic;
    in_3_we: in std_logic;
    in_4_we: in std_logic;
    in_5_we: in std_logic;
    in_6_we: in std_logic;
    in_7_we: in std_logic;
    in_8_we: in std_logic;
    in_9_we: in std_logic;
    opb_dbus: in std_logic_vector(31 downto 0);
    in_0_data: out std_logic_vector(8 downto 0);
    in_10_data: out std_logic_vector(1 downto 0);
    in_11_data: out std_logic;
    in_12_data: out std_logic_vector(7 downto 0);
    in_13_data: out std_logic;
    in_14_data: out std_logic;
    in_15_data: out std_logic;
    in_16_data: out std_logic;
    in_1_data: out std_logic_vector(8 downto 0);
    in_2_data: out std_logic_vector(8 downto 0);
    in_3_data: out std_logic_vector(8 downto 0);
    in_4_data: out std_logic_vector(8 downto 0);
    in_5_data: out std_logic_vector(8 downto 0);
    in_6_data: out std_logic_vector(8 downto 0);
    in_7_data: out std_logic_vector(8 downto 0);
    in_8_data: out std_logic_vector(2 downto 0);
    in_9_data: out std_logic
  );
end mem_if_in_entity_8c87289dd9;

architecture structural of mem_if_in_entity_8c87289dd9 is
  signal ce_1_sg_x11: std_logic;
  signal clk_1_sg_x11: std_logic;
  signal convert_0_dout_net: std_logic_vector(8 downto 0);
  signal convert_10_dout_net: std_logic_vector(1 downto 0);
  signal convert_11_dout_net: std_logic;
  signal convert_12_dout_net: std_logic_vector(7 downto 0);
  signal convert_13_dout_net: std_logic;
  signal convert_14_dout_net: std_logic;
  signal convert_15_dout_net: std_logic;
  signal convert_16_dout_net: std_logic;
  signal convert_1_dout_net: std_logic_vector(8 downto 0);
  signal convert_2_dout_net: std_logic_vector(8 downto 0);
  signal convert_3_dout_net: std_logic_vector(8 downto 0);
  signal convert_4_dout_net: std_logic_vector(8 downto 0);
  signal convert_5_dout_net: std_logic_vector(8 downto 0);
  signal convert_6_dout_net: std_logic_vector(8 downto 0);
  signal convert_7_dout_net: std_logic_vector(8 downto 0);
  signal convert_8_dout_net: std_logic_vector(2 downto 0);
  signal convert_9_dout_net: std_logic;
  signal from_register1_0_opb5_5_q_net_x1: std_logic_vector(8 downto 0);
  signal from_register1_1_opb10_10_q_net_x1: std_logic_vector(1 downto 0);
  signal from_register1_opb0_0_q_net_x1: std_logic_vector(8 downto 0);
  signal from_register2_0_opb6_6_q_net_x1: std_logic_vector(8 downto 0);
  signal from_register2_1_opb11_11_q_net_x1: std_logic;
  signal from_register2_opb1_1_q_net_x1: std_logic_vector(8 downto 0);
  signal from_register3_0_opb7_7_q_net_x1: std_logic_vector(8 downto 0);
  signal from_register3_1_opb12_12_q_net_x1: std_logic_vector(7 downto 0);
  signal from_register3_opb2_2_q_net_x1: std_logic_vector(8 downto 0);
  signal from_register4_0_opb8_8_q_net_x1: std_logic_vector(2 downto 0);
  signal from_register4_1_opb13_13_q_net_x0: std_logic;
  signal from_register4_opb3_3_q_net_x1: std_logic_vector(8 downto 0);
  signal from_register5_0_opb14_14_q_net_x0: std_logic;
  signal from_register5_opb4_4_q_net_x1: std_logic_vector(8 downto 0);
  signal from_register6_opb15_15_q_net_x0: std_logic;
  signal from_register7_opb16_16_q_net_x1: std_logic;
  signal from_register_opb9_9_q_net_x0: std_logic;
  signal register2_q_net_x3: std_logic_vector(31 downto 0);
  signal reinterpret_0_output_port_net: std_logic_vector(31 downto 0);
  signal reinterpret_10_output_port_net: std_logic_vector(31 downto 0);
  signal reinterpret_11_output_port_net: std_logic_vector(31 downto 0);
  signal reinterpret_12_output_port_net: std_logic_vector(31 downto 0);
  signal reinterpret_13_output_port_net: std_logic_vector(31 downto 0);
  signal reinterpret_14_output_port_net: std_logic_vector(31 downto 0);
  signal reinterpret_15_output_port_net: std_logic_vector(31 downto 0);
  signal reinterpret_16_output_port_net: std_logic_vector(31 downto 0);
  signal reinterpret_1_output_port_net: std_logic_vector(31 downto 0);
  signal reinterpret_2_output_port_net: std_logic_vector(31 downto 0);
  signal reinterpret_3_output_port_net: std_logic_vector(31 downto 0);
  signal reinterpret_4_output_port_net: std_logic_vector(31 downto 0);
  signal reinterpret_5_output_port_net: std_logic_vector(31 downto 0);
  signal reinterpret_6_output_port_net: std_logic_vector(31 downto 0);
  signal reinterpret_7_output_port_net: std_logic_vector(31 downto 0);
  signal reinterpret_8_output_port_net: std_logic_vector(31 downto 0);
  signal reinterpret_9_output_port_net: std_logic_vector(31 downto 0);
  signal write_rel_0_op_net_x1: std_logic;
  signal write_rel_10_op_net_x1: std_logic;
  signal write_rel_11_op_net_x1: std_logic;
  signal write_rel_12_op_net_x1: std_logic;
  signal write_rel_13_op_net_x1: std_logic;
  signal write_rel_14_op_net_x1: std_logic;
  signal write_rel_15_op_net_x1: std_logic;
  signal write_rel_16_op_net_x1: std_logic;
  signal write_rel_1_op_net_x1: std_logic;
  signal write_rel_2_op_net_x1: std_logic;
  signal write_rel_3_op_net_x1: std_logic;
  signal write_rel_4_op_net_x1: std_logic;
  signal write_rel_5_op_net_x1: std_logic;
  signal write_rel_6_op_net_x1: std_logic;
  signal write_rel_7_op_net_x1: std_logic;
  signal write_rel_8_op_net_x1: std_logic;
  signal write_rel_9_op_net_x1: std_logic;

begin
  ce_1_sg_x11 <= ce_1;
  clk_1_sg_x11 <= clk_1;
  write_rel_0_op_net_x1 <= in_0_we;
  write_rel_10_op_net_x1 <= in_10_we;
  write_rel_11_op_net_x1 <= in_11_we;
  write_rel_12_op_net_x1 <= in_12_we;
  write_rel_13_op_net_x1 <= in_13_we;
  write_rel_14_op_net_x1 <= in_14_we;
  write_rel_15_op_net_x1 <= in_15_we;
  write_rel_16_op_net_x1 <= in_16_we;
  write_rel_1_op_net_x1 <= in_1_we;
  write_rel_2_op_net_x1 <= in_2_we;
  write_rel_3_op_net_x1 <= in_3_we;
  write_rel_4_op_net_x1 <= in_4_we;
  write_rel_5_op_net_x1 <= in_5_we;
  write_rel_6_op_net_x1 <= in_6_we;
  write_rel_7_op_net_x1 <= in_7_we;
  write_rel_8_op_net_x1 <= in_8_we;
  write_rel_9_op_net_x1 <= in_9_we;
  register2_q_net_x3 <= opb_dbus;
  in_0_data <= from_register1_opb0_0_q_net_x1;
  in_10_data <= from_register1_1_opb10_10_q_net_x1;
  in_11_data <= from_register2_1_opb11_11_q_net_x1;
  in_12_data <= from_register3_1_opb12_12_q_net_x1;
  in_13_data <= from_register4_1_opb13_13_q_net_x0;
  in_14_data <= from_register5_0_opb14_14_q_net_x0;
  in_15_data <= from_register6_opb15_15_q_net_x0;
  in_16_data <= from_register7_opb16_16_q_net_x1;
  in_1_data <= from_register2_opb1_1_q_net_x1;
  in_2_data <= from_register3_opb2_2_q_net_x1;
  in_3_data <= from_register4_opb3_3_q_net_x1;
  in_4_data <= from_register5_opb4_4_q_net_x1;
  in_5_data <= from_register1_0_opb5_5_q_net_x1;
  in_6_data <= from_register2_0_opb6_6_q_net_x1;
  in_7_data <= from_register3_0_opb7_7_q_net_x1;
  in_8_data <= from_register4_0_opb8_8_q_net_x1;
  in_9_data <= from_register_opb9_9_q_net_x0;

  convert_0: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 32,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 9,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din => reinterpret_0_output_port_net,
      dout => convert_0_dout_net
    );

  convert_1: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 32,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 9,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din => reinterpret_1_output_port_net,
      dout => convert_1_dout_net
    );

  convert_10: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 32,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 2,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din => reinterpret_10_output_port_net,
      dout => convert_10_dout_net
    );

  convert_11: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 32,
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
      din => reinterpret_11_output_port_net,
      dout(0) => convert_11_dout_net
    );

  convert_12: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 32,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 8,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din => reinterpret_12_output_port_net,
      dout => convert_12_dout_net
    );

  convert_13: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 32,
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
      din => reinterpret_13_output_port_net,
      dout(0) => convert_13_dout_net
    );

  convert_14: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 32,
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
      din => reinterpret_14_output_port_net,
      dout(0) => convert_14_dout_net
    );

  convert_15: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 32,
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
      din => reinterpret_15_output_port_net,
      dout(0) => convert_15_dout_net
    );

  convert_16: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 32,
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
      din => reinterpret_16_output_port_net,
      dout(0) => convert_16_dout_net
    );

  convert_2: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 32,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 9,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din => reinterpret_2_output_port_net,
      dout => convert_2_dout_net
    );

  convert_3: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 32,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 9,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din => reinterpret_3_output_port_net,
      dout => convert_3_dout_net
    );

  convert_4: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 32,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 9,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din => reinterpret_4_output_port_net,
      dout => convert_4_dout_net
    );

  convert_5: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 32,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 9,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din => reinterpret_5_output_port_net,
      dout => convert_5_dout_net
    );

  convert_6: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 32,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 9,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din => reinterpret_6_output_port_net,
      dout => convert_6_dout_net
    );

  convert_7: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 32,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 9,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din => reinterpret_7_output_port_net,
      dout => convert_7_dout_net
    );

  convert_8: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 32,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 3,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din => reinterpret_8_output_port_net,
      dout => convert_8_dout_net
    );

  convert_9: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 32,
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
      din => reinterpret_9_output_port_net,
      dout(0) => convert_9_dout_net
    );

  from_register1_0_opb5_5: entity work.xlregister
    generic map (
      d_width => 9,
      init_value => b"101110101"
    )
    port map (
      ce => ce_1_sg_x11,
      clk => clk_1_sg_x11,
      d => convert_5_dout_net,
      en(0) => write_rel_5_op_net_x1,
      rst => "0",
      q => from_register1_0_opb5_5_q_net_x1
    );

  from_register1_1_opb10_10: entity work.xlregister
    generic map (
      d_width => 2,
      init_value => b"00"
    )
    port map (
      ce => ce_1_sg_x11,
      clk => clk_1_sg_x11,
      d => convert_10_dout_net,
      en(0) => write_rel_10_op_net_x1,
      rst => "0",
      q => from_register1_1_opb10_10_q_net_x1
    );

  from_register1_opb0_0: entity work.xlregister
    generic map (
      d_width => 9,
      init_value => b"000000000"
    )
    port map (
      ce => ce_1_sg_x11,
      clk => clk_1_sg_x11,
      d => convert_0_dout_net,
      en(0) => write_rel_0_op_net_x1,
      rst => "0",
      q => from_register1_opb0_0_q_net_x1
    );

  from_register2_0_opb6_6: entity work.xlregister
    generic map (
      d_width => 9,
      init_value => b"101011100"
    )
    port map (
      ce => ce_1_sg_x11,
      clk => clk_1_sg_x11,
      d => convert_6_dout_net,
      en(0) => write_rel_6_op_net_x1,
      rst => "0",
      q => from_register2_0_opb6_6_q_net_x1
    );

  from_register2_1_opb11_11: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x11,
      clk => clk_1_sg_x11,
      d(0) => convert_11_dout_net,
      en(0) => write_rel_11_op_net_x1,
      rst => "0",
      q(0) => from_register2_1_opb11_11_q_net_x1
    );

  from_register2_opb1_1: entity work.xlregister
    generic map (
      d_width => 9,
      init_value => b"010000011"
    )
    port map (
      ce => ce_1_sg_x11,
      clk => clk_1_sg_x11,
      d => convert_1_dout_net,
      en(0) => write_rel_1_op_net_x1,
      rst => "0",
      q => from_register2_opb1_1_q_net_x1
    );

  from_register3_0_opb7_7: entity work.xlregister
    generic map (
      d_width => 9,
      init_value => b"100010101"
    )
    port map (
      ce => ce_1_sg_x11,
      clk => clk_1_sg_x11,
      d => convert_7_dout_net,
      en(0) => write_rel_7_op_net_x1,
      rst => "0",
      q => from_register3_0_opb7_7_q_net_x1
    );

  from_register3_1_opb12_12: entity work.xlregister
    generic map (
      d_width => 8,
      init_value => b"00001010"
    )
    port map (
      ce => ce_1_sg_x11,
      clk => clk_1_sg_x11,
      d => convert_12_dout_net,
      en(0) => write_rel_12_op_net_x1,
      rst => "0",
      q => from_register3_1_opb12_12_q_net_x1
    );

  from_register3_opb2_2: entity work.xlregister
    generic map (
      d_width => 9,
      init_value => b"000000000"
    )
    port map (
      ce => ce_1_sg_x11,
      clk => clk_1_sg_x11,
      d => convert_2_dout_net,
      en(0) => write_rel_2_op_net_x1,
      rst => "0",
      q => from_register3_opb2_2_q_net_x1
    );

  from_register4_0_opb8_8: entity work.xlregister
    generic map (
      d_width => 3,
      init_value => b"000"
    )
    port map (
      ce => ce_1_sg_x11,
      clk => clk_1_sg_x11,
      d => convert_8_dout_net,
      en(0) => write_rel_8_op_net_x1,
      rst => "0",
      q => from_register4_0_opb8_8_q_net_x1
    );

  from_register4_1_opb13_13: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x11,
      clk => clk_1_sg_x11,
      d(0) => convert_13_dout_net,
      en(0) => write_rel_13_op_net_x1,
      rst => "0",
      q(0) => from_register4_1_opb13_13_q_net_x0
    );

  from_register4_opb3_3: entity work.xlregister
    generic map (
      d_width => 9,
      init_value => b"000000000"
    )
    port map (
      ce => ce_1_sg_x11,
      clk => clk_1_sg_x11,
      d => convert_3_dout_net,
      en(0) => write_rel_3_op_net_x1,
      rst => "0",
      q => from_register4_opb3_3_q_net_x1
    );

  from_register5_0_opb14_14: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x11,
      clk => clk_1_sg_x11,
      d(0) => convert_14_dout_net,
      en(0) => write_rel_14_op_net_x1,
      rst => "0",
      q(0) => from_register5_0_opb14_14_q_net_x0
    );

  from_register5_opb4_4: entity work.xlregister
    generic map (
      d_width => 9,
      init_value => b"010000011"
    )
    port map (
      ce => ce_1_sg_x11,
      clk => clk_1_sg_x11,
      d => convert_4_dout_net,
      en(0) => write_rel_4_op_net_x1,
      rst => "0",
      q => from_register5_opb4_4_q_net_x1
    );

  from_register6_opb15_15: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"1"
    )
    port map (
      ce => ce_1_sg_x11,
      clk => clk_1_sg_x11,
      d(0) => convert_15_dout_net,
      en(0) => write_rel_15_op_net_x1,
      rst => "0",
      q(0) => from_register6_opb15_15_q_net_x0
    );

  from_register7_opb16_16: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"1"
    )
    port map (
      ce => ce_1_sg_x11,
      clk => clk_1_sg_x11,
      d(0) => convert_16_dout_net,
      en(0) => write_rel_16_op_net_x1,
      rst => "0",
      q(0) => from_register7_opb16_16_q_net_x1
    );

  from_register_opb9_9: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x11,
      clk => clk_1_sg_x11,
      d(0) => convert_9_dout_net,
      en(0) => write_rel_9_op_net_x1,
      rst => "0",
      q(0) => from_register_opb9_9_q_net_x0
    );

  reinterpret_0: entity work.reinterpret_0_30d8822341
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => register2_q_net_x3,
      output_port => reinterpret_0_output_port_net
    );

  reinterpret_1: entity work.reinterpret_1_2637d80113
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => register2_q_net_x3,
      output_port => reinterpret_1_output_port_net
    );

  reinterpret_10: entity work.reinterpret_10_dc5a913a14
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => register2_q_net_x3,
      output_port => reinterpret_10_output_port_net
    );

  reinterpret_11: entity work.reinterpret_11_18d5986613
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => register2_q_net_x3,
      output_port => reinterpret_11_output_port_net
    );

  reinterpret_12: entity work.reinterpret_12_d8cb68aff2
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => register2_q_net_x3,
      output_port => reinterpret_12_output_port_net
    );

  reinterpret_13: entity work.reinterpret_13_da2f3dfcfb
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => register2_q_net_x3,
      output_port => reinterpret_13_output_port_net
    );

  reinterpret_14: entity work.reinterpret_14_dc5e0e152e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => register2_q_net_x3,
      output_port => reinterpret_14_output_port_net
    );

  reinterpret_15: entity work.reinterpret_15_7a04276d04
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => register2_q_net_x3,
      output_port => reinterpret_15_output_port_net
    );

  reinterpret_16: entity work.reinterpret_16_be1d93be75
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => register2_q_net_x3,
      output_port => reinterpret_16_output_port_net
    );

  reinterpret_2: entity work.reinterpret_2_86b6c897b3
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => register2_q_net_x3,
      output_port => reinterpret_2_output_port_net
    );

  reinterpret_3: entity work.reinterpret_3_4a71c92358
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => register2_q_net_x3,
      output_port => reinterpret_3_output_port_net
    );

  reinterpret_4: entity work.reinterpret_4_08f87832dd
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => register2_q_net_x3,
      output_port => reinterpret_4_output_port_net
    );

  reinterpret_5: entity work.reinterpret_5_cdd14878a6
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => register2_q_net_x3,
      output_port => reinterpret_5_output_port_net
    );

  reinterpret_6: entity work.reinterpret_6_b56b6e0737
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => register2_q_net_x3,
      output_port => reinterpret_6_output_port_net
    );

  reinterpret_7: entity work.reinterpret_7_778adf93f8
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => register2_q_net_x3,
      output_port => reinterpret_7_output_port_net
    );

  reinterpret_8: entity work.reinterpret_8_cb1cfb6e22
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => register2_q_net_x3,
      output_port => reinterpret_8_output_port_net
    );

  reinterpret_9: entity work.reinterpret_9_f7edd0618b
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => register2_q_net_x3,
      output_port => reinterpret_9_output_port_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller/Memory Mapped I_O/mem_if_out/repeater"

entity repeater_entity_182357f20d is
  port (
    x1_bit_in: in std_logic;
    x32_bits_out: out std_logic_vector(31 downto 0)
  );
end repeater_entity_182357f20d;

architecture structural of repeater_entity_182357f20d is
  signal concat1_y_net: std_logic_vector(15 downto 0);
  signal concat2_y_net_x0: std_logic_vector(31 downto 0);
  signal concat_y_net: std_logic_vector(15 downto 0);
  signal delay_q_net_x1: std_logic;

begin
  delay_q_net_x1 <= x1_bit_in;
  x32_bits_out <= concat2_y_net_x0;

  concat: entity work.concat_2c955f0350
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0(0) => delay_q_net_x1,
      in1(0) => delay_q_net_x1,
      in10(0) => delay_q_net_x1,
      in11(0) => delay_q_net_x1,
      in12(0) => delay_q_net_x1,
      in13(0) => delay_q_net_x1,
      in14(0) => delay_q_net_x1,
      in15(0) => delay_q_net_x1,
      in2(0) => delay_q_net_x1,
      in3(0) => delay_q_net_x1,
      in4(0) => delay_q_net_x1,
      in5(0) => delay_q_net_x1,
      in6(0) => delay_q_net_x1,
      in7(0) => delay_q_net_x1,
      in8(0) => delay_q_net_x1,
      in9(0) => delay_q_net_x1,
      y => concat_y_net
    );

  concat1: entity work.concat1_1e4752a176
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0(0) => delay_q_net_x1,
      in1(0) => delay_q_net_x1,
      in10(0) => delay_q_net_x1,
      in11(0) => delay_q_net_x1,
      in12(0) => delay_q_net_x1,
      in13(0) => delay_q_net_x1,
      in14(0) => delay_q_net_x1,
      in15(0) => delay_q_net_x1,
      in2(0) => delay_q_net_x1,
      in3(0) => delay_q_net_x1,
      in4(0) => delay_q_net_x1,
      in5(0) => delay_q_net_x1,
      in6(0) => delay_q_net_x1,
      in7(0) => delay_q_net_x1,
      in8(0) => delay_q_net_x1,
      in9(0) => delay_q_net_x1,
      y => concat1_y_net
    );

  concat2: entity work.concat2_ad1502d31f
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      in0 => concat1_y_net,
      in1 => concat_y_net,
      y => concat2_y_net_x0
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller/Memory Mapped I_O/mem_if_out"

entity mem_if_out_entity_691c0cefe9 is
  port (
    ack_in: in std_logic;
    addr: in std_logic_vector(31 downto 0);
    ce_1: in std_logic;
    clk_1: in std_logic;
    in_0_data: in std_logic_vector(8 downto 0);
    in_10_data: in std_logic_vector(1 downto 0);
    in_11_data: in std_logic;
    in_12_data: in std_logic_vector(7 downto 0);
    in_13_data: in std_logic;
    in_14_data: in std_logic;
    in_15_data: in std_logic;
    in_16_data: in std_logic;
    in_1_data: in std_logic_vector(8 downto 0);
    in_2_data: in std_logic_vector(8 downto 0);
    in_3_data: in std_logic_vector(8 downto 0);
    in_4_data: in std_logic_vector(8 downto 0);
    in_5_data: in std_logic_vector(8 downto 0);
    in_6_data: in std_logic_vector(8 downto 0);
    in_7_data: in std_logic_vector(8 downto 0);
    in_8_data: in std_logic_vector(2 downto 0);
    in_9_data: in std_logic;
    out_17: in std_logic;
    ack_out: out std_logic;
    sgp_dbus: out std_logic_vector(31 downto 0)
  );
end mem_if_out_entity_691c0cefe9;

architecture structural of mem_if_out_entity_691c0cefe9 is
  signal a_correction_0_s_net: std_logic_vector(4 downto 0);
  signal cast_0_dout_net: std_logic_vector(31 downto 0);
  signal cast_10_dout_net: std_logic_vector(31 downto 0);
  signal cast_11_dout_net: std_logic_vector(31 downto 0);
  signal cast_12_dout_net: std_logic_vector(31 downto 0);
  signal cast_13_dout_net: std_logic_vector(31 downto 0);
  signal cast_14_dout_net: std_logic_vector(31 downto 0);
  signal cast_15_dout_net: std_logic_vector(31 downto 0);
  signal cast_16_dout_net: std_logic_vector(31 downto 0);
  signal cast_17_dout_net: std_logic_vector(31 downto 0);
  signal cast_1_dout_net: std_logic_vector(31 downto 0);
  signal cast_2_dout_net: std_logic_vector(31 downto 0);
  signal cast_3_dout_net: std_logic_vector(31 downto 0);
  signal cast_4_dout_net: std_logic_vector(31 downto 0);
  signal cast_5_dout_net: std_logic_vector(31 downto 0);
  signal cast_6_dout_net: std_logic_vector(31 downto 0);
  signal cast_7_dout_net: std_logic_vector(31 downto 0);
  signal cast_8_dout_net: std_logic_vector(31 downto 0);
  signal cast_9_dout_net: std_logic_vector(31 downto 0);
  signal ce_1_sg_x12: std_logic;
  signal clk_1_sg_x12: std_logic;
  signal concat2_y_net_x0: std_logic_vector(31 downto 0);
  signal const_0_op_net: std_logic;
  signal convert1_dout_net_x5: std_logic;
  signal delay_q_net_x2: std_logic;
  signal force_0_output_port_net: std_logic_vector(8 downto 0);
  signal force_10_output_port_net: std_logic_vector(1 downto 0);
  signal force_11_output_port_net: std_logic;
  signal force_12_output_port_net: std_logic_vector(7 downto 0);
  signal force_13_output_port_net: std_logic;
  signal force_14_output_port_net: std_logic;
  signal force_15_output_port_net: std_logic;
  signal force_16_output_port_net: std_logic;
  signal force_17_output_port_net: std_logic;
  signal force_1_output_port_net: std_logic_vector(8 downto 0);
  signal force_2_output_port_net: std_logic_vector(8 downto 0);
  signal force_3_output_port_net: std_logic_vector(8 downto 0);
  signal force_4_output_port_net: std_logic_vector(8 downto 0);
  signal force_5_output_port_net: std_logic_vector(8 downto 0);
  signal force_6_output_port_net: std_logic_vector(8 downto 0);
  signal force_7_output_port_net: std_logic_vector(8 downto 0);
  signal force_8_output_port_net: std_logic_vector(2 downto 0);
  signal force_9_output_port_net: std_logic;
  signal from_register1_0_opb5_5_q_net_x2: std_logic_vector(8 downto 0);
  signal from_register1_1_opb10_10_q_net_x2: std_logic_vector(1 downto 0);
  signal from_register1_opb0_0_q_net_x2: std_logic_vector(8 downto 0);
  signal from_register2_0_opb6_6_q_net_x2: std_logic_vector(8 downto 0);
  signal from_register2_1_opb11_11_q_net_x2: std_logic;
  signal from_register2_opb1_1_q_net_x2: std_logic_vector(8 downto 0);
  signal from_register3_0_opb7_7_q_net_x2: std_logic_vector(8 downto 0);
  signal from_register3_1_opb12_12_q_net_x2: std_logic_vector(7 downto 0);
  signal from_register3_opb2_2_q_net_x2: std_logic_vector(8 downto 0);
  signal from_register4_0_opb8_8_q_net_x2: std_logic_vector(2 downto 0);
  signal from_register4_1_opb13_13_q_net_x1: std_logic;
  signal from_register4_opb3_3_q_net_x2: std_logic_vector(8 downto 0);
  signal from_register5_0_opb14_14_q_net_x1: std_logic;
  signal from_register5_opb4_4_q_net_x2: std_logic_vector(8 downto 0);
  signal from_register6_opb15_15_q_net_x1: std_logic;
  signal from_register7_opb16_16_q_net_x2: std_logic;
  signal from_register_opb9_9_q_net_x1: std_logic;
  signal logical_y_net_x4: std_logic;
  signal mux_0_17_y_net: std_logic_vector(31 downto 0);
  signal register_q_net_x2: std_logic_vector(31 downto 0);
  signal slice_y_net: std_logic_vector(4 downto 0);
  signal to_register_opb0_17_q_net: std_logic;
  signal valid_data_y_net_x1: std_logic_vector(31 downto 0);

begin
  logical_y_net_x4 <= ack_in;
  register_q_net_x2 <= addr;
  ce_1_sg_x12 <= ce_1;
  clk_1_sg_x12 <= clk_1;
  from_register1_opb0_0_q_net_x2 <= in_0_data;
  from_register1_1_opb10_10_q_net_x2 <= in_10_data;
  from_register2_1_opb11_11_q_net_x2 <= in_11_data;
  from_register3_1_opb12_12_q_net_x2 <= in_12_data;
  from_register4_1_opb13_13_q_net_x1 <= in_13_data;
  from_register5_0_opb14_14_q_net_x1 <= in_14_data;
  from_register6_opb15_15_q_net_x1 <= in_15_data;
  from_register7_opb16_16_q_net_x2 <= in_16_data;
  from_register2_opb1_1_q_net_x2 <= in_1_data;
  from_register3_opb2_2_q_net_x2 <= in_2_data;
  from_register4_opb3_3_q_net_x2 <= in_3_data;
  from_register5_opb4_4_q_net_x2 <= in_4_data;
  from_register1_0_opb5_5_q_net_x2 <= in_5_data;
  from_register2_0_opb6_6_q_net_x2 <= in_6_data;
  from_register3_0_opb7_7_q_net_x2 <= in_7_data;
  from_register4_0_opb8_8_q_net_x2 <= in_8_data;
  from_register_opb9_9_q_net_x1 <= in_9_data;
  convert1_dout_net_x5 <= out_17;
  ack_out <= delay_q_net_x2;
  sgp_dbus <= valid_data_y_net_x1;

  a_correction_0: entity work.a_correction_0_215db66be8
    port map (
      a => slice_y_net,
      b(0) => const_0_op_net,
      ce => ce_1_sg_x12,
      clk => clk_1_sg_x12,
      clr => '0',
      s => a_correction_0_s_net
    );

  cast_0: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 9,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 32,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din => force_0_output_port_net,
      dout => cast_0_dout_net
    );

  cast_1: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 9,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 32,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din => force_1_output_port_net,
      dout => cast_1_dout_net
    );

  cast_10: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 2,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 32,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din => force_10_output_port_net,
      dout => cast_10_dout_net
    );

  cast_11: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 1,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 32,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din(0) => force_11_output_port_net,
      dout => cast_11_dout_net
    );

  cast_12: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 8,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 32,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din => force_12_output_port_net,
      dout => cast_12_dout_net
    );

  cast_13: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 1,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 32,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din(0) => force_13_output_port_net,
      dout => cast_13_dout_net
    );

  cast_14: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 1,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 32,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din(0) => force_14_output_port_net,
      dout => cast_14_dout_net
    );

  cast_15: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 1,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 32,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din(0) => force_15_output_port_net,
      dout => cast_15_dout_net
    );

  cast_16: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 1,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 32,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din(0) => force_16_output_port_net,
      dout => cast_16_dout_net
    );

  cast_17: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 1,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 32,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din(0) => force_17_output_port_net,
      dout => cast_17_dout_net
    );

  cast_2: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 9,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 32,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din => force_2_output_port_net,
      dout => cast_2_dout_net
    );

  cast_3: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 9,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 32,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din => force_3_output_port_net,
      dout => cast_3_dout_net
    );

  cast_4: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 9,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 32,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din => force_4_output_port_net,
      dout => cast_4_dout_net
    );

  cast_5: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 9,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 32,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din => force_5_output_port_net,
      dout => cast_5_dout_net
    );

  cast_6: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 9,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 32,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din => force_6_output_port_net,
      dout => cast_6_dout_net
    );

  cast_7: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 9,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 32,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din => force_7_output_port_net,
      dout => cast_7_dout_net
    );

  cast_8: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 3,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 32,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din => force_8_output_port_net,
      dout => cast_8_dout_net
    );

  cast_9: entity work.xlconvert
    generic map (
      bool_conversion => 0,
      din_arith => 1,
      din_bin_pt => 0,
      din_width => 1,
      dout_arith => 1,
      dout_bin_pt => 0,
      dout_width => 32,
      latency => 0,
      overflow => xlWrap,
      quantization => xlTruncate
    )
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      din(0) => force_9_output_port_net,
      dout => cast_9_dout_net
    );

  const_0: entity work.const_0_875565ddfa
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => const_0_op_net
    );

  delay: entity work.delay_fe9d77185b
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d(0) => logical_y_net_x4,
      q(0) => delay_q_net_x2
    );

  force_0: entity work.force_0_926b7f7642
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => from_register1_opb0_0_q_net_x2,
      output_port => force_0_output_port_net
    );

  force_1: entity work.force_1_6396c8c2be
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => from_register2_opb1_1_q_net_x2,
      output_port => force_1_output_port_net
    );

  force_10: entity work.force_10_7d19bea9a3
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => from_register1_1_opb10_10_q_net_x2,
      output_port => force_10_output_port_net
    );

  force_11: entity work.force_11_199b049259
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port(0) => from_register2_1_opb11_11_q_net_x2,
      output_port(0) => force_11_output_port_net
    );

  force_12: entity work.force_12_a7c5e649a9
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => from_register3_1_opb12_12_q_net_x2,
      output_port => force_12_output_port_net
    );

  force_13: entity work.force_13_04ba53f6fc
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port(0) => from_register4_1_opb13_13_q_net_x1,
      output_port(0) => force_13_output_port_net
    );

  force_14: entity work.force_14_12dfc422b4
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port(0) => from_register5_0_opb14_14_q_net_x1,
      output_port(0) => force_14_output_port_net
    );

  force_15: entity work.force_15_6984ae8d01
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port(0) => from_register6_opb15_15_q_net_x1,
      output_port(0) => force_15_output_port_net
    );

  force_16: entity work.force_16_506e50b36b
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port(0) => from_register7_opb16_16_q_net_x2,
      output_port(0) => force_16_output_port_net
    );

  force_17: entity work.force_17_5f7a1de601
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port(0) => to_register_opb0_17_q_net,
      output_port(0) => force_17_output_port_net
    );

  force_2: entity work.force_2_892a3cd76c
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => from_register3_opb2_2_q_net_x2,
      output_port => force_2_output_port_net
    );

  force_3: entity work.force_3_202adeb79d
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => from_register4_opb3_3_q_net_x2,
      output_port => force_3_output_port_net
    );

  force_4: entity work.force_4_10478396f6
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => from_register5_opb4_4_q_net_x2,
      output_port => force_4_output_port_net
    );

  force_5: entity work.force_5_bb148c070b
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => from_register1_0_opb5_5_q_net_x2,
      output_port => force_5_output_port_net
    );

  force_6: entity work.force_6_970280b756
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => from_register2_0_opb6_6_q_net_x2,
      output_port => force_6_output_port_net
    );

  force_7: entity work.force_7_fbe4c3a528
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => from_register3_0_opb7_7_q_net_x2,
      output_port => force_7_output_port_net
    );

  force_8: entity work.force_8_7e507ba849
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port => from_register4_0_opb8_8_q_net_x2,
      output_port => force_8_output_port_net
    );

  force_9: entity work.force_9_f25ebee362
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      input_port(0) => from_register_opb9_9_q_net_x1,
      output_port(0) => force_9_output_port_net
    );

  mux_0_17: entity work.mux_0_17_06f0a07b4b
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => cast_0_dout_net,
      d1 => cast_1_dout_net,
      d10 => cast_10_dout_net,
      d11 => cast_11_dout_net,
      d12 => cast_12_dout_net,
      d13 => cast_13_dout_net,
      d14 => cast_14_dout_net,
      d15 => cast_15_dout_net,
      d16 => cast_16_dout_net,
      d17 => cast_17_dout_net,
      d2 => cast_2_dout_net,
      d3 => cast_3_dout_net,
      d4 => cast_4_dout_net,
      d5 => cast_5_dout_net,
      d6 => cast_6_dout_net,
      d7 => cast_7_dout_net,
      d8 => cast_8_dout_net,
      d9 => cast_9_dout_net,
      sel => a_correction_0_s_net,
      y => mux_0_17_y_net
    );

  repeater_182357f20d: entity work.repeater_entity_182357f20d
    port map (
      x1_bit_in => delay_q_net_x2,
      x32_bits_out => concat2_y_net_x0
    );

  slice: entity work.slice_7c15b5c75c
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => register_q_net_x2,
      y => slice_y_net
    );

  to_register_opb0_17: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x12,
      clk => clk_1_sg_x12,
      d(0) => convert1_dout_net_x5,
      en(0) => convert1_dout_net_x5,
      rst => "0",
      q(0) => to_register_opb0_17_q_net
    );

  valid_data: entity work.valid_data_5dfe5a8f9e
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => mux_0_17_y_net,
      d1 => concat2_y_net_x0,
      y => valid_data_y_net_x1
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller/Memory Mapped I_O"

entity memory_mapped_i_o_entity_8628bc2130 is
  port (
    ce_1: in std_logic;
    clk_1: in std_logic;
    convert1: in std_logic;
    opb_abus: in std_logic_vector(31 downto 0);
    opb_dbus: in std_logic_vector(31 downto 0);
    opb_rnw: in std_logic;
    opb_rst: in std_logic;
    opb_select: in std_logic;
    ps: in std_logic;
    a_valid: out std_logic;
    addr: out std_logic_vector(31 downto 0);
    en_gen: out std_logic_vector(13 downto 0);
    en_gen_x0: out std_logic;
    en_gen_x1: out std_logic;
    en_gen_x2: out std_logic;
    ip2opb_if: out std_logic_vector(31 downto 0);
    ip2opb_if_x0: out std_logic;
    ip2opb_if_x1: out std_logic;
    ip2opb_if_x2: out std_logic;
    ip2opb_if_x3: out std_logic;
    mem_if_in: out std_logic_vector(8 downto 0);
    mem_if_in_x0: out std_logic_vector(1 downto 0);
    mem_if_in_x1: out std_logic_vector(8 downto 0);
    mem_if_in_x10: out std_logic_vector(8 downto 0);
    mem_if_in_x11: out std_logic;
    mem_if_in_x12: out std_logic_vector(8 downto 0);
    mem_if_in_x13: out std_logic;
    mem_if_in_x14: out std_logic;
    mem_if_in_x15: out std_logic;
    mem_if_in_x2: out std_logic_vector(8 downto 0);
    mem_if_in_x3: out std_logic;
    mem_if_in_x4: out std_logic_vector(8 downto 0);
    mem_if_in_x5: out std_logic_vector(8 downto 0);
    mem_if_in_x6: out std_logic_vector(7 downto 0);
    mem_if_in_x7: out std_logic_vector(8 downto 0);
    mem_if_in_x8: out std_logic_vector(2 downto 0);
    mem_if_in_x9: out std_logic;
    smwodatai_0: out std_logic_vector(31 downto 0)
  );
end memory_mapped_i_o_entity_8628bc2130;

architecture structural of memory_mapped_i_o_entity_8628bc2130 is
  signal addrslice_y_net_x3: std_logic_vector(13 downto 0);
  signal and_sm_1_y_net_x2: std_logic;
  signal and_sm_2_y_net_x2: std_logic;
  signal and_sm_3_y_net_x2: std_logic;
  signal ce_1_sg_x13: std_logic;
  signal clk_1_sg_x13: std_logic;
  signal constant2_op_net_x0: std_logic;
  signal convert1_dout_net_x6: std_logic;
  signal delay_q_net_x2: std_logic;
  signal from_register1_0_opb5_5_q_net_x3: std_logic_vector(8 downto 0);
  signal from_register1_1_opb10_10_q_net_x3: std_logic_vector(1 downto 0);
  signal from_register1_opb0_0_q_net_x3: std_logic_vector(8 downto 0);
  signal from_register2_0_opb6_6_q_net_x3: std_logic_vector(8 downto 0);
  signal from_register2_1_opb11_11_q_net_x3: std_logic;
  signal from_register2_opb1_1_q_net_x3: std_logic_vector(8 downto 0);
  signal from_register3_0_opb7_7_q_net_x3: std_logic_vector(8 downto 0);
  signal from_register3_1_opb12_12_q_net_x3: std_logic_vector(7 downto 0);
  signal from_register3_opb2_2_q_net_x3: std_logic_vector(8 downto 0);
  signal from_register4_0_opb8_8_q_net_x3: std_logic_vector(2 downto 0);
  signal from_register4_1_opb13_13_q_net_x2: std_logic;
  signal from_register4_opb3_3_q_net_x3: std_logic_vector(8 downto 0);
  signal from_register5_0_opb14_14_q_net_x2: std_logic;
  signal from_register5_opb4_4_q_net_x3: std_logic_vector(8 downto 0);
  signal from_register6_opb15_15_q_net_x2: std_logic;
  signal from_register7_opb16_16_q_net_x3: std_logic;
  signal from_register_opb9_9_q_net_x2: std_logic;
  signal logical_y_net_x4: std_logic;
  signal logical_y_net_x5: std_logic;
  signal opb_abus_net_x1: std_logic_vector(31 downto 0);
  signal opb_dbus_net_x1: std_logic_vector(31 downto 0);
  signal opb_rnw_net_x1: std_logic;
  signal opb_rst_net_x2: std_logic;
  signal opb_select_net_x1: std_logic;
  signal register1_q_net_x1: std_logic;
  signal register2_q_net_x4: std_logic;
  signal register2_q_net_x5: std_logic_vector(31 downto 0);
  signal register3_q_net_x1: std_logic;
  signal register3_q_net_x2: std_logic;
  signal register4_q_net_x2: std_logic;
  signal register4_q_net_x3: std_logic;
  signal register_q_net_x1: std_logic_vector(31 downto 0);
  signal register_q_net_x3: std_logic_vector(31 downto 0);
  signal valid_data_y_net_x1: std_logic_vector(31 downto 0);
  signal write_rel_0_op_net_x1: std_logic;
  signal write_rel_10_op_net_x1: std_logic;
  signal write_rel_11_op_net_x1: std_logic;
  signal write_rel_12_op_net_x1: std_logic;
  signal write_rel_13_op_net_x1: std_logic;
  signal write_rel_14_op_net_x1: std_logic;
  signal write_rel_15_op_net_x1: std_logic;
  signal write_rel_16_op_net_x1: std_logic;
  signal write_rel_1_op_net_x1: std_logic;
  signal write_rel_2_op_net_x1: std_logic;
  signal write_rel_3_op_net_x1: std_logic;
  signal write_rel_4_op_net_x1: std_logic;
  signal write_rel_5_op_net_x1: std_logic;
  signal write_rel_6_op_net_x1: std_logic;
  signal write_rel_7_op_net_x1: std_logic;
  signal write_rel_8_op_net_x1: std_logic;
  signal write_rel_9_op_net_x1: std_logic;

begin
  ce_1_sg_x13 <= ce_1;
  clk_1_sg_x13 <= clk_1;
  convert1_dout_net_x6 <= convert1;
  opb_abus_net_x1 <= opb_abus;
  opb_dbus_net_x1 <= opb_dbus;
  opb_rnw_net_x1 <= opb_rnw;
  opb_rst_net_x2 <= opb_rst;
  opb_select_net_x1 <= opb_select;
  logical_y_net_x5 <= ps;
  a_valid <= register4_q_net_x3;
  addr <= register_q_net_x3;
  en_gen <= addrslice_y_net_x3;
  en_gen_x0 <= and_sm_1_y_net_x2;
  en_gen_x1 <= and_sm_2_y_net_x2;
  en_gen_x2 <= and_sm_3_y_net_x2;
  ip2opb_if <= register_q_net_x1;
  ip2opb_if_x0 <= register1_q_net_x1;
  ip2opb_if_x1 <= register2_q_net_x4;
  ip2opb_if_x2 <= register3_q_net_x2;
  ip2opb_if_x3 <= register4_q_net_x2;
  mem_if_in <= from_register1_0_opb5_5_q_net_x3;
  mem_if_in_x0 <= from_register1_1_opb10_10_q_net_x3;
  mem_if_in_x1 <= from_register1_opb0_0_q_net_x3;
  mem_if_in_x10 <= from_register4_opb3_3_q_net_x3;
  mem_if_in_x11 <= from_register5_0_opb14_14_q_net_x2;
  mem_if_in_x12 <= from_register5_opb4_4_q_net_x3;
  mem_if_in_x13 <= from_register6_opb15_15_q_net_x2;
  mem_if_in_x14 <= from_register7_opb16_16_q_net_x3;
  mem_if_in_x15 <= from_register_opb9_9_q_net_x2;
  mem_if_in_x2 <= from_register2_0_opb6_6_q_net_x3;
  mem_if_in_x3 <= from_register2_1_opb11_11_q_net_x3;
  mem_if_in_x4 <= from_register2_opb1_1_q_net_x3;
  mem_if_in_x5 <= from_register3_0_opb7_7_q_net_x3;
  mem_if_in_x6 <= from_register3_1_opb12_12_q_net_x3;
  mem_if_in_x7 <= from_register3_opb2_2_q_net_x3;
  mem_if_in_x8 <= from_register4_0_opb8_8_q_net_x3;
  mem_if_in_x9 <= from_register4_1_opb13_13_q_net_x2;
  smwodatai_0 <= register2_q_net_x5;

  ack_gen_04ab867b36: entity work.ack_gen_entity_04ab867b36
    port map (
      ce_1 => ce_1_sg_x13,
      clk_1 => clk_1_sg_x13,
      ps => logical_y_net_x5,
      rst => opb_rst_net_x2,
      ack => logical_y_net_x4
    );

  constant2: entity work.constant2_bb9364aedc
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => constant2_op_net_x0
    );

  en_gen_dc0458dd9b: entity work.en_gen_entity_dc0458dd9b
    port map (
      ack_in => logical_y_net_x4,
      addr => register_q_net_x3,
      ce_1 => ce_1_sg_x13,
      clk_1 => clk_1_sg_x13,
      rnw => register3_q_net_x1,
      in_0_we => write_rel_0_op_net_x1,
      in_10_we => write_rel_10_op_net_x1,
      in_11_we => write_rel_11_op_net_x1,
      in_12_we => write_rel_12_op_net_x1,
      in_13_we => write_rel_13_op_net_x1,
      in_14_we => write_rel_14_op_net_x1,
      in_15_we => write_rel_15_op_net_x1,
      in_16_we => write_rel_16_op_net_x1,
      in_1_we => write_rel_1_op_net_x1,
      in_2_we => write_rel_2_op_net_x1,
      in_3_we => write_rel_3_op_net_x1,
      in_4_we => write_rel_4_op_net_x1,
      in_5_we => write_rel_5_op_net_x1,
      in_6_we => write_rel_6_op_net_x1,
      in_7_we => write_rel_7_op_net_x1,
      in_8_we => write_rel_8_op_net_x1,
      in_9_we => write_rel_9_op_net_x1,
      smwoaddr_2 => addrslice_y_net_x3,
      smwowe_0 => and_sm_1_y_net_x2,
      smwowe_1 => and_sm_2_y_net_x2,
      smwowe_2 => and_sm_3_y_net_x2
    );

  ip2opb_if_86de1e84d1: entity work.ip2opb_if_entity_86de1e84d1
    port map (
      ce_1 => ce_1_sg_x13,
      clk_1 => clk_1_sg_x13,
      sgp_dbus_in => valid_data_y_net_x1,
      sgp_retry_in => constant2_op_net_x0,
      sgp_xferack_in => delay_q_net_x2,
      register1_x0 => register1_q_net_x1,
      register2_x0 => register2_q_net_x4,
      register3_x0 => register3_q_net_x2,
      register4_x0 => register4_q_net_x2,
      register_x1 => register_q_net_x1
    );

  mem_if_in_8c87289dd9: entity work.mem_if_in_entity_8c87289dd9
    port map (
      ce_1 => ce_1_sg_x13,
      clk_1 => clk_1_sg_x13,
      in_0_we => write_rel_0_op_net_x1,
      in_10_we => write_rel_10_op_net_x1,
      in_11_we => write_rel_11_op_net_x1,
      in_12_we => write_rel_12_op_net_x1,
      in_13_we => write_rel_13_op_net_x1,
      in_14_we => write_rel_14_op_net_x1,
      in_15_we => write_rel_15_op_net_x1,
      in_16_we => write_rel_16_op_net_x1,
      in_1_we => write_rel_1_op_net_x1,
      in_2_we => write_rel_2_op_net_x1,
      in_3_we => write_rel_3_op_net_x1,
      in_4_we => write_rel_4_op_net_x1,
      in_5_we => write_rel_5_op_net_x1,
      in_6_we => write_rel_6_op_net_x1,
      in_7_we => write_rel_7_op_net_x1,
      in_8_we => write_rel_8_op_net_x1,
      in_9_we => write_rel_9_op_net_x1,
      opb_dbus => register2_q_net_x5,
      in_0_data => from_register1_opb0_0_q_net_x3,
      in_10_data => from_register1_1_opb10_10_q_net_x3,
      in_11_data => from_register2_1_opb11_11_q_net_x3,
      in_12_data => from_register3_1_opb12_12_q_net_x3,
      in_13_data => from_register4_1_opb13_13_q_net_x2,
      in_14_data => from_register5_0_opb14_14_q_net_x2,
      in_15_data => from_register6_opb15_15_q_net_x2,
      in_16_data => from_register7_opb16_16_q_net_x3,
      in_1_data => from_register2_opb1_1_q_net_x3,
      in_2_data => from_register3_opb2_2_q_net_x3,
      in_3_data => from_register4_opb3_3_q_net_x3,
      in_4_data => from_register5_opb4_4_q_net_x3,
      in_5_data => from_register1_0_opb5_5_q_net_x3,
      in_6_data => from_register2_0_opb6_6_q_net_x3,
      in_7_data => from_register3_0_opb7_7_q_net_x3,
      in_8_data => from_register4_0_opb8_8_q_net_x3,
      in_9_data => from_register_opb9_9_q_net_x2
    );

  mem_if_out_691c0cefe9: entity work.mem_if_out_entity_691c0cefe9
    port map (
      ack_in => logical_y_net_x4,
      addr => register_q_net_x3,
      ce_1 => ce_1_sg_x13,
      clk_1 => clk_1_sg_x13,
      in_0_data => from_register1_opb0_0_q_net_x3,
      in_10_data => from_register1_1_opb10_10_q_net_x3,
      in_11_data => from_register2_1_opb11_11_q_net_x3,
      in_12_data => from_register3_1_opb12_12_q_net_x3,
      in_13_data => from_register4_1_opb13_13_q_net_x2,
      in_14_data => from_register5_0_opb14_14_q_net_x2,
      in_15_data => from_register6_opb15_15_q_net_x2,
      in_16_data => from_register7_opb16_16_q_net_x3,
      in_1_data => from_register2_opb1_1_q_net_x3,
      in_2_data => from_register3_opb2_2_q_net_x3,
      in_3_data => from_register4_opb3_3_q_net_x3,
      in_4_data => from_register5_opb4_4_q_net_x3,
      in_5_data => from_register1_0_opb5_5_q_net_x3,
      in_6_data => from_register2_0_opb6_6_q_net_x3,
      in_7_data => from_register3_0_opb7_7_q_net_x3,
      in_8_data => from_register4_0_opb8_8_q_net_x3,
      in_9_data => from_register_opb9_9_q_net_x2,
      out_17 => convert1_dout_net_x6,
      ack_out => delay_q_net_x2,
      sgp_dbus => valid_data_y_net_x1
    );

  opb2ip_if_b410420760: entity work.opb2ip_if_entity_b410420760
    port map (
      ce_1 => ce_1_sg_x13,
      clk_1 => clk_1_sg_x13,
      opb_abus => opb_abus_net_x1,
      opb_dbus => opb_dbus_net_x1,
      opb_rnw => opb_rnw_net_x1,
      opb_rst => opb_rst_net_x2,
      opb_select => opb_select_net_x1,
      opb_abus_reg => register_q_net_x3,
      opb_dbus_reg => register2_q_net_x5,
      opb_rnw_reg => register3_q_net_x1,
      opb_select_reg => register4_q_net_x3
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller/Pos_Edge_Detector"

entity pos_edge_detector_entity_3e01658cf5 is
  port (
    ce_1: in std_logic;
    clk_1: in std_logic;
    input_signal: in std_logic;
    rising_edge: out std_logic
  );
end pos_edge_detector_entity_3e01658cf5;

architecture structural of pos_edge_detector_entity_3e01658cf5 is
  signal ce_1_sg_x14: std_logic;
  signal clk_1_sg_x14: std_logic;
  signal convert2_dout_net_x0: std_logic;
  signal delay_q_net: std_logic;
  signal inverter_op_net: std_logic;
  signal logical_y_net_x3: std_logic;

begin
  ce_1_sg_x14 <= ce_1;
  clk_1_sg_x14 <= clk_1;
  convert2_dout_net_x0 <= input_signal;
  rising_edge <= logical_y_net_x3;

  delay: entity work.xldelay
    generic map (
      d_width => 1,
      en_width => 1,
      latency => 1,
      q_width => 1,
      reg_retiming => false,
      rst_width => 1
    )
    port map (
      ce => ce_1_sg_x14,
      clk => clk_1_sg_x14,
      clr => '0',
      d(0) => inverter_op_net,
      en => "1",
      rst => "0",
      q(0) => delay_q_net
    );

  inverter: entity work.inverter_1ad3fd342d
    port map (
      ce => ce_1_sg_x14,
      clk => clk_1_sg_x14,
      clr => '0',
      ip(0) => convert2_dout_net_x0,
      op(0) => inverter_op_net
    );

  logical: entity work.logical_9ce9caf750
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => convert2_dout_net_x0,
      d1(0) => delay_q_net,
      y(0) => logical_y_net_x3
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller/SPI/Data_Latch"

entity data_latch_entity_787c5ea487 is
  port (
    bit_select: in std_logic_vector(3 downto 0);
    ce_1: in std_logic;
    clk_1: in std_logic;
    data_to_transmit: in std_logic_vector(8 downto 0);
    latchdata: in std_logic;
    reset: in std_logic;
    spi_data: out std_logic
  );
end data_latch_entity_787c5ea487;

architecture structural of data_latch_entity_787c5ea487 is
  signal ce_1_sg_x15: std_logic;
  signal clk_1_sg_x15: std_logic;
  signal convert1_dout_net_x7: std_logic;
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
  ce_1_sg_x15 <= ce_1;
  clk_1_sg_x15 <= clk_1;
  mux_y_net_x1 <= data_to_transmit;
  mux1_y_net_x0 <= latchdata;
  convert1_dout_net_x7 <= reset;
  spi_data <= mux_y_net_x2;

  mux: entity work.mux_1dfdc407ff
    port map (
      ce => ce_1_sg_x15,
      clk => clk_1_sg_x15,
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
      ce => ce_1_sg_x15,
      clk => clk_1_sg_x15,
      d => mux_y_net_x1,
      en(0) => mux1_y_net_x0,
      rst(0) => convert1_dout_net_x7,
      q => register_q_net
    );

  slice: entity work.slice_791295c431
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => register_q_net,
      y(0) => slice_y_net
    );

  slice1: entity work.slice1_ff4192363f
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => register_q_net,
      y(0) => slice1_y_net
    );

  slice2: entity work.slice2_29d60a12cc
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => register_q_net,
      y(0) => slice2_y_net
    );

  slice3: entity work.slice3_7e70c47c84
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => register_q_net,
      y(0) => slice3_y_net
    );

  slice4: entity work.slice4_af90c4b694
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => register_q_net,
      y(0) => slice4_y_net
    );

  slice5: entity work.slice5_68bd3a6261
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => register_q_net,
      y(0) => slice5_y_net
    );

  slice6: entity work.slice6_b8fc9afe99
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => register_q_net,
      y(0) => slice6_y_net
    );

  slice7: entity work.slice7_21ba1aeffb
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => register_q_net,
      y(0) => slice7_y_net
    );

  slice8: entity work.slice8_e1859eb584
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => register_q_net,
      y(0) => slice8_y_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller/SPI/Pos_Edge_Detector"

entity pos_edge_detector_entity_84d1bd469d is
  port (
    ce_1: in std_logic;
    clk_1: in std_logic;
    input_signal: in std_logic;
    rising_edge: out std_logic
  );
end pos_edge_detector_entity_84d1bd469d;

architecture structural of pos_edge_detector_entity_84d1bd469d is
  signal ce_1_sg_x16: std_logic;
  signal clk_1_sg_x16: std_logic;
  signal delay_q_net: std_logic;
  signal inverter_op_net: std_logic;
  signal logical_y_net_x0: std_logic;
  signal mux_y_net_x0: std_logic;

begin
  ce_1_sg_x16 <= ce_1;
  clk_1_sg_x16 <= clk_1;
  mux_y_net_x0 <= input_signal;
  rising_edge <= logical_y_net_x0;

  delay: entity work.xldelay
    generic map (
      d_width => 1,
      en_width => 1,
      latency => 1,
      q_width => 1,
      reg_retiming => false,
      rst_width => 1
    )
    port map (
      ce => ce_1_sg_x16,
      clk => clk_1_sg_x16,
      clr => '0',
      d(0) => inverter_op_net,
      en => "1",
      rst => "0",
      q(0) => delay_q_net
    );

  inverter: entity work.inverter_77ee0cd0d1
    port map (
      ce => ce_1_sg_x16,
      clk => clk_1_sg_x16,
      clr => '0',
      ip(0) => mux_y_net_x0,
      op(0) => inverter_op_net
    );

  logical: entity work.logical_efbd270832
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

-- Generated from Simulink block "user_io_board_controller/SPI/Pos_Edge_Detector2"

entity pos_edge_detector2_entity_cb0b2950d7 is
  port (
    ce_1: in std_logic;
    clk_1: in std_logic;
    input_signal: in std_logic;
    rising_edge: out std_logic
  );
end pos_edge_detector2_entity_cb0b2950d7;

architecture structural of pos_edge_detector2_entity_cb0b2950d7 is
  signal ce_1_sg_x17: std_logic;
  signal clk_1_sg_x17: std_logic;
  signal delay_q_net: std_logic;
  signal inverter1_op_net_x0: std_logic;
  signal inverter_op_net: std_logic;
  signal logical_y_net_x0: std_logic;

begin
  ce_1_sg_x17 <= ce_1;
  clk_1_sg_x17 <= clk_1;
  inverter1_op_net_x0 <= input_signal;
  rising_edge <= logical_y_net_x0;

  delay: entity work.xldelay
    generic map (
      d_width => 1,
      en_width => 1,
      latency => 1,
      q_width => 1,
      reg_retiming => false,
      rst_width => 1
    )
    port map (
      ce => ce_1_sg_x17,
      clk => clk_1_sg_x17,
      clr => '0',
      d(0) => inverter_op_net,
      en => "1",
      rst => "0",
      q(0) => delay_q_net
    );

  inverter: entity work.inverter_8d7a99ad38
    port map (
      ce => ce_1_sg_x17,
      clk => clk_1_sg_x17,
      clr => '0',
      ip(0) => inverter1_op_net_x0,
      op(0) => inverter_op_net
    );

  logical: entity work.logical_d0cd988cf6
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => inverter1_op_net_x0,
      d1(0) => delay_q_net,
      y(0) => logical_y_net_x0
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller/SPI"

entity spi_entity_b4f3e2794f is
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
end spi_entity_b4f3e2794f;

architecture structural of spi_entity_b4f3e2794f is
  signal ce_1_sg_x18: std_logic;
  signal clk_1_sg_x18: std_logic;
  signal constant_op_net: std_logic_vector(3 downto 0);
  signal convert1_dout_net_x8: std_logic;
  signal convert1_dout_net_x9: std_logic;
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
  ce_1_sg_x18 <= ce_1;
  clk_1_sg_x18 <= clk_1;
  mux_y_net_x3 <= data_to_transfer;
  convert_dout_net_x1 <= dividerselect;
  convert1_dout_net_x8 <= reset;
  mux1_y_net_x1 <= send;
  cs <= inverter_op_net_x0;
  data <= mux_y_net_x4;
  done <= convert1_dout_net_x9;
  scl <= mux_y_net_x5;

  constant_x0: entity work.constant_d8dc206917
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
      dout(0) => convert1_dout_net_x9
    );

  counter: entity work.xlcounter_limit
    generic map (
      cnt_15_0 => 8,
      cnt_31_16 => 0,
      cnt_47_32 => 0,
      cnt_63_48 => 0,
      core_name0 => "binary_counter_virtex2p_7_0_0611420023f6fdd6",
      count_limited => 1,
      op_arith => xlUnsigned,
      op_width => 4
    )
    port map (
      ce => ce_1_sg_x18,
      clk => clk_1_sg_x18,
      clr => '0',
      en(0) => convert_dout_net_x0,
      rst(0) => convert1_dout_net_x8,
      op => counter_op_net_x0
    );

  counter1: entity work.xlcounter_free
    generic map (
      core_name0 => "binary_counter_virtex2p_7_0_dbb5736f3ec3cba8",
      op_arith => xlUnsigned,
      op_width => 4
    )
    port map (
      ce => ce_1_sg_x18,
      clk => clk_1_sg_x18,
      clr => '0',
      din => constant_op_net,
      en(0) => register_q_net,
      load(0) => convert1_dout_net_x9,
      rst(0) => convert1_dout_net_x8,
      op => counter1_op_net
    );

  data_latch_787c5ea487: entity work.data_latch_entity_787c5ea487
    port map (
      bit_select => counter_op_net_x0,
      ce_1 => ce_1_sg_x18,
      clk_1 => clk_1_sg_x18,
      data_to_transmit => mux_y_net_x3,
      latchdata => mux1_y_net_x1,
      reset => convert1_dout_net_x8,
      spi_data => mux_y_net_x4
    );

  delay: entity work.xldelay
    generic map (
      d_width => 1,
      en_width => 1,
      latency => 2,
      q_width => 1,
      reg_retiming => false,
      rst_width => 1
    )
    port map (
      ce => ce_1_sg_x18,
      clk => clk_1_sg_x18,
      clr => '0',
      d(0) => logical_y_net_x0,
      en => "1",
      rst => "0",
      q(0) => delay_q_net
    );

  delay1: entity work.xldelay
    generic map (
      d_width => 1,
      en_width => 1,
      latency => 6,
      q_width => 1,
      reg_retiming => false,
      rst_width => 1
    )
    port map (
      ce => ce_1_sg_x18,
      clk => clk_1_sg_x18,
      clr => '0',
      d(0) => logical_y_net_x0,
      en => "1",
      rst => "0",
      q(0) => delay1_q_net
    );

  inverter: entity work.inverter_28860404e6
    port map (
      ce => ce_1_sg_x18,
      clk => clk_1_sg_x18,
      clr => '0',
      ip(0) => register_q_net,
      op(0) => inverter_op_net_x0
    );

  inverter1: entity work.inverter1_0f8027306d
    port map (
      ce => ce_1_sg_x18,
      clk => clk_1_sg_x18,
      clr => '0',
      ip(0) => slice1_y_net,
      op(0) => inverter1_op_net_x0
    );

  logical: entity work.logical_46f244e8bb
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => convert1_dout_net_x9,
      d1(0) => mux1_y_net_x1,
      y(0) => logical_y_net
    );

  mux: entity work.mux_e3fe44b617
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => slice_y_net,
      d1(0) => slice2_y_net,
      sel(0) => convert_dout_net_x1,
      y(0) => mux_y_net_x5
    );

  mux1: entity work.mux1_d0bb08f30c
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => delay_q_net,
      d1(0) => delay1_q_net,
      sel(0) => convert_dout_net_x1,
      y(0) => mux1_y_net
    );

  pos_edge_detector2_cb0b2950d7: entity work.pos_edge_detector2_entity_cb0b2950d7
    port map (
      ce_1 => ce_1_sg_x18,
      clk_1 => clk_1_sg_x18,
      input_signal => inverter1_op_net_x0,
      rising_edge => logical_y_net_x1
    );

  pos_edge_detector_84d1bd469d: entity work.pos_edge_detector_entity_84d1bd469d
    port map (
      ce_1 => ce_1_sg_x18,
      clk_1 => clk_1_sg_x18,
      input_signal => mux_y_net_x5,
      rising_edge => logical_y_net_x0
    );

  register_x0: entity work.xlregister
    generic map (
      d_width => 1,
      init_value => b"0"
    )
    port map (
      ce => ce_1_sg_x18,
      clk => clk_1_sg_x18,
      d(0) => mux1_y_net_x1,
      en(0) => logical_y_net,
      rst(0) => convert1_dout_net_x8,
      q(0) => register_q_net
    );

  slice: entity work.slice_1db632eb4d
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => counter1_op_net,
      y(0) => slice_y_net
    );

  slice1: entity work.slice1_31d72b6151
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => counter_op_net_x0,
      y(0) => slice1_y_net
    );

  slice2: entity work.slice2_a14dc94f53
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => counter1_op_net,
      y(0) => slice2_y_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller/p_select"

entity p_select_entity_7ae2089f23 is
  port (
    a_valid: in std_logic;
    addr: in std_logic_vector(31 downto 0);
    ps: out std_logic
  );
end p_select_entity_7ae2089f23;

architecture structural of p_select_entity_7ae2089f23 is
  signal constant_op_net: std_logic_vector(31 downto 0);
  signal logical_y_net_x6: std_logic;
  signal register4_q_net_x4: std_logic;
  signal register_q_net_x4: std_logic_vector(31 downto 0);
  signal relational_op_net: std_logic;
  signal slice_c_y_net: std_logic_vector(13 downto 0);
  signal slice_d_y_net: std_logic_vector(13 downto 0);

begin
  register4_q_net_x4 <= a_valid;
  register_q_net_x4 <= addr;
  ps <= logical_y_net_x6;

  constant_x0: entity work.constant_b86c2593ab
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      op => constant_op_net
    );

  logical: entity work.logical_cc69aebb05
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => relational_op_net,
      d1(0) => register4_q_net_x4,
      y(0) => logical_y_net_x6
    );

  relational: entity work.relational_3a7b93335f
    port map (
      a => slice_c_y_net,
      b => slice_d_y_net,
      ce => '0',
      clk => '0',
      clr => '0',
      op(0) => relational_op_net
    );

  slice_c: entity work.slice_c_2025eb8052
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => register_q_net_x4,
      y => slice_c_y_net
    );

  slice_d: entity work.slice_d_8b205dd8c0
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      x => constant_op_net,
      y => slice_d_y_net
    );

end structural;
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

-- Generated from Simulink block "user_io_board_controller"

entity user_io_board_controller is
  port (
    ce_1: in std_logic;
    clk_1: in std_logic;
    opb_abus: in std_logic_vector(31 downto 0);
    opb_be: in std_logic_vector(3 downto 0);
    opb_dbus: in std_logic_vector(31 downto 0);
    opb_rnw: in std_logic;
    opb_rst: in std_logic;
    opb_select: in std_logic;
    opb_seqaddr: in std_logic;
    reset: in std_logic;
    cs: out std_logic;
    resetlcd: out std_logic;
    scl: out std_logic;
    sdi: out std_logic;
    sgp_dbus: out std_logic_vector(31 downto 0);
    sgp_errack: out std_logic;
    sgp_retry: out std_logic;
    sgp_toutsup: out std_logic;
    sgp_xferack: out std_logic
  );
end user_io_board_controller;

architecture structural of user_io_board_controller is
  signal addrslice_y_net_x3: std_logic_vector(13 downto 0);
  signal and_sm_1_y_net_x2: std_logic;
  signal and_sm_2_y_net_x2: std_logic;
  signal and_sm_3_y_net_x2: std_logic;
  signal ce_1_sg_x19: std_logic;
  signal clk_1_sg_x19: std_logic;
  signal concat2_y_net_x0: std_logic_vector(8 downto 0);
  signal concat4_y_net_x0: std_logic_vector(8 downto 0);
  signal convert1_dout_net_x8: std_logic;
  signal convert1_dout_net_x9: std_logic;
  signal convert2_dout_net_x0: std_logic;
  signal convert_dout_net_x1: std_logic;
  signal cs_net: std_logic;
  signal delay_q_net_x0: std_logic;
  signal from_register1_0_opb5_5_q_net_x3: std_logic_vector(8 downto 0);
  signal from_register1_1_opb10_10_q_net_x3: std_logic_vector(1 downto 0);
  signal from_register1_opb0_0_q_net_x3: std_logic_vector(8 downto 0);
  signal from_register2_0_opb6_6_q_net_x3: std_logic_vector(8 downto 0);
  signal from_register2_1_opb11_11_q_net_x3: std_logic;
  signal from_register2_opb1_1_q_net_x3: std_logic_vector(8 downto 0);
  signal from_register3_0_opb7_7_q_net_x3: std_logic_vector(8 downto 0);
  signal from_register3_1_opb12_12_q_net_x3: std_logic_vector(7 downto 0);
  signal from_register3_opb2_2_q_net_x3: std_logic_vector(8 downto 0);
  signal from_register4_0_opb8_8_q_net_x3: std_logic_vector(2 downto 0);
  signal from_register4_1_opb13_13_q_net_x2: std_logic;
  signal from_register4_opb3_3_q_net_x3: std_logic_vector(8 downto 0);
  signal from_register5_0_opb14_14_q_net_x2: std_logic;
  signal from_register5_opb4_4_q_net_x3: std_logic_vector(8 downto 0);
  signal from_register6_opb15_15_q_net_x2: std_logic;
  signal from_register7_opb16_16_q_net_x3: std_logic;
  signal from_register_opb9_9_q_net_x2: std_logic;
  signal logical1_y_net: std_logic;
  signal logical_y_net_x3: std_logic;
  signal logical_y_net_x6: std_logic;
  signal mux1_y_net_x1: std_logic;
  signal mux2_y_net_x0: std_logic;
  signal mux_y_net_x3: std_logic_vector(8 downto 0);
  signal opb_abus_net: std_logic_vector(31 downto 0);
  signal opb_be_net: std_logic_vector(3 downto 0);
  signal opb_dbus_net: std_logic_vector(31 downto 0);
  signal opb_rnw_net: std_logic;
  signal opb_rst_net: std_logic;
  signal opb_select_net: std_logic;
  signal opb_seqaddr_net: std_logic;
  signal register2_q_net_x5: std_logic_vector(31 downto 0);
  signal register4_q_net_x4: std_logic;
  signal register_q_net_x1: std_logic;
  signal register_q_net_x4: std_logic_vector(31 downto 0);
  signal reset_net: std_logic;
  signal resetlcd_net: std_logic;
  signal scl_net: std_logic;
  signal sdi_net: std_logic;
  signal sgp_dbus_net: std_logic_vector(31 downto 0);
  signal sgp_errack_net: std_logic;
  signal sgp_retry_net: std_logic;
  signal sgp_toutsup_net: std_logic;
  signal sgp_xferack_net: std_logic;

begin
  ce_1_sg_x19 <= ce_1;
  clk_1_sg_x19 <= clk_1;
  opb_abus_net <= opb_abus;
  opb_be_net <= opb_be;
  opb_dbus_net <= opb_dbus;
  opb_rnw_net <= opb_rnw;
  opb_rst_net <= opb_rst;
  opb_select_net <= opb_select;
  opb_seqaddr_net <= opb_seqaddr;
  reset_net <= reset;
  cs <= cs_net;
  resetlcd <= resetlcd_net;
  scl <= scl_net;
  sdi <= sdi_net;
  sgp_dbus <= sgp_dbus_net;
  sgp_errack <= sgp_errack_net;
  sgp_retry <= sgp_retry_net;
  sgp_toutsup <= sgp_toutsup_net;
  sgp_xferack <= sgp_xferack_net;

  commandrom_5effcb692f: entity work.commandrom_entity_5effcb692f
    port map (
      ce_1 => ce_1_sg_x19,
      clk_1 => clk_1_sg_x19,
      configloc => from_register1_1_opb10_10_q_net_x3,
      in_0 => from_register1_opb0_0_q_net_x3,
      in_1 => from_register2_opb1_1_q_net_x3,
      in_2 => from_register3_opb2_2_q_net_x3,
      in_3 => from_register4_opb3_3_q_net_x3,
      in_4 => from_register5_opb4_4_q_net_x3,
      invertramaddr => from_register2_1_opb11_11_q_net_x3,
      reset => convert1_dout_net_x8,
      sendcmds => logical_y_net_x3,
      smwoaddr_0 => addrslice_y_net_x3,
      smwodatai_0 => register2_q_net_x5,
      smwowe_0 => and_sm_1_y_net_x2,
      totalnoofcmds => from_register3_1_opb12_12_q_net_x3,
      transferdone => convert1_dout_net_x9,
      cmdsdone => register_q_net_x1,
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
      din(0) => from_register4_1_opb13_13_q_net_x2,
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
      dout(0) => convert1_dout_net_x8
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
      din(0) => from_register5_0_opb14_14_q_net_x2,
      dout(0) => convert2_dout_net_x0
    );

  datarom_76c8725483: entity work.datarom_entity_76c8725483
    port map (
      ce_1 => ce_1_sg_x19,
      clk_1 => clk_1_sg_x19,
      cmdsdone => register_q_net_x1,
      in_5 => from_register1_0_opb5_5_q_net_x3,
      in_6 => from_register2_0_opb6_6_q_net_x3,
      in_7 => from_register3_0_opb7_7_q_net_x3,
      in_8 => from_register4_0_opb8_8_q_net_x3,
      invertramaddr => from_register7_opb16_16_q_net_x3,
      reset => convert1_dout_net_x8,
      smwoaddr_2 => addrslice_y_net_x3,
      smwodatai_2 => register2_q_net_x5,
      smwowe_1 => and_sm_2_y_net_x2,
      smwowe_2 => and_sm_3_y_net_x2,
      transferdone => convert1_dout_net_x9,
      data => concat4_y_net_x0,
      starttransfer => delay_q_net_x0
    );

  delay: entity work.xldelay
    generic map (
      d_width => 1,
      en_width => 1,
      latency => 4,
      q_width => 1,
      reg_retiming => false,
      rst_width => 1
    )
    port map (
      ce => ce_1_sg_x19,
      clk => clk_1_sg_x19,
      clr => '0',
      d(0) => from_register6_opb15_15_q_net_x2,
      en => "1",
      rst => "0",
      q(0) => resetlcd_net
    );

  logical1: entity work.logical1_2f79cf4de3
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => reset_net,
      d1(0) => from_register_opb9_9_q_net_x2,
      y(0) => logical1_y_net
    );

  memory_mapped_i_o_8628bc2130: entity work.memory_mapped_i_o_entity_8628bc2130
    port map (
      ce_1 => ce_1_sg_x19,
      clk_1 => clk_1_sg_x19,
      convert1 => convert1_dout_net_x8,
      opb_abus => opb_abus_net,
      opb_dbus => opb_dbus_net,
      opb_rnw => opb_rnw_net,
      opb_rst => opb_rst_net,
      opb_select => opb_select_net,
      ps => logical_y_net_x6,
      a_valid => register4_q_net_x4,
      addr => register_q_net_x4,
      en_gen => addrslice_y_net_x3,
      en_gen_x0 => and_sm_1_y_net_x2,
      en_gen_x1 => and_sm_2_y_net_x2,
      en_gen_x2 => and_sm_3_y_net_x2,
      ip2opb_if => sgp_dbus_net,
      ip2opb_if_x0 => sgp_xferack_net,
      ip2opb_if_x1 => sgp_retry_net,
      ip2opb_if_x2 => sgp_toutsup_net,
      ip2opb_if_x3 => sgp_errack_net,
      mem_if_in => from_register1_0_opb5_5_q_net_x3,
      mem_if_in_x0 => from_register1_1_opb10_10_q_net_x3,
      mem_if_in_x1 => from_register1_opb0_0_q_net_x3,
      mem_if_in_x10 => from_register4_opb3_3_q_net_x3,
      mem_if_in_x11 => from_register5_0_opb14_14_q_net_x2,
      mem_if_in_x12 => from_register5_opb4_4_q_net_x3,
      mem_if_in_x13 => from_register6_opb15_15_q_net_x2,
      mem_if_in_x14 => from_register7_opb16_16_q_net_x3,
      mem_if_in_x15 => from_register_opb9_9_q_net_x2,
      mem_if_in_x2 => from_register2_0_opb6_6_q_net_x3,
      mem_if_in_x3 => from_register2_1_opb11_11_q_net_x3,
      mem_if_in_x4 => from_register2_opb1_1_q_net_x3,
      mem_if_in_x5 => from_register3_0_opb7_7_q_net_x3,
      mem_if_in_x6 => from_register3_1_opb12_12_q_net_x3,
      mem_if_in_x7 => from_register3_opb2_2_q_net_x3,
      mem_if_in_x8 => from_register4_0_opb8_8_q_net_x3,
      mem_if_in_x9 => from_register4_1_opb13_13_q_net_x2,
      smwodatai_0 => register2_q_net_x5
    );

  mux: entity work.mux_a4ed0f3863
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0 => concat2_y_net_x0,
      d1 => concat4_y_net_x0,
      sel(0) => register_q_net_x1,
      y => mux_y_net_x3
    );

  mux1: entity work.mux1_c9b55459ef
    port map (
      ce => '0',
      clk => '0',
      clr => '0',
      d0(0) => mux2_y_net_x0,
      d1(0) => delay_q_net_x0,
      sel(0) => register_q_net_x1,
      y(0) => mux1_y_net_x1
    );

  p_select_7ae2089f23: entity work.p_select_entity_7ae2089f23
    port map (
      a_valid => register4_q_net_x4,
      addr => register_q_net_x4,
      ps => logical_y_net_x6
    );

  pos_edge_detector_3e01658cf5: entity work.pos_edge_detector_entity_3e01658cf5
    port map (
      ce_1 => ce_1_sg_x19,
      clk_1 => clk_1_sg_x19,
      input_signal => convert2_dout_net_x0,
      rising_edge => logical_y_net_x3
    );

  spi_b4f3e2794f: entity work.spi_entity_b4f3e2794f
    port map (
      ce_1 => ce_1_sg_x19,
      clk_1 => clk_1_sg_x19,
      data_to_transfer => mux_y_net_x3,
      dividerselect => convert_dout_net_x1,
      reset => convert1_dout_net_x8,
      send => mux1_y_net_x1,
      cs => cs_net,
      data => sdi_net,
      done => convert1_dout_net_x9,
      scl => scl_net
    );

end structural;

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------

-------------------------------------------------------------------
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
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
-- System Generator version 8.2.02 VHDL source file.
--
-- Copyright(C) 2006 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2006 Xilinx, Inc.  All rights
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
library IEEE;
use IEEE.std_logic_1164.all;
use work.conv_pkg.all;

entity user_io_board_controller_clock_driver is
  port (
    sysce: in std_logic;
    sysce_clr: in std_logic;
    sysclk: in std_logic;
    ce_1: out std_logic;
    clk_1: out std_logic
  );
end user_io_board_controller_clock_driver;

architecture structural of user_io_board_controller_clock_driver is
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
    ce: in std_logic := '1';
    clk: in std_logic;
    opb_abus: in std_logic_vector(31 downto 0);
    opb_be: in std_logic_vector(3 downto 0);
    opb_dbus: in std_logic_vector(31 downto 0);
    opb_rnw: in std_logic;
    opb_rst: in std_logic;
    opb_select: in std_logic;
    opb_seqaddr: in std_logic;
    reset: in std_logic;
    cs: out std_logic;
    resetlcd: out std_logic;
    scl: out std_logic;
    sdi: out std_logic;
    sgp_dbus: out std_logic_vector(31 downto 0);
    sgp_errack: out std_logic;
    sgp_retry: out std_logic;
    sgp_toutsup: out std_logic;
    sgp_xferack: out std_logic
  );
end user_io_board_controller_cw;

architecture structural of user_io_board_controller_cw is
  component xlpersistentdff
    port (
      clk: in std_logic;
      d: in std_logic;
      q: out std_logic
    );
  end component;
  attribute syn_black_box: boolean;
  attribute syn_black_box of xlpersistentdff: component is true;
  attribute box_type: string;
  attribute box_type of xlpersistentdff: component is "black_box";
  attribute syn_noprune: boolean;
  attribute optimize_primitives: boolean;
  attribute dont_touch: boolean;
  attribute syn_noprune of xlpersistentdff: component is true;
  attribute optimize_primitives of xlpersistentdff: component is false;
  attribute dont_touch of xlpersistentdff: component is true;

  signal ce_1_sg_x19: std_logic;
  signal clkNet: std_logic;
  signal clk_1_sg_x19: std_logic;
  signal cs_net: std_logic;
  signal opb_abus_net: std_logic_vector(31 downto 0);
  signal opb_be_net: std_logic_vector(3 downto 0);
  signal opb_dbus_net: std_logic_vector(31 downto 0);
  signal opb_rnw_net: std_logic;
  signal opb_rst_net: std_logic;
  signal opb_select_net: std_logic;
  signal opb_seqaddr_net: std_logic;
  signal persistentdff_inst_q: std_logic;
  attribute syn_keep: boolean;
  attribute syn_keep of persistentdff_inst_q: signal is true;
  attribute keep: boolean;
  attribute keep of persistentdff_inst_q: signal is true;
  attribute preserve_signal: boolean;
  attribute preserve_signal of persistentdff_inst_q: signal is true;
  signal reset_net: std_logic;
  signal resetlcd_net: std_logic;
  signal scl_net: std_logic;
  signal sdi_net: std_logic;
  signal sgp_dbus_net: std_logic_vector(31 downto 0);
  signal sgp_errack_net: std_logic;
  signal sgp_retry_net: std_logic;
  signal sgp_toutsup_net: std_logic;
  signal sgp_xferack_net: std_logic;

begin
  clkNet <= clk;
  opb_abus_net <= opb_abus;
  opb_be_net <= opb_be;
  opb_dbus_net <= opb_dbus;
  opb_rnw_net <= opb_rnw;
  opb_rst_net <= opb_rst;
  opb_select_net <= opb_select;
  opb_seqaddr_net <= opb_seqaddr;
  reset_net <= reset;
  cs <= cs_net;
  resetlcd <= resetlcd_net;
  scl <= scl_net;
  sdi <= sdi_net;
  sgp_dbus <= sgp_dbus_net;
  sgp_errack <= sgp_errack_net;
  sgp_retry <= sgp_retry_net;
  sgp_toutsup <= sgp_toutsup_net;
  sgp_xferack <= sgp_xferack_net;

  clk_probe: entity work.xlclkprobe
    port map (
      ce => '1',
      clk => clkNet,
      clr => '0'
    );

  default_clock_driver: entity work.user_io_board_controller_clock_driver
    port map (
      sysce => '1',
      sysce_clr => '0',
      sysclk => clkNet,
      ce_1 => ce_1_sg_x19,
      clk_1 => clk_1_sg_x19
    );

  persistentdff_inst: xlpersistentdff
    port map (
      clk => clkNet,
      d => persistentdff_inst_q,
      q => persistentdff_inst_q
    );

  user_io_board_controller_x0: entity work.user_io_board_controller
    port map (
      ce_1 => ce_1_sg_x19,
      clk_1 => clk_1_sg_x19,
      opb_abus => opb_abus_net,
      opb_be => opb_be_net,
      opb_dbus => opb_dbus_net,
      opb_rnw => opb_rnw_net,
      opb_rst => opb_rst_net,
      opb_select => opb_select_net,
      opb_seqaddr => opb_seqaddr_net,
      reset => reset_net,
      cs => cs_net,
      resetlcd => resetlcd_net,
      scl => scl_net,
      sdi => sdi_net,
      sgp_dbus => sgp_dbus_net,
      sgp_errack => sgp_errack_net,
      sgp_retry => sgp_retry_net,
      sgp_toutsup => sgp_toutsup_net,
      sgp_xferack => sgp_xferack_net
    );

end structural;
