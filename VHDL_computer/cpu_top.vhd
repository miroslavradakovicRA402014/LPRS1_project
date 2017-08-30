----------------------------------------------------------------------------------
-- Company: Faculty of technical sciencies Novi Sad 
-- Engineer: 
-- 
-- Create Date:    12:07:45 08/30/2017 
-- Design Name: 
-- Module Name:    cpu_top - Behavioral 
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

entity cpu_top is
	 Generic (
		--Data width
		DATA_WIDTH : integer := 16;
		--Instruction width
		INSTRUCTION_WIDTH : integer := 15;
		--Address width
		ADDRESS_WIDTH : integer := 16;
		--Num of registers
		NUMBER_OF_REGISTERS : integer := 8;
		--Mux and ALU selection width
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
end cpu_top;

architecture Behavioral of cpu_top is
	--Processors internal signals
	
	--Register signals
	signal sR0,sR1,sR2,sR3,sR4,sR5,sR6,sR7: std_logic_vector(DATA_WIDTH-1 downto 0);
	--Register enable signal
	signal sREG_WE : std_logic_vector(NUMBER_OF_REGISTERS-1 downto 0);
	--Result form ALU
	signal sRESULT : std_logic_vector(DATA_WIDTH-1 downto 0);
	--Carry sign and zero from ALU
	signal sCARRY,sZERO,sSIGN : std_logic;
	--ALU operands signals
	signal sMUXA,sMUXB : std_logic_vector(DATA_WIDTH-1 downto 0);
	--MUX selection signals
	signal sMUXA_SEL,sMUXB_SEL : std_logic_vector(MUX_SELECTION_WIDTH-1 downto 0);
	--ALU selection signal
	signal sALU_SEL : std_logic_vector(ALU_SELECTION_WIDTH-1 downto 0);
	--Signal of memory write enable
	signal sMEM_WE : std_logic;
	--Prgram counter address
	signal sPC_IN : std_logic_vector(ADDRESS_WIDTH-1 downto 0);
	--Enable and load program counter signal
	signal sPC_LOAD,sPC_EN : std_logic;
	--Program counter signal
	signal sPC : std_logic_vector(ADDRESS_WIDTH-1 downto 0);


									--COMPONENTS
	--Register
	component reg is
	 Generic (
		DATA_WIDTH : integer := 16
	 );
    Port ( iCLK : in  STD_LOGIC;
           inRST : in  STD_LOGIC;
           iREG_WE : in  STD_LOGIC;
           iD : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           oQ : out  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0));
	 end component;
	 
	 --Multiplexer
	component mux is
	 Generic (
		DATA_WIDTH : integer := 16;
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
	end component;
	
	--ALU	
	component alu is
	 Generic (
		DATA_WIDTH : integer := 16
	 );
    Port ( iOP1 : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           iOP2 : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           iALU_SEL : in  STD_LOGIC_VECTOR(3 downto 0);
           oRESULT : out  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           oZERO : out  STD_LOGIC;
           oCARRY : out  STD_LOGIC;
           oSIGN : out  STD_LOGIC);
	end component;	
	
	--Program counter
	component cnt is
    Generic (
		DATA_WIDTH : integer := 16
	);																																											
    Port ( iCLK : in  STD_LOGIC;
           inRST : in  STD_LOGIC;
           iD : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           iEN : in  STD_LOGIC;
           iLOAD : in  STD_LOGIC;
           oQ : out  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0));
	end component;
		
	--Control unit	
	component ctrl_unit is
	 Generic (
		INSTRUCTION_WIDTH : integer := 15;
		ADDRESS_WIDTH : integer := 16;
		MUX_WIDTH : integer := 4;
		NUMBER_OF_REGS : integer := 8;
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
	end component;	
	
begin
	--Instance of components
	R0 : reg 
	port map (
		iCLK => iCLK,
      inRST => inRST,
      iREG_WE => sREG_WE(0),
      iD => sRESULT,
      oQ => sR0	
	);
	
	R1 : reg 
	port map (
		iCLK => iCLK,
      inRST => inRST,
      iREG_WE => sREG_WE(1),
      iD => sRESULT,
      oQ => sR1	
	);

	R2 : reg 
	port map (
		iCLK => iCLK,
      inRST => inRST,
      iREG_WE => sREG_WE(2),
      iD => sRESULT,
      oQ => sR2	
	);

	R3 : reg 
	port map (
		iCLK => iCLK,
      inRST => inRST,
      iREG_WE => sREG_WE(3),
      iD => sRESULT,
      oQ => sR3	
	);
	
	R4 : reg 
	port map (
		iCLK => iCLK,
      inRST => inRST,
      iREG_WE => sREG_WE(4),
      iD => sRESULT,
      oQ => sR4	
	);
	
	R5 : reg 
	port map (
		iCLK => iCLK,
      inRST => inRST,
      iREG_WE => sREG_WE(5),
      iD => sRESULT,
      oQ => sR5	
	);
	
	R6 : reg 
	port map (
		iCLK => iCLK,
      inRST => inRST,
      iREG_WE => sREG_WE(6),
      iD => sRESULT,
      oQ => sR6	
	);
	
	R7 : reg 
	port map (
		iCLK => iCLK,
      inRST => inRST,
      iREG_WE => sREG_WE(7),
      iD => sRESULT,
      oQ => sR7	
	);
	
   MUXA : mux 	
	port map (
		iR0 => sR0,
      iR1 => sR1,
      iR2 => sR2,
      iR3 => sR3, 
      iR4 => sR4,
      iR5 => sR5,
      iR6 => sR6,
      iR7 => sR7,
      iDATA => iDATA,
      iMUX_SEL => sMUXA_SEL,
      oMUX => sMUXA
	);
	
   MUXB : mux 	
	port map (
		iR0 => sR0,
      iR1 => sR1,
      iR2 => sR2,
      iR3 => sR3, 
      iR4 => sR4,
      iR5 => sR5,
      iR6 => sR6,
      iR7 => sR7,
      iDATA => iDATA,
      iMUX_SEL => sMUXB_SEL,
      oMUX => sMUXB
	);

	ALU_I : alu 
	port map (
	   iOP1 => sMUXA,
      iOP2 => sMUXB, 
      iALU_SEL => sALU_SEL,
      oRESULT => sRESULT,
	   oZERO => sZERO,
      oCARRY => sCARRY,
      oSIGN => sSIGN
	);	

	PC : cnt 
	port map (
		iCLK => iCLK,
      inRST => inRST,
      iD => sPC_IN,
      iEN => sPC_EN,
      iLOAD => sPC_LOAD,
      oQ => sPC
	);
	
	CONTROL_UNIT : ctrl_unit
	port map(
		iCLK => iCLK,
      inRST => inRST, 
      iZERO => sZERO,
      iSIGN => sSIGN,
      iCARRY => sCARRY,
      iINSTR => iINSTR,  
      oPC_EN => sPC_EN,
      oPC_LOAD => sPC_LOAD,
      oPC_IN => sPC_IN,
      oREG_WE => sREG_WE,
      oMUXA_SEL => sMUXA_SEL,
      oMUXB_SEL => sMUXB_SEL,
      oALU_SEL => sALU_SEL,
      oMEM_WE => sMEM_WE
	);

	--Output signals
	oPC <= sPC;
	oMEM_WE <= sMEM_WE;
	oADDR <= sMUXB;
	oDATA <= sRESULT;
	
end Behavioral;

