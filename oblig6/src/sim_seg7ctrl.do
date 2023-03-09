vsim work.tb_seg7ctrl
add wave -position insertpoint sim:/tb_seg7ctrl/tb_mclk
add wave -position insertpoint sim:/tb_seg7ctrl/tb_reset
add wave -position insertpoint sim:/tb_seg7ctrl/tb_d0
add wave -position insertpoint sim:/tb_seg7ctrl/tb_d1
add wave -position insertpoint sim:/tb_seg7ctrl/tb_disp0
add wave -position insertpoint sim:/tb_seg7ctrl/tb_disp1
add wave -position insertpoint sim:/tb_seg7ctrl/tb_abcdefg
add wave -position insertpoint sim:/tb_seg7ctrl/tb_c
run 75 us
