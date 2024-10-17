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


proc find_obj {side x1 y1 x2 y2} {
	set ret ""
	if {$side == "right"} {
		#find all objects in a 5um distance to the right
		set objs [get_obj_in_area -obj_type inst -areas "$x1 $y1 [expr $x2 + 5] $y2" -overlap_only]
		set highx 999999
		foreach obj $objs {
			set x [get_db $obj .location.x]
			if {$x < $highx} {
				set highx $x
				set ret $obj
			}
		}
	}
	if {$side == "left"} {
		#find all objects in a 5um distance to the left
		set objs [get_obj_in_area -obj_type inst -areas "$x1 $y1 [expr $x2 - 5] $y2" -overlap_only]
		set lowx 0
		foreach obj $objs {
			set x [get_db $obj .location.x]
			if {$x > $lowx} {
				set lowx $x
				set ret $obj
			}
		}
	}

	if {$ret != ""} {
		variable logger
		puts $logger $ret
	}
	return $ret
}

# a strategy based on nudges and pushes could work
# a nudgex would be a horizontal thin blockage
# a push could be a vertical fat blockage
# maybe alternating or doing nudges until nothing changes than doing pushes... could work.

while {$rounds <= $MAX} {
	set count 0
	foreach rect [get_db gui_rects -if {.gui_layer_name == *abcd*}] {
		set count [expr $count + 1]
	}
	
	if {$count == 0} { 
		# all done, nothing left to solve
		opt_design -post_route
		source ../scripts/eval.stylus.tcl
		break;
	}

	if {$count < $bestcount} {
		set stuck 0
		set bestcount $count
		puts $logger "new best found: $count"
	} else {
		set stuck [expr $stuck + 1]
	}

	if {$stuck < 3} {
		set nudgex 1
		set push 0
	} else {
		set nudgex 0
		set push 1
		set bestcount 999999
	}

	puts $logger "ROUND: $rounds --- count: $count will do nudge|push? $nudgex $push"

	flush $logger

	set regions [array size centroids_x]
	set i 0
	while {$i < $regions} {
		set myx $shape_high_x_x($i)
		set myy $shape_high_x_lowy($i)

		#lower right corner
		if {$nudgex == 1} {
			set obj [find_obj "right" [expr $myx +0.095] [expr $myy -0.5] [expr $myx +0.095 +0.19] [expr $myy +0.5]]
			set objx [get_db $obj .location.x]
			set objy [get_db $obj .location.y]
			set_db $obj .location "[expr $objx - 0.76] $objy"
			gui_highlight $obj -index 31
		} else {
			set obj [find_obj "right" [expr $myx +0.095] [expr $myy -1.4] [expr $myx +0.095 +0.19] [expr $myy -1.3]]
			set objx [get_db $obj .location.x]
			set objy [get_db $obj .location.y]
			set_db $obj .location "$objx [expr $objy + 1.4]"
			gui_highlight $obj -index 32
		}
	
		#upper right corner
		set myx $shape_high_x_x($i)
		set myy $shape_high_x_highy($i)
		if {$nudgex == 1} {
			if {$shape_high_x_highy($i) != $shape_high_x_lowy($i)} {	
				set obj [find_obj "right" [expr $myx +0.095] [expr $myy -0.5] [expr $myx +0.095 +0.19] [expr $myy +0.5]]
				set objx [get_db $obj .location.x]
				set objy [get_db $obj .location.y]
				set_db $obj .location "[expr $objx - 0.76] $objy"
				gui_highlight $obj -index 31			
			} 
		} else {
			set obj [find_obj "right" [expr $myx +0.095] [expr $myy +1.4] [expr $myx +0.095 +0.19] [expr $myy +1.5]]
			set objx [get_db $obj .location.x]
			set objy [get_db $obj .location.y]
			set_db $obj .location "$objx [expr $objy - 1.4]"
			gui_highlight $obj -index 32	
		}
						
		#lower left corner
		set myx $shape_low_x_x($i)
		set myy $shape_low_x_lowy($i) 
		if {$nudgex == 1} {
			set obj [find_obj "left" [expr $myx -0.095] [expr $myy -0.5] [expr $myx -0.095 -0.19] [expr $myy +0.5]]
			set objx [get_db $obj .location.x]
			set objy [get_db $obj .location.y]
			set_db $obj .location "[expr $objx + 0.38] $objy"
			gui_highlight $obj -index 31			
		} else {
			set obj [find_obj "left" [expr $myx -0.095] [expr $myy -1.4] [expr $myx -0.095 -0.19] [expr $myy -1.3]]
			set objx [get_db $obj .location.x]
			set objy [get_db $obj .location.y]
			set_db $obj .location "$objx [expr $objy + 1.4]"
			gui_highlight $obj -index 32
		}
	
		#upper left corner
		set myx $shape_low_x_x($i)
		set myy $shape_low_x_highy($i) 
		if {$nudgex == 1} {
	       		if {$shape_low_x_highy($i) !=  $shape_low_x_lowy($i)} {
				set obj [find_obj "left" [expr $myx -0.095] [expr $myy -0.5] [expr $myx -0.095 -0.19] [expr $myy +0.5]]
				set objx [get_db $obj .location.x]
				set objy [get_db $obj .location.y]
				set_db $obj .location "[expr $objx + 0.38] $objy"
				gui_highlight $obj -index 31			
			}
		} else {
			set obj [find_obj "left" [expr $myx -0.095] [expr $myy -1.4] [expr $myx -0.095 -0.19] [expr $myy -1.3]]
			set objx [get_db $obj .location.x]
			set objy [get_db $obj .location.y]
			set_db $obj .location "$objx [expr $objy - 1.4]"
			gui_highlight $obj -index 32	
		}
	
		set i [expr $i + 1]
		#break
	}

	set rounds [expr $rounds + 1]
	if {$push == 1} {
		# there is a chance that a push can create overlaps, so eco place fixes that
		eco_place
	}
	#suspend
	#eco_place
	#suspend
	#route_eco
	source ../scripts/eval.fast.stylus.tcl

}

close $logger


