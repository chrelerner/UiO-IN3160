vsim work.tb_compute_pipelined
add wave -position insertpoint  \
sim:/tb_compute_pipelined/rst \
sim:/tb_compute_pipelined/clk \
sim:/tb_compute_pipelined/a \
sim:/tb_compute_pipelined/b \
sim:/tb_compute_pipelined/c \
sim:/tb_compute_pipelined/d \
sim:/tb_compute_pipelined/e \
sim:/tb_compute_pipelined/dvalid \
sim:/tb_compute_pipelined/result \
sim:/tb_compute_pipelined/max \
sim:/tb_compute_pipelined/rvalid
run 1 us