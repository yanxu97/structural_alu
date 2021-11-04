onerror {resume}
quietly set dataset_list [list sim vsim]
if {[catch {datasetcheck $dataset_list}]} {abort}
quietly WaveActivateNextPane {} 0
add wave -noupdate sim:/alu_tb/operand_a
add wave -noupdate sim:/alu_tb/operand_b
add wave -noupdate sim:/alu_tb/control
add wave -noupdate sim:/alu_tb/carry_out
add wave -noupdate sim:/alu_tb/overflow
add wave -noupdate sim:/alu_tb/zero
add wave -noupdate sim:/alu_tb/result
add wave -noupdate sim:/alu_tb/opcode_ascii
add wave -noupdate -radix ascii sim:/alu_tb/curr_opcode
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1097 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 197
configure wave -valuecolwidth 206
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1418 ps}
