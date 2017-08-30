--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:30:38 08/30/2017
-- Design Name:   
-- Module Name:   /home/mika/Projects/projects_workspace/VHDL_processor/VHDL_computer/alu_tb.vhd
-- Project Name:  VHDL_computer
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: alu
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY alu_tb IS
END alu_tb;
 
ARCHITECTURE behavior OF alu_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT alu
    PORT(
         iOP1 : IN  std_logic_vector(15 downto 0);
         iOP2 : IN  std_logic_vector(15 downto 0);
         iALU_SEL : IN  std_logic_vector(3 downto 0);
         oRESULT : OUT  std_logic_vector(15 downto 0);
         oZERO : OUT  std_logic;
         oCARRY : OUT  std_logic;
         oSIGN : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal iOP1 : std_logic_vector(15 downto 0) := (others => '0');
   signal iOP2 : std_logic_vector(15 downto 0) := (others => '0');
   signal iALU_SEL : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal oRESULT : std_logic_vector(15 downto 0);
   signal oZERO : std_logic;
   signal oCARRY : std_logic;
   signal oSIGN : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: alu PORT MAP (
          iOP1 => iOP1,
          iOP2 => iOP2,
          iALU_SEL => iALU_SEL,
          oRESULT => oRESULT,
          oZERO => oZERO,
          oCARRY => oCARRY,
          oSIGN => oSIGN
        );

   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

     -- wait for <clock>_period*10;

      -- insert stimulus here 
		iOP1 <= x"FFFE";
		iOP2 <= x"0009";
		iALU_SEL <= "1111";
		
		wait for 50 ns;
		
		iALU_SEL <= "0000";
		
		wait for 50 ns;
		
		iALU_SEL <= "0001";
		
		wait for 50 ns;

		iALU_SEL <= "0010";
		
		wait for 50 ns;
		
		iALU_SEL <= "0011";
		
		wait for 50 ns;		

		iALU_SEL <= "0100";
		
		wait for 50 ns;
		
		iALU_SEL <= "0101";
		
		wait for 50 ns;
		
		iALU_SEL <= "0110";
		
		wait for 50 ns;
		
		iALU_SEL <= "0111";
		
		wait for 50 ns;
		
		iALU_SEL <= "1000";
		
		wait for 50 ns;
		
		iALU_SEL <= "1001";
		
		wait for 50 ns;
		
		iALU_SEL <= "1010";
		
		wait for 50 ns;
		
		iALU_SEL <= "1011";
		
		wait for 50 ns;
		
		iALU_SEL <= "1100";

      wait;
   end process;

END;
