# this script assumes the design is already loaded and that the design is legal (does not violate competition rules like pin placement, power stripe locations, etc.)
# this script also assumes innovus is using stylus mode
# and finally, the design name must be declared on the DESIGN variable. the load_design.tcl script already does this automatically. 

#step 0 - cleanup. will delete any previous error files
rm errors.rpt -f

# step 1 - generate area.rpt
set fl [open area.rpt w]
puts $fl [get_db current_design .bbox.area]
close $fl

# step 2 - generate power.rpt
#report_power > power.rpt

#step 3 - generate report timing summary
#report_timing_summary -checks setup > timing.rpt

# step 4 - connectivity checks, generates *.conn.rpt
#check_connectivity

# step 5 - pin checks, will generate *.checkPin.rpt
#check_pin_assignment

# step 6 - design rule check, will create *.geom.rpt
#check_drc -limit 99999

# step 7 - miscelaneous place and route checks, will create check_route.rpt
#check_design -type route > check_route.rpt 

# step 8 - find exploitable regions (related to hw trojans)
set fl [open ../assets/cells.assets r]
set lines [split [read $fl] '\n']
close $fl

set lines [lrange $lines 0 end-1] 
set sc_inst_pattern [join $lines " "]

#source exploit_eval_threshold.tcl
source -quiet ../scripts/exploit_regions.tcl

# step 9 - find exposed assets (related to probing)
#source -quiet ../scripts/probing_execute.tcl

# step 10 - summarize design costs into a single report
#sh design_cost.sh

# step 11 - some post processing for TI related metrics
#sh post_process_exploit_regions.sh

#step 12 - calculate scores
#sh scores.sh 5 ../reports/






