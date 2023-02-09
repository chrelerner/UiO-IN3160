library IEEE;
use IEEE.std_logic_1164.all;

entity DECODER is
  port 
    (
      input : in std_logic_vector(1 downto 0);
      output : out std_logic_vector(3 downto 0)
      );
end DECODER;
