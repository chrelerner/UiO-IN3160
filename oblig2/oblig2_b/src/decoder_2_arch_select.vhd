library IEEE;
use IEEE.std_logic_1164.all;

architecture DECODER_SELECT of DECODER is
begin
  with input select output <=
    "0111" when "00",  -- (Deliberate change) Changed output for "00" from "1110" to "0111".
    "1101" when "01",
    "1011" when "10",
    "1110" when "11",  -- (Deliberate change) Changed output for "11" from "0111" to "1110".
    "0000" when others;
end DECODER_SELECT;

