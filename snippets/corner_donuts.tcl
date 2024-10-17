# cleans all previously drawn donuts
delete_obj [get_db gui_rects -if {.gui_layer_name == *xyz*}]

# gets corner shapes created during score evaluation (eval.stylus.tcl)
set regions [array size centroids_x]
set i 0
while {$i < $regions} {
	set x $shape_high_x_x($i)
	set y $shape_high_x_lowy($i)

	set x_ll [expr $x - 2.0]
	set y_ll [expr $y - 4.0]
	set x_ur [expr $x + 4.0]
	set y_ur [expr $y + 4.0]
	create_gui_shape -layer xyz1 -rect $x_ll $y_ll $x_ur $y_ur 

	set x $shape_high_x_x($i)
	set y $shape_high_x_highy($i)

	set x_ll [expr $x - 2.0]
	set y_ll [expr $y - 4.0]
	set x_ur [expr $x + 4.0]
	set y_ur [expr $y + 4.0]
	create_gui_shape -layer xyz1 -rect $x_ll $y_ll $x_ur $y_ur 

	set x $shape_low_x_x($i)
	set y $shape_low_x_lowy($i)

	set x_ll [expr $x - 4.0]
	set y_ll [expr $y - 4.0]
	set x_ur [expr $x + 2.0]
	set y_ur [expr $y + 4.0]
	create_gui_shape -layer xyz1 -rect $x_ll $y_ll $x_ur $y_ur 

	set x $shape_low_x_x($i)
	set y $shape_low_x_highy($i)

	set x_ll [expr $x - 4.0]
	set y_ll [expr $y - 4.0]
	set x_ur [expr $x + 2.0]
	set y_ur [expr $y + 4.0]
	create_gui_shape -layer xyz1 -rect $x_ll $y_ll $x_ur $y_ur 

	set i [expr $i+1]
}		

foreach rect [get_db gui_rects -if {.gui_layer_name == *xyz2*}] {
	gui_highlight $rect -index 40
}

foreach rect [get_db gui_rects -if {.gui_layer_name == *xyz1*}] {
	gui_highlight $rect -index 1
}




