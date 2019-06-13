library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.FilterTypes.all;

entity IIS2ByteStream_tb is
end entity;

architecture tb of IIS2ByteStream_tb is
  component IIS2ByteStream
    port(
      reset      	: in  std_logic;
      byteStreamLeft 	: out  signed32;
      byteStreamRight 	: out  signed32;
      bitclk     	: in  std_logic;
      adcdat     	: in  std_logic;
      dacdat     	: out std_logic;
      adclrck    	: in  std_logic;
      daclrck    	: in  std_logic);
end component;

  signal reset_tb      		: std_logic := '0';
  signal byteStreamLeft_tb 	: signed32 := to_signed(0,32);
  signal byteStreamRight_tb 	: signed32 := to_signed(0,32);
  signal bitclk_tb     		: std_logic := '0';
  signal adcdat_tb     		: std_logic := '0';
  signal dacdat_tb     		: std_logic := '0';
  signal adclrck_tb    		: std_logic := '0';
  signal daclrck_tb    		: std_logic := '0';

  signal clock 		: std_logic := '1';

begin
  DUT: IIS2ByteStream
    port map(
      reset 		=> reset_tb,
      byteStreamLeft 	=> byteStreamLeft_tb,
      byteStreamRight 	=> byteStreamRight_tb,
      bitclk 		=> bitclk_tb,
      adcdat 		=> adcdat_tb,
      dacdat 		=> dacdat_tb,
      adclrck 		=> adclrck_tb,
      daclrck 		=> daclrck_tb);

  clock <= not clock after 10 ns;
  bitclk_tb <= clock;
  reset_tb <= '0', '1' after 5 ns;

  proc: process
  begin
    



  end process proc;
end tb;








