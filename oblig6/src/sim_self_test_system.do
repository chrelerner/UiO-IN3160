vsim work.tb_self_test_system
add wave -position insertpoint sim:/tb_self_test_system/tb_reset
add wave -position insertpoint sim:/tb_self_test_system/tb_abcdefg
add wave -position insertpoint sim:/tb_self_test_system/tb_c
run 18 sec
