----------------------------------------------------------------------------------
-- Company: Faculty of technical sciencies Novi Sad 
-- Engineer: 
-- 
-- Create Date:    10:15:14 08/30/2017 
-- Design Name: 
-- Module Name:    reg - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
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

entity reg is
	 Generic (
		--Register data width
		DATA_WIDTH : integer := 16
	 );
    Port ( iCLK : in  STD_LOGIC;
           inRST : in  STD_LOGIC;
           iREG_WE : in  STD_LOGIC;
           iD : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           oQ : out  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0));
end reg;

architecture Behavioral of reg is
	--Register signal
	signal sREG : std_logic_vector(DATA_WIDTH-1 downto 0);

begin
	--Register process
	process (iCLK) begin
		if (iCLK'event and iCLK = '1') then
			if (inRST = '0') then
				sREG <= (others => '0'); --Reset register
			elsif (iREG_WE = '1') then --Write enabled
				sREG <= iD;
			end if;
		end if;
	end process;
	--Ouput signal
	oQ  <= sREG;
	
end Behavioral;

