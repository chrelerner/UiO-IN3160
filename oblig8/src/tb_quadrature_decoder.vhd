library ieee;
use ieee.std_logic_1164.all;

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

  procedure test_inc(
    signal tb_pos_inc: in std_logic;
    signal tb_pos_dec: in std_logic;
    signal tb_err    : in std_logic;
    signal tb_reset  : out std_logic;
    signal tb_SA     : out std_logic;
    signal tb_SB     : out std_logic) is
  begin

    -- From S_0
    tb_SA <= '0';
    tb_SB <= '0';
    tb_reset <= '1';
    wait for 10 ns;
    tb_reset <= '0';
    wait for 20 ns;
    tb_SA <= '0';
    tb_SB <= '1';
    wait on tb_pos_inc for 10 ns;
    report "S_0: inc = " & std_logic'image(tb_pos_inc) & " --- dec = " & std_logic'image(tb_pos_dec) & " --- err = " & std_logic'image(tb_err);
    wait for 10 ns;

    -- From S_1
    tb_SA <= '0';
    tb_SB <= '1';
    tb_reset <= '1';
    wait for 10 ns;
    tb_reset <= '0';
    wait for 20 ns;
    tb_SA <= '1';
    tb_SB <= '1';
    wait on tb_pos_inc for 10 ns;
    report "S_1: inc = " & std_logic'image(tb_pos_inc) & " --- dec = " & std_logic'image(tb_pos_dec) & " --- err = " & std_logic'image(tb_err);
    wait for 10 ns;

    -- From S_2
    tb_SA <= '1';
    tb_SB <= '1';
    tb_reset <= '1';
    wait for 10 ns;
    tb_reset <= '0';
    wait for 20 ns;
    tb_SA <= '1';
    tb_SB <= '0';
    wait on tb_pos_inc for 10 ns;
    report "S_2: inc = " & std_logic'image(tb_pos_inc) & " --- dec = " & std_logic'image(tb_pos_dec) & " --- err = " & std_logic'image(tb_err);
    wait for 10 ns;

    -- From S_3
    tb_SA <= '1';
    tb_SB <= '0';
    tb_reset <= '1';
    wait for 10 ns;
    tb_reset <= '0';
    wait for 20 ns;
    tb_SA <= '0';
    tb_SB <= '0';
    wait on tb_pos_inc for 10 ns;
    report "S_3: inc = " & std_logic'image(tb_pos_inc) & " --- dec = " & std_logic'image(tb_pos_dec) & " --- err = " & std_logic'image(tb_err);
    wait for 10 ns;
    
  end procedure test_inc;

  procedure test_dec(
    signal tb_pos_inc: in std_logic;
    signal tb_pos_dec: in std_logic;
    signal tb_err    : in std_logic;
    signal tb_reset  : out std_logic;
    signal tb_SA     : out std_logic;
    signal tb_SB     : out std_logic) is
  begin

    -- From S_0
    tb_SA <= '0';
    tb_SB <= '0';
    tb_reset <= '1';
    wait for 10 ns;
    tb_reset <= '0';
    wait for 20 ns;
    tb_SA <= '1';
    tb_SB <= '0';
    wait on tb_pos_dec for 10 ns;
    report "S_0: inc = " & std_logic'image(tb_pos_inc) & " --- dec = " & std_logic'image(tb_pos_dec) & " --- err = " & std_logic'image(tb_err);
    wait for 10 ns;

    -- From S_1
    tb_SA <= '0';
    tb_SB <= '1';
    tb_reset <= '1';
    wait for 10 ns;
    tb_reset <= '0';
    wait for 20 ns;
    tb_SA <= '0';
    tb_SB <= '0';
    wait on tb_pos_dec for 10 ns;
    report "S_1: inc = " & std_logic'image(tb_pos_inc) & " --- dec = " & std_logic'image(tb_pos_dec) & " --- err = " & std_logic'image(tb_err);
    wait for 10 ns;

    -- From S_2
    tb_SA <= '1';
    tb_SB <= '1';
    tb_reset <= '1';
    wait for 10 ns;
    tb_reset <= '0';
    wait for 20 ns;
    tb_SA <= '0';
    tb_SB <= '1';
    wait on tb_pos_dec for 10 ns;
    report "S_2: inc = " & std_logic'image(tb_pos_inc) & " --- dec = " & std_logic'image(tb_pos_dec) & " --- err = " & std_logic'image(tb_err);
    wait for 10 ns;

    -- From S_3
    tb_SA <= '1';
    tb_SB <= '0';
    tb_reset <= '1';
    wait for 10 ns;
    tb_reset <= '0';
    wait for 20 ns;
    tb_SA <= '1';
    tb_SB <= '1';
    wait on tb_pos_dec for 10 ns;
    report "S_3: inc = " & std_logic'image(tb_pos_inc) & " --- dec = " & std_logic'image(tb_pos_dec) & " --- err = " & std_logic'image(tb_err);
    wait for 10 ns;
    
  end procedure test_dec;

  procedure test_err(
    signal tb_pos_inc: in std_logic;
    signal tb_pos_dec: in std_logic;
    signal tb_err    : in std_logic;
    signal tb_reset  : out std_logic;
    signal tb_SA     : out std_logic;
    signal tb_SB     : out std_logic) is
  begin

    -- From S_0
    tb_SA <= '0';
    tb_SB <= '0';
    tb_reset <= '1';
    wait for 10 ns;
    tb_reset <= '0';
    wait for 20 ns;
    tb_SA <= '1';
    tb_SB <= '1';
    wait on tb_err for 10 ns;
    report "S_0: inc = " & std_logic'image(tb_pos_inc) & " --- dec = " & std_logic'image(tb_pos_dec) & " --- err = " & std_logic'image(tb_err);
    wait for 10 ns;

    -- From S_1
    tb_SA <= '0';
    tb_SB <= '1';
    tb_reset <= '1';
    wait for 10 ns;
    tb_reset <= '0';
    wait for 20 ns;
    tb_SA <= '1';
    tb_SB <= '0';
    wait on tb_err for 10 ns;
    report "S_1: inc = " & std_logic'image(tb_pos_inc) & " --- dec = " & std_logic'image(tb_pos_dec) & " --- err = " & std_logic'image(tb_err);
    wait for 10 ns;

    -- From S_2
    tb_SA <= '1';
    tb_SB <= '1';
    tb_reset <= '1';
    wait for 10 ns;
    tb_reset <= '0';
    wait for 20 ns;
    tb_SA <= '0';
    tb_SB <= '0';
    wait on tb_err for 10 ns;
    report "S_2: inc = " & std_logic'image(tb_pos_inc) & " --- dec = " & std_logic'image(tb_pos_dec) & " --- err = " & std_logic'image(tb_err);
    wait for 10 ns;

    -- From S_3
    tb_SA <= '1';
    tb_SB <= '0';
    tb_reset <= '1';
    wait for 10 ns;
    tb_reset <= '0';
    wait for 20 ns;
    tb_SA <= '0';
    tb_SB <= '1';
    wait on tb_err for 10 ns;
    report "S_3: inc = " & std_logic'image(tb_pos_inc) & " --- dec = " & std_logic'image(tb_pos_dec) & " --- err = " & std_logic'image(tb_err);
    wait for 10 ns;
    
  end procedure test_err;


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

  INPUT_stimuli:
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

  end process INPUT_stimuli;

end architecture testbench;



