library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.FilterTypes.all;

entity FilterProcessor is
	port(clk 		: in std_logic;
	     reset 		: in std_logic;
	     inputFilter 	: in fir_filter;
	     input 		: in signed32;
	     output 		: out signed32 := to_signed(0,32));
end entity;

architecture default of FilterProcessor is
begin
--	processData: process(clk)
--	variable outputTemp : signed32;
--	begin
--		delayLine(0) <= input;
--		processData := to_signed(0,32);
--		processData:= resize(
--								shift_right(
--										inputFilter(0)*input
--								,31)
--							,32);
--		for i in 0 to 254 loop
--			delayLine(i+1) <= delayLine(i);
--			processData:=processData
--				+resize(
--					shift_right(
--						inputFilter(i+1)*delayLine(i)
--					,31)
--				,32);
--		end loop;
--	end process processData;
	processData: process(clk)
	variable outputTemp : signed64 := to_signed(0,64);
	variable delayLine : signed32_array(255 downto 0) := (others => to_signed(0,32));
	begin
		if reset = '0' then
			outputTemp := to_signed(0,64);
			delayLine := (others => to_signed(0,32));
			output <= to_signed(0,32);
		elsif rising_edge(clk) then
	  		outputTemp := to_signed(0,64);
			for i in 0 to 254 loop
			delayLine(255-i) := delayLine(254-i);
			end loop;
			delayLine(0) := input;
			for i in 0 to 255 loop
				outputTemp:=outputTemp+inputFilter(i)*delayLine(i);
			end loop;
			output<=outputTemp(31 downto 0);
		end if;
	end process processData;
end architecture default;