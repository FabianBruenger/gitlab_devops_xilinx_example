# This is the second TCL script for opening the project, adding the simulation files and performing a simulation
set outputDir build
set log build/logs/project.log
file mkdir $outputDir
#
open_project build/masterthesis/masterthesis.xpr
#
# launch implementation and writing the bitstream
launch_runs impl_1 -jobs 8
wait_on_run impl_1
if {[get_property STATUS [get_runs impl_1]] == {route_design Complete!}} then {set fp [open $log a]; puts $fp "Impl. Successful: 1"; close $fp} else {set fp [open $log a]; puts $fp "Impl. Successful: 0"; close $fp}
# Write Bitstream 
#
launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1
#
close_project

