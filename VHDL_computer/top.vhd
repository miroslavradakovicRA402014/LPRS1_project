----------------------------------------------------------------------------------
-- Company: Faculty of technical sciencies Novi Sad 
-- Engineer: 
-- 
-- Create Date:    13:58:10 08/30/2017 
-- Design Name: 
-- Module Name:    top - Behavioral 
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

entity top is
	 Generic (
		--Data width
		DATA_BUS_WIDTH : integer := 16;
		--Instruction word width
		INSTRUCTION_WIDTH : integer := 15;
		--Address width
		ADDRESS_BUS_WIDTH : integer := 16
	 );
    Port ( iCLK : in  STD_LOGIC;
           inRST : in  STD_LOGIC);
end top;

architecture Behavioral of top is
	--Computers internal signals
	
	--Write enable memory signal
	signal sMEM_WE : std_logic;
	--Address signal
	signal sADDR : std_logic_vector(ADDRESS_BUS_WIDTH-1 downto 0);
	--Data signals
	signal sDATA_ST,sDATA_LD : std_logic_vector(DATA_BUS_WIDTH-1 downto 0);
	--Instruction signal 
	signal sINSTR : std_logic_vector(INSTRUCTION_WIDTH-1 downto 0);
	--Program counter signal
	signal sPC : std_logic_vector(ADDRESS_BUS_WIDTH-1 downto 0);
	
				--COMPONENTS
	--CPU			
	component cpu_top is
	 Generic (
		DATA_WIDTH : integer := 16;
		INSTRUCTION_WIDTH : integer := 15;
		ADDRESS_WIDTH : integer := 16;
		NUMBER_OF_REGISTERS : integer := 8;
		MUX_SELECTION_WIDTH : integer := 4;
		ALU_SELECTION_WIDTH : integer := 4
	 );
    Port ( iCLK : in  STD_LOGIC;
           inRST : in  STD_LOGIC;
           iINSTR : in STD_LOGIC_VECTOR(INSTRUCTION_WIDTH-1 downto 0);
           iDATA : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           oPC : out  STD_LOGIC_VECTOR(ADDRESS_WIDTH-1 downto 0);
           oDATA : out  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           oADDR : out  STD_LOGIC_VECTOR(ADDRESS_WIDTH-1 downto 0);
           oMEM_WE : out  STD_LOGIC);
	end component;
	
	--Instruction ROM
	component instr_rom is
	 Generic (
		WORD_WIDTH : integer := 15;
		ADDRESS_WIDTH : integer := 5;
		NUMBER_OF_WORDS : integer := 32
	 );
    Port ( iA : in  STD_LOGIC_VECTOR(ADDRESS_WIDTH-1 downto 0);
           oQ : out  STD_LOGIC_VECTOR(WORD_WIDTH-1 downto 0));
	end component;	
	
	--Data RAM
	component data_ram is
	 Generic (
		WORD_WIDTH : integer := 16;
		ADDRESS_WIDTH : integer := 5;
		NUMBER_OF_WORDS : integer := 32
	 );
    Port ( iCLK : in  STD_LOGIC;
           inRST : in  STD_LOGIC;
           iA : in  STD_LOGIC_VECTOR(ADDRESS_WIDTH-1 downto 0);
           iD : in  STD_LOGIC_VECTOR(WORD_WIDTH-1 downto 0);
           iWE : in  STD_LOGIC;
           oQ : out  STD_LOGIC_VECTOR(WORD_WIDTH-1 downto 0));
	end component;	
	
begin
	--Instance of components
	CPU_TOP_I : cpu_top 
	port map (
		iCLK => iCLK, 
      inRST => inRST, 
      iINSTR => sINSTR,
      iDATA => sDATA_LD,
      oPC => sPC,
      oDATA => sDATA_ST,
      oADDR => sADDR,
      oMEM_WE => sMEM_WE		
	);

	INSRTUCION_ROM_I : instr_rom 
	port map (
		iA => sPC(4 downto 0),
      oQ => sINSTR
	);
	
	DATA_RAM_I : data_ram 
	port map (
	   iCLK => iCLK,
      inRST => inRST,
      iA => sADDR(4 downto 0),
      iD => sDATA_ST,
      iWE => sMEM_WE,
      oQ => sDATA_LD
	);
	
end Behavioral;

