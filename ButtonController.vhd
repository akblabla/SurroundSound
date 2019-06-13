library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ButtonController is
	port(clkwBtn 		: in  std_logic;
	     cntclkwBtn		: in  std_logic;
	     SenseUp		: in  std_logic;
	     SenseDown		: in  std_logic;
	     clk		: in  std_logic;
	     reset		: in  std_logic;
	     direction		: out unsigned(7 downto 0));
end entity;

architecture controlDirection of ButtonController is
  signal degrees 		: 	unsigned(21 downto 0);
  signal sensitivity 		:	unsigned(2 downto 0) := "001";
  signal step			:	integer := 1;

begin
  direction <= degrees(21 downto 14);
  clocks: process(clk, reset)
  begin
    if reset = '0' then
	   direction <= (others => '0');
		sensitivity <= "001";
	 elsif rising_edge(clk) then
	   if clkwBtn = '0' then
	     degrees <= degrees + (sensitivity * step);
	 	elsif cntclkwBtn = '0' then
	 	  degrees <= degrees - (sensitivity * step);
	 	end if;
	 end if;
  end process clocks;
  
  process(SenseUp)
  begin
    if falling_edge(SenseUp) then
	   if sensitivity = "101" then
		  sensitivity <= "101";
		else
		  sensitivity <= sensitivity + "001";
		end if;
	 end if;
  end process;
  
  process(SenseDown)
  begin
    if falling_edge(SenseUp) then
	   if sensitivity = "001" then
		  sensitivity <= "001";
		else
		  sensitivity <= sensitivity - "001";
		end if;
	 end if;
  end process;
end controlDirection;