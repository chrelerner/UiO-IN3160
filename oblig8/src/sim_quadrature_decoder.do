vsim work.tb_quadrature_decoder
add wave -position insertpoint  \
sim:/tb_quadrature_decoder/tb_mclk \
sim:/tb_quadrature_decoder/tb_reset \
sim:/tb_quadrature_decoder/tb_SA \
sim:/tb_quadrature_decoder/tb_SB \
sim:/tb_quadrature_decoder/tb_pos_inc \
sim:/tb_quadrature_decoder/tb_pos_dec \
sim:/tb_quadrature_decoder/tb_err
run 1 sec