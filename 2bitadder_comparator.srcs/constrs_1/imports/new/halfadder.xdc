set_property -dict {PACKAGE_PIN K18 IOSTANDARD LVCMOS33} [get_ports { A[0] }]; #A[0]=btn[0]
set_property -dict {PACKAGE_PIN D18 IOSTANDARD LVCMOS33} [get_ports { A0_show }]
set_property -dict {PACKAGE_PIN P16 IOSTANDARD LVCMOS33} [get_ports { A[1] }]; #A[1]=btn[1]
set_property -dict {PACKAGE_PIN K19 IOSTANDARD LVCMOS33} [get_ports { B[0] }]; #B[0]=btn[2]
set_property -dict {PACKAGE_PIN Y16 IOSTANDARD LVCMOS33} [get_ports { B[1] }]; #B[1]=btn[3]
set_property -dict {PACKAGE_PIN G15 IOSTANDARD LVCMOS33} [get_ports Cin]; #Cin=sw[0]

set_property -dict {PACKAGE_PIN M14  IOSTANDARD LVCMOS33} [get_ports {Sum[0]}]; #Sum[0]=LED[0]
set_property -dict {PACKAGE_PIN M15  IOSTANDARD LVCMOS33} [get_ports {Sum[1]}]; #Sum[1]=LED[1]
set_property -dict {PACKAGE_PIN G14  IOSTANDARD LVCMOS33} [get_ports Cout];   #Carry=LED[2]

set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports { led_status_switch[2] }]; #IO_L18P_T2_34 Sch=led6_r
set_property -dict { PACKAGE_PIN F17   IOSTANDARD LVCMOS33 } [get_ports { led_status_switch[1] }]; #IO_L6N_T0_VREF_35 Sch=led6_g
set_property -dict { PACKAGE_PIN M17   IOSTANDARD LVCMOS33 } [get_ports { led_status_switch[0] }]; #IO_L8P_T1_AD10P_35 Sch=led6_b
