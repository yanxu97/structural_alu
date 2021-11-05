
# XM-Sim Command File
# TOOL:	xmsim(64)	18.09-s011
#
#
# You can restore this configuration with:
#
#      xrun -64bit -access r ./lib/and_gate.v ./lib/and_gate_32.v ./lib/and_gate_n.v ./lib/dec_n.v ./lib/mux.v ./lib/mux_32.v ./lib/mux_n.v ./lib/nand_gate.v ./lib/nand_gate_32.v ./lib/nand_gate_n.v ./lib/nor_gate.v ./lib/nor_gate_32.v ./lib/nor_gate_n.v ./lib/not_gate.v ./lib/not_gate_32.v ./lib/not_gate_n.v ./lib/or_gate.v ./lib/or_gate_32.v ./lib/or_gate_n.v ./lib/xnor_gate.v ./lib/xnor_gate_32.v ./lib/xnor_gate_n.v ./lib/xor_gate.v ./lib/xor_gate_32.v ./lib/xor_gate_n.v ./add_32.v ./alu.v ./alu_tb.v ./carry_sel.v ./check_zero.v ./comparator.v ./fulladder.v ./fulladder_4.v ./mux16_to_1.v ./mux_32_wrapper.v ./mux_n_wrapper.v ./sll.v ./slr.v ./slt.v ./sltu.v -input /home/yxz7776/eecs361lib_alu_Verilog/restore.tcl
#

set tcl_prompt1 {puts -nonewline "xcelium> "}
set tcl_prompt2 {puts -nonewline "> "}
set vlog_format %h
set vhdl_format %v
set real_precision 6
set display_unit auto
set time_unit module
set heap_garbage_size -200
set heap_garbage_time 0
set assert_report_level note
set assert_stop_level error
set autoscope yes
set assert_1164_warnings yes
set pack_assert_off {}
set severity_pack_assert_off {note warning}
set assert_output_stop_level failed
set tcl_debug_level 0
set relax_path_name 1
set vhdl_vcdmap XX01ZX01X
set intovf_severity_level ERROR
set probe_screen_format 0
set rangecnst_severity_level ERROR
set textio_severity_level ERROR
set vital_timing_checks_on 1
set vlog_code_show_force 0
set assert_count_attempts 1
set tcl_all64 false
set tcl_runerror_exit false
set assert_report_incompletes 0
set show_force 1
set force_reset_by_reinvoke 0
set tcl_relaxed_literal 0
set probe_exclude_patterns {}
set probe_packed_limit 4k
set probe_unpacked_limit 16k
set assert_internal_msg no
set svseed 1
set assert_reporting_mode 0
alias . run
alias quit exit
database -open -shm -into waves.shm waves -default
probe -create -database waves alu_tb.and_unit.x alu_tb.and_unit.z alu_tb.and_unit.y
probe -create -database waves alu_tb.xor_unit.x alu_tb.xor_unit.y alu_tb.xor_unit.z
probe -create -database waves alu_tb.or_unit.x alu_tb.or_unit.y alu_tb.or_unit.z
probe -create -database waves alu_tb.dut.operand_a alu_tb.dut.operand_b alu_tb.dut.control alu_tb.curr_opcode alu_tb.dut.carryout alu_tb.dut.overflow alu_tb.dut.zero alu_tb.dut.result

simvision -input restore.tcl.svcf
