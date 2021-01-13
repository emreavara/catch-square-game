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

entity freq_div1M is
	Port (
			in_clk1M : in STD_LOGIC;
			out_clk1M  : out STD_LOGIC
	);
end freq_div1M;

architecture Behavioral of freq_div1M is

signal counter     : integer range 0 to 750000 := 0 ;
signal out_clk_div : STD_LOGIC :='0';
--signal reset      : STD_LOGIC 
begin
   process(in_clk1M) 
	begin 
	if rising_edge(in_clk1M) then
		if(counter=750000) then
		out_clk_div <= NOT(out_clk_div);
		counter <= 0;
		else 
			counter <= counter + 1;
		end if;
	end if;
end process;
out_clk1M<=out_clk_div;

end Behavioral;

