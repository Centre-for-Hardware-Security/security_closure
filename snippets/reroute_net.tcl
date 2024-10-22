set round 1
set MAX 50

set logger [open "../run/log2.txt" w]

set net_name ""
set net_area ""
set net_exp ""
set net_factor 0

set worst_factor 0
set worst_net ""
set previous_worst ""
set used {}

while {$round <= $MAX} {
	set worst_factor 0

	set infile [open "../run/nets_ea.rpt" r]
	# skip reading the first 5 lines 
	for {set i 0} {$i < 5} {incr i} {gets $infile}

	while {[gets $infile line] >= 0} {
		set net_name [lindex $line 0]
		set net_area [lindex $line 1]
		set net_exp [lindex $line 2]
		set net_factor [expr ($net_exp * $net_area)/100]
		set found 0
		foreach n $used {
			if {$n == $net_name} {
				set found 1
				break
			}
		}

		if {($net_factor >= $worst_factor) && ($found == 0)} {
			set worst_factor $net_factor
			set worst_net $net_name
		}
	}
	close $infile

	if {$previous_worst == $worst_net} {
		puts $logger "ROUND_A $round: not executed as worst net has not changed"	
		break
	} else {
		set previous_worst $worst_net
	}

	echo "worst net is $worst_net with a factor of $worst_factor"
	puts $logger "ROUND_A $round: worst net is $worst_net with a factor of $worst_factor"
	flush $logger
	lappend used $worst_net

	select_obj $worst_net

	#create_route_blockage -layers {metal6 metal5} -rects [get_db  [get_nets $worst_net] .wires.rect]
	set_db [get_nets $worst_net] .bottom_preferred_layer 1
	set_db [get_nets $worst_net] .top_preferred_layer 3
	delete_selected_from_floorplan
	route_eco
	#opt_design -post_route
	source ../scripts/eval.fast2.stylus.tcl
	#delete_route_blockages -all route
	
	set round [expr $round +1]
}

set previous_worst ""
set round 1
set MAX 0

while {$round <= $MAX} {
	set worst_factor 0

	set infile [open "../run/nets_ea.rpt" r]
	# skip reading the first 5 lines 
	for {set i 0} {$i < 5} {incr i} {gets $infile}

	while {[gets $infile line] >= 0} {
		set net_name [lindex $line 0]
		set net_area [lindex $line 1]
		set net_exp [lindex $line 2]
		if {$net_exp >= $worst_factor} {
			set worst_factor $net_exp
			set worst_net $net_name
		}
	}
	close $infile

	if {$previous_worst == $worst_net} {
		puts $logger "ROUND_B $round: not executed as worst net has not changed"	
		break
	} else {
		set previous_worst $worst_net
	}

	echo "worst net is $worst_net with a factor of $worst_factor"
	puts $logger "ROUND_B $round: worst net is $worst_net with an exposure of $worst_factor"
	flush $logger

	select_obj $worst_net

	create_route_blockage -layers {metal6 metal5} -rects [get_db  [get_nets $worst_net] .wires.rect]
	set_db [get_nets $worst_net] .bottom_preferred_layer 1
	set_db [get_nets $worst_net] .top_preferred_layer 3
	delete_selected_from_floorplan
	route_eco
	#opt_design -post_route
	source ../scripts/eval.fast2.stylus.tcl
	delete_route_blockages -all route
	
	set round [expr $round +1]
}

set round 1
set MAX 0

# if no NDR exists, then one is created with 2x width for M3-M4-M5-M6 or M5-M6-M7-M8-M9-M10
set ret [get_db route_rules]
if {$ret == ""} {
	if {$DESIGN == "AES" } {
		create_route_rule -width_multiplier {metal5:metal10 2} -name 2W -generate_via
	} else {
		create_route_rule -width_multiplier {metal3:metal6 2} -name 2W -generate_via
	}
}

set used {}

delete_markers

while {$round <= $MAX} {
	set worst_factor 0

	set infile [open "../run/nets_ea.rpt" r]
	# skip reading the first 5 lines 
	for {set i 0} {$i < 5} {incr i} {gets $infile}

	while {[gets $infile line] >= 0} {
		set net_name [lindex $line 0]
		set found 0
		foreach n $used {
			if {$n == $net_name} {
				set found 1
				break
			}
		}
		if {$found == 0} {
			set net_area [lindex $line 1]
			set net_exp [lindex $line 2]
			if {$net_exp >= $worst_factor} {
				set worst_factor $net_exp
				set worst_net $net_name
			}
		}
	}
	close $infile

	lappend used $worst_net

	echo "worst net is $worst_net with an expsure of $worst_factor"
	puts $logger "ROUND_C $round: worst net is $worst_net with an exposure of $worst_factor"
	flush $logger

	# now I will find all nets that overlap with the net with the highest exposure
	set candidates [get_obj_in_area -areas [get_db [get_nets $worst_net  ] .wires.rect]  -obj_type net]
	set filtered {}

	#now I will filter out the candidate list. We do not want to increase the size of asset nets
	foreach net $candidates {
		if {[get_db $net .dont_touch] == "false"} {
			# net is not an asset
			lappend filtered $net
		}		
	}

	# this removes the net: prefix
	set filtered [get_db $filtered .name]

	if {[llength $filtered] == 0} {
		puts $logger "ROUND_C $round: No nets overlap with the asset ($worst_net)"
		set round [expr $round +1]
		continue
	} else {
		puts $logger "ROUND_C $round: nets to be NDRd are $filtered"
		flush $logger
	}

	foreach net $filtered {
		set_route_attributes -nets $net -route_rule 2W
		puts $logger "ROUND_C $round: Attempting to wide $net because it crosses $worst_net"
		flush $logger

		route_eco
		check_drc
		route_eco
		source ../scripts/eval.fast2.stylus.tcl
		
		set drc_count [llength [get_db designs .markers]]
		if {$drc_count > 0} {
			# meaning routing created drcs
			legalize_pins
			route_eco
			set drc_count [llength [get_db designs .markers]]
			if {$drc_count > 0} {
				puts $logger "ROUND_C $round: $drc_count DRCs appeared when attempting to widen $net ... aborting?"
				set_route_attributes -nets $net -route_rule default
				suspend
			}
		}
	}

	# two calls to route_eco are needed for innovus to realize the ndrs have to be respected?	
	#route_eco	
	#opt_design -post_route
	
	set round [expr $round +1]
}


close $logger

