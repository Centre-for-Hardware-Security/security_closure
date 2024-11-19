set TIME_start [clock clicks -milliseconds]

set round 1
set MAX 999

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

set ALPHA 1.0

set logger [open "../run/log2.txt" w]

set net_name ""
set net_area ""
set net_exp ""
set net_factor 0

set worst_factor 0
set worst_net ""
set previous_worst ""
set prev_exp 999999
set curr_exp 0
set used {}

set TIME_total 0

while {$round <= $MAX} {
	set TIME_start [clock clicks -milliseconds]

	set worst_factor 0

	set infile [open "../run/nets_ea.rpt" r]
	gets $infile line
	set curr_exp [lindex $line 6]
	gets $infile line
	gets $infile line
	set curr_perc [lindex $line 6]
	
	if {[expr $curr_exp*$ALPHA] >= $prev_exp} {
		puts $logger "ROUND_A $round: total exposure now is $curr_exp"	
		puts $logger "ROUND_A $round: percentage exposure of worst net now is $curr_perc"
		puts $logger "ROUND_A terminated at $round because exposure did not improve (enough)"
		set TIME_end [clock clicks -milliseconds]
		set TIME_taken [expr ($TIME_end - $TIME_start)]
		set TIME_total [expr $TIME_total + $TIME_taken]
	
		break
	} else {
		puts $logger "ROUND_A $round: total exposure now is $curr_exp"	
		puts $logger "ROUND_A $round: percentage exposure of worst net now is $curr_perc"
		flush $logger
		
		set prev_exp $curr_exp
	}

	# skip reading the next 2 lines 
	for {set i 0} {$i < 2} {incr i} {gets $infile}

	while {[gets $infile line] >= 0} {
		set net_name [lindex $line 0]
		set net_area [lindex $line 1]
		set net_exp [lindex $line 2]
		set net_factor [expr ($net_exp * $net_area)/100]

		set factors($net_name) $net_factor
		set exps($net_name) $net_exp
	}
	close $infile

	set factorsl [lsort -stride 2 -index 1 -decreasing -real [array get factors]]

	for {set i 0} {$i < $NETS_PER_ROUND} {incr i} {
		if {[llength $factorsl] < ($i*2 +1)} {
			break
			# this is for cases where number of net assets is small
		}
		set worst_net [lindex $factorsl [expr $i*2 + 0]]
		set worst_factor [lindex $factorsl [expr $i*2 + 1]]

		echo "ROUND_A $round : worst net is $worst_net with a factor of $worst_factor an exposure of $exps($worst_net)"
		puts $logger "ROUND_A $round : worst net is $worst_net with a factor of $worst_factor and an exposure of $exps($worst_net)"
		flush $logger
		deselect_obj -all
		select_obj $worst_net
		delete_selected_from_floorplan

		set_db [get_nets $worst_net] .bottom_preferred_layer 1
		if {$DESIGN == "AES"} {		
			set_db [get_nets $worst_net] .top_preferred_layer 4
		} else {
			set_db [get_nets $worst_net] .top_preferred_layer 3
		}

		lappend used $worst_net
	}

	route_eco
	
	set TIME_end [clock clicks -milliseconds]
	set TIME_taken [expr ($TIME_end - $TIME_start)]
	set TIME_total [expr $TIME_total + $TIME_taken]

	source ../scripts/eval.fast2.stylus.tcl
	
	set round [expr $round +1]
}

set unique [lsort -unique $used]   
echo "total number of nets touch in round A is [llength $unique]"
puts $logger "total number of nets touch in round A is [llength $unique]"

set TIME_start [clock clicks -milliseconds]

check_drc
opt_design -post_route

set TIME_end [clock clicks -milliseconds]
set TIME_total [expr $TIME_total + $TIME_taken]

set TIME_taken [expr ($TIME_end - $TIME_start)/1000]

echo "total time is: [expr $TIME_total/1000]"
puts $logger "total time is: [expr $TIME_total/1000]"

close $logger

return

