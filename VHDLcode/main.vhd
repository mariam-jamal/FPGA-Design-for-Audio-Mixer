LIBRARY ieee;


USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_signed.ALL; 
USE ieee.std_logic_unsigned.ALL;
USE ieee.fixed_pkg.ALL;
USE ieee.std_logic_signed.ALL;
USE ieee.std_logic_arith.ALL;
--use ieee.numeric_std.all;


ENTITY main IS
	PORT (
		clk: 		IN STD_LOGIC;
		aclr: 		IN STD_LOGIC; 
		ch0: 		IN STD_LOGIC_VECTOR (15 DOWNTO 0); 
		ch1: 		IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		ch2: 		IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		ch3: 		IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		in_g1_0: 	IN STD_LOGIC_VECTOR (10 DOWNTO 0); 
		in_g1_1: 	IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		in_g1_2: 	IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		in_g1_3: 	IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		in_g2_0: 	IN STD_LOGIC_VECTOR (10 DOWNTO 0); 
		in_g2_1: 	IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		in_g2_2: 	IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		in_g2_3: 	IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		in_vol_1: 		IN STD_LOGIC_VECTOR (10 DOWNTO 0); 
		in_vol_2: 		IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		--g1_1: 		IN STD_LOGIC_VECTOR (10 DOWNTO 0); 
		--g1_2: 		IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		--g1_3: 		IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		--g1_4: 		IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		--g2_1: 		IN STD_LOGIC_VECTOR (10 DOWNTO 0); 
		--g2_2: 		IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		--g2_3: 		IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		--g2_4: 		IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		--vol_1: 		IN STD_LOGIC_VECTOR (10 DOWNTO 0); 
		--vol_2: 		IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		out1: 	OUT STD_LOGIC_VECTOR (23 DOWNTO 0);
		out2:	OUT STD_LOGIC_VECTOR (23 DOWNTO 0)
	);
END  main; 
ARCHITECTURE Behavioral OF main IS

SIGNAL sumadd1 , sumadd2 :STD_LOGIC_VECTOR (26 DOWNTO 0);
SIGNAL g1_1_int , g1_2_int, g1_3_int, g1_4_int, g2_1_int, g2_2_int, g2_3_int, g2_4_int : STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL volume1_int , volume2_int : STD_LOGIC_VECTOR(10 DOWNTO 0); 

COMPONENT signedmult_add IS 
PORT(
		clk : 		IN STD_LOGIC;
		aclr : 		IN STD_LOGIC; 
		ch0: 		IN STD_LOGIC_VECTOR (15 DOWNTO 0); 
		ch1: 		IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		ch2: 		IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		ch3: 		IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		g1_1:		IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		g1_2:		IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		g1_3:		IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		g1_4:		IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		g2_1:		IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		g2_2:		IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		g2_3:		IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		g2_4:		IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		result1: 	OUT STD_LOGIC_VECTOR (26 DOWNTO 0);
		result2:	OUT STD_LOGIC_VECTOR (26 DOWNTO 0)
	);
END  COMPONENT;


COMPONENT gain IS 
PORT (
		clk : 		IN STD_LOGIC;
		aclr : 		IN STD_LOGIC;
		in_g1_0: 	IN STD_LOGIC_VECTOR (10 DOWNTO 0); 
		in_g1_1: 	IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		in_g1_2: 	IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		in_g1_3: 	IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		g1_0: 		OUT STD_LOGIC_VECTOR (10 DOWNTO 0); 
		g1_1: 		OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
		g1_2: 		OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
		g1_3: 		OUT STD_LOGIC_VECTOR (10 DOWNTO 0)
	);
END COMPONENT;

COMPONENT gain_2 IS 
PORT (
		clk : 		IN STD_LOGIC;
		aclr : 		IN STD_LOGIC;
		in_g2_0: 	IN STD_LOGIC_VECTOR (10 DOWNTO 0); 
		in_g2_1: 	IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		in_g2_2: 	IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		in_g2_3: 	IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		g2_0: 		OUT STD_LOGIC_VECTOR (10 DOWNTO 0); 
		g2_1: 		OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
		g2_2: 		OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
		g2_3: 		OUT STD_LOGIC_VECTOR (10 DOWNTO 0)
		
	);
END COMPONENT;

COMPONENT volume IS 
PORT (
		clk : 		IN STD_LOGIC;
		aclr : 		IN STD_LOGIC; 
		in_vol_1: 		IN STD_LOGIC_VECTOR (10 DOWNTO 0); 
		in_vol_2: 		IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		vol_1: 		OUT STD_LOGIC_VECTOR (10 DOWNTO 0); 
		vol_2: 		OUT STD_LOGIC_VECTOR (10 DOWNTO 0)
	);
END COMPONENT;

COMPONENT volume_mult IS 
PORT (
		clk : 		IN STD_LOGIC;
		aclr : 		IN STD_LOGIC; 
		vol_1: 		IN STD_LOGIC_VECTOR (10 DOWNTO 0); 
		vol_2: 		IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		result1: 	IN STD_LOGIC_VECTOR (26 DOWNTO 0);
		result2:	IN STD_LOGIC_VECTOR (26 DOWNTO 0);
		out1: 		OUT STD_LOGIC_VECTOR (23 DOWNTO 0);
		out2:		OUT STD_LOGIC_VECTOR (23 DOWNTO 0)
	);
END COMPONENT;


BEGIN

		unit1:  gain PORT MAP(
		clk 	,
		aclr   ,
		in_g1_0,in_g1_1,in_g1_2,in_g1_3,
		g1_1_int,
		g1_2_int,
		g1_3_int,
		g1_4_int 	); 
		
		unit2:  gain_2 PORT MAP(  
		clk ,
		aclr ,
		in_g2_0,in_g2_1,in_g2_2,in_g2_3,
		g2_1_int, g2_2_int, g2_3_int, g2_4_int	);
		
		unit3: volume PORT MAP(
		clk,
		aclr,
		in_vol_1,in_vol_2,
		volume1_int , volume2_int
		); 
		
		unit4:  signedmult_add PORT MAP(
		clk ,
		aclr,
		ch0,
		ch1,
		ch2,
		ch3, 
		g1_1_int , g1_2_int, g1_3_int, g1_4_int, g2_1_int, g2_2_int, g2_3_int, g2_4_int,
		sumadd1,  
		sumadd2		);
		
		
		unit5:  volume_mult PORT MAP(
		clk,
		aclr,
		volume1_int , volume2_int,
		sumadd1,  
		sumadd2, 
		out1,
		out2 ); 

		
		
END Behavioral;

