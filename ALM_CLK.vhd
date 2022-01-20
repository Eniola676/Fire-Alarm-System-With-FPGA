LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY ALM_CLK IS
PORT(clk_4 : IN   STD_LOGIC;
		T3   : OUT  STD_LOGIC
		);
END ALM_CLK;


ARCHITECTURE Behavior of ALM_CLK IS
SIGNAL clk    : STD_LOGIC;
SIGNAL Q, tmp : STD_LOGIC_VECTOR(23 DOWNTO 0);

BEGIN
	clk <= clk_4;	
	
   --- CLOCK DIVIDER ---
   PROCESS(clk, Q) 
   BEGIN
		 
		IF (RISING_EDGE(clk)) THEN
			tmp <= tmp + 1;
		END IF;
		Q <= tmp;	
		
		
		IF (Q <= "000000000000000000000000") THEN
			T3 <= '1';
		ELSE
			T3 <= '0';
		END IF;
		
	END PROCESS;
END Behavior;