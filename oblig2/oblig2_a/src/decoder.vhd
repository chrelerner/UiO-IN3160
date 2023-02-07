library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity DECODER is
  port
    (
     -- clk      : in std_logic;
     input      : in std_logic_vector(1 downto 0);
     output      : out std_logic_Vector(3 downto 0)
     );
end DECODER;


architecture RTL of DECODER is
begin
process(input) is
begin
  case input is
    when "00" =>
      output <= "1110";
    when "01" => 
      output <= "1101";
    when "10" =>
      output <= "1011";
    when "11" =>
      output <= "0111";
  end case;
end process;
end RTL;


