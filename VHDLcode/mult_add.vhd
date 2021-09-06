LIBRARY ieee;


USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_signed.ALL; 
USE ieee.std_logic_unsigned.ALL;
USE ieee.fixed_pkg.ALL;
USE ieee.std_logic_signed.ALL;
USE ieee.std_logic_arith.ALL;
--use ieee.numeric_std.all;


ENTITY signedmult_add IS
	PORT (
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
END  signedmult_add;

ARCHITECTURE rtl OF signedmult_add IS
	SIGNAL ch0_int, ch1_int, ch2_int, ch3_int  : STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL g1_1_int , g1_2_int, g1_3_int, g1_4_int, g2_1_int, g2_2_int, g2_3_int, g2_4_int : STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL mult_int, mult2_int,mult3_int, mult4_int,mult5_int, mult6_int,mult7_int, mult8_int : signed (26 DOWNTO 0);
	SIGNAL result1_int,result2_int: signed(26 DOWNTO 0);
	SIGNAL saturation1_bit, saturation2_bit: signed(26 DOWNTO 0);
BEGIN
	PROCESS (clk, aclr)
	VARIABLE result1a_int, result2a_int: signed (26 DOWNTO 0);
	
	CONSTANT Zerostring: signed(25 DOWNTO 0) := (OTHERS => '0');
	CONSTANT Onesstring: signed(25 DOWNTO 0) := (OTHERS => '1');
	
	BEGIN
		IF (aclr = '1') THEN
			ch0_int <= (OTHERS => '0');				
			ch1_int <= (OTHERS => '0');
			ch2_int <= (OTHERS => '0');
			ch3_int <= (OTHERS => '0');
			mult_int <= (OTHERS => '0');
			mult2_int <= (OTHERS => '0');
			mult3_int <= (OTHERS => '0');
			mult4_int <= (OTHERS => '0');
			mult5_int <= (OTHERS => '0');
			mult6_int <= (OTHERS => '0');
			mult7_int <= (OTHERS => '0');
			mult8_int <= (OTHERS => '0');
			result1_int <= (OTHERS => '0');
			result2_int <= (OTHERS => '0');
			
			result1a_int := (OTHERS => '0');
			result2a_int := (OTHERS => '0');

		ELSIF (clk'event AND clk = '1') THEN
			ch0_int <= ch0; 
			ch1_int <= ch1; 
			ch2_int <= ch2;		
			ch3_int <= ch3;
			g1_1_int <= g1_1;
			g1_2_int <= g1_2;
			g1_3_int <= g1_3;
			g1_4_int <= g1_4;
			g2_1_int <= g2_1;
			g2_2_int <= g2_2;
			g2_3_int <= g2_3;
			g2_4_int <= g2_4; 

			mult_int <=  signed(ch0_int) * signed(g1_1_int);
			mult2_int <= signed(ch1_int) * signed(g1_2_int);
			mult3_int <= signed(ch2_int) * signed(g1_3_int);
			mult4_int <= signed(ch3_int) * signed(g1_4_int);
			mult5_int <= signed(ch0_int) * signed(g2_1_int);
			mult6_int <= signed(ch1_int) * signed(g2_2_int);
			mult7_int <= signed(ch2_int) * signed(g2_3_int);
			mult8_int <= signed(ch3_int) * signed(g2_4_int);
			
			result1a_int:= mult_int + mult2_int+mult3_int + mult4_int;
			IF result1a_int(26) = result1a_int(25) THEN	-- no overflow 
				saturation1_bit <= '0'& Zerostring;
  			ELSIF result1a_int(26) = '1' THEN 		-- negative saturation
            	saturation1_bit <= '1'& Zerostring;
			ELSE 									-- positive saturation
            	saturation1_bit <= '1'& Onesstring;
            END IF;
            	result1_int <= result1a_int(26 DOWNTO 0);	 
			
			result2a_int:= mult5_int + mult6_int +mult7_int + mult8_int;
			IF result2a_int(26) = result2a_int(25) THEN	-- no overflow 
				saturation2_bit <= '0'& Zerostring;
  			ELSIF result2a_int(26) = '1' THEN 		-- negative saturation
            	saturation2_bit <= '1'& Zerostring; 							
            ELSE 									-- positive saturation
            	saturation2_bit <= '1'& Onesstring;
            END IF;
            	result2_int <= result2a_int(26 DOWNTO 0);

			--result1_int <= mult_int + mult2_int +mult3_int + mult4_int;
			--result2_int <= mult5_int + mult6_int +mult7_int + mult8_int;

		END IF;
	END PROCESS;

	result1 <= STD_LOGIC_VECTOR(result1_int);
  	result2 <= STD_LOGIC_VECTOR(result2_int);

END rtl;
