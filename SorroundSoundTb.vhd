library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.FilterTypes.all;

entity SorroundSoundTb is
end entity;

architecture default of SorroundSoundTb is
signal clk, reset : std_logic := '0';
constant period : time := 20.83 us;
signal inputFilters : fir_filter_array(1 downto 0);
signal outputFilter : fir_filter;
signal weights: signed32_array(1 downto 0);
begin
	FI : entity work.FilterInterpolator port map(clk=>clk, reset=>reset, inputFilters=>inputFilters,outputFilter=>outputFilter,weights=>weights);
	FI : entity work.FilterInterpolator port map(clk=>clk, reset=>reset, inputFilters=>inputFilters,outputFilter=>outputFilter,weights=>weights);
	process
	begin
		clk<=not clk;
		wait for period/2;
	end process;

	process
	begin
		reset<='0';
		for i in 0 to 255 loop
			inputFilters(0)(i)<=to_signed(i*10,32);
			inputFilters(1)(i)<=to_signed(1000,32);
		end loop;
		weights(0)<=to_signed(1073741824,32);
		weights(1)<=to_signed(1073741824,32);
		wait for period;
		assert outputFilter(0)= to_signed(500,32)
			report "Filters are not weighted proper"
			severity FAILURE;
		wait;    
	end process;

end architecture default;