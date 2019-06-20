library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.FilterTypes.all;

entity SurroundSound is
	port(
		AUD_ADCDAT     : in   std_logic;
		AUD_ADCLRCK    : inout   std_logic;
		AUD_BCLK       : inout   std_logic;
		AUD_DACDAT     : out  std_logic;
		AUD_DACLRCK    : inout   std_logic;
		
		CLK_50 			: in std_logic;
		
		KEY             :in   std_logic_vector(3 downto 0);
		LEDR            :out std_logic_vector(9 downto 0); 
		SW              :in   std_logic_vector(9 downto 0)
	);
end entity SurroundSound;

architecture default of SurroundSound is
signal reset : std_logic := '0';
signal direction : unsigned(7 downto 0);
signal mem_filters : fir_filter_array(23 downto 0);
begin
	BC : entity work.ButtonController port map(
		clkwBtn=>KEY(0),
		cntclkwBtn=>KEY(1),
		SenseUp=>KEY(2),
		SenseDown=>KEY(3),
		clk=>Clk_50,
		reset=>reset,
		direction=>direction);
	FMem : entity work.FilterMemory port map(
		mem_filters => mem_filters);
end default;