--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:09:35 09/02/2017
-- Design Name:   
-- Module Name:   /home/mika/Projects/projects_workspace/VHDL_processor/VHDL_computer/cpu_top_tb.vhd
-- Project Name:  VHDL_computer
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: cpu_top
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
 
ENTITY cpu_top_tb IS
END cpu_top_tb;
 
ARCHITECTURE behavior OF cpu_top_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT cpu_top
    PORT(
         iCLK : IN  std_logic;
         inRST : IN  std_logic;
         iINSTR : IN  std_logic_vector(14 downto 0);
         iDATA : IN  std_logic_vector(15 downto 0);
         oPC : OUT  std_logic_vector(15 downto 0);
         oDATA : OUT  std_logic_vector(15 downto 0);
         oADDR : OUT  std_logic_vector(15 downto 0);
         oMEM_WE : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal iCLK : std_logic := '0';
   signal inRST : std_logic := '0';
   signal iINSTR : std_logic_vector(14 downto 0) := (others => '0');
   signal iDATA : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal oPC : std_logic_vector(15 downto 0);
   signal oDATA : std_logic_vector(15 downto 0);
   signal oADDR : std_logic_vector(15 downto 0);
   signal oMEM_WE : std_logic;

   -- Clock period definitions
   constant iCLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: cpu_top PORT MAP (
          iCLK => iCLK,
          inRST => inRST,
          iINSTR => iINSTR,
          iDATA => iDATA,
          oPC => oPC,
          oDATA => oDATA,
          oADDR => oADDR,
          oMEM_WE => oMEM_WE
        );

   -- Clock process definitions
   iCLK_process :process
   begin
		iCLK <= '0';
		wait for iCLK_period/2;
		iCLK <= '1';
		wait for iCLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for iCLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
