----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:01:03 05/09/2019 
-- Design Name: 
-- Module Name:    colour_gen - Behavioral 
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
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.std_logic_signed.all;
USE IEEE.MATH_REAL.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity colour_gen is
	Port( vga_clk   : in std_logic;
			vga_clk_1M: in std_logic;
			reset     : in std_logic;
			btn_r     : in std_logic;
			btn_l     : in std_logic;
			hor_c     : in integer;
			ver_c     : in integer;
			catch     : out std_logic;
			rgb       : out std_logic_vector(7 downto 0)
	);
end colour_gen;

architecture Behavioral of colour_gen is

signal rgb_out : std_logic_vector (7 downto 0) ;


signal  square_hl : integer := 100;
signal  square_hr : integer := square_hl+50;
signal  square_vu : integer := -50;
signal  square_vd : integer := square_vu+50;

signal  basket_hl : integer := 100;
signal  basket_hr : integer := basket_hl+100;
signal  basket_vu : integer := 400;
signal  basket_vd : integer := basket_vu+30;

signal sig_btn_r, sig_btn_l : std_logic;
signal rand_num : integer :=0;

signal catch_flag : std_logic :='0';

begin
	sig_btn_r<=btn_r;
	sig_btn_l<=btn_l;
	process (vga_clk_1M)
		begin
		if(rising_edge(vga_clk_1M)) then
			if(rand_num=590) then
				rand_num<=0;
			else
				rand_num<=rand_num + 1;
			end if;
		else
			rand_num<=rand_num;
		end if;
			
	end process;
		
	process(reset,vga_clk,hor_c,ver_c)
	begin
	if (reset = '1') then
		rgb_out <= "00000000";
	elsif(vga_clk'event and vga_clk = '1') then
		if(ver_c <=479 and hor_c <=639) then
				if((hor_c>=square_hl and hor_c<=square_hr)  and (ver_c >=square_vu and  ver_c <=square_vd))   then
					rgb_out <="00000011" ;
				elsif((hor_c>=basket_hl and hor_c<=basket_hr)  and (ver_c >=basket_vu and  ver_c <=basket_vd))   then
					rgb_out <="11000000" ;
				else
					rgb_out<=B"00000000";
				end if;
		else
		rgb_out<=B"00000000";
		end if;
	end if;
end process;

process(vga_clk_1M,btn_r,btn_l)
	begin
		if(vga_clk_1M'event and vga_clk_1M = '1') then
			if(basket_hl>0 and basket_hl<540) then
				if(sig_btn_r='1') then
					basket_hl<=basket_hl+1;	
				elsif(sig_btn_l='1') then
					basket_hl<=basket_hl-1;
				else
					basket_hl<=basket_hl;
				end if;
			else
				if(basket_hl=0) then
					basket_hl<=basket_hl+1;
				else
					basket_hl<=basket_hl-1;
				end if;
			end if;
			if((square_vd=basket_vu and ((square_hr>=basket_hl and square_hr<=basket_hr) or (square_hl<=basket_hr and square_hl>=basket_hl))) or square_vu=480 ) then
				if(square_vd=basket_vu and ((square_hr>=basket_hl and square_hr<=basket_hr) or (square_hl<=basket_hr and square_hl>=basket_hl))) then
					square_hl<=integer(rand_num);
					square_vu<=-50;
					catch_flag<='1';
				else
					square_hl<=integer(rand_num);
					square_vu<=-50;
					catch_flag<='0';
				end if;
			else
				catch_flag<='0';
				square_vu<=square_vu+1;
			end if;
		end if;
end process;
catch<=catch_flag;
rgb<=rgb_out;

end Behavioral;

