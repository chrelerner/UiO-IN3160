library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity selftest_seg7ctrl
  port (
         mclk : in std_logic;
         d0 : out std_logic_vector(4 downto 0);
         d1 : out std_logic_vector(4 downto 0)
         );
end selftest_seg7ctrl;

architecture rtl of selftest_seg7ctrl is
  signal counter : unsigned(26 downto 0) := (others => '0');  -- Can count to 99 999 999.
  signal second_tick : std_logic;
begin

  -- second_tick will be active for 1 clock cycle every second.
  -- In this case, it will be 100 000 000 clock periods (100MHz) between each '1'.
  SECOND_TICK_GENERATOR:
  process (mclk)
    variable increment : unsigned(26 downto 0);
  begin
    if rising_edge(mclk) then
      -- Incrementing the counter, or resetting to 0 when it is 99 999 999 (x5F5E0FF).
      increment := (others => '0') when (counter = "101111101011110000011111111") else counter + '1';
      counter <= increment;
      -- Setting second_tick to 1 for exactly one clock period. The first second_tick will appear on the one second mark.
      second_tick <= '1' when (increment = "101111101011110000011111111") else '0';
    end if;
  end process SECOND_TICK_GENERATOR;

  

end architecture rtl;