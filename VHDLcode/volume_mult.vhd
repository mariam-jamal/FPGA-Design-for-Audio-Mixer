LIBRARY ieee;


USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_signed.ALL; 
USE ieee.std_logic_unsigned.ALL;
USE ieee.fixed_pkg.ALL;
USE ieee.std_logic_signed.ALL;
USE ieee.std_logic_arith.ALL;
--use ieee.numeric_std.all;

ENTITY volume_mult IS
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
END  volume_mult;

ARCHITECTURE Behavioral OF volume_mult IS
	SIGNAL vol_1_int, vol_2_int : STD_LOGIC_VECTOR (10 DOWNTO 0);
	SIGNAL  result1_int, result2_int : STD_LOGIC_VECTOR (26 DOWNTO 0);
	SIGNAL out1_int, out2_int : signed(37 DOWNTO 0);
BEGIN 
PROCESS (clk, aclr)
	BEGIN
		IF (aclr = '1') THEN
			vol_1_int <= (OTHERS => '0');				
			vol_2_int <= (OTHERS => '0');
			result1_int <= (OTHERS => '0');
			result2_int <= (OTHERS => '0');
			out1_int <= (OTHERS => '0');
			out2_int <= (OTHERS => '0');
			 
		ELSIF (clk'event AND clk = '1') THEN
			vol_1_int <= vol_1	;			
			vol_2_int <= vol_2;
			result1_int <= result1 ;
			result2_int <= result2;
			--out1_int <= out1;
			--out2_int <= out2; 
			out1_int <=  signed(result1_int) * signed(vol_1_int);
			out2_int <=  signed(result2_int) * signed(vol_2_int);
END IF ;
END PROCESS; 
out1 <= STD_LOGIC_VECTOR(out1_int(23 DOWNTO 0)); 
out2 <= STD_LOGIC_VECTOR(out2_int(23 DOWNTO 0));
END Behavioral;