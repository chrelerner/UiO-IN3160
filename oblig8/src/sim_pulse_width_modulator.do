vsim work.tb_pulse_width_modulator
add wave -position insertpoint  \
sim:/tb_pulse_width_modulator/mclk \
sim:/tb_pulse_width_modulator/reset \
sim:/tb_pulse_width_modulator/dir \
sim:/tb_pulse_width_modulator/en \
sim:/tb_pulse_width_modulator/duty_cycle
run 1 sec