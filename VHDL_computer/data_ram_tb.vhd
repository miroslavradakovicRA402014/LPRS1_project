--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:00:32 08/29/2017
-- Design Name:   
-- Module Name:   /home/mika/Projects/projects_workspace/VHDL_processor/VHDL_computer/data_ram_tb.vhd
-- Project Name:  VHDL_computer
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: data_ram
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
 
ENTITY data_ram_tb IS
END data_ram_tb;
 
ARCHITECTURE behavior OF data_ram_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT data_ram
    PORT(
         iCLK : IN  std_logic;
         inRST : IN  std_logic;
         iA : IN  std_logic_vector(4 downto 0);
         iD : IN  std_logic_vector(15 downto 0);
         iWE : IN  std_logic;
         oQ : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal iCLK : std_logic := '0';
   signal inRST : std_logic := '0';
   signal iA : std_logic_vector(4 downto 0) := (others => '0');
   signal iD : std_logic_vector(15 downto 0) := (others => '0');
   signal iWE : std_logic := '0';

 	--Outputs
   signal oQ : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant iCLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: data_ram PORT MAP (
          iCLK => iCLK,
          inRST => inRST,
          iA => iA,
          iD => iD,
          iWE => iWE,
          oQ => oQ
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
		inRST <= '1';
		
		iWE <= '0';
		iD <= x"0001";
		iA <= "00001";
		
		wait for iCLK_period*4; 
		
		iWE <= '1';
		
		wait for iCLK_period*2; 
		
		iWE <= '0';
		iD <= x"00A0";
		iA <= "00010";
		
		wait for iCLK_period*4;		
		
		iWE <= '1';
		
		wait for iCLK_period*2; 
		
		iWE <= '0';
		iD <= x"00AA";
		iA <= "00011";	

		wait for iCLK_period*4;		

		iWE <= '1';
		
		wait for iCLK_period*2; 

      wait;
   end process;

END;
