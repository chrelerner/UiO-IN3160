library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package subprog_pck is
  function method1(indata1: std_logic_vector) return std_logic;
  function method2(indata2: unsigned) return std_logic;
  procedure test_values(signal par: in std_logic);
end;

package body subprog_pck is

  function method1(indata1: std_logic_vector) return std_logic is
    variable toggle : std_logic;
  begin
    toggle := '0';
    for i in indata1'range loop
      if indata1(i) = '1' then
        toggle := not toggle;
      end if;        
    end loop;
    return toggle;
  end;

  function method2(indata2: unsigned) return std_logic is
  begin
      return xor(indata2);
  end;

  procedure test_values(signal par: in std_logic) is
  begin
    -- Testing with values of indata2 incrementing by 13 from x0000 and up.

    -- Make sense of comments: toggle_parity xor xor_parity with indata2 = XXXX
    -- Testing values indata1 = 0001
    wait for 60 ns;  -- We want to match the clock.
    assert (par = '0')  -- 1 xor 0 with indata2 = 0000, but rst_n is 0!
     report "Parity not correct at simulation start"
     severity warning;

    wait for 100 ns;
    assert (par = '0')  -- 1 xor 1 with indata2 = 000D
     report "Parity not correct after 160 ns"
     severity warning;

    wait for 100 ns;  -- 1 xor 1 with indata2 = 001A
    assert (par = '0')
     report "Parity not correct after 260 ns"
     severity warning;

    wait for 100 ns;
    assert (par = '1')  -- 1 xor 0 with indata2 = 0027
     report "Parity not correct after 360 ns"
     severity warning;

    wait for 100 ns;
    assert (par = '0')  -- 1 xor 1 with indata2 = 0034
     report "Parity not correct after 460 ns"
     severity warning;

    -- Testing values indata1 = 0003
    wait for 100 ns;  -- 0 xor 0 with indata2 = 0041
    assert (par = '0')
     report "Parity not correct after 560 ns"
     severity warning;

    wait for 100 ns;
    assert (par = '0')  -- 0 xor 0 with indata2 = 004E
     report "Parity not correct after 660 ns"
     severity warning;

    wait for 100 ns;  -- 0 xor 1 with indata2 = 005B
    assert (par = '1')
     report "Parity not correct after 760 ns"
     severity warning;

    wait for 100 ns;
    assert (par = '1')  -- 0 xor 1 with indata2 = 0068
     report "Parity not correct after 860 ns"
     severity warning;

    -- Testing values indata = 0004
    wait for 100 ns;
    assert (par = '0')  -- 1 xor 1 with indata2 = 0075
     report "Parity not correct after 960 ns"
       severity warning;

    wait for 100 ns;
    assert (par = '1')  -- 1 xor 0 with indata2 = 0082
     report "Parity not correct after 1060 ns"
     severity warning;

    wait for 100 ns;  -- 1 xor 1 with indata2 = 008F
    assert (par = '0')
     report "Parity not correct after 1160 ns"
     severity warning;

    wait for 100 ns;
    assert (par = '1')  -- 1 xor 0 with indata2 = 009C
     report "Parity not correct after 1260 ns"
     severity warning;

    -- Testing values indata = 0005
    wait for 100 ns;
    assert (par = '0')  -- 0 xor 0 with indata2 = 00A9
     report "Parity not correct after 1360 ns"
     severity warning;

    wait for 100 ns;
    assert (par = '1')  -- 0 xor 1 with indata2 = 00B6
     report "Parity not correct after 1460 ns"
     severity warning;

    wait for 100 ns;  -- 0 xor 0 with indata2 = 00C3
    assert (par = '0')
     report "Parity not correct after 1560 ns"
     severity warning;

    wait for 100 ns;
    assert (par = '1')  -- 0 xor 1 with indata2 = 00D0
     report "Parity not correct after 1660 ns"
     severity warning;

    -- Testing values indata = 0007
    wait for 100 ns;
    assert (par = '1')  -- 1 xor 0 with indata2 = 00DD
     report "Parity not correct after 1760 ns"
     severity warning;

    wait for 100 ns;
    assert (par = '0')  -- 1 xor 1 with indata2 = 00EA
     report "Parity not correct after 1860 ns"
     severity warning;

    wait for 100 ns;  -- 1 xor 1 with indata2 = 00F7
    assert (par = '0')
     report "Parity not correct after 1960 ns"
     severity warning;
    
    wait for 100 ns;
    report "Testing completed.";   
  end;
  
end subprog_pck;

