library ieee;
use ieee.std_logic_1164.all;

entity bin2ssd is
  port (
         d       : in std_logic_vector(4 downto 0);  -- Binary 5-bit input.
         abcdefg : out std_logic_vector(6 downto 0); -- Seven segment output
         )
end bin2ssd;

architecture bin2ssd_select of bin2ssd is
begin
  with d select abcdefg <=
    -- Output 0 - 7
    "1111110" when "00000",  -- 0
    "0110000" when "00001",  -- 1
    "1101101" when "00010",  -- 2
    "1111001" when "00011",  -- 3
    "0110011" when "00100",  -- 4
    "1011011" when "00101",  -- 5
    "1011111" when "00110",  -- 6
    "1110000" when "00111",  -- 7
    -- Output 8 - F
    "1111110" when "00000",  -- 0
    "0110000" when "00001",  -- 1
    "1101101" when "00010",  -- 2
    "1111001" when "00011",  -- 3
    "0110011" when "00100",  -- 4
    "1011011" when "00101",  -- 5
    "1011111" when "00110",  -- 6
    "1110000" when "00111",  -- 7
end rtl;

 