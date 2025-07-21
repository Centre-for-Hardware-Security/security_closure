# How to load a benchmark design?
Navigate to the design of your choice and go to its run folder, e.g., `cd designs/tdea/run/`.

From this folder, you can launch Innovus in two ways: Stylus mode or legacy mode. Stylus is a newer interface, and it was used by the contest organizers to score the designs. The legacy mode is probably what most Innovus tutorials still teach.

```
innovus -files ../scripts/load_design.tcl
or
innovus -files ../scripts/load_design.stylus.tcl -stylus
```

When using the Stylus mode, commands from legacy mode can be issued using the `eval_legacy` command. 

When using the Stylus mode, one can check what a legacy mode command looks like in the new interface using the `get_common_ui_map` command.

To start the graphical interface in Stylus, the command is `gui_show`. 

# How to score a design?
A script called eval.stylus.tcl is provided. It only works in Stylus mode. To run it, you must have a design already loaded in Innovus before calling `source ../scripts/eval.stylus.tcl`. This script can be called at any time and repeatedly, if necessary. 

# How to recreate results from the paper?
Recreating the results is a 3-step process: implementation strategy, TI strategy, followed by FSPFI strategy.
1. to start implementation, use script1.tcl. It works for every design and will set the floorplan sizes according to the paper results. Powerplan strategies are as in the contest setting as much possible. Since design sizes shrink, some stripes no longer fit where they should be.
2. to start TI strategy, use nudger.tcl. It works for every design, no changes are needed. Statistics appear on the terminal as the script runs, and a summary appears in run/log.txt. 
3. to start FSPFI strategy, use reroute_multinet.tcl followed by reroute_multinet2.tcl. Both scripts work for every design, no changes are needed. Statistics appear on the terminal as the script runs, and a summary appears in run/log2.txt. These scripts correspond to phases A and B of the FSPFI strategy described in the paper.

# Workflow - how to improve the scores with my own methodology?
In order to improve the designs, the workflow should look like the itemized list below.

1. load a design: from the terminal, issue `innovus -files ../scripts/load_design.stylus.tcl -stylus`
2. score a design: from inside innovus, issue `source eval.stylus.tcl`
3. reimplement the design by redoing the floorplan, placement, cts, routing, and optimization steps. create a script for this, say implement.tcl, and issue `source implement.tcl`
	* in innovus stylus mode, these are the commands you will be needing: `create_floorplan` `add_rings` `route_special` `add_stripes` `place_opt_design` `ccopt_design` `route_design` `opt_design -post_route`
4. rescore the design by issueing  `source eval.stylus.tcl` again

Note: the scoring scripts should not be modified. The eval.stylus.tcl is the top level evaluation script, it will call a lot of other scripts automatically. You don't have to call them yourself. You can, however, look at them for learning a bit more about the TCL language. 

#

