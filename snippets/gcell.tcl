# rounds should be a function of the size of gcell_l?
set rounds 1

while {$rounds > 0} {
	set worst_h 999
	set worst_v 999
	set worst_gcell_h ""
	set worst_gcell_v ""

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
			set total_diff [expr $x_diff + $y_diff]
			if {$total_diff < 5} {set abort 0}
			set i [expr $i+1]
		}		

		if {$abort == 1} {
			continue
		}
		set hr [get_db $g .horizontal_remaining]
		set vr [get_db $g .vertical_remaining]
		if {$hr < $worst_h} {
			set worst_gcell_h $g
			set worst_h $hr
		}
		if {$vr < $worst_v} {
			set worst_gcell_v $g
			set worst_v $vr
		}
	}

	set absolute_worst ""
	if {$worst_h < $worst_v} {
		set absolute_worst $worst_gcell_h
	} else {
		set absolute_worst $worst_gcell_v
	}

	lappend already_blocked $absolute_worst
	
	echo "adding placement blockage to $absolute_worst"
	#create_place_blockage -type partial -density 50 -rects [get_db $absolute_worst .rect] -no_cut_by_core
	create_place_blockage -type hard -rects [get_db $absolute_worst .rect] -no_cut_by_core 
	set rounds [expr $rounds - 1]
}

opt_design -post_route

set block_l [get_db place_blockages]
foreach b $block_l {
	set_db $b .type partial
	set_db $b .density 50
}

