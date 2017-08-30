----------------------------------------------------------------------------------
-- Company: Faculty of technical sciencies Novi Sad 
-- Engineer: 
-- 
-- Create Date:    10:56:05 08/30/2017 
-- Design Name: 
-- Module Name:    alu - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: ALU 
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

entity alu is
	 Generic (
		--Data width
		DATA_WIDTH : integer := 16
	 );
    Port ( iOP1 : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           iOP2 : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           iALU_SEL : in  STD_LOGIC_VECTOR(3 downto 0);
           oRESULT : out  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           oZERO : out  STD_LOGIC;
           oCARRY : out  STD_LOGIC;
           oSIGN : out  STD_LOGIC);
end alu;

architecture Behavioral of alu is
	--Result signal
	signal sRESULT : STD_LOGIC_VECTOR(DATA_WIDTH downto 0);
	--Carry zero and sign flags
	signal sCARRY,sSIGN,sZERO : STD_LOGIC;
begin
	--ALU process
	process (iOP1,iOP2,iALU_SEL) begin
		case (iALU_SEL) is
			when "0000" => sRESULT <= '0' & iOP1; --mov 
			when "0001" => sRESULT <= ('0' & iOP1) + ('0' & iOP2); --add
			when "0010" => sRESULT <= ('0' & iOP1) - ('0' & iOP2); --sub
			when "0011" => sRESULT <= '0' & (iOP1 and iOP2);		--and
			when "0100" => sRESULT <= '0' & (iOP1 or iOP2);			--or
			when "0101" => sRESULT <= '0' & not(iOP1);				--not
			when "0110" => sRESULT <= ('0' & iOP1) + 1;				--inc
			when "0111" => sRESULT <= ('0' & iOP1) - 1;				--dec
			when "1000" => sRESULT <= iOP1 & '0';						--shl
			when "1001" => sRESULT <= iOP1(0) & '0' & iOP1(15 downto 1); --shr
			when "1010" => sRESULT <= ('0' & not(iOP1)) + 1; -- neg
			when "1011" => sRESULT <= iOP1(0) & iOP1(15) & iOP1(15) & iOP1(14 downto 1); --ashr
			when "1100" => sRESULT <= iOP1 & '0'; --aslh
			when others => sRESULT <= (others => 'Z');
		end case;
	end process;
	--Carry,sign and zero signals
	sZERO <= '1' when sRESULT(15 downto 0) = x"0000" else
				'0';
	sCARRY <= '1' when sRESULT(16) = '1' else
				'0';
	sSIGN <= '1' when sRESULT(15) = '1' else
				'0';
	--Output signals
	oZERO <= sZERO;
	oCARRY <= sCARRY;
	oSIGN <= sSIGN;
	
	oRESULT <= sRESULT(15 downto 0);
	
end Behavioral;

