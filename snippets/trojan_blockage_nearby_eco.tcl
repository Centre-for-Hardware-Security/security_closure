# this variable could be used for calling the script multiple times without returning. by default, it is set to 1 so the while loop will only execute once
set rounds 1

while {$rounds > 0} {
	set worst_demand 0
	set worst_gcell ""
	set almost_worst_gcell ""

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
		if {[get_db $g .rect.ll.x] < 2} {
			# outside floorplan
			#echo "ignoring x = 0"
			continue;
		}
		if {[get_db $g .rect.ll.y] < 2} {
			#echo "ignoring y = 0"
			continue;
		}

		# TODO: get die coordinates from db and check against dimensions on top and right sides
		
		set abort 1
		set regions [array size centroids_x]
		set i 0
		while {$i < $regions} {
			set happy 1
			set x_diff 0
			set y_diff 0

			#if {( [get_db $g .rect.ll.x] <= [expr $shape_high_x($i) + 0.4] ) && ( [get_db $g .rect.ll.x] >= [expr $shape_low_x($i) -0.4]) } {
				# middle condition for x, let's check y
			#	if {( [get_db $g .rect.ll.y] <= [expr $shape_high_y($i) +1.4] ) && ( [get_db $g .rect.ll.y] >= [expr $shape_low_y($i) -1.4] ) } {
				# middle condition too
			#		set happy 1
			#		set abort 0
			#	} else {
			#		set happy 0
			#	}
			#} else {
			#	set happy 0
			#}

			#set i [expr $i+1]

			#continue
			#echo "trying region $i, gcell $g"
			set gcell_x [get_db $g .rect.ll.x]
			set gcell_x [expr $gcell_x + 1.05]			
			set gcell_y [get_db $g .rect.ll.y]
			set gcell_y [expr $gcell_y + 1.05]			
			
		
			set x_diff [expr  $gcell_x - $shape_high_x_x($i)]
			#if {$x_diff < 0} {set x_diff [expr -$x_diff]}
			if {($x_diff < -2) || ($x_diff > 4)} {
				# gcell can be 2 um to the left of the rightmost x shape
				# or it can be up to 4um to the right of it
				set happy 0
			} else {
				# must check y
				set y_diff [expr $gcell_y - $shape_high_x_lowy($i)]
				if {$y_diff < 0} {set y_diff [expr -$y_diff]}
				if {$y_diff > 4} {
					#too far
					set happy 0
				} else {
					set happy 1
					echo "we are happy with region $i versus g_cell $g. $x_diff $y_diff"
					set abort 0
					break;
				}	
				set y_diff [expr $gcell_y - $shape_high_x_highy($i)]
				if {$y_diff < 0} {set y_diff [expr -$y_diff]}
				if {$y_diff > 4} {
					#too far
					set happy 0
				} else {
					set happy 1
					echo "we are happy with region $i versus g_cell $g. $x_diff $y_diff"
					set abort 0
					break;
				}				
			}

			set x_diff [expr $shape_low_x_x($i) - $gcell_x]
			if {($x_diff < -2) || ($x_diff > 4)} {
				# too far
				set happy 0
			} else {
				# must check y
				set y_diff [expr $gcell_y - $shape_low_x_lowy($i)]
				if {$y_diff < 0} {set y_diff [expr -$y_diff]}
				if {$y_diff > 4} {
					#too far
					set happy 0
				} else {
					set happy 1
					echo "we are happy with region $i versus g_cell $g. $x_diff $y_diff"
					set abort 0
					break;

				}		
				set y_diff [expr $gcell_y - $shape_low_x_highy($i)]
				if {$y_diff < 0} {set y_diff [expr -$y_diff]}
				if {$y_diff > 4} {
					#too far
					set happy 0
				} else {
					set happy 1
					echo "we are happy with region $i versus g_cell $g. $x_diff $y_diff"
					set abort 0
					break;

				}				
			}

			#if {$happy == 1} {
			#	echo "we are happy with region $i versus g_cell $g. $x_diff $y_diff"
			#}
			break; 
			# this makes it such that we only look at region 0
			set i [expr $i+1]
		}			

		if {$abort == 1} { 
			continue
		}
		set hd [get_db $g .horizontal_demand]
		set vd [get_db $g .vertical_demand]
		set demand [expr $hd + $vd]
		if {$demand >= $worst_demand} {
			set almost_worst_gcell $worst_gcell
			set worst_gcell $g
			set worst_demand $demand
		}
	}

	lappend already_blocked $worst_gcell
	lappend already_blocked $almost_worst_gcell
	set rounds [expr $rounds - 1]
	
	echo "adding placement blockage to $almost_worst_gcell"
	echo "adding placement blockage to $worst_gcell"
	#create_place_blockage -type partial -density 50 -rects [get_db $absolute_worst .rect] -no_cut_by_core
	if {$worst_gcell == ""} {
		continue;
	}
	create_place_blockage -type hard -rects [get_db $almost_worst_gcell .rect] -no_cut_by_core
	create_place_blockage -type hard -rects [get_db $worst_gcell .rect] -no_cut_by_core
	gui_zoom -rect [get_db $worst_gcell .rect]
	gui_zoom -out
	gui_zoom -out
}

place_eco
suspend

# this can be used to detect if any net needs to be re routed
#get_db designs .nets.has_valid_parasitics

route_eco
#source ../scripts/eval.fast.stylus.tcl
set STAT_ECO_RUNS [expr $STAT_ECO_RUNS + 1]

# if the placement ECO actually promote changes, opt_design outght to be called to reroute and perform timing analysis.
#suspend
#opt_design -post_route

set block_l [get_db place_blockages]
foreach b $block_l {
	if {[get_db $b .type] == "hard"} {
		set_db $b .type partial
		set_db $b .density 10
	}
}

foreach b $block_l {
	set current_p [get_db $b .density]
	set current_p [expr $current_p + 5]
	set_db $b .density $current_p
}

foreach b $block_l {
	set current_p [get_db $b .density]
	if {$current_p >= 100} {
		delete_obj $b
		set already_blocked [lreplace $already_blocked 0 0]
	}
}

source ../scripts/eval.fast.stylus.tcl

echo $almost_worst_gcell
echo $worst_gcell



