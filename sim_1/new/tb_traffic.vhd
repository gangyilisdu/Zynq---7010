library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 

entity tb_traffic is 
end entity; 

architecture tb_behaviour of tb_traffic is 
    component Traffic_system is
    Port(clk : in std_logic;
         reset : in std_logic;
         direction_select : in std_logic;
         mode_switch : in std_logic;
         car_detector : in std_logic_vector(1 downto 0);
         illegal_car_detector : in std_logic_vector(1 downto 0);
         external_camera : out std_logic_vector(1 downto 0); 
         traffic_lights : out std_logic_vector(2 downto 0);
         state_signal : out std_logic_vector(1 downto 0)
         );
    end component;
    
    component clk_divider 
           Port ( clk_in : in STD_LOGIC;
           clk_out : out STD_LOGIC);
    end component;
    signal clk_in_tb : std_logic;
    signal clk_out_tb : std_logic; 
    signal reset_tb : std_logic;
    signal direction_select_tb : std_logic; 
    signal mode_switch_tb : std_logic;
    signal car_detector_tb : std_logic_vector(1 downto 0);
    signal illegal_car_detector_tb : std_logic_vector(1 downto 0);
    signal external_camera_tb : std_logic_vector(1 downto 0);
    signal traffic_lights_tb : std_logic_vector(2 downto 0); 
    signal state_signal_tb : std_logic_vector(1 downto 0);  
    constant clock_period_tb : time := 1ns;
begin
    vending_tb : Traffic_system port map(clk => clk_in_tb, reset => reset_tb, direction_select => direction_select_tb, 
                                   mode_switch => mode_switch_tb, car_detector => car_detector_tb, illegal_car_detector => illegal_car_detector_tb, 
                                  external_camera => external_camera_tb, traffic_lights => traffic_lights_tb, state_signal => state_signal_tb);
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
        wait for 2ns;        
        reset_tb <= '0';
        mode_switch_tb <= '1';
        direction_select_tb <= '0';
        car_detector_tb <= "00";
        illegal_car_detector_tb <= "00";
        wait for 40ns;
        car_detector_tb <= "01";
        wait for 15ns;
        car_detector_tb <= "10";
        illegal_car_detector_tb <= "10";
        wait for 6ns;
        car_detector_tb <= "00";
        illegal_car_detector_tb <= "00";
        wait for 20ns;
        direction_select_tb <= '1';
        car_detector_tb <= "00";
        illegal_car_detector_tb <= "00";
        wait for 40ns;
        car_detector_tb <= "01";
        wait for 15ns;
        car_detector_tb <= "10";
        illegal_car_detector_tb <= "10";
        wait for 6ns;
        car_detector_tb <= "00";
        illegal_car_detector_tb <= "00";
        wait for 20ns;
        
    end process;
end architecture;
