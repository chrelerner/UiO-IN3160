vsim work.tb_self_test_unit
add wave -position insertpoint sim:/tb_self_test_unit/tb_mclk
add wave -position insertpoint sim:/tb_self_test_unit/tb_reset
add wave -position insertpoint sim:/tb_self_test_unit/tb_d0
add wave -position insertpoint sim:/tb_self_test_unit/tb_d1
run 18 sec
