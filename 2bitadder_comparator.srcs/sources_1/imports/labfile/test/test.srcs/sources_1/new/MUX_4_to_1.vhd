----------------------------------------------------------------------------------
-- Company: University of Alberta
-- Engineer: Gangyi Li
-- 
-- Create Date: 10/11/2021 01:29:44 PM
-- Design Name: 4_to_1_MUX
-- Module Name: MUX_4_to_1 - Behavioral
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

entity MUX_4_to_1 is
    Port ( S : in STD_LOGIC_VECTOR(1 downto 0);
           d : in STD_LOGIC_VECTOR(3 downto 0);
           Y : out STD_LOGIC);
end MUX_4_to_1;

architecture Behavioral of MUX_4_to_1 is

begin
    CASE_PRO: process(d,S)is
    begin
        case S is
            when "00"=> Y<= d(0);
            when "01"=> Y<= d(1);
            when "10"=> Y<= d(2);
            when "11"=> Y<= d(3);
            when others => null;
        end case;
    end process;
end Behavioral;