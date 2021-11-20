set_property -dict {PACKAGE_PIN K17 IOSTANDARD LVCMOS33} [get_ports { clk }];
create_clock -period 64.000 -name sys_clk_pin -waveform {0.000 32.000} -add [get_ports { clk }];

set_property -dict { PACKAGE_PIN K18   IOSTANDARD LVCMOS33 } [get_ports { reset }];

set_property -dict {PACKAGE_PIN P15    IOSTANDARD LVCMOS33} [ get_ports { coins_in[0] }]; 
set_property -dict { PACKAGE_PIN W13   IOSTANDARD LVCMOS33 } [get_ports { coins_in[1] }]; 
set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS33 } [get_ports { item_sel }]; 

set_property -dict {PACKAGE_PIN G14 IOSTANDARD LVCMOS33} [get_ports { change_out[0] }];
set_property -dict {PACKAGE_PIN D18 IOSTANDARD LVCMOS33} [get_ports { change_out[1] }];

set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33     } [get_ports { display_sum[0] }]; 
set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS33     } [get_ports { display_sum[1] }]; 
set_property -dict { PACKAGE_PIN T11   IOSTANDARD LVCMOS33     } [get_ports { display_sum[2] }]; 
set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33     } [get_ports { display_sum[3] }]; 
set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS33     } [get_ports { display_sum[4] }]; 
set_property -dict { PACKAGE_PIN T15   IOSTANDARD LVCMOS33     } [get_ports { display_sum[5] }]; 
set_property -dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33     } [get_ports { display_sum[6] }];
set_property -dict { PACKAGE_PIN R14   IOSTANDARD LVCMOS33} [get_ports { select_segment }];

set_property -dict {PACKAGE_PIN M14 IOSTANDARD LVCMOS33} [get_ports { chips }];
set_property -dict {PACKAGE_PIN M15 IOSTANDARD LVCMOS33} [get_ports { chocolates }];