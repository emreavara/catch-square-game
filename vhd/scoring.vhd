----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:05:31 05/27/2019 
-- Design Name: 
-- Module Name:    scoring - Behavioral 
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
-- arithmetic functions with Signed or Unsigned value
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity scoring is
	port(	clk_slw     : in std_logic;
			catch_flag1 : in std_logic;
			score       : out std_logic_vector (5 downto 0)
		);
end scoring;

architecture Behavioral of scoring is

signal sig_catch_flag1 :std_logic := '0';
signal sig_score :std_logic_vector (5 downto 0) :="000000";

begin
	sig_catch_flag1<=catch_flag1;
	process (clk_slw) 
	begin
		if(falling_edge(clk_slw)) then
			if(sig_catch_flag1='1') then
				sig_score<=sig_score + B"000001";
			else
				sig_score<=sig_score;
			end if;
		end if;
end process;
score<=sig_score;

end Behavioral;

