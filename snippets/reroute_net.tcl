set net_name ""
set net_area ""
set net_exp ""
set net_factor 0

set worst_factor 0
set worst_net ""

set infile [open "../run/nets_ea.rpt" r]

# skip reading the first 5 lines 
for {set i 0} {$i < 5} {incr i} {gets $infile}

while {[gets $infile line] >= 0} {
	set net_name [lindex $line 0]
	set net_area [lindex $line 1]
	set net_exp [lindex $line 2]
	set net_factor [expr $net_exp * $net_area]
	if {$net_factor >= $worst_factor} {
		set worst_factor $net_factor
		set worst_net $net_name
	}
}


echo "worst net is $worst_net with a factor of $worst_factor"

select_obj $worst_net

#set worstnet [get_nets $netname]
#get_db $worst_net .wires.rect
#create_route_blockage -layers {metal6 metal5} -rects [get_db  [get_nets $worst_net] .wires.rect]
set_db [get_nets $worst_net] .bottom_preferred_layer 1
set_db [get_nets $worst_net] .top_preferred_layer 3
delete_selected_from_floorplan
opt_design -post_route
delete_route_blockages -all route


