library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity IIS2ByteStream is
  port(clk        : in  std_logic;
       reset      : in  std_logic;
		 IISdata    : in  ;
		 byteStream : out signed32);
end entity;

architecture stream of IIS2ByteStream is

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