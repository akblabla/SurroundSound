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

  signal clk_tb		: std_logic;
  signal reset_tb	: std_logic;
  signal inputFilter_tb	: fir_filter;
  signal input_tb	: signed32;
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


end tb;











