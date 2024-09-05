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

set FP_ROWS 44
set FP_COLS 320

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
         -spacing .1 \
         -pin { 
              drdy krdy enc \
              rstn en clk \ 
              {din[1]} {din[2]} \
              {din[3]} {din[4]} \
              {din[5]} {din[6]} \
              {din[7]} {din[8]} \
              {din[9]} {din[10]} \
              {din[11]} {din[12]} \
              {din[13]} {din[14]} \
              {din[15]} {din[16]} \
              {din[17]} {din[18]} \
              {din[19]} {din[20]} \
              {din[21]} {din[22]} \
              {din[23]} {din[24]} \
              {din[25]} {din[26]} \
              {din[27]} {din[28]} \
              {din[29]} {din[30]} \
              {din[31]} {din[32]} \
              {din[33]} {din[34]} \
              {din[35]} {din[36]} \
              {din[37]} {din[38]} \
              {din[39]} {din[40]} \
              {din[41]} {din[42]} \
              {din[43]} {din[44]} \
              {din[45]} {din[46]} \
              {din[47]} {din[48]} \
              {din[49]} {din[50]} \
              {din[51]} {din[52]} \
              {din[53]} {din[54]} \
              {din[55]} {din[56]} \
              {din[57]} {din[58]} \
              {din[59]} {din[60]} \
              {din[61]} {din[62]} \
              {din[63]} {din[64]} \
              {key1[1]} {key1[2]} \
              {key1[3]} {key1[4]} \
              {key1[5]} {key1[6]} \
              {key1[7]} {key1[8]} \
              {key1[9]} {key1[10]} \
              {key1[11]} {key1[12]} \
              {key1[13]} {key1[14]} \
              {key1[15]} {key1[16]} \
              {key1[17]} {key1[18]} \
              {key1[19]} {key1[20]} \
              {key1[21]} {key1[22]} \
              {key1[23]} {key1[24]} \
              {key1[25]} {key1[26]} \
              {key1[27]} {key1[28]} \
              {key1[29]} {key1[30]} \
              {key1[31]} {key1[32]} \
              {key1[33]} {key1[34]} \
              {key1[35]} {key1[36]} \
              {key1[37]} {key1[38]} \
              {key1[39]} {key1[40]} \
              {key1[41]} {key1[42]} \
              {key1[43]} {key1[44]} \
              {key1[45]} {key1[46]} \
              {key1[47]} {key1[48]} \
              {key1[49]} {key1[50]} \
              {key1[51]} {key1[52]} \
              {key1[53]} {key1[54]} \
              {key1[55]} {key1[56]} \
              {key1[57]} {key1[58]} \
              {key1[59]} {key1[60]} \
              {key1[61]} {key1[62]} \
              {key1[63]} \
              {key2[1]} {key2[2]} \
              {key2[3]} {key2[4]} \
              {key2[5]} {key2[6]} \
              {key2[7]} {key2[8]} \
              {key2[9]} {key2[10]} \
              {key2[11]} {key2[12]} \
              {key2[13]} {key2[14]} \
              {key2[15]} {key2[16]} \
              {key2[17]} {key2[18]} \
              {key2[19]} {key2[20]} \
              {key2[21]} {key2[22]} \
              {key2[23]} {key2[24]} \
              {key2[25]} {key2[26]} \
              {key2[27]} {key2[28]} \
              {key2[29]} {key2[30]} \
              {key2[31]} {key2[32]} \
              {key2[33]} {key2[34]} \
              {key2[35]} {key2[36]} \
              {key2[37]} {key2[38]} \
              {key2[39]} {key2[40]} \
              {key2[41]} {key2[42]} \
              {key2[43]} {key2[44]} \
              {key2[45]} {key2[46]} \
              {key2[47]} {key2[48]} \
              {key2[49]} {key2[50]} \
              {key2[51]} {key2[52]} \
              {key2[53]} {key2[54]} \
              {key2[55]} {key2[56]} \
              {key2[57]} {key2[58]} \
              {key2[59]} {key2[60]} \
              {key2[61]} {key2[62]} \
              {key2[63]} \
              {key3[1]} {key3[2]} \
              {key3[3]} {key3[4]} \
              {key3[5]} {key3[6]} \
              {key3[7]} {key3[8]} \
              {key3[9]} {key3[10]} \
              {key3[11]} {key3[12]} \
              {key3[13]} {key3[14]} \
              {key3[15]} {key3[16]} \
              {key3[17]} {key3[18]} \
              {key3[19]} {key3[20]} \
              {key3[21]} {key3[22]} \
              {key3[23]} {key3[24]} \
              {key3[25]} {key3[26]} \
              {key3[27]} {key3[28]} \
              {key3[29]} {key3[30]} \
              {key3[31]} {key3[32]} \
              {key3[33]} {key3[34]} \
              {key3[35]} {key3[36]} \
              {key3[37]} {key3[38]} \
              {key3[39]} {key3[40]} \
              {key3[41]} {key3[42]} \
              {key3[43]} {key3[44]} \
              {key3[45]} {key3[46]} \
              {key3[47]} {key3[48]} \
              {key3[49]} {key3[50]} \
              {key3[51]} {key3[52]} \
              {key3[53]} {key3[54]} \
              {key3[55]} {key3[56]} \
              {key3[57]} {key3[58]} \
              {key3[59]} {key3[60]} \
              {key3[61]} {key3[62]} \
              {key3[63]} 
              }
           

edit_pin -fix_overlap 1 \
         -unit MICRON \
         -spread_direction clockwise \
         -side Right \
         -layer 3 \
         -spread_type center \
         -spacing .1 \
         -pin { 
              bsy dvld \
              {dout[1]} {dout[2]} \
              {dout[3]} {dout[4]} \
              {dout[5]} {dout[6]} \
              {dout[7]} {dout[8]} \
              {dout[9]} {dout[10]} \
              {dout[11]} {dout[12]} \
              {dout[13]} {dout[14]} \
              {dout[15]} {dout[16]} \
              {dout[17]} {dout[18]} \
              {dout[19]} {dout[20]} \
              {dout[21]} {dout[22]} \
              {dout[23]} {dout[24]} \
              {dout[25]} {dout[26]} \
              {dout[27]} {dout[28]} \
              {dout[29]} {dout[30]} \
              {dout[31]} {dout[32]} \
              {dout[33]} {dout[34]} \
              {dout[35]} {dout[36]} \
              {dout[37]} {dout[38]} \
              {dout[39]} {dout[40]} \
              {dout[41]} {dout[42]} \
              {dout[43]} {dout[44]} \
              {dout[45]} {dout[46]} \
              {dout[47]} {dout[48]} \
              {dout[49]} {dout[50]} \
              {dout[51]} {dout[52]} \
              {dout[53]} {dout[54]} \
              {dout[55]} {dout[56]} \
              {dout[57]} {dout[58]} \
              {dout[59]} {dout[60]} \
              {dout[61]} {dout[62]} \
              {dout[63]} {dout[64]} \  
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

set m4pwrwidth 0.400
set m4pwrspacing 0.400
set m4pwrset2setdist 15

add_stripes -direction vertical \
            -set_to_set_distance $m4pwrset2setdist \
            -spacing $m4pwrspacing \
            -layer M4 \
            -width $m4pwrwidth \
            -nets {VDD VSS} \
            -start_from bottom 

# suspend 

#########################
# step 6: add horizontal power stripes
#########################

set m5pwrwidth 0.400 
set m5pwrspacing 0.400
set m5pwrset2setdist 15

add_stripes -direction horizontal \
            -set_to_set_distance $m5pwrset2setdist \
            -spacing $m5pwrspacing \
            -layer M5 \
            -width $m5pwrwidth \
            -nets {VDD VSS} \
            -start_from left 

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



