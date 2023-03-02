library IEEE;
use IEEE.std_logic_1164.all;

architecture beh of seg7model is
  signal char : std_logic_vector(4 downto 0);
begin
  display :
  process(c,char)
  begin
    --Default verdier
    --Benytter man default verdier kan man sløyfe 
    --else i if setninger uten å få laget en latch
    --En annen fordel er at koden kan bli enklere.
    --Benytter 'Z'(høy impendans) for å vise at et display er slukket
    disp0 <= "ZZZZZ";
    disp1 <= "ZZZZZ";
    if c then
      disp1 <= char;
    else -- c_n = '0' then
      disp0 <= char;
    end if;
  end process display;

--De to metodene nedenfor er helt ekvivalente beskrivelser med negativ logikk (derav _n)
--Legg merke til alternativ koding nederst dersom man bare vil vise tallverdier
--Kan være fint å benytte dersom man lager digitalklokke
  
--  ENCODE:
--  process (abcdefg_n)
--  begin    
--    case abcdefg_n(6 downto 0) is
--      when "0000001" => char <= X"30"; --0
--      when "1001111" => char <= X"31"; --1
--      when "0010010" => char <= X"32"; --2
--      when "0000110" => char <= X"33"; --3
--      when "1001100" => char <= X"34"; --4
--      when "0100100" => char <= X"35"; --5
--      when "0100000" => char <= X"36"; --6
--      when "0001111" => char <= X"37"; --7
--      when "0000000" => char <= X"38"; --8
--      when "0001100" => char <= X"39"; --9
--      when "0001000" => char <= X"41"; --A
--      when "1100000" => char <= X"42"; --B
--      when "0110001" => char <= X"43"; --C
--      when "1000010" => char <= X"44"; --D
--      when "0110000" => char <= X"45"; --E
--      when "0111000" => char <= X"46"; --F
--      when "0000100" => char <= X"67"; --G
--      when "1101000" => char <= X"68"; --H
--      when "0000111" => char <= X"49"; --I
--      when "1000011" => char <= X"4A"; --J
--      when "1110001" => char <= X"4C"; --L
--      when "1101010" => char <= X"6E"; --n
--      when "1100010" => char <= X"6F"; --o
--      when "0011000" => char <= X"50"; --P
--      when "1111010" => char <= X"72"; --r
--      when "1110000" => char <= X"74"; --t
--      when "1100011" => char <= X"75"; --u
--      when "1000100" => char <= X"59"; --Y
--      when others    => char <= "XXXXXXXX";
--    end case;
--  end process encode;
  
--  with abcdefg_n(6 downto 0) select
--      char <= X"30" when "0000001", --0
--              X"31" when "1001111", --1
--              X"32" when "0010010", --2
--              X"33" when "0000110", --3
--              X"34" when "1001100", --4
--              X"35" when "0100100", --5
--              X"36" when "0100000", --6
--              X"37" when "0001111", --7
--              X"38" when "0000000", --8
--              X"39" when "0001100", --9
--              X"41" when "0001000", --A
--              X"42" when "1100000", --B
--              X"43" when "0110001", --C
--              X"44" when "1000010", --D
--              X"45" when "0110000", --E
--              X"46" when "0111000", --F
--              X"67" when "0000100", --G
--              X"68" when "1101000", --H
--              X"49" when "0000111", --I
--              X"4A" when "1000011", --J
--              X"4C" when "1110001", --L
--              X"6E" when "1101010", --n
--              X"6F" when "1100010", --o
--              X"50" when "0011000", --P
--              X"72" when "1111010", --r
--              X"74" when "1110000", --t
--              X"75" when "1100011", --u
--              X"59" when "1000100", --Y
--              "XXXXXXXX" when others;

-- Eventuelt kan det være hensiktsmessig å vise bare hexadesimale tall 0-F
 
   with abcdefg(6 downto 0) select char <= 
     5X"00" when "1111110", --"0000001", --0
     5X"01" when "0110000", --"1001111", --1
     5X"02" when "1101101", --"0010010", --2
     5X"03" when "1111001", --"0000110", --3
     5X"04" when "0110011", --"1001100", --4
     5X"05" when "1011011", --"0100100", --5
     5X"06" when "1011111", --"0100000", --6
     5X"07" when "1110000", --"0001111", --7
     5X"08" when "1111111", --"0000000", --8
     5X"09" when "1110011", --"0001100", --9
     5X"0A" when "1110111", --"0001000", --A
     5X"0B" when "0011111", --"1100000", --B
     5X"0C" when "1001110", --"0110001", --C
     5X"0D" when "0111101", --"1000010", --D
     5X"0E" when "1001111", --"0110000", --E
     5X"0F" when "1000111", --"0111000", --F
     5X"10" when "0000000", -- blank
     5X"11" when "0011110", -- \|
     5X"12" when "0111100", -- |/
     --5X"13" when "1001111", -- E
     5X"14" when "0001110", -- L
     --5X"15" when "0111101", -- d
     5X"16" when "0011101", -- o
     5X"17" when "0010101", -- n
     5X"18" when "0111011", -- y
     5X"19" when "0111110", -- U
     --5X"1A" when "1110111", -- A
     5X"1B" when "0000101", -- r
     5X"1C" when "1111011", -- g
     5X"1D" when "0011100", -- u/v
     5X"1E" when "0001101", -- c
     5X"1F" when "0001111", -- t
     "XXXXX" when others;

end architecture beh;