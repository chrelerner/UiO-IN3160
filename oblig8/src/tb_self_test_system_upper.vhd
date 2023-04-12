-- Self test system testbench for oblig 8 task c.
library ieee;
use ieee.std_logic_1164.all;

entity tb_self_test_system_upper is
end tb_self_test_system_upper;

architecture testbench of tb_self_test_system_upper is

  component self_test_module is
    generic (
              addr_width : natural := 5; -- 21 data instances require 5 bit addresses,
              data_width : natural := 8 -- 8 bit data. 
              );
    port (
           mclk        : in std_logic;
           reset       : in std_logic;
	   duty_cycle : out std_logic_vector(7 downto 0)
           );
  end component;

  component pulse_width_modulator is
    port (
           mclk       : in std_logic;
           reset      : in std_logic;
           duty_cycle : in std_logic_vector(7 downto 0);
           dir        : out std_logic;
           en         : out std_logic
           );
  end component;

  component output_synchronizer is
    port (
           mclk      : in std_logic;
           reset     : in std_logic;
           DIR       : in std_logic;
           EN        : in std_logic;
           DIR_synch : out std_logic;
           EN_synch  : out std_logic
           );
  end component;

  signal tb_mclk       : std_logic := '0';
  signal tb_reset      : std_logic := '0';
  signal tb_duty_cycle : std_logic_vector(7 downto 0);
  signal tb_dir        : std_logic;
  signal tb_en         : std_logic;
  signal tb_DIR_synch  : std_logic;
  signal tb_EN_synch   : std_logic;

begin

  UUT_1 : self_test_module
    port map (
               mclk => tb_mclk,
               reset => tb_reset,
               duty_cycle => tb_duty_cycle
               );

  UUT_2 : pulse_width_modulator
    port map (
               mclk => tb_mclk,
               reset => tb_reset,
               duty_cycle => tb_duty_cycle,
               dir => tb_dir,
               en => tb_en
               );

  UUT_3 : output_synchronizer
    port map (
               mclk => tb_mclk,
               reset => tb_reset,
               DIR => tb_dir,
               EN => tb_en,
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
    -- Allows all the 21 values to be tested with a frequency of 128 values per second.
    wait for 400 ms;
    report "Simulation has finished";
    std.env.stop;
  end process TESTING;

end architecture testbench;

