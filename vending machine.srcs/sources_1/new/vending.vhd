library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vending is
    Port( clk : in std_logic;
          reset : in std_Logic;
          item_sel : in std_logic;
          coins_in : in std_logic_vector(1 downto 0);
          change_out : out std_logic_vector(1 downto 0);
          display_sum : out std_logic_vector(6 downto 0);
          select_segment : out std_logic;
          chips : out std_logic; 
          chocolates : out std_logic);
end entity vending;

architecture behaviour of vending is
    type stateType is (idle, Chip_state, a1, a2, a3, Chocolate_state, s1, s2, change_state, Products_out);
    signal current_state, next_state : stateType;
    signal clk_out_component : std_logic; 
    component clk_divider is 
        Port( clk_in : in std_logic;
              clk_out : out std_logic);
    end component;
begin
    label_clk_divider : clk_divider port map(clk_in => clk, clk_out => clk_out_component);
    select_segment <= '1'; 
    com : process(item_sel, coins_in, current_state) is 
    begin
        case current_state is
            when idle =>
                chips <= '0'; chocolates <= '0';
                display_sum <= "0111111";
                if(item_sel = '1') then
                    next_state <= Chip_state;
                    change_out <= "00"; 
                else
                    next_state <= Chocolate_state;
                    change_out <= "00"; 
                end if;
                
            when Chip_state => 
                if(coins_in = "00") then
                    next_state <= Chip_state;
                    change_out <= "00"; 
                    display_sum <= "0111111";
                    chips <= '0'; chocolates <= '0';
                elsif (coins_in = "01") then
                    next_state <= a1; 
                    change_out <= "00"; 
                    display_sum <= "0000110";
                    chips <= '0'; chocolates <= '0';
                elsif (coins_in = "10") then
                    next_state <= a2; 
                    change_out <= "00"; 
                    display_sum <= "1011011";
                    chips <= '0'; chocolates <= '0';
                else
                    next_state <= Products_out;
                    change_out <= "01"; 
                    display_sum <= "1101101";
                end if; 
            
            when a1 => 
                if(coins_in = "00") then
                    next_state <= a1;
                    change_out <= "00"; 
                    display_sum <= "0000110";
                    chips <= '0'; chocolates <= '0';
                elsif (coins_in = "01") then
                    next_state <= a2; 
                    change_out <= "00"; 
                    display_sum <= "1011011";
                    chips <= '0'; chocolates <= '0';
                elsif (coins_in = "10") then
                    next_state <= a3; 
                    change_out <= "00"; 
                    display_sum <= "1001111";
                    chips <= '0'; chocolates <= '0';
                else
                    next_state <= Products_out;
                    change_out <= "10"; 
                    display_sum <= "1111101";
                end if; 
            
            when a2 =>
                if(coins_in = "00") then
                    next_state <= a2;
                    change_out <= "00"; 
                    display_sum <= "1011011";
                    chips <= '0'; chocolates <= '0';            
                elsif (coins_in = "01") then
                    next_state <= a3;
                    change_out <= "00"; 
                    display_sum <= "1001111";
                    chips <= '0'; chocolates <= '0';
                elsif (coins_in = "10") then
                    next_state <= Products_out; 
                    change_out <= "00"; 
                    display_sum <= "1100110";
                else
                    next_state <= change_state;
                    change_out <= "01";
                    display_sum <= "0000111";
                end if; 
             
            when a3 =>
                if(coins_in = "00") then
                    next_state <= a3;
                    change_out <= "00"; 
                    display_sum <= "1001111";
                    chips <= '0'; chocolates <= '0';
                elsif (coins_in = "01") then
                    next_state <= Products_out;
                    change_out <= "00"; 
                    display_sum <= "1100110";
                elsif (coins_in = "10") then
                    next_state <= Products_out; 
                    change_out <= "01"; 
                    display_sum <= "1101101";
                else
                    next_state <= change_state;
                    change_out <= "10";
                    display_sum <= "1111111";
                end if; 
                
            when Chocolate_state =>
                if(coins_in = "00") then
                    next_state <= Chocolate_state;
                    change_out <= "00"; 
                    display_sum <= "0111111";
                    chips <= '0'; chocolates <= '0';
                elsif (coins_in = "01") then
                    next_state <= s1;
                    change_out <= "00"; 
                    display_sum <= "0000110";
                    chips <= '0'; chocolates <= '0';
                elsif (coins_in = "10") then
                    next_state <= s2; 
                    change_out <= "00"; 
                    display_sum <= "1011011";
                    chips <= '0'; chocolates <= '0';
                else
                    next_state <= Products_out;
                    change_out <= "10";
                    display_sum <= "1101101";
                end if; 
                
            when s1 =>
                if(coins_in = "00") then
                    next_state <= s1;
                    change_out <= "00"; 
                    display_sum <= "0000110";
                    chips <= '0'; chocolates <= '0';
                elsif (coins_in = "01") then
                    next_state <= s2;
                    change_out <= "00"; 
                    display_sum <= "1011011";
                    chips <= '0'; chocolates <= '0';
                elsif (coins_in = "10") then
                    next_state <= Products_out; 
                    change_out <= "00"; 
                    display_sum <= "1001111";
                else
                    next_state <= change_state;
                    change_out <= "01";
                    display_sum <= "1111101";
                end if; 
                
            when s2 =>
                if(coins_in = "00") then
                    next_state <= s2;
                    change_out <= "00"; 
                    display_sum <= "1011011";
                    chips <= '0'; chocolates <= '0';
                elsif (coins_in = "01") then
                    next_state <= Products_out;
                    change_out <= "00"; 
                    display_sum <= "1001111";
                elsif (coins_in = "10") then
                    next_state <= Products_out; 
                    change_out <= "01"; 
                    display_sum <= "1100110";
                else
                    next_state <= change_state;
                    change_out <= "10";
                    display_sum <= "0000111";
                end if; 
                
            when change_state =>
                    change_out <= "10";
                    display_sum <= "0111111";
                    next_state <= Products_out; 
            
            when Products_out =>
                change_out <= "00";
                display_sum <= "0111111";
                if(item_sel = '1') then
                    chips <= '1';
                    chocolates <= '0';
                else
                    chips <= '0';
                    chocolates <= '1';
                end if; 
                next_state <= idle; 
        end case;
    end process com; 
    
    seq : process(reset, clk_out_component) is 
    begin
        if reset = '1' then
            current_state <= idle;
        elsif rising_edge(clk_out_component) then
            current_state <= next_state;
        end if;  
    end process seq; 
end architecture behaviour;  