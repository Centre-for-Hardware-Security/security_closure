set log [open log.log w]
set now [exec date]
puts $log "$now: starting run..."

# this will mark all assets as dont_touch
source ../../../assets.tcl

# this helps cts to succeed. otherwise it complains that there are no inv/buffs available in the library.
set_db cts_buffer_cells {BUF_X1 BUF_X2 BUF_X4 BUF_X8 BUF_X16 BUF_X32 CLKBUF_X1 CLKBUF_X2 CLKBUF_X3}

connect_global_net VDD -type pg_pin -pin_base_name VDD -inst_base_name * -override
connect_global_net VSS -type pg_pin -pin_base_name VSS -inst_base_name * 

# std cell height is 1.400
# std cell pitch is  0.190

switch $DESIGN {
	"present" {
		set param_rows 30
		set param_cols 215
	} 
	"camellia" {
		set param_rows 70
		set param_cols 498
		set_db opt_max_density 1.0
		# camellia can reach really high density, this helps too.		
	}
	"cast" {
		set param_rows 93
		set param_cols 619
		set_db opt_max_density 1.0		
	}
	default {
		set param_rows 138
		set param_cols 989
		# this seems to matter a lot for AES. A LOT!
		set_db opt_max_density 1.0
	}
}

set height [expr $param_rows * 1.4]
set width [expr $param_cols * 0.19]

delete_all_floorplan_objs

if {$DESIGN=="AES"} {
	create_floorplan -core_size $width $height 1.7 1.7 1.7 1.7 -no_snap_to_grid
} else {
	create_floorplan -core_size $width $height 2.4 2.4 2.4 2.4 -no_snap_to_grid
}

deselect_routes
select_routes -nets VDD
select_routes -nets VSS
delete_selected_from_floorplan

if {$DESIGN=="AES"} {
	add_rings -nets {VDD VSS} -width 0.6 -spacing 0.5 -offset 0 -layer {top 7 bottom 7 left 6 right 6}
	route_special
	add_stripes -nets {VDD VSS} -width 0.4 -spacing 0.5 -start_offset 2.32 -set_to_set_distance 5 -layer 6 -direction vertical
	add_stripes -nets {VDD VSS} -width 0.4 -spacing 0.5 -start_offset 5.06 -set_to_set_distance 5 -layer 7 -direction horizontal
} else {
	add_rings -nets {VDD VSS} -width 0.8 -spacing 0.8 -offset 0 -layer {top 5 bottom 5 left 6 right 6}
	route_special
	add_stripes -nets {VDD VSS} -width 0.4 -spacing 0.4 -start_offset 5.00 -set_to_set_distance 15 -layer 4 -direction vertical
	add_stripes -nets {VDD VSS} -width 0.4 -spacing 0.4 -start_offset 4.00 -set_to_set_distance 14 -layer 5 -direction horizontal 
}


# this keeps the same pin strategy from the original design
read_floorplan ../originals/floorplan.fp -sections {pin}
legalize_pins

# initial settings
set setup_target 0.000
set_db opt_setup_target_slack $setup_target
set_db opt_hold_target_slack -1

# useless
#set_db opt_leakage_to_dynamic_ratio 0.0
# useless because it is the default?
#setOptMode -usefulSkew true

# this bloated up the design considerably!
#set_db place_global_timing_effort high

# these don't do much at all, decreased quality a bit
set_db place_global_activity_power_driven true
#set_db place_global_activity_power_driven_effort high
#set_db place_global_clock_power_driven_effort high

# cts stuff, largely inconsequential
#set_db opt_useful_skew_eco_route true
#set_db cts_merge_clock_gates true
#set_db cts_merge_clock_logic true

# this one helps with long nets and improves the score... but design quality goes down very quickly
#set_db opt_max_length 100

#this did nothing
#set_db route_design_with_timing_driven true

# this does something, but messes with convergence. has to be studied further.
set_db design_flow_effort extreme

#power as a priority insted of insertion delay? seems to do nothing
#eval_legacy "set_ccopt_mode -cts_opt_priority power"

#does nothing
#eval_legacy  "set_ccopt_property effort high"

# this does something but it is not a clear win without convergence
#set_db opt_post_route_area_reclaim setup_aware

# this increases runtime considerably, but indeed saves some power. it also messes with timing a bit. might be useful to try this out, turn on, then turn off, halfway?
#set_db opt_power_effort high
#set_db opt_leakage_to_dynamic_ratio 0.01

#lowest cell count!
#set_db opt_drv false

# this has a negative effect, apparently. might have to check against ccopt skew target
#set_db opt_skew_ccopt extreme

# these two do nothing
#set_db place_global_activity_power_driven true
#set_db place_global_activity_power_driven_effort high

#decreases quality
#set_db place_global_clock_power_driven_effort high

# does almost nothing, small bloating
#set_db place_global_cong_effort high

# does almost nothing
#set_db place_detail_activity_power_driven true

# does nothing
#set_db place_detail_swap_eeq_cells true

# does nothing
#set_db place_detail_wire_length_opt_effort high

#basic flow is like this:
#place_opt_design
#opt_design -pre_cts 
#ccopt_design
#opt_design -post_cts
#route_design
#opt_design -post_route

# advanced flow is below

set now [exec date]
puts $log "$now: starting place_opt..."
place_opt_design

set tp [report_timing -collection]
set slack [get_db $tp .slack]
set round 1

while {$slack < 0} {
	set setup_target [expr $setup_target + 0.001]
	set_db opt_setup_target_slack $setup_target
	set now [exec date]
	puts $log "$now: starting pre_cts opt round#$round ..."
	flush $log
	opt_design -pre_cts
	set tp [report_timing -collection ]
	set slack [get_db $tp .slack]
	set round [expr $round + 1]
}

# maybe here is a place do deflate? because it never recovers later?
set now [exec date]
puts $log "$now: starting ccopt..."
# these commands configure the target skew, but then it gets recomputed internally. there must be a better/guaranteed way to set this.
#create_clock_tree -name mytree -source clk -no_skew_group
#create_skew_group -name skew -sources clk -auto_sinks -target_skew 0.100

# this should tell the cts engine to not aim for fast transitions and use whatever the liberty file allows. should save power? not sure it is working
#set cts_target_max_transition_time ignore

#set_db cts_use_inverters false
#set_db cts_inverter_cells INV*
ccopt_design

set now [exec date]
puts $log "$now: starting post_cts opt..."
opt_design -post_cts

#route_opt_design -setup
#suspend

set now [exec date]
puts $log "$now: starting route_design..."
route_design

set now [exec date]
puts $log "$now: starting post_rout opt..."
# by default, area recovery is disabled during post_route opt. but our designs are very dense... this can help.
set_db opt_post_route_area_reclaim setup_aware

set tp [report_timing -collection]
set slack [get_db $tp .slack]

if {$slack > 0} { 
	opt_power -post_route -force
	# only if there is positive slack
}
opt_design -post_route
# last touch up only for paths that fail timing
set_db opt_setup_target_slack 0.0
opt_design -post_route -incremental

close $log

get_db current_design .bbox.area

