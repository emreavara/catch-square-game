----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:53:33 04/12/2019 
-- Design Name: 
-- Module Name:    bin2bcd_dec - Dataflow 
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

entity bin2bcd_dec is
	port(
			bin_num : in STD_LOGIC_VECTOR(5 downto 0);
			lowdig  : out STD_LOGIC_VECTOR(3 downto 0);
			highdig  : out STD_LOGIC_VECTOR(3 downto 0)
			);
end bin2bcd_dec;

architecture Dataflow of bin2bcd_dec is

component adder_3 
	port(
			in_add : in STD_LOGIC_VECTOR(3 downto 0);
			out_add: out STD_LOGIC_VECTOR(3 downto 0)
		 );
end component adder_3;
signal sig_A1,sig_A2,int_1_out,int_2_out,int_3_out : STD_LOGIC_VECTOR(3 downto 0);
signal sig_A3,sig_A4 : STD_LOGIC_VECTOR(3 downto 0);

begin
sig_A1(0)<=bin_num(3);
sig_A1(1)<=bin_num(4);
sig_A1(2)<=bin_num(5);
sig_A1(3)<='0';

highdig(3)<='0';

int_1 : adder_3 PORT MAP(sig_A1,int_1_out);

highdig(2)<=int_1_out(3);

sig_A2(1)<=int_1_out(0);
sig_A2(2)<=int_1_out(1);
sig_A2(3)<=int_1_out(2);
sig_A2(0)<=bin_num(2);

int_2 : adder_3 PORT MAP(sig_A2,int_2_out);

highdig(1)<=int_2_out(3);

sig_A3(1)<=int_2_out(0);
sig_A3(2)<=int_2_out(1);
sig_A3(3)<=int_2_out(2);
sig_A3(0)<=bin_num(1);

int_3 : adder_3 PORT MAP(sig_A3,int_3_out);

highdig(0)<=int_3_out(3);

sig_A4(1)<=int_3_out(0);
sig_A4(2)<=int_3_out(1);
sig_A4(3)<=int_3_out(2);
sig_A4(0)<=bin_num(0);

lowdig<=sig_A4;

end Dataflow;

