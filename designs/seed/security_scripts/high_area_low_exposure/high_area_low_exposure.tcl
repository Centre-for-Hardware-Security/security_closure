# run traditional closure 
source ../scripts/implement.tcl

# make a copy of pre_security scores 
file copy -force ../run/scores.rpt ../security_scripts/high_area_low_exposure/pre_security_scores.rpt

################################################################################
# step 12: reroute nets
################################################################################

# set vars 
set target_nets {}
set total_net_area 0
set num_net_assets 0

##### read through net assets once to calculate the average net area ###########

# open file describing net assets 
set infile [open "../run/nets_ea.rpt" r]

# skip reading the first 5 lines 
for {set i 0} {$i < 5} {incr i} {gets $infile}

# get the sum of all net areas  
while {[gets $infile line] >= 0} {
    set curr_net_area  [lindex $line 1]
    set total_net_area [expr $total_net_area + $curr_net_area]
    set num_net_assets [expr $num_net_assets + 1]
}

# calculate the average net area 
set avg_net_area [expr $total_net_area / $num_net_assets]

# close file 
close $infile

##### read through net assets again to identify target net assets ##############

# open file describing net assets 
set infile [open "../run/nets_ea.rpt" r]

# define average net exposure 
for {set i 0} {$i < 5} {incr i} {
    gets $infile
    if {$i == 2} {
        set avg_net_exposure [lindex $line 6]
    }
}

# identify target net assets 
while { [gets $infile line] >= 0} {
    set net_area [lindex $line 1]
    set net_exposure [lindex $line 2]
    if {$net_exposure <= $avg_net_exposure} {
        if {$net_area > $avg_net_area} {
            lappend target_nets [lindex $line 0]
        }
    }
}

# close file 
close $infile

# create net blockages 
foreach net $target_nets {
	select_obj $net
    set worstnet [get_nets $net]
    get_db $worstnet .wires.rect
    create_route_blockage -layers 6 -rects [get_db $worstnet .wires.rect]
    delete_selected_from_floorplan
}

# reroute nets 
opt_design -post_route

# delete blockages 
delete_route_blockages -all route

################################################################################
# step 13: rescore design
################################################################################

# score design 
source ../scripts/eval.stylus.tcl

# make a copy of post-security scores 
file copy -force ../run/scores.rpt ../security_scripts/high_area_low_exposure/post_security_scores.rpt