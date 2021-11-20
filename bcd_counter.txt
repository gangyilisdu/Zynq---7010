----------------------------------------------------------------------------------
-- Company: 
-- Engineer: SHYAMA GANDHI
-- 
-- Create Date: 07/17/2020 08:45:47 PM
-- Design Name: 
-- Module Name: bcd_counter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bcd_counter is
    Port ( clk : in STD_LOGIC;
           dir : in STD_LOGIC;
           reset : in STD_LOGIC;
           led_out : out STD_LOGIC_VECTOR(3 downto 0));
end bcd_counter;

architecture Behavioral of bcd_counter is

component clk_divider is 
    Port ( clk_in : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end component;

    signal temp : std_logic_vector(3 downto 0) := "0000";
    signal clk_out_component : std_logic;  
begin
    label_clk_divider: clk_divider port map(clk_in => clk, clk_out => clk_out_component);   
process_0: process(clk_out_component,reset)
    begin
        if reset='1' then
            temp <= "0000";
        elsif(rising_edge(clk_out_component))then
            if(dir='1')then
                if(temp ="1001")then
                    temp <= "0000";
                else
                    temp <= temp + 1;
                end if;
            else
                if(temp="0000")then
                    temp <= "1001";
                else
                    temp <= temp - 1;
                end if;
            end if;
            led_out <= temp;        
        end if;
        
end process;
end Behavioral;
