LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY TEST7 IS
PORT ( CLK50MHZ : IN STD_LOGIC;
		 SW   : IN  STD_LOGIC_VECTOR(9  DOWNTO 0);  --Initializing Switch,LED,Arduino_io and GPio as Inputs and Outputs
		 ARDUINO_IO : IN STD_LOGIC_VECTOR(16 DOWNTO 0);
		 LEDR : OUT STD_LOGIC_VECTOR(9  DOWNTO 0);
		 GPIO : OUT STD_LOGIC_VECTOR(36 DOWNTO 0);
		 HEX0 : out STD_LOGIC_VECTOR(7  DOWNTO 0);
		 HEX1 : out STD_LOGIC_VECTOR(7  DOWNTO 0);
		 HEX2 : out STD_LOGIC_VECTOR(7  DOWNTO 0)
		 );
END ENTITY TEST7;


ARCHITECTURE behaviour OF TEST7 IS

SIGNAL BUZZ    : STD_LOGIC; --Buzzer signal
SIGNAL O_N     : STD_LOGIC; -- Switch Signal
SIGNAL SMK_SEN : STD_LOGIC; -- Smoke sensor signal
SIGNAL K       : STD_LOGIC:='0';
SIGNAL CLK_ALM, CLK_BUZZ : STD_LOGIC;
signal Hex_1,Hex_2,Hex_0 : std_logic_vector(7 downto 0); -- hex display
SIGNAL ALM_LIGHT         : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";



BEGIN

O_N     <= SW(0);
SMK_SEN <= ARDUINO_IO(7);
GPIO(5) <= BUZZ;
HEX0    <= Hex_0;
HEX1    <= Hex_1;
HEX2    <= Hex_2;
LEDR(9) <= K;
LEDR(8 DOWNTO 0)  <= ALM_LIGHT;
DISP_CLK_4: WORK.ALM_CLK PORT MAP(clk_4 => CLK50MHZ,
											T3     => CLK_ALM);
DISP_CLK_5: WORK.BUZZ_CLK PORT MAP(clk_3 => CLK50MHZ,
											T2     => CLK_BUZZ);

PROCESS(SMK_SEN, O_N, K)
BEGIN
IF O_N = '1' THEN
	IF SMK_SEN = '0' THEN  --ON
		K <= '1';
		IF RISING_EDGE(CLK_BUZZ) THEN
			BUZZ  <= NOT(BUZZ);
		END IF;
		Hex_1 <= "11000000";
		Hex_0 <= "11001000";
		Hex_2 <= "11111111";
	ELSE                   --OFF
		K <= '0';
		BUZZ <= '0';
		Hex_2 <= "11000000";
		Hex_1 <= "10001110";
		Hex_0 <= "10001110";
	END IF;
ELSE
	BUZZ <= '0';
	Hex_1 <= "11111111";
	Hex_0 <= "11111111";
	Hex_2 <= "11111111";
END IF;

IF K = '1' THEN
	IF RISING_EDGE(CLK_ALM) THEN
		ALM_LIGHT <= NOT(ALM_LIGHT);
	END IF;
ELSE
	ALM_LIGHT <= "000000000";
END IF;
	
END PROCESS;
END behaviour;