vsim work.tb_bin2ssd
add wave -position insertpoint sim:/tb_bin2ssd/tb_d
add wave -position insertpoint sim:/tb_bin2ssd/tb_c
add wave -position insertpoint sim:/tb_bin2ssd/tb_disp0
add wave -position insertpoint sim:/tb_bin2ssd/tb_disp1
add wave -position insertpoint sim:/tb_bin2ssd/tb_abcdefg
run 350 ns
