----------------------------------------------------------------------------------
-- Company:  Faculty of technical sciencies Novi Sad 
-- Engineer: 
-- 
-- Create Date:    11:56:18 08/30/2017 
-- Design Name: 
-- Module Name:    ctrl_unit - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Control unit
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ctrl_unit is
	 Generic (
		--Instruction width
		INSTRUCTION_WIDTH : integer := 15;
		--Address width
		ADDRESS_WIDTH : integer := 16;
		--Mux selection width
		MUX_WIDTH : integer := 4;
		--Number of regs
		NUMBER_OF_REGS : integer := 8;
		--Alus selection width
		ALU_WIDTH : integer := 4
	 );
    Port ( iCLK : in  STD_LOGIC;
           inRST : in  STD_LOGIC;
           iZERO : in  STD_LOGIC;
           iSIGN : in  STD_LOGIC;
           iCARRY : in  STD_LOGIC;
           iINSTR : in  STD_LOGIC_VECTOR(INSTRUCTION_WIDTH-1 downto 0);
           oPC_EN : out  STD_LOGIC;
           oPC_LOAD : out  STD_LOGIC;
           oPC_IN : out  STD_LOGIC_VECTOR(ADDRESS_WIDTH-1 downto 0);
           oREG_WE : out  STD_LOGIC_VECTOR(NUMBER_OF_REGS-1 downto 0);
           oMUXA_SEL : out  STD_LOGIC_VECTOR(MUX_WIDTH-1 downto 0);
           oMUXB_SEL : out  STD_LOGIC_VECTOR(MUX_WIDTH-1 downto 0);
           oALU_SEL : out  STD_LOGIC_VECTOR(ALU_WIDTH-1 downto 0);
           oMEM_WE : out  STD_LOGIC);
end ctrl_unit;

architecture Behavioral of ctrl_unit is

begin
	
	oPC_EN <= '0';
	oPC_LOAD <= '0';
	oPC_IN <= (others => '0');
	oREG_WE <= (others => '0');
	oMUXA_SEL <= (others => '0');
	oMUXB_SEL <= (others => '0');
	oALU_SEL <= (others => '0');
	oMEM_WE <= '0';
	
end Behavioral;

