
LIBRARY ieee;


USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_signed.ALL; 
USE ieee.std_logic_unsigned.ALL;
--use ieee.fixed_pkg.all;
USE ieee.std_logic_signed.ALL;
USE ieee.std_logic_arith.ALL;
--use ieee.numeric_std.all;
	

ENTITY main_tb IS
END main_tb;

ARCHITECTURE TB_ARCHITECTURE OF main_tb IS
	-- Component declaration of the tested unit
	COMPONENT main
	PORT(
		clk : IN STD_LOGIC;
		aclr : IN STD_LOGIC;
		ch0 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		ch1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		ch2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		ch3 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		in_g1_0 : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		in_g1_1 : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		in_g1_2 : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		in_g1_3 : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		in_g2_0 : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		in_g2_1 : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		in_g2_2 : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		in_g2_3 : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		in_vol_1 : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		in_vol_2 : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		out1 : OUT STD_LOGIC_VECTOR(23 DOWNTO 0);
		out2 : OUT STD_LOGIC_VECTOR(23 DOWNTO 0) );
	END COMPONENT;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	SIGNAL clk : STD_LOGIC;
	SIGNAL aclr : STD_LOGIC;
	SIGNAL ch0 : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL ch1 : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL ch2 : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL ch3 : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL in_g1_0 : STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL in_g1_1 : STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL in_g1_2 : STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL in_g1_3 : STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL in_g2_0 : STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL in_g2_1 : STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL in_g2_2 : STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL in_g2_3 : STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL in_vol_1 : STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL in_vol_2 : STD_LOGIC_VECTOR(10 DOWNTO 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	SIGNAL out1 : STD_LOGIC_VECTOR(23 DOWNTO 0);
	SIGNAL out2 : STD_LOGIC_VECTOR(23 DOWNTO 0);

	-- Add your code here ...

BEGIN

	-- Unit Under Test port map
	UUT : main
		PORT MAP (
			clk => clk,
			aclr => aclr,
			ch0 => ch0,
			ch1 => ch1,
			ch2 => ch2,
			ch3 => ch3,
			in_g1_0 => in_g1_0,
			in_g1_1 => in_g1_1,
			in_g1_2 => in_g1_2,
			in_g1_3 => in_g1_3,
			in_g2_0 => in_g2_0,
			in_g2_1 => in_g2_1,
			in_g2_2 => in_g2_2,
			in_g2_3 => in_g2_3,
			in_vol_1 => in_vol_1,
			in_vol_2 => in_vol_2,
			out1 => out1,
			out2 => out2
		);
  
clk_process:PROCESS
BEGIN
clk <= '0';
WAIT FOR 20.83 us;
clk <= '1';
WAIT FOR 20.83 us;
END PROCESS;

	-- Add your stimulus here ...
--input stimulus process
stim_proc:PROCESS
BEGIN
--aclr<='1';
WAIT FOR 5 ns;
aclr<='0';
WAIT FOR 5 ns;
  
ch0 <= "0000000000010010";
ch1 <= "0000001001110000";
ch2 <= "0000001100011001";
ch3 <= "0000010000000010";
in_g1_0 <= "00000001010";  --10db 
in_g1_1 <= "00000001111";  --15db
in_g1_2 <= "00000010100";  --20db
in_g1_3 <= "00000011001";  --25db
in_g2_0 <= "00000010000";  --(16db)
in_g2_1 <= "00000010001";  --(17db)
in_g2_2 <= "00000010010";  --(18db)
in_g2_3 <= "00000010011";  --(19db)
in_vol_1 <= "00000000010"; --2
in_vol_2 <= "00000000011"; --3
 WAIT FOR 10ns;
END PROCESS;

END TB_ARCHITECTURE;

CONFIGURATION TESTBENCH_FOR_main OF main_tb IS
	FOR TB_ARCHITECTURE
		FOR UUT : main
			USE ENTITY work.main(behavioral);
		END FOR;
	END FOR;
END TESTBENCH_FOR_main;