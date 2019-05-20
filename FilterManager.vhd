library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.FilterTypes.all;

entity FilterManager is
  port(clk       : in  std_logic;
       reset     : in  std_logic;
		 direction : in  unsigned(8 downto 0);
		 weight    : out signed32;
		 filters   : out fir_filter_array(1 downto 0);
		 delays    : out signed8_array(1 downto 0));
<<<<<<< HEAD
end entity;

architecture filtering of FilterManager is


begin
  
=======
end entity;
>>>>>>> de14092316be09b55fa2a8c97bcb61d6f7636f13
