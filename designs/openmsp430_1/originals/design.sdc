###################################################################

# Created by write_sdc on Tue Mar  1 15:27:22 2022

###################################################################
set sdc_version 2.0

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current mA
create_clock [get_ports dco_clk]  -period 30  -waveform {0 15}
create_clock [get_ports lfxt_clk]  -period 30  -waveform {0 15}
group_path -name FEEDTHROUGH  -from [list [get_ports cpu_en] [get_ports dbg_en] [get_ports                  \
{dbg_i2c_addr[6]}] [get_ports {dbg_i2c_addr[5]}] [get_ports {dbg_i2c_addr[4]}] \
[get_ports {dbg_i2c_addr[3]}] [get_ports {dbg_i2c_addr[2]}] [get_ports         \
{dbg_i2c_addr[1]}] [get_ports {dbg_i2c_addr[0]}] [get_ports                    \
{dbg_i2c_broadcast[6]}] [get_ports {dbg_i2c_broadcast[5]}] [get_ports          \
{dbg_i2c_broadcast[4]}] [get_ports {dbg_i2c_broadcast[3]}] [get_ports          \
{dbg_i2c_broadcast[2]}] [get_ports {dbg_i2c_broadcast[1]}] [get_ports          \
{dbg_i2c_broadcast[0]}] [get_ports dbg_i2c_scl] [get_ports dbg_i2c_sda_in]     \
[get_ports dbg_uart_rxd] [get_ports {dmem_dout[15]}] [get_ports                \
{dmem_dout[14]}] [get_ports {dmem_dout[13]}] [get_ports {dmem_dout[12]}]       \
[get_ports {dmem_dout[11]}] [get_ports {dmem_dout[10]}] [get_ports             \
{dmem_dout[9]}] [get_ports {dmem_dout[8]}] [get_ports {dmem_dout[7]}]          \
[get_ports {dmem_dout[6]}] [get_ports {dmem_dout[5]}] [get_ports               \
{dmem_dout[4]}] [get_ports {dmem_dout[3]}] [get_ports {dmem_dout[2]}]          \
[get_ports {dmem_dout[1]}] [get_ports {dmem_dout[0]}] [get_ports {irq[13]}]    \
[get_ports {irq[12]}] [get_ports {irq[11]}] [get_ports {irq[10]}] [get_ports   \
{irq[9]}] [get_ports {irq[8]}] [get_ports {irq[7]}] [get_ports {irq[6]}]       \
[get_ports {irq[5]}] [get_ports {irq[4]}] [get_ports {irq[3]}] [get_ports      \
{irq[2]}] [get_ports {irq[1]}] [get_ports {irq[0]}] [get_ports lfxt_clk]       \
[get_ports {dma_addr[15]}] [get_ports {dma_addr[14]}] [get_ports               \
{dma_addr[13]}] [get_ports {dma_addr[12]}] [get_ports {dma_addr[11]}]          \
[get_ports {dma_addr[10]}] [get_ports {dma_addr[9]}] [get_ports {dma_addr[8]}] \
[get_ports {dma_addr[7]}] [get_ports {dma_addr[6]}] [get_ports {dma_addr[5]}]  \
[get_ports {dma_addr[4]}] [get_ports {dma_addr[3]}] [get_ports {dma_addr[2]}]  \
[get_ports {dma_addr[1]}] [get_ports {dma_din[15]}] [get_ports {dma_din[14]}]  \
[get_ports {dma_din[13]}] [get_ports {dma_din[12]}] [get_ports {dma_din[11]}]  \
[get_ports {dma_din[10]}] [get_ports {dma_din[9]}] [get_ports {dma_din[8]}]    \
[get_ports {dma_din[7]}] [get_ports {dma_din[6]}] [get_ports {dma_din[5]}]     \
[get_ports {dma_din[4]}] [get_ports {dma_din[3]}] [get_ports {dma_din[2]}]     \
[get_ports {dma_din[1]}] [get_ports {dma_din[0]}] [get_ports dma_en]           \
[get_ports dma_priority] [get_ports {dma_we[1]}] [get_ports {dma_we[0]}]       \
[get_ports dma_wkup] [get_ports nmi] [get_ports {per_dout[15]}] [get_ports     \
{per_dout[14]}] [get_ports {per_dout[13]}] [get_ports {per_dout[12]}]          \
[get_ports {per_dout[11]}] [get_ports {per_dout[10]}] [get_ports               \
{per_dout[9]}] [get_ports {per_dout[8]}] [get_ports {per_dout[7]}] [get_ports  \
{per_dout[6]}] [get_ports {per_dout[5]}] [get_ports {per_dout[4]}] [get_ports  \
{per_dout[3]}] [get_ports {per_dout[2]}] [get_ports {per_dout[1]}] [get_ports  \
{per_dout[0]}] [get_ports {pmem_dout[15]}] [get_ports {pmem_dout[14]}]         \
[get_ports {pmem_dout[13]}] [get_ports {pmem_dout[12]}] [get_ports             \
{pmem_dout[11]}] [get_ports {pmem_dout[10]}] [get_ports {pmem_dout[9]}]        \
[get_ports {pmem_dout[8]}] [get_ports {pmem_dout[7]}] [get_ports               \
{pmem_dout[6]}] [get_ports {pmem_dout[5]}] [get_ports {pmem_dout[4]}]          \
[get_ports {pmem_dout[3]}] [get_ports {pmem_dout[2]}] [get_ports               \
{pmem_dout[1]}] [get_ports {pmem_dout[0]}] [get_ports reset_n] [get_ports      \
scan_enable] [get_ports scan_mode] [get_ports wkup]]  -to [list [get_ports aclk] [get_ports aclk_en] [get_ports dbg_freeze]         \
[get_ports dbg_i2c_sda_out] [get_ports dbg_uart_txd] [get_ports dco_enable]    \
[get_ports dco_wkup] [get_ports {dmem_addr[8]}] [get_ports {dmem_addr[7]}]     \
[get_ports {dmem_addr[6]}] [get_ports {dmem_addr[5]}] [get_ports               \
{dmem_addr[4]}] [get_ports {dmem_addr[3]}] [get_ports {dmem_addr[2]}]          \
[get_ports {dmem_addr[1]}] [get_ports {dmem_addr[0]}] [get_ports dmem_cen]     \
[get_ports {dmem_din[15]}] [get_ports {dmem_din[14]}] [get_ports               \
{dmem_din[13]}] [get_ports {dmem_din[12]}] [get_ports {dmem_din[11]}]          \
[get_ports {dmem_din[10]}] [get_ports {dmem_din[9]}] [get_ports {dmem_din[8]}] \
[get_ports {dmem_din[7]}] [get_ports {dmem_din[6]}] [get_ports {dmem_din[5]}]  \
[get_ports {dmem_din[4]}] [get_ports {dmem_din[3]}] [get_ports {dmem_din[2]}]  \
[get_ports {dmem_din[1]}] [get_ports {dmem_din[0]}] [get_ports {dmem_wen[1]}]  \
[get_ports {dmem_wen[0]}] [get_ports {irq_acc[13]}] [get_ports {irq_acc[12]}]  \
[get_ports {irq_acc[11]}] [get_ports {irq_acc[10]}] [get_ports {irq_acc[9]}]   \
[get_ports {irq_acc[8]}] [get_ports {irq_acc[7]}] [get_ports {irq_acc[6]}]     \
[get_ports {irq_acc[5]}] [get_ports {irq_acc[4]}] [get_ports {irq_acc[3]}]     \
[get_ports {irq_acc[2]}] [get_ports {irq_acc[1]}] [get_ports {irq_acc[0]}]     \
[get_ports lfxt_enable] [get_ports lfxt_wkup] [get_ports mclk] [get_ports      \
{dma_dout[15]}] [get_ports {dma_dout[14]}] [get_ports {dma_dout[13]}]          \
[get_ports {dma_dout[12]}] [get_ports {dma_dout[11]}] [get_ports               \
{dma_dout[10]}] [get_ports {dma_dout[9]}] [get_ports {dma_dout[8]}] [get_ports \
{dma_dout[7]}] [get_ports {dma_dout[6]}] [get_ports {dma_dout[5]}] [get_ports  \
{dma_dout[4]}] [get_ports {dma_dout[3]}] [get_ports {dma_dout[2]}] [get_ports  \
{dma_dout[1]}] [get_ports {dma_dout[0]}] [get_ports dma_ready] [get_ports      \
dma_resp] [get_ports {per_addr[13]}] [get_ports {per_addr[12]}] [get_ports     \
{per_addr[11]}] [get_ports {per_addr[10]}] [get_ports {per_addr[9]}]           \
[get_ports {per_addr[8]}] [get_ports {per_addr[7]}] [get_ports {per_addr[6]}]  \
[get_ports {per_addr[5]}] [get_ports {per_addr[4]}] [get_ports {per_addr[3]}]  \
[get_ports {per_addr[2]}] [get_ports {per_addr[1]}] [get_ports {per_addr[0]}]  \
[get_ports {per_din[15]}] [get_ports {per_din[14]}] [get_ports {per_din[13]}]  \
[get_ports {per_din[12]}] [get_ports {per_din[11]}] [get_ports {per_din[10]}]  \
[get_ports {per_din[9]}] [get_ports {per_din[8]}] [get_ports {per_din[7]}]     \
[get_ports {per_din[6]}] [get_ports {per_din[5]}] [get_ports {per_din[4]}]     \
[get_ports {per_din[3]}] [get_ports {per_din[2]}] [get_ports {per_din[1]}]     \
[get_ports {per_din[0]}] [get_ports per_en] [get_ports {per_we[1]}] [get_ports \
{per_we[0]}] [get_ports {pmem_addr[10]}] [get_ports {pmem_addr[9]}] [get_ports \
{pmem_addr[8]}] [get_ports {pmem_addr[7]}] [get_ports {pmem_addr[6]}]          \
[get_ports {pmem_addr[5]}] [get_ports {pmem_addr[4]}] [get_ports               \
{pmem_addr[3]}] [get_ports {pmem_addr[2]}] [get_ports {pmem_addr[1]}]          \
[get_ports {pmem_addr[0]}] [get_ports pmem_cen] [get_ports {pmem_din[15]}]     \
[get_ports {pmem_din[14]}] [get_ports {pmem_din[13]}] [get_ports               \
{pmem_din[12]}] [get_ports {pmem_din[11]}] [get_ports {pmem_din[10]}]          \
[get_ports {pmem_din[9]}] [get_ports {pmem_din[8]}] [get_ports {pmem_din[7]}]  \
[get_ports {pmem_din[6]}] [get_ports {pmem_din[5]}] [get_ports {pmem_din[4]}]  \
[get_ports {pmem_din[3]}] [get_ports {pmem_din[2]}] [get_ports {pmem_din[1]}]  \
[get_ports {pmem_din[0]}] [get_ports {pmem_wen[1]}] [get_ports {pmem_wen[0]}]  \
[get_ports puc_rst] [get_ports smclk] [get_ports smclk_en]]
group_path -name REGIN  -from [get_ports dbg_uart_rxd]
group_path -name REGIN  -from [get_ports nmi]
group_path -name REGIN  -from [get_ports reset_n]
group_path -name REGIN  -from [get_ports cpu_en]
group_path -name REGIN  -from [get_ports dbg_en]
group_path -name REGIN  -from [list [get_ports {dbg_i2c_addr[6]}] [get_ports {dbg_i2c_addr[5]}]       \
[get_ports {dbg_i2c_addr[4]}] [get_ports {dbg_i2c_addr[3]}] [get_ports         \
{dbg_i2c_addr[2]}] [get_ports {dbg_i2c_addr[1]}] [get_ports {dbg_i2c_addr[0]}] \
[get_ports {dbg_i2c_broadcast[6]}] [get_ports {dbg_i2c_broadcast[5]}]          \
[get_ports {dbg_i2c_broadcast[4]}] [get_ports {dbg_i2c_broadcast[3]}]          \
[get_ports {dbg_i2c_broadcast[2]}] [get_ports {dbg_i2c_broadcast[1]}]          \
[get_ports {dbg_i2c_broadcast[0]}] [get_ports dbg_i2c_scl] [get_ports          \
dbg_i2c_sda_in] [get_ports {dmem_dout[15]}] [get_ports {dmem_dout[14]}]        \
[get_ports {dmem_dout[13]}] [get_ports {dmem_dout[12]}] [get_ports             \
{dmem_dout[11]}] [get_ports {dmem_dout[10]}] [get_ports {dmem_dout[9]}]        \
[get_ports {dmem_dout[8]}] [get_ports {dmem_dout[7]}] [get_ports               \
{dmem_dout[6]}] [get_ports {dmem_dout[5]}] [get_ports {dmem_dout[4]}]          \
[get_ports {dmem_dout[3]}] [get_ports {dmem_dout[2]}] [get_ports               \
{dmem_dout[1]}] [get_ports {dmem_dout[0]}] [get_ports {irq[13]}] [get_ports    \
{irq[12]}] [get_ports {irq[11]}] [get_ports {irq[10]}] [get_ports {irq[9]}]    \
[get_ports {irq[8]}] [get_ports {irq[7]}] [get_ports {irq[6]}] [get_ports      \
{irq[5]}] [get_ports {irq[4]}] [get_ports {irq[3]}] [get_ports {irq[2]}]       \
[get_ports {irq[1]}] [get_ports {irq[0]}] [get_ports lfxt_clk] [get_ports      \
{dma_addr[15]}] [get_ports {dma_addr[14]}] [get_ports {dma_addr[13]}]          \
[get_ports {dma_addr[12]}] [get_ports {dma_addr[11]}] [get_ports               \
{dma_addr[10]}] [get_ports {dma_addr[9]}] [get_ports {dma_addr[8]}] [get_ports \
{dma_addr[7]}] [get_ports {dma_addr[6]}] [get_ports {dma_addr[5]}] [get_ports  \
{dma_addr[4]}] [get_ports {dma_addr[3]}] [get_ports {dma_addr[2]}] [get_ports  \
{dma_addr[1]}] [get_ports {dma_din[15]}] [get_ports {dma_din[14]}] [get_ports  \
{dma_din[13]}] [get_ports {dma_din[12]}] [get_ports {dma_din[11]}] [get_ports  \
{dma_din[10]}] [get_ports {dma_din[9]}] [get_ports {dma_din[8]}] [get_ports    \
{dma_din[7]}] [get_ports {dma_din[6]}] [get_ports {dma_din[5]}] [get_ports     \
{dma_din[4]}] [get_ports {dma_din[3]}] [get_ports {dma_din[2]}] [get_ports     \
{dma_din[1]}] [get_ports {dma_din[0]}] [get_ports dma_en] [get_ports           \
dma_priority] [get_ports {dma_we[1]}] [get_ports {dma_we[0]}] [get_ports       \
dma_wkup] [get_ports {per_dout[15]}] [get_ports {per_dout[14]}] [get_ports     \
{per_dout[13]}] [get_ports {per_dout[12]}] [get_ports {per_dout[11]}]          \
[get_ports {per_dout[10]}] [get_ports {per_dout[9]}] [get_ports {per_dout[8]}] \
[get_ports {per_dout[7]}] [get_ports {per_dout[6]}] [get_ports {per_dout[5]}]  \
[get_ports {per_dout[4]}] [get_ports {per_dout[3]}] [get_ports {per_dout[2]}]  \
[get_ports {per_dout[1]}] [get_ports {per_dout[0]}] [get_ports                 \
{pmem_dout[15]}] [get_ports {pmem_dout[14]}] [get_ports {pmem_dout[13]}]       \
[get_ports {pmem_dout[12]}] [get_ports {pmem_dout[11]}] [get_ports             \
{pmem_dout[10]}] [get_ports {pmem_dout[9]}] [get_ports {pmem_dout[8]}]         \
[get_ports {pmem_dout[7]}] [get_ports {pmem_dout[6]}] [get_ports               \
{pmem_dout[5]}] [get_ports {pmem_dout[4]}] [get_ports {pmem_dout[3]}]          \
[get_ports {pmem_dout[2]}] [get_ports {pmem_dout[1]}] [get_ports               \
{pmem_dout[0]}] [get_ports scan_enable] [get_ports scan_mode] [get_ports       \
wkup]]
group_path -name REGOUT  -to [list [get_ports dbg_uart_txd] [get_ports aclk] [get_ports aclk_en]       \
[get_ports dbg_freeze] [get_ports dbg_i2c_sda_out] [get_ports dco_enable]      \
[get_ports dco_wkup] [get_ports {dmem_addr[8]}] [get_ports {dmem_addr[7]}]     \
[get_ports {dmem_addr[6]}] [get_ports {dmem_addr[5]}] [get_ports               \
{dmem_addr[4]}] [get_ports {dmem_addr[3]}] [get_ports {dmem_addr[2]}]          \
[get_ports {dmem_addr[1]}] [get_ports {dmem_addr[0]}] [get_ports dmem_cen]     \
[get_ports {dmem_din[15]}] [get_ports {dmem_din[14]}] [get_ports               \
{dmem_din[13]}] [get_ports {dmem_din[12]}] [get_ports {dmem_din[11]}]          \
[get_ports {dmem_din[10]}] [get_ports {dmem_din[9]}] [get_ports {dmem_din[8]}] \
[get_ports {dmem_din[7]}] [get_ports {dmem_din[6]}] [get_ports {dmem_din[5]}]  \
[get_ports {dmem_din[4]}] [get_ports {dmem_din[3]}] [get_ports {dmem_din[2]}]  \
[get_ports {dmem_din[1]}] [get_ports {dmem_din[0]}] [get_ports {dmem_wen[1]}]  \
[get_ports {dmem_wen[0]}] [get_ports {irq_acc[13]}] [get_ports {irq_acc[12]}]  \
[get_ports {irq_acc[11]}] [get_ports {irq_acc[10]}] [get_ports {irq_acc[9]}]   \
[get_ports {irq_acc[8]}] [get_ports {irq_acc[7]}] [get_ports {irq_acc[6]}]     \
[get_ports {irq_acc[5]}] [get_ports {irq_acc[4]}] [get_ports {irq_acc[3]}]     \
[get_ports {irq_acc[2]}] [get_ports {irq_acc[1]}] [get_ports {irq_acc[0]}]     \
[get_ports lfxt_enable] [get_ports lfxt_wkup] [get_ports mclk] [get_ports      \
{dma_dout[15]}] [get_ports {dma_dout[14]}] [get_ports {dma_dout[13]}]          \
[get_ports {dma_dout[12]}] [get_ports {dma_dout[11]}] [get_ports               \
{dma_dout[10]}] [get_ports {dma_dout[9]}] [get_ports {dma_dout[8]}] [get_ports \
{dma_dout[7]}] [get_ports {dma_dout[6]}] [get_ports {dma_dout[5]}] [get_ports  \
{dma_dout[4]}] [get_ports {dma_dout[3]}] [get_ports {dma_dout[2]}] [get_ports  \
{dma_dout[1]}] [get_ports {dma_dout[0]}] [get_ports dma_ready] [get_ports      \
dma_resp] [get_ports {per_addr[13]}] [get_ports {per_addr[12]}] [get_ports     \
{per_addr[11]}] [get_ports {per_addr[10]}] [get_ports {per_addr[9]}]           \
[get_ports {per_addr[8]}] [get_ports {per_addr[7]}] [get_ports {per_addr[6]}]  \
[get_ports {per_addr[5]}] [get_ports {per_addr[4]}] [get_ports {per_addr[3]}]  \
[get_ports {per_addr[2]}] [get_ports {per_addr[1]}] [get_ports {per_addr[0]}]  \
[get_ports {per_din[15]}] [get_ports {per_din[14]}] [get_ports {per_din[13]}]  \
[get_ports {per_din[12]}] [get_ports {per_din[11]}] [get_ports {per_din[10]}]  \
[get_ports {per_din[9]}] [get_ports {per_din[8]}] [get_ports {per_din[7]}]     \
[get_ports {per_din[6]}] [get_ports {per_din[5]}] [get_ports {per_din[4]}]     \
[get_ports {per_din[3]}] [get_ports {per_din[2]}] [get_ports {per_din[1]}]     \
[get_ports {per_din[0]}] [get_ports per_en] [get_ports {per_we[1]}] [get_ports \
{per_we[0]}] [get_ports {pmem_addr[10]}] [get_ports {pmem_addr[9]}] [get_ports \
{pmem_addr[8]}] [get_ports {pmem_addr[7]}] [get_ports {pmem_addr[6]}]          \
[get_ports {pmem_addr[5]}] [get_ports {pmem_addr[4]}] [get_ports               \
{pmem_addr[3]}] [get_ports {pmem_addr[2]}] [get_ports {pmem_addr[1]}]          \
[get_ports {pmem_addr[0]}] [get_ports pmem_cen] [get_ports {pmem_din[15]}]     \
[get_ports {pmem_din[14]}] [get_ports {pmem_din[13]}] [get_ports               \
{pmem_din[12]}] [get_ports {pmem_din[11]}] [get_ports {pmem_din[10]}]          \
[get_ports {pmem_din[9]}] [get_ports {pmem_din[8]}] [get_ports {pmem_din[7]}]  \
[get_ports {pmem_din[6]}] [get_ports {pmem_din[5]}] [get_ports {pmem_din[4]}]  \
[get_ports {pmem_din[3]}] [get_ports {pmem_din[2]}] [get_ports {pmem_din[1]}]  \
[get_ports {pmem_din[0]}] [get_ports {pmem_wen[1]}] [get_ports {pmem_wen[0]}]  \
[get_ports puc_rst] [get_ports smclk] [get_ports smclk_en]]
set_false_path   -from [get_ports dbg_uart_rxd]
set_false_path   -from [get_ports nmi]
set_false_path   -from [get_ports reset_n]
set_false_path   -from [get_ports cpu_en]
set_false_path   -from [get_ports dbg_en]
set_false_path   -to [get_ports dbg_uart_txd]
set_false_path   -from [get_clocks lfxt_clk]
set_input_delay -clock dco_clk  -max 2.25  [get_ports {dmem_dout[15]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {dmem_dout[15]}]
set_input_delay -clock dco_clk  -max 2.25  [get_ports {dmem_dout[14]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {dmem_dout[14]}]
set_input_delay -clock dco_clk  -max 2.25  [get_ports {dmem_dout[13]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {dmem_dout[13]}]
set_input_delay -clock dco_clk  -max 2.25  [get_ports {dmem_dout[12]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {dmem_dout[12]}]
set_input_delay -clock dco_clk  -max 2.25  [get_ports {dmem_dout[11]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {dmem_dout[11]}]
set_input_delay -clock dco_clk  -max 2.25  [get_ports {dmem_dout[10]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {dmem_dout[10]}]
set_input_delay -clock dco_clk  -max 2.25  [get_ports {dmem_dout[9]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {dmem_dout[9]}]
set_input_delay -clock dco_clk  -max 2.25  [get_ports {dmem_dout[8]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {dmem_dout[8]}]
set_input_delay -clock dco_clk  -max 2.25  [get_ports {dmem_dout[7]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {dmem_dout[7]}]
set_input_delay -clock dco_clk  -max 2.25  [get_ports {dmem_dout[6]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {dmem_dout[6]}]
set_input_delay -clock dco_clk  -max 2.25  [get_ports {dmem_dout[5]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {dmem_dout[5]}]
set_input_delay -clock dco_clk  -max 2.25  [get_ports {dmem_dout[4]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {dmem_dout[4]}]
set_input_delay -clock dco_clk  -max 2.25  [get_ports {dmem_dout[3]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {dmem_dout[3]}]
set_input_delay -clock dco_clk  -max 2.25  [get_ports {dmem_dout[2]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {dmem_dout[2]}]
set_input_delay -clock dco_clk  -max 2.25  [get_ports {dmem_dout[1]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {dmem_dout[1]}]
set_input_delay -clock dco_clk  -max 2.25  [get_ports {dmem_dout[0]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {dmem_dout[0]}]
set_input_delay -clock dco_clk  -max 9  [get_ports {irq[13]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {irq[13]}]
set_input_delay -clock dco_clk  -max 9  [get_ports {irq[12]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {irq[12]}]
set_input_delay -clock dco_clk  -max 9  [get_ports {irq[11]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {irq[11]}]
set_input_delay -clock dco_clk  -max 9  [get_ports {irq[10]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {irq[10]}]
set_input_delay -clock dco_clk  -max 9  [get_ports {irq[9]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {irq[9]}]
set_input_delay -clock dco_clk  -max 9  [get_ports {irq[8]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {irq[8]}]
set_input_delay -clock dco_clk  -max 9  [get_ports {irq[7]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {irq[7]}]
set_input_delay -clock dco_clk  -max 9  [get_ports {irq[6]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {irq[6]}]
set_input_delay -clock dco_clk  -max 9  [get_ports {irq[5]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {irq[5]}]
set_input_delay -clock dco_clk  -max 9  [get_ports {irq[4]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {irq[4]}]
set_input_delay -clock dco_clk  -max 9  [get_ports {irq[3]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {irq[3]}]
set_input_delay -clock dco_clk  -max 9  [get_ports {irq[2]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {irq[2]}]
set_input_delay -clock dco_clk  -max 9  [get_ports {irq[1]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {irq[1]}]
set_input_delay -clock dco_clk  -max 9  [get_ports {irq[0]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {irq[0]}]
set_input_delay -clock dco_clk  -max 6  [get_ports {per_dout[15]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {per_dout[15]}]
set_input_delay -clock dco_clk  -max 6  [get_ports {per_dout[14]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {per_dout[14]}]
set_input_delay -clock dco_clk  -max 6  [get_ports {per_dout[13]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {per_dout[13]}]
set_input_delay -clock dco_clk  -max 6  [get_ports {per_dout[12]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {per_dout[12]}]
set_input_delay -clock dco_clk  -max 6  [get_ports {per_dout[11]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {per_dout[11]}]
set_input_delay -clock dco_clk  -max 6  [get_ports {per_dout[10]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {per_dout[10]}]
set_input_delay -clock dco_clk  -max 6  [get_ports {per_dout[9]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {per_dout[9]}]
set_input_delay -clock dco_clk  -max 6  [get_ports {per_dout[8]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {per_dout[8]}]
set_input_delay -clock dco_clk  -max 6  [get_ports {per_dout[7]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {per_dout[7]}]
set_input_delay -clock dco_clk  -max 6  [get_ports {per_dout[6]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {per_dout[6]}]
set_input_delay -clock dco_clk  -max 6  [get_ports {per_dout[5]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {per_dout[5]}]
set_input_delay -clock dco_clk  -max 6  [get_ports {per_dout[4]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {per_dout[4]}]
set_input_delay -clock dco_clk  -max 6  [get_ports {per_dout[3]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {per_dout[3]}]
set_input_delay -clock dco_clk  -max 6  [get_ports {per_dout[2]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {per_dout[2]}]
set_input_delay -clock dco_clk  -max 6  [get_ports {per_dout[1]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {per_dout[1]}]
set_input_delay -clock dco_clk  -max 6  [get_ports {per_dout[0]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {per_dout[0]}]
set_input_delay -clock dco_clk  -max 2.25  [get_ports {pmem_dout[15]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {pmem_dout[15]}]
set_input_delay -clock dco_clk  -max 2.25  [get_ports {pmem_dout[14]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {pmem_dout[14]}]
set_input_delay -clock dco_clk  -max 2.25  [get_ports {pmem_dout[13]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {pmem_dout[13]}]
set_input_delay -clock dco_clk  -max 2.25  [get_ports {pmem_dout[12]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {pmem_dout[12]}]
set_input_delay -clock dco_clk  -max 2.25  [get_ports {pmem_dout[11]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {pmem_dout[11]}]
set_input_delay -clock dco_clk  -max 2.25  [get_ports {pmem_dout[10]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {pmem_dout[10]}]
set_input_delay -clock dco_clk  -max 2.25  [get_ports {pmem_dout[9]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {pmem_dout[9]}]
set_input_delay -clock dco_clk  -max 2.25  [get_ports {pmem_dout[8]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {pmem_dout[8]}]
set_input_delay -clock dco_clk  -max 2.25  [get_ports {pmem_dout[7]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {pmem_dout[7]}]
set_input_delay -clock dco_clk  -max 2.25  [get_ports {pmem_dout[6]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {pmem_dout[6]}]
set_input_delay -clock dco_clk  -max 2.25  [get_ports {pmem_dout[5]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {pmem_dout[5]}]
set_input_delay -clock dco_clk  -max 2.25  [get_ports {pmem_dout[4]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {pmem_dout[4]}]
set_input_delay -clock dco_clk  -max 2.25  [get_ports {pmem_dout[3]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {pmem_dout[3]}]
set_input_delay -clock dco_clk  -max 2.25  [get_ports {pmem_dout[2]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {pmem_dout[2]}]
set_input_delay -clock dco_clk  -max 2.25  [get_ports {pmem_dout[1]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {pmem_dout[1]}]
set_input_delay -clock dco_clk  -max 2.25  [get_ports {pmem_dout[0]}]
set_input_delay -clock dco_clk  -min 0  [get_ports {pmem_dout[0]}]
set_output_delay -clock dco_clk  -max 25.5  [get_ports aclk_en]
set_output_delay -clock dco_clk  -min 0  [get_ports aclk_en]
set_output_delay -clock dco_clk  -max 25.5  [get_ports dbg_freeze]
set_output_delay -clock dco_clk  -min 0  [get_ports dbg_freeze]
set_output_delay -clock dco_clk  -max 0.64  [get_ports {dmem_addr[8]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {dmem_addr[8]}]
set_output_delay -clock dco_clk  -max 0.64  [get_ports {dmem_addr[7]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {dmem_addr[7]}]
set_output_delay -clock dco_clk  -max 0.64  [get_ports {dmem_addr[6]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {dmem_addr[6]}]
set_output_delay -clock dco_clk  -max 0.64  [get_ports {dmem_addr[5]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {dmem_addr[5]}]
set_output_delay -clock dco_clk  -max 0.64  [get_ports {dmem_addr[4]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {dmem_addr[4]}]
set_output_delay -clock dco_clk  -max 0.64  [get_ports {dmem_addr[3]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {dmem_addr[3]}]
set_output_delay -clock dco_clk  -max 0.64  [get_ports {dmem_addr[2]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {dmem_addr[2]}]
set_output_delay -clock dco_clk  -max 0.64  [get_ports {dmem_addr[1]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {dmem_addr[1]}]
set_output_delay -clock dco_clk  -max 0.64  [get_ports {dmem_addr[0]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {dmem_addr[0]}]
set_output_delay -clock dco_clk  -max 0.63  [get_ports dmem_cen]
set_output_delay -clock dco_clk  -min 0  [get_ports dmem_cen]
set_output_delay -clock dco_clk  -max 0.39  [get_ports {dmem_din[15]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {dmem_din[15]}]
set_output_delay -clock dco_clk  -max 0.39  [get_ports {dmem_din[14]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {dmem_din[14]}]
set_output_delay -clock dco_clk  -max 0.39  [get_ports {dmem_din[13]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {dmem_din[13]}]
set_output_delay -clock dco_clk  -max 0.39  [get_ports {dmem_din[12]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {dmem_din[12]}]
set_output_delay -clock dco_clk  -max 0.39  [get_ports {dmem_din[11]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {dmem_din[11]}]
set_output_delay -clock dco_clk  -max 0.39  [get_ports {dmem_din[10]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {dmem_din[10]}]
set_output_delay -clock dco_clk  -max 0.39  [get_ports {dmem_din[9]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {dmem_din[9]}]
set_output_delay -clock dco_clk  -max 0.39  [get_ports {dmem_din[8]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {dmem_din[8]}]
set_output_delay -clock dco_clk  -max 0.39  [get_ports {dmem_din[7]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {dmem_din[7]}]
set_output_delay -clock dco_clk  -max 0.39  [get_ports {dmem_din[6]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {dmem_din[6]}]
set_output_delay -clock dco_clk  -max 0.39  [get_ports {dmem_din[5]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {dmem_din[5]}]
set_output_delay -clock dco_clk  -max 0.39  [get_ports {dmem_din[4]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {dmem_din[4]}]
set_output_delay -clock dco_clk  -max 0.39  [get_ports {dmem_din[3]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {dmem_din[3]}]
set_output_delay -clock dco_clk  -max 0.39  [get_ports {dmem_din[2]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {dmem_din[2]}]
set_output_delay -clock dco_clk  -max 0.39  [get_ports {dmem_din[1]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {dmem_din[1]}]
set_output_delay -clock dco_clk  -max 0.39  [get_ports {dmem_din[0]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {dmem_din[0]}]
set_output_delay -clock dco_clk  -max 0.44  [get_ports {dmem_wen[1]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {dmem_wen[1]}]
set_output_delay -clock dco_clk  -max 0.44  [get_ports {dmem_wen[0]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {dmem_wen[0]}]
set_output_delay -clock dco_clk  -max 18  [get_ports {irq_acc[13]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {irq_acc[13]}]
set_output_delay -clock dco_clk  -max 18  [get_ports {irq_acc[12]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {irq_acc[12]}]
set_output_delay -clock dco_clk  -max 18  [get_ports {irq_acc[11]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {irq_acc[11]}]
set_output_delay -clock dco_clk  -max 18  [get_ports {irq_acc[10]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {irq_acc[10]}]
set_output_delay -clock dco_clk  -max 18  [get_ports {irq_acc[9]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {irq_acc[9]}]
set_output_delay -clock dco_clk  -max 18  [get_ports {irq_acc[8]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {irq_acc[8]}]
set_output_delay -clock dco_clk  -max 18  [get_ports {irq_acc[7]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {irq_acc[7]}]
set_output_delay -clock dco_clk  -max 18  [get_ports {irq_acc[6]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {irq_acc[6]}]
set_output_delay -clock dco_clk  -max 18  [get_ports {irq_acc[5]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {irq_acc[5]}]
set_output_delay -clock dco_clk  -max 18  [get_ports {irq_acc[4]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {irq_acc[4]}]
set_output_delay -clock dco_clk  -max 18  [get_ports {irq_acc[3]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {irq_acc[3]}]
set_output_delay -clock dco_clk  -max 18  [get_ports {irq_acc[2]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {irq_acc[2]}]
set_output_delay -clock dco_clk  -max 18  [get_ports {irq_acc[1]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {irq_acc[1]}]
set_output_delay -clock dco_clk  -max 18  [get_ports {irq_acc[0]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {irq_acc[0]}]
set_output_delay -clock dco_clk  -max 7.5  [get_ports {per_addr[13]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {per_addr[13]}]
set_output_delay -clock dco_clk  -max 7.5  [get_ports {per_addr[12]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {per_addr[12]}]
set_output_delay -clock dco_clk  -max 7.5  [get_ports {per_addr[11]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {per_addr[11]}]
set_output_delay -clock dco_clk  -max 7.5  [get_ports {per_addr[10]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {per_addr[10]}]
set_output_delay -clock dco_clk  -max 7.5  [get_ports {per_addr[9]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {per_addr[9]}]
set_output_delay -clock dco_clk  -max 7.5  [get_ports {per_addr[8]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {per_addr[8]}]
set_output_delay -clock dco_clk  -max 7.5  [get_ports {per_addr[7]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {per_addr[7]}]
set_output_delay -clock dco_clk  -max 7.5  [get_ports {per_addr[6]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {per_addr[6]}]
set_output_delay -clock dco_clk  -max 7.5  [get_ports {per_addr[5]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {per_addr[5]}]
set_output_delay -clock dco_clk  -max 7.5  [get_ports {per_addr[4]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {per_addr[4]}]
set_output_delay -clock dco_clk  -max 7.5  [get_ports {per_addr[3]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {per_addr[3]}]
set_output_delay -clock dco_clk  -max 7.5  [get_ports {per_addr[2]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {per_addr[2]}]
set_output_delay -clock dco_clk  -max 7.5  [get_ports {per_addr[1]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {per_addr[1]}]
set_output_delay -clock dco_clk  -max 7.5  [get_ports {per_addr[0]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {per_addr[0]}]
set_output_delay -clock dco_clk  -max 7.5  [get_ports {per_din[15]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {per_din[15]}]
set_output_delay -clock dco_clk  -max 7.5  [get_ports {per_din[14]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {per_din[14]}]
set_output_delay -clock dco_clk  -max 7.5  [get_ports {per_din[13]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {per_din[13]}]
set_output_delay -clock dco_clk  -max 7.5  [get_ports {per_din[12]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {per_din[12]}]
set_output_delay -clock dco_clk  -max 7.5  [get_ports {per_din[11]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {per_din[11]}]
set_output_delay -clock dco_clk  -max 7.5  [get_ports {per_din[10]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {per_din[10]}]
set_output_delay -clock dco_clk  -max 7.5  [get_ports {per_din[9]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {per_din[9]}]
set_output_delay -clock dco_clk  -max 7.5  [get_ports {per_din[8]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {per_din[8]}]
set_output_delay -clock dco_clk  -max 7.5  [get_ports {per_din[7]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {per_din[7]}]
set_output_delay -clock dco_clk  -max 7.5  [get_ports {per_din[6]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {per_din[6]}]
set_output_delay -clock dco_clk  -max 7.5  [get_ports {per_din[5]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {per_din[5]}]
set_output_delay -clock dco_clk  -max 7.5  [get_ports {per_din[4]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {per_din[4]}]
set_output_delay -clock dco_clk  -max 7.5  [get_ports {per_din[3]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {per_din[3]}]
set_output_delay -clock dco_clk  -max 7.5  [get_ports {per_din[2]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {per_din[2]}]
set_output_delay -clock dco_clk  -max 7.5  [get_ports {per_din[1]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {per_din[1]}]
set_output_delay -clock dco_clk  -max 7.5  [get_ports {per_din[0]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {per_din[0]}]
set_output_delay -clock dco_clk  -max 7.5  [get_ports per_en]
set_output_delay -clock dco_clk  -min 0  [get_ports per_en]
set_output_delay -clock dco_clk  -max 7.5  [get_ports {per_we[1]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {per_we[1]}]
set_output_delay -clock dco_clk  -max 7.5  [get_ports {per_we[0]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {per_we[0]}]
set_output_delay -clock dco_clk  -max 0.64  [get_ports {pmem_addr[10]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {pmem_addr[10]}]
set_output_delay -clock dco_clk  -max 0.64  [get_ports {pmem_addr[9]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {pmem_addr[9]}]
set_output_delay -clock dco_clk  -max 0.64  [get_ports {pmem_addr[8]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {pmem_addr[8]}]
set_output_delay -clock dco_clk  -max 0.64  [get_ports {pmem_addr[7]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {pmem_addr[7]}]
set_output_delay -clock dco_clk  -max 0.64  [get_ports {pmem_addr[6]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {pmem_addr[6]}]
set_output_delay -clock dco_clk  -max 0.64  [get_ports {pmem_addr[5]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {pmem_addr[5]}]
set_output_delay -clock dco_clk  -max 0.64  [get_ports {pmem_addr[4]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {pmem_addr[4]}]
set_output_delay -clock dco_clk  -max 0.64  [get_ports {pmem_addr[3]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {pmem_addr[3]}]
set_output_delay -clock dco_clk  -max 0.64  [get_ports {pmem_addr[2]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {pmem_addr[2]}]
set_output_delay -clock dco_clk  -max 0.64  [get_ports {pmem_addr[1]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {pmem_addr[1]}]
set_output_delay -clock dco_clk  -max 0.64  [get_ports {pmem_addr[0]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {pmem_addr[0]}]
set_output_delay -clock dco_clk  -max 0.63  [get_ports pmem_cen]
set_output_delay -clock dco_clk  -min 0  [get_ports pmem_cen]
set_output_delay -clock dco_clk  -max 0.39  [get_ports {pmem_din[15]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {pmem_din[15]}]
set_output_delay -clock dco_clk  -max 0.39  [get_ports {pmem_din[14]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {pmem_din[14]}]
set_output_delay -clock dco_clk  -max 0.39  [get_ports {pmem_din[13]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {pmem_din[13]}]
set_output_delay -clock dco_clk  -max 0.39  [get_ports {pmem_din[12]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {pmem_din[12]}]
set_output_delay -clock dco_clk  -max 0.39  [get_ports {pmem_din[11]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {pmem_din[11]}]
set_output_delay -clock dco_clk  -max 0.39  [get_ports {pmem_din[10]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {pmem_din[10]}]
set_output_delay -clock dco_clk  -max 0.39  [get_ports {pmem_din[9]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {pmem_din[9]}]
set_output_delay -clock dco_clk  -max 0.39  [get_ports {pmem_din[8]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {pmem_din[8]}]
set_output_delay -clock dco_clk  -max 0.39  [get_ports {pmem_din[7]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {pmem_din[7]}]
set_output_delay -clock dco_clk  -max 0.39  [get_ports {pmem_din[6]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {pmem_din[6]}]
set_output_delay -clock dco_clk  -max 0.39  [get_ports {pmem_din[5]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {pmem_din[5]}]
set_output_delay -clock dco_clk  -max 0.39  [get_ports {pmem_din[4]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {pmem_din[4]}]
set_output_delay -clock dco_clk  -max 0.39  [get_ports {pmem_din[3]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {pmem_din[3]}]
set_output_delay -clock dco_clk  -max 0.39  [get_ports {pmem_din[2]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {pmem_din[2]}]
set_output_delay -clock dco_clk  -max 0.39  [get_ports {pmem_din[1]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {pmem_din[1]}]
set_output_delay -clock dco_clk  -max 0.39  [get_ports {pmem_din[0]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {pmem_din[0]}]
set_output_delay -clock dco_clk  -max 0.44  [get_ports {pmem_wen[1]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {pmem_wen[1]}]
set_output_delay -clock dco_clk  -max 0.44  [get_ports {pmem_wen[0]}]
set_output_delay -clock dco_clk  -min 0  [get_ports {pmem_wen[0]}]
set_output_delay -clock dco_clk  -max 2.5  [get_ports puc_rst]
set_output_delay -clock dco_clk  -min 0  [get_ports puc_rst]
set_output_delay -clock dco_clk  -max 2.5  [get_ports smclk_en]
set_output_delay -clock dco_clk  -min 0  [get_ports smclk_en]
