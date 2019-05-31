library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.FilterTypes.all;

entity ByteStream2IIS is
  port(reset      : in  std_logic;
       bitclk     : in  std_logic;
       adcdat     : in  std_logic;
       dacdat     : out std_logic := '0';
       adclrck    : in  std_logic;
       daclrck    : in  std_logic);
end entity;

architecture stream of ByteStream2IIS is

begin
  process
  begin
    if reset = '0' then
	   --Set IISdata 0
	elsif rising_edge(bitclk) then

	   --Put data from IISdata to byteStream
	 end if;
  end process;
end stream;