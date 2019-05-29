library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.FilterTypes.all;

entity FilterManager is
  port(clk       : in  std_logic;
       reset     : in  std_logic;
		 direction : in  unsigned(7 downto 0);
		 weight    : out unsigned32;
		 filters   : out fir_filter_array(1 downto 0);
		 delays    : out unsigned8_array(1 downto 0));
end entity;

architecture filtering of FilterManager is
  variable flt       : integer;
  variable wght		: unsigned32;
  variable dir32		: unsigned32;
  variable dir_flt	: unsigned32;
  variable flt_ang	: unsigned32 := to_unsigned(178956971,32);
  signal mem_filt    : fir_filter_array(23 downto 0);
  signal filt_delays : unsigned8_array(23 downto 0);

begin
  
  process(clk, reset)
  begin
    if reset = '0' then
	   weight <= to_unsigned(0,32);
		for i in 0 to 255 loop
		  filters(0)(i) <= to_signed(0,32);
		  filters(1)(i) <= to_signed(0,32);
		end loop;
		delays(0) <= to_unsigned(0,8);
		delays(1) <= to_unsigned(0,8);
	 elsif rising_edge(clk) then
	   flt := to_integer((direction * 3)/32);
		dir32 := direction;
		dir32 := shift_left(dir32,24);
		wght := to_unsigned((4294967296*flt)/24,32); --The number is 32 bits
		dir_flt := dir32 - wght;
		weight <= (1-(dir_flt/flt_ang));
		if flt = 23 then
		  filters(0) <= mem_filt(flt);
		  filters(1) <= mem_filt(0);
		  delays(0) <= filt_delays(flt);
		  delays(1) <= filt_delays(0);
		else
		  filters(0) <= mem_filt(flt);
		  filters(1) <= mem_filt(flt+1);
		  delays(0) <= filt_delays(flt);
		  delays(1) <= filt_delays(flt+1);
		end if;
	 end if;
  end process;
end filtering;
