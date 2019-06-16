library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.FilterTypes.all;

entity ByteStream2IIS is


  port(clk        	: in  std_logic;
       reset      	: in  std_logic;
       byteStreamLeft 	: in  signed32;
       byteStreamRight 	: in  signed32;
       bitclk     	: in  std_logic;
       dacdat     	: out std_logic := '0';
       daclrck    	: in  std_logic);
end entity;

architecture stream of ByteStream2IIS is
constant IISbitResolution : integer := 24;
signal start            : std_logic := '0';
signal dest_data_temp : std_logic_vector(IISbitResolution-1 downto 0) := (others => '0');
	
begin
<<<<<<< HEAD
  process
  constant IISbitResolution : integer := 24;
	variable daclrckPrev            : std_logic := '0';
	variable bitcount            : integer range 0 to IISbitResolution         := 0;
	variable dest_data_temp : std_logic_vector(IISbitResolution-1 downto 0) := (others => '0');
  begin
    if reset = '0' then
      --Set IISdata 0
    elsif rising_edge(bitclk) then
      --Put data from IISdata to byteStream
    elsif rising_edge(clk) then
      if reset = '0' then
	--Set IISdata 0
	dacdat <= '0';
      elsif rising_edge(bitclk) then
	if daclrckPrev = not daclrck then
	  bitcount := 0;
	  if daclrck = '0' then
	    dest_data_temp := std_logic_vector(byteStreamLeft)(IISbitResolution-1 downto 0);
	  else
	    dest_data_temp := std_logic_vector(byteStreamRight)(IISbitResolution-1 downto 0);				
	  end if;
	end if;
     if bitcount<IISbitResolution then
				if daclrck = '0' then
					dacdat <= dest_data_temp(bitcount);
=======
	process (daclrck)
	begin
		if rising_edge(daclrck) or falling_edge(daclrck) then
			if daclrck = '0' then
				dest_data_temp <= std_logic_vector(byteStreamLeft)(IISbitResolution-1 downto 0);
			else
				dest_data_temp <= std_logic_vector(byteStreamRight)(IISbitResolution-1 downto 0);				
			end if;
			start <= '1';
		end if;
	end process;


	process (bitclk)
	variable bitcount            : integer range 0 to IISbitResolution         := 0;
	begin
		if reset = '0' then
			--Set IISdata 0
			dacdat <= '0';
		else
			if rising_edge(bitclk) then
				if start = '1' then
					start <= '0';
>>>>>>> 4459f499fe7a182bbb34fa684447688110afefcf
				else
					if bitcount<IISbitResolution then
						if daclrck = '0' then
							dacdat <= dest_data_temp(bitcount);
						else
							dacdat <= dest_data_temp(bitcount);
						end if;
						bitcount := bitcount+1;
					end if;
				end if;
			end if;
<<<<<<< HEAD
			daclrckPrev := daclrck;
end if;
    end if;
  end process;
=======
		end if;
	end process;
>>>>>>> 4459f499fe7a182bbb34fa684447688110afefcf
end stream;