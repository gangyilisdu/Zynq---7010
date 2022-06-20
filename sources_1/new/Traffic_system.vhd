library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;

entity Traffic_system is
    Port(clk : in std_logic;
         reset : in std_logic;
         direction_select : in std_logic;
         mode_switch : in std_logic;
         car_detector : in std_logic_vector(1 downto 0);
         illegal_car_detector : in std_logic_vector(1 downto 0);
         external_camera : out std_logic_vector(1 downto 0); 
         traffic_lights : out std_logic_vector(2 downto 0);
         state_signal : out std_logic_vector(1 downto 0);  
         select_segment : out std_logic;
         display_sum : out std_logic_vector(6 downto 0);
         KeyPad_Row : inout std_logic_vector(3 downto 0);
         KeyPad_Col : inout std_logic_vector(3 downto 0)
         );
end entity; 

architecture behaviour of Traffic_system is
    type stateType is (idle, EW_Red_NS_Green, EW_Red_NS_Yellow, EW_Yellow_NS_Red, EW_Green_NS_Red);
    signal current_state, next_state : stateType;  
    signal clk_1Hz : std_logic; 
    signal clk_1000Hz : std_logic;
    signal count : integer := 1;
    signal Decode: STD_LOGIC_VECTOR (3 downto 0);
    signal pedestrian_crosswalk_EW : std_logic;
    signal pedestrian_crosswalk_NS : std_logic;
    constant delay20s : natural := 20;
    constant delay2s : natural := 2; 
    component clk_divider is
        Port( clk_in : in std_logic;
              clk_out : out std_logic);
    end component;
    component clk_divider_1000Hz is
        Port( clk_in : in std_logic;
              clk_out : out std_logic);
    end component;
    component Decoder is
	Port (
			 clk : in  STD_LOGIC;
          Row : in  STD_LOGIC_VECTOR (3 downto 0);
			 Col : out  STD_LOGIC_VECTOR (3 downto 0);
          DecodeOut : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;
begin 
    label_clk_divider_1hz : clk_divider port map (clk_in => clk, clk_out => clk_1Hz);
    label_clk_divider_1000hz : clk_divider_1000hz port map (clk_in => clk, clk_out => clk_1000Hz);
    C0: Decoder port map (clk=>clk, Row =>KeyPad_Row, Col=>KeyPad_Col, DecodeOut=> Decode);
    normal_and_night_modes_change : process(reset, clk_1Hz, mode_switch, car_detector, current_state) is 
    begin 
    if reset = '1' then
        current_state <= idle;
    elsif clk_1Hz'event and clk_1Hz = '1' then
        case current_state is     
            when idle =>
                current_state <= EW_Green_NS_Red;
            
            when EW_Green_NS_Red =>  
            if (mode_switch = '0') then     
                if(count = delay20s) then
                    count <= 1;
                    current_state <= EW_Yellow_NS_Red;             
                else
                    count <= count + 1; 
                    current_state <= EW_Green_NS_Red;
               end if;    
            else      
                if (car_detector = "01") then
                    current_state <= EW_Yellow_NS_Red;
                elsif (car_detector = "11") then
                    if(count = delay2s) then
                        count <= 1;
                        current_state <= EW_Yellow_NS_Red;             
                    else
                        count <= count + 1; 
                        current_state <= EW_Green_NS_Red;
                    end if;
                else 
                    current_state <= EW_Green_NS_Red; 
                end if; 
            end if;
         
            when EW_Yellow_NS_Red =>    
                if(mode_switch = '0') then                  
                    if (count = delay2s) then
                        count <= 1; 
                        current_state <= EW_Red_NS_Green;
                    else
                        count <= count + 1; 
                        current_state <= EW_Yellow_NS_Red;
                    end if;
                else
                    current_state <= EW_Red_NS_Green; 
               end if;
                     
            when EW_Red_NS_Green =>
                if (mode_switch = '0') then
                    if (count = delay20s) then
                       count <= 1; 
                       current_state <= EW_Red_NS_Yellow;
                    else
                        count <= count + 1; 
                        current_state <= EW_Red_NS_Green;
                    end if;
                else
                    if (car_detector = "10") then
                        current_state <= EW_Red_NS_Yellow;
                    elsif (car_detector = "11") then
                        if(count = delay2s) then
                            count <= 1;
                            current_state <= EW_Red_NS_Yellow;             
                        else
                            count <= count + 1; 
                            current_state <= EW_Red_NS_Green;
                        end if; 
                    else
                        current_state <= EW_Red_NS_Green; 
                    end if; 
                end if;

            when EW_Red_NS_Yellow =>  
                if(mode_switch = '0') then
                    if (count = delay2s) then
                        count <= 1; 
                        current_state <= EW_Green_NS_Red;
                    else
                        count <= count + 1; 
                        current_state <= EW_Red_NS_Yellow;
                    end if;
               else
                    current_state <= EW_Green_NS_Red; 
              end if;    
        end case; 
     end if;
    end process; 
    
    light_switch_and_camera_detector : process(current_state, direction_select, illegal_car_detector) is  
    begin 
        case(current_state) is
            when idle =>
            traffic_lights <= "000";
            external_camera <= "00";
            state_signal <= "--";
            
            when EW_Green_NS_Red =>  state_signal <= "00";
            if(illegal_car_detector(0) = '1') then
                external_camera <= "01";
            else
                external_camera <= "00";
            end if;
            if(direction_select = '1') then
                traffic_lights <= "100";
            else
                traffic_lights <= "010";
            end if; 
            
            when EW_Yellow_NS_Red =>  state_signal <= "01";
            if(illegal_car_detector(0) = '1') then
                external_camera <= "01";
            else
                external_camera <= "00";
            end if;
            if(direction_select = '1') then
                traffic_lights <= "100";
            else
                traffic_lights <= "001";
            end if;  
            
            when EW_Red_NS_Green => state_signal <= "10";
            if(illegal_car_detector(1) = '1') then
                external_camera <= "10";
            else
                external_camera <= "00";
            end if;
            if(direction_select = '1') then
                traffic_lights <= "010";
            else
                traffic_lights <= "100";
            end if;  
            
            when EW_Red_NS_Yellow =>  state_signal <= "11";
            if(illegal_car_detector(1) = '1') then
                external_camera <= "10";
            else
                external_camera <= "00";
            end if;
            if(direction_select = '1') then
                    traffic_lights <= "001";
            else
                    traffic_lights <= "100";
            end if; 
        end case;
    end process; 
    
     
    Segment_show_right : process(clk, Decode, count, current_state, pedestrian_crosswalk_EW) is 
    begin
    if (clk_1000Hz = '1') then 
        select_segment <= '0';
        if Decode = "1111" then
        case(current_state) is 
            when idle =>
               display_sum <= "0000000";
            when EW_Green_NS_Red => 
                if (count = 1) then
                    display_sum <= "1111111"; 
                elsif (count = 2) then
                    display_sum <= "0000111";
                elsif (count = 3) then
                    display_sum <= "1111101";
                elsif (count = 4) then
                    display_sum <= "1101101";
                elsif (count = 5) then
                    display_sum <= "1100110";
                elsif (count = 6) then
                    display_sum <= "1001111";
                elsif (count = 7) then
                    display_sum <= "1011011";
                elsif (count = 8) then
                    display_sum <= "0000110";
                elsif (count = 9) then
                    display_sum <= "0111111";
                else
                    display_sum <= "0000000";
                end if;
                     
            when EW_Yellow_NS_Red => 
                if (count = 1) then
                    display_sum <= "0000110";
                elsif (count = 2) then  
                    display_sum <= "0111111";
                else
                    display_sum <= "0000000";
                end if;
        
            when EW_Red_NS_Green => 
                if (count = 1) then
                    display_sum <= "1111111"; 
                elsif (count = 2) then
                    display_sum <= "0000111";
                elsif (count = 3) then
                    display_sum <= "1111101";
                elsif (count = 4) then
                    display_sum <= "1101101";
                elsif (count = 5) then
                    display_sum <= "1100110";
                elsif (count = 6) then
                    display_sum <= "1001111";
                elsif (count = 7) then
                    display_sum <= "1011011";
                elsif (count = 8) then
                    display_sum <= "0000110";
                elsif (count = 9) then
                    display_sum <= "0111111";
                else
                    display_sum <= "0000000";
                end if;
        
            when EW_Red_NS_Yellow => 
                if (count = 1) then
                    display_sum <= "0000110";
                elsif (count = 2) then  
                    display_sum <= "0111111";
                else
                    display_sum <= "0000000";
                end if;
            end case;
        elsif  Decode = "0111" then
           if(pedestrian_crosswalk_EW = '0') then
                display_sum <= "0111111";
           else
                display_sum <= "0000110";
           end if;
        else
            display_sum <= "0000000";
        end if;  
    elsif(clk_1000Hz = '0') then
        select_segment <= '1';
        if Decode = "1111" then
        case(current_state) is 
            when idle =>
               display_sum <= "0000000";
            when EW_Green_NS_Red => 
                display_sum <= "0111111";   
            when EW_Yellow_NS_Red => 
                display_sum <= "0000110"; 
            when EW_Red_NS_Green => 
                display_sum <= "1011011";      
            when EW_Red_NS_Yellow => 
                display_sum <= "1001111";
            end case;
              
        elsif  Decode = "0111" then
           if(pedestrian_crosswalk_NS = '0') then
                display_sum <= "0111111";
           else
                display_sum <= "0000110";
           end if;
        end if;  
    end if;
    end process; 
    
     
    pedestrian_signal : process(current_state) is
    begin
         case(current_state) is 
            when idle =>
                pedestrian_crosswalk_EW <= '0';
                pedestrian_crosswalk_NS <= '0';
            
            when EW_Green_NS_Red =>
                pedestrian_crosswalk_EW <= '1';
                pedestrian_crosswalk_NS <= '0';
                
            when EW_Yellow_NS_Red =>
                pedestrian_crosswalk_EW <= '0';
                pedestrian_crosswalk_NS <= '0';
            when EW_Red_NS_Green => 
                pedestrian_crosswalk_EW <= '0';
                pedestrian_crosswalk_NS <= '1';
            when EW_Red_NS_Yellow => 
                pedestrian_crosswalk_EW <= '0';
                pedestrian_crosswalk_NS <= '0';
                
        end case; 
    end process; 
end architecture; 