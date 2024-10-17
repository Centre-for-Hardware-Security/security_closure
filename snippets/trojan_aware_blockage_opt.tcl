set STAT_OPT_RUNS [expr $STAT_OPT_RUNS + 1]
opt_design -post_route
source ../scripts/eval.stylus.tcl


# this will empty the list of gcells already blocked and allow some to be reconsidered
# it can introduce non convergence to the flow, but might also improve the results. needs more experimentation.
#set already_blocked ""

echo "current ECO runs: " $STAT_ECO_RUNS
echo "current OPT runs: " $STAT_OPT_RUNS
