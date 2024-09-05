set VERSION 21

#######################################################
# step 0: setup (copied from "load_design.stylus.tcl")
#######################################################

# # settings
# set_multi_cpu_usage -local_cpu 8
# set_db design_process_node 45

# set mmmc_path ../originals/mmmc_ui.tcl
# set lef_path ../../../libraries/NangateOpenCellLibrary_AES.lef
# set def_path ../originals/design_original.def
# set netlist_path ../originals/design_original.v

# # init
# read_mmmc $mmmc_path
# #read_physical -lefs $lef_path
# read_physical -lef $lef_path
# read_netlist $netlist_path
# read_def $def_path -preserve_shape

# init_design

#######################
# step 1: floorplanning
#######################

# define top + bottom routing layers 
set_db design_bottom_routing_layer 1
set_db design_top_routing_layer 10

# define VDD + VSS for the standard cells 
connect_global_net VDD -type pg_pin -pin_base_name VDD -inst_base_name * -override 
connect_global_net VSS -type pg_pin -pin_base_name VSS -inst_base_name *

set FP_RING_OFFSET 1.0000 ; # space between core and first ring
set FP_RING_WIDTH 0.6000 ;  # width of the rings
set FP_RING_SPACE 0.5000 ;  # space between rings
set FP_RING_SIZE [expr {$FP_RING_SPACE + 2*$FP_RING_WIDTH + $FP_RING_OFFSET}]

set CELL_HEIGHT 1.4
set CELL_PITCH  0.19

set FP_ROWS 137
set FP_COLS 983

# 2nd best: 137, 990, area = 38158.2/.95, score = .55
# best: 137, 983, area = 37895.924/.94386, score = .38917



set FP_HEIGHT [expr $CELL_HEIGHT * $FP_ROWS ]
set FP_WIDTH [expr $CELL_PITCH * $FP_COLS]

delete_all_floorplan_objs

create_floorplan -site FreePDK45_38x28_10R_NP_162NW_34O \
                 -core_size $FP_WIDTH $FP_HEIGHT $FP_RING_SIZE $FP_RING_SIZE $FP_RING_SIZE $FP_RING_SIZE \
                 -no_snap_to_grid

# suspend

#######################
# step 2: add tap cells
#######################


#######################
# step 3: place pins
#######################

# classic setting: all inputs on the left, all outputs on the right
set_db assign_pins_edit_in_batch true

edit_pin -fix_overlap 1 \
         -unit MICRON \
         -spread_direction clockwise \
         -side Left \
         -layer 3 \
         -spread_type center \
         -spacing 2 \
         -pin {
              reset_n clk cs we \
              {address[0]} {address[1]} \
              {address[2]} {address[3]} \
              {address[4]} {address[5]} \
              {address[6]} {address[7]} \
              {write_data[0]} {write_data[1]} \
              {write_data[2]} {write_data[3]} \
              {write_data[4]} {write_data[5]} \
              {write_data[6]} {write_data[7]} \
              {write_data[8]} {write_data[9]} \
              {write_data[10]} {write_data[11]} \
              {write_data[12]} {write_data[13]} \
              {write_data[14]} {write_data[15]} \
              {write_data[16]} {write_data[17]} \
              {write_data[18]} {write_data[19]} \
              {write_data[20]} {write_data[21]} \
              {write_data[22]} {write_data[23]} \
              {write_data[24]} {write_data[25]} \
              {write_data[26]} {write_data[27]} \
              {write_data[28]} {write_data[29]} \
              {write_data[30]} {write_data[31]}
              }

edit_pin -fix_overlap 1 \
         -unit MICRON \
         -spread_direction clockwise \
         -side Right \
         -layer 3 \
         -spread_type center \
         -spacing 2 \
         -pin { 
              {read_data[0]} {read_data[1]} \
              {read_data[2]} {read_data[3]} \
              {read_data[4]} {read_data[5]} \
              {read_data[6]} {read_data[7]} \
              {read_data[8]} {read_data[9]} \
              {read_data[10]} {read_data[11]} \
              {read_data[12]} {read_data[13]} \
              {read_data[14]} {read_data[15]} \
              {read_data[16]} {read_data[17]} \
              {read_data[18]} {read_data[19]} \
              {read_data[20]} {read_data[21]} \
              {read_data[22]} {read_data[23]} \
              {read_data[24]} {read_data[25]} \
              {read_data[26]} {read_data[27]} \
              {read_data[28]} {read_data[29]} \
              {read_data[30]} {read_data[31]}
              }

edit_pin -snap TRACK -pin *
set_db assign_pins_edit_in_batch false
legalize_pins

# suspend 

#########################
# step 4: add power rings 
#########################

# add the core ring using M6/M7
# set_db add_rings_target default 
# set_db add_rings_extend_over_row false
# set_db add_rings_ignore_rows false 
# set_db add_rings_avoid_short false 
# set_db add_rings_skip_shared_inner_ring none 
# set_db add_rings_stacked_via_top_layer M10 
# set_db add_rings_stacked_via_bottom_layer M1 
# set_db add_rings_via_using_exact_crossover_size 1 
# set_db add_rings_orthogonal_only true 
# set_db add_rings_skip_via_on_pin {  standardcell } 
# set_db add_rings_skip_via_on_wire_shape {  noshape }

add_rings -nets {VDD VSS} \
          -type core_rings \
          -follow core \
          -layer {top M7 bottom M7 left M6 right M6} \
          -width $FP_RING_WIDTH \
          -spacing $FP_RING_SPACE \
          -offset $FP_RING_OFFSET \
          -center 0 \
          -threshold 0 \
          -jog_distance 0 \
          -snap_wire_center_to_grid None 

# suspend 

#####################################
# step 5: add vertical power stripes 
#####################################

# add vertical M6 power stripes
set m3pwrwidth 0.400
set m3pwrspacing 0.500
set m3pwrset2setdist 5.000

add_stripes -direction vertical \
            -set_to_set_distance $m3pwrset2setdist \
            -spacing $m3pwrspacing \
            -layer M6 \
            -width $m3pwrwidth \
            -nets {VDD VSS} \
            -start_from left 

# suspend 

#########################
# step 6: add horizontal power stripes
#########################

# add horizontal M7 power stripes
set m4pwrwidth 0.400 
set m4pwrspacing 0.500
set m4pwrset2setdist 5.000

add_stripes -direction horizontal \
            -set_to_set_distance $m4pwrset2setdist \
            -spacing $m4pwrspacing \
            -layer M7 \
            -width $m4pwrwidth \
            -nets {VDD VSS} \
            -start_from bottom 

# suspend 

#########################
# step 7: add power rails 
#########################

set_db route_special_via_connect_to_shape { noshape }
route_special -connect { corePin } \
              -block_pin_target { nearestTarget } \
              -floating_stripe_target { blockring padring ring stripe ringpin blockpin followpin } \
              -delete_existing_routes \
              -allow_jogging 0 \
              -crossover_via_layer_range { M1(1) M10(10) } \
              -nets { VDD VSS } \
              -allow_layer_change 0 \
              -target_via_layer_range { M1(1) M10(10) }

# suspend 

#########################
# step 8: placement 
#########################

set_db opt_setup_target_slack 0

# this command places + optimizes at the same time
place_opt_design 

# attempt pre-CTS optimization 
# opt_design -pre_cts

# # code snippet which adjusts the setup target if design fails to meet timing 
# set tp [report_timing -collection ]
# set slack [get_db $tp .slack]
# set round 1
# set setup_target 0
# while {$slack < 0} {
# 	set setup_target [expr $setup_target + 0.001]
# 	set_db opt_setup_target_slack $setup_target
# 	set now [exec date]
# 	# puts $log "$now: starting pre_cts opt round#$round ..."
# 	# flush $log
# 	opt_design -pre_cts
# 	set tp [report_timing -collection ]
# 	set slack [get_db $tp .slack]
# 	set round [expr $round + 1]
# }

# suspend 

#########################
# step 9: clock tree synthesis
#########################

# add tie hi lo at this point. could have been handled in genus too.
#setTieHiLoMode -maxFanout 5
#addTieHiLo -prefix TIE -cell {TIELOx1_ASAP7_75t_SL TIEHIx1_ASAP7_75t_SL}

# CTS super command. will create the clock tree and do timing optimization at the same time
ccopt_design

# suspend 

#########################
# step 10: signal routing
#########################

route_opt_design

# suspend 

#########################
# step 11: score design
#########################

source ../scripts/eval.stylus.tcl



