
# good values for nets per round are 0.005~0.01 of the total number of nets
 
# with 0.02, cast takes forever to route
# AES 1/2/3 has 19165 nets => 95
# CAMELLIA has 7200 nets => 36
# CAST has 13048 nets => 65
# MISTY has 9800 nets => 49
# OPENMSP1 has 781 nets => 4
# OPENMSP2 has 794 nets => 4
# PRESENT has 1044 nets => 5
# SEED has 12900 nets => 64
# SPARX has 10800 nets => 54
# TDEA has 2651 nets => 13

switch $DESIGN {
	"present" {
		set NETS_PER_ROUND 5
	} 
	"camellia" {
		set NETS_PER_ROUND 36
	}
	"cast" {
		set NETS_PER_ROUND 65
	}
	"misty" {
		set NETS_PER_ROUND 49
	}
	"openmsp430_1" {
		set NETS_PER_ROUND 4
	}
	"openmsp430_2" {
		set NETS_PER_ROUND 4
	}
	"seed" {
		set NETS_PER_ROUND 64
	}
	"sparx" {
		set NETS_PER_ROUND 54
	}
	"tdea" {
		set NETS_PER_ROUND 13
	}
	default {
		set NETS_PER_ROUND 95
	}
}

set ALPHA 1.01
set DEBUG 1

# this proc finds nets on layer layer that have not been widened yet
proc find_nets {layer net_assets nets_widened} {
	upvar $nets_widened nets_w
	set allnets [get_db current_design .nets -if {.wires.layer == layer:metal$layer}]

	foreach net $allnets {
		if {[get_db $net .dont_touch] == "true"} {
			# this is a net asset
			continue
		}

		set netname [get_db $net .name]
		if {[lsearch -exact $nets_w $netname] >= 0} {
			# this net has been widened before
			continue
		}

		set touched [get_obj_in_area -areas [get_db [get_nets $netname  ] .wires.rect]  -obj_type net]
		
		set asset_is_touched 0
		set crossed ""
		foreach net_t $touched {
			if {[get_db $net_t .dont_touch] == "true"} {
				set asset_is_touched 1
				set crossed $net_t
				break
			}
		}
		if {$asset_is_touched == 0} {continue}
		
		echo "found at least one net to wide in M$layer: $netname because it crosses $crossed " 
		return 1

	}

	echo "found no nets to wide in M$layer" 
	return 0
}

proc apply_rule {layer rule net_assets max nets_widened log} {
	set counter 0
	upvar $nets_widened nets_w
	upvar $log logger
	set allnets [get_db current_design .nets -if {.wires.layer == layer:metal$layer && .dont_touch == false}]

	foreach net $allnets {
		#if {[get_db $net .dont_touch] == "true"} {
		#	this is a net asset
		#	continue
		#}

		set netname [get_db $net .name]
		#set touched [get_obj_in_area -areas [get_db [get_nets $netname  ] .wires.rect]  -obj_type net]
		
		#set asset_is_touched 0
		#set crossed ""
		#foreach net_t $touched {
		#	if {[get_db $net_t .dont_touch] == "true"} {
		#		set asset_is_touched 1
		#		break
		#	}
		#}
		#if {$asset_is_touched == 0} {continue}

		set attr [get_route_attributes -nets $netname -quiet]
		set ruleattr [lindex $attr 1]
		set ruleattr [lindex $ruleattr 1]

		#echo "comparing $rule vs. $ruleattr"
		
		if {$rule != $ruleattr} {
			set_route_attributes -nets $netname -route_rule $rule
			set counter [expr $counter +1]
			lappend nets_w $netname
		}

		if {$counter >= $max} {
			#puts $logger "ROUND B $round: widening the limit ($max)"
			return "success but reached limit"
		}
	}

	#puts $logger "ROUND B $round: widening under the limit ($counter)"
	return "sucess"
}


set nets_widened {}

set rules [get_db route_rules]
if {[llength $rules]>0} {
	# NDR rules were already defined, skip
} else {
	if {$DESIGN == "AES"} {
		create_route_rule -width_multiplier {metal10:metal10 2} -name 2WM10 -generate_via
		create_route_rule -width_multiplier {metal9:metal10 2} -name 2WM9 -generate_via
		create_route_rule -width_multiplier {metal8:metal10 2} -name 2WM8 -generate_via
		create_route_rule -width_multiplier {metal7:metal10 2} -name 2WM7 -generate_via
		#create_route_rule -width_multiplier {metal6:metal10 2} -name 2WM6 -generate_via
	} else {
		create_route_rule -width_multiplier {metal6:metal6 2} -name 2WM6 -generate_via
		create_route_rule -width_multiplier {metal5:metal6 2} -name 2WM5 -generate_via
		create_route_rule -width_multiplier {metal4:metal6 2} -name 2WM4 -generate_via
	}
}

set round 1
set MAX 99

set logger [open "../run/log2.txt" a]

set TIME_start [clock clicks -milliseconds]

if {$DESIGN == "AES"} {
	set current_layer 10
	set end_layer 7
} else {
	set current_layer 6
	set end_layer 4
}

while {$round <= $MAX} {
	if {$current_layer < $end_layer} {break}
	flush $logger

	set drc_count [llength [get_db designs .markers]]
	if {$drc_count > 0} {
		# there are two annoying things that can happen
		# a widened metal created a pin that is invalid, so pins have to be legalized again
		# this makes the global routing solution invalid, so the entire route_design engine has to be called :/
		# the commands below can fix some issues and try to reroute, but we will abort otherwise ^
		legalize_pins
		route_design
		set drc_count [llength [get_db designs .markers]]
		if {$drc_count > 0} {
			puts $logger "we are done, drcs appeared"
			break			
		}
	}
	
	set current_rule "2WM$current_layer"

	if {[find_nets $current_layer $net_assets nets_widened] == 1} { 
		puts $logger "ROUND_B $round: found at least one net to wide in M$current_layer"	
		apply_rule $current_layer $current_rule $net_assets $NETS_PER_ROUND nets_widened logger
		route_detail
		set round [expr $round +1]
		if {$DEBUG == 1} {
			source ../scripts/eval.fast2.stylus.tcl
			set infile [open "../run/nets_ea.rpt" r]
			gets $infile line
			set curr_exp [lindex $line 6]
			gets $infile line
			gets $infile line
			set curr_perc [lindex $line 6]
			puts $logger "ROUND_B $round: total exposure now is $curr_exp"	
			puts $logger "ROUND_B $round: percentage exposure of worst net now is $curr_perc"
			set TIME_end [clock clicks -milliseconds]
			set TIME_taken [expr ($TIME_end - $TIME_start)/1000]

			echo "time taken so far is: [expr $TIME_taken]"
			puts $logger "time taken so far is: [expr $TIME_taken]"
		}
	} else {
		set current_layer [expr $current_layer -1]
	}
}

opt_design -post_route

set TIME_end [clock clicks -milliseconds]
set TIME_taken [expr ($TIME_end - $TIME_start)/1000]

echo "total time is: [expr $TIME_taken]"
puts $logger "total time is: [expr $TIME_taken]"

set unique [lsort -unique $nets_widened]   
echo "total number of nets touched in round B is [llength $unique]"
puts $logger "total number of nets touched in round B is [llength $unique]"

close $logger

return



