# This is the second TCL script for opening the project, adding the simulation files and performing a simulation
set outputDir build
set log build/logs/project.log
file mkdir $outputDir

open_project build/masterthesis/masterthesis.xpr
# Run Synthesis. Final Step for this Job
launch_runs synth_1 -jobs 8
wait_on_run synth_1
# Writes in log, when Synthesis is successfull.
if {[get_property STATUS [get_runs synth_1]] == {synth_design Complete!}} then {set fp [open $log a]; puts $fp "Synth. Successful: 1"; close $fp} else {set fp [open $log a]; puts $fp "Synth. Successful: 0"; close $fp}

close_project

