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
signal delays : unsigned8_array(1 downto 0);
signal outputFilter : fir_filter;
signal weights: signed32;
begin
	FI : entity work.FilterInterpolator port map(
		clk=>clk,
		reset=>reset,
		inputFilters=>inputFilters,
		delays=>delays,
		outputFilter=>outputFilter,
		weights=>weights);
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
			inputFilters(1)(i)<=to_signed(1000-i*i,32);
		end loop;
		weights<=to_signed(1073741824,32);
		delays(0) <= to_unsigned(0,8);
		delays(1) <= to_unsigned(0,8);

		wait for period;
		assert outputFilter(0)= to_signed(500,32)
			report "Filters are not weighted proper"
			severity FAILURE;
		wait for period;
		delays(0) <= to_unsigned(50,8);
		delays(1) <= to_unsigned(120,8);
		wait for period;
		assert outputFilter(50)= to_signed(0,32)
			report "Filters are not weighted proper"
			severity FAILURE;
		assert outputFilter(0)= to_signed(500,32)
			report "Filters are not weighted proper"
			severity FAILURE;
		wait;    
	end process;

end architecture default;