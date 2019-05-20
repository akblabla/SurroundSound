library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

package FilterTypes is 


     subtype signed8 is signed(7 downto 0);
     subtype signed32 is signed(31 downto 0);
     type signed_array is array(natural range <>) of signed32;
	  subtype fir_filter is signed_array(255 downto 0);
     type signed8_array is array(natural range <>) of signed8;
     type signed32_array is array(natural range <>) of signed32;
     type fir_filter_array is array(natural range <>) of fir_filter;
	  
end FilterTypes;