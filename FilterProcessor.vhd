library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.FilterTypes.all;

entity FilterProcessor is
	port(clk : in std_logic;
		reset : in std_logic;
		inputFilter : in fir_filter_array;
		input : in signed32;
		output : out signed32);
end entity;

architecture default of FilterProcessor is
signal delayLine : signed32_array(255 downto 0);
begin
	processData: process(clk)
	variable outputTemp : signed32;
	begin
		delayLine(i) <= input;
		processData := to_signed(0,32);
		processData:= resize(
					shift_right(
						inputFilter(0)*input
					,31)
				,32);
		for i in 0 to 254 loop
			delayLine(i+1) <= delayLine(i);
			processData:=processData
				+resize(
					shift_right(
						inputFilter(i+1)*delayLine(i)
					,31)
				,32);
		end loop;
	end process processData;


end architecture default;