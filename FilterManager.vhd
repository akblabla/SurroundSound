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
		 direction : in  unsigned(7 downto 0);
		 weight    : out unsigned32;
		 filters   : out fir_filter_array(1 downto 0);
		 delays    : out unsigned8_array(1 downto 0);
		 mem_filt  : in  fir_filter_array(23 downto 0));
end entity;

architecture filtering of FilterManager is
  variable flt       : integer;
  variable wght		: unsigned32;
  variable dir32		: unsigned32;
  variable dir_flt	: unsigned32;
  variable flt_ang	: unsigned32 := to_unsigned(178956971,32);
  signal filt_delays : unsigned8_array(23 downto 0);
  file fileID			: text;
  variable lineRead  : line;
  variable readings  : std_logic_vector(31 downto 0);
  variable readChar  : character;
  variable counter   : integer := 0;

begin
  
  process(clk, reset)
  begin
    file_open(fileID,"data_file.txt",read_mode);
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
		wght := to_unsigned((4294967295*flt)/24,32); --The number is 32 bits
		dir_flt := dir32 - wght;
		weight <= (1-(dir_flt/flt_ang));
		if flt = 23 then
		  for i in 0 to 255 loop
		    readline(fileID, lineRead);
		    read(lineRead,readings);
			 filters(1)(i) <= signed(readings);
		  end loop;
		  counter := 0;
		  while counter < flt * 256 loop
		    readline(fileID, lineRead);
			 read(lineRead,readings);
		    counter := counter + 1;
		  end loop;
		  for i in 0 to 255 loop
		    readline(fileID, lineRead);
			 read(lineRead,readings);
			 filters(0)(i) <= signed(readings);
		  end loop;
		  delays(0) <= filt_delays(flt);
		  delays(1) <= filt_delays(0);
		else
		  counter := 0;
		  while counter < flt * 256 loop
		    readline(fileID, lineRead);
			 read(lineRead,readings);
		    counter := counter + 1;
		  end loop;
		  for i in 0 to 255 loop
		    readline(fileID, lineRead);
			 read(lineRead,readings);
			 filters(0)(i) <= signed(readings);
		  end loop;
		  for i in 0 to 255 loop
		    readline(fileID, lineRead);
			 read(lineRead,readings);
			 filters(1)(i) <= signed(readings);
		  end loop;
		  delays(0) <= filt_delays(flt);
		  delays(1) <= filt_delays(flt+1);
		end if;
	 end if;
	 file_close(fileID);
  end process;
end filtering;
