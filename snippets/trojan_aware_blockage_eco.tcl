# this variable could be used for calling the script multiple times without returning. by default, it is set to 1 so the while loop will only execute once
set rounds 1

while {$rounds > 0} {
	set worst_demand 0
	set worst_gcell ""

	set gcell_l [get_db designs .gcells]

	if {[info exists already_blocked]} {
		# do nothing, list exists
	} else {
		set already_blocked ""
	}

	foreach g $gcell_l {
		if {$g in $already_blocked} {
			continue;
		}
		
		set abort 1
		set regions [array size centroids_x]
		set i 0
		while {$i < $regions} {
			set x_diff [expr abs($centroids_x($i) - [get_db $g .rect.ll.x])]
			set y_diff [expr abs($centroids_y($i) - [get_db $g .rect.ll.y])]
			if {($x_diff < 8) && ($x_diff > 1)} {
				if {($y_diff < 6.0) && ($y_diff > 2.1)} {set abort 0}
			}
			
			#set total_diff [expr $x_diff + $y_diff]
			#if {($total_diff < 8.4) && ($total_diff > 2.8)} {set abort 0}
			# one std cell is 1.4um high. if the distance is too small, you may create bigger gaps
			# >2 should almost always guarantee the blockage appears two rows away, above or below
			set i [expr $i+1]
		}		

		if {$abort == 1} {
			continue
		}
		set hd [get_db $g .horizontal_demand]
		set vd [get_db $g .vertical_demand]
		set demand [expr $hd + $vd]
		if {$demand > $worst_demand} {
			set worst_gcell $g
			set worst_demand $demand
		}
	}

	set absolute_worst $worst_gcell
	lappend already_blocked $absolute_worst
	set rounds [expr $rounds - 1]
	
	echo "adding placement blockage to $absolute_worst"
	#create_place_blockage -type partial -density 50 -rects [get_db $absolute_worst .rect] -no_cut_by_core
	if {$absolute_worst == ""} {
		continue;
	}
	create_place_blockage -type hard -rects [get_db $absolute_worst .rect] -no_cut_by_core 
}

place_eco
set STAT_ECO_RUNS [expr STAT_ECO_RUNS + 1]

# if the placement ECO actually promote changes, opt_design outght to be called to reroute and perform timing analysis.
#opt_design -post_route

set block_l [get_db place_blockages]
foreach b $block_l {
	if {[get_db $b .type] == "hard"} {
		set_db $b .type partial
		set_db $b .density 5
	}
}

foreach b $block_l {
	set current_p [get_db $b .density]
	set current_p [expr $current_p + 10]
	set_db $b .density $current_p
}

foreach b $block_l {
	set current_p [get_db $b .density]
	if {$current_p >= 100} {
		delete_obj $b
	}
}


