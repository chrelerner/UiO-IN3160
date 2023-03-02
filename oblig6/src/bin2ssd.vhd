library ieee;
use ieee.std_logic_1164.all;

entity bin2ssd is
  port (
         d0       : in std_logic_vector(4 downto 0);  -- Binary 5-bit input.
         d1       : in std_logic_vector(4 downto 0);  -- Binary 5-bit input.
         abcdefg0 : out std_logic_vector(6 downto 0);  -- Seven segment output
         abcdefg1 : out std_logic_vector(6 downto 0)   -- Seven segment output
         );
end bin2ssd;

architecture bin2ssd_select of bin2ssd is
begin
  with d0 select abcdefg0 <=
    -- Input x0 - x7
    "1111110" when "00000",  -- 0
    "0110000" when "00001",  -- 1
    "1101101" when "00010",  -- 2
    "1111001" when "00011",  -- 3
    "0110011" when "00100",  -- 4
    "1011011" when "00101",  -- 5
    "1011111" when "00110",  -- 6
    "1110000" when "00111",  -- 7
    -- Input x8 - xF
    "1111111" when "01000",  -- 8
    "1110011" when "01001",  -- 9
    "1110111" when "01010",  -- A
    "0011111" when "01011",  -- B
    "1001110" when "01100",  -- C
    "0111101" when "01101",  -- D
    "1001111" when "01110",  -- E
    "1000111" when "01111",  -- F
    -- Input x10 - x17
    "0000000" when "10000",  -- <blank>
    "0011110" when "10001",  -- checkmark J
    "0111100" when "10010",  -- checkmark L
    "1001111" when "10011",  -- E
    "0001110" when "10100",  -- L
    "0111101" when "10101",  -- d
    "0011101" when "10110",  -- o
    "0010101" when "10111",  -- n
    -- Input x18 - x1F
    "0111011" when "11000",  -- y
    "0111110" when "11001",  -- U
    "1110111" when "11010",  -- A
    "0000101" when "11011",  -- r
    "1111011" when "11100",  -- g
    "0011100" when "11101",  -- v
    "0001101" when "11110",  -- c
    "0001111" when "11111",  -- t
    "XXXXXXX" when others;

  with d1 select abcdefg1 <=
    -- Input x0 - x7
    "1111110" when "00000",  -- 0
    "0110000" when "00001",  -- 1
    "1101101" when "00010",  -- 2
    "1111001" when "00011",  -- 3
    "0110011" when "00100",  -- 4
    "1011011" when "00101",  -- 5
    "1011111" when "00110",  -- 6
    "1110000" when "00111",  -- 7
    -- Input x8 - xF
    "1111111" when "01000",  -- 8
    "1110011" when "01001",  -- 9
    "1110111" when "01010",  -- A
    "0011111" when "01011",  -- B
    "1001110" when "01100",  -- C
    "0111101" when "01101",  -- D
    "1001111" when "01110",  -- E
    "1000111" when "01111",  -- F
    -- Input x10 - x17
    "0000000" when "10000",  -- <blank>
    "0011110" when "10001",  -- checkmark J
    "0111100" when "10010",  -- checkmark L
    "1001111" when "10011",  -- E
    "0001110" when "10100",  -- L
    "0111101" when "10101",  -- d
    "0011101" when "10110",  -- o
    "0010101" when "10111",  -- n
    -- Input x18 - x1F
    "0111011" when "11000",  -- y
    "0111110" when "11001",  -- U
    "1110111" when "11010",  -- A
    "0000101" when "11011",  -- r
    "1111011" when "11100",  -- g
    "0011100" when "11101",  -- v
    "0001101" when "11110",  -- c
    "0001111" when "11111",  -- t
    "XXXXXXX" when others;
end rtl;

 