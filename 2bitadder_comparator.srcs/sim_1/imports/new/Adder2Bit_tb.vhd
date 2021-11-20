library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Adder2Bit_tb is

end entity Adder2Bit_tb;

architecture tb_behaviour of Adder2Bit_tb is
    component Adder2Bit
    Port( A, B : in STD_LOGIC_VECTOR(1 downto 0);
          Cin : in STD_LOGIC;
          Sum : out STD_LOGIC_VECTOR(1 downto 0);
          Cout : out STD_LOGIC;
          led_status_switch : out STD_LOGIC_VECTOR (2 downto 0)
        ); 
    end component;
    signal A_tb, B_tb, Sum_tb : STD_LOGIC_VECTOR(1 downto 0);
    signal Cin_tb : STD_LOGIC := '1';
    signal Cout_tb: STD_LOGIC;
    signal led_status_switch_tb : STD_LOGIC_VECTOR(2 downto 0);
begin
    dut : entity WORK.Adder2Bit(Behavioural)
        port map (A=>A_tb, B=>B_tb, Cin=>Cin_tb, Cout=>Cout_tb, Sum=>Sum_tb, led_status_switch => led_status_switch_tb);
    stimulus : process
    begin
             Cin_tb <= not Cin_tb;
        for i in 0 to 3 loop
            B_tb <= std_logic_vector(to_unsigned(i, 2));
            for j in 0 to 3 loop
                A_tb <= std_logic_vector(to_unsigned(j, 2));
                wait for 20ns; 
            end loop;
         end loop;   
    end process stimulus;
end architecture tb_behaviour;