----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:53:25 05/09/2019 
-- Design Name: 
-- Module Name:    V_sync_gen - DataFlow 
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

entity V_sync_gen is
	Port( vga_clk : in std_logic;
			reset   : in std_logic;
			hsync   : out std_logic;
			vsync   : out std_logic;
			horizontal : out integer;
			vertical   : out integer
	);
end V_sync_gen;



architecture Behavioral of V_sync_gen is

signal hor_counter : integer range 0 to 799 :=0;
signal ver_counter : integer range 0 to 520 :=0;

begin
	process(reset,hor_counter,ver_counter,vga_clk)
	begin
	if reset='1' then
		hor_counter<=0;
		ver_counter<=0;
		hsync <='0';
		vsync <='0';
	elsif(vga_clk'event and vga_clk = '1') then
		if(hor_counter = 799) then
			--hsync <='0';
			hor_counter <=0;
			if(ver_counter = 520) then
				ver_counter<=0;
			else
				ver_counter<= ver_counter + 1;
				if(ver_counter <= 489 or ver_counter >491) then
					vsync <='1';
				else
					vsync <='0';
				end if;
			end if;
		elsif(hor_counter<=655 or hor_counter>751) then
			hsync <='1';
			hor_counter <= hor_counter + 1;
		else
		hsync <='0';
		hor_counter <= hor_counter + 1;
		end if;
	end if;
horizontal <= hor_counter;
vertical   <= ver_counter;
end process;	
end Behavioral;

