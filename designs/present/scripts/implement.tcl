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
set_db design_top_routing_layer 6

# define VDD + VSS for the standard cells 
connect_global_net VDD -type pg_pin -pin_base_name VDD -inst_base_name * -override 
connect_global_net VSS -type pg_pin -pin_base_name VSS -inst_base_name *

set FP_RING_OFFSET 0.095 ; # space between core and first ring
set FP_RING_WIDTH 0.800 ;  # width of the rings
set FP_RING_SPACE 0.800 ;  # space between rings
set FP_RING_SIZE_H [expr {$FP_RING_SPACE + 2*$FP_RING_WIDTH + $FP_RING_OFFSET + 1.565}]
set FP_RING_SIZE_V [expr {$FP_RING_SPACE + 2*$FP_RING_WIDTH + $FP_RING_OFFSET + 1.685}]

set CELL_HEIGHT 1.4
set CELL_PITCH  0.19

set FP_ROWS 30
set FP_COLS 225 

set FP_HEIGHT [expr $CELL_HEIGHT * $FP_ROWS ]
set FP_WIDTH [expr $CELL_PITCH * $FP_COLS]

delete_all_floorplan_objs

create_floorplan -site FreePDK45_38x28_10R_NP_162NW_34O \
                 -core_size $FP_WIDTH $FP_HEIGHT $FP_RING_SIZE_V $FP_RING_SIZE_H $FP_RING_SIZE_V $FP_RING_SIZE_H \
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
         -spacing .2 \
         -pin {   
              clock reset_n load \
              {pt[1]} {pt[2]} \
              {pt[3]} {pt[4]} \
              {pt[5]} {pt[6]} \
              {pt[7]} {pt[8]} \
              {pt[9]} {pt[10]} \
              {pt[11]} {pt[12]} \
              {pt[13]} {pt[14]} \
              {pt[15]} {pt[16]} \
              {pt[17]} {pt[18]} \
              {pt[19]} {pt[20]} \
              {pt[21]} {pt[22]} \
              {pt[23]} {pt[24]} \
              {pt[25]} {pt[26]} \
              {pt[27]} {pt[28]} \
              {pt[29]} {pt[30]} \
              {pt[31]} {pt[32]} \
              {pt[33]} {pt[34]} \
              {pt[35]} {pt[36]} \
              {pt[37]} {pt[38]} \
              {pt[39]} {pt[40]} \
              {pt[41]} {pt[42]} \
              {pt[43]} {pt[44]} \
              {pt[45]} {pt[46]} \
              {pt[47]} {pt[48]} \
              {pt[49]} {pt[50]} \
              {pt[51]} {pt[52]} \
              {pt[53]} {pt[54]} \
              {pt[55]} {pt[56]} \
              {pt[57]} {pt[58]} \
              {pt[59]} {pt[60]} \
              {pt[61]} {pt[62]} \
              {pt[63]} {pt[0]} \
              {key[1]} {key[2]} \
              {key[3]} {key[4]} \
              {key[5]} {key[6]} \
              {key[7]} {key[8]} \
              {key[9]} {key[10]} \
              {key[11]} {key[12]} \
              {key[13]} {key[14]} \
              {key[15]} {key[16]} \
              {key[17]} {key[18]} \
              {key[19]} {key[20]} \
              {key[21]} {key[22]} \
              {key[23]} {key[24]} \
              {key[25]} {key[26]} \
              {key[27]} {key[28]} \
              {key[29]} {key[30]} \
              {key[31]} {key[32]} \
              {key[33]} {key[34]} \
              {key[35]} {key[36]} \
              {key[37]} {key[38]} \
              {key[39]} {key[40]} \
              {key[41]} {key[42]} \
              {key[43]} {key[44]} \
              {key[45]} {key[46]} \
              {key[47]} {key[48]} \
              {key[49]} {key[50]} \
              {key[51]} {key[52]} \
              {key[53]} {key[54]} \
              {key[55]} {key[56]} \
              {key[57]} {key[58]} \
              {key[59]} {key[60]} \
              {key[61]} {key[62]} \
              {key[63]} {key[64]} \
              {key[65]} {key[66]} \
              {key[67]} {key[68]} \
              {key[69]} {key[70]} \
              {key[71]} {key[72]} \
              {key[73]} {key[74]} \
              {key[75]} {key[76]} \
              {key[77]} {key[78]} \
              {key[79]} {key[0]} 
              }
           

edit_pin -fix_overlap 1 \
         -unit MICRON \
         -spread_direction clockwise \
         -side Right \
         -layer 3 \
         -spread_type center \
         -spacing .2 \
         -pin { 
              valid busy \
              {ct[1]} {ct[2]} \
              {ct[3]} {ct[4]} \
              {ct[5]} {ct[6]} \
              {ct[7]} {ct[8]} \
              {ct[9]} {ct[10]} \
              {ct[11]} {ct[12]} \
              {ct[13]} {ct[14]} \
              {ct[15]} {ct[16]} \
              {ct[17]} {ct[18]} \
              {ct[19]} {ct[20]} \
              {ct[21]} {ct[22]} \
              {ct[23]} {ct[24]} \
              {ct[25]} {ct[26]} \
              {ct[27]} {ct[28]} \
              {ct[29]} {ct[30]} \
              {ct[31]} {ct[32]} \
              {ct[33]} {ct[34]} \
              {ct[35]} {ct[36]} \
              {ct[37]} {ct[38]} \
              {ct[39]} {ct[40]} \
              {ct[41]} {ct[42]} \
              {ct[43]} {ct[44]} \
              {ct[45]} {ct[46]} \
              {ct[47]} {ct[48]} \
              {ct[49]} {ct[50]} \
              {ct[51]} {ct[52]} \
              {ct[53]} {ct[54]} \
              {ct[55]} {ct[56]} \
              {ct[57]} {ct[58]} \
              {ct[59]} {ct[60]} \
              {ct[61]} {ct[62]} \
              {ct[63]} {ct[0]} 
              }
               
edit_pin -snap TRACK -pin *
set_db assign_pins_edit_in_batch false
legalize_pins

# suspend 

#########################
# step 4: add power rings 
#########################

add_rings -nets {VDD VSS} \
          -type core_rings \
          -follow core \
          -layer {top M5 bottom M5 left M6 right M6} \
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

# add vertical M4 power stripes
set m4pwrwidth 0.400
set m4pwrspacing 0.400
set m4pwrset2setdist 15

add_stripes -direction vertical \
            -set_to_set_distance $m4pwrset2setdist \
            -spacing $m4pwrspacing \
            -layer M4 \
            -width $m4pwrwidth \
            -nets {VDD VSS} \
            -start_from bottom \
            -start 5

# suspend 

#########################
# step 6: add horizontal power stripes
#########################

# add horizontal M5 power stripes
set m5pwrwidth 0.400 
set m5pwrspacing 0.400
set m5pwrset2setdist 14

add_stripes -direction horizontal \
            -set_to_set_distance $m5pwrset2setdist \
            -spacing $m5pwrspacing \
            -layer M5 \
            -width $m5pwrwidth \
            -nets {VDD VSS} \
            -start_from left \
            -start 4

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
              -crossover_via_layer_range { M1(1) M6(6) } \
              -nets { VDD VSS } \
              -allow_layer_change 0 \
              -target_via_layer_range { M1(1) M6(6) }

# suspend 
#########################
# step 8: placement 
#########################

set_db opt_setup_target_slack 0

place_opt_design 
check_place
# suspend
opt_design -pre_cts

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

###############################
# step 9: clock tree synthesis
###############################

set_db cts_buffer_cells {BUF_X1 BUF_X2 BUF_X4 BUF_X8 BUF_X16 BUF_X32 CLKBUF_X1 CLKBUF_X2 CLKBUF_X3}

ccopt_design
opt_design -post_cts

# suspend 

#########################
# step 10: signal routing
#########################

route_opt_design
opt_design -post_route

# suspend 

#########################
# step 11: score design
#########################

source ../scripts/eval.stylus.tcl



