# this script works for innovus 21.16

setMultiCpuUsage -localCpu 8
setDesignMode -process 45
set init_verilog {../originals/design_original.v}
set init_design_netlisttype {Verilog}
set init_lef_file {../../../libraries/NangateOpenCellLibrary_AES.lef}
set init_mmmc_file {../originals/mmmc.tcl}

init_design

defIn ../originals/design_original.def

####
# clock propagation
####
set_interactive_constraint_modes [all_constraint_modes -active]
reset_propagated_clock [all_clocks]
update_io_latency -source -verbose
set_propagated_clock [all_clocks]

####
# timing
####
set_db timing_analysis_type ocv
set_db timing_analysis_cppr both
timeDesign -postRoute

set DESIGN AES


