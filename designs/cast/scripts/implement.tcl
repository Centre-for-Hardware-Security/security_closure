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
set FP_RING_SIZE [expr {$FP_RING_SPACE + 2*$FP_RING_WIDTH + $FP_RING_OFFSET}]

set CELL_HEIGHT 1.4
set CELL_PITCH  0.19


set FP_ROWS 84
set FP_COLS 668


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

# (skip this step)

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
              clk nreset data_rdy key_rdy EncDec \
              {data_in[1]} {data_in[2]} \
              {data_in[3]} {data_in[4]} \
              {data_in[5]} {data_in[6]} \
              {data_in[7]} {data_in[8]} \
              {data_in[9]} {data_in[10]} \
              {data_in[11]} {data_in[12]} \
              {data_in[13]} {data_in[14]} \
              {data_in[15]} {data_in[16]} \
              {data_in[17]} {data_in[18]} \
              {data_in[19]} {data_in[20]} \
              {data_in[21]} {data_in[22]} \
              {data_in[23]} {data_in[24]} \
              {data_in[25]} {data_in[26]} \
              {data_in[27]} {data_in[28]} \
              {data_in[29]} {data_in[30]} \
              {data_in[31]} {data_in[32]} \
              {data_in[33]} {data_in[34]} \
              {data_in[35]} {data_in[36]} \
              {data_in[37]} {data_in[38]} \
              {data_in[39]} {data_in[40]} \
              {data_in[41]} {data_in[42]} \
              {data_in[43]} {data_in[44]} \
              {data_in[45]} {data_in[46]} \
              {data_in[47]} {data_in[48]} \
              {data_in[49]} {data_in[50]} \
              {data_in[51]} {data_in[52]} \
              {data_in[53]} {data_in[54]} \
              {data_in[55]} {data_in[56]} \
              {data_in[57]} {data_in[58]} \
              {data_in[59]} {data_in[60]} \
              {data_in[61]} {data_in[62]} \
              {data_in[63]} {data_in[64]} \
              {data_in[65]} {data_in[66]} \
              {data_in[67]} {data_in[68]} \
              {data_in[69]} {data_in[70]} \
              {data_in[71]} {data_in[72]} \
              {data_in[73]} {data_in[74]} \
              {data_in[75]} {data_in[76]} \
              {data_in[77]} {data_in[78]} \
              {data_in[79]} {data_in[80]} \
              {data_in[81]} {data_in[82]} \
              {data_in[83]} {data_in[84]} \
              {data_in[85]} {data_in[86]} \
              {data_in[87]} {data_in[88]} \
              {data_in[89]} {data_in[90]} \
              {data_in[91]} {data_in[92]} \
              {data_in[93]} {data_in[94]} \
              {data_in[95]} {data_in[96]} \
              {data_in[97]} {data_in[98]} \
              {data_in[99]} {data_in[100]} \
              {data_in[101]} {data_in[102]} \
              {data_in[103]} {data_in[104]} \
              {data_in[105]} {data_in[106]} \
              {data_in[107]} {data_in[108]} \
              {data_in[109]} {data_in[110]} \
              {data_in[111]} {data_in[112]} \
              {data_in[113]} {data_in[114]} \
              {data_in[115]} {data_in[116]} \
              {data_in[117]} {data_in[118]} \
              {data_in[119]} {data_in[120]} \
              {data_in[121]} {data_in[122]} \
              {data_in[123]} {data_in[124]} \
              {data_in[125]} {data_in[126]} \
              {data_in[127]} {data_in[0]} 
              }
           

edit_pin -fix_overlap 1 \
         -unit MICRON \
         -spread_direction clockwise \
         -side Right \
         -layer 3 \
         -spread_type center \
         -spacing .2 \
         -pin { 
              data_valid key_valid busy \
              {data_out[1]} {data_out[2]} \
              {data_out[3]} {data_out[4]} \
              {data_out[5]} {data_out[6]} \
              {data_out[7]} {data_out[8]} \
              {data_out[9]} {data_out[10]} \
              {data_out[11]} {data_out[12]} \
              {data_out[13]} {data_out[14]} \
              {data_out[15]} {data_out[16]} \
              {data_out[17]} {data_out[18]} \
              {data_out[19]} {data_out[20]} \
              {data_out[21]} {data_out[22]} \
              {data_out[23]} {data_out[24]} \
              {data_out[25]} {data_out[26]} \
              {data_out[27]} {data_out[28]} \
              {data_out[29]} {data_out[30]} \
              {data_out[31]} {data_out[32]} \
              {data_out[33]} {data_out[34]} \
              {data_out[35]} {data_out[36]} \
              {data_out[37]} {data_out[38]} \
              {data_out[39]} {data_out[40]} \
              {data_out[41]} {data_out[42]} \
              {data_out[43]} {data_out[44]} \
              {data_out[45]} {data_out[46]} \
              {data_out[47]} {data_out[48]} \
              {data_out[49]} {data_out[50]} \
              {data_out[51]} {data_out[52]} \
              {data_out[53]} {data_out[54]} \
              {data_out[55]} {data_out[56]} \
              {data_out[57]} {data_out[58]} \
              {data_out[59]} {data_out[60]} \
              {data_out[61]} {data_out[62]} \
              {data_out[63]} {data_out[64]} \
              {data_out[65]} {data_out[66]} \
              {data_out[67]} {data_out[68]} \
              {data_out[69]} {data_out[70]} \
              {data_out[71]} {data_out[72]} \
              {data_out[73]} {data_out[74]} \
              {data_out[75]} {data_out[76]} \
              {data_out[77]} {data_out[78]} \
              {data_out[79]} {data_out[80]} \
              {data_out[81]} {data_out[82]} \
              {data_out[83]} {data_out[84]} \
              {data_out[85]} {data_out[86]} \
              {data_out[87]} {data_out[88]} \
              {data_out[89]} {data_out[90]} \
              {data_out[91]} {data_out[92]} \
              {data_out[93]} {data_out[94]} \
              {data_out[95]} {data_out[96]} \
              {data_out[97]} {data_out[98]} \
              {data_out[99]} {data_out[100]} \
              {data_out[101]} {data_out[102]} \
              {data_out[103]} {data_out[104]} \
              {data_out[105]} {data_out[106]} \
              {data_out[107]} {data_out[108]} \
              {data_out[109]} {data_out[110]} \
              {data_out[111]} {data_out[112]} \
              {data_out[113]} {data_out[114]} \
              {data_out[115]} {data_out[116]} \
              {data_out[117]} {data_out[118]} \
              {data_out[119]} {data_out[120]} \
              {data_out[121]} {data_out[122]} \
              {data_out[123]} {data_out[124]} \
              {data_out[125]} {data_out[126]} \
              {data_out[127]} {data_out[0]} 
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
suspend
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



