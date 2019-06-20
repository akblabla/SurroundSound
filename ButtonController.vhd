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
			  direction		: out unsigned(7 downto 0) := (others => '0'));
end entity;

architecture controlDirection of ButtonController is
  signal degrees 		: 	unsigned(21 downto 0) := (others => '0');
  signal sensitivity 		:	integer := 1;
  signal step			:	integer := 1;
  signal sense			:	integer := 1;

begin
  
  clocks: process(clk, reset)
  begin
    direction <= degrees(21 downto 14);
    sensitivity <= sense;
    if reset = '0' then
      direction <= (others => '0');
      sensitivity <= 1;
      step <= 1;
    elsif rising_edge(clk) then
      if clkwBtn = '0' then
        degrees <= degrees + (sensitivity * step);
      elsif cntclkwBtn = '0' then
        degrees <= degrees - (sensitivity * step);
      end if;
    end if;
  end process clocks;

  senses: process(clk, reset)
  variable pressedSenseUp : std_logic;
  variable pressedSenseDown : std_logic;
  begin
    if reset = '0' then
      sense <= 0;
	 elsif rising_edge(clk) then
		if SenseUp = '0' and pressedSenseUp = '0' then
		  if sense < 5 then
          sense <= sense + 1;
        end if;
		  pressedSenseUp := '1';
		end if;
		if SenseUp = '1' then
			pressedSenseUp := '0';
		end if;
		
      if SenseDown = '0' and pressedSenseDown = '0' then
		  if sense < 5 then
          sense <= sense - 1;
        end if;
		  pressedSenseDown := '1';
		end if;
		if SenseDown = '1' then
			pressedSenseDown := '0';
		end if;
		
	 end if;
  end process senses;
    
--  senses: process(SenseUp, SenseDown)
--  begin
--    if falling_edge(SenseUp) then
--      if sense = 5 then
--        
--      else
--        sense <= sense + 1;
--      end if;
--	 end if;
--    if falling_edge(SenseDown) then
--      if sense = 1 then
--        
--      else
--        sense <= sense - 1;
--      end if;
--    end if;
--  end process;
end controlDirection;