library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Adder2Bit is
    Port( A, B : in STD_LOGIC_VECTOR(1 downto 0);
          Cin : in STD_LOGIC;
          Sum : out STD_LOGIC_VECTOR(1 downto 0);
          Cout : out STD_LOGIC;
          led_status_switch : out STD_LOGIC_VECTOR (2 downto 0)
        );
end entity Adder2Bit;

architecture Behavioural of Adder2Bit is
component MUX_16_to_1 is
     Port(d:in std_logic_vector(15 downto 0);
         s:in std_logic_vector(3 downto 0);
         y:out std_logic);
end component;
signal d_Cin_c1 : std_logic_vector(15 downto 0);
signal s_AB : std_logic_vector(3 downto 0);
signal d_Cin_s0 : std_logic_vector(15 downto 0);
signal d_Cin_s1 : std_logic_vector(15 downto 0);
signal led_rgb : std_logic_vector(2 downto 0) := "000";
signal A0_show : std_logic;  

begin
    led_rgb <= "100" when A > B else
               "010" when A < B else
               "001" when A = B else     
               "000";
    led_status_switch <= led_rgb;
    d_Cin_c1 <= '1' & '1' & '1' & Cin & '1' & '1' & Cin & '0' & '1' & Cin & '0' & '0' & Cin & '0' & '0' & '0';
    s_AB <= A(1)&A(0)&B(1)&B(0);
    c1: MUX_16_to_1 port map(d_Cin_c1, s_AB, Cout);
    d_Cin_s0 <= Cin & not(Cin) & Cin & not(Cin) & not(Cin) & Cin & not(Cin) & Cin & Cin 
                            & not(Cin) & Cin & not(Cin) & not(Cin) & Cin & not(Cin) & Cin;
    s0: MUX_16_to_1 port map(d_Cin_s0, s_AB, Sum(0)); 
    d_Cin_s1 <= '1' & Cin & '0' & not(Cin) & Cin & '0' & not(Cin) & '1' & '0' & not(Cin) & '1' & Cin & not(Cin) & '1' & Cin & '0';           
    s1: MUX_16_to_1 port map(d_Cin_s1, s_AB, Sum(1));
        A0_show <= A(0);
end architecture;

