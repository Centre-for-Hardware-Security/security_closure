set tp [report_timing -collection]
set slack [get_db $tp .slack]
set round_opt 1

while {$slack < 0} {
	set setup_target [expr $setup_target + 0.001]
	set_db opt_setup_target_slack $setup_target
	set now [exec date]
	opt_design -post_route
	set tp [report_timing -collection ]
	set slack [get_db $tp .slack]
	set round_opt [expr $round_opt + 1]
}

