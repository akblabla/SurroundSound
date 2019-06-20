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

  signal clkwBtn_tb 	: std_logic := '1';
  signal cntclkwBtn_tb	: std_logic := '1';
  signal SenseUp_tb	: std_logic := '0';
  signal SenseDown_tb	: std_logic := '0';
  signal clk_tb		: std_logic := '0';
  signal reset_tb	: std_logic := '0';
  signal direction_tb	: unsigned(7 downto 0) := (others => '0');

  signal Clock 		: std_logic := '1';

begin

  DUT: ButtonController
    port map(
      clkwBtn		=> clkwBtn_tb,
      cntclkwBtn	=> cntclkwBtn_tb,
      SenseUp		=> SenseUp_tb,
      SenseDown 	=> SenseDown_tb,
      clk 		=> clk_tb,
      reset 		=> reset_tb,
      direction 	=> direction_tb);

  Clock <= not Clock after 10 ns;
  clk_tb <= Clock;
  reset_tb <= '0', '1' after 10 ns;

  ButtonGen: process 
  begin
    wait for 200 us;
    for i in 0 to 3 loop
      SenseUp_tb <= '1';
	  wait for 200 us;
      SenseUp_tb <= '0';
	  wait for 200 us;
    end loop;
    clkwBtn_tb <= '0';
    wait for 100 us;
    assert direction_tb = to_unsigned(1,8)
      report "Wrong direction - 1"
      severity warning;
    wait for 100 us;
    assert direction_tb = "00000010"
      report "Wrong direction - 2"
      severity warning;
    wait for 100 us;
    assert direction_tb = "00000011"
      report "Wrong direction - 3"
      severity warning;
    wait for 100 us;
    assert direction_tb = "00000100"
      report "Wrong direction - 4"
      severity warning;
    wait for 50 us;
    assert direction_tb = "00000101"
      report "Wrong direction - 5"
      severity warning;

    --wait for 100 ns;
    --clkwBtn <= '0';
    wait;
  end process ButtonGen;
end tb;
    








