set netname core_round_key[61]
select_obj $netname
set worstnet [get_nets $netname]
get_db $worstnet .wires.rect
create_route_blockage -layers 10 -rects [get_db $worstnet .wires.rect]
delete_selected_from_floorplan
opt_design -post_route
delete_route_blockages -all route


