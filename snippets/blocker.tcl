# this variable could be used for calling the script multiple times without returning
set MAX 100
set rounds 1

set logger [open log.txt w]
set count 0
set bestcount 999999
set stuck 0
set nudgex 1
set nudgey 0
set push 0
set offset 0

# a strategy based on nudges and pushes could work
# a nudgex would be a horizontal thin blockage
# a push could be a vertical fat blockage
# maybe alternating or doing nudges until nothing changes than doing pushes... could work.

while {$rounds < $MAX} {
	set block_l [get_db place_blockages]
	foreach b $block_l {
		delete_obj $b
	}

	if {[info exists first_time]} {
		# do nothing, variable exists
	} else {
		set first_time 1
	}

	set count 0
	foreach rect [get_db gui_rects -if {.gui_layer_name == *abcd*}] {
		set count [expr $count + 1]
	}
	
	if {$count == 0} { 
		# all done, nothing left to solve
		break;
	}

	set stuck [expr $stuck + 1]

	# global condition, always true
	if {$count < ($bestcount-2)} {
		set stuck 0
	}
	
	# if last round was a push, we reset bestcount
	if {$nudgey == 1} {
		set bestcount $count
		#set stuck 0
	}
	# if last round was a push, we reset bestcount and stuck count
	if {$push == 1} {
		set bestcount $count
		set stuck 0
	}			

	if {$count < $bestcount} {
		set bestcount $count
	}

	if {$stuck < 4} {
		#set offset 0
		set nudgex 1
		set nudgey 0
		set push 0
	} elseif {$stuck < 5} {
		set offset 0
		set nudgex 0
		set nudgey 1
		set push 0
	} elseif {$stuck < 7} {
		set offset 0
		set nudgex 1
		set nudgey 0
		set push 0
	} else {
		set offset 0
		set nudgex 0
		set nudgey 0
		set push 1
	}

	puts $logger "ROUND $rounds --- count: $count nudgex|nudgey|push? $nudgex $nudgey $push"

	flush $logger

	set regions [array size centroids_x]
	set i 0
	while {$i < $regions} {
		set myx $shape_high_x_x($i)
		set myy $shape_high_x_lowy($i) 

		#3.23 is the width of a flip-flop
		#set offset [expr $offset + 0.19]
		set offset 0
		#lower right corner
		if {$nudgex == 1} {
			create_place_blockage -type hard -rects "[expr $myx +0.095 +0.19] [expr $myy -0.5] [expr $myx +0.095 +0.57 + $offset ] [expr $myy +0.5]" -no_cut_by_core
		}
		if {$nudgey == 1} {
			create_place_blockage -type hard -rects "[expr $myx -0.19] [expr $myy -1.4] [expr $myx +0.19] [expr $myy -1.3]" -no_cut_by_core
		}
		if {$push == 1} {
			create_place_blockage -type hard -rects "[expr $myx -2] [expr $myy-2.8] [expr $myx +1 ] [expr $myy -2.7]" -no_cut_by_core
		}

		#set offset [expr 2*rand()]
		#better to use same offset for cases where UR and LR are the same
		#upper right corner
		set myx $shape_high_x_x($i)
		set myy $shape_high_x_highy($i) 
		if {$nudgex == 1} {		
			create_place_blockage -type hard -rects "[expr $myx +0.095 +0.19] [expr $myy -0.5] [expr $myx +0.095 +0.57 + $offset] [expr $myy +0.5]" -no_cut_by_core
		}
		if {$nudgey == 1} {
			create_place_blockage -type hard -rects "[expr $myx -0.19 ] [expr $myy +1.4] [expr $myx +0.19] [expr $myy +1.3]" -no_cut_by_core
		}
       		if {$push == 1} {
			create_place_blockage -type hard -rects "[expr $myx -2] [expr $myy+2.8] [expr $myx +1] [expr $myy +2.7]" -no_cut_by_core
		}
			
		#set offset [expr 1.6*rand()]		
		#lower left corner
		set myx $shape_low_x_x($i)
		set myy $shape_low_x_lowy($i) 
		if {$nudgex == 1} {
			create_place_blockage -type hard -rects "[expr $myx -0.095 -0.19] [expr $myy -0.5] [expr $myx -0.095 -0.57 - $offset] [expr $myy +0.5]" -no_cut_by_core
		} 
		if {$nudgey == 1} {
			create_place_blockage -type hard -rects "[expr $myx -0.19] [expr $myy -1.4] [expr $myx +0.19] [expr $myy -1.3]" -no_cut_by_core
		}
		if {$push == 1} {
			create_place_blockage -type hard -rects "[expr $myx -1] [expr $myy -2.8] [expr $myx +2 ] [expr $myy -2.7]" -no_cut_by_core
		}
	
		#set offset [expr 2*rand()]	
		#better to use same offset for cases where UR and LR are the same
		#upper left corner
		set myx $shape_low_x_x($i)
		set myy $shape_low_x_highy($i) 
		if {$nudgex == 1} {
			create_place_blockage -type hard -rects "[expr $myx -0.095 -0.19] [expr $myy -0.5] [expr $myx -0.095 -0.57 - $offset] [expr $myy +0.5]" -no_cut_by_core
		}
		if {$nudgey == 1} {
			create_place_blockage -type hard -rects "[expr $myx -0.19] [expr $myy +1.4] [expr $myx +0.19] [expr $myy +1.3]" -no_cut_by_core
		}

		if {$push == 1} {
			create_place_blockage -type hard -rects "[expr $myx -1] [expr $myy +2.8] [expr $myx +2 ] [expr $myy +2.7]" -no_cut_by_core
		}
	

		set i [expr $i + 1]
		break
	}

	set rounds [expr $rounds + 1]
	suspend
	eco_place
	#suspend
	#route_eco
	source ../scripts/eval.fast.stylus.tcl

	set first_time 0
}

close $logger


