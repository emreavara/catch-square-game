----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:44:48 04/19/2019 
-- Design Name: 
-- Module Name:    freq_div - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity freq_div is
	Port (
			in_clk : in STD_LOGIC;
			out_clk  : out STD_LOGIC
	);
end freq_div;

architecture Behavioral of freq_div is

signal counter     : integer range 0 to 3 := 0 ;
signal out_clk_div : STD_LOGIC :='0';
--signal reset      : STD_LOGIC 
begin
   process(in_clk) 
	begin 
	if rising_edge(in_clk) then
		if(counter=1) then
		out_clk_div <= NOT(out_clk_div);
		counter <= 0;
		else 
			counter <= counter + 1;
		end if;
	end if;
end process;
out_clk<=out_clk_div;

end Behavioral;

