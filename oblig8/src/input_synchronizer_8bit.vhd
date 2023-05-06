library ieee;
use ieee.std_logic_1164.all;

entity input_synchronizer_8bit is
  port (
         mclk      : in std_logic;
         reset     : in std_logic;
         duty_cycle : in std_logic_vector(7 downto 0);
         duty_cycle_synch : out std_logic_Vector(7 downto 0)
         );
end input_synchronizer_8bit;

architecture rtl of input_synchronizer_8bit is
  signal duty_cycle_middle : std_logic_Vector(7 downto 0);
begin

  BRUTE_FORCE:
  process (mclk, reset) is
  begin
    if (reset = '1') then
      duty_cycle_synch <= (others => '0');
    elsif rising_edge(mclk) then
      duty_cycle_middle <= duty_cycle;
      duty_cycle_synch <= duty_cycle_middle;
    end if;
  end process BRUTE_FORCE;

end architecture rtl;
