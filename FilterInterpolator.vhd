library IEEE;
use IEEE.std_logic_1164.all;
library IEEE;
use IEEE.numeric_std.all;
library work;
use work.FilterTypes.all;

entity FilterInterpolator is
	port(clk 		: in std_logic;
	     reset 		: in std_logic;
	     inputFilters 	: in fir_filter_array(1 downto 0);
	     delays 		: in unsigned8_array(1 downto 0);
	     outputFilter 	: out fir_filter;
	     weights		: in unsigned32);
end entity;

architecture default of FilterInterpolator is
begin
  interpolate: process(clk)
  variable outputFilterTemp : signed32;
  begin
    for i in 0 to 255 loop
      outputFilterTemp := to_signed(0,32);
      if (i >= delays(0)) then
        outputFilterTemp:=resize(
                      shift_right(
				inputFilters(0)(to_integer(to_unsigned(i,8)-delays(0)))*(x"FFFFFFFF"-to_signed(to_integer(weights),33))
                      ,32)
        ,32);
      end if;
      if (i >= delays(1)) then
	outputFilterTemp:=resize(
		      shift_right(
				 outputFilterTemp+inputFilters(1)(to_integer(to_unsigned(i,8)-delays(1)))*to_signed(to_integer(weights),33)
                      ,32)
	,32);			
      end if;
      outputFilter(i)<=outputFilterTemp;
    end loop;
  end process interpolate;


end architecture default;