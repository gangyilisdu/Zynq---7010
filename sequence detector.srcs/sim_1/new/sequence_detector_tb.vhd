library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 

entity tb_sequence_detector is 
end entity;

architecture tb_behaviour of tb_sequence_detector is
    component sequence_detector
        Port(clk : in std_logic;
          reset : in std_logic;
          din : in std_logic;
          dout : out std_logic);
    end component;
    signal din_tb : std_logic := '0';
    signal clk_tb : std_logic := '0'; 
    signal reset_tb : std_logic := '0';
    signal dout_tb : std_logic := '0'; 
    constant clock_period_tb : time := 10ns; 
begin
    sd : sequence_detector port map(din=>din_tb, clk=>clk_tb, reset=>reset_tb, dout=>dout_tb);
    clock : process
    begin
        clk_tb <= '0';
        wait for clock_period_tb/2;
        clk_tb <= '1';
        wait for clock_period_tb/2;
    end process;
    
    stimulus : process
    begin
        reset_tb <= '1';
        wait for 10ns;
        reset_tb <= '0';
        din_tb <= '1';
        wait for 10ns;
        din_tb <= '1';
        wait for 10ns;
        din_tb <= '1';
        wait for 10ns;
        din_tb <= '0';
        wait for 10ns; 
        din_tb <= '0';
        wait for 10ns; 
        din_tb <= '1';
        wait for 10ns;
        din_tb <= '0';
        wait for 10ns; 
        din_tb <= '1';  
        wait for 10ns; 
        din_tb <= '1';
        wait for 10ns;
        din_tb <= '0';
        wait for 10ns; 
        din_tb <= '1';  
        wait for 10ns; 
        din_tb <= '1';
        wait for 10ns;
        din_tb <= '0';
        wait for 10ns; 
        din_tb <= '1';  
        wait for 10ns; 
        din_tb <= '0';
        wait for 10ns;
        din_tb <= '1';
        wait for 10ns; 
        din_tb <= '1';
        wait for 10ns; 
        din_tb <= '0';
        wait for 10ns;
        din_tb <= '0';
        wait for 10ns; 
        din_tb <= '1';
        wait for 10ns;
        din_tb <= '1';
        wait for 10ns; 
        din_tb <= '1';
        wait for 10ns;
    end process stimulus; 
end architecture tb_behaviour;