library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_self_test_system is
end entity;

architecture self_testing_testbench of tb_self_test_system is
  
  component self_test_system is
    port(
        mclk    : in std_logic;
        reset   : in std_logic;
        abcdefg : out std_logic_vector(6 downto 0);
        c       : out std_logic
        );
  end component self_test_system;

  signal tb_mclk  : std_logic;
  signal tb_reset : std_logic;
  signal tb_abcdefg  : std_logic_vector(6 downto 0);
  signal tb_c     : std_logic;

  type memory_array is array(0 to (2**4)-1 ) of
    std_logic_vector(6 downto 0);
  
  constant expected_outputs_0 : memory_array :=
  (
    "0111100", -- checkmark
    "0001110", -- L
    "0000000", -- BLANK
    "0000000", -- BLANK
    "0011101", -- o
    "1001111", -- E
    "0000000", -- BLANK
    "0011101", -- o
    "0000000", -- BLANK
    "0000000", -- BLANK
    "0000101", -- r
    "0000000", -- BLANK
    "0000000", -- BLANK
    "0011101", -- o
    "0111101", -- d
    "0000000"  -- BLANK
  );

  constant expected_outputs_1 : memory_array :=
  (
    "0011110", -- checkmark
    "1001111", -- E
    "0001110", -- L
    "0000000", -- BLANK
    "0111101", -- d
    "0010101", -- n
    "0000000", -- BLANK
    "0111011", -- y
    "0111110", -- U
    "0000000", -- BLANK
    "1110111", -- A
    "1001111", -- E
    "0000000", -- BLANK
    "1111011", -- g
    "0011101", -- o
    "0000000"  -- BLANK
  );

begin

  UUT: self_test_system
    port map (
               mclk    => tb_mclk,
               reset   => tb_reset,
               abcdefg => tb_abcdefg,
               c       => tb_c
               );

  CLOCK_stimuli:
  process
  begin
    tb_mclk <= '0';
    wait for 5 ns;
    tb_mclk <= '1';
    wait for 5 ns;
  end process CLOCK_stimuli;

  TEST_digits:
  process
    variable current_test : std_logic_vector(6 downto 0);
  begin
    testing_loop: for i in 0 to 15 loop
      report "Testing digits at " & integer'image(i) & " seconds";

      -- Testing digit 1.
      wait until tb_c = '1';
      current_test := expected_outputs_1(i);
      assert (tb_abcdefg = current_test)
        report "Digit-1 " & integer'image(to_integer(unsigned(tb_abcdefg))) & " not matching expected value " & integer'image(to_integer(unsigned(current_test)))
        severity error;

      -- Testing digit 0.
      wait until tb_c = '0';
      current_test := expected_outputs_0(i);
      assert (tb_abcdefg = current_test)
        report "Digit-0 " & integer'image(to_integer(unsigned(tb_abcdefg))) & " not matching expected value " & integer'image(to_integer(unsigned(current_test)))
        severity error;
      
      -- Will wait for one second as long as there are more outpus to inspect.
      if (i /= 17) then
        wait for 1 sec;
      end if;
    end loop;
  end process TEST_digits;


  tb_reset <= '0';

end;




