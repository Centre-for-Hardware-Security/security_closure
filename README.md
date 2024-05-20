# How to load a benchmark design?
Navigate to the design of your choice and go to its run folder, e.g., `cd designs/tdea/run/`.

From this folder, you can launch Innovus in two ways: Stylus mode or legacy mode. Stylus is a newer interface, and it was used by the contest organizers to score the designs. The legacy mode is what we utilized in the Innovus tutorial.

```
innovus -files ../scripts/load_design.tcl
or
innovus -files ../scripts/load_design.stylus.tcl -stylus
```

When using the Stylus mode, commands from legacy mode can be issued using the `eval_legacy` command.

When using the Stylus mode, one can check what a legacy mode command should look like using the `get_common_ui_map` command.

To start the graphical interface in Stylus, the command is `gui_show`. 

# How to score a design?
A script called eval.stylus.tcl is provided. It only works in Stylus mode. To run it, you must have a design already load in Innovus before calling `source ../scripts/eval.stylus.tcl`.
