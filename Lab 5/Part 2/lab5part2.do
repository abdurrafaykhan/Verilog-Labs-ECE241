# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules to working dir
vlog lab5part2.v

# load simulation using the top level simulation module
vsim lab5part2

# log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force reset 0

force {CLOCK_50} 0 0ns , 1 {10ns} -r 20ns
force {SW[1]} 0
force {SW[0]} 1
run 100ns

force {SW[1]} 0
force {SW[0]} 1
#run 625000ps

force {SW[1]} 1
force {SW[0]} 0
#run 1250000ps

force {SW[1]} 1
force {SW[0]} 1
#run 2500000ps






