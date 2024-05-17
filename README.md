# How to load a benchmark design?
Navigate to the design of your choice and go to its run folder, e.g., `cd designs/tdea/run/`
From this folder, you can launch Innovus in two ways, Stylus mode and classic mode. Stylus is a newer interface, and it was used by the contest organizers to score the designs. The classic mode is what we utilized in the Innovus tutorial.

```
innovus -files ../scripts/load_design.tcl
or
innovus -files ../scripts/load_design.stylus.tcl -common_ui
```

# How to score a design?
A script called eval.stylus.tcl is provided. It only works in Stylus mode. To run it, you must have a design already load in Innovus before calling `source ../scripts/eval.stylus.tcl`.
