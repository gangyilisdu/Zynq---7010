----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Shyama Gandhi
-- 
-- Create Date: 07/29/2020 08:32:34 AM
-- Design Name: 
-- Module Name: bcd_tb - Behavioral
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
use ieee.numeric_std.all;


entity bcd_tb is

end bcd_tb;

architecture behavioral of bcd_tb is
    --Include Components
    component bcd_counter
    Port ( clk : in STD_LOGIC;
           dir : in STD_LOGIC;
           reset : in STD_LOGIC;
           led_out : out STD_LOGIC_VECTOR(3 downto 0));
    end component;

    component clk_divider is
    Port ( clk_in : in STD_LOGIC;
           clk_out : out STD_LOGIC);
    end component;
    
    --Input Signals
    signal clk_in_tb: std_logic :='0';
    signal reset_tb: std_logic :='0';
    signal dir_tb:   std_logic :='1';
    signal load_tb:  std_logic :='0';
    signal count_in: std_logic_vector(3 downto 0) := (others=>'0');
 
    --Output Signal
    signal led_tb: std_logic_vector(3 downto 0);
    signal clk_out_tb: std_logic :='0';
   
   --Clock period definition
   constant clock_period_tb: time:=40ns;   --1/25MHz => 40ns

begin
    --Instantiate components
    count1:
        bcd_counter port map(
            clk => clk_in_tb,
            dir => dir_tb,
            reset => reset_tb,
            led_out => led_tb
        );
    divider: 
        clk_divider port map(   
             clk_in=>clk_in_tb,
             clk_out=>clk_out_tb
         );
         
----Clock process
    clock: 
        process
        begin
            clk_in_tb <='0';
            wait for clock_period_tb/2;
            clk_in_tb <='1';
            wait for clock_period_tb/2;
        end process;

----Stimulus process                
        process
        begin
            reset_tb <= '1' ;  -- Reset the device under test and setup input to starting state
            Wait for 40 ns; -- Wait one clock period for our device to reset
            reset_tb <= '0' ;
            dir_tb <= '1' ; -- this for up counting in the BCD Counter
            -- Clock = 40ns * 2 = 80ns and the total number of counts = 10 so 10 * 80ns = 800ns atleast to see the whole range from 0 to 10.
            
            wait for 1000ns;
            
            dir_tb <= '0';
            wait for 500ns;
            
            --Asserts are followed by REPORT statement that prints a string report and then followed by severity clauses. ASSERT statements will check for a condition and upon failure of the condition
            --it will report a state.
            --Severity clause will tell you how serious the failed condition is.
            
            ASSERT(led_tb = "1001") -- set the value to 00 and nothing will
                REPORT "not zero" -- appear in the tcl console window
                SEVERITY NOTE;
            
        end process;

end Behavioral;
