# this is provided by the contest organizer. not sure which version of innovus this works with. 
# this script assumes innovus is launched with the -common_ui flag << this is important

####
# settings
####
set_multi_cpu_usage -local_cpu 8
set_db design_process_node 45

set mmmc_path ../originals/mmmc_ui.tcl
set lef_path ../../../libraries/NangateOpenCellLibrary_metal1--metal6.lef
set def_path ../originals/design_original.def
set netlist_path ../originals/design_original.v

####
# init
####
read_mmmc $mmmc_path
#read_physical -lefs $lef_path
read_physical -lef $lef_path
read_netlist $netlist_path
read_def $def_path -preserve_shape

init_design

####
# clock propagation
####
set_interactive_constraint_modes [all_constraint_modes -active]
reset_propagated_clock [all_clocks]
update_io_latency -adjust_source_latency -verbose
set_propagated_clock [all_clocks]

####
# timing
####
set_db timing_analysis_type ocv
set_db timing_analysis_cppr both
time_design -post_route
# this is important to make the power environment match the design settings
set_default_switching_activity -sequential_activity -1

set DESIGN tdea

## NOTE no exit here, as this is supposed to be sourced along with other scripts
