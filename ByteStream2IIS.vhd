library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.FilterTypes.all;

entity ByteStream2IIS is
  port(clk        : in  std_logic;
       reset      : in  std_logic;
<<<<<<< HEAD
		 byteStream : in  signed32;
		 IISdata    : out signed32);
=======
       byteStream : in  signed32;
		 
       bitclk     : in  std_logic;
       adcdat     : in  std_logic;
       dacdat     : out std_logic := '0';
       adclrck    : in  std_logic;
       daclrck    : in  std_logic);
>>>>>>> 401fd8de7ed597c0175739b1719dbdd385e83676
end entity;

architecture stream of ByteStream2IIS is

begin
  process
  begin
    if reset = '0' then
	   --Set IISdata 0
<<<<<<< HEAD
	 elsif rising_edge(clk) then
=======
	elsif rising_edge(clk) then
>>>>>>> 401fd8de7ed597c0175739b1719dbdd385e83676
	   --Put data from IISdata to byteStream
	 end if;
  end process;
end stream;