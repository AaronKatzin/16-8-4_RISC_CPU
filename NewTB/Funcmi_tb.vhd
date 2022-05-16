library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity FUNCMI_tb is
end FUNCMI_tb;

architecture ARC_FUNCMI_tb of FUNCMI_tb is
	
	type test_array is array (natural range <>) of
		std_logic_vector (0 to 15);
	constant test_data: test_array := (

-- Load Address = x"0000"
-- Program Memory (M0) Word = 8

-- The Following Labels were defined:
-- AdrA = 0000
-- Bun_imd = 0032
-- Bun_long_direct_indexed = 0048


-- (1) AdrA: x"0000"
-- 1 (4) lod r0, #x"0008" ; r0 := x"0008"
-- Program Counter = x"0000" (10001 101 0000 0000)
-- Addressing Mode is: Long Immediate
x"8d00",
x"0008",

-- 2 (5) out r0 ; r0 == x"0008";
-- Program Counter = x"0004" (11001 000 0000 0000)
-- Addressing Mode is: Short Direct
x"c800",

-- 3 (8) lod rC, #x"EEEE" ; rC := x"EEEE"
-- Program Counter = x"0006" (10001 101 1100 0000)
-- Addressing Mode is: Long Immediate
x"8dc0",
x"eeee",

-- 4 (9) lod r4, #x"0004" ; r4 := x"0004"
-- Program Counter = x"000a" (10001 101 0100 0000)
-- Addressing Mode is: Long Immediate
x"8d40",
x"0004",

-- 5 (10) str r4, rC ; rC := r4 = x"0004"
-- Program Counter = x"000e" (10011 000 0100 1100)
-- Addressing Mode is: Short Direct
x"984c",

-- 6 (11) out rC ; rC == x"0004";
-- Program Counter = x"0010" (11001 000 1100 0000)
-- Addressing Mode is: Short Direct
x"c8c0",

-- 7 (14) lod r0, #x"EEEE" ;
-- Program Counter = x"0012" (10001 101 0000 0000)
-- Addressing Mode is: Long Immediate
x"8d00",
x"eeee",

-- 8 (15) lod r8, #x"1234" ;
-- Program Counter = x"0016" (10001 101 1000 0000)
-- Addressing Mode is: Long Immediate
x"8d80",
x"1234",

-- 9 (16) lod rC, #x"0004" ;
-- Program Counter = x"001a" (10001 101 1100 0000)
-- Addressing Mode is: Long Immediate
x"8dc0",
x"0004",

-- 10 (17) str r8, AdrA, rC ; M1[ AdrA + rC =x"0004" ]:= r8 , r8= x"1234" ,M1[x"0004"]=x"1234", AdrA=x"0000"
-- Program Counter = x"001e" (10011 100 1000 1100)
-- Addressing Mode is: Long Direct Index
x"9c8c",
x"0000",

-- 11 (18) lod r0, AdrA, rC ; r0 := M1[x"0004"] = x"1234"
-- Program Counter = x"0022" (10001 100 0000 1100)
-- Addressing Mode is: Long Direct Index
x"8c0c",
x"0000",

-- 12 (19) out r0 ; r0 == x"1234";
-- Program Counter = x"0026" (11001 000 0000 0000)
-- Addressing Mode is: Short Direct
x"c800",

-- 13 (22) lod rC, #x"0001" ;
-- Program Counter = x"0028" (10001 101 1100 0000)
-- Addressing Mode is: Long Immediate
x"8dc0",
x"0001",

-- 14 (23) bun #Bun_imd ;
-- Program Counter = x"002c" (01000 101 0000 0000)
-- Addressing Mode is: Long Immediate
x"4500",
x"0032",

-- 15 (24) sub rC,rC ; rC:= rC -rC =0, shouldn't be performed @test_skip@
-- Program Counter = x"0030" (00011 000 1100 1100)
-- Addressing Mode is: Short Direct
x"18cc",

-- (25) Bun_imd: 
-- 16 (26) inc rC ; rC:= rC + 1; rC should be x"0002" after execution of command
-- Program Counter = x"0032" (00101 000 1100 0000)
-- Addressing Mode is: Short Direct
x"28c0",

-- 17 (27) out rC ; rC==x"0002"
-- Program Counter = x"0034" (11001 000 1100 0000)
-- Addressing Mode is: Short Direct
x"c8c0",

-- 18 (30) lod r4, #x"0004" ;
-- Program Counter = x"0036" (10001 101 0100 0000)
-- Addressing Mode is: Long Immediate
x"8d40",
x"0004",

-- 19 (31) lod r8, #Bun_long_direct_indexed 
-- Program Counter = x"003a" (10001 101 1000 0000)
-- Addressing Mode is: Long Immediate
x"8d80",
x"0048",

-- 20 (32) str r8, AdrA, r4 ; M1[x"0004"] = M1[ AdrA + x"0004"]:= r8 , r8= #Bun_long_direct_indexed ,AdrA=x"0000" => M1[4]=#Bun_long_direct_indexed
-- Program Counter = x"003e" (10011 100 1000 0100)
-- Addressing Mode is: Long Direct Index
x"9c84",
x"0000",

-- 21 (33) bun AdrA, r4 
-- Program Counter = x"0042" (01000 100 0000 0100)
-- Addressing Mode is: Long Direct Index
x"4404",
x"0000",

-- 22 (34) sub rC,rC ; rC:= rC -rC =0, shouldn't be performed @test_skip@
-- Program Counter = x"0046" (00011 000 1100 1100)
-- Addressing Mode is: Short Direct
x"18cc",

-- (35) Bun_long_direct_indexed: 
-- 23 (36) inc rC ; rC:= rC + 1; rC should be x"0003" after execution of command
-- Program Counter = x"0048" (00101 000 1100 0000)
-- Addressing Mode is: Short Direct
x"28c0",

-- 24 (37) out rC ; rC==x"0003"
-- Program Counter = x"004a" (11001 000 1100 0000)
-- Addressing Mode is: Short Direct
x"c8c0",

-- TestBench instruction table closing
x"0000" -- this is NOT a valid instruction

	
	);
	
	component Funcmi is
    port 
    	(
		clk          : in std_logic;
		dma          : in std_logic;
		ext_adr      : in std_logic_vector(15 downto 0);
		ext_in       : out std_logic_vector(15 downto 0);
		ext_out      : in std_logic_vector(15 downto 0);
		ext_rdwr     : in std_logic;
		fgi          : in std_logic;
		fgi_reset    : out std_logic;
		fgo          : in std_logic;
		fgo_reset    : out std_logic;
		idle         : out std_logic;
		inpr         : in std_logic_vector(15 downto 0);
		m            : in std_logic;
		outr         : out std_logic_vector(15 downto 0);
		rst          : in std_logic;
		s            : in std_logic
    	);
end component; 
	
	signal clk          : std_logic;
	signal dma          : std_logic;
	signal ext_adr      : std_logic_vector(15 downto 0);
	signal ext_in       : std_logic_vector(15 downto 0);
	signal ext_out      : std_logic_vector(15 downto 0);
	signal ext_rdwr     : std_logic;
	signal fgi          : std_logic;
	signal fgi_reset    : std_logic;
	signal fgo          : std_logic;
	signal fgo_reset    : std_logic;
	signal idle         : std_logic;
	signal inpr         : std_logic_vector(15 downto 0);
	signal m            : std_logic;
	signal outr         : std_logic_vector(15 downto 0);
	signal rst          : std_logic;
	signal s            : std_logic;
	
    	
begin
	UUT : Funcmi port map
		(
			clk       , 	 
			dma       ,  
			ext_adr   , 
			ext_in    , 	 
			ext_out   ,  
			ext_rdwr  , 	 
			fgi       ,  
			fgi_reset , 
			fgo       ,  
			fgo_reset ,  
			idle      , 	 
			inpr      , 		 
			m         , 	 
			outr      ,
            rst       ,
			s        
        );
	
	test : process
	begin
		-- Reset the system
		rst       <= '1';
		S         <= '0';
		
--		data_in   <= x"0000";
		DMA       <= '0';
		
		wave_gen(clk);
		
		-- Load test program to M0 using DMA
		rst       <= '0';
		S         <= '1';
		
		DMA       <= '1';
		Ext_RdWr  <= '1';
		M         <= '0';
		
		for i in test_data'range loop
			Ext_Adr <= std_logic_vector(to_unsigned(i * 2, 16));
			Ext_out <= test_data(i);
			exec_inst(Idle, clk);
		end loop;
		
		DMA       <= '0';
        FGI       <= '1';
        FGO       <= '1';
		
		-- =====================
		-- Test lod immediate (line 3)
		-- =====================
		-- Execute test program
		for j in 1 to 2 loop
			exec_inst(Idle, clk);
		end loop;

		-- Output BoR into outr (execute out instructions)
		assert outr = x"0008"
			report "output outr is wrong! (Test lod immediate)"
			severity error;


		-- =====================
		-- Test str short direct (line 7)
		-- =====================
		-- Execute test program
		for j in 1 to 4 loop
			exec_inst(Idle, clk);
		end loop;

		-- Output BoR into outr (execute out instructions)
		assert outr = x"0004"
			report "output outr is wrong! (Test str short direct)"
			severity error;


		-- =====================
		-- Test lod/str long direct indexed (line 13)
		-- =====================
		-- Execute test program
		for j in 1 to 6 loop
			exec_inst(Idle, clk);
		end loop;

		-- Output BoR into outr (execute out instructions)
		assert outr = x"1234"
			report "output outr is wrong! (Test lod/str long direct indexed)"
			severity error;


		-- =====================
		-- Test bun immediate (line 21)
		-- =====================
		-- Execute test program
		for j in 1 to 4 loop
			exec_inst(Idle, clk);
		end loop;

		-- Output BoR into outr (execute out instructions)
		assert outr = x"0002"
			report "output outr is wrong! (Test bun immediate)"
			severity error;


		-- =====================
		-- Test bun long direct indexed (line 29)
		-- =====================
		-- Execute test program
		for j in 1 to 6 loop
			exec_inst(Idle, clk);
		end loop;

		-- Output BoR into outr (execute out instructions)
		assert outr = x"0003"
			report "output outr is wrong! (Test bun long direct indexed)"
			severity error;



		
		wait;
	end process test;
end ARC_FUNCMI_tb;

configuration CFG_FUNCMI_tb of FUNCMI_tb is
	for ARC_FUNCMI_tb
	end for;
end CFG_FUNCMI_tb;