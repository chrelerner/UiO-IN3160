vsim work.tb_compute
add wave -position insertpoint  \
sim:/tb_compute/rst \
sim:/tb_compute/clk \
sim:/tb_compute/a \
sim:/tb_compute/b \
sim:/tb_compute/c \
sim:/tb_compute/d \
sim:/tb_compute/e \
sim:/tb_compute/dvalid \
sim:/tb_compute/result \
sim:/tb_compute/max \
sim:/tb_compute/rvalid
run 1 us