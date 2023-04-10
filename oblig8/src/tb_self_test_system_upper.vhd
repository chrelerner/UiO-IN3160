-- Self test system testbench for oblig 8 task c.
library ieee;
use ieee.std_logic_1164.all;

entity tb_self_test_system_upper is
end tb_self_test_system_upper;

architecture testbench of tb_self_test_system_upper is

  component self_test_system_upper is
    port(
          mclk      : in std_logic;
          reset     : in std_logic;
          DIR_synch : out std_logic;
          EN_synch  : out std_logic
          );
  end component;

  signal tb_mclk : std_logic := '0';
  signal tb_reset : std_logic := '0';
  signal tb_DIR_synch : std_logic;
  signal tb_EN_synch : std_logic;

begin

  UUT: self_test_system_upper
    port map (
               mclk => tb_mclk,
               reset => tb_reset,
               DIR_synch => tb_DIR_synch,
               EN_synch => tb_EN_synch
               );

  CLOCK_stimuli:
  process is
  begin
    tb_mclk <= '0';
    wait for 5 ns;
    tb_mclk <= '1';
    wait for 5 ns;
  end process CLOCK_STIMULI;

  TESTING:
  process is
  begin
    -- Allows all the 21 values to be tested for 3 seconds each.
    wait for 65 sec;
    report "Simulation has finished";
    std.env.stop;
  end process TESTING;

end architecture testbench;

