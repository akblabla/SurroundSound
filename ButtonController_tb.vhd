library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;

entity ButtonController_tb is

end ButtonController_tb;

architecture tb of ButtonController_tb is

  component ButtonController
    port(
      clkwBtn 		: in  std_logic;
      cntclkwBtn	: in  std_logic;
      SenseUp		: in  std_logic;
      SenseDown		: in  std_logic;
      clk		: in  std_logic;
      reset		: in  std_logic;
      direction		: out unsigned(7 downto 0));
  end component;

  signal clkwBtn 	: std_logic := '0';
  signal cntclkwBtn	: std_logic := '0';
  signal SenseUp	: std_logic := '0';
  signal SenseDown	: std_logic := '0';
  signal clk		: std_logic := '0';
  signal reset		: std_logic := '0';
  signal direction	: unsigned(7 downto 0) := (others => '0');

  signal Clock 		: std_logic := '1';

begin

  DUT: ButtonController
    port map(
      clkwBtn		=> clkwBtn,
      cntclkwBtn	=> cntclkwBtn,
      SenseUp		=> SenseUp,
      SenseDown 	=> SenseDown,
      clk 		=> clk,
      reset 		=> reset,
      direction 	=> direction);

  Clock <= not Clock after 10 ns;
  clk <= Clock;
  reset <= '0', '1' after 10 ns;

  ButtonGen: process 
  begin
    clkwBtn <= '1';

    wait for 100 ns;
    --clkwBtn <= '0';
    wait;
  end process ButtonGen;
end tb;
    








