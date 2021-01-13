LIBRARY ieee ;

USE ieee.std_logic_1164.all ;
USE ieee.std_logic_signed.all ;
USE ieee.std_logic_arith.all ;
USE ieee.std_logic_unsigned.all;

entity ee240_vgadriver is
	port (nreset: in std_logic;
			board_clk: in std_logic;
			move_r : in std_logic;
			move_l : in std_logic;
			vsync: out std_logic;
			hsync: out std_logic;
			red: out std_logic_vector(2 downto 0);
			green: out std_logic_vector(2 downto 0);
			blue: out std_logic_vector(1 downto 0);
			SSEG_CA : out STD_LOGIC_VECTOR (7 downto 0);
			SSEG_AN : out STD_LOGIC_VECTOR (3 downto 0)
			);
end;

architecture arch_vga_driver of ee240_vgadriver is

component freq_div 
	Port (
			in_clk : in STD_LOGIC;
			out_clk  : out STD_LOGIC
	);
	
end component freq_div;


component freq_div1M 
	Port (
			in_clk1M : in STD_LOGIC;
			out_clk1M  : out STD_LOGIC
	);
end component freq_div1M;


component scoring is
	port(	clk_slw     : in std_logic;
			catch_flag1 : in std_logic;
			score       : out std_logic_vector (5 downto 0)
		);
end component scoring;


component bin2bcd_dec
	port(
			bin_num : in STD_LOGIC_VECTOR(5 downto 0);
			lowdig  : out STD_LOGIC_VECTOR(3 downto 0);
			highdig  : out STD_LOGIC_VECTOR(3 downto 0)
			);
end component bin2bcd_dec;

component BCD_to_seven_segment 
port ( 
		 d: in std_logic_vector (3 downto 0);
		 s: out std_logic_vector ( 7 downto 0) );
end component BCD_to_seven_segment;



component nexys3_sseg_driver 
    port( 
		MY_CLK 	: in  STD_LOGIC;
		DIGIT0  : in  STD_LOGIC_VECTOR (7 downto 0);
		DIGIT1  : in  STD_LOGIC_VECTOR (7 downto 0);
		DIGIT2  : in  STD_LOGIC_VECTOR (7 downto 0);
		DIGIT3  : in  STD_LOGIC_VECTOR (7 downto 0);
		out_SSEG_CA : out STD_LOGIC_VECTOR (7 downto 0);
		out_SSEG_AN : out STD_LOGIC_VECTOR (3 downto 0)
	);
end component nexys3_sseg_driver;

component colour_gen 
	Port( vga_clk   : in std_logic;
			vga_clk_1M: in std_logic;
			reset     : in std_logic;
			btn_r  : in std_logic;
			btn_l  : in std_logic;
			hor_c     : in integer;
			ver_c     : in integer;
			catch     : out std_logic;
			rgb       : out std_logic_vector(7 downto 0)
	);
end component colour_gen;

component V_sync_gen 
	Port( vga_clk : in std_logic;
			reset   : in std_logic;
			hsync   : out std_logic;
			vsync   : out std_logic;
			horizontal : out integer;
			vertical   : out integer
	);
end component V_sync_gen;

signal vga_slw_clk : std_logic;
signal vga_slw_clk_1M : std_logic;

signal hsync_out   : std_logic :='0';
signal vsync_out   : std_logic :='0';
signal hor_count   : integer;
signal ver_count   : integer;

signal clr_gnr     : std_logic_vector(7 downto 0) :="00000000";

signal catch_out   : std_logic :='0';
signal sig_score   : std_logic_vector(5 downto 0) :="000000";
signal sig_high_dig,sig_low_dig : std_logic_vector(3 downto 0) :="0000";

signal bcd_DIGIT0,bcd_DIGIT1: std_logic_vector(7 downto 0) :="00000000";

signal out_SCA : STD_LOGIC_VECTOR (7 downto 0);
signal out_SAN : STD_LOGIC_VECTOR (3 downto 0);

begin

fd1 : freq_div PORT MAP (board_clk,vga_slw_clk);
fd2 : freq_div1M PORT MAP (board_clk,vga_slw_clk_1M);
vh_sync : V_sync_gen PORT MAP(vga_slw_clk,nreset,hsync_out,vsync_out,hor_count,ver_count);
clr_genr1: colour_gen PORT MAP(vga_slw_clk,vga_slw_clk_1M,nreset,move_r,move_l,hor_count,ver_count,catch_out,clr_gnr);
score1   : scoring PORT MAP (vga_slw_clk_1M,catch_out,sig_score);
bin2bcd1: bin2bcd_dec PORT MAP (sig_score,sig_low_dig,sig_high_dig);
bcd2_7seg1: BCD_to_seven_segment PORT MAP(sig_low_dig,bcd_DIGIT0);
bcd2_7seg2: BCD_to_seven_segment PORT MAP(sig_high_dig,bcd_DIGIT1);
nexys1 : nexys3_sseg_driver PORT MAP(board_clk,"11111111","11111111",bcd_DIGIT1,bcd_DIGIT0,out_SCA,out_SAN);


SSEG_CA <=out_SCA;
SSEG_AN <=out_SAN;


vsync<=vsync_out;
hsync<=hsync_out;

red<= clr_gnr(7 downto 5);
green<= clr_gnr(4 downto 2);
blue<= clr_gnr(1 downto 0);


end arch_vga_driver;