### Step 1) - Floorplan ###
set WIDTH 189
set HEIGHT 189
set SIDE 4

create_floorplan -core_size $WIDTH $HEIGHT $SIDE $SIDE $SIDE $SIDE

### Step 2) - Rings
set FP_RING_WIDTH 0.6125
set FP_RING_SPACE 0.50
set FP_RING_OFFSET 1.0

add_rings -nets {VDD VSS} -type core_rings -follow core -layer {top M7 bottom M7 left M6 right M6} -width $FP_RING_WIDTH -spacing $FP_RING_SPACE -offset $FP_RING_OFFSET -center 0 -threshold 0 -jog_distance 0 -snap_wire_center_to_grid none

### Step 3) - Specials ###

### Step 4) - Stripes ###

# M6 Power Stripes
set m6pwrwidth 0.400
set m6pwrspacing 0.500
set m6pwrset2setdist 3.700
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
set m7pwrset2setdist 3.700
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

### Step 8) - Final optimazation ###
opt_design -post_route