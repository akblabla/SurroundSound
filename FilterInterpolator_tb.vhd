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
         clk 			: in std_logic;
	 reset 			: in std_logic;
	 inputFilters 		: in fir_filter_array(1 downto 0);
	 delays 		: in unsigned8_array(1 downto 0);
	 outputFilter 		: out fir_filter;
	 weights		: in signed32);
  end component;

  signal clk_tb 		: std_logic := '0';
  signal reset_tb 		: std_logic := '0';
  signal inputFilters_tb 	: fir_filter_array(1 downto 0);
  signal delays_tb	 	: unsigned8_array(1 downto 0);
  signal outputFilter_tb 	: fir_filter;
  signal weights_tb		: signed32 := (others => '0');

  signal clock 			: std_logic := '1';

  

begin
  


  DUT: FilterInterpolator
    port map(
      clk 		=> clk_tb,
      reset 		=> reset_tb,
      inputFilters 	=> inputFilters_tb,
      delays 		=> delays_tb,
      outputFilter 	=> outputFilter_tb,
      weights 		=> weights_tb);

  clock <= not clock after 10 ns;
  clk_tb <= clock;
  reset_tb <= '0', '1' after 5 ns;

  prosessed: process
  begin
    

    weights_tb <= to_signed(0,32);
    delays_Tb(0) <= to_unsigned(0,8);
    delays_tb(1) <= to_unsigned(0,8);
    for i in 0 to 255 loop
      inputFilters_tb(0)(i) <= to_signed(i,32);
      inputFilters_tb(1)(i) <= to_signed(255-i,32);
    end loop;
    wait for 10 ns;
    for i in 0 to 255 loop
      inputFilters_tb(0)(i) <= to_signed(i+1,32);
      inputFilters_tb(1)(i) <= to_signed(i*2,32);
    end loop;

    wait;
  
  end process prosessed;

end tb;