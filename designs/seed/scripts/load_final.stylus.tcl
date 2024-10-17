#### this script loads the finalized db, after security closure was applied
set_multi_cpu_usage -local_cpu 8
set_db design_process_node 45

set DESIGN seed

read_db ../db/seed.tar.gz

set_db timing_analysis_type ocv
set_db timing_analysis_cppr both
time_design -post_route

source ../scripts/eval.stylus.tcl


