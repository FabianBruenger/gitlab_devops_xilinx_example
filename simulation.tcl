# This is the second TCL script for opening the project, adding the simulation files and performing a simulation
open_project build/masterthesis/masterthesis.xpr
#Simulation Start
#
launch_simulation
# open_wave_config src/simulation/pomaa.wcfg
source build/masterthesis/masterthesis.sim/sim_1/behav/xsim/masterthesis_tb.tcl
log_wave /masterthesis_tb/DUT/*
#
run 1 us

close_project

