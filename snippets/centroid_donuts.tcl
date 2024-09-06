# cleans all previously drawn donuts
delete_obj [get_db gui_rects -if {.gui_layer_name == *xyz*}]

# gets centroids created during score evaluation (eval.stylus.tcl)
set regions [array size centroids_x]
set i 0
while {$i < $regions} {
	set x $centroids_x($i)
	set y $centroids_y($i)

	set x_ll [expr $x - 2.8]
	set y_ll [expr $y - 2.8]
	set x_ur [expr $x + 2.8]
	set y_ur [expr $y + 2.8]
	create_gui_shape -layer xyz1 -rect $x_ll $y_ll $x_ur $y_ur 

	set x_ll [expr $x - 8.4]
	set y_ll [expr $y - 8.4]
	set x_ur [expr $x + 8.4]
	set y_ur [expr $y + 8.4]
	create_gui_shape -layer xyz2 -rect $x_ll $y_ll $x_ur $y_ur 

	set i [expr $i+1]
}		

foreach rect [get_db gui_rects -if {.gui_layer_name == *xyz2*}] {
	gui_highlight $rect -index 40
}

foreach rect [get_db gui_rects -if {.gui_layer_name == *xyz1*}] {
	gui_highlight $rect -index 1
}




