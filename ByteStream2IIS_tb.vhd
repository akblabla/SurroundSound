library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.FilterTypes.all;


entity ByteStream2IIS_tb is
end entity;

architecture tb of ByteStream2IIS_tb is
  component ByteStream2IIS
    port(
       clk        	: in  std_logic;
       reset      	: in  std_logic;
       byteStreamLeft 	: in  signed32;
       byteStreamRight 	: in  signed32;
       bitclk     	: in  std_logic;
       dacdat     	: out std_logic := '0';
       daclrck    	: in  std_logic);
end component;

  signal clk_tb			: std_logic := '0';
  signal reset_tb      		: std_logic := '0';
  signal byteStreamLeft_tb 	: signed32 := to_signed(0,32);
  signal byteStreamRight_tb 	: signed32 := to_signed(0,32);
  signal bitclk_tb     		: std_logic := '0';
  signal dacdat_tb     		: std_logic := '0';
  signal daclrck_tb    		: std_logic := '0';

  signal clock 			: std_logic := '1';
  signal dacclk			: std_logic := '1';

begin
  DUT: ByteStream2IIS
    port map(
      clk		=> clk_tb,
      reset 		=> reset_tb,
      byteStreamLeft 	=> byteStreamLeft_tb,
      byteStreamRight 	=> byteStreamRight_tb,
      bitclk 		=> bitclk_tb,
      dacdat 		=> dacdat_tb,
      daclrck 		=> daclrck_tb);

  clock <= not clock after 10 ns;
  dacclk <= not dacclk after 500 ns;
  clk_tb <= clock;
  bitclk_tb <= clock;
  daclrck_tb <= dacclk;
  reset_tb <= '0', '1' after 5 ns;

  proc: process
  begin
    byteStreamLeft_tb <= to_signed(324,32);
    byteStreamRight_tb <= to_signed(2345,32);
    wait for 750 ns;
    byteStreamLeft_tb <= to_signed(42232,32);
    byteStreamRight_tb <= to_signed(60000,32);
    

    wait;
  end process proc;
end tb;


