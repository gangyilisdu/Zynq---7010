set_property -dict {PACKAGE_PIN K17 IOSTANDARD LVCMOS33} [get_ports { clk }];
create_clock -period 8.000 -name sys_clk_pin -waveform {0.000 4.000} -add [get_ports clk];

set_property -dict { PACKAGE_PIN K18   IOSTANDARD LVCMOS33 } [get_ports { direction_select }]; #IO_L12N_T1_MRCC_35 Sch=btn[0]
set_property -dict { PACKAGE_PIN P16   IOSTANDARD LVCMOS33 } [get_ports { reset }]; #IO_L24N_T3_34 Sch=btn[1]
set_property -dict { PACKAGE_PIN K19   IOSTANDARD LVCMOS33 } [get_ports { illegal_car_detector[1] }]; #IO_L10P_T1_AD11P_35 Sch=btn[2]
set_property -dict {PACKAGE_PIN Y16 IOSTANDARD LVCMOS33} [get_ports { illegal_car_detector[0] }];

set_property -dict {PACKAGE_PIN G15 IOSTANDARD LVCMOS33} [get_ports { car_detector[1] }];
set_property -dict {PACKAGE_PIN P15 IOSTANDARD LVCMOS33} [get_ports { car_detector[0] }];
set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS33 } [get_ports { mode_switch }]; #IO_L9P_T1_DQS_34 Sch=sw[3]

set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports { traffic_lights[2] }]; #IO_L18P_T2_34 Sch=led6_r
set_property -dict { PACKAGE_PIN F17   IOSTANDARD LVCMOS33 } [get_ports { traffic_lights[1] }]; #IO_L6N_T0_VREF_35 Sch=led6_g
set_property -dict { PACKAGE_PIN M17   IOSTANDARD LVCMOS33 } [get_ports { traffic_lights[0] }]; #IO_L8P_T1_AD10P_35 Sch=led6_b

set_property -dict {PACKAGE_PIN M14 IOSTANDARD LVCMOS33} [get_ports {state_signal[0]}];#led0
set_property -dict {PACKAGE_PIN M15 IOSTANDARD LVCMOS33} [get_ports {state_signal[1]}];#led1
set_property -dict {PACKAGE_PIN G14 IOSTANDARD LVCMOS33} [get_ports {external_camera[1]}];#led2
set_property -dict {PACKAGE_PIN D18 IOSTANDARD LVCMOS33} [get_ports {external_camera[0]}];#led3

set_property -dict {PACKAGE_PIN V15 IOSTANDARD LVCMOS33} [get_ports { display_sum[0] }]; 
set_property -dict {PACKAGE_PIN W15 IOSTANDARD LVCMOS33} [get_ports { display_sum[1] }]; 
set_property -dict {PACKAGE_PIN T11 IOSTANDARD LVCMOS33} [get_ports { display_sum[2] }]; 
set_property -dict {PACKAGE_PIN T10 IOSTANDARD LVCMOS33} [get_ports { display_sum[3] }]; 
set_property -dict {PACKAGE_PIN T14 IOSTANDARD LVCMOS33} [get_ports { display_sum[4] }]; 
set_property -dict {PACKAGE_PIN T15 IOSTANDARD LVCMOS33} [get_ports { display_sum[5] }]; 
set_property -dict {PACKAGE_PIN P14 IOSTANDARD LVCMOS33} [get_ports { display_sum[6] }];
set_property -dict {PACKAGE_PIN R14 IOSTANDARD LVCMOS33} [get_ports { select_segment }];


set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { KeyPad_Row[0] }]; #IO_L4P_T0_34 Sch=je[1]
set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS33 } [get_ports { KeyPad_Row[1] }]; #IO_L18N_T2_34 Sch=je[2]
set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { KeyPad_Row[2] }]; #IO_25_35 Sch=je[3]
set_property -dict { PACKAGE_PIN H15   IOSTANDARD LVCMOS33 } [get_ports { KeyPad_Row[3] }]; #IO_L19P_T3_35 Sch=je[4]
set_property -dict { PACKAGE_PIN V13   IOSTANDARD LVCMOS33 } [get_ports { KeyPad_Col[0] }]; #IO_L3N_T0_DQS_34 Sch=je[7]
set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports { KeyPad_Col[1] }]; #IO_L9N_T1_DQS_34 Sch=je[8]
set_property -dict { PACKAGE_PIN T17   IOSTANDARD LVCMOS33 } [get_ports { KeyPad_Col[2] }]; #IO_L20P_T3_34 Sch=je[9]
set_property -dict { PACKAGE_PIN Y17   IOSTANDARD LVCMOS33 } [get_ports { KeyPad_Col[3] }]; #IO_L7N_T1_34 Sch=je[10]



