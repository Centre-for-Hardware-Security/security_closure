set STAT_OPT_RUNS [expr $STAT_OPT_RUNS + 1]

set block_l [get_db place_blockages]

foreach b $block_l {
	set current_p [get_db $b .density]
	set current_p [expr $current_p + 10]
	set_db $b .density $current_p
}

foreach b $block_l {
	set current_p [get_db $b .density]
	if {$current_p >= 100} {
		delete_obj $b
	}
}

opt_design -post_route
source ../scripts/eval.stylus.tcl

echo "current ECO runs: " $STAT_ECO_RUNS
echo "current OPT runs: " $STAT_OPT_RUNS
