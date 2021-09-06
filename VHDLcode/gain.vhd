LIBRARY ieee;


USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_signed.ALL; 
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_signed.ALL;
USE ieee.std_logic_arith.ALL;

ENTITY gain IS
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
END  gain;

ARCHITECTURE BEHAVIORAL OF gain IS
SIGNAL g1_0_int,g1_1_int,g1_2_int,g1_3_int: STD_LOGIC_VECTOR (10 DOWNTO 0);
BEGIN 
PROCESS (clk, aclr)
	BEGIN
		IF (aclr = '1') THEN
			g1_0_int <= (OTHERS => '0');	
			g1_1_int <= (OTHERS => '0');	
			g1_2_int <= (OTHERS => '0');	
			g1_3_int <= (OTHERS => '0');	
		ELSIF (clk'event AND clk = '1') THEN
			g1_0_int <= in_g1_0 ; 
			g1_1_int <= in_g1_1 ;
			g1_2_int <= in_g1_2 ; 
			g1_3_int <= in_g1_3 ;

END IF;
END PROCESS;
g1_0 <= g1_0_int;
g1_1 <= g1_1_int;
g1_2 <= g1_2_int;
g1_3 <= g1_3_int;
END BEHAVIORAL;
