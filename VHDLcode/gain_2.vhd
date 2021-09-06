LIBRARY ieee;


USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_signed.ALL; 
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_signed.ALL;
USE ieee.std_logic_arith.ALL;

ENTITY gain_2 IS
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
END  gain_2; 

ARCHITECTURE BEHAVIORAL OF gain_2 IS
SIGNAL g2_0_int,g2_1_int,g2_2_int,g2_3_int: STD_LOGIC_VECTOR (10 DOWNTO 0);
BEGIN 
PROCESS (clk, aclr)
	BEGIN
		IF (aclr = '1') THEN
			g2_0_int <= (OTHERS => '0');	
			g2_1_int <= (OTHERS => '0');	
			g2_2_int <= (OTHERS => '0');	
			g2_3_int <= (OTHERS => '0');	
		ELSIF (clk'event AND clk = '1') THEN
			g2_0_int <= in_g2_0 ; 
			g2_1_int <= in_g2_1 ;
			g2_2_int <= in_g2_2 ; 
			g2_3_int <= in_g2_3 ;

END IF;
END PROCESS;
g2_0 <= g2_0_int;
g2_1 <= g2_1_int;
g2_2 <= g2_2_int;
g2_3 <= g2_3_int;
END BEHAVIORAL;
