library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.FilterTypes.all;

entity FilterManager is
  port(clk       : in  std_logic;
       reset     : in  std_logic;
		 direction : in  unsigned(7 downto 0);
		 weight    : out signed32;
		 filters   : out fir_filter_array(1 downto 0);
		 delays    : out signed8_array(1 downto 0));
end entity;

architecture filtering of FilterManager is
  variable flt    : integer;
  signal mem_filt : fir_filter_array(23 downto 0);

begin
  process(clk, reset)
  begin
    if reset = '0' then
	   weight <= to_signed(0,32);
		for i in 0 to 255 loop
		  filters(0)(i) <= to_signed(0,32);
		  filters(1)(i) <= to_signed(0,32);
		end loop;
		delays(0) <= to_signed(0,8);
		delays(1) <= to_signed(0,8);
	 elsif rising_edge(clk) then
	   flt := to_integer((direction * 3)/32);
		if flt = 23 then
		  filters(0) <= mem_filt(flt);
		  filters(1) <= mem_filt(0);
		else
		  filters(0) <= mem_filt(flt);
		  filters(1) <= mem_filt(flt+1);
		end if;
	 end if;
  end process;
end filtering;
