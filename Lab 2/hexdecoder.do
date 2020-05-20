# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in hexdecoder.v to working dir
# could also have multiple verilog files
vlog hexdecoder.v

#load simulation using mux as the top level simulation module
vsim seg7

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {c0} 0
force {c1} 0
force {c2} 0
force {c3} 0
#run simulation for a few ns
run 10ns

force {c0} 0
force {c1} 0
force {c2} 0
force {c3} 1
#run simulation for a few ns
run 10ns

force {c0} 0
force {c1} 0
force {c2} 1
force {c3} 0
#run simulation for a few ns
run 10ns

force {c0} 0
force {c1} 0
force {c2} 1
force {c3} 1
#run simulation for a few ns
run 10ns

force {c0} 0
force {c1} 1
force {c2} 0
force {c3} 0
#run simulation for a few ns
run 10ns

force {c0} 0
force {c1} 1
force {c2} 0
force {c3} 1
#run simulation for a few ns
run 10ns

force {c0} 0
force {c1} 1
force {c2} 1
force {c3} 0
#run simulation for a few ns
run 10ns

force {c0} 0
force {c1} 1
force {c2} 1
force {c3} 1
#run simulation for a few ns
run 10ns

force {c0} 1
force {c1} 0
force {c2} 0
force {c3} 0
#run simulation for a few ns
run 10ns

force {c0} 1
force {c1} 0
force {c2} 0
force {c3} 1
#run simulation for a few ns
run 10ns

force {c0} 1
force {c1} 0
force {c2} 1
force {c3} 0
#run simulation for a few ns
run 10ns

force {c0} 1
force {c1} 0
force {c2} 1
force {c3} 1
#run simulation for a few ns
run 10ns

force {c0} 1
force {c1} 1
force {c2} 0
force {c3} 0
#run simulation for a few ns
run 10ns

force {c0} 1
force {c1} 1
force {c2} 0
force {c3} 1
#run simulation for a few ns
run 10ns

force {c0} 1
force {c1} 1
force {c2} 1
force {c3} 0
#run simulation for a few ns
run 10ns

force {c0} 1
force {c1} 1
force {c2} 1
force {c3} 1
#run simulation for a few ns
run 10ns
