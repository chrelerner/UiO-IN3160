library ieee;
use ieee.std_logic_1164.all;

entity output_synchronizer is
  port (
         mclk      : in std_logic;
         reset     : in std_logic;
         DIR       : in std_logic;
         EN        : in std_logic;
         DIR_synch : out std_logic;
         EN_synch  : out std_logic
         );
end output_synchronizer;

architecture rtl of output_synchronizer is
  signal DIR_middle, EN_middle : std_logic;
begin

  BRUTE_FORCE:
  process (mclk, reset) is
  begin
    if (reset = '1') then
      DIR_synch <= '0';
      EN_synch <= '0';
    elsif rising_edge(mclk) then
      DIR_middle <= DIR;
      DIR_synch <= DIR_middle;

      EN_middle <= EN;
      EN_synch <= EN_middle;
    end if;
  end process BRUTE_FORCE;

end architecture rtl;
