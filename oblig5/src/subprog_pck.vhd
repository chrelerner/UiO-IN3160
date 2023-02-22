library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package subprog_pck is
  function method1(indata1: std_logic_vector) return std_logic;
  function method2(indata2: unsigned) return std_logic;
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

end subprog_pck;

