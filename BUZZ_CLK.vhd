LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY BUZZ_CLK IS
PORT(clk_3 : IN   STD_LOGIC;
		T2   : OUT  STD_LOGIC
		);
END BUZZ_CLK;


ARCHITECTURE Behavior of BUZZ_CLK IS
SIGNAL clk    : STD_LOGIC;
SIGNAL Q, tmp : STD_LOGIC_VECTOR(23 DOWNTO 0);

BEGIN
	clk <= clk_3;	
	
   --- CLOCK DIVIDER ---
   PROCESS(clk, Q) 
   BEGIN
		 
		IF (RISING_EDGE(clk)) THEN
			tmp <= tmp + 1;
		END IF;
		Q <= tmp;	
		
		
		IF (Q <= "000000000000000000000000") THEN
			T2 <= '1';
		ELSE
			T2 <= '0';
		END IF;
		
	END PROCESS;
END Behavior;