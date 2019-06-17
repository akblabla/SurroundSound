library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.FilterTypes.all;

entity FilterProcessor_tb is
end entity;

architecture tb of FilterProcessor_tb is
  component FilterProcessor
    port(
      clk 		: in std_logic;
      reset 		: in std_logic;
      inputFilter 	: in fir_filter;
      input 		: in signed32;
      output 		: out signed32);
  end component;

  signal clk_tb		: std_logic := '0';
  signal reset_tb	: std_logic := '0';
  signal inputFilter_tb	: fir_filter;
  signal input_tb	: signed32 := (others => '0');
  signal output_tb	: signed32;

  signal Clock 		: std_logic := '1';

begin
  
  DUT: FilterProcessor
    port map(
      clk => clk_tb,
      reset => reset_tb,
      inputFilter => inputFilter_tb,
      input => input_tb,
      output => output_tb);

  Clock <= not Clock after 10 ns;
  clk_tb <= Clock;
  reset_tb <= '0', '1' after 5 ns;

  procced: process
  begin
    for i in 0 to 255 loop
      inputFilter_tb(i) <= to_signed(i+1,32);
    end loop;
    input_tb <= to_signed(1,32);
    wait for 25 ns;
    input_tb <= to_signed(2,32);
    wait for 25 ns;
    input_tb <= to_signed(3,32);
    wait for 25 ns;
    input_tb <= to_signed(5,32);
    wait for 25 ns;
    input_tb <= to_signed(8,32);
    wait for 25 ns;
    input_tb <= to_signed(10,32);
    wait for 25 ns;
    input_tb <= to_signed(0,32);
  wait;
  end process;
end tb;











