# set the working dir, where all compiled verilog goes
vlib work

vlog lab7part1.v

vsim -L altera_mf_ver lab7part1

#log all signals and add some signals to waveform window
log {/*}

#add wave {/*} would add all items in top level simulation module
add wave {/*}

#***********************************************************************#
# Case 1: All switches off, clock oscillates for a few ns
force {KEY[0]} 0
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {SW[8]} 0
force {SW[9]} 0
run 10ns

#***********************************************************************#
# Case 1: Store '1' in Adresss 1 with store swith off to show doesnt store without sw[9]

force {SW[0]} 1
force {SW[4]} 1

force {KEY[0]} 1
run 10ns

force {KEY[0]} 0
run 10ns

force {SW[0]} 0
force {SW[4]} 0

force {KEY[0]} 1
run 10ns

force {KEY[0]} 0
run 10ns

force {SW[4]} 1

force {KEY[0]} 1
run 10ns

force {KEY[0]} 0
run 10ns

force {SW[4]} 0

force {KEY[0]} 1
run 10ns

force {KEY[0]} 0
run 10ns

#***********************************************************************#
# Case 2: Store '1' in Adresss 1 with store swith on to show it does store

force {SW[0]} 1
force {SW[4]} 1
force {SW[9]} 1

force {KEY[0]} 1
run 10ns

force {KEY[0]} 0
run 10ns

force {SW[0]} 0
force {SW[4]} 0
force {SW[9]} 0

force {KEY[0]} 1
run 10ns

force {KEY[0]} 0
run 10ns

force {SW[4]} 1

force {KEY[0]} 1
run 10ns

force {KEY[0]} 0
run 10ns

force {SW[4]} 0

force {KEY[0]} 1
run 10ns

force {KEY[0]} 0
run 10ns


#***********************************************************************#
# Case 3: Overwrites address of '1' with value of '10' and writes value of '10' in address '10'

force {SW[1]} 1
force {SW[3]} 1
force {SW[4]} 1
force {SW[9]} 1


force {KEY[0]} 1
run 10ns

force {KEY[0]} 0
run 10ns

force {SW[8]} 1

force {KEY[0]} 1
run 10ns

force {KEY[0]} 0
run 10ns


force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {SW[8]} 0
force {SW[9]} 0

force {KEY[0]} 1
run 10ns

force {KEY[0]} 0
run 10ns

force {SW[4]} 1

force {KEY[0]} 1
run 10ns

force {KEY[0]} 0
run 10ns

force {SW[4]} 1
force {SW[8]} 1


force {KEY[0]} 1
run 10ns

force {KEY[0]} 0
run 10ns
























