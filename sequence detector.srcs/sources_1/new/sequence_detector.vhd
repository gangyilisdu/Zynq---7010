library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sequence_detector is
    Port( clk : in std_logic;
          reset : in std_logic;
          din : in std_logic;
          dout : out std_logic);
end entity sequence_detector;

architecture behaveiour of sequence_detector is
    type stateType is (idle, A_state, B_state, C_state, D_state);
    signal current_state, next_state : stateType;  

begin 
    com : process(din, current_state) is
    begin
        case current_state is 
            when idle =>
                if(din = '0') then
                    next_state <= A_state; 
                    dout <= '0';
                else
                    next_state <= idle; 
                    dout <= '0';
                end if; 
            
            when A_state =>
                if(din = '1') then
                    next_state <= B_state; 
                    dout <= '0';
                else 
                    next_state <= A_state; 
                    dout <= '0';
                end if; 
            
            when B_state =>
                if(din = '1') then 
                    next_state <= C_state; 
                    dout <= '0';
                else 
                    next_state <= A_state;
                    dout <= '0';
                end if;
            
            when C_state => 
                if(din = '0') then
                    next_state <= D_state; 
                    dout <= '0';
                else 
                    next_state <= idle;
                    dout <= '0'; 
                end if; 
            
            when D_state =>
                if(din = '1') then
                    next_state <= B_state;
                    dout <= '1'; 
                else 
                    next_state <= A_state; 
                    dout <= '0';
                end if; 
        end case;
    end process com;     
    
    seq : process(reset, clk) is 
    begin
        if reset = '1' then
            current_state <= idle;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;  
    end process seq; 
end architecture;  
