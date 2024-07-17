### Step 1) - Floorplan .8 best w = 0.19 multiple, height = 1.4 multiple### Best: 137/989
# side ~ 190
set row 136
set col 1000
set cell_height 1.4
set cell_width 0.19
set HEIGHT [expr $row * $cell_height]
set WIDTH [expr $col * $cell_width]
set SIDE 4.00

create_floorplan -core_size $WIDTH $HEIGHT $SIDE $SIDE $SIDE $SIDE

### Step 2) - Rings (Ring Offset can be 0)
set FP_RING_WIDTH 0.80
set FP_RING_SPACE 0.80
set FP_RING_OFFSET 0.0

add_rings -nets {VDD VSS} -type core_rings -follow core -layer {top M5 bottom M5 left M6 right M6} -width $FP_RING_WIDTH -spacing $FP_RING_SPACE -offset $FP_RING_OFFSET -center 0 -threshold 0 -jog_distance 0 -snap_wire_center_to_grid none

### Step 3) - Specials ###

### Step 4) - Stripes start offset around half of the width###

# M4 Power Stripes
set m4pwrwidth 0.400
set m4pwrspacing 0.400
set m4pwrset2setdist 15.000
set m4pwrstart $SIDE
set m4pwrstart_offset 1.32
set m4pwrstop [expr $SIDE + $WIDTH]
set m4pwrstop_offset 0.75

add_stripes -nets {VDD VSS} -layer M4 \
    -width $m4pwrwidth -spacing $m4pwrspacing \
    -set_to_set_distance $m4pwrset2setdist -start_from left \
    -start $m4pwrstart  \
    -stop $m4pwrstop  \
    -direction vertical

# M7 Power Stripes
set m5pwrwidth 0.400
set m5pwrspacing 0.400
set m5pwrset2setdist 15.000
set m5pwrstart $SIDE
set m5pwrstart_offset 1.45
set m5pwrstop [expr $SIDE + $HEIGHT]
set m5pwrstop_offset 4.0

add_stripes -nets {VDD VSS} -layer M5 \
    -width $m5pwrwidth -spacing $m5pwrspacing \
    -set_to_set_distance $m5pwrset2setdist -start_from bottom \
    -start $m5pwrstart  \
    -stop $m5pwrstop  \
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



