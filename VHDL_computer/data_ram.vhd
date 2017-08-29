----------------------------------------------------------------------------------
-- Company: Faculty of techinical sciencies Novi Sad
-- Engineer: 
-- 
-- Create Date:    13:41:41 08/29/2017 
-- Design Name: 
-- Module Name:    data_ram - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Data RAM
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

entity data_ram is
	 Generic (
		--Word width
		WORD_WIDTH : integer := 16;
		--Address width
		ADDRESS_WIDTH : integer := 5;
		--Number of words
		NUMBER_OF_WORDS : integer := 32
	 );
    Port ( iCLK : in  STD_LOGIC;
           inRST : in  STD_LOGIC;
           iA : in  STD_LOGIC_VECTOR(ADDRESS_WIDTH-1 downto 0);
           iD : in  STD_LOGIC_VECTOR(WORD_WIDTH-1 downto 0);
           iWE : in  STD_LOGIC;
           oQ : out  STD_LOGIC_VECTOR(WORD_WIDTH-1 downto 0));
end data_ram;

architecture Behavioral of data_ram is
	--Type of RAM 
	type tRAM is array(NUMBER_OF_WORDS-1 downto 0) of std_logic_vector(WORD_WIDTH-1 downto 0);
	--Signal of RAM
	signal sRAM : tRAM := ( 
		others => x"0000"
	);
	--Signal of RAM location
	signal sLOCATION : integer range 0 to 31;
	
begin
	--Decode address
	sLOCATION <= CONV_INTEGER(iA);
	--RAM memory process 
	process (iCLK) begin
		if (iCLK'event and iCLK = '0') then
			if (inRST = '0') then --Reset memory
				for i in sRAM'range loop
					sRAM(i) <= (others => '0');
				end loop;
			elsif (iWE = '1') then
				sRAM(sLOCATION) <= iD; --Write to memory
			end if;
		end if;
	end process;
	--Output RAM signal
	oQ <= sRAM(sLOCATION);
	
end Behavioral;

