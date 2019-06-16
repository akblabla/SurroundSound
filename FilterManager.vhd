library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.FilterTypes.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity FilterManager is
  port(clk       : in  std_logic;
       reset     : in  std_logic;
       direction : in  unsigned8;
       weight    : out unsigned32;
       filters   : out fir_filter_array(1 downto 0);
       delays    : out unsigned8_array(1 downto 0);
       mem_filt	 : in  fir_filter_array(23 downto 0));
end entity;

architecture filtering of FilterManager is
  signal filt_delays 	: unsigned8_array(23 downto 0) := (others => to_unsigned(0,8));

begin
  
  process(clk, reset)
    variable flt        : integer := 0;
    variable wght 	: unsigned32 := (others => '0');
    variable dir32	: unsigned32 := (others => '0');
    variable dir_flt	: unsigned32 := (others => '0');
    variable flt_ang	: unsigned32 := to_unsigned(178956970,32);
    

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
		dir32(7 downto 0) := direction;
		dir32 := shift_left(dir32,24);
		wght := to_unsigned((2147483647/24)*flt,32);
                wght := resize(wght * 2,32);
		dir_flt := dir32 - wght;
                weight <= (1-(dir_flt/flt_ang));
		if flt = 23 then
		  filters(0) <= mem_filt(23);
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
