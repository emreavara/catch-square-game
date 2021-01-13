----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:08:54 04/12/2019 
-- Design Name: 
-- Module Name:    adder_3 - Dataflow 
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

entity adder_3 is
	port(
			in_add : in STD_LOGIC_VECTOR(3 downto 0);
			out_add: out STD_LOGIC_VECTOR(3 downto 0)
		);
end adder_3;

architecture Dataflow of adder_3 is

begin
out_add<= "1000" when in_add = "0101" ELSE
"1001" when in_add = "0110" ELSE
"1010" when in_add = "0111" ELSE
"1011" when in_add = "1000" ELSE
"1100" when in_add = "1001" ELSE
in_add;
end Dataflow;

