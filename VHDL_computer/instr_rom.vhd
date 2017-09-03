----------------------------------------------------------------------------------
-- Company: Faculty of techinical sciencies Novi Sad
-- Engineer: 
-- 
-- Create Date:    12:37:02 08/29/2017 
-- Design Name: 
-- Module Name:    instr_rom - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 	Instruction ROM
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity instr_rom is
	 Generic (
		--Word width 
		WORD_WIDTH : integer := 15;
		--Address width 
		ADDRESS_WIDTH : integer := 5;
		--Number of words
		NUMBER_OF_WORDS : integer := 32
	 );
    Port ( iA : in  STD_LOGIC_VECTOR(ADDRESS_WIDTH-1 downto 0);
           oQ : out  STD_LOGIC_VECTOR(WORD_WIDTH-1 downto 0));
end instr_rom;

architecture Behavioral of instr_rom is
	--Inruction ROM type
	type tROM is array(NUMBER_OF_WORDS-1 downto 0) of std_logic_vector(WORD_WIDTH-1 downto 0);
	--ROM signal 
	signal sROM : tROM := ( 
	0 => "000110001000000",
	1 => "000110010001000",
	2 => "000101111010000",
	3 => "001011110111000",
--	4 => "010101000000010",
--	5 => "010000000000010",
	4 => "110000000111010",
	5 => "100000110---010",
	6 => "111111000000000",
	7 => "000000000000000",
	8 => "000000000000000",
	9 => "000000000000000",
	10 => "000000000000000",
	11 => "000000000000000",
	12 => "000000000000000",
	13 => "000000000000000",
	14 => "000000000000000",
	15 => "000000000000000",
	16 => "000000000000000",
	17 => "000000000000000",
	18 => "000000000000000",
	19 => "000000000000000",
	20 => "000000000000000",
	21 => "000000000000000",
	22 => "000000000000000",
	23 => "000000000000000",
	24 => "000000000000000",
	25 => "000000000000000",
	26 => "000000000000000",
	27 => "000000000000000",
	28 => "000000000000000",
	29 => "000000000000000",
	30 => "000000000000000",
	31 => "000000000000000"
	);
	--ROM index 
	signal sLOCATION : integer range 0 to 15; 
begin
	--Address decoder
	sLOCATION <= CONV_INTEGER(iA);
	--Output signal
	oQ <= sROM(sLOCATION);
			
end Behavioral;

