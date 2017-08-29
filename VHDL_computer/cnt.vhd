----------------------------------------------------------------------------------
-- Company: Faculty of technical sciencies Novi Sad
-- Engineer: 
-- 
-- Create Date:    12:11:22 08/29/2017 
-- Design Name: 
-- Module Name:    cnt - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Program counter
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

entity cnt is
    Generic (
		--Widht of data
		DATA_WIDTH : integer := 16
	);																																											
    Port ( iCLK : in  STD_LOGIC;
           inRST : in  STD_LOGIC;
           iD : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           iEN : in  STD_LOGIC;
           iLOAD : in  STD_LOGIC;
           oQ : out  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0));
end cnt;

architecture Behavioral of cnt is
	--Counter signal
	signal sCNT : std_logic_vector(DATA_WIDTH-1 downto 0);
begin
	--Counter process
	process (iCLK) begin
		if (iCLK'event and iCLK = '1') then 
			if (inRST = '0') then 
				sCNT <= (others => '0'); --Reset counter
			elsif (iEN = '1') then --Count enabled
				if (iLOAD = '1') then
					sCNT <= iD; --Load new value
				else 
					sCNT <= sCNT + 1; --Next count
				end if;
			end if;
		end if;
	end process;
	--Ouput signal
	oQ <= sCNT;
	
end Behavioral;

