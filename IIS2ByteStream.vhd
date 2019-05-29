library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.FilterTypes.all;

entity IIS2ByteStream is
  port(reset      : in  std_logic;
		 bitclk           : in  std_logic;
		 adcdat           : in  std_logic;
		 dacdat           : out std_logic                     := '0';
		 adclrck          : in  std_logic;
		 daclrck          : in  std_logic;
		 byteStream : out signed32);
end entity;

architecture stream of IIS2ByteStream is

begin
	process
	variable bitcount            : integer range 0 to 23         := 0;
	variable st_source_data_temp : std_logic_vector(23 downto 0) := (others => '0');
	begin
		if reset = '0' then
			--Set IISdata 0
			byteStream <= to_signed(0,32);
		elsif rising_edge(bitclk) then
--			if adclrck = '0'
--				
--				bitcount := bitcount+1;
--			end if;
--
--		end if;
--			wait until adclrck = '0';
--			wait for bitperiod;
--			wait until bitclk = '1';
--			for bitcount in 23 downto 0 loop    --shift register
--			  st_source_data_temp(bitcount) := adcdat;
--			  wait for bitperiod;
--			end loop;
--			wait until adclrck = '1';
--			ast_source_valid <= '0';
--			ast_source_data  <= st_source_data_temp;
--			ast_source_valid <= '1';
		end if;
	end process;
end stream;