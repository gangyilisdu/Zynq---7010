set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_IBUF]
set_property -dict {PACKAGE_PIN P16 IOSTANDARD LVCMOS33} [get_ports clk]

set_property -dict {PACKAGE_PIN G15 IOSTANDARD LVCMOS33} [get_ports din];

set_property -dict { PACKAGE_PIN Y16   IOSTANDARD LVCMOS33 } [get_ports reset]; #IO_L24N_T3_34 Sch=btn[1]

set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33 } [get_ports dout];