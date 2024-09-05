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

# 1.685

set CELL_HEIGHT 1.4
set CELL_PITCH  0.19

set FP_ROWS 67
set FP_COLS 490


set FP_HEIGHT [expr $CELL_HEIGHT * $FP_ROWS ]
set FP_WIDTH [expr $CELL_PITCH * $FP_COLS]

delete_all_floorplan_objs

set init_pwr_net {VDD}
set init_gnd_net {VSS}

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
               dbg_en cpu_en dbg_i2c_scl \
               dbg_i2c_sda_in dbg_uart_rxd dco_clk lfxt_clk \
               dma_en dma_priority dma_wkup \
               nmi reset_n scan_enable \
               scan_mode wkup \
               {dbg_i2c_addr[0]} {dbg_i2c_addr[1]} \
               {dbg_i2c_addr[2]} {dbg_i2c_addr[3]} \
               {dbg_i2c_addr[4]} {dbg_i2c_addr[5]} \
               {dbg_i2c_addr[6]} \
               {dbg_i2c_broadcast[0]} {dbg_i2c_broadcast[1]} \
               {dbg_i2c_broadcast[2]} {dbg_i2c_broadcast[3]} \
               {dbg_i2c_broadcast[4]} {dbg_i2c_broadcast[5]} \
               {dbg_i2c_broadcast[6]} \
               {dmem_dout[0]} {dmem_dout[1]} \
               {dmem_dout[2]} {dmem_dout[3]} \
               {dmem_dout[4]} {dmem_dout[5]} \
               {dmem_dout[6]} {dmem_dout[7]} \
               {dmem_dout[8]} {dmem_dout[9]} \
               {dmem_dout[10]} {dmem_dout[11]} \
               {dmem_dout[12]} {dmem_dout[13]} \
               {dmem_dout[14]} {dmem_dout[15]}\
               {irq[0]} {irq[1]} \
               {irq[2]} {irq[3]} \
               {irq[4]} {irq[5]} \
               {irq[6]} {irq[7]} \
               {irq[8]} {irq[9]} \
               {irq[10]} {irq[11]} \
               {irq[12]} {irq[13]} \
               {dma_addr[1]} {dma_addr[2]} \
               {dma_addr[3]} {dma_addr[4]} \
               {dma_addr[5]} {dma_addr[6]} \
               {dma_addr[7]} {dma_addr[8]} \
               {dma_addr[9]} {dma_addr[10]} \
               {dma_addr[11]} {dma_addr[12]} \
               {dma_addr[13]} {dma_addr[14]} \
               {dma_addr[15]} \
               {dma_din[0]} {dma_din[1]} \
               {dma_din[2]} {dma_din[3]} \
               {dma_din[4]} {dma_din[5]} \
               {dma_din[6]} {dma_din[7]} \
               {dma_din[8]} {dma_din[9]} \
               {dma_din[10]} {dma_din[11]} \
               {dma_din[12]} {dma_din[13]} \
               {dma_din[14]} {dma_din[15]} \
               {dma_we[0]} {dma_we[1]} \
               {per_dout[0]} {per_dout[1]} \
               {per_dout[2]} {per_dout[3]} \
               {per_dout[4]} {per_dout[5]} \
               {per_dout[6]} {per_dout[7]} \
               {per_dout[8]} {per_dout[9]} \
               {per_dout[10]} {per_dout[11]} \
               {per_dout[12]} {per_dout[13]} \
               {per_dout[14]} {per_dout[15]} \
               {pmem_dout[0]} {pmem_dout[1]} \
               {pmem_dout[2]} {pmem_dout[3]} \
               {pmem_dout[4]} {pmem_dout[5]} \
               {pmem_dout[6]} {pmem_dout[7]} \
               {pmem_dout[8]} {pmem_dout[9]} \
               {pmem_dout[10]} {pmem_dout[11]} \
               {pmem_dout[12]} {pmem_dout[13]} \
               {pmem_dout[14]} {pmem_dout[15]}
               }

               
           

edit_pin -fix_overlap 1 \
         -unit MICRON \
         -spread_direction clockwise \
         -side Right \
         -layer 3 \
         -spread_type center \
         -spacing .2 \
         -pin { 
              aclk aclk_en dbg_freeze \
              dbg_i2c_sda_out dbg_uart_txd dco_enable \
              dco_wkup dmem_cen lfxt_enable \
              lfxt_wkup mclk dma_ready \
              dma_resp per_en pmem_cen \
              puc_rst smclk smclk_en \
              {dmem_din[0]} {dmem_din[1]} \
              {dmem_din[2]} {dmem_din[3]} \
              {dmem_din[4]} {dmem_din[5]} \
              {dmem_din[6]} {dmem_din[7]} \
              {dmem_din[8]} {dmem_din[9]} \
              {dmem_din[10]} {dmem_din[11]} \
              {dmem_din[12]} {dmem_din[13]} \
              {dmem_din[14]} {dmem_din[15]} \
              {dma_dout[0]} {dma_dout[1]} \
              {dma_dout[2]} {dma_dout[3]} \
              {dma_dout[4]} {dma_dout[5]} \
              {dma_dout[6]} {dma_dout[7]} \
              {dma_dout[8]} {dma_dout[9]} \
              {dma_dout[10]} {dma_dout[11]} \
              {dma_dout[12]} {dma_dout[13]} \
              {dma_dout[14]} {dma_dout[15]} \
              {per_din[0]} {per_din[1]} \
              {per_din[2]} {per_din[3]} \
              {per_din[4]} {per_din[5]} \
              {per_din[6]} {per_din[7]} \
              {per_din[8]} {per_din[9]} \
              {per_din[10]} {per_din[11]} \
              {per_din[12]} {per_din[13]} \
              {per_din[14]} {per_din[15]} \
              {pmem_din[0]} {pmem_din[1]} \
              {pmem_din[2]} {pmem_din[3]} \
              {pmem_din[4]} {pmem_din[5]} \
              {pmem_din[6]} {pmem_din[7]} \
              {pmem_din[8]} {pmem_din[9]} \
              {pmem_din[10]} {pmem_din[11]} \
              {pmem_din[12]} {pmem_din[13]} \
              {pmem_din[14]} {pmem_din[15]} \
              {dmem_wen[0]} {dmem_wen[1]} \
              {pmem_wen[0]} {pmem_wen[1]} \
              {per_we[0]} {per_we[1]} \
              {irq_acc[0]} {irq_acc[1]} \
              {irq_acc[2]} {irq_acc[3]} \
              {irq_acc[4]} {irq_acc[5]} \
              {irq_acc[6]} {irq_acc[7]} \
              {irq_acc[8]} {irq_acc[9]} \
              {irq_acc[10]} {irq_acc[11]} \
              {irq_acc[12]} {irq_acc[13]} \
              {per_addr[0]} {per_addr[1]} \
              {per_addr[2]} {per_addr[3]} \
              {per_addr[4]} {per_addr[5]} \
              {per_addr[6]} {per_addr[7]} \
              {per_addr[8]} {per_addr[9]} \
              {per_addr[10]} {per_addr[11]} \
              {per_addr[12]} {per_addr[13]} \
              {pmem_addr[0]} {pmem_addr[1]} \
              {pmem_addr[2]} {pmem_addr[3]} \
              {pmem_addr[4]} {pmem_addr[5]} \
              {pmem_addr[6]} {pmem_addr[7]} \
              {pmem_addr[8]} {pmem_addr[9]} \
              {pmem_addr[10]} \
              {dmem_addr[0]} {dmem_addr[1]} \
              {dmem_addr[2]} {dmem_addr[3]} \
              {dmem_addr[4]} {dmem_addr[5]} \
              {dmem_addr[6]} {dmem_addr[7]} \
              {dmem_addr[8]} 
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
set m4pwrstart 9.18

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
set m5pwrstart 9.060
# set m5pwrstop [expr {$FP_HEIGHT - 11.6 + 3.595}]


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

# set_db route_
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

update_power_via -add_vias 1 -orthogonal_only 0

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



