----------------------------------------------------------------------------------
-- Company: University of Alberta
-- Engineer: Gangyi Li
-- 
-- Create Date: 10/11/2021 01:40:06 PM
-- Design Name: 16_to_1_MUX
-- Module Name: MUX_16_to_1 - Behavioral
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

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity MUX_16_to_1 is
    port(d:in std_logic_vector(15 downto 0);
         s:in std_logic_vector(3 downto 0);
         y:out std_logic);
end MUX_16_to_1;

architecture behavioural of MUX_16_to_1 is
component mux_4_to_1 is
    port(d:in std_logic_vector(3 downto 0);
         s:in std_logic_vector(1 downto 0);
         y:out std_logic);
end component; 
signal x:std_logic_vector(3 downto 0);
begin 
    a2:for i in 0 to 3 generate
    ai:mux_4_to_1 port map(d((((i)*4)+3) downto (i*4)),s(1 downto 0),x(i));
end generate;
    a5:mux_4_to_1 port map(x(3 downto 0),s(3 downto 2),y);
end behavioural;