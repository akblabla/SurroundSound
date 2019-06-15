library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.FilterTypes.all;

entity FilterInterpolator is
	port(clk 		: in std_logic;
		reset 		: in std_logic;
		inputFilters 	: in fir_filter_array(1 downto 0);
		delays 		: in unsigned8_array(1 downto 0);
		outputFilter 	: out fir_filter;
		weights		: in signed32);
end entity;

architecture default of FilterInterpolator is
begin
  interpolate: process(clk)
  variable output : signed32;
  begin
    for i in 0 to 255 loop
      output := to_signed(0,32);
      if (i >= delays(0)) then
        output:=resize(
                      shift_right(
				inputFilters(0)(to_integer(to_unsigned(i,8)-delays(0)))*weights
                      ,31)
        ,32);
      end if;
      if (i >= delays(1)) then
	output:=resize(
		      shift_right(
				 output+inputFilters(1)(to_integer(to_unsigned(i,8)-delays(1)))*(to_signed(-2147483648,32)-weights)
		      ,31)
	,32);			
      end if;
      outputFilter(i)<=output;
    end loop;
  end process interpolate;


end architecture default;