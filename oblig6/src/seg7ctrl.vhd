library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity seg7ctrl is
  port (
         mclk     : in std_logic;  -- 100 MHz, positive flank
         reset    : in std_logic;  -- Asynchronous reset, active high
         d0       : in std_logic_vector(4 downto 0);  -- digit 1 input
         d1       : in std_logic_vector(4 downto 0);  -- digit 2 input
         abcdefg  : out std_logic_vector(6 downto 0);  
         c        : out std_logic
         );
end entity seg7ctrl

architecture mixed of segtctrl is
  signal counter : unsigned(19 downto 0) := x"00000"  -- Singal able to count to 1 million.
  signal switch  : std_logic
begin

  counting:
  process (mclk, reset)
    variable increment     : unsigned(19 downto 0);
    variable change_switch : std_logic;
  begin
    change_switch := switch;
    if (reset = '1') then
      count <= x"00000"
      switch <= '0';
    elsif rising_edge(clk) then
      increment := counter + '1';
      switch <= not(change_switch) when (counter = x"00000") else change_switch;
      counter := x"00000" when (counter = x"7A11F") else increment;  -- counter is 499 999.
    end if;
  end process counting;

  displaying:
  process (all)
  begin
    abcdefg <= output1 when (switch = '0') else output2;
  end process displaying;

  c <= switch;

end mixed;
