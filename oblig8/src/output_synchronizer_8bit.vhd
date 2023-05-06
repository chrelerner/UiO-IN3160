library ieee;
use ieee.std_logic_1164.all;

entity output_synchronizer_8bit is
  port (
         mclk      : in std_logic;
         reset     : in std_logic;
         velocity : in std_logic_vector(7 downto 0);
         velocity_synch : out std_logic_Vector(7 downto 0)
         );
end output_synchronizer_8bit;

architecture rtl of output_synchronizer_8bit is
  signal velocity_middle : std_logic_Vector(7 downto 0);
begin

  BRUTE_FORCE:
  process (mclk, reset) is
  begin
    if (reset = '1') then
      velocity_synch <= (others => '0');
    elsif rising_edge(mclk) then
      velocity_middle <= velocity;
      velocity_synch <= velocity_middle;
    end if;
  end process BRUTE_FORCE;

end architecture rtl;