----------------------------------------------------------------------------------
-- Company: Faculty of technical sciencies Novi Sad 
-- Engineer: 
-- 
-- Create Date:    10:33:49 08/30/2017 
-- Design Name: 
-- Module Name:    mux - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Multiplexer
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

entity mux is
	 Generic (
		--Data width 
		DATA_WIDTH : integer := 16;
		--Select lines
		SELECT_LINES : integer := 4
	 );
    Port ( iR0 : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           iR1 : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           iR2 : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           iR3 : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           iR4 : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           iR5 : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           iR6 : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           iR7 : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           iDATA : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           iMUX_SEL : in  STD_LOGIC_VECTOR(SELECT_LINES-1 downto 0);
           oMUX : out  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0));
end mux;

architecture Behavioral of mux is

begin
	--Multipelxer process 
	process (iR0,iR1,iR2,iR3,iR4,iR5,iR6,iR7,iDATA,iMUX_SEL) begin
		case (iMUX_SEL(3 downto 0)) is
			when "0000" => oMUX <= iR0;
			when "0001" => oMUX <= iR1;
			when "0010" => oMUX <= iR2;
			when "0011" => oMUX <= iR3;
			when "0100" => oMUX <= iR4;
			when "0101" => oMUX <= iR5;
			when "0110" => oMUX <= iR6;
			when "0111" => oMUX <= iR7;
			when "1000" => oMUX <= iDATA;
			when others => oMUX <= (others => 'Z');
		end case;
	end process;
	
end Behavioral;

