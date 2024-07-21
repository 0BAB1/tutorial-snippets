# CONSTRAINTS

set_property PACKAGE_PIN G15 [get_ports {sw1}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw1}]

set_property PACKAGE_PIN P15 [get_ports {sw2}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw2}]

set_property PACKAGE_PIN K18 [get_ports {btn}]
set_property IOSTANDARD LVCMOS33 [get_ports {btn}]

set_property PACKAGE_PIN M14 [get_ports {led_out}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out}]

# deal with the fact btn is not an actual clock
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets {clk_IBUF_inst/O}]