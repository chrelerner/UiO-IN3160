library IEEE;
use IEEE.std_logic_1164.all;

entity TEST_DECODER is
-- Empty entity of the testbench.
end TEST DECODER;

-- Behavioral architecture of the testbench.
architecture TESTBENCH of TEST_DECODER is

  component DECODER
    port 
      (
        inp     : in std_logic_vector(1 downto 0);
        out     : out std_logic_vector(3 downto 0)
        );
  end component;

  signal tb_inp;
  signal tb_out;

begin

  UUT : DECODER
    port map 
    (
      inp => tb_inp,
      out => tb_out
      );

  -- Running the simulation testing all 4 alternatives.
  process
  begin
    -- Input is "00"
    wait
    tb_inp <= "00"
    assert (tb_out = "1110") report "Output from input = 00 is not correct!"
    
    -- Input is "01"
    wait
    tb_inp <= "01"
    assert (tb_out = "1101") report "Output from input = 01 is not correct!"

    -- Input is "10"
    wait
    tb_inp <= "10"
    assert (tb_out = "1011") report "Output from input = 10 is not correct!"
    
    -- Input is "11"
    wait
    tb_inp <= "11"
    assert (tb_out = "0111") report "Output from input = 11 is not correct!"
    
    wait
  end process;
end TESTBENCH;



 