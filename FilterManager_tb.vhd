library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.FilterTypes.all;


entity FilterManager_tb is
end FilterManager_tb;

architecture tb of FilterManager_tb is
  component FilterManager 
    port(
      clk       	: in  std_logic;
      reset     	: in  std_logic;
      direction 	: in  unsigned(8 downto 0);
      weight    	: out unsigned(32 downto 0);
      filters   	: out fir_filter_array(1 downto 0);
      delays    	: out unsigned8_array(1 downto 0);
      mem_filt	 	: in  fir_filter_array(23 downto 0));
  end component;

  component FilterMemory
    port(mem_filters 	: out fir_filter_array(23 downto 0));
  end component;

  signal clk_tb 	: std_logic := '0';
  signal reset_tb     	: std_logic := '0';
  signal direction_tb 	: unsigned(8 downto 0) := (others => '0');
  signal weight_tb    	: unsigned(32 downto 0) := (others => '0');
  signal filters_tb   	: fir_filter_array(1 downto 0);
  signal delays_tb    	: unsigned8_array(1 downto 0);
  signal mem_filt_tb	: fir_filter_array(23 downto 0);

  signal Clock 		: std_logic := '1';


begin
  DUT: FilterManager
    port map(
      clk 		=> clk_tb,
      reset 		=> reset_tb,
      direction 	=> direction_tb,
      weight 		=> weight_tb,
      filters 		=> filters_tb,
      delays 		=> delays_tb,
      mem_filt 		=> mem_filt_tb);

  DAT: FilterMemory
    port map(
      mem_filters 	=> mem_filt_tb);

  Clock <= not Clock after 10 ns;
  clk_tb <= Clock;
  reset_tb <= '0', '1' after 5 ns;

  filt_proc: process
  begin
    direction_tb <= to_unsigned(1,9);
    wait for 15 ns;
    direction_tb <= to_unsigned(2,9);
    wait for 20 ns;
    direction_tb <= to_unsigned(4,9);
    wait for 20 ns;
    direction_tb <= to_unsigned(8,9);
    wait for 20 ns;
    direction_tb <= to_unsigned(16,9);
    wait for 20 ns;
    direction_tb <= to_unsigned(32,9);
    wait for 20 ns;
    direction_tb <= to_unsigned(64,9);
    wait for 20 ns;
    direction_tb <= to_unsigned(127,9);
    wait for 20 ns;
    direction_tb <= to_unsigned(200,9);
    
    wait;
  end process filt_proc;
end tb;








