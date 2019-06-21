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
      adclrck    	: in  std_logic);
end component;

  signal reset_tb      		: std_logic := '0';
  signal byteStreamLeft_tb 	: signed32 := to_signed(0,32);
  signal byteStreamRight_tb 	: signed32 := to_signed(0,32);
  signal bitclk_tb     		: std_logic := '0';
  signal adcdat_tb     		: std_logic := '0';
  signal adclrck_tb    		: std_logic := '0';

  signal clock 		: std_logic := '1';

begin
  DUT: IIS2ByteStream
    port map(
      reset 		=> reset_tb,
      byteStreamLeft 	=> byteStreamLeft_tb,
      byteStreamRight 	=> byteStreamRight_tb,
      bitclk 		=> bitclk_tb,
      adcdat 		=> adcdat_tb,
      adclrck 		=> adclrck_tb);

  clock <= not clock after 10 ns;
  bitclk_tb <= clock;
--  adclrck_tb <= clock;
  reset_tb <= '0', '1' after 5 ns;

  proc: process
  begin
    adcdat_tb <= '1';
    wait for 25 ns;
    adcdat_tb <= '0';
    wait for 20 ns;
    adcdat_tb <= '1';
    wait for 40 ns;
    adcdat_tb <= '0';
    adclrck_tb <= not adclrck_tb;
    wait for 25 ns;
    adcdat_tb <= '0';
    wait for 25 ns;
    adcdat_tb <= '1';
    wait for 20 ns;
    adcdat_tb <= '0';
    wait for 40 ns;
    adcdat_tb <= '1';
    adclrck_tb <= not adclrck_tb;    wait for 20 ns;
    assert byteStreamRight_tb = to_signed(13,32)
      report "Right stream wrong"
      severity warning;
    assert byteStreamLeft_tb = to_signed(2,32)
      report "Left stream wrong stream wrong"
      severity warning;
    wait;
  end process proc;
end tb;








