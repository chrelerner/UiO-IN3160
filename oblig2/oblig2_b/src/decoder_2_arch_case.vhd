library IEEE;
use IEEE.std_logic_1164.all;

architecture DECODER_CASE of DECODER is
begin
  process(all) is
    begin
      case input is
        when "00" =>
          output <= "0111";  -- (Deliberate change) Changed output for "00" from "1110" to "0111".
        when "01" =>
          output <= "1101";
        when "10" =>
          output <= "1011";
        when "11" =>
          output <= "1110";  -- (Deliberate change) Changed output for "11" from "0111" to "1110".
        when others =>
          output <= "0000";
      end case;
  end process;
end DECODER_CASE;

