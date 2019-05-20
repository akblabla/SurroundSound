library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity FilterManager is
  port(clk       : in  std_logic;
       reset     : in  std_logic;
		 direction : in  unsigned(8 downto 0);
		 weight    : out signed32;
		 filters   : out fir_filter_array(1 downto 0);
		 delays    : out signed8_array(1 downto 0);
end entity;