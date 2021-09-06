LIBRARY ieee;


USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_signed.ALL; 
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_signed.ALL;
USE ieee.std_logic_arith.ALL;

ENTITY volume IS
	PORT (
	clk : 		IN STD_LOGIC;
		aclr : 		IN STD_LOGIC; 
		in_vol_1: 		IN STD_LOGIC_VECTOR (10 DOWNTO 0); 
		in_vol_2: 		IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		vol_1: 		OUT STD_LOGIC_VECTOR (10 DOWNTO 0); 
		vol_2: 		OUT STD_LOGIC_VECTOR (10 DOWNTO 0)
	);
END  volume;
ARCHITECTURE BEHAVIORAL OF volume IS
SIGNAL vol_1_int,vol_2_int: STD_LOGIC_VECTOR (10 DOWNTO 0);
BEGIN 
PROCESS (clk, aclr)
	BEGIN
		IF (aclr = '1') THEN
			vol_1_int <= (OTHERS => '0');	
			vol_2_int <= (OTHERS => '0');	
		ELSIF (clk'event AND clk = '1') THEN
			vol_1_int <= in_vol_1 ; 
			vol_2_int <= in_vol_2;
			
END IF;
END PROCESS;
vol_1 <= vol_1_int;
vol_2 <= vol_2_int;
END BEHAVIORAL;
