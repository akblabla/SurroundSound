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
       adclrck    	: in  std_logic);
end entity;

architecture stream of IIS2ByteStream is
signal byteStreamLeftFIFO : signed32_array(0 downto 3)
signal byteStreamRightFIFO : signed32_array(0 downto 3)
signal FIFOCounterGrey : std_logic_vector(0 downto 1)
begin
  function integer_to_grey_code (
    int : in integer)
    return std_logic_vector is
    variable GCTemp : std_logic_vector(1 downto 0);
  begin
    case int is
		when 0 => GCTemp := '00';
		when 1 => GCTemp := '01';
		when 2 => GCTemp := '11';
		when 3 => GCTemp := '10';
		when others => GCTemp := '00'

    return GCTemp;
  end;
  function grey_code_to_integer (
    GCTemp : in std_logic_vector(1 downto 0))
    return integer is
    variable int : integer;
  begin
    case GCTemp is
		when '00' => int := 0;
		when '01' => int := 1;
		when '11' => int := 2;
		when '10' => int := 3;
		when others => int := 0

    return int;
  end;

  process (clk)
  variable FIFOCounter_temp : integer := 0
  begin
    if rising_edge(clk) then
	  FIFOCounter_temp = grey_code_to_integer(FIFOCounterGrey);
	  FIFOCounter_temp := (FIFOCounter_temp-2) rem 4;
      byteStreamLeft <= byteStreamLeftFIFO(FIFOCounter_temp);
	  byteStreamRight <= byteStreamRightFIFO(FIFOCounter_temp);
    end if;
  end process;


  process(bitclk, reset)
  constant IISbitResolution : integer 						:= 24;
  variable adclrckPrev      : std_logic 					:= '0';
  variable bitcount         : integer range 0 to IISbitResolution         	:= 0;
  variable sourceDataLeft_temp : std_logic_vector(IISbitResolution-1 downto 0) 	:= (others => '0');
  variable sourceDataRight_temp : std_logic_vector(IISbitResolution-1 downto 0) 	:= (others => '0');
  variable FIFOCounter_temp : integer := 0;
  begin
    if reset = '0' then
      byteStreamLeft <= to_signed(0,32);
      byteStreamRight <= to_signed(0,32);
    elsif rising_edge(bitclk) then
      if adclrckPrev = not adclrck then
	    bitcount := 0;
	    if adclrck = '1' then		  
	      byteStreamLeftFIFO(FIFOCounter_temp) <= resize(signed(sourceDataLeft_temp),32);
	      byteStreamRightFIFO(FIFOCounter_temp) <= resize(signed(sourceDataRight_temp),32);				
	    end if;
		FIFOCounter_temp := (FIFOCounter_temp+1) rem 4;
		FIFOCounterGrey <= integer_to_grey_code(FIFOCounter_temp);
      elsif bitcount<IISbitResolution then
		if adclrck = '0'
			sourceDataLeft_temp(bitcount) := adcdat;
		else
			sourceDataRight_temp(bitcount) := adcdat;
		end if;
	    bitcount := bitcount+1;
      end if;
      adclrckPrev := adclrck;			
    end if;	
  end process;
end stream;
