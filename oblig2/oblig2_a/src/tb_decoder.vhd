library IEEE;
use IEEE.std_logic_1164.all;

entity TEST_DECODER is
-- Empty entity of the testbench.
end TEST_DECODER;

-- Behavioral architecture of the testbench.
architecture TESTBENCH of TEST_DECODER is

  component DECODER
    port 
      (
        input   : in std_logic_vector(1 downto 0);
        output  : out std_logic_vector(3 downto 0)
        );
  end component;

  signal tb_input  : std_logic_vector(1 downto 0);
  signal tb_output : std_logic_Vector(3 downto 0);

begin

  UUT : DECODER
    port map 
    (
      input => tb_input,
      output => tb_output
      );

  -- Running the simulation testing all 4 alternatives.
  process
  begin
    -- Input is "00"
    wait for 100 ns;
    tb_input <= "00";
    wait for 100 ns;
    assert (tb_output = "1110") report "Output from input = 00 is not correct!";
    
    -- Input is "01"
    wait for 100 ns;
    tb_input <= "01";
    wait for 100 ns;
    assert (tb_output = "1101") report "Output from input = 01 is not correct!";

    -- Input is "10"
    wait for 100 ns;
    tb_input <= "10";
    wait for 100 ns;
    assert (tb_output = "1011") report "Output from input = 10 is not correct!";
    
    -- Input is "11"
    wait for 100 ns;
    tb_input <= "11";
    wait for 100 ns;
    assert (tb_output = "0111") report "Output from input = 11 is not correct!";
    
    wait for 100 ns;
  end process;
end TESTBENCH;



 