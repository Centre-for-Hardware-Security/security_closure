source -quiet ../scripts/probing_functions.tcl

# load assets
set cell_asset_names [ CUHK::load_cell_assets ]
set net_asset_names [ CUHK::load_net_assets ]

# mark assets as dont touch; procedures are based on that property
set_dont_touch $cell_asset_names true
set_dont_touch $net_asset_names true

set cell_assets [get_db insts -if {.dont_touch == true} ]
set net_assets [get_db nets -if {.dont_touch == true} ]

# run reporting of nets and cells assets from layout db
CUHK::summarize_assets

exec ../scripts/ispd22_eval --bm_name $DESIGN --cell_file ./cells_summary.rpt --net_file ./nets_summary.rpt  > probing_eval.log

set rptfile $DESIGN
append rptfile _nets_ea.rpt
mv $rptfile nets_ea.rpt

set rptfile $DESIGN
append rptfile _cells_ea.rpt
mv $rptfile cells_ea.rpt

