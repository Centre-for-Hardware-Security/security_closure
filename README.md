# How to load a benchmark design?
Navigate to the design of your choice and go to its run folder, e.g., `cd designs/tdea/run/`.

From this folder, you can launch Innovus in two ways: Stylus mode or legacy mode. Stylus is a newer interface, and it was used by the contest organizers to score the designs. The legacy mode is what we utilized in the Innovus tutorial.

```
innovus -files ../scripts/load_design.tcl
or
innovus -files ../scripts/load_design.stylus.tcl -stylus
```

When using the Stylus mode, commands from legacy mode can be issued using the `eval_legacy` command. 

When using the Stylus mode, one can check what a legacy mode command looks like in the new interface using the `get_common_ui_map` command.

To start the graphical interface in Stylus, the command is `gui_show`. 

# How to score a design?
A script called eval.stylus.tcl is provided. It only works in Stylus mode. To run it, you must have a design already load in Innovus before calling `source ../scripts/eval.stylus.tcl`. This script can be called at any time and repeatedly, if necessary. 

# Workflow - how to improve the scores?
In order to improve the designs, the workflow should look like the itemized list below.

1. load a design: from the terminal, issue `innovus -files ../scripts/load_design.stylus.tcl -stylus`
2. score a design: from inside innovus, issue `source eval.stylus.tcl`
3. reimplement the design by redoing the floorplan, placement, cts, routing, and optimization steps. create a script for this, say implement.tcl, and issue `source implement.tcl`
	* in innovus stylus mode, these are the commands you will be needing: `create_floorplan` `add_rings` `route_special` `add_stripes` `place_opt_design` `ccopt_design` `route_design` `opt_design -post_route`
4. rescore the design by issueing  `source eval.stylus.tcl` again

Note: the scoring scripts should not be modified. The eval.stylus.tcl is the top level evaluation script, it will call a lot of other scripts automatically. You don't have to call them yourself. You can, however, look at them for learning a bit more about the TCL language. 

