library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.FilterTypes.all;

entity FilterProcessor is
	port(clk : in std_logic;
		reset : in std_logic;
		inputFilter : in fir_filter;
		input : in signed32;
		output : out signed32);
end entity;

architecture default of FilterProcessor is
begin
	processData: process(clk)
	variable outputTemp : signed32;
	variable delayLine : signed32_array(255 downto 0);
	begin
		outputTemp := to_signed(0,32);
		for i in 0 to 254 loop
			delayLine(255-i) := delayLine(254-i);
		end loop;
		delayLine(0) := input;
		for i in 0 to 255 loop
			outputTemp:=outputTemp+inputFilter(i)*delayLine(i);
		end loop;
		output<=outputTemp;
	end process processData;


end architecture default;