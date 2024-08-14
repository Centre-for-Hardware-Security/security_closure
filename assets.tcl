# Ready assets
set filename "../assets/cells.assets"

set file_id [open $filename "r"]
set file_data [read $file_id]
close $file_id

# Set all assets dont touch
set data [split $file_data "\n"]
foreach a_cell $data {  
    if { $a_cell != "" } {
	# Legacy mode
	#dbSetIsInstDontTouch $a_cell 1
	# Common UI mode
	set_db [ get_db insts $a_cell ] .dont_touch "size_ok"
	get_db insts $a_cell
    }
}

set infile [open "../assets/nets.assets" r]
set net_assets {}
while { [gets $infile line] >= 0} {
	lappend net_assets $line
}
close $infile
set_dont_touch $net_assets


