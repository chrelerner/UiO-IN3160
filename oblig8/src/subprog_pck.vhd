library ieee;
use ieee.std_logic_1164.all;

package subprog_pck is

  -- Three procedures used by tb_quadrature_decoder for testing.
  procedure test_inc(
    signal tb_pos_inc: in std_logic;
    signal tb_pos_dec: in std_logic;
    signal tb_err    : in std_logic;
    signal tb_reset  : out std_logic;
    signal tb_SA     : out std_logic;
    signal tb_SB     : out std_logic
  );

  procedure test_dec(
    signal tb_pos_inc: in std_logic;
    signal tb_pos_dec: in std_logic;
    signal tb_err    : in std_logic;
    signal tb_reset  : out std_logic;
    signal tb_SA     : out std_logic;
    signal tb_SB     : out std_logic
  );  

  procedure test_err(
    signal tb_pos_inc: in std_logic;
    signal tb_pos_dec: in std_logic;
    signal tb_err    : in std_logic;
    signal tb_reset  : out std_logic;
    signal tb_SA     : out std_logic;
    signal tb_SB     : out std_logic
  );

end;

package body subprog_pck is

  procedure test_inc(
    signal tb_pos_inc: in std_logic;
    signal tb_pos_dec: in std_logic;
    signal tb_err    : in std_logic;
    signal tb_reset  : out std_logic;
    signal tb_SA     : out std_logic;
    signal tb_SB     : out std_logic
  ) is
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
    wait on tb_pos_inc for 5 ns;
    assert ((tb_pos_inc = '1') and (tb_pos_dec = '0') and (tb_err = '0'))
      report "S_0: inc = " & std_logic'image(tb_pos_inc) & " --- dec = " & std_logic'image(tb_pos_dec) & " --- err = " & std_logic'image(tb_err)
      severity warning;
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
    wait on tb_pos_inc for 5 ns;
    assert ((tb_pos_inc = '1') and (tb_pos_dec = '0') and (tb_err = '0'))
      report "S_1: inc = " & std_logic'image(tb_pos_inc) & " --- dec = " & std_logic'image(tb_pos_dec) & " --- err = " & std_logic'image(tb_err)
      severity warning;
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
    wait on tb_pos_inc for 5 ns;
    assert ((tb_pos_inc = '1') and (tb_pos_dec = '0') and (tb_err = '0'))
      report "S_2: inc = " & std_logic'image(tb_pos_inc) & " --- dec = " & std_logic'image(tb_pos_dec) & " --- err = " & std_logic'image(tb_err)
      severity warning;
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
    wait on tb_pos_inc for 5 ns;
    assert ((tb_pos_inc = '1') and (tb_pos_dec = '0') and (tb_err = '0'))
      report "S_3: inc = " & std_logic'image(tb_pos_inc) & " --- dec = " & std_logic'image(tb_pos_dec) & " --- err = " & std_logic'image(tb_err)
      severity warning;
    wait for 10 ns;
    
  end procedure test_inc;


  procedure test_dec(
    signal tb_pos_inc: in std_logic;
    signal tb_pos_dec: in std_logic;
    signal tb_err    : in std_logic;
    signal tb_reset  : out std_logic;
    signal tb_SA     : out std_logic;
    signal tb_SB     : out std_logic
  ) is
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
    wait on tb_pos_dec for 5 ns;
    assert ((tb_pos_inc = '0') and (tb_pos_dec = '1') and (tb_err = '0'))
      report "S_0: inc = " & std_logic'image(tb_pos_inc) & " --- dec = " & std_logic'image(tb_pos_dec) & " --- err = " & std_logic'image(tb_err)
      severity warning;
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
    wait on tb_pos_dec for 5 ns;
    assert ((tb_pos_inc = '0') and (tb_pos_dec = '1') and (tb_err = '0'))
      report "S_1: inc = " & std_logic'image(tb_pos_inc) & " --- dec = " & std_logic'image(tb_pos_dec) & " --- err = " & std_logic'image(tb_err)
      severity warning;
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
    wait on tb_pos_dec for 5 ns;
    assert ((tb_pos_inc = '0') and (tb_pos_dec = '1') and (tb_err = '0'))
      report "S_2: inc = " & std_logic'image(tb_pos_inc) & " --- dec = " & std_logic'image(tb_pos_dec) & " --- err = " & std_logic'image(tb_err)
      severity warning;
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
    wait on tb_pos_dec for 5 ns;
    assert ((tb_pos_inc = '0') and (tb_pos_dec = '1') and (tb_err = '0'))
      report "S_3: inc = " & std_logic'image(tb_pos_inc) & " --- dec = " & std_logic'image(tb_pos_dec) & " --- err = " & std_logic'image(tb_err)
      severity warning;
    wait for 10 ns;
    
  end procedure test_dec;


  procedure test_err(
    signal tb_pos_inc: in std_logic;
    signal tb_pos_dec: in std_logic;
    signal tb_err    : in std_logic;
    signal tb_reset  : out std_logic;
    signal tb_SA     : out std_logic;
    signal tb_SB     : out std_logic
  ) is
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
    wait on tb_err for 5 ns;
    assert ((tb_pos_inc = '0') and (tb_pos_dec = '0') and (tb_err = '1'))
      report "S_0: inc = " & std_logic'image(tb_pos_inc) & " --- dec = " & std_logic'image(tb_pos_dec) & " --- err = " & std_logic'image(tb_err)
      severity warning;
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
    wait on tb_err for 5 ns;
    assert ((tb_pos_inc = '0') and (tb_pos_dec = '0') and (tb_err = '1'))
      report "S_1: inc = " & std_logic'image(tb_pos_inc) & " --- dec = " & std_logic'image(tb_pos_dec) & " --- err = " & std_logic'image(tb_err)
      severity warning;
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
    wait on tb_err for 5 ns;
    assert ((tb_pos_inc = '0') and (tb_pos_dec = '0') and (tb_err = '1'))
      report "S_2: inc = " & std_logic'image(tb_pos_inc) & " --- dec = " & std_logic'image(tb_pos_dec) & " --- err = " & std_logic'image(tb_err)
      severity warning;
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
    wait on tb_err for 5 ns;
    assert ((tb_pos_inc = '0') and (tb_pos_dec = '0') and (tb_err = '1'))
      report "S_3: inc = " & std_logic'image(tb_pos_inc) & " --- dec = " & std_logic'image(tb_pos_dec) & " --- err = " & std_logic'image(tb_err)
      severity warning;
    wait for 10 ns;
    
  end procedure test_err;

end subprog_pck;