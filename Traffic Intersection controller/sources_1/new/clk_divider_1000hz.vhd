library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL; 


entity clk_divider_1000Hz is
    Port ( clk_in : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end clk_divider_1000Hz;

architecture Behavioral of clk_divider_1000Hz is
signal clock_out : std_logic := '0';
signal count : integer := 1;
begin
    process(clk_in, clock_out)
    begin
        if clk_in='1' and clk_in'event then
            count <= count + 1;
            if(count = 62500) then                  
                clock_out <= NOT clock_out;
                count <= 1;
            end if;
        end if;            
    clk_out <= clock_out;
    end process;
end Behavioral;
