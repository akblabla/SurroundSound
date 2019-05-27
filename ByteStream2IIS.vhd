library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ByteStream2IIS is
  port(clk        : in  std_logic;
       reset      : in  std_logic;
		 byteStream : in  signed32;
		 IISdata    : out );
end entity;

architecture stream of ByteStream2IIS is

begin
  process
  begin
    if reset = '0' then
	   --Set IISdata 0
		byteStream <= '0';
	 elsif rising_edge(clk) then
	   --Put data from IISdata to byteStream
	 end if;
  end process;
end stream;