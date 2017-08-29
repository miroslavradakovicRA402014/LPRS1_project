--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:23:38 08/29/2017
-- Design Name:   
-- Module Name:   /home/mika/Projects/projects_workspace/VHDL_processor/VHDL_computer/cnt_tb.vhd
-- Project Name:  VHDL_computer
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: cnt
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
 
ENTITY cnt_tb IS
END cnt_tb;
 
ARCHITECTURE behavior OF cnt_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT cnt
    PORT(
         iCLK : IN  std_logic;
         inRST : IN  std_logic;
         iD : IN  std_logic_vector(15 downto 0);
         iEN : IN  std_logic;
         iLOAD : IN  std_logic;
         oQ : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal iCLK : std_logic := '0';
   signal inRST : std_logic := '0';
   signal iD : std_logic_vector(15 downto 0) := (others => '0');
   signal iEN : std_logic := '0';
   signal iLOAD : std_logic := '0';

 	--Outputs
   signal oQ : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant iCLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: cnt PORT MAP (
          iCLK => iCLK,
          inRST => inRST,
          iD => iD,
          iEN => iEN,
          iLOAD => iLOAD,
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
	  iD <= x"00A0";
	  iLOAD <= '0';
	  iEN <= '0';
	  
	  wait for iCLK_period*3;
	
	  iEN <= '1';

     wait for iCLK_period*15;

	  iLOAD <= '1';		
				
	  wait for iCLK_period;

     iLOAD <= '0';
	  
	  wait for iCLK_period*6;
	  
	  iEN <= '0';
	  
     wait;
   end process;

END;
