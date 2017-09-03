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
	--Type of control unit states
	type tSTATES is (IDLE,FETCH,DECODE,MOVI,ADDI,SUBI,ANDI,ORI,NOTI,INCI,DECI,SHRI,SHLI,NEGI,ASHLI,ASHRI,JMPI,JMPZI,JMPNZI,JMPSI,JMPNSI,JMPCI,JMPNCI,LOADI,STOREI,T1,ENDP);
	--Next and current state of control unit
	signal sCURRENT_STATE,sNEXT_STATE : tSTATES;
	--Output sigal from control unit
	signal sCONTROL_WORD : std_logic_vector(38 downto 0);
	--Instruction code from input
	signal sINSTRUCTION_CODE : std_logic_vector(5 downto 0);
	--Registers from istruction 
	signal sRX,sRY,sRZ : std_logic_vector(2 downto 0);
	--Decoded regster operand
	signal sDEC_RZ : std_logic_vector(7 downto 0);
	--Jump instruction address
	signal sJMP_ADDRESS : std_logic_vector(8 downto 0);

begin
	--Instruction code
	sINSTRUCTION_CODE <= iINSTR(14 downto  9);
	sRZ <= iINSTR(8 downto  6);
	sRX <= iINSTR(5 downto  3);
	sRY <= iINSTR(2 downto  0);
	--Decode output register code			
		sDEC_RZ <= "00000001"  when sRZ = "000" else
					  "00000010"  when sRZ = "001" else	
					  "00000100"  when sRZ = "010" else
					  "00001000"  when sRZ = "011" else
					  "00010000"  when sRZ = "100" else
					  "00100000"  when sRZ = "101" else
					  "01000000"  when sRZ = "110" else
					  "10000000";
	--Jump address
	sJMP_ADDRESS <= iINSTR(8 downto 0);
	--Control unit flip flop 
	process (iCLK) begin
		if (iCLK'event and iCLK = '1') then
			if (inRST = '0') then
				sCURRENT_STATE <= IDLE; --Initial state of computer
			else
				sCURRENT_STATE <= sNEXT_STATE;--Next state of control unit
			end if;
		end if;
	end process;
	
	process (sCURRENT_STATE,iINSTR,iZERO,iSIGN,iCARRY) begin
		case (sCURRENT_STATE) is
			when IDLE => 
				sNEXT_STATE <= FETCH;
				--Control word		
				sCONTROL_WORD <= "0------------00000000000000000000000010";	
			when FETCH =>
				--Fetch instruction
				sNEXT_STATE <= DECODE;
				--Control word	
				sCONTROL_WORD <= "0------------00000000----------------00";				
			when DECODE =>
				--Decode instruction
				case (sINSTRUCTION_CODE) is 
					when "000000" => 
						sNEXT_STATE <= MOVI;
					when "000001" => 
						sNEXT_STATE <= ADDI;
					when "000010" => 
						sNEXT_STATE <= SUBI;
					when "000011" => 
						sNEXT_STATE <= ANDI;
					when "000100" => 
						sNEXT_STATE <= ORI;
					when "000101" => 
						sNEXT_STATE <= NOTI;
					when "000110" => 
						sNEXT_STATE <= INCI;
					when "000111" => 
						sNEXT_STATE <= DECI;
					when "001000" => 
						sNEXT_STATE <= SHLI;
					when "001001" => 
						sNEXT_STATE <= SHRI;
					when "001010" => 
						sNEXT_STATE <= NEGI;
					when "001011" => 
						sNEXT_STATE <= ASHRI;
					when "001100" => 
						sNEXT_STATE <= ASHLI;
					when "010000" =>
						sNEXT_STATE <= JMPI;
					when "010001" =>
						sNEXT_STATE <= JMPZI;	
					when "010010" =>
						sNEXT_STATE <= JMPSI;
					when "010011" =>
						sNEXT_STATE <= JMPCI;
					when "010101" =>
						sNEXT_STATE <= JMPNZI;
					when "010110" =>
						sNEXT_STATE <= JMPNSI;
					when "010111" =>
						sNEXT_STATE <= JMPNCI;	
					when "100000" =>
						sNEXT_STATE <= LOADI;
					when "110000" =>
						sNEXT_STATE <= STOREI;						
					when "111111" => 
						sNEXT_STATE <= ENDP;
					when others	  => 
						sNEXT_STATE <= IDLE;
				end case;
				--Control word	
				sCONTROL_WORD <= "0------------00000000----------------00";
			--Mircroprograms execute period	
			when MOVI =>
				sNEXT_STATE <= T1;
				--Control word	
				sCONTROL_WORD <= "00000----0" & sRX & sDEC_RZ & "----------------00";				
			when ADDI =>
				sNEXT_STATE <= T1;
				--Control word	
				sCONTROL_WORD <= "000010" & sRY & '0' & sRX & sDEC_RZ & "----------------00";					
			when SUBI =>
				sNEXT_STATE <= T1;	
				--Control word	
				sCONTROL_WORD <= "000100" & sRY & '0' & sRX & sDEC_RZ & "----------------00";					
			when ANDI =>
				sNEXT_STATE <= T1;
				--Control word	
				sCONTROL_WORD <= "000110" & sRY  & '0' & sRX & sDEC_RZ & "----------------00";				
			when ORI =>
				sNEXT_STATE <= T1;
				--Control word	
				sCONTROL_WORD <= "001000" & sRY  & '0' & sRX & sDEC_RZ & "----------------00";					
			when NOTI =>
				sNEXT_STATE <= T1;
				--Control word	
				sCONTROL_WORD <= "00101----0" & sRX & sDEC_RZ & "----------------00";				
			when INCI =>
				sNEXT_STATE <= T1;
				--Control word	
				sCONTROL_WORD <= "00110----0" & sRX & sDEC_RZ & "----------------00";				
			when DECI =>
				sNEXT_STATE <= T1;
				--Control word	
				sCONTROL_WORD <= "00111----0" & sRX & sDEC_RZ & "----------------00";				
			when SHLI =>
				sNEXT_STATE <= T1;
				--Control word	
				sCONTROL_WORD <= "01000----0" & sRX & sDEC_RZ & "----------------00";					
			when SHRI =>
				sNEXT_STATE <= T1;
				--Control word	
				sCONTROL_WORD <= "01001----0" & sRX & sDEC_RZ & "----------------00";				
			when NEGI =>
				sNEXT_STATE <= T1;
				--Control word	
				sCONTROL_WORD <= "01010----0" & sRX & sDEC_RZ & "----------------00";				
			when ASHRI =>
				sNEXT_STATE <= T1;
				--Control word	
				sCONTROL_WORD <= "01011----0" & sRX & sDEC_RZ & "----------------00";				
			when ASHLI =>
				sNEXT_STATE <= T1;
				--Control word	
				sCONTROL_WORD <= "01100----0" & sRX & sDEC_RZ & "----------------00";
			when JMPI =>
				sNEXT_STATE <= FETCH;
				--Control word	
				sCONTROL_WORD <= "-------------000000000000000" & sJMP_ADDRESS & "11";
			when JMPZI =>
				sNEXT_STATE <= FETCH;
				if (iZERO = '1') then --Jump if true
					--Control word	
					sCONTROL_WORD <= "-------------000000000000000" & sJMP_ADDRESS & "11";				
				else
					--Control word	
					sCONTROL_WORD <= "-------------000000000000000" & sJMP_ADDRESS & "01";	
				end if;
			when JMPSI =>
				sNEXT_STATE <= FETCH;
				if (iSIGN = '1') then --Jump if true
					--Control word	
					sCONTROL_WORD <= "-------------000000000000000" & sJMP_ADDRESS & "11";				
				else
					--Control word	
					sCONTROL_WORD <= "-------------000000000000000" & sJMP_ADDRESS & "01";	
				end if;		
			when JMPCI =>
				sNEXT_STATE <= FETCH;
				if (iCARRY = '1') then --Jump if true
					--Control word	
					sCONTROL_WORD <= "-------------000000000000000" & sJMP_ADDRESS & "11";				
				else
					--Control word	
					sCONTROL_WORD <= "-------------000000000000000" & sJMP_ADDRESS & "01";	
				end if;
			when JMPNZI =>
				sNEXT_STATE <= FETCH;
				if (iZERO = '0') then --Jump if true
					--Control word	
					sCONTROL_WORD <= "-------------000000000000000" & sJMP_ADDRESS & "11";				
				else
					--Control word	
					sCONTROL_WORD <= "-------------000000000000000" & sJMP_ADDRESS & "01";	
				end if;			
			when JMPNSI =>
				sNEXT_STATE <= FETCH;
				if (iSIGN = '0') then --Jump if true
					--Control word	
					sCONTROL_WORD <= "-------------000000000000000" & sJMP_ADDRESS & "11";				
				else
					--Control word	
					sCONTROL_WORD <= "-------------000000000000000" & sJMP_ADDRESS & "01";	
				end if;			
			when JMPNCI =>
				sNEXT_STATE <= FETCH;
				if (iCARRY = '0') then --Jump if true
					--Control word	
					sCONTROL_WORD <= "-------------000000000000000" & sJMP_ADDRESS & "11";				
				else
					--Control word	
					sCONTROL_WORD <= "-------------000000000000000" & sJMP_ADDRESS & "01";	
				end if;	
			when LOADI =>
				sNEXT_STATE <= T1;
				--Control word	
				sCONTROL_WORD <= "000000" & sRY & "1000" & sDEC_RZ & "----------------00";
			when STOREI =>
				sNEXT_STATE <= FETCH;
				--Control word	
				sCONTROL_WORD <= "100000" & sRY & '0' & sRX & "00000000----------------01";					
			when ENDP =>	
				sNEXT_STATE <= IDLE;
				--Control word	
				sCONTROL_WORD <= (others => '0');			
			-- T1 period of execute cycle
			when T1 =>	
				case (sINSTRUCTION_CODE) is 
					when "000000" => 
						sNEXT_STATE <= FETCH;
						--Control word	
						sCONTROL_WORD <= "00000----0" & sRX & sDEC_RZ & "----------------01";						
					when "000001" => 
						sNEXT_STATE <= FETCH;
						--Control word	
						sCONTROL_WORD <= "000010" & sRY & '0' & sRX & sDEC_RZ & "----------------01";						
					when "000010" => 
						sNEXT_STATE <= FETCH;
						--Control word	
						sCONTROL_WORD <= "000100" & sRY  & '0' & sRX & sDEC_RZ & "----------------01";							
					when "000011" => 
						sNEXT_STATE <= FETCH;
						--Control word	
						sCONTROL_WORD <= "000110" & sRY & '0' & sRX & sDEC_RZ & "----------------01";							
					when "000100" => 
						sNEXT_STATE <= FETCH;
						--Control word	
						sCONTROL_WORD <= "001000" & sRY & '0' & sRX & sDEC_RZ & "----------------01";						
					when "000101" => 
						sNEXT_STATE <= FETCH;
						--Control word	
						sCONTROL_WORD <= "00101----0" & sRX & sDEC_RZ & "----------------01";							
					when "000110" => 
						sNEXT_STATE <= FETCH;
						--Control word	
						sCONTROL_WORD <= "00110----0" & sRX & sDEC_RZ & "----------------01";								
					when "000111" => 
						sNEXT_STATE <= FETCH;
						--Control word	
						sCONTROL_WORD <= "00111----0" & sRX & sDEC_RZ & "----------------01";							
					when "001000" => 
						sNEXT_STATE <= FETCH;
						--Control word	
						sCONTROL_WORD <= "01000----0" & sRX & sDEC_RZ & "----------------01";							
					when "001001" => 
						sNEXT_STATE <= FETCH;
						--Control word	
						sCONTROL_WORD <= "01001----0" & sRX & sDEC_RZ & "----------------01";						
					when "001010" => 
						sNEXT_STATE <= FETCH;
						--Control word	
						sCONTROL_WORD <= "01010----0" & sRX & sDEC_RZ & "----------------01";							
					when "001011" => 
						sNEXT_STATE <= FETCH;
						--Control word	
						sCONTROL_WORD <= "01011----0" & sRX & sDEC_RZ & "----------------01";							
					when "001100" => 
						sNEXT_STATE <= FETCH;
						--Control word	
						sCONTROL_WORD <= "01100----0" & sRX & sDEC_RZ & "----------------01";
					when "100000" => 
						sNEXT_STATE <= FETCH;
						--Control word	
						sCONTROL_WORD <= "000000" & sRY & "1000" & sDEC_RZ & "----------------01";						
					when others	  => 
						sNEXT_STATE <= IDLE;
						--Control word	
						sCONTROL_WORD <= (others => '0');							
				end case;
		end case;
	end process;
	
	
--------------------------------------------------------------	
				--CONTROL SIGNALS
--------------------------------------------------------------
	oPC_EN <= sCONTROL_WORD(0);
	oPC_LOAD <= sCONTROL_WORD(1);
	oPC_IN <= sCONTROL_WORD(17 downto 2);
	oREG_WE <= sCONTROL_WORD(25 downto 18);
	oMUXA_SEL <= sCONTROL_WORD(29 downto 26);
	oMUXB_SEL <= sCONTROL_WORD(33 downto 30);
	oALU_SEL <= sCONTROL_WORD(37 downto 34);
	oMEM_WE <= sCONTROL_WORD(38);
	
end Behavioral;

