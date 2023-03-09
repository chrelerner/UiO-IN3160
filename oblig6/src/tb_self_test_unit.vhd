library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_self_test_unit is
  generic (
              addr_width : natural := 4;   -- 16 rows of inputs.
              data_width : natural := 5    -- 5 bit input
              );
end tb_self_test_unit;

architecture self_testing_testbench of tb_self_test_unit is
  
  component self_test_unit is
    generic (
              addr_width : natural := 4;   -- 16 rows of inputs.
              data_width : natural := 5    -- 5 bit input
              );
    port (
           mclk  : in std_logic;
           reset : in std_logic;
           d0    : out std_logic_vector(4 downto 0);
           d1    : out std_logic_vector(4 downto 0)
           );
  end component self_test_unit;

  signal tb_mclk  : std_logic;
  signal tb_reset : std_logic;
  signal tb_d0    : std_logic_vector(4 downto 0);
  signal tb_d1    : std_logic_vector(4 downto 0);

  type memory_array is array(0 to (2**addr_width)-1) of
    std_logic_vector((data_width*2)-1 downto 0);
  
  constant expected_outputs : memory_array :=
  (
    "1000110010", -- 11 12  -> checkmark checkmark (W)
    "1001110100", -- 13 14  -> E L
    "1010010000", -- 14 10  -> L BLANK
    "1000010000", -- 10 10  -> BLANK BLANK
    "1010110110", -- 15 16  -> d o
    "1011110011", -- 17 13  -> n E
    "1000010000", -- 10 10  -> BLANK BLANK
    "1100010110", -- 18 16  -> y o
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

  UUT: self_test_unit
    port map (
               mclk  => tb_mclk,
               reset => tb_reset,
               d0    => tb_d0,
               d1    => tb_d1
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
    variable current_test : std_logic_vector(data_width-1 downto 0);
    variable expected_output_both   : std_logic_vector((data_width*2)-1 downto 0);
    variable expected_output_0 : std_logic_vector(data_width-1 downto 0);
    variable expected_output_1 : std_logic_vector(data_width-1 downto 0);
  begin
    wait for 50 ns;
    testing_loop: for i in 0 to 15 loop
      report "Testing digits at " & integer'image(i) & " seconds";
      expected_output_both := expected_outputs(i);

     -- Testing digit 1
     expected_output_1 := expected_output_both((data_width*2)-1 downto data_width);
     current_test := expected_output_1;
      assert (tb_d1 = current_test)
        report "Digit-1 " & integer'image(to_integer(unsigned(tb_d1))) & " not matching expected value " & integer'image(to_integer(unsigned(current_test)))
        severity error;

    -- Testing digit 0
     expected_output_0 := expected_output_both(data_width-1 downto 0);
     current_test := expected_output_0;
      assert (tb_d0 = current_test)
        report "Digit-0 " & integer'image(to_integer(unsigned(tb_d0))) & " not matching expected value " & integer'image(to_integer(unsigned(current_test)))
        severity error;
    
      wait for 1 sec;
    end loop;
  end process TEST_digits;


  tb_reset <= '0';

end;
