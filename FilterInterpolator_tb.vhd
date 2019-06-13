library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.FilterTypes.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity FilterInterpolator_tb is
end FilterInterpolator_tb;

architecture tb of FilterInterpolator_tb is

  component FilterInterpolator
    port(
         clk 		: in std_logic;
	 reset 		: in std_logic;
	 inputFilters 	: in fir_filter_array(1 downto 0);
	 delays 	: in unsigned8_array(1 downto 0);
	 outputFilter 	: out fir_filter;
	 weights	: in signed32);
  end component;

  signal clk 		: std_logic := '0';
  signal reset 		: std_logic := '0';
  signal inputFilters 	: fir_filter_array(1 downto 0);
  signal delays 	: unsigned8_array(1 downto 0);
  signal outputFilter 	: fir_filter;
  signal weights	: signed32 := (others => '0');

  signal clock 		: std_logic := '1';

  

begin
  


  DUT: FilterInterpolator
    port map(
      clk 		=> clk,
      reset 		=> reset,
      inputFilters 	=> inputFilters,
      delays 		=> delays,
      outputFilter 	=> outputFilter,
      weights 		=> weights);

  clock <= not clock after 10 ns;
  clk <= clock;
  reset <= '0', '1' after 5 ns;

  prosessed: process
  begin
    

    weights <= to_signed(73737,32);
    delays(0) <= to_unsigned(0,8);
    delays(1) <= to_unsigned(0,8);
    for i in 0 to 255 loop
      inputFilters(0)(i) <= to_signed(i,32);
      inputFilters(1)(i) <= to_signed(255-i,32);
    end loop;

    wait;
  
  end process prosessed;

end tb;