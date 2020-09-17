# This is the first vivado tcl script. It is creating a project for further usage with all the source files for the bram project and the board nexys video.
set outputDir build
set log build/logs/project.log
file mkdir $outputDir
# Project create with FPGA from Nyxes Video
create_project masterthesis build/masterthesis -part xc7a100tcsg324-1 -force

# set board properties
# set_property board_part digilentinc.com:nexys4_ddr:part0:1.1 [current_project]

# Set Verliog as preferred language
set_property target_language Verilog [current_project]

# Adding the required files
add_files -norecurse -scan_for_includes [ glob src/rtl/* ]
update_compile_order -fileset sources_1

# creating clock
create_ip -name clk_wiz -vendor xilinx.com -library ip -version 6.0 -module_name clk_wiz_0
set_property -dict [list CONFIG.USE_PHASE_ALIGNMENT {false} CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {25.000} CONFIG.USE_LOCKED {false} CONFIG.SECONDARY_SOURCE {Single_ended_clock_capable_pin} CONFIG.CLKOUT1_DRIVES {BUFG} CONFIG.CLKOUT2_DRIVES {BUFG} CONFIG.CLKOUT3_DRIVES {BUFG} CONFIG.CLKOUT4_DRIVES {BUFG} CONFIG.CLKOUT5_DRIVES {BUFG} CONFIG.CLKOUT6_DRIVES {BUFG} CONFIG.CLKOUT7_DRIVES {BUFG} CONFIG.MMCM_CLKFBOUT_MULT_F {9.125} CONFIG.MMCM_CLKOUT0_DIVIDE_F {36.500} CONFIG.CLKOUT1_JITTER {181.828} CONFIG.CLKOUT1_PHASE_ERROR {104.359}] [get_ips clk_wiz_0]
generate_target {instantiation_template} [get_files build/masterthesis/masterthesis.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci]
update_compile_order -fileset sources_1
generate_target all [get_files  build/masterthesis/masterthesis.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci]
catch { config_ip_cache -export [get_ips -all clk_wiz_0] }
export_ip_user_files -of_objects [get_files build/masterthesis/masterthesis.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci] -no_script -sync -force -quiet
create_ip_run [get_files -of_objects [get_fileset sources_1] build/masterthesis/masterthesis.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci]
launch_runs clk_wiz_0_synth_1 -jobs 8
export_simulation -of_objects [get_files build/masterthesis/masterthesis.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci] -directory build/masterthesis/masterthesis.ip_user_files/sim_scripts -ip_user_files_dir build/masterthesis/masterthesis.ip_user_files -ipstatic_source_dir build/masterthesis/masterthesis.ip_user_files/ipstatic -lib_map_path [list {modelsim=build/masterthesis/masterthesis.cache/compile_simlib/modelsim} {questa=build/masterthesis/masterthesis.cache/compile_simlib/questa} {ies=build/masterthesis/masterthesis.cache/compile_simlib/ies} {xcelium=build/masterthesis/masterthesis.cache/compile_simlib/xcelium} {vcs=build/masterthesis/masterthesis.cache/compile_simlib/vcs} {riviera=build/masterthesis/masterthesis.cache/compile_simlib/riviera}] -use_ip_compiled_libs -force -quiet

#creating bram
create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.4 -module_name blk_mem_gen_0
set_property -dict [list CONFIG.Memory_Type {True_Dual_Port_RAM} CONFIG.Enable_32bit_Address {true} CONFIG.Use_Byte_Write_Enable {true} CONFIG.Byte_Size {8} CONFIG.Assume_Synchronous_Clk {true} CONFIG.Write_Width_A {32} CONFIG.Write_Depth_A {65536} CONFIG.Read_Width_A {32} CONFIG.Enable_A {Always_Enabled} CONFIG.Write_Width_B {32} CONFIG.Read_Width_B {32} CONFIG.Enable_B {Always_Enabled} CONFIG.Register_PortA_Output_of_Memory_Primitives {false} CONFIG.Register_PortB_Output_of_Memory_Primitives {false} CONFIG.Load_Init_File {true} CONFIG.Coe_File {../../../../../../ext/riscv-caeco-master.coe} CONFIG.Fill_Remaining_Memory_Locations {true} CONFIG.Use_RSTA_Pin {false} CONFIG.Use_RSTB_Pin {false} CONFIG.Port_B_Clock {100} CONFIG.Port_B_Write_Rate {50} CONFIG.Port_B_Enable_Rate {100} CONFIG.EN_SAFETY_CKT {false}] [get_ips blk_mem_gen_0]
generate_target {instantiation_template} [get_files build/masterthesis/masterthesis.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0.xci]
update_compile_order -fileset sources_1
generate_target all [get_files  build/masterthesis/masterthesis.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0.xci]
catch { config_ip_cache -export [get_ips -all blk_mem_gen_0] }
export_ip_user_files -of_objects [get_files build/masterthesis/masterthesis.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0.xci] -no_script -sync -force -quiet
create_ip_run [get_files -of_objects [get_fileset sources_1] build/masterthesis/masterthesis.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0.xci]
launch_runs blk_mem_gen_0_synth_1 -jobs 8
export_simulation -of_objects [get_files build/masterthesis/masterthesis.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0.xci] -directory build/masterthesis/masterthesis.ip_user_files/sim_scripts -ip_user_files_dir build/masterthesis/masterthesis.ip_user_files -ipstatic_source_dir build/masterthesis/masterthesis.ip_user_files/ipstatic -lib_map_path [list {modelsim=build/masterthesis/masterthesis.cache/compile_simlib/modelsim} {questa=build/masterthesis/masterthesis.cache/compile_simlib/questa} {ies=build/masterthesis/masterthesis.cache/compile_simlib/ies} {xcelium=build/masterthesis/masterthesis.cache/compile_simlib/xcelium} {vcs=build/masterthesis/masterthesis.cache/compile_simlib/vcs} {riviera=build/masterthesis/masterthesis.cache/compile_simlib/riviera}] -use_ip_compiled_libs -force -quiet

# constrains: 
add_files -fileset constrs_1 -norecurse src/constrains/Nexys-4-DDR-Master.xdc

set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse -scan_for_includes [glob src/simulation/masterthesis_tb.v]
update_compile_order -fileset sim_1

close_project