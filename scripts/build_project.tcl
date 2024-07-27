# Execute from this script's location
set script_path [file normalize [info script]]
set script_dir [file dirname $script_path]
cd $script_dir

# Create project
create_project arctic_edge_core ../vivado_project -part xc7a100tcsg324-1

# Set project properties
set_property board_part digilentinc.com:nexys-a7-100t:part0:1.0 [current_project]

# Set target language to SystemVerilog
set_property target_language SystemVerilog [current_project]

# Add source files recursively
add_files -fileset sources_1 [glob -nocomplain -directory ../src/rtl -types f **/*.sv]

# Add testbench files
add_files -fileset sim_1 [glob ../src/tb/*.sv]

# Add constraints file
add_files -fileset constrs_1 ../src/constraints/Nexys_A7_100T.xdc

# Set top module
set_property top cpu_core [current_fileset]

# Set SystemVerilog as default file type
set_property file_type SystemVerilog [get_files {*.sv}]

# Generate output products
generate_target all [get_files *.xci]

# Synthesize the design
synth_design -top cpu_core

# Implement the design
implement_design

# Generate bitstream
write_bitstream -force cpu.bit