--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:47:06 08/30/2017
-- Design Name:   
-- Module Name:   /home/mika/Projects/projects_workspace/VHDL_processor/VHDL_computer/mux_tb.vhd
-- Project Name:  VHDL_computer
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mux
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
 
ENTITY mux_tb IS
END mux_tb;
 
ARCHITECTURE behavior OF mux_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux
    PORT(
         iR0 : IN  std_logic_vector(15 downto 0);
         iR1 : IN  std_logic_vector(15 downto 0);
         iR2 : IN  std_logic_vector(15 downto 0);
         iR3 : IN  std_logic_vector(15 downto 0);
         iR4 : IN  std_logic_vector(15 downto 0);
         iR5 : IN  std_logic_vector(15 downto 0);
         iR6 : IN  std_logic_vector(15 downto 0);
         iR7 : IN  std_logic_vector(15 downto 0);
         iDATA : IN  std_logic_vector(15 downto 0);
         iMUX_SEL : IN  std_logic_vector(3 downto 0);
         oMUX : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal iR0 : std_logic_vector(15 downto 0) := (others => '0');
   signal iR1 : std_logic_vector(15 downto 0) := (others => '0');
   signal iR2 : std_logic_vector(15 downto 0) := (others => '0');
   signal iR3 : std_logic_vector(15 downto 0) := (others => '0');
   signal iR4 : std_logic_vector(15 downto 0) := (others => '0');
   signal iR5 : std_logic_vector(15 downto 0) := (others => '0');
   signal iR6 : std_logic_vector(15 downto 0) := (others => '0');
   signal iR7 : std_logic_vector(15 downto 0) := (others => '0');
   signal iDATA : std_logic_vector(15 downto 0) := (others => '0');
   signal iMUX_SEL : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal oMUX : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mux PORT MAP (
          iR0 => iR0,
          iR1 => iR1,
          iR2 => iR2,
          iR3 => iR3,
          iR4 => iR4,
          iR5 => iR5,
          iR6 => iR6,
          iR7 => iR7,
          iDATA => iDATA,
          iMUX_SEL => iMUX_SEL,
          oMUX => oMUX
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

      ---wait for <clock>_period*10;

      -- insert stimulus here

		iDATA <= x"0008";	
		iR0 <= x"0000";
		iR1 <= x"0001";
		iR2 <= x"0002";
		iR3 <= x"0003";
		iR4 <= x"0004";
		iR5 <= x"0005";
		iR6 <= x"0006";
		iR7 <= x"0007";
		iMUX_SEL <= "1111";
		
		wait for 50 ns;
		
		iMUX_SEL <= "0000";
		
		wait for 50 ns;
		
		iMUX_SEL <= "0001";
		
		wait for 50 ns;

		iMUX_SEL <= "0010";
		
		wait for 50 ns;
		
		iMUX_SEL <= "0011";
		
		wait for 50 ns;		

		iMUX_SEL <= "0100";
		
		wait for 50 ns;
		
		iMUX_SEL <= "0101";
		
		wait for 50 ns;
		
		iMUX_SEL <= "0110";
		
		wait for 50 ns;
		
		iMUX_SEL <= "0111";
		
		wait for 50 ns;
		
		iMUX_SEL <= "1000";
		
      wait;
   end process;

END;
