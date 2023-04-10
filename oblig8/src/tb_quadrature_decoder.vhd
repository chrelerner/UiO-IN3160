library ieee;
use ieee.std_logic_1164.all;

library work;
use work.subprog_pck.all;

entity tb_quadrature_decoder is
end tb_quadrature_decoder;

architecture testbench of tb_quadrature_decoder is

  component quadrature_decoder is
    port (
         mclk    : in std_logic;
         reset   : in std_logic;
         SA      : in std_logic;
         SB      : in std_logic;
         pos_inc : out std_logic;
         pos_dec : out std_logic;
         err     : out std_logic
         );
  end component;

  signal tb_mclk     : std_logic := '0';
  signal tb_reset    : std_logic := '0';
  signal tb_SA       : std_logic;
  signal tb_SB       : std_logic;
  signal tb_pos_inc  : std_logic;
  signal tb_pos_dec  : std_logic;
  signal tb_err      : std_logic;

begin

  UUT : quadrature_decoder
    port map (
               mclk    => tb_mclk,
               reset   => tb_reset,
               SA      => tb_SA,
               SB      => tb_SB,
               pos_inc => tb_pos_inc,
               pos_dec => tb_pos_dec,
               err     => tb_err
               );

  CLOCK_stimuli:
  process is
  begin
    tb_mclk <= '0';
    wait for 5 ns;
    tb_mclk <= '1';
    wait for 5 ns;
  end process CLOCK_STIMULI;

  TESTING:
  process is
  begin
    
    -- Testing incrementing
    report "Running test_inc";
    test_inc(tb_pos_inc, tb_pos_dec, tb_err, tb_reset, tb_SA, tb_SB);

    -- Testing decrementing
    report "Running test_dec";
    test_dec(tb_pos_inc, tb_pos_dec, tb_err, tb_reset, tb_SA, tb_SB);

    -- Testing error
    report "Running test_err";
    test_err(tb_pos_inc, tb_pos_dec, tb_err, tb_reset, tb_SA, tb_SB);

    report "All tests are done!";
    std.env.stop;    

  end process TESTING;

end architecture testbench;



