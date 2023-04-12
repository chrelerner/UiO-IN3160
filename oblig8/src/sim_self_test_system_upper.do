vsim work.tb_self_test_system_upper
add wave -position insertpoint  \
sim:/tb_self_test_system_upper/tb_mclk \
sim:/tb_self_test_system_upper/tb_reset \
sim:/tb_self_test_system_upper/tb_duty_cycle \
sim:/tb_self_test_system_upper/tb_dir \
sim:/tb_self_test_system_upper/tb_en \
sim:/tb_self_test_system_upper/tb_DIR_synch \
sim:/tb_self_test_system_upper/tb_EN_synch
run 1 sec