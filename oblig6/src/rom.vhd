-- THIS CODE IS INSPIRED FROM LECTURE SLIDES!

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
  generic (
              data_width : natural := 5;  -- 5 bit input
              addr_width : natural := 4   -- 16 rows of inputs.
              );
  port (
         address : in std_logic_vector(addr_width-1 downto 0);
         data : out std_logic_vector((data_width*2)-1 downto 0)
         );
end rom;

architecture rtl of rom is
  type memory_array is array(0 to (2**addr_width)-1) of
    std_logic_vector((data_width*2)-1 downto 0);

  -- Got this idea of making ROM from steemit.com
  constant ROM_DATA : memory_array := -- Well done you are good
  (
    "1000110010", -- 11 12  -> checkmark checkmark (W)
    "1001110100", -- 13 14  -> E L
    "1010010000", -- 14 10  -> L BLANK
    "1000010000", -- 10 10  -> BLANK BLANK
    "1010110110", -- 15 16  -> d o
    "1011110011", -- 17 13  -> n E
    "1000010000", -- 10 10  -> BLANK BLANK
    "1011110011", -- 18 16  -> y o
    "1100110000", -- 19 10  -> U BLANK
    "1000010000", -- 10 10  -> BLANK BLANK
    "1101011011", -- 1A 1B  -> A r
    "1001110000", -- 13 10  -> E BLANK
    "1000010000", -- 10 10  -> BLANK BLANK
    "1110010110", -- 1C 16  -> g o
    "1011010101", -- 16 15  -> o d
    "1000010000"  -- 10 10  -> BLANK BLANK
  );

begin
  data <= ROM_DATA(to_integer(unsigned(address)));
end architecture rtl;