set VERSION 21

################################################################################
# step 0: setup (copied from "load_design.stylus.tcl")
################################################################################

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

################################################################################
# step 1: floorplanning
################################################################################

# define top + bottom routing layers (AES uses M1-10, others use M1-6)
set_db design_bottom_routing_layer 1
set_db design_top_routing_layer 6

# define VDD + VSS for the standard cells 
connect_global_net VDD -type pg_pin \
                       -pin_base_name VDD \
                       -inst_base_name * \
                       -override 
connect_global_net VSS -type pg_pin \
                       -pin_base_name VSS \
                       -inst_base_name * 

# set vars 
set FP_RING_OFFSET 0.095 ;  # space between core and first ring
set FP_RING_WIDTH  0.800 ;  # width of each ring
set FP_RING_SPACE  0.800 ;  # space between rings
set FP_RING_SIZE [expr {$FP_RING_SPACE + 2*$FP_RING_WIDTH + $FP_RING_OFFSET}]

# defined by library 
set CELL_HEIGHT 1.4
set CELL_PITCH  0.19

# rows/cols control the chip area 
set FP_ROWS 100
set FP_COLS 720

# calculate FP width + height 
set FP_HEIGHT [expr $CELL_HEIGHT * $FP_ROWS] ; # floorplan height
set FP_WIDTH  [expr $CELL_PITCH * $FP_COLS]   ; # floorplan width

# delete given design before reimplementing ours 
delete_all_floorplan_objs

# create floorplan 
create_floorplan -site FreePDK45_38x28_10R_NP_162NW_34O \
                 -core_size $FP_WIDTH \
                            $FP_HEIGHT \
                            $FP_RING_SIZE \
                            $FP_RING_SIZE \
                            $FP_RING_SIZE \
                            $FP_RING_SIZE \
                 -no_snap_to_grid

# suspend

################################################################################
# step 2: add tap cells
################################################################################

# skip this step 

################################################################################
# step 3: place pins
################################################################################

# competition rules require all inputs on the left, all outputs on the right
# pins are defined as inputs/outputs in "../originals/design_original.v"

# not really sure what this cmd does 
set_db assign_pins_edit_in_batch true

# define pin placements for all inputs 
edit_pin -fix_overlap 1 \
         -unit MICRON \
         -spread_direction clockwise \
         -side left \
         -layer 3 \
         -spread_type center \
         -spacing .2 \
         -pin {clock resetn enc_dec key_exp start \
              {text_in[1]} {text_in[2]} \
              {text_in[3]} {text_in[4]} \
              {text_in[5]} {text_in[6]} \
              {text_in[7]} {text_in[8]} \
              {text_in[9]} {text_in[10]} \
              {text_in[11]} {text_in[12]} \
              {text_in[13]} {text_in[14]} \
              {text_in[15]} {text_in[16]} \
              {text_in[17]} {text_in[18]} \
              {text_in[19]} {text_in[20]} \
              {text_in[21]} {text_in[22]} \
              {text_in[23]} {text_in[24]} \
              {text_in[25]} {text_in[26]} \
              {text_in[27]} {text_in[28]} \
              {text_in[29]} {text_in[30]} \
              {text_in[31]} {text_in[32]} \
              {text_in[33]} {text_in[34]} \
              {text_in[35]} {text_in[36]} \
              {text_in[37]} {text_in[38]} \
              {text_in[39]} {text_in[40]} \
              {text_in[41]} {text_in[42]} \
              {text_in[43]} {text_in[44]} \
              {text_in[45]} {text_in[46]} \
              {text_in[47]} {text_in[48]} \
              {text_in[49]} {text_in[50]} \
              {text_in[51]} {text_in[52]} \
              {text_in[53]} {text_in[54]} \
              {text_in[55]} {text_in[56]} \
              {text_in[57]} {text_in[58]} \
              {text_in[59]} {text_in[60]} \
              {text_in[61]} {text_in[62]} \
              {text_in[63]} {text_in[64]} \
              {text_in[65]} {text_in[66]} \
              {text_in[67]} {text_in[68]} \
              {text_in[69]} {text_in[70]} \
              {text_in[71]} {text_in[72]} \
              {text_in[73]} {text_in[74]} \
              {text_in[75]} {text_in[76]} \
              {text_in[77]} {text_in[78]} \
              {text_in[79]} {text_in[80]} \
              {text_in[81]} {text_in[82]} \
              {text_in[83]} {text_in[84]} \
              {text_in[85]} {text_in[86]} \
              {text_in[87]} {text_in[88]} \
              {text_in[89]} {text_in[90]} \
              {text_in[91]} {text_in[92]} \
              {text_in[93]} {text_in[94]} \
              {text_in[95]} {text_in[96]} \
              {text_in[97]} {text_in[98]} \
              {text_in[99]} {text_in[100]} \
              {text_in[101]} {text_in[102]} \
              {text_in[103]} {text_in[104]} \
              {text_in[105]} {text_in[106]} \
              {text_in[107]} {text_in[108]} \
              {text_in[109]} {text_in[110]} \
              {text_in[111]} {text_in[112]} \
              {text_in[113]} {text_in[114]} \
              {text_in[115]} {text_in[116]} \
              {text_in[117]} {text_in[118]} \
              {text_in[119]} {text_in[120]} \
              {text_in[121]} {text_in[122]} \
              {text_in[123]} {text_in[124]} \
              {text_in[125]} {text_in[126]} \
              {text_in[127]} {text_in[0]} 
              {key_in[1]} {key_in[2]} \
              {key_in[3]} {key_in[4]} \
              {key_in[5]} {key_in[6]} \
              {key_in[7]} {key_in[8]} \
              {key_in[9]} {key_in[10]} \
              {key_in[11]} {key_in[12]} \
              {key_in[13]} {key_in[14]} \
              {key_in[15]} {key_in[16]} \
              {key_in[17]} {key_in[18]} \
              {key_in[19]} {key_in[20]} \
              {key_in[21]} {key_in[22]} \
              {key_in[23]} {key_in[24]} \
              {key_in[25]} {key_in[26]} \
              {key_in[27]} {key_in[28]} \
              {key_in[29]} {key_in[30]} \
              {key_in[31]} {key_in[32]} \
              {key_in[33]} {key_in[34]} \
              {key_in[35]} {key_in[36]} \
              {key_in[37]} {key_in[38]} \
              {key_in[39]} {key_in[40]} \
              {key_in[41]} {key_in[42]} \
              {key_in[43]} {key_in[44]} \
              {key_in[45]} {key_in[46]} \
              {key_in[47]} {key_in[48]} \
              {key_in[49]} {key_in[50]} \
              {key_in[51]} {key_in[52]} \
              {key_in[53]} {key_in[54]} \
              {key_in[55]} {key_in[56]} \
              {key_in[57]} {key_in[58]} \
              {key_in[59]} {key_in[60]} \
              {key_in[61]} {key_in[62]} \
              {key_in[63]} {key_in[64]} \
              {key_in[65]} {key_in[66]} \
              {key_in[67]} {key_in[68]} \
              {key_in[69]} {key_in[70]} \
              {key_in[71]} {key_in[72]} \
              {key_in[73]} {key_in[74]} \
              {key_in[75]} {key_in[76]} \
              {key_in[77]} {key_in[78]} \
              {key_in[79]} {key_in[80]} \
              {key_in[81]} {key_in[82]} \
              {key_in[83]} {key_in[84]} \
              {key_in[85]} {key_in[86]} \
              {key_in[87]} {key_in[88]} \
              {key_in[89]} {key_in[90]} \
              {key_in[91]} {key_in[92]} \
              {key_in[93]} {key_in[94]} \
              {key_in[95]} {key_in[96]} \
              {key_in[97]} {key_in[98]} \
              {key_in[99]} {key_in[100]} \
              {key_in[101]} {key_in[102]} \
              {key_in[103]} {key_in[104]} \
              {key_in[105]} {key_in[106]} \
              {key_in[107]} {key_in[108]} \
              {key_in[109]} {key_in[110]} \
              {key_in[111]} {key_in[112]} \
              {key_in[113]} {key_in[114]} \
              {key_in[115]} {key_in[116]} \
              {key_in[117]} {key_in[118]} \
              {key_in[119]} {key_in[120]} \
              {key_in[121]} {key_in[122]} \
              {key_in[123]} {key_in[124]} \
              {key_in[125]} {key_in[126]} \
              {key_in[127]} {key_in[0]}}
           
# define pin placements for all outputs 
edit_pin -fix_overlap 1 \
         -unit MICRON \
         -spread_direction clockwise \
         -side Right \
         -layer 3 \
         -spread_type center \
         -spacing .2 \
         -pin {key_val text_val busy \
              {text_out[1]} {text_out[2]} \
              {text_out[3]} {text_out[4]} \
              {text_out[5]} {text_out[6]} \
              {text_out[7]} {text_out[8]} \
              {text_out[9]} {text_out[10]} \
              {text_out[11]} {text_out[12]} \
              {text_out[13]} {text_out[14]} \
              {text_out[15]} {text_out[16]} \
              {text_out[17]} {text_out[18]} \
              {text_out[19]} {text_out[20]} \
              {text_out[21]} {text_out[22]} \
              {text_out[23]} {text_out[24]} \
              {text_out[25]} {text_out[26]} \
              {text_out[27]} {text_out[28]} \
              {text_out[29]} {text_out[30]} \
              {text_out[31]} {text_out[32]} \
              {text_out[33]} {text_out[34]} \
              {text_out[35]} {text_out[36]} \
              {text_out[37]} {text_out[38]} \
              {text_out[39]} {text_out[40]} \
              {text_out[41]} {text_out[42]} \
              {text_out[43]} {text_out[44]} \
              {text_out[45]} {text_out[46]} \
              {text_out[47]} {text_out[48]} \
              {text_out[49]} {text_out[50]} \
              {text_out[51]} {text_out[52]} \
              {text_out[53]} {text_out[54]} \
              {text_out[55]} {text_out[56]} \
              {text_out[57]} {text_out[58]} \
              {text_out[59]} {text_out[60]} \
              {text_out[61]} {text_out[62]} \
              {text_out[63]} {text_out[64]} \
              {text_out[65]} {text_out[66]} \
              {text_out[67]} {text_out[68]} \
              {text_out[69]} {text_out[70]} \
              {text_out[71]} {text_out[72]} \
              {text_out[73]} {text_out[74]} \
              {text_out[75]} {text_out[76]} \
              {text_out[77]} {text_out[78]} \
              {text_out[79]} {text_out[80]} \
              {text_out[81]} {text_out[82]} \
              {text_out[83]} {text_out[84]} \
              {text_out[85]} {text_out[86]} \
              {text_out[87]} {text_out[88]} \
              {text_out[89]} {text_out[90]} \
              {text_out[91]} {text_out[92]} \
              {text_out[93]} {text_out[94]} \
              {text_out[95]} {text_out[96]} \
              {text_out[97]} {text_out[98]} \
              {text_out[99]} {text_out[100]} \
              {text_out[101]} {text_out[102]} \
              {text_out[103]} {text_out[104]} \
              {text_out[105]} {text_out[106]} \
              {text_out[107]} {text_out[108]} \
              {text_out[109]} {text_out[110]} \
              {text_out[111]} {text_out[112]} \
              {text_out[113]} {text_out[114]} \
              {text_out[115]} {text_out[116]} \
              {text_out[117]} {text_out[118]} \
              {text_out[119]} {text_out[120]} \
              {text_out[121]} {text_out[122]} \
              {text_out[123]} {text_out[124]} \
              {text_out[125]} {text_out[126]} \
              {text_out[127]} {text_out[0]}}
               
# not really sure what these cmds do  
edit_pin -snap TRACK -pin *
set_db assign_pins_edit_in_batch false
legalize_pins

# suspend 

################################################################################
# step 4: add power rings 
################################################################################

# add core power rings 
add_rings -nets {VDD VSS} \
          -type core_rings \
          -follow core \
          -layer {top M5 \
                  bottom M5 \
                  left M6 \
                  right M6} \
          -width $FP_RING_WIDTH \
          -spacing $FP_RING_SPACE \
          -offset $FP_RING_OFFSET \
          -center 0 \
          -threshold 0 \
          -jog_distance 0 \
          -snap_wire_center_to_grid None 

# suspend 

################################################################################
# step 5: add vertical power stripes 
################################################################################

# set vars 
set m4pwrwidth 0.400    ; # width of each stripe
set m4pwrspacing 0.400  ; # space between stripes
set m4pwrset2setdist 15 ; # space between the start of each set of stripes 

# add vertical power stripes (M4)
add_stripes -direction vertical \
            -set_to_set_distance $m4pwrset2setdist \
            -spacing $m4pwrspacing \
            -layer M4 \
            -width $m4pwrwidth \
            -nets {VDD VSS} \
            -start_from bottom 

# suspend 

################################################################################
# step 6: add horizontal power stripes
################################################################################

# set vars 
set m5pwrwidth 0.400    ; # width of each stripe
set m5pwrspacing 0.400  ; # space between stripes
set m5pwrset2setdist 15 ; # space between the start of each set of stripes 

# add horizontal power stripes (M5)
add_stripes -direction horizontal \
            -set_to_set_distance $m5pwrset2setdist \
            -spacing $m5pwrspacing \
            -layer M5 \
            -width $m5pwrwidth \
            -nets {VDD VSS} \
            -start_from left 

# suspend 

################################################################################
# step 7: add standard cell power rails 
################################################################################

# not sure what this cmd does 
set_db route_special_via_connect_to_shape {noshape}

# add power rails (M1)
route_special -connect {corePin} \
              -block_pin_target {nearestTarget} \
              -floating_stripe_target {blockring \
                                       padring \
                                       ring stripe \
                                       ringpin \
                                       blockpin \
                                       followpin} \
              -delete_existing_routes \
              -allow_jogging 0 \
              -crossover_via_layer_range {M1(1) M6(6)} \
              -nets {VDD VSS} \
              -allow_layer_change 0 \
              -target_via_layer_range {M1(1) M6(6)}

# suspend 

################################################################################
# step 8: placement 
################################################################################

# set setup target slack to 0
set_db opt_setup_target_slack 0

# run placement + optimize 
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

################################################################################
# step 9: clock tree synthesis
################################################################################

# not entirely sure what this does, prevents some errors
set_db cts_buffer_cells {BUF_X1 \
                         BUF_X2 \
                         BUF_X4 \
                         BUF_X8 \
                         BUF_X16 \
                         BUF_X32 \
                         CLKBUF_X1 \
                         CLKBUF_X2 \
                         CLKBUF_X3}

# run cts + optimize  
ccopt_design
opt_design -post_cts

# suspend 

################################################################################
# step 10: signal routing
################################################################################

# route nets + optimize 
route_opt_design
opt_design -post_route

# suspend 

################################################################################
# step 11: score design
################################################################################

# score design 
source ../scripts/eval.stylus.tcl



