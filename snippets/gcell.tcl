
set worst_h 999
set worst_v 999
set worst_gcell_h ""
set worst_gcell_v ""
set gcell_l [get_db designs .gcells]
foreach g $gcell_l {
	set hr [get_db $g .horizontal_remaining]
	set vr [get_db $g .vertical_remaining]
	if {$hr < $worst_h} {
		set worst_gcell_h $g
		set worst_h $hr
	}
	if {$vr < $worst_v} {
		set worst_gcell_v $g
		set worst_v $vr
	}
}

set absolute_worst ""
if {$worst_h < $worst_v} {
	set absolute_worst $worst_gcell_h
} else {
	set absolute_worst $worst_gcell_v
}

echo "adding HARD placement blockage to [get_db $absolute_worst .rect]"
create_place_blockage -type hard -rects [get_db $absolute_worst .rect]
# opt_design should be executed after this



