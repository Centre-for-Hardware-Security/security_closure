### Step 1) - Floorplan .8 best w = 0.19 multiple, height = 1.4 multiple### Best: 137/989

set row 137
set col 989
set cell_height 1.4
set cell_width 0.19
set HEIGHT [expr $row * $cell_height]
set WIDTH [expr $col * $cell_width]
set SIDE 4.0

create_floorplan -core_size $WIDTH $HEIGHT $SIDE $SIDE $SIDE $SIDE

### Step 2) - Rings (Ring Offset can be 0)
set FP_RING_WIDTH 0.6
set FP_RING_SPACE 0.50
set FP_RING_OFFSET 1.0

add_rings -nets {VDD VSS} -type core_rings -follow core -layer {top M7 bottom M7 left M6 right M6} -width $FP_RING_WIDTH -spacing $FP_RING_SPACE -offset $FP_RING_OFFSET -center 0 -threshold 0 -jog_distance 0 -snap_wire_center_to_grid none

### Step 3) - Specials ###

### Step 4) - Stripes start offset around half of the width###

# M6 Power Stripes
set m6pwrwidth 0.400
set m6pwrspacing 0.500
set m6pwrset2setdist 5.000
set m6pwrstart $SIDE
set m6pwrstart_offset 1.32
set m6pwrstop [expr $SIDE + $WIDTH]
set m6pwrstop_offset 0.75

add_stripes -nets {VDD VSS} -layer M6 \
    -width $m6pwrwidth -spacing $m6pwrspacing \
    -set_to_set_distance $m6pwrset2setdist -start_from left \
    -start $m6pwrstart  \
    -stop $m6pwrstop  \
    -direction vertical

# M7 Power Stripes
set m7pwrwidth 0.400
set m7pwrspacing 0.500
set m7pwrset2setdist 5.000
set m7pwrstart $SIDE
set m7pwrstart_offset 1.45
set m7pwrstop [expr $SIDE + $HEIGHT]
set m7pwrstop_offset 4.0

add_stripes -nets {VDD VSS} -layer M7 \
    -width $m7pwrwidth -spacing $m7pwrspacing \
    -set_to_set_distance $m6pwrset2setdist -start_from left \
    -start $m7pwrstart  \
    -stop $m7pwrstop  \
    -direction horizontal

route_special

### Step 5) - Placement ###
place_opt_design

### Step 6) - Clock Synthesis ###
ccopt_design

### Step 7) - Routing ###
route_design

### Step 8) - Post route optimazation ###
opt_design -post_route

### Step 9) - gcell optimization ###
set worst_h 0
set worst_v 0
set worst_sum 0
set worst_gcell_h ""
set worst_gcell_v ""
set worst_gcell ""
set gcell_l [get_db designs .gcells]

# gcell iteration
foreach g $gcell_l {
    set hr [get_db $g .horizontal_remaining]
    set vr [get_db $g .vertical_remaining]
    set sum [expr $hr + $vr]
    # worst horizontal 
    if {$sum > $worst_sum} {
        set worst_gcell $g
        set worst_sum $sum 
    }
    # worst horizontal 
    #if {$hr > $worst_h} {
    #    set worst_gcell_h $g
    #    set worst_h $hr
    #}
    ## worst vertical 
    #if {$vr < $worst_v} {
    #    set worst_gcell_v $g
    #    set worst_v $vr
    #}
}

# gcell selection
#set absolute_worst ""
#if {$worst_h < $worst_v} {
#    set absolute_worst $worst_gcell_h
#} else {
#    set absolute_worst $worst_gcell_v
#}
set absolute_worst $worst_gcell
# place blockage
# create_place_blockage -type hard -rects [get_db $absolute_worst .rect]

### Step 10) - Place, route and optimize again ###
# place_opt_design
# ccopt_design
# route_design
# opt_design -post_route



