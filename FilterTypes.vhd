library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

package FilterTypes is 
     type fir_filter is array(natural range <>) of unsigned(31 downto 0);
end FilterTypes;