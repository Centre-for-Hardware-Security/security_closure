#### this script loads the finalized db, after security closure was applied
set_multi_cpu_usage -local_cpu 8
set_db design_process_node 45

set DESIGN openmsp430_1

read_db ../db/openmsp1.tar.gz

set_db timing_analysis_type ocv
set_db timing_analysis_cppr both
time_design -post_route
# this is important to make the power environment match the design settings
set_default_switching_activity -sequential_activity -1

source ../scripts/eval.stylus.tcl


