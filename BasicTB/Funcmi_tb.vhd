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

@@TEST_ARRAY@@
	
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
			Ext_Adr <= std_logic_vector(to_unsigned(i * @@ADDR_MULT@@, 16));
			Ext_out <= test_data(i);
			exec_inst(Idle, clk);
		end loop;
		
		DMA       <= '0';
        FGI       <= '1';
        FGO       <= '1';
		
@@TESTS@@
		
		wait;
	end process test;
end ARC_FUNCMI_tb;

configuration CFG_FUNCMI_tb of FUNCMI_tb is
	for ARC_FUNCMI_tb
	end for;
end CFG_FUNCMI_tb;