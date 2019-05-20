library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.FilterTypes.all;

entity FilterInterpolator is
	port(clk : in std_logic;
		reset : in std_logic;
		inputFilters : in fir_filter_array(1 downto 0);
		delays : in signed8_array(1 downto 0);
		outputFilter : out fir_filter;
		weights: in signed32);
end entity;

architecture default of FilterInterpolator is
begin
	interpolate: process(clk)
	begin
		for i in 0 to 255 loop
			outputFilter(i)<= resize(
				shift_right(
					inputFilters(0)(i)*weights+inputFilters(1)(i)*(to_signed(2147483647,32)-weights)
				,31)
			,32);
		end loop;
	end process interpolate;


end architecture default;