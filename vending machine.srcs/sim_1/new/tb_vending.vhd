library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 

entity tb_vending is 
end entity; 

architecture tb_behaviour of tb_vending is 
    component vending
        Port( clk : in std_logic;
          reset : in std_Logic;
          item_sel : in std_logic;
          coins_in : in std_logic_vector(1 downto 0);
          change_out : out std_logic_vector(1 downto 0);
          display_sum : out std_logic_vector(6 downto 0);
          select_segment : out std_logic;
          chips : out std_logic; 
          chocolates : out std_logic);
    end component;
    
    component clk_divider 
           Port ( clk_in : in STD_LOGIC;
           clk_out : out STD_LOGIC);
    end component;
    signal clk_in_tb : std_logic;
    signal clk_out_tb : std_logic; 
    signal reset_tb : std_logic := '0';
    signal item_sel_tb : std_logic := '1'; 
    signal coins_in_tb : std_logic_vector(1 downto 0) := "00";
    signal display_sum_tb : std_logic_vector(6 downto 0) := "0000000";
    signal change_out_tb : std_logic_vector(1 downto 0) := "00";
    signal select_segment_tb : std_logic;
    signal chips_tb : std_logic; 
    signal chocolates_tb : std_logic;  
    constant clock_period_tb : time := 20ns;
begin
    vending_tb : vending port map(clk => clk_in_tb, reset => reset_tb, item_sel => item_sel_tb, 
                        coins_in => coins_in_tb, change_out => change_out_tb, display_sum => display_sum_tb, 
                        select_segment => select_segment_tb, chips => chips_tb, chocolates => chocolates_tb);
    divider : clk_divider port map(clk_in => clk_in_tb, clk_out => clk_out_tb);
    
    clock : process
    begin
        clk_in_tb <= '0';
        wait for clock_period_tb/2;
        clk_in_tb <= '1';
        wait for clock_period_tb/2;
    end process;
    
    stimulus : process
    begin
        reset_tb <= '1';
        wait for 40ns;        
        reset_tb <= '0';
        item_sel_tb <= not item_sel_tb; 
        wait for 40ns; 
        coins_in_tb <= "01";
        wait for 40ns;
        coins_in_tb <= "10";
        wait for 40ns;
        coins_in_tb <= "11";
        wait for 40ns;
        coins_in_tb <= "10";
        wait for 40ns;
        coins_in_tb <= "10";
        wait for 40ns;
        coins_in_tb <= "10";
        wait for 40ns;
        coins_in_tb <= "11";
        wait for 40ns;  
    end process;
end architecture; 