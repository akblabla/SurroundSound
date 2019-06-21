library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.FilterTypes.all;

entity TopLevelSimulation is
end entity;

architecture default of TopLevelSimulation is
begin
	FI : entity work.FilterInterpolator_tb;
	FP : entity work.FilterProcessor_tb;
	FM : entity work.FilterManager_tb;
	Byte2ISS : entity work.ByteStream2IIS_tb;
	BC : entity work.ButtonController_tb;
	IIS2Byte : entity work.IIS2ByteStream_tb(tb);

end architecture default;