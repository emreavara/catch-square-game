----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:48:33 04/12/2019 
-- Design Name: 
-- Module Name:    bcd2sevseg - Behavioral 
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

entity BCD_to_seven_segment is
port ( 
		 d: in std_logic_vector (3 downto 0);
		 s: out std_logic_vector ( 7 downto 0) );
end BCD_to_seven_segment;
architecture dataflow of BCD_to_seven_segment is

begin

with d select
--s <="00111111" when "0000",
--"00000110" when "0001",
--"01011011" when "0010",
--"01001111" when "0011",
--"01100110" when "0100",
--"01101101" when "0101",
--"01111101" when "0110",
--"00000111" when "0111",
--"01111111" when "1000",
--"01101111" when "1001",
--"00000000" when others;
s <="11000000" when "0000",
"11111001" when "0001",
"10100100" when "0010",
"10110000" when "0011",
"10011001" when "0100",
"10010010" when "0101",
"10000010" when "0110",
"11111000" when "0111",
"10000000" when "1000",
"10010000" when "1001",
"11111111" when others;
end dataflow;

