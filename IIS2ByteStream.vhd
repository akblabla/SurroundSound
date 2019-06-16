library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.FilterTypes.all;


entity IIS2ByteStream is
  port(reset      	: in  std_logic;
       byteStreamLeft 	: out signed32;
       byteStreamRight 	: out signed32;
       bitclk     	: in  std_logic;
       adcdat     	: in  std_logic;
       dacdat     	: out std_logic := '0';
       adclrck    	: in  std_logic;
       daclrck    	: in  std_logic);
end entity;

architecture stream of IIS2ByteStream is

begin

  process(bitclk, reset)
  constant IISbitResolution : integer 						:= 24;
  variable adclrckPrev      : std_logic 					:= '0';
  variable bitcount         : integer range 0 to IISbitResolution         	:= 0;
  variable source_data_temp : std_logic_vector(IISbitResolution-1 downto 0) 	:= (others => '0');

  begin
    if reset = '0' then
      byteStreamLeft <= to_signed(0,32);
      byteStreamRight <= to_signed(0,32);
    elsif rising_edge(bitclk) then
      if adclrckPrev = not adclrck then
	bitcount := 0;
	if adclrck = '0' then
	  byteStreamLeft <= resize(signed(source_data_temp),32);
	else
	  byteStreamRight <= resize(signed(source_data_temp),32);				
	end if;
      elsif bitcount<IISbitResolution then
        source_data_temp(bitcount) := adcdat;
	bitcount := bitcount+1;
      end if;
      adclrckPrev := adclrck;			
    end if;	
  end process;
end stream;