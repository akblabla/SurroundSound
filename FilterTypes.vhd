library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

package FilterTypes is 


     subtype signed8 is signed(7 downto 0);
     subtype unsigned8 is unsigned(7 downto 0);
     subtype signed16 is signed(15 downto 0);
     subtype unsigned16 is unsigned(15 downto 0);
     subtype signed32 is signed(31 downto 0);
     subtype unsigned32 is unsigned(31 downto 0);
     subtype signed64 is signed(63 downto 0);
     subtype unsigned64 is unsigned(63 downto 0);
     type signed_array is array(natural range <>) of signed32;
     subtype fir_filter is signed_array(255 downto 0);
     type signed8_array is array(natural range <>) of signed8;
     type unsigned8_array is array(natural range <>) of unsigned8;
     type signed32_array is array(natural range <>) of signed32;
     type unsigned32_array is array(natural range <>) of unsigned32;
     type fir_filter_array is array(natural range <>) of fir_filter;
	  
end FilterTypes;