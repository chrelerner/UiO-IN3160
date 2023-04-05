library ieee;
use ieee.std_logic_1164.all;

entity input_synchronizer is
  generic (
            bit_amount : natural := 10;
            );
  port (
         mclk     : in std_logic;
         reset    : in std_logic;
         SA    : in std_logic_vector(bit_amount-1 downto 0);
         SB    : in std_logic_vector(bit_amount-1 downto 0);
         SA_synch : out std_logic_vector(bit_amount-1 downto 0);
         SB_synch : out std_logic_vector(bit_amount-1 downto 0)
         );
end input_synchronizer;

architecture rtl of input_synchronizer is
  signal SA_middle, SB_middle : std_logic_vector(bit_amount-1 downto 0);
begin

  BRUTE_FORCE:
  process (mclk, reset) is
  begin
    if (reset = '1') then
      SA_synch <= (others => '0');
      SB_synch <= (others => '0');
    elsif rising_edge(mclk) then
      SA_middle <= SA;
      SA_synch <= SA_middle;

      SB_middle <= SB;
      SB_synch <= SB_middle;
    end if;
  end process BRUTE_FORCE;

end architecture rtl;


